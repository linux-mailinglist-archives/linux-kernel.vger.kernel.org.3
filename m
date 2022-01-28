Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3277849FE82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350362AbiA1Q6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:58:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49474 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350356AbiA1Q6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:58:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58CF960A37
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFA9C340E0;
        Fri, 28 Jan 2022 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643389090;
        bh=cSWFmj8V16u2Rv70coCL6KydttKxHizGkDzISlZgJ8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=KENo6okXMlojGRHbOcVeDTfFbAwDy2Qfv9Bmh7b+3cEkHj0BPeOWP9XrL+YBue7AZ
         9MBVa6UQfkniyHqpXlbYts55+cj6hSXDbOolylc8QhaP20gvGUQRfwe0frWqRhY7mh
         PdC/MMzhwHIW343pKgMmcPuAyOarP9XYvYToOLIYovZ4BtJUWX9vMDQK+qJPVnELJ1
         ibgv5+fKX4aBE4lvAj+1QpBsF/XAM7tGOK33IYXpYqc3ydtkidzo2wMRlmr0gkX8+k
         XIieS2rdmVT9K7MSKHH/3AKcnT6RFlx8gI0uAcQsHixNDBPDqb6lakENWlavvuvrfC
         bEjMOGja8Tiww==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/2] habanalabs: Timestamps buffers registration
Date:   Fri, 28 Jan 2022 18:58:04 +0200
Message-Id: <20220128165805.2816823-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Timestamp registration API allows the user to register
a timestamp record event which will make the driver set
timestamp when CQ counter reaches the target value
and write it to a specific location specified
by the user.
This is a non blocking API, unlike the wait_for_interrupt
which is a blocking one.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 197 ++++++++++---
 drivers/misc/habanalabs/common/device.c       |  18 +-
 drivers/misc/habanalabs/common/habanalabs.h   | 106 ++++++-
 .../misc/habanalabs/common/habanalabs_drv.c   |   2 +
 drivers/misc/habanalabs/common/irq.c          | 127 ++++++++-
 drivers/misc/habanalabs/common/memory.c       | 261 ++++++++++++++++++
 include/uapi/misc/habanalabs.h                |  37 ++-
 7 files changed, 690 insertions(+), 58 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ba5215b77852..c7757c78d0b1 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -14,6 +14,8 @@
 #define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
 				HL_CS_FLAGS_COLLECTIVE_WAIT)
 
+#define MAX_TS_ITER_NUM 10
+
 /**
  * enum hl_cs_wait_status - cs wait status
  * @CS_WAIT_STATUS_BUSY: cs was not completed yet
@@ -924,7 +926,7 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 	int i;
 	struct hl_cs *cs, *tmp;
 
-	flush_workqueue(hdev->sob_reset_wq);
+	flush_workqueue(hdev->ts_free_obj_wq);
 
 	/* flush all completions before iterating over the CS mirror list in
 	 * order to avoid a race with the release functions
@@ -948,13 +950,19 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 static void
 wake_pending_user_interrupt_threads(struct hl_user_interrupt *interrupt)
 {
-	struct hl_user_pending_interrupt *pend;
+	struct hl_user_pending_interrupt *pend, *temp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-	list_for_each_entry(pend, &interrupt->wait_list_head, wait_list_node) {
-		pend->fence.error = -EIO;
-		complete_all(&pend->fence.completion);
+	list_for_each_entry_safe(pend, temp, &interrupt->wait_list_head, wait_list_node) {
+		if (pend->ts_reg_info.ts_buff) {
+			list_del(&pend->wait_list_node);
+			hl_ts_put(pend->ts_reg_info.ts_buff);
+			hl_cb_put(pend->ts_reg_info.cq_cb);
+		} else {
+			pend->fence.error = -EIO;
+			complete_all(&pend->fence.completion);
+		}
 	}
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 }
@@ -2857,43 +2865,133 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	return 0;
 }
 
+static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
+					struct hl_cb *cq_cb,
+					u64 ts_offset, u64 cq_offset, u64 target_value,
+					spinlock_t *wait_list_lock,
+					struct hl_user_pending_interrupt **pend)
+{
+	struct hl_user_pending_interrupt *requested_offset_record =
+				(struct hl_user_pending_interrupt *)ts_buff->kernel_buff_address +
+				ts_offset;
+	struct hl_user_pending_interrupt *cb_last =
+			(struct hl_user_pending_interrupt *)ts_buff->kernel_buff_address +
+			(ts_buff->kernel_buff_size / sizeof(struct hl_user_pending_interrupt));
+	unsigned long flags, iter_counter = 0;
+	u64 current_cq_counter;
+
+	/* Validate ts_offset not exceeding last max */
+	if (requested_offset_record > cb_last) {
+		dev_err(ts_buff->hdev->dev, "Ts offset exceeds max CB offset(0x%llx)\n",
+								(u64)(uintptr_t)cb_last);
+		return -EINVAL;
+	}
+
+start_over:
+	spin_lock_irqsave(wait_list_lock, flags);
+
+	/* Unregister only if we didn't reach the target value
+	 * since in this case there will be no handling in irq context
+	 * and then it's safe to delete the node out of the interrupt list
+	 * then re-use it on other interrupt
+	 */
+	if (requested_offset_record->ts_reg_info.in_use) {
+		current_cq_counter = *requested_offset_record->cq_kernel_addr;
+		if (current_cq_counter < requested_offset_record->cq_target_value) {
+			list_del(&requested_offset_record->wait_list_node);
+			spin_unlock_irqrestore(wait_list_lock, flags);
+
+			hl_ts_put(requested_offset_record->ts_reg_info.ts_buff);
+			hl_cb_put(requested_offset_record->ts_reg_info.cq_cb);
+
+			dev_dbg(ts_buff->hdev->dev, "ts node removed from interrupt list now can re-use\n");
+		} else {
+			dev_dbg(ts_buff->hdev->dev, "ts node in middle of irq handling\n");
+
+			/* irq handling in the middle give it time to finish */
+			spin_unlock_irqrestore(wait_list_lock, flags);
+			usleep_range(1, 10);
+			if (++iter_counter == MAX_TS_ITER_NUM) {
+				dev_err(ts_buff->hdev->dev, "handling registration interrupt took too long!!\n");
+				return -EINVAL;
+			}
+
+			goto start_over;
+		}
+	} else {
+		spin_unlock_irqrestore(wait_list_lock, flags);
+	}
+
+	/* Fill up the new registration node info */
+	requested_offset_record->ts_reg_info.in_use = 1;
+	requested_offset_record->ts_reg_info.ts_buff = ts_buff;
+	requested_offset_record->ts_reg_info.cq_cb = cq_cb;
+	requested_offset_record->ts_reg_info.timestamp_kernel_addr =
+			(u64 *) ts_buff->user_buff_address + ts_offset;
+	requested_offset_record->cq_kernel_addr =
+			(u64 *) cq_cb->kernel_address + cq_offset;
+	requested_offset_record->cq_target_value = target_value;
+
+	*pend = requested_offset_record;
+
+	dev_dbg(ts_buff->hdev->dev, "Found available node in TS kernel CB(0x%llx)\n",
+						(u64)(uintptr_t)requested_offset_record);
+	return 0;
+}
+
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				struct hl_cb_mgr *cb_mgr, u64 timeout_us,
-				u64 cq_counters_handle,	u64 cq_counters_offset,
+				struct hl_cb_mgr *cb_mgr, struct hl_ts_mgr *ts_mgr,
+				u64 timeout_us, u64 cq_counters_handle,	u64 cq_counters_offset,
 				u64 target_value, struct hl_user_interrupt *interrupt,
