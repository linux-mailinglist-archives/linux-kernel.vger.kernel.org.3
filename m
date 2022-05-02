Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE4516BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359281AbiEBIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383712AbiEBIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA203B012
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EFD660ECB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F43C385AF;
        Mon,  2 May 2022 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478754;
        bh=13tm6JeNVfLfUpR+NJlHymQGWGkCOsEh9w23Yb+IBJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=DeSi1ml1gIOLAymAio4jlQjrmZBIHRNI5MaXHxo7KXgozwg2tqyFiV5d9QpDLAmxM
         0ZM+UjTg1gxw2fF6BEWtVJNzRa8UDeGLvTAHPphgwW2OC49FLZeddJUOAVTSRIziHk
         mhwrP3VK1Ca1n7hS2TQ+zZBM9CbPkOiDLQ+UzAdMR8TqZhLSURvlNlFE0P/y5BrXAR
         ayP5jgB2YZNZrnaSY2XMzaNM2IPKJEZQKserNvtJaZ3UUH5HryVmQVgUI1KucHgvl/
         RdLr/d3eZmipAPFneErebm0hnOKp6fIpXFLjltD1nDfCZIJj18C8l20XCyaEaF/sZd
         Yc0xV3FZmVNtQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 1/6] habanalabs: hide memory manager page shift
Date:   Mon,  2 May 2022 11:05:44 +0300
Message-Id: <20220502080549.230411-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

The new unified memory manager uses page offset to pass buffer handle
during the mmap operation. One problem with this approach is that it
requires the handle to always be divisible by the page size, else, the
user would not be able to pass it correctly as an argument to the mmap
system call.

Previously, this was achieved by shifting the handle left after alloc
operation, and shifting it right before get operation. This was done in
the user code. This creates code duplication, and, what's worse,
requires some knowledge from the user regarding the handle internal
structure, hurting the encapsulation.

