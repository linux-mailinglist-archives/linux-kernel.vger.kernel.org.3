Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C94745FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhLNPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhLNPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B28C061756
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA609B81A2C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC57C34607;
        Tue, 14 Dec 2021 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494370;
        bh=0e/D+kSA0kZGBFpT3CwEA0RhjeebpJwRXLyyKaYRN1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyvorncCICzm1s4NXJqzHV9f2MreN1VB1GOtQa0cwK9kyreESMnbfPdiiBU5xzKUY
         p0fuKCrUoj1lTQNi/m/VJXeeOMoJ30Vbh6XJf4OX+5WhL5/d+wAmTTbSLuFaxbwZOf
         syUjv9DiszvUOPdv+/pbT7ui2hQ/UZDDo+nvYWo1h4LHckTChk3Xw6e2ZlgrNLCisD
         eVa16WLJ7dyhb44MtYBCuB32el8s/6bmDtKUUibjhift0t9WnHDWyo9zn3fccSabOt
         zn2ntqHfS48caOmzgxqSbkAS+wndBYwZHClQjowI+PV5ErWO2tlaxeRAr4bjRq2Qq3
         iE3uTF2jS6smg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 11/11] habanalabs: change wait_for_interrupt implementation
Date:   Tue, 14 Dec 2021 17:05:51 +0200
Message-Id: <20211214150551.1568192-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Currently the cq counters are allocated in userspace memory,
and mapped by the driver to the device address space.

A new requirement that is part of new future API related to this one,
requires that cq counters will be allocated in kernel memory.

We leverage the existing cb_create API with KERNEL_MAPPED flag set to
allocate this memory.

That way we gain two things:
1. The memory cannot be freed while in use since it's protected
by refcount in driver.

2. No need to wake up the user thread upon each interrupt from CQ,
because the kernel has direct access to the counter. Therefore,
it can make comparison with the target value in the interrupt
handler and wake up the user thread only if the counter reaches the
target value. This is instead of waking the thread up to copy counter
value from user then go sleep again if target value wasn't reached.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  31 ++++-
 .../habanalabs/common/command_submission.c    | 111 +++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |   5 +
 drivers/misc/habanalabs/common/irq.c          |   8 +-
 include/uapi/misc/habanalabs.h                |  61 +++++++---
 5 files changed, 189 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index c591f0487272..d4eb9fb9ea12 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -380,8 +380,9 @@ int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle)
 }
 
 static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			u64 cb_handle, u32 *usage_cnt)
+			u64 cb_handle, u32 flags, u32 *usage_cnt, u64 *device_va)
 {
+	struct hl_vm_va_block *va_block;
 	struct hl_cb *cb;
 	u32 handle;
 	int rc = 0;
@@ -402,7 +403,18 @@ static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 		goto out;
 	}
 
-	*usage_cnt = atomic_read(&cb->cs_cnt);
+	if (flags & HL_CB_FLAGS_GET_DEVICE_VA) {
+		va_block = list_first_entry(&cb->va_block_list, struct hl_vm_va_block, node);
+		if (va_block) {
+			*device_va = va_block->start;
+		} else {
+			dev_err(hdev->dev, "CB is not mapped to the device's MMU\n");
+			rc = -EINVAL;
+			goto out;
+		}
+	} else {
+		*usage_cnt = atomic_read(&cb->cs_cnt);
+	}
 
 out:
 	spin_unlock(&mgr->cb_lock);
@@ -414,7 +426,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 	union hl_cb_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
 	enum hl_device_status status;
-	u64 handle = 0;
+	u64 handle = 0, device_va;
 	u32 usage_cnt = 0;
 	int rc;
 
@@ -450,9 +462,16 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	case HL_CB_OP_INFO:
 		rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