+				bool register_ts_record, u64 ts_handle, u64 ts_offset,
 				u32 *status, u64 *timestamp)
 {
+	u32 cq_patched_handle, ts_patched_handle;
 	struct hl_user_pending_interrupt *pend;
+	struct hl_ts_buff *ts_buff;
+	struct hl_cb *cq_cb;
 	unsigned long timeout, flags;
 	long completion_rc;
-	struct hl_cb *cb;
 	int rc = 0;
-	u32 handle;
 
 	timeout = hl_usecs64_to_jiffies(timeout_us);
 
 	hl_ctx_get(hdev, ctx);
 
-	cq_counters_handle >>= PAGE_SHIFT;
-	handle = (u32) cq_counters_handle;
-
-	cb = hl_cb_get(hdev, cb_mgr, handle);
-	if (!cb) {
-		hl_ctx_put(ctx);
-		return -EINVAL;
+	cq_patched_handle = lower_32_bits(cq_counters_handle >> PAGE_SHIFT);
+	cq_cb = hl_cb_get(hdev, cb_mgr, cq_patched_handle);
+	if (!cq_cb) {
+		rc = -EINVAL;
+		goto put_ctx;
 	}
 
-	pend = kzalloc(sizeof(*pend), GFP_KERNEL);
-	if (!pend) {
-		hl_cb_put(cb);
-		hl_ctx_put(ctx);
-		return -ENOMEM;
-	}
+	if (register_ts_record) {
+		dev_dbg(hdev->dev, "Timestamp registration: interrupt id: %u, ts offset: %llu, cq_offset: %llu\n",
+					interrupt->interrupt_id, ts_offset, cq_counters_offset);
 
-	hl_fence_init(&pend->fence, ULONG_MAX);
+		ts_patched_handle = lower_32_bits(ts_handle >> PAGE_SHIFT);
+		ts_buff = hl_ts_get(hdev, ts_mgr, ts_patched_handle);
+		if (!ts_buff) {
+			rc = -EINVAL;
+			goto put_cq_cb;
+		}
 
-	pend->cq_kernel_addr = (u64 *) cb->kernel_address + cq_counters_offset;
-	pend->cq_target_value = target_value;
+		/* Find first available record */
+		rc = ts_buff_get_kernel_ts_record(ts_buff, cq_cb, ts_offset,
+						cq_counters_offset, target_value,
+						&interrupt->wait_list_lock, &pend);
+		if (rc)
+			goto put_ts_buff;
+	} else {
+		pend = kzalloc(sizeof(*pend), GFP_KERNEL);
+		if (!pend) {
+			rc = -ENOMEM;
+			goto put_cq_cb;
+		}
+		hl_fence_init(&pend->fence, ULONG_MAX);
+		pend->cq_kernel_addr = (u64 *) cq_cb->kernel_address + cq_counters_offset;
+		pend->cq_target_value = target_value;
+	}
 
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 
@@ -2901,13 +2999,19 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * before we added the node to the wait list
 	 */
 	if (*pend->cq_kernel_addr >= target_value) {
+		if (register_ts_record)
+			pend->ts_reg_info.in_use = 0;
 		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
 		*status = HL_WAIT_CS_STATUS_COMPLETED;
-		/* There was no interrupt, we assume the completion is now. */
-		pend->fence.timestamp = ktime_get();
-		goto set_timestamp;
 
+		if (register_ts_record) {
+			*pend->ts_reg_info.timestamp_kernel_addr = ktime_get_ns();
+			goto put_ts_buff;
+		} else {
+			pend->fence.timestamp = ktime_get();
+			goto set_timestamp;
+		}
 	} else if (!timeout_us) {
 		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 		*status = HL_WAIT_CS_STATUS_BUSY;
@@ -2916,11 +3020,19 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 	/* Add pending user interrupt to relevant list for the interrupt
-	 * handler to monitor
+	 * handler to monitor.
+	 * Note that we cannot have sorted list by target value,
+	 * in order to shorten the list pass loop, since
+	 * same list could have nodes for different cq counter handle.
 	 */
 	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
+	if (register_ts_record) {
+		rc = *status = HL_WAIT_CS_STATUS_COMPLETED;
+		goto ts_registration_exit;
+	}
+
 	/* Wait for interrupt handler to signal completion */
 	completion_rc = wait_for_completion_interruptible_timeout(&pend->fence.completion,
 								timeout);
@@ -2952,15 +3064,30 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		}
 	}
 
+	/*
+	 * We keep removing the node from list here, and not at the irq handler
+	 * for completion timeout case. and if it's a registration
+	 * for ts record, the node will be deleted in the irq handler after
+	 * we reach the target value.
+	 */
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_del(&pend->wait_list_node);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
 set_timestamp:
 	*timestamp = ktime_to_ns(pend->fence.timestamp);
-
 	kfree(pend);
-	hl_cb_put(cb);
+	hl_cb_put(cq_cb);
+ts_registration_exit:
+	hl_ctx_put(ctx);
+
+	return rc;
+
+put_ts_buff:
+	hl_ts_put(ts_buff);
+put_cq_cb:
+	hl_cb_put(cq_cb);
+put_ctx:
 	hl_ctx_put(ctx);
 
 	return rc;
@@ -3119,11 +3246,13 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
 
 	if (args->in.flags & HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ)
-		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr,
+		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr, &hpriv->ts_mem_mgr,
 				args->in.interrupt_timeout_us, args->in.cq_counters_handle,
 				args->in.cq_counters_offset,
-				args->in.target, interrupt, &status,
-				&timestamp);
+				args->in.target, interrupt,
+				!!(args->in.flags & HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT),
+				args->in.timestamp_handle, args->in.timestamp_offset,
+				&status, &timestamp);
 	else
 		rc = _hl_interrupt_wait_ioctl_user_addr(hdev, hpriv->ctx,
 				args->in.interrupt_timeout_us, args->in.addr,
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 727315b36b8b..60bfd737404b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -145,6 +145,7 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
 	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
+	hl_ts_mgr_fini(hpriv->hdev, &hpriv->ts_mem_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
 	if (!hl_hpriv_put(hpriv))
@@ -209,6 +210,9 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	case HL_MMAP_TYPE_BLOCK:
 		return hl_hw_block_mmap(hpriv, vma);
+
+	case HL_MMAP_TYPE_TS_BUFF:
+		return hl_ts_mmap(hpriv, vma);
 	}
 
 	return -EINVAL;
@@ -410,10 +414,10 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cq_wq;
 	}
 