This patch encloses all the page shifts inside memory manager functions.
This way, the user can take the handle as a black box, and simply use
it, without any concert about how it actually works.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 12 ++-------
 drivers/misc/habanalabs/common/device.c       |  3 ++-
 drivers/misc/habanalabs/common/habanalabs.h   | 20 ++++++++------
 drivers/misc/habanalabs/common/memory.c       | 10 +++----
 drivers/misc/habanalabs/common/memory_mgr.c   | 27 +++++++++----------
 5 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 6c13ae3ffa7c..a189157be104 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2952,7 +2952,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				bool register_ts_record, u64 ts_handle, u64 ts_offset,
 				u32 *status, u64 *timestamp)
 {
-	u32 cq_patched_handle, ts_patched_handle;
+	u32 cq_patched_handle;
 	struct hl_user_pending_interrupt *pend;
 	struct hl_mmap_mem_buf *buf;
 	struct hl_cb *cq_cb;
@@ -2974,15 +2974,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	if (register_ts_record) {
 		dev_dbg(hdev->dev, "Timestamp registration: interrupt id: %u, ts offset: %llu, cq_offset: %llu\n",
 					interrupt->interrupt_id, ts_offset, cq_counters_offset);
-
-		/* TODO:
-		 * See if this can be removed.
-		 * Embedding type in handle will no longer be needed as soon as we
-		 * switch to using a single memory manager for all memory types.
-		 * We may still need the page shift, though.
-		 */
-		ts_patched_handle = lower_32_bits(ts_handle >> PAGE_SHIFT);
-		buf = hl_mmap_mem_buf_get(mmg, ts_patched_handle);
+		buf = hl_mmap_mem_buf_get(mmg, ts_handle);
 		if (!buf) {
 			rc = -EINVAL;
 			goto put_cq_cb;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 350cd61e06c1..bd74e0359473 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -384,13 +384,14 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 
 	vm_pgoff = vma->vm_pgoff;
-	vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
 
 	switch (vm_pgoff & HL_MMAP_TYPE_MASK) {
 	case HL_MMAP_TYPE_CB:
+		vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
 		return hl_cb_mmap(hpriv, vma);
 
 	case HL_MMAP_TYPE_BLOCK:
+		vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
 		return hl_hw_block_mmap(hpriv, vma);
 
 	case HL_MMAP_TYPE_TS_BUFF:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 19f6af59cfc9..ea5cfea21a2c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -750,21 +750,25 @@ struct hl_mem_mgr {
 };
 
 /**
- * struct hl_mmap_mem_buf_ops - describes unified memory manager buffer behavior
+ * struct hl_mmap_mem_buf_behavior - describes unified memory manager buffer behavior
+ * @mem_id: memory type identifier, embedded in the handle and used to identify
+ *          the memory type by handle.
  * @alloc: callback executed on buffer allocation, shall allocate the memory,
  *         set it under buffer private, and set mappable size.
  * @mmap: callback executed on mmap, must map the buffer to vma
  * @release: callback executed on release, must free the resources used by the buffer
  */
-struct hl_mmap_mem_buf_ops {
+struct hl_mmap_mem_buf_behavior {
+	u64 mem_id;
+
 	int (*alloc)(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args);
 	int (*mmap)(struct hl_mmap_mem_buf *buf, struct vm_area_struct *vma, void *args);
 	void (*release)(struct hl_mmap_mem_buf *buf);
 };
 
 /**
- * struct hl_mmap_mem_buf_ops - describes a single unified memory buffer
- * @ops: buffer behavior
+ * struct hl_mmap_mem_buf - describes a single unified memory buffer
+ * @behavior: buffer behavior
  * @mmg: back pointer to the unified memory manager
  * @refcount: reference counter for buffer users
  * @private: pointer to buffer behavior private data
@@ -776,14 +780,14 @@ struct hl_mmap_mem_buf_ops {
  * @handle: the buffer id in mmg handles store
  */
 struct hl_mmap_mem_buf {
-	struct hl_mmap_mem_buf_ops *ops;
+	struct hl_mmap_mem_buf_behavior *behavior;
 	struct hl_mem_mgr *mmg;
 	struct kref refcount;
 	void *private;
 	atomic_t mmap;
 	u64 real_mapped_size;
 	u64 mappable_size;
-	u32 handle;
+	u64 handle;
 };
 
 /**
@@ -3288,11 +3292,11 @@ void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
 int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
 struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg,
-						   u32 handle);
+						   u64 handle);
 int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf);
 struct hl_mmap_mem_buf *
 hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
-		      struct hl_mmap_mem_buf_ops *behavior, gfp_t gfp,
+		      struct hl_mmap_mem_buf_behavior *behavior, gfp_t gfp,
 		      void *args);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 6face45c57e3..e7a0c44c487d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2140,7 +2140,8 @@ static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 	return -ENOMEM;
 }
 
-static struct hl_mmap_mem_buf_ops hl_ts_behavior = {
+static struct hl_mmap_mem_buf_behavior hl_ts_behavior = {
+	.mem_id = HL_MMAP_TYPE_TS_BUFF,
 	.mmap = hl_ts_mmap,
 	.alloc = hl_ts_alloc_buf,
 	.release = ts_buff_release,
@@ -2175,12 +2176,7 @@ static int allocate_timestamps_buffers(struct hl_fpriv *hpriv, struct hl_mem_in
 	if (!buf)
 		return -ENOMEM;
 
-	/* TODO:
-	 * Remove HL_MMAP_TYPE_TS_BUFF.
-	 * Embedding type in handle will no longer be needed as soon as we
-	 * switch to using a single memory manager for all memory types.
-	 */
-	*handle = ((u64)buf->handle | HL_MMAP_TYPE_TS_BUFF) << PAGE_SHIFT;
+	*handle = buf->handle;
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 1bc23362e61d..1cc2f2ebe3b6 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -17,16 +17,16 @@
  * @return Find the buffer in the store and return a pointer to its descriptor.
  *         Increase buffer refcount. If not found - return NULL.
  */
-struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u32 handle)
+struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u64 handle)
 {
 	struct hl_mmap_mem_buf *buf;
 
 	spin_lock(&mmg->lock);
-	buf = idr_find(&mmg->handles, handle);
+	buf = idr_find(&mmg->handles, lower_32_bits(handle >> PAGE_SHIFT));
 	if (!buf) {
 		spin_unlock(&mmg->lock);
 		dev_warn(mmg->dev,
-			 "Buff get failed, no match to handle %u\n", handle);
+			 "Buff get failed, no match to handle %llu\n", handle);
 		return NULL;
 	}
 	kref_get(&buf->refcount);
@@ -51,8 +51,8 @@ static void hl_mmap_mem_buf_release(struct kref *kref)
 	idr_remove(&buf->mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
 	spin_unlock(&buf->mmg->lock);
 
-	if (buf->ops->release)
-		buf->ops->release(buf);
+	if (buf->behavior->release)
+		buf->behavior->release(buf);
 
 	kfree(buf);
 }
@@ -83,7 +83,7 @@ int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf)
  */
 struct hl_mmap_mem_buf *
 hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
-		      struct hl_mmap_mem_buf_ops *behavior, gfp_t gfp,
+		      struct hl_mmap_mem_buf_behavior *behavior, gfp_t gfp,
 		      void *args)
 {
 	struct hl_mmap_mem_buf *buf;
@@ -102,19 +102,18 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		goto free_buf;
 	}
 
-	buf->handle = rc;
 	buf->mmg = mmg;
-	buf->ops = behavior;
+	buf->behavior = behavior;
+	buf->handle = (((u64)rc | buf->behavior->mem_id) << PAGE_SHIFT);
 	kref_init(&buf->refcount);
 
-	rc = buf->ops->alloc(buf, gfp, args);
+	rc = buf->behavior->alloc(buf, gfp, args);
 	if (rc) {
 		dev_err(mmg->dev, "Failure in buffer alloc callback %d\n",
 			rc);
 		goto remove_idr;
 	}
 
-	dev_dbg(mmg->dev, "Created buff object handle %u\n", buf->handle);
 	return buf;
 
 remove_idr:
@@ -169,20 +168,20 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 {
 	struct hl_mmap_mem_buf *buf;
 	u64 user_mem_size;
-	u32 handle;
+	u64 handle;
 	int rc;
 
 	/* We use the page offset to hold the idr and thus we need to clear
 	 * it before doing the mmap itself
 	 */
-	handle = vma->vm_pgoff;
+	handle = vma->vm_pgoff << PAGE_SHIFT;
 	vma->vm_pgoff = 0;
 
 	/* Reference was taken here */
 	buf = hl_mmap_mem_buf_get(mmg, handle);
 	if (!buf) {
 		dev_err(mmg->dev,
-			"Memory mmap failed, no match to handle %u\n", handle);
+			"Memory mmap failed, no match to handle %llu\n", handle);
 		return -EINVAL;
 	}
 
@@ -223,7 +222,7 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 
 	vma->vm_private_data = buf;
 
-	rc = buf->ops->mmap(buf, vma, args);
+	rc = buf->behavior->mmap(buf, vma, args);
 	if (rc) {
 		atomic_set(&buf->mmap, 0);
 		goto put_mem;
-- 
2.25.1

