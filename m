Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D274E6124
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbiCXJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiCXJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355E1C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 152AAB820BD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C8C340EC;
        Thu, 24 Mar 2022 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114438;
        bh=HnaOfLYSgYePvOxRmunulU+Vrd2fW2MRJMktU799Ko8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXFUduoDN22+Mq0UB+3C+o9iV8mQYGUB5bUIS916QLmKgsPRKDDOwQ1FpwrQQMMib
         i8iQ5zBejVe3yVJKIZdG3gFiSvMOjbfNeL0Vk2mrGZNF+Z4zXqPpHeL65v81gyxjUM
         vTBCqhlHpIbVdtCvXy/4Wm5P8TlPaRyDJ7Zm24P6fcToMwVDUEw/eFn54bT7EtW0Uy
         Gw6ehLgngpTChIWhJUwhvrZnhNUvXdS9chH8BIHImVJrWFhTrzxlzhBas9PF4seuuH
         GK6D35iNLgvi3Xx6kXS9AIV0R/5uVQKGmK7G6jP5rPFK4CEi8fYXZ6aezm186hcocS
         9ZFiPCt1RhIPw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/7] habanalabs: convert ts to use unified memory manager
Date:   Thu, 24 Mar 2022 11:33:45 +0200
Message-Id: <20220324093349.3245973-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324093349.3245973-1-ogabbay@kernel.org>
References: <20220324093349.3245973-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