-				&usage_cnt);
-		memset(args, 0, sizeof(*args));
-		args->out.usage_cnt = usage_cnt;
+				args->in.flags,
+				&usage_cnt,
+				&device_va);
+
+		memset(&args->out, 0, sizeof(args->out));
+
+		if (args->in.flags & HL_CB_FLAGS_GET_DEVICE_VA)
+			args->out.device_va = device_va;
+		else
+			args->out.usage_cnt = usage_cnt;
 		break;
 
 	default:
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b9fed6b6d1ab..7073fa6b9f0f 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2845,6 +2845,106 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 }
 
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
+				struct hl_cb_mgr *cb_mgr, u64 timeout_us,
+				u64 cq_counters_handle,	u64 cq_counters_offset,
+				u64 target_value, struct hl_user_interrupt *interrupt,
+				u32 *status,
+				u64 *timestamp)
+{
+	struct hl_user_pending_interrupt *pend;
+	unsigned long timeout, flags;
+	long completion_rc;
+	struct hl_cb *cb;
+	int rc = 0;
+	u32 handle;
+
+	timeout = hl_usecs64_to_jiffies(timeout_us);
+
+	hl_ctx_get(hdev, ctx);
+
+	cq_counters_handle >>= PAGE_SHIFT;
+	handle = (u32) cq_counters_handle;
+
+	cb = hl_cb_get(hdev, cb_mgr, handle);
+	if (!cb) {
+		hl_ctx_put(ctx);
+		return -EINVAL;
+	}
+
+	pend = kzalloc(sizeof(*pend), GFP_KERNEL);
+	if (!pend) {
+		hl_cb_put(cb);
+		hl_ctx_put(ctx);
+		return -ENOMEM;
+	}
+
+	hl_fence_init(&pend->fence, ULONG_MAX);
+
+	pend->cq_kernel_addr = (u64 *) cb->kernel_address + cq_counters_offset;
+	pend->cq_target_value = target_value;
+
+	/* We check for completion value as interrupt could have been received
+	 * before we added the node to the wait list
+	 */
+	if (*pend->cq_kernel_addr >= target_value) {
+		*status = HL_WAIT_CS_STATUS_COMPLETED;
+		/* There was no interrupt, we assume the completion is now. */
+		pend->fence.timestamp = ktime_get();
+	}
+
+	if (!timeout_us || (*status == HL_WAIT_CS_STATUS_COMPLETED))
+		goto set_timestamp;
+
+	/* Add pending user interrupt to relevant list for the interrupt
+	 * handler to monitor
+	 */
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
+	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
+	/* Wait for interrupt handler to signal completion */
+	completion_rc = wait_for_completion_interruptible_timeout(&pend->fence.completion,
+								timeout);
+	if (completion_rc > 0) {
+		*status = HL_WAIT_CS_STATUS_COMPLETED;
+	} else {
+		if (completion_rc == -ERESTARTSYS) {
+			dev_err_ratelimited(hdev->dev,
+					"user process got signal while waiting for interrupt ID %d\n",
+					interrupt->interrupt_id);
+			rc = -EINTR;
+			*status = HL_WAIT_CS_STATUS_ABORTED;
+		} else {
+			if (pend->fence.error == -EIO) {
+				dev_err_ratelimited(hdev->dev,
+						"interrupt based wait ioctl aborted(error:%d) due to a reset cycle initiated\n",
+						pend->fence.error);
+				rc = -EIO;
+				*status = HL_WAIT_CS_STATUS_ABORTED;
+			} else {
+				dev_err_ratelimited(hdev->dev, "Waiting for interrupt ID %d timedout\n",
+						interrupt->interrupt_id);
+				rc = -ETIMEDOUT;
+			}
+			*status = HL_WAIT_CS_STATUS_BUSY;
+		}
+	}
+
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
+	list_del(&pend->wait_list_node);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
+set_timestamp:
+	*timestamp = ktime_to_ns(pend->fence.timestamp);
+
+	kfree(pend);
+	hl_cb_put(cb);
+	hl_ctx_put(ctx);
+
+	return rc;
+}
+
+static int _hl_interrupt_wait_ioctl_user_addr(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 user_address,
 				u64 target_value, struct hl_user_interrupt *interrupt,
 
@@ -2861,7 +2961,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_ctx_get(hdev, ctx);
 
-	pend = kmalloc(sizeof(*pend), GFP_KERNEL);
+	pend = kzalloc(sizeof(*pend), GFP_KERNEL);
 	if (!pend) {
 		hl_ctx_put(ctx);
 		return -ENOMEM;
@@ -2990,7 +3090,14 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	else
 		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
 
-	rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx,
+	if (args->in.flags & HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ)
+		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr,
+				args->in.interrupt_timeout_us, args->in.cq_counters_handle,
+				args->in.cq_counters_offset,
+				args->in.target, interrupt, &status,
+				&timestamp);
+	else
+		rc = _hl_interrupt_wait_ioctl_user_addr(hdev, hpriv->ctx,
 				args->in.interrupt_timeout_us, args->in.addr,
 				args->in.target, interrupt, &status,
 				&timestamp);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4d4986177776..78772fe548b9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -876,10 +876,15 @@ struct hl_user_interrupt {
  *                                    pending on an interrupt
  * @wait_list_node: node in the list of user threads pending on an interrupt
  * @fence: hl fence object for interrupt completion
+ * @cq_target_value: CQ target value
+ * @cq_kernel_addr: CQ kernel address, to be used in the cq interrupt
+ *                  handler for taget value comparison
  */
 struct hl_user_pending_interrupt {
 	struct list_head	wait_list_node;
 	struct hl_fence		fence;
+	u64			cq_target_value;
+	u64			*cq_kernel_addr;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 64e0d9de21bd..6454ea12bf3a 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -145,8 +145,12 @@ static void handle_user_cq(struct hl_device *hdev,
 
 	spin_lock(&user_cq->wait_list_lock);
 	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node) {
-		pend->fence.timestamp = now;
-		complete_all(&pend->fence.completion);
+		if ((pend->cq_kernel_addr &&
+				*(pend->cq_kernel_addr) >= pend->cq_target_value) ||
+				!pend->cq_kernel_addr) {
+			pend->fence.timestamp = now;
+			complete_all(&pend->fence.completion);
+		}
 	}
 	spin_unlock(&user_cq->wait_list_lock);
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 648850b954a3..371dfc4243b3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -680,7 +680,10 @@ struct hl_info_args {
 #define HL_MAX_CB_SIZE		(0x200000 - 32)
 
 /* Indicates whether the command buffer should be mapped to the device's MMU */
-#define HL_CB_FLAGS_MAP		0x1
+#define HL_CB_FLAGS_MAP			0x1
+
+/* Used with HL_CB_OP_INFO opcode to get the device va address for kernel mapped CB */
+#define HL_CB_FLAGS_GET_DEVICE_VA	0x2
 
 struct hl_cb_in {
 	/* Handle of CB or 0 if we want to create one */
@@ -702,11 +705,16 @@ struct hl_cb_out {
 		/* Handle of CB */
 		__u64 cb_handle;
 
-		/* Information about CB */
-		struct {
-			/* Usage count of CB */
-			__u32 usage_cnt;
-			__u32 pad;
+		union {
+			/* Information about CB */
+			struct {
+				/* Usage count of CB */
+				__u32 usage_cnt;
+				__u32 pad;
+			};
+
+			/* CB mapped address to device MMU */
+			__u64 device_va;
 		};
 	};
 };
@@ -947,9 +955,10 @@ union hl_cs_args {
 	struct hl_cs_out out;
 };
 
-#define HL_WAIT_CS_FLAGS_INTERRUPT	0x2
-#define HL_WAIT_CS_FLAGS_INTERRUPT_MASK 0xFFF00000
-#define HL_WAIT_CS_FLAGS_MULTI_CS	0x4
+#define HL_WAIT_CS_FLAGS_INTERRUPT		0x2
+#define HL_WAIT_CS_FLAGS_INTERRUPT_MASK		0xFFF00000
+#define HL_WAIT_CS_FLAGS_MULTI_CS		0x4
+#define HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ	0x10
 
 #define HL_WAIT_MULTI_CS_LIST_MAX_LEN	32
 
@@ -969,14 +978,23 @@ struct hl_wait_cs_in {
 		};
 
 		struct {
-			/* User address for completion comparison.
-			 * upon interrupt, driver will compare the value pointed
-			 * by this address with the supplied target value.
-			 * in order not to perform any comparison, set address
-			 * to all 1s.
-			 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
-			 */
-			__u64 addr;
+			union {
+				/* User address for completion comparison.
+				 * upon interrupt, driver will compare the value pointed
+				 * by this address with the supplied target value.
+				 * in order not to perform any comparison, set address
+				 * to all 1s.
+				 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
+				 */
+				__u64 addr;
+
+				/* cq_counters_handle to a kernel mapped cb which contains
+				 * cq counters.
+				 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ is set
+				 */
+				__u64 cq_counters_handle;
+			};
+
 			/* Target value for completion comparison */
 			__u64 target;
 		};
@@ -1004,6 +1022,15 @@ struct hl_wait_cs_in {
 		 */
 		__u64 interrupt_timeout_us;
 	};
+
+	/*
+	 * cq counter offset inside the counters cb pointed by cq_counters_handle above.
+	 * upon interrupt, driver will compare the value pointed
+	 * by this address (cq_counters_handle + cq_counters_offset)
+	 * with the supplied target value.
+	 * relevant only when HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ is set
+	 */
+	__u64 cq_counters_offset;
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
-- 
2.25.1