-	hdev->sob_reset_wq = alloc_workqueue("hl-sob-reset", WQ_UNBOUND, 0);
-	if (!hdev->sob_reset_wq) {
+	hdev->ts_free_obj_wq = alloc_workqueue("hl-ts-free-obj", WQ_UNBOUND, 0);
+	if (!hdev->ts_free_obj_wq) {
 		dev_err(hdev->dev,
-			"Failed to allocate SOB reset workqueue\n");
+			"Failed to allocate Timestamp registration free workqueue\n");
 		rc = -ENOMEM;
 		goto free_eq_wq;
 	}
@@ -422,7 +426,7 @@ static int device_early_init(struct hl_device *hdev)
 					GFP_KERNEL);
 	if (!hdev->hl_chip_info) {
 		rc = -ENOMEM;
-		goto free_sob_reset_wq;
+		goto free_ts_free_wq;
 	}
 
 	rc = hl_mmu_if_set_funcs(hdev);
@@ -461,8 +465,8 @@ static int device_early_init(struct hl_device *hdev)
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
-free_sob_reset_wq:
-	destroy_workqueue(hdev->sob_reset_wq);
+free_ts_free_wq:
+	destroy_workqueue(hdev->ts_free_obj_wq);
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
@@ -501,7 +505,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	kfree(hdev->hl_chip_info);
 