With the introduction of the unified memory manager infrastructure, the
timestamp buffers can be converted to use it.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  44 ++--
 drivers/misc/habanalabs/common/device.c       |   4 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  43 ++--
 .../misc/habanalabs/common/habanalabs_drv.c   |   4 +-
 drivers/misc/habanalabs/common/irq.c          |  10 +-
 drivers/misc/habanalabs/common/memory.c       | 221 +++---------------
 6 files changed, 91 insertions(+), 235 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 32051f05a05a..23370aa67bcd 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -957,9 +957,9 @@ wake_pending_user_interrupt_threads(struct hl_user_interrupt *interrupt)
 
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_for_each_entry_safe(pend, temp, &interrupt->wait_list_head, wait_list_node) {
-		if (pend->ts_reg_info.ts_buff) {
+		if (pend->ts_reg_info.buf) {
 			list_del(&pend->wait_list_node);
-			hl_ts_put(pend->ts_reg_info.ts_buff);
+			hl_mmap_mem_buf_put(pend->ts_reg_info.buf);
 			hl_cb_put(pend->ts_reg_info.cq_cb);
 		} else {
 			pend->fence.error = -EIO;
@@ -2867,12 +2867,13 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	return 0;
 }
 
-static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
+static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 					struct hl_cb *cq_cb,
 					u64 ts_offset, u64 cq_offset, u64 target_value,
 					spinlock_t *wait_list_lock,
 					struct hl_user_pending_interrupt **pend)
 {
+	struct hl_ts_buff *ts_buff = buf->private;
 	struct hl_user_pending_interrupt *requested_offset_record =
 				(struct hl_user_pending_interrupt *)ts_buff->kernel_buff_address +
 				ts_offset;
@@ -2884,7 +2885,7 @@ static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
 
 	/* Validate ts_offset not exceeding last max */
 	if (requested_offset_record > cb_last) {
-		dev_err(ts_buff->hdev->dev, "Ts offset exceeds max CB offset(0x%llx)\n",
+		dev_err(buf->mmg->dev, "Ts offset exceeds max CB offset(0x%llx)\n",
 								(u64)(uintptr_t)cb_last);
 		return -EINVAL;
 	}
@@ -2903,18 +2904,21 @@ static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
 			list_del(&requested_offset_record->wait_list_node);
 			spin_unlock_irqrestore(wait_list_lock, flags);
 
-			hl_ts_put(requested_offset_record->ts_reg_info.ts_buff);
+			hl_mmap_mem_buf_put(requested_offset_record->ts_reg_info.buf);
 			hl_cb_put(requested_offset_record->ts_reg_info.cq_cb);
 
-			dev_dbg(ts_buff->hdev->dev, "ts node removed from interrupt list now can re-use\n");
+			dev_dbg(buf->mmg->dev,
+				"ts node removed from interrupt list now can re-use\n");
 		} else {
-			dev_dbg(ts_buff->hdev->dev, "ts node in middle of irq handling\n");
+			dev_dbg(buf->mmg->dev,
+				"ts node in middle of irq handling\n");
 
 			/* irq handling in the middle give it time to finish */
 			spin_unlock_irqrestore(wait_list_lock, flags);
 			usleep_range(1, 10);
 			if (++iter_counter == MAX_TS_ITER_NUM) {
-				dev_err(ts_buff->hdev->dev, "handling registration interrupt took too long!!\n");
+				dev_err(buf->mmg->dev,
+					"handling registration interrupt took too long!!\n");
 				return -EINVAL;
 			}
 
@@ -2926,7 +2930,7 @@ static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
 
 	/* Fill up the new registration node info */
 	requested_offset_record->ts_reg_info.in_use = 1;
-	requested_offset_record->ts_reg_info.ts_buff = ts_buff;
+	requested_offset_record->ts_reg_info.buf = buf;
 	requested_offset_record->ts_reg_info.cq_cb = cq_cb;
 	requested_offset_record->ts_reg_info.timestamp_kernel_addr =
 			(u64 *) ts_buff->user_buff_address + ts_offset;
@@ -2936,13 +2940,13 @@ static int ts_buff_get_kernel_ts_record(struct hl_ts_buff *ts_buff,
 
 	*pend = requested_offset_record;
 
-	dev_dbg(ts_buff->hdev->dev, "Found available node in TS kernel CB(0x%llx)\n",
+	dev_dbg(buf->mmg->dev, "Found available node in TS kernel CB(0x%llx)\n",
 						(u64)(uintptr_t)requested_offset_record);
 	return 0;
 }
 
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				struct hl_cb_mgr *cb_mgr, struct hl_ts_mgr *ts_mgr,
+				struct hl_cb_mgr *cb_mgr, struct hl_mem_mgr *mmg,
 				u64 timeout_us, u64 cq_counters_handle,	u64 cq_counters_offset,
 				u64 target_value, struct hl_user_interrupt *interrupt,
 				bool register_ts_record, u64 ts_handle, u64 ts_offset,
@@ -2950,7 +2954,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 {
 	u32 cq_patched_handle, ts_patched_handle;
 	struct hl_user_pending_interrupt *pend;
-	struct hl_ts_buff *ts_buff;
+	struct hl_mmap_mem_buf *buf;
 	struct hl_cb *cq_cb;
 	unsigned long timeout, flags;
 	long completion_rc;
@@ -2971,15 +2975,21 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		dev_dbg(hdev->dev, "Timestamp registration: interrupt id: %u, ts offset: %llu, cq_offset: %llu\n",
 					interrupt->interrupt_id, ts_offset, cq_counters_offset);
 
+		/* TODO:
+		 * See if this can be removed.
+		 * Embedding type in handle will no longer be needed as soon as we
+		 * switch to using a single memory manager for all memory types.
+		 * We may still need the page shift, though.
+		 */
 		ts_patched_handle = lower_32_bits(ts_handle >> PAGE_SHIFT);
-		ts_buff = hl_ts_get(hdev, ts_mgr, ts_patched_handle);
-		if (!ts_buff) {
+		buf = hl_mmap_mem_buf_get(mmg, ts_patched_handle);
+		if (!buf) {
 			rc = -EINVAL;
 			goto put_cq_cb;
 		}
 
 		/* Find first available record */
-		rc = ts_buff_get_kernel_ts_record(ts_buff, cq_cb, ts_offset,
+		rc = ts_buff_get_kernel_ts_record(buf, cq_cb, ts_offset,
 						cq_counters_offset, target_value,
 						&interrupt->wait_list_lock, &pend);
 		if (rc)
@@ -3086,7 +3096,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 
 put_ts_buff:
-	hl_ts_put(ts_buff);
+	hl_mmap_mem_buf_put(buf);
 put_cq_cb:
 	hl_cb_put(cq_cb);
 put_ctx:
@@ -3248,7 +3258,7 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
 
 	if (args->in.flags & HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ)
-		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr, &hpriv->ts_mem_mgr,
+		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr, &hpriv->mem_mgr,
 				args->in.interrupt_timeout_us, args->in.cq_counters_handle,
 				args->in.cq_counters_offset,
 				args->in.target, interrupt,
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 3eb392b4308a..ef42646a9a3f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -149,7 +149,7 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
 	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
-	hl_ts_mgr_fini(hpriv->hdev, &hpriv->ts_mem_mgr);
+	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
 	hdev->compute_ctx_in_release = 1;
@@ -218,7 +218,7 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 		return hl_hw_block_mmap(hpriv, vma);
 
 	case HL_MMAP_TYPE_TS_BUFF:
-		return hl_ts_mmap(hpriv, vma);
+		return hl_mem_mgr_mmap(&hpriv->mem_mgr, vma, NULL);
 	}
 
 	return -EINVAL;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1859ace28783..a6c6d9fd30db 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -719,26 +719,14 @@ struct hl_ts_mgr {
 
 /**
  * struct hl_ts_buff - describes a timestamp buffer.
- * @refcount: reference counter for usage of the buffer.
- * @hdev: pointer to device this buffer belongs to.
- * @mmap: true if the buff is currently mapped to user.
  * @kernel_buff_address: Holds the internal buffer's kernel virtual address.
  * @user_buff_address: Holds the user buffer's kernel virtual address.
- * @id: the buffer ID.
- * @mmap_size: Holds the buffer size that was mmaped.
  * @kernel_buff_size: Holds the internal kernel buffer size.
- * @user_buff_size: Holds the user buffer size.
  */
 struct hl_ts_buff {
-	struct kref		refcount;
-	struct hl_device	*hdev;
-	atomic_t		mmap;
 	void			*kernel_buff_address;
 	void			*user_buff_address;
-	u32			id;
-	u32			mmap_size;
 	u32			kernel_buff_size;
-	u32			user_buff_size;
 };
 
 struct hl_mmap_mem_buf;
@@ -973,12 +961,12 @@ struct hl_user_interrupt {
  * struct timestamp_reg_free_node - holds the timestamp registration free objects node
  * @free_objects_node: node in the list free_obj_jobs
  * @cq_cb: pointer to cq command buffer to be freed
- * @ts_buff: pointer to timestamp buffer to be freed
+ * @buf: pointer to timestamp buffer to be freed
  */
 struct timestamp_reg_free_node {
 	struct list_head	free_objects_node;
 	struct hl_cb		*cq_cb;
-	struct hl_ts_buff	*ts_buff;
+	struct hl_mmap_mem_buf	*buf;
 };
 
 /* struct timestamp_reg_work_obj - holds the timestamp registration free objects job
@@ -995,8 +983,8 @@ struct timestamp_reg_work_obj {
 };
 
 /* struct timestamp_reg_info - holds the timestamp registration related data.
- * @ts_buff: pointer to the timestamp buffer which include both user/kernel buffers.
- *           relevant only when doing timestamps records registration.
+ * @buf: pointer to the timestamp buffer which include both user/kernel buffers.
+ *       relevant only when doing timestamps records registration.
  * @cq_cb: pointer to CQ counter CB.
  * @timestamp_kernel_addr: timestamp handle address, where to set timestamp
  *                         relevant only when doing timestamps records
@@ -1007,7 +995,7 @@ struct timestamp_reg_work_obj {
  *          allocating records dynamically.
  */
 struct timestamp_reg_info {
-	struct hl_ts_buff	*ts_buff;
+	struct hl_mmap_mem_buf	*buf;
 	struct hl_cb		*cq_cb;
 	u64			*timestamp_kernel_addr;
 	u8			in_use;
@@ -1966,7 +1954,7 @@ struct hl_debug_params {
  * @ctx: current executing context. TODO: remove for multiple ctx per process
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
- * @ts_mem_mgr: timestamp registration manager for alloc/free/map timestamp buffers.
+ * @mem_mgr: manager descriptor for memory exportable via mmap
  * @debugfs_list: list of relevant ASIC debugfs.
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
@@ -1979,7 +1967,7 @@ struct hl_fpriv {
 	struct hl_ctx		*ctx;
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
-	struct hl_ts_mgr	ts_mem_mgr;
+	struct hl_mem_mgr	mem_mgr;
 	struct list_head	debugfs_list;
 	struct list_head	dev_node;
 	struct kref		refcount;
@@ -3267,11 +3255,18 @@ __printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
 					const char *format, ...);
 char *hl_format_as_binary(char *buf, size_t buf_len, u32 n);
 const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
-void hl_ts_mgr_init(struct hl_ts_mgr *mgr);
-void hl_ts_mgr_fini(struct hl_device *hdev, struct hl_ts_mgr *mgr);
-int hl_ts_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
-struct hl_ts_buff *hl_ts_get(struct hl_device *hdev, struct hl_ts_mgr *mgr, u32 handle);
-void hl_ts_put(struct hl_ts_buff *buff);
+
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg);
+void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
+int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
+		    void *args);
+struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg,
+						   u32 handle);
+int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf);
+struct hl_mmap_mem_buf *
+hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
+		      struct hl_mmap_mem_buf_ops *behavior, gfp_t gfp,
+		      void *args);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 95c000d7dc26..28549d34d99c 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -140,7 +140,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
-	hl_ts_mgr_init(&hpriv->ts_mem_mgr);
+	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr);
 
 	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
@@ -198,7 +198,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
-	hl_ts_mgr_fini(hpriv->hdev, &hpriv->ts_mem_mgr);
+	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
 	mutex_destroy(&hpriv->restore_phase_mutex);
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index e2bc128f2291..5b5a992460c9 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -152,11 +152,11 @@ static void hl_ts_free_objects(struct work_struct *work)
 	struct hl_device *hdev = job->hdev;
 
 	list_for_each_entry_safe(free_obj, temp_free_obj, free_list_head, free_objects_node) {
-		dev_dbg(hdev->dev, "About to put refcount to ts_buff (%p) cq_cb(%p)\n",
-					free_obj->ts_buff,
+		dev_dbg(hdev->dev, "About to put refcount to buf (%p) cq_cb(%p)\n",
+					free_obj->buf,
 					free_obj->cq_cb);
 
-		hl_ts_put(free_obj->ts_buff);
+		hl_mmap_mem_buf_put(free_obj->buf);
 		hl_cb_put(free_obj->cq_cb);
 		kfree(free_obj);
 	}
@@ -210,7 +210,7 @@ static int handle_registration_node(struct hl_device *hdev, struct hl_user_pendi
 	/* Putting the refcount for ts_buff and cq_cb objects will be handled
 	 * in workqueue context, just add job to free_list.
 	 */
-	free_node->ts_buff = pend->ts_reg_info.ts_buff;
+	free_node->buf = pend->ts_reg_info.buf;
 	free_node->cq_cb = pend->ts_reg_info.cq_cb;
 	list_add(&free_node->free_objects_node, *free_list);
 
@@ -244,7 +244,7 @@ static void handle_user_cq(struct hl_device *hdev,
 	list_for_each_entry_safe(pend, temp_pend, &user_cq->wait_list_head, wait_list_node) {
 		if ((pend->cq_kernel_addr && *(pend->cq_kernel_addr) >= pend->cq_target_value) ||
 				!pend->cq_kernel_addr) {
-			if (pend->ts_reg_info.ts_buff) {
+			if (pend->ts_reg_info.buf) {
 				if (!reg_node_handle_fail) {
 					rc = handle_registration_node(hdev, pend,
 									&ts_reg_free_list_head);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 671633414504..a9bf1a5f4a86 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2076,164 +2076,34 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 	return rc;
 }
 
-static void ts_buff_release(struct kref *ref)
+static void ts_buff_release(struct hl_mmap_mem_buf *buf)
 {
-	struct hl_ts_buff *buff;
+	struct hl_ts_buff *ts_buff = buf->private;
 
-	buff = container_of(ref, struct hl_ts_buff, refcount);
-
-	vfree(buff->kernel_buff_address);
-	vfree(buff->user_buff_address);
-	kfree(buff);
-}
-
-struct hl_ts_buff *hl_ts_get(struct hl_device *hdev, struct hl_ts_mgr *mgr,
-					u32 handle)
-{
-	struct hl_ts_buff *buff;
-
-	spin_lock(&mgr->ts_lock);
-	buff = idr_find(&mgr->ts_handles, handle);
-	if (!buff) {
-		spin_unlock(&mgr->ts_lock);
-		dev_warn(hdev->dev,
-			"TS buff get failed, no match to handle 0x%x\n", handle);
-		return NULL;
-	}
-	kref_get(&buff->refcount);
-	spin_unlock(&mgr->ts_lock);
-
-	return buff;
-}
-
-void hl_ts_put(struct hl_ts_buff *buff)
-{
-	kref_put(&buff->refcount, ts_buff_release);
-}
-
-static void buff_vm_close(struct vm_area_struct *vma)
-{
-	struct hl_ts_buff *buff = (struct hl_ts_buff *) vma->vm_private_data;
-	long new_mmap_size;
-
-	new_mmap_size = buff->mmap_size - (vma->vm_end - vma->vm_start);
-
-	if (new_mmap_size > 0) {
-		buff->mmap_size = new_mmap_size;
-		return;
-	}
-
-	atomic_set(&buff->mmap, 0);
-	hl_ts_put(buff);
-	vma->vm_private_data = NULL;
+	vfree(ts_buff->kernel_buff_address);
+	vfree(ts_buff->user_buff_address);
+	kfree(ts_buff);
 }
 
-static const struct vm_operations_struct ts_buff_vm_ops = {
-	.close = buff_vm_close
-};
-
-int hl_ts_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+static int hl_ts_mmap(struct hl_mmap_mem_buf *buf, struct vm_area_struct *vma, void *args)
 {
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_ts_buff *buff;
-	u32 handle, user_buff_size;
-	int rc;
-
-	/* We use the page offset to hold the idr and thus we need to clear
-	 * it before doing the mmap itself
-	 */
-	handle = vma->vm_pgoff;
-	vma->vm_pgoff = 0;
-
-	buff = hl_ts_get(hdev, &hpriv->ts_mem_mgr, handle);
-	if (!buff) {
-		dev_err(hdev->dev,
-			"TS buff mmap failed, no match to handle 0x%x\n", handle);
-		return -EINVAL;
-	}
-
-	/* Validation check */
-	user_buff_size = vma->vm_end - vma->vm_start;
-	if (user_buff_size != ALIGN(buff->user_buff_size, PAGE_SIZE)) {
-		dev_err(hdev->dev,
-			"TS buff mmap failed, mmap size 0x%x != 0x%x buff size\n",
-			user_buff_size, ALIGN(buff->user_buff_size, PAGE_SIZE));
-		rc = -EINVAL;
-		goto put_buff;
-	}
-
-#ifdef _HAS_TYPE_ARG_IN_ACCESS_OK
-	if (!access_ok(VERIFY_WRITE,
-		(void __user *) (uintptr_t) vma->vm_start, user_buff_size)) {
-#else
-	if (!access_ok((void __user *) (uintptr_t) vma->vm_start,
-						user_buff_size)) {
-#endif
-		dev_err(hdev->dev,
-			"user pointer is invalid - 0x%lx\n",
-			vma->vm_start);
-
-		rc = -EINVAL;
-		goto put_buff;
-	}
-
-	if (atomic_cmpxchg(&buff->mmap, 0, 1)) {
-		dev_err(hdev->dev, "TS buff memory mmap failed, already mmaped to user\n");
-		rc = -EINVAL;
-		goto put_buff;
-	}
+	struct hl_ts_buff *ts_buff = buf->private;
 
-	vma->vm_ops = &ts_buff_vm_ops;
-	vma->vm_private_data = buff;
 	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP | VM_DONTCOPY | VM_NORESERVE;
-	rc = remap_vmalloc_range(vma, buff->user_buff_address, 0);
-	if (rc) {
-		atomic_set(&buff->mmap, 0);
-		goto put_buff;
-	}
-
-	buff->mmap_size = buff->user_buff_size;
-	vma->vm_pgoff = handle;
-
-	return 0;
-
-put_buff:
-	hl_ts_put(buff);
-	return rc;
-}
-
-void hl_ts_mgr_init(struct hl_ts_mgr *mgr)
-{
-	spin_lock_init(&mgr->ts_lock);
-	idr_init(&mgr->ts_handles);
-}
-
-void hl_ts_mgr_fini(struct hl_device *hdev, struct hl_ts_mgr *mgr)
-{
-	struct hl_ts_buff *buff;
-	struct idr *idp;
-	u32 id;
-
-	idp = &mgr->ts_handles;
-
-	idr_for_each_entry(idp, buff, id) {
-		if (kref_put(&buff->refcount, ts_buff_release) != 1)
-			dev_err(hdev->dev, "TS buff handle %d for CTX is still alive\n",
-							id);
-	}
-
-	idr_destroy(&mgr->ts_handles);
+	return remap_vmalloc_range(vma, ts_buff->user_buff_address, 0);
 }
 
-static struct hl_ts_buff *hl_ts_alloc_buff(struct hl_device *hdev, u32 num_elements)
+static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 {
 	struct hl_ts_buff *ts_buff = NULL;
-	u32 size;
+	u32 size, num_elements;
 	void *p;
 
+	num_elements = *(u32 *)args;
+
 	ts_buff = kzalloc(sizeof(*ts_buff), GFP_KERNEL);
 	if (!ts_buff)
-		return NULL;
+		return -ENOMEM;
 
 	/* Allocate the user buffer */
 	size = num_elements * sizeof(u64);
@@ -2242,7 +2112,7 @@ static struct hl_ts_buff *hl_ts_alloc_buff(struct hl_device *hdev, u32 num_eleme
 		goto free_mem;
 
 	ts_buff->user_buff_address = p;
-	ts_buff->user_buff_size = size;
+	buf->mappable_size = size;
 
 	/* Allocate the internal kernel buffer */
 	size = num_elements * sizeof(struct hl_user_pending_interrupt);
@@ -2253,15 +2123,23 @@ static struct hl_ts_buff *hl_ts_alloc_buff(struct hl_device *hdev, u32 num_eleme
 	ts_buff->kernel_buff_address = p;
 	ts_buff->kernel_buff_size = size;
 
-	return ts_buff;
+	buf->private = ts_buff;
+
+	return 0;
 
 free_user_buff:
 	vfree(ts_buff->user_buff_address);
 free_mem:
 	kfree(ts_buff);
-	return NULL;
+	return -ENOMEM;
 }
 
+struct hl_mmap_mem_buf_ops hl_ts_behavior = {
+	.mmap = hl_ts_mmap,
+	.alloc = hl_ts_alloc_buf,
+	.release = ts_buff_release,
+};
+
 /**
  * allocate_timestamps_buffers() - allocate timestamps buffers
  * This function will allocate ts buffer that will later on be mapped to the user
@@ -2278,54 +2156,27 @@ static struct hl_ts_buff *hl_ts_alloc_buff(struct hl_device *hdev, u32 num_eleme
  */
 static int allocate_timestamps_buffers(struct hl_fpriv *hpriv, struct hl_mem_in *args, u64 *handle)
 {
-	struct hl_ts_mgr *ts_mgr = &hpriv->ts_mem_mgr;
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_ts_buff *ts_buff;
-	int rc = 0;
+	struct hl_mem_mgr *mmg = &hpriv->mem_mgr;
+	struct hl_mmap_mem_buf *buf;
 
 	if (args->num_of_elements > TS_MAX_ELEMENTS_NUM) {
-		dev_err(hdev->dev, "Num of elements exceeds Max allowed number (0x%x > 0x%x)\n",
+		dev_err(mmg->dev, "Num of elements exceeds Max allowed number (0x%x > 0x%x)\n",
 				args->num_of_elements, TS_MAX_ELEMENTS_NUM);
 		return -EINVAL;
 	}
 
-	/* Allocate ts buffer object
-	 * This object will contain two buffers one that will be mapped to the user
-	 * and another internal buffer for the driver use only, which won't be mapped
-	 * to the user.
-	 */
-	ts_buff = hl_ts_alloc_buff(hdev, args->num_of_elements);
-	if (!ts_buff) {
-		rc = -ENOMEM;
-		goto out_err;
-	}
-
-	spin_lock(&ts_mgr->ts_lock);
-	rc = idr_alloc(&ts_mgr->ts_handles, ts_buff, 1, 0, GFP_ATOMIC);
-	spin_unlock(&ts_mgr->ts_lock);
-	if (rc < 0) {
-		dev_err(hdev->dev, "Failed to allocate IDR for a new ts buffer\n");
-		goto release_ts_buff;
-	}
-
-	ts_buff->id = rc;
-	ts_buff->hdev = hdev;
-
-	kref_init(&ts_buff->refcount);
-
-	/* idr is 32-bit so we can safely OR it with a mask that is above 32 bit */
-	*handle = (u64) ts_buff->id | HL_MMAP_TYPE_TS_BUFF;
-	*handle <<= PAGE_SHIFT;
+	buf = hl_mmap_mem_buf_alloc(mmg, &hl_ts_behavior, GFP_KERNEL, &args->num_of_elements);
+	if (!buf)
+		return -ENOMEM;
 
-	dev_dbg(hdev->dev, "Created ts buff object handle(%u)\n", ts_buff->id);
+	/* TODO:
+	 * Remove HL_MMAP_TYPE_TS_BUFF.
+	 * Embedding type in handle will no longer be needed as soon as we
+	 * switch to using a single memory manager for all memory types.
+	 */
+	*handle = ((u64)buf->handle | HL_MMAP_TYPE_TS_BUFF) << PAGE_SHIFT;
 
 	return 0;
-
-release_ts_buff:
-	kref_put(&ts_buff->refcount, ts_buff_release);
-out_err:
-	*handle = 0;
-	return rc;
 }
 
 int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
-- 
2.25.1