-	destroy_workqueue(hdev->sob_reset_wq);
+	destroy_workqueue(hdev->ts_free_obj_wq);
 	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->device_reset_work.wq);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 995167020c27..b06e2b0812b6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -31,14 +31,15 @@
 #define HL_NAME				"habanalabs"
 
 /* Use upper bits of mmap offset to store habana driver specific information.
- * bits[63:61] - Encode mmap type
+ * bits[63:59] - Encode mmap type
  * bits[45:0]  - mmap offset value
  *
  * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
  *  defines are w.r.t to PAGE_SIZE
  */
-#define HL_MMAP_TYPE_SHIFT		(61 - PAGE_SHIFT)
-#define HL_MMAP_TYPE_MASK		(0x7ull << HL_MMAP_TYPE_SHIFT)
+#define HL_MMAP_TYPE_SHIFT		(59 - PAGE_SHIFT)
+#define HL_MMAP_TYPE_MASK		(0x1full << HL_MMAP_TYPE_SHIFT)
+#define HL_MMAP_TYPE_TS_BUFF		(0x10ull << HL_MMAP_TYPE_SHIFT)
 #define HL_MMAP_TYPE_BLOCK		(0x4ull << HL_MMAP_TYPE_SHIFT)
 #define HL_MMAP_TYPE_CB			(0x2ull << HL_MMAP_TYPE_SHIFT)
 
@@ -709,6 +710,40 @@ struct hl_cb_mgr {
 	struct idr		cb_handles; /* protected by cb_lock */
 };
 
+/**
+ * struct hl_ts_mgr - describes the timestamp registration memory manager.
+ * @ts_lock: protects ts_handles.
+ * @ts_handles: an idr to hold all ts bufferes handles.
+ */
+struct hl_ts_mgr {
+	spinlock_t		ts_lock;
+	struct idr		ts_handles;
+};
+
+/**
+ * struct hl_ts_buff - describes a timestamp buffer.
+ * @refcount: reference counter for usage of the buffer.
+ * @hdev: pointer to device this buffer belongs to.
+ * @mmap: true if the buff is currently mapped to user.
+ * @kernel_buff_address: Holds the internal buffer's kernel virtual address.
+ * @user_buff_address: Holds the user buffer's kernel virtual address.
+ * @id: the buffer ID.
+ * @mmap_size: Holds the buffer size that was mmaped.
+ * @kernel_buff_size: Holds the internal kernel buffer size.
+ * @user_buff_size: Holds the user buffer size.
+ */
+struct hl_ts_buff {
+	struct kref		refcount;
+	struct hl_device	*hdev;
+	atomic_t		mmap;
+	void			*kernel_buff_address;
+	void			*user_buff_address;
+	u32			id;
+	u32			mmap_size;
+	u32			kernel_buff_size;
+	u32			user_buff_size;
+};
+
 /**
  * struct hl_cb - describes a Command Buffer.
  * @refcount: reference counter for usage of the CB.
@@ -886,9 +921,54 @@ struct hl_user_interrupt {
 	u32			interrupt_id;
 };
 
+/**
+ * struct timestamp_reg_free_node - holds the timestamp registration free objects node
+ * @free_objects_node: node in the list free_obj_jobs
+ * @cq_cb: pointer to cq command buffer to be freed
+ * @ts_buff: pointer to timestamp buffer to be freed
+ */
+struct timestamp_reg_free_node {
+	struct list_head	free_objects_node;
+	struct hl_cb		*cq_cb;
+	struct hl_ts_buff	*ts_buff;
+};
+
+/* struct timestamp_reg_work_obj - holds the timestamp registration free objects job
+ * the job will be to pass over the free_obj_jobs list and put refcount to objects
+ * in each node of the list
+ * @free_obj: workqueue object to free timestamp registration node objects
+ * @hdev: pointer to the device structure
+ * @free_obj_head: list of free jobs nodes (node type timestamp_reg_free_node)
+ */
+struct timestamp_reg_work_obj {
+	struct work_struct	free_obj;
+	struct hl_device	*hdev;
+	struct list_head	*free_obj_head;
+};
+
+/* struct timestamp_reg_info - holds the timestamp registration related data.
+ * @ts_buff: pointer to the timestamp buffer which include both user/kernel buffers.
+ *           relevant only when doing timestamps records registration.
+ * @cq_cb: pointer to CQ counter CB.
+ * @timestamp_kernel_addr: timestamp handle address, where to set timestamp
+ *                         relevant only when doing timestamps records
+ *                         registration.
+ * @in_use: indicates if the node already in use. relevant only when doing
+ *          timestamps records registration, since in this case the driver
+ *          will have it's own buffer which serve as a records pool instead of
+ *          allocating records dynamically.
+ */
+struct timestamp_reg_info {
+	struct hl_ts_buff	*ts_buff;
+	struct hl_cb		*cq_cb;
+	u64			*timestamp_kernel_addr;
+	u8			in_use;
+};
+
 /**
  * struct hl_user_pending_interrupt - holds a context to a user thread
  *                                    pending on an interrupt
+ * @ts_reg_info: holds the timestamps registration nodes info
  * @wait_list_node: node in the list of user threads pending on an interrupt
  * @fence: hl fence object for interrupt completion
  * @cq_target_value: CQ target value
@@ -896,10 +976,11 @@ struct hl_user_interrupt {
  *                  handler for taget value comparison
  */
 struct hl_user_pending_interrupt {
-	struct list_head	wait_list_node;
-	struct hl_fence		fence;
-	u64			cq_target_value;
-	u64			*cq_kernel_addr;
+	struct timestamp_reg_info	ts_reg_info;
+	struct list_head		wait_list_node;
+	struct hl_fence			fence;
+	u64				cq_target_value;
+	u64				*cq_kernel_addr;
 };
 
 /**
@@ -1833,6 +1914,7 @@ struct hl_debug_params {
  * @ctx: current executing context. TODO: remove for multiple ctx per process
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
+ * @ts_mem_mgr: timestamp registration manager for alloc/free/map timestamp buffers.
  * @debugfs_list: list of relevant ASIC debugfs.
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
@@ -1845,6 +1927,7 @@ struct hl_fpriv {
 	struct hl_ctx		*ctx;
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
+	struct hl_ts_mgr	ts_mem_mgr;
 	struct list_head	debugfs_list;
 	struct list_head	dev_node;
 	struct kref		refcount;
@@ -2517,7 +2600,7 @@ struct hl_reset_info {
  * @cq_wq: work queues of completion queues for executing work in process
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
- * @sob_reset_wq: work queue for sob reset executions.
+ * @ts_free_obj_wq: work queue for timestamp registration objects release.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
@@ -2645,7 +2728,7 @@ struct hl_device {
 	struct hl_user_interrupt	common_user_interrupt;
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
-	struct workqueue_struct		*sob_reset_wq;
+	struct workqueue_struct		*ts_free_obj_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
@@ -3128,6 +3211,11 @@ __printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
 					const char *format, ...);
 char *hl_format_as_binary(char *buf, size_t buf_len, u32 n);
 const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
+void hl_ts_mgr_init(struct hl_ts_mgr *mgr);
+void hl_ts_mgr_fini(struct hl_device *hdev, struct hl_ts_mgr *mgr);
+int hl_ts_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
+struct hl_ts_buff *hl_ts_get(struct hl_device *hdev, struct hl_ts_mgr *mgr, u32 handle);
+void hl_ts_put(struct hl_ts_buff *buff);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 017bfc4551da..ca404ed9d9a7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -140,6 +140,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
+	hl_ts_mgr_init(&hpriv->ts_mem_mgr);
 
 	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
@@ -184,6 +185,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
+	hl_ts_mgr_fini(hpriv->hdev, &hpriv->ts_mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
 	mutex_destroy(&hpriv->restore_phase_mutex);
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 1b6bdc900c26..c28f3a1c7a03 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -137,22 +137,137 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/*
+ * hl_ts_free_objects - handler of the free objects workqueue.
+ * This function should put refcount to objects that the registration node
+ * took refcount to them.
+ * @work: workqueue object pointer
+ */
+static void hl_ts_free_objects(struct work_struct *work)
+{
+	struct timestamp_reg_work_obj *job =
+			container_of(work, struct timestamp_reg_work_obj, free_obj);
+	struct timestamp_reg_free_node *free_obj, *temp_free_obj;
+	struct list_head *free_list_head = job->free_obj_head;
+	struct hl_device *hdev = job->hdev;
+
+	list_for_each_entry_safe(free_obj, temp_free_obj, free_list_head, free_objects_node) {
+		dev_dbg(hdev->dev, "About to put refcount to ts_buff (%p) cq_cb(%p)\n",
+					free_obj->ts_buff,
+					free_obj->cq_cb);
+
+		hl_ts_put(free_obj->ts_buff);
+		hl_cb_put(free_obj->cq_cb);
+		kfree(free_obj);
+	}
+
+	kfree(free_list_head);
+	kfree(job);
+}
+
+/*
+ * This function called with spin_lock of wait_list_lock taken
+ * This function will set timestamp and delete the registration node from the
+ * wait_list_lock.
+ * and since we're protected with spin_lock here, so we cannot just put the refcount
+ * for the objects here, since the release function may be called and it's also a long
+ * logic (which might sleep also) that cannot be handled in irq context.
+ * so here we'll be filling a list with nodes of "put" jobs and then will send this
+ * list to a dedicated workqueue to do the actual put.
+ */
+int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
+						struct list_head **free_list)
+{
+	struct timestamp_reg_free_node *free_node;
+	u64 timestamp;
+
+	if (!(*free_list)) {
+		/* Alloc/Init the timestamp registration free objects list */
+		*free_list = kmalloc(sizeof(struct list_head), GFP_ATOMIC);
+		if (!(*free_list))
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(*free_list);
+	}
+
+	free_node = kmalloc(sizeof(*free_node), GFP_ATOMIC);
+	if (!free_node)
+		return -ENOMEM;
+
+	timestamp = ktime_get_ns();
+
+	*pend->ts_reg_info.timestamp_kernel_addr = timestamp;
+
+	dev_dbg(hdev->dev, "Timestamp is set to ts cb address (%p), ts: 0x%llx\n",
+			pend->ts_reg_info.timestamp_kernel_addr,
+			*(u64 *)pend->ts_reg_info.timestamp_kernel_addr);
+
+	list_del(&pend->wait_list_node);
+
+	/* Mark kernel CB node as free */
+	pend->ts_reg_info.in_use = 0;
+
+	/* Putting the refcount for ts_buff and cq_cb objects will be handled
+	 * in workqueue context, just add job to free_list.
+	 */
+	free_node->ts_buff = pend->ts_reg_info.ts_buff;
+	free_node->cq_cb = pend->ts_reg_info.cq_cb;
+	list_add(&free_node->free_objects_node, *free_list);
+
+	return 0;
+}
+
 static void handle_user_cq(struct hl_device *hdev,
 			struct hl_user_interrupt *user_cq)
 {
-	struct hl_user_pending_interrupt *pend;
+	struct hl_user_pending_interrupt *pend, *temp_pend;
+	struct list_head *ts_reg_free_list_head = NULL;
+	struct timestamp_reg_work_obj *job;
+	bool reg_node_handle_fail = false;
 	ktime_t now = ktime_get();
+	int rc;
+
+	/* For registration nodes:
+	 * As part of handling the registration nodes, we should put refcount to
+	 * some objects. the problem is that we cannot do that under spinlock
+	 * or in irq handler context at all (since release functions are long and
+	 * might sleep), so we will need to handle that part in workqueue context.
+	 * To avoid handling kmalloc failure which compels us rolling back actions
+	 * and move nodes hanged on the free list back to the interrupt wait list
+	 * we always alloc the job of the WQ at the beginning.
+	 */
+	job = kmalloc(sizeof(*job), GFP_ATOMIC);
+	if (!job)
+		return;
 
 	spin_lock(&user_cq->wait_list_lock);
-	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node) {
-		if ((pend->cq_kernel_addr &&
-				*(pend->cq_kernel_addr) >= pend->cq_target_value) ||
+	list_for_each_entry_safe(pend, temp_pend, &user_cq->wait_list_head, wait_list_node) {
+		if ((pend->cq_kernel_addr && *(pend->cq_kernel_addr) >= pend->cq_target_value) ||
 				!pend->cq_kernel_addr) {
-			pend->fence.timestamp = now;
-			complete_all(&pend->fence.completion);
+			if (pend->ts_reg_info.ts_buff) {
+				if (!reg_node_handle_fail) {
+					rc = handle_registration_node(hdev, pend,
+									&ts_reg_free_list_head);
+					if (rc)
+						reg_node_handle_fail = true;
+				}
+			} else {
+				/* Handle wait target value node */
+				pend->fence.timestamp = now;
+				complete_all(&pend->fence.completion);
+			}
 		}
 	}
 	spin_unlock(&user_cq->wait_list_lock);
+
+	if (ts_reg_free_list_head) {
+		INIT_WORK(&job->free_obj, hl_ts_free_objects);
+		job->free_obj_head = ts_reg_free_list_head;
+		job->hdev = hdev;
+		queue_work(hdev->ts_free_obj_wq, &job->free_obj);
+	} else {
+		kfree(job);
+	}
 }
 
 /**
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index f60a9638d9ea..c0904081f37e 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -20,6 +20,9 @@ MODULE_IMPORT_NS(DMA_BUF);
 /* use small pages for supporting non-pow2 (32M/40M/48M) DRAM phys page sizes */
 #define DRAM_POOL_PAGE_SIZE SZ_8M
 
+static int allocate_timestamps_buffers(struct hl_fpriv *hpriv,
+			struct hl_mem_in *args, u64 *handle);
+
 /*
  * The va ranges in context object contain a list with the available chunks of
  * device virtual memory.
@@ -2021,6 +2024,9 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 		rc = -EPERM;
 		break;
 
+	case HL_MEM_OP_TS_ALLOC:
+		rc = allocate_timestamps_buffers(hpriv, &args->in, &args->out.handle);
+		break;
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
 		rc = -EINVAL;
@@ -2031,6 +2037,258 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 	return rc;
 }
 
+static void ts_buff_release(struct kref *ref)
+{
+	struct hl_ts_buff *buff;
+
+	buff = container_of(ref, struct hl_ts_buff, refcount);
+
+	vfree(buff->kernel_buff_address);
+	vfree(buff->user_buff_address);
+	kfree(buff);
+}
+
+struct hl_ts_buff *hl_ts_get(struct hl_device *hdev, struct hl_ts_mgr *mgr,
+					u32 handle)
+{
+	struct hl_ts_buff *buff;
+
+	spin_lock(&mgr->ts_lock);
+	buff = idr_find(&mgr->ts_handles, handle);
+	if (!buff) {
+		spin_unlock(&mgr->ts_lock);
+		dev_warn(hdev->dev,
+			"TS buff get failed, no match to handle 0x%x\n", handle);
+		return NULL;
+	}
+	kref_get(&buff->refcount);
+	spin_unlock(&mgr->ts_lock);
+
+	return buff;
+}
+
+void hl_ts_put(struct hl_ts_buff *buff)
+{
+	kref_put(&buff->refcount, ts_buff_release);
+}
+
+static void buff_vm_close(struct vm_area_struct *vma)
+{
+	struct hl_ts_buff *buff = (struct hl_ts_buff *) vma->vm_private_data;
+	long new_mmap_size;
+
+	new_mmap_size = buff->mmap_size - (vma->vm_end - vma->vm_start);
+
+	if (new_mmap_size > 0) {
+		buff->mmap_size = new_mmap_size;
+		return;
+	}
+
+	atomic_set(&buff->mmap, 0);
+	hl_ts_put(buff);
+	vma->vm_private_data = NULL;
+}
+
+static const struct vm_operations_struct ts_buff_vm_ops = {
+	.close = buff_vm_close
+};
+
+int hl_ts_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ts_buff *buff;
+	u32 handle, user_buff_size;
+	int rc;
+
+	/* We use the page offset to hold the idr and thus we need to clear
+	 * it before doing the mmap itself
+	 */
+	handle = vma->vm_pgoff;
+	vma->vm_pgoff = 0;
+
+	buff = hl_ts_get(hdev, &hpriv->ts_mem_mgr, handle);
+	if (!buff) {
+		dev_err(hdev->dev,
+			"TS buff mmap failed, no match to handle 0x%x\n", handle);
+		return -EINVAL;
+	}
+
+	/* Validation check */
+	user_buff_size = vma->vm_end - vma->vm_start;
+	if (user_buff_size != ALIGN(buff->user_buff_size, PAGE_SIZE)) {
+		dev_err(hdev->dev,
+			"TS buff mmap failed, mmap size 0x%x != 0x%x buff size\n",
+			user_buff_size, ALIGN(buff->user_buff_size, PAGE_SIZE));
+		rc = -EINVAL;
+		goto put_buff;
+	}
+
+#ifdef _HAS_TYPE_ARG_IN_ACCESS_OK
+	if (!access_ok(VERIFY_WRITE,
+		(void __user *) (uintptr_t) vma->vm_start, user_buff_size)) {
+#else
+	if (!access_ok((void __user *) (uintptr_t) vma->vm_start,
+						user_buff_size)) {
+#endif
+		dev_err(hdev->dev,
+			"user pointer is invalid - 0x%lx\n",
+			vma->vm_start);
+
+		rc = -EINVAL;
+		goto put_buff;
+	}
+
+	if (atomic_cmpxchg(&buff->mmap, 0, 1)) {
+		dev_err(hdev->dev, "TS buff memory mmap failed, already mmaped to user\n");
+		rc = -EINVAL;
+		goto put_buff;
+	}
+
+	vma->vm_ops = &ts_buff_vm_ops;
+	vma->vm_private_data = buff;
+	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP | VM_DONTCOPY | VM_NORESERVE;
+	rc = remap_vmalloc_range(vma, buff->user_buff_address, 0);
+	if (rc) {
+		atomic_set(&buff->mmap, 0);
+		goto put_buff;
+	}
+
+	buff->mmap_size = buff->user_buff_size;
+	vma->vm_pgoff = handle;
+
+	return 0;
+
+put_buff:
+	hl_ts_put(buff);
+	return rc;
+}
+
+void hl_ts_mgr_init(struct hl_ts_mgr *mgr)
+{
+	spin_lock_init(&mgr->ts_lock);
+	idr_init(&mgr->ts_handles);
+}
+
+void hl_ts_mgr_fini(struct hl_device *hdev, struct hl_ts_mgr *mgr)
+{
+	struct hl_ts_buff *buff;
+	struct idr *idp;
+	u32 id;
+
+	idp = &mgr->ts_handles;
+
+	idr_for_each_entry(idp, buff, id) {
+		if (kref_put(&buff->refcount, ts_buff_release) != 1)
+			dev_err(hdev->dev, "TS buff handle %d for CTX is still alive\n",
+							id);
+	}
+
+	idr_destroy(&mgr->ts_handles);
+}
+
+static struct hl_ts_buff *hl_ts_alloc_buff(struct hl_device *hdev, u32 num_elements)
+{
+	struct hl_ts_buff *ts_buff = NULL;
+	u32 size;
+	void *p;
+
+	ts_buff = kzalloc(sizeof(*ts_buff), GFP_KERNEL);
+	if (!ts_buff)
+		return NULL;
+
+	/* Allocate the user buffer */
+	size = num_elements * sizeof(u64);
+	p = vmalloc_user(size);
+	if (!p)
+		goto free_mem;
+
+	ts_buff->user_buff_address = p;
+	ts_buff->user_buff_size = size;
+
+	/* Allocate the internal kernel buffer */
+	size = num_elements * sizeof(struct hl_user_pending_interrupt);
+	p = vmalloc(size);
+	if (!p)
+		goto free_user_buff;
+
+	ts_buff->kernel_buff_address = p;
+	ts_buff->kernel_buff_size = size;
+
+	return ts_buff;
+
+free_user_buff:
+	vfree(ts_buff->user_buff_address);
+free_mem:
+	kfree(ts_buff);
+	return NULL;
+}
+
+/**
+ * allocate_timestamps_buffers() - allocate timestamps buffers
+ * This function will allocate ts buffer that will later on be mapped to the user
+ * in order to be able to read the timestamp.
+ * in additon it'll allocate an extra buffer for registration management.
+ * since we cannot fail during registration for out-of-memory situation, so
+ * we'll prepare a pool which will be used as user interrupt nodes and instead
+ * of dynamically allocating nodes while registration we'll pick the node from
+ * this pool. in addtion it'll add node to the mapping hash which will be used
+ * to map user ts buffer to the internal kernel ts buffer.
+ * @hpriv: pointer to the private data of the fd
+ * @args: ioctl input
+ * @handle: user timestamp buffer handle as an output
+ */
+static int allocate_timestamps_buffers(struct hl_fpriv *hpriv, struct hl_mem_in *args, u64 *handle)
+{
+	struct hl_ts_mgr *ts_mgr = &hpriv->ts_mem_mgr;
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ts_buff *ts_buff;
+	int rc = 0;
+
+	if (args->num_of_elements > TS_MAX_ELEMENTS_NUM) {
+		dev_err(hdev->dev, "Num of elements exceeds Max allowed number (0x%x > 0x%x)\n",
+				args->num_of_elements, TS_MAX_ELEMENTS_NUM);
+		return -EINVAL;
+	}
+
+	/* Allocate ts buffer object
+	 * This object will contain two buffers one that will be mapped to the user
+	 * and another internal buffer for the driver use only, which won't be mapped
+	 * to the user.
+	 */
+	ts_buff = hl_ts_alloc_buff(hdev, args->num_of_elements);
+	if (!ts_buff) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
+
+	spin_lock(&ts_mgr->ts_lock);
+	rc = idr_alloc(&ts_mgr->ts_handles, ts_buff, 1, 0, GFP_ATOMIC);
+	spin_unlock(&ts_mgr->ts_lock);
+	if (rc < 0) {
+		dev_err(hdev->dev, "Failed to allocate IDR for a new ts buffer\n");
+		goto release_ts_buff;
+	}
+
+	ts_buff->id = rc;
+	ts_buff->hdev = hdev;
+
+	kref_init(&ts_buff->refcount);
+
+	/* idr is 32-bit so we can safely OR it with a mask that is above 32 bit */
+	*handle = (u64) ts_buff->id | HL_MMAP_TYPE_TS_BUFF;
+	*handle <<= PAGE_SHIFT;
+
+	dev_dbg(hdev->dev, "Created ts buff object handle(%u)\n", ts_buff->id);
+
+	return 0;
+
+release_ts_buff:
+	kref_put(&ts_buff->refcount, ts_buff_release);
+out_err:
+	*handle = 0;
+	return rc;
+}
+
 int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	enum hl_device_status status;
@@ -2146,6 +2404,9 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		args->out.fd = dmabuf_fd;
 		break;
 
+	case HL_MEM_OP_TS_ALLOC:
+		rc = allocate_timestamps_buffers(hpriv, &args->in, &args->out.handle);
+		break;
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
 		rc = -EINVAL;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 12976f7a8d84..e21db03196ae 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2020 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -30,6 +30,9 @@
  */
 #define GAUDI_FIRST_AVAILABLE_W_S_MONITOR		72
 
+/* Max number of elements in timestamps registration buffers */
+#define	TS_MAX_ELEMENTS_NUM				(1 << 20) /* 1MB */
+
 /*
  * Goya queue Numbering
  *
@@ -695,10 +698,12 @@ struct hl_cb_in {
 	__u64 cb_handle;
 	/* HL_CB_OP_* */
 	__u32 op;
+
 	/* Size of CB. Maximum size is HL_MAX_CB_SIZE. The minimum size that
 	 * will be allocated, regardless of this parameter's value, is PAGE_SIZE
 	 */
 	__u32 cb_size;
+
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
 	/* HL_CB_FLAGS_* */
@@ -964,6 +969,7 @@ union hl_cs_args {
 #define HL_WAIT_CS_FLAGS_INTERRUPT_MASK		0xFFF00000
 #define HL_WAIT_CS_FLAGS_MULTI_CS		0x4
 #define HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ	0x10
+#define HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT	0x20
 
 #define HL_WAIT_MULTI_CS_LIST_MAX_LEN	32
 
@@ -1036,6 +1042,20 @@ struct hl_wait_cs_in {
 	 * relevant only when HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ is set
 	 */
 	__u64 cq_counters_offset;
+
+	/*
+	 * Timestamp_handle timestamps buffer handle.
+	 * relevant only when HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT is set
+	 */
+	__u64 timestamp_handle;
+
+	/*
+	 * Timestamp_offset is offset inside the timestamp buffer pointed by timestamp_handle above.
+	 * upon interrupt, if the cq reached the target value then driver will write
+	 * timestamp to this offset.
+	 * relevant only when HL_WAIT_CS_FLAGS_REGISTER_INTERRUPT is set
+	 */
+	__u64 timestamp_offset;
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
@@ -1082,6 +1102,14 @@ union hl_wait_cs_args {
  */
 #define HL_MEM_OP_EXPORT_DMABUF_FD	5
 
+/* Opcode to create timestamps pool for user interrupts registration support
+ * The memory will be allocated by the kernel driver, A timestamp buffer which the user
+ * will get handle to it for mmap, and another internal buffer used by the
+ * driver for registration management
+ * The memory will be freed when the user closes the file descriptor(ctx close)
+ */
+#define HL_MEM_OP_TS_ALLOC		6
+
 /* Memory flags */
 #define HL_MEM_CONTIGUOUS	0x1
 #define HL_MEM_SHARED		0x2
@@ -1173,9 +1201,14 @@ struct hl_mem_in {
 	 * DMA-BUF file/FD flags.
 	 */
 	__u32 flags;
+
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
-	__u32 pad;
+
+	/* number of timestamp elements
+	 * used only when HL_MEM_OP_TS_ALLOC opcode
+	 */
+	__u32 num_of_elements;
 };
 
 struct hl_mem_out {
-- 
2.25.1

