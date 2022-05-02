Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D522516BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359255AbiEBILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383716AbiEBIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EAE3BBDD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968BA60ECB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC498C385AC;
        Mon,  2 May 2022 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478761;
        bh=1FXjsuFFfKNhIw0p85foFcp0ciuwVZqlX801++8OM04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khpcnRs7aJ6zsxrCVlDewc8oStWGEqsFDJTwIgeIlATEXFU7WGiR9k8LX1vnlqZzS
         n5/dOBvw9g5GdcDqipEsqwm4tHM2lPWCuw4N+UfzZSRP1DiMUXLu6TKgdQR+A0SIkB
         lv90zK4xwJ+/RX6Ji82uf6n9rkPXZmuNkIuu1fyQSiOA+qZ4iLoj8sqK+HDzriDq4e
         5ZKQ5nb3V76cfWa7CelwcaymQf4MhbNe43oYVgW20PwHfydXC4tsyYsnLt6XSkrAy1
         O4/lfuvvZ+HedhcHevlq3AOFvOOJCV1lGNx/lccPvXGzc/J9idyNOS5cJHJluV3dOg
         aWh36FWpwLSpg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 5/6] habanalabs: use unified memory manager for CB flow
Date:   Mon,  2 May 2022 11:05:48 +0300
Message-Id: <20220502080549.230411-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502080549.230411-1-ogabbay@kernel.org>
References: <20220502080549.230411-1-ogabbay@kernel.org>
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

With the new code required for the flow added, we can now switch
to using the new memory manager infrastructure, removing the old code.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 362 ++----------------
 .../habanalabs/common/command_submission.c    |  21 +-
 drivers/misc/habanalabs/common/debugfs.c      |   6 +-
 drivers/misc/habanalabs/common/device.c       |  12 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  47 +--
 .../misc/habanalabs/common/habanalabs_drv.c   |   2 -
 drivers/misc/habanalabs/gaudi/gaudi.c         |  42 +-
 drivers/misc/habanalabs/goya/goya.c           |  34 +-
 8 files changed, 72 insertions(+), 454 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index a2a97f4876bd..fd9ef32ea6a0 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -160,24 +160,6 @@ static void cb_do_release(struct hl_device *hdev, struct hl_cb *cb)
 	}
 }
 
-static void cb_release(struct kref *ref)
-{
-	struct hl_device *hdev;
-	struct hl_cb *cb;
-
-	cb = container_of(ref, struct hl_cb, refcount);
-	hdev = cb->hdev;
-
-	hl_debugfs_remove_cb(cb);
-
-	if (cb->is_mmu_mapped)
-		cb_unmap_mem(cb->ctx, cb);
-
-	hl_ctx_put(cb->ctx);
-
-	cb_do_release(hdev, cb);
-}
-
 static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 					int ctx_id, bool internal_cb)
 {
@@ -238,146 +220,6 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 	return cb;
 }
 
-int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
-			bool map_cb, u64 *handle)
-{
-	struct hl_cb *cb;
-	bool alloc_new_cb = true;
-	int rc, ctx_id = ctx->asid;
-
-	/*
-	 * Can't use generic function to check this because of special case
-	 * where we create a CB as part of the reset process
-	 */
-	if ((hdev->disabled) || (hdev->reset_info.in_reset && (ctx_id != HL_KERNEL_ASID_ID))) {
-		dev_warn_ratelimited(hdev->dev,
-			"Device is disabled or in reset. Can't create new CBs\n");
-		rc = -EBUSY;
-		goto out_err;
-	}
-
-	if (cb_size > SZ_2M) {
-		dev_err(hdev->dev, "CB size %d must be less than %d\n",
-			cb_size, SZ_2M);
-		rc = -EINVAL;
-		goto out_err;
-	}
-
-	if (!internal_cb) {
-		/* Minimum allocation must be PAGE SIZE */
-		if (cb_size < PAGE_SIZE)
-			cb_size = PAGE_SIZE;
-
-		if (ctx_id == HL_KERNEL_ASID_ID &&
-				cb_size <= hdev->asic_prop.cb_pool_cb_size) {
-
-			spin_lock(&hdev->cb_pool_lock);
-			if (!list_empty(&hdev->cb_pool)) {
-				cb = list_first_entry(&hdev->cb_pool,
-						typeof(*cb), pool_list);
-				list_del(&cb->pool_list);
-				spin_unlock(&hdev->cb_pool_lock);
-				alloc_new_cb = false;
-			} else {
-				spin_unlock(&hdev->cb_pool_lock);
-				dev_dbg(hdev->dev, "CB pool is empty\n");
-			}
-		}
-	}
-
-	if (alloc_new_cb) {
-		cb = hl_cb_alloc(hdev, cb_size, ctx_id, internal_cb);
-		if (!cb) {
-			rc = -ENOMEM;
-			goto out_err;
-		}
-	}
-
-	cb->hdev = hdev;
-	cb->ctx = ctx;
-	hl_ctx_get(hdev, cb->ctx);
-
-	if (map_cb) {
-		if (ctx_id == HL_KERNEL_ASID_ID) {
-			dev_err(hdev->dev,
-				"CB mapping is not supported for kernel context\n");
-			rc = -EINVAL;
-			goto release_cb;
-		}
-
-		rc = cb_map_mem(ctx, cb);
-		if (rc)
-			goto release_cb;
-	}
-
-	spin_lock(&mgr->cb_lock);
-	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
-	spin_unlock(&mgr->cb_lock);
-
-	if (rc < 0) {
-		dev_err(hdev->dev, "Failed to allocate IDR for a new CB\n");
-		goto unmap_mem;
-	}
-
-	cb->id = (u64) rc;
-
-	kref_init(&cb->refcount);
-	spin_lock_init(&cb->lock);
-
-	/*
-	 * idr is 32-bit so we can safely OR it with a mask that is above
-	 * 32 bit
-	 */
-	*handle = cb->id | HL_MMAP_TYPE_CB;
-	*handle <<= PAGE_SHIFT;
-
-	hl_debugfs_add_cb(cb);
-
-	return 0;
-
-unmap_mem:
-	if (cb->is_mmu_mapped)
-		cb_unmap_mem(cb->ctx, cb);
-release_cb:
-	hl_ctx_put(cb->ctx);
-	cb_do_release(hdev, cb);
-out_err:
-	*handle = 0;
-
-	return rc;
-}
-
-int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle)
-{
-	struct hl_cb *cb;
-	u32 handle;
-	int rc = 0;
-
-	/*
-	 * handle was given to user to do mmap, I need to shift it back to
-	 * how the idr module gave it to me
-	 */
-	cb_handle >>= PAGE_SHIFT;
-	handle = (u32) cb_handle;
-
-	spin_lock(&mgr->cb_lock);
-
-	cb = idr_find(&mgr->cb_handles, handle);
-	if (cb) {
-		idr_remove(&mgr->cb_handles, handle);
-		spin_unlock(&mgr->cb_lock);
-		kref_put(&cb->refcount, cb_release);
-	} else {
-		spin_unlock(&mgr->cb_lock);
-		dev_err(hdev->dev,
-			"CB destroy failed, no match to handle 0x%x\n", handle);
-		rc = -EINVAL;
-	}
-
-	return rc;
-}
-
 struct hl_cb_mmap_mem_alloc_args {
 	struct hl_device *hdev;
 	struct hl_ctx *ctx;
@@ -467,7 +309,7 @@ static int hl_cb_mmap_mem_alloc(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *ar
 	return rc;
 }
 
-static int hl_cb_mmap_unified_mem_mgr(struct hl_mmap_mem_buf *buf,
+static int hl_cb_mmap(struct hl_mmap_mem_buf *buf,
 				      struct vm_area_struct *vma, void *args)
 {
 	struct hl_cb *cb = buf->private;
@@ -480,10 +322,10 @@ static struct hl_mmap_mem_buf_behavior cb_behavior = {
 	.mem_id = HL_MMAP_TYPE_CB,
 	.alloc = hl_cb_mmap_mem_alloc,
 	.release = hl_cb_mmap_mem_release,
-	.mmap = hl_cb_mmap_unified_mem_mgr,
+	.mmap = hl_cb_mmap,
 };
 
-int hl_cb_create_unified_mem_mgr(struct hl_device *hdev, struct hl_mem_mgr *mmg,
+int hl_cb_create(struct hl_device *hdev, struct hl_mem_mgr *mmg,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
 			bool map_cb, u64 *handle)
 {
@@ -520,7 +362,7 @@ int hl_cb_create_unified_mem_mgr(struct hl_device *hdev, struct hl_mem_mgr *mmg,
 	return 0;
 }
 
-int hl_cb_destroy_unified_mem_mgr(struct hl_mem_mgr *mmg, u64 cb_handle)
+int hl_cb_destroy(struct hl_mem_mgr *mmg, u64 cb_handle)
 {
 	int rc;
 
@@ -529,33 +371,23 @@ int hl_cb_destroy_unified_mem_mgr(struct hl_mem_mgr *mmg, u64 cb_handle)
 		return rc; /* Invalid handle */
 
 	if (rc == 0)
-		dev_warn(mmg->dev, "CB 0x%llx is destroyed while still in use\n", cb_handle);
+		dev_dbg(mmg->dev, "CB 0x%llx is destroyed while still in use\n", cb_handle);
 
 	return 0;
 }
 
-static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			u64 cb_handle, u32 flags, u32 *usage_cnt, u64 *device_va)
+static int hl_cb_info(struct hl_mem_mgr *mmg,
+			u64 handle, u32 flags, u32 *usage_cnt, u64 *device_va)
 {
 	struct hl_vm_va_block *va_block;
 	struct hl_cb *cb;
-	u32 handle;
 	int rc = 0;
 
-	/* The CB handle was given to user to do mmap, so need to shift it back
-	 * to the value which was allocated by the IDR module.
-	 */
-	cb_handle >>= PAGE_SHIFT;
-	handle = (u32) cb_handle;
-
-	spin_lock(&mgr->cb_lock);
-
-	cb = idr_find(&mgr->cb_handles, handle);
+	cb = hl_cb_get(mmg, handle);
 	if (!cb) {
-		dev_err(hdev->dev,
-			"CB info failed, no match to handle 0x%x\n", handle);
-		rc = -EINVAL;
-		goto out;
+		dev_err(mmg->dev,
+			"CB info failed, no match to handle 0x%llx\n", handle);
+		return -EINVAL;
 	}
 
 	if (flags & HL_CB_FLAGS_GET_DEVICE_VA) {
@@ -563,7 +395,7 @@ static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 		if (va_block) {
 			*device_va = va_block->start;
 		} else {
-			dev_err(hdev->dev, "CB is not mapped to the device's MMU\n");
+			dev_err(mmg->dev, "CB is not mapped to the device's MMU\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -572,7 +404,7 @@ static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	}
 
 out:
-	spin_unlock(&mgr->cb_lock);
+	hl_cb_put(cb);
 	return rc;
 }
 
@@ -600,7 +432,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.cb_size, HL_MAX_CB_SIZE);
 			rc = -EINVAL;
 		} else {
-			rc = hl_cb_create(hdev, &hpriv->cb_mgr, hpriv->ctx,
+			rc = hl_cb_create(hdev, &hpriv->mem_mgr, hpriv->ctx,
 					args->in.cb_size, false,
 					!!(args->in.flags & HL_CB_FLAGS_MAP),
 					&handle);
@@ -611,12 +443,12 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_CB_OP_DESTROY:
-		rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
+		rc = hl_cb_destroy(&hpriv->mem_mgr,
 					args->in.cb_handle);
 		break;
 
 	case HL_CB_OP_INFO:
-		rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
+		rc = hl_cb_info(&hpriv->mem_mgr, args->in.cb_handle,
 				args->in.flags,
 				&usage_cnt,
 				&device_va);
@@ -639,163 +471,20 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
-static void cb_vm_close(struct vm_area_struct *vma)
-{
-	struct hl_cb *cb = (struct hl_cb *) vma->vm_private_data;
-	long new_mmap_size;
-
-	new_mmap_size = cb->mmap_size - (vma->vm_end - vma->vm_start);
-
-	if (new_mmap_size > 0) {
-		cb->mmap_size = new_mmap_size;
-		return;
-	}
-
-	spin_lock(&cb->lock);
-	cb->mmap = false;
-	spin_unlock(&cb->lock);
-
-	hl_cb_put(cb);
-	vma->vm_private_data = NULL;
-}
-
-static const struct vm_operations_struct cb_vm_ops = {
-	.close = cb_vm_close
-};
-
-int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+struct hl_cb *hl_cb_get(struct hl_mem_mgr *mmg, u64 handle)
 {
-	struct hl_device *hdev = hpriv->hdev;
-	struct hl_cb *cb;
-	u32 handle, user_cb_size;
-	int rc;
-
-	/* We use the page offset to hold the idr and thus we need to clear
-	 * it before doing the mmap itself
-	 */
-	handle = vma->vm_pgoff;
-	vma->vm_pgoff = 0;
-
-	/* reference was taken here */
-	cb = hl_cb_get(hdev, &hpriv->cb_mgr, handle);
-	if (!cb) {
-		dev_err(hdev->dev,
-			"CB mmap failed, no match to handle 0x%x\n", handle);
-		return -EINVAL;
-	}
-
-	/* Validation check */
-	user_cb_size = vma->vm_end - vma->vm_start;
-	if (user_cb_size != ALIGN(cb->size, PAGE_SIZE)) {
-		dev_err(hdev->dev,
-			"CB mmap failed, mmap size 0x%lx != 0x%x cb size\n",
-			vma->vm_end - vma->vm_start, cb->size);
-		rc = -EINVAL;
-		goto put_cb;
-	}
-
-	if (!access_ok((void __user *) (uintptr_t) vma->vm_start,
-							user_cb_size)) {
-		dev_err(hdev->dev,
-			"user pointer is invalid - 0x%lx\n",
-			vma->vm_start);
-
-		rc = -EINVAL;
-		goto put_cb;
-	}
-
-	spin_lock(&cb->lock);
-
-	if (cb->mmap) {
-		dev_err(hdev->dev,
-			"CB mmap failed, CB already mmaped to user\n");
-		rc = -EINVAL;
-		goto release_lock;
-	}
-
-	cb->mmap = true;
-
-	spin_unlock(&cb->lock);
-
-	vma->vm_ops = &cb_vm_ops;
-
-	/*
-	 * Note: We're transferring the cb reference to
-	 * vma->vm_private_data here.
-	 */
-
-	vma->vm_private_data = cb;
-
-	rc = hdev->asic_funcs->mmap(hdev, vma, cb->kernel_address,
-					cb->bus_address, cb->size);
-	if (rc) {
-		spin_lock(&cb->lock);
-		cb->mmap = false;
-		goto release_lock;
-	}
-
-	cb->mmap_size = cb->size;
-	vma->vm_pgoff = handle;
-
-	return 0;
-
-release_lock:
-	spin_unlock(&cb->lock);
-put_cb:
-	hl_cb_put(cb);
-	return rc;
-}
-
-struct hl_cb *hl_cb_get(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			u32 handle)
-{
-	struct hl_cb *cb;
-
-	spin_lock(&mgr->cb_lock);
-	cb = idr_find(&mgr->cb_handles, handle);
+	struct hl_mmap_mem_buf *buf;
 
-	if (!cb) {
-		spin_unlock(&mgr->cb_lock);
-		dev_warn(hdev->dev,
-			"CB get failed, no match to handle 0x%x\n", handle);
+	buf = hl_mmap_mem_buf_get(mmg, handle);
+	if (!buf)
 		return NULL;
-	}
-
-	kref_get(&cb->refcount);
-
-	spin_unlock(&mgr->cb_lock);
-
-	return cb;
+	return buf->private;
 
 }
 
 void hl_cb_put(struct hl_cb *cb)
 {
-	kref_put(&cb->refcount, cb_release);
-}
-
-void hl_cb_mgr_init(struct hl_cb_mgr *mgr)
-{
-	spin_lock_init(&mgr->cb_lock);
-	idr_init(&mgr->cb_handles);
-}
-
-void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr)
-{
-	struct hl_cb *cb;
-	struct idr *idp;
-	u32 id;
-
-	idp = &mgr->cb_handles;
-
-	idr_for_each_entry(idp, cb, id) {
-		if (kref_put(&cb->refcount, cb_release) != 1)
-			dev_err(hdev->dev,
-				"CB %d for CTX ID %d is still alive\n",
-				id, cb->ctx->asid);
-	}
-
-	idr_destroy(&mgr->cb_handles);
+	hl_mmap_mem_buf_put(cb->buf);
 }
 
 struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
@@ -805,7 +494,7 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 	struct hl_cb *cb;
 	int rc;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx, cb_size,
+	rc = hl_cb_create(hdev, &hdev->kernel_mem_mgr, hdev->kernel_ctx, cb_size,
 				internal_cb, false, &cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
@@ -813,8 +502,7 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 		return NULL;
 	}
 
-	cb_handle >>= PAGE_SHIFT;
-	cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr, (u32) cb_handle);
+	cb = hl_cb_get(&hdev->kernel_mem_mgr, cb_handle);
 	/* hl_cb_get should never fail here */
 	if (!cb) {
 		dev_crit(hdev->dev, "Kernel CB handle invalid 0x%x\n",
@@ -825,7 +513,7 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 	return cb;
 
 destroy_cb:
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb_handle << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb_handle);
 
 	return NULL;
 }
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a189157be104..41206c5d6e7b 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1071,17 +1071,14 @@ static int validate_queue_index(struct hl_device *hdev,
 }
 
 static struct hl_cb *get_cb_from_cs_chunk(struct hl_device *hdev,
-					struct hl_cb_mgr *cb_mgr,
+					struct hl_mem_mgr *mmg,
 					struct hl_cs_chunk *chunk)
 {
 	struct hl_cb *cb;
-	u32 cb_handle;
 
-	cb_handle = (u32) (chunk->cb_handle >> PAGE_SHIFT);
-
-	cb = hl_cb_get(hdev, cb_mgr, cb_handle);
+	cb = hl_cb_get(mmg, chunk->cb_handle);
 	if (!cb) {
-		dev_err(hdev->dev, "CB handle 0x%x invalid\n", cb_handle);
+		dev_err(hdev->dev, "CB handle 0x%llx invalid\n", chunk->cb_handle);
 		return NULL;
 	}
 
@@ -1343,7 +1340,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		}
 
 		if (is_kernel_allocated_cb) {
-			cb = get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
+			cb = get_cb_from_cs_chunk(hdev, &hpriv->mem_mgr, chunk);
 			if (!cb) {
 				atomic64_inc(
 					&ctx->cs_counters.validation_drop_cnt);
@@ -1771,7 +1768,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	 */
 	job->patched_cb = job->user_cb;
 	job->job_cb_size = job->user_cb_size;
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	/* increment refcount as for external queues we get completion */
 	cs_get(cs);
@@ -2946,13 +2943,12 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 }
 
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				struct hl_cb_mgr *cb_mgr, struct hl_mem_mgr *mmg,
+				struct hl_mem_mgr *cb_mmg, struct hl_mem_mgr *mmg,
 				u64 timeout_us, u64 cq_counters_handle,	u64 cq_counters_offset,
 				u64 target_value, struct hl_user_interrupt *interrupt,
 				bool register_ts_record, u64 ts_handle, u64 ts_offset,
 				u32 *status, u64 *timestamp)
 {
-	u32 cq_patched_handle;
 	struct hl_user_pending_interrupt *pend;
 	struct hl_mmap_mem_buf *buf;
 	struct hl_cb *cq_cb;
@@ -2964,8 +2960,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_ctx_get(hdev, ctx);
 
-	cq_patched_handle = lower_32_bits(cq_counters_handle >> PAGE_SHIFT);
-	cq_cb = hl_cb_get(hdev, cb_mgr, cq_patched_handle);
+	cq_cb = hl_cb_get(cb_mmg, cq_counters_handle);
 	if (!cq_cb) {
 		rc = -EINVAL;
 		goto put_ctx;
@@ -3250,7 +3245,7 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
 
 	if (args->in.flags & HL_WAIT_CS_FLAGS_INTERRUPT_KERNEL_CQ)
-		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->cb_mgr, &hpriv->mem_mgr,
+		rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx, &hpriv->mem_mgr, &hpriv->mem_mgr,
 				args->in.interrupt_timeout_us, args->in.cq_counters_handle,
 				args->in.cq_counters_offset,
 				args->in.target, interrupt,
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index a94f01713efd..a9c4f2d4139d 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -126,9 +126,9 @@ static int command_buffers_show(struct seq_file *s, void *data)
 		}
 		seq_printf(s,
 			"   %03llu        %d    0x%08x      %d          %d          %d\n",
-			cb->id, cb->ctx->asid, cb->size,
-			kref_read(&cb->refcount),
-			cb->mmap, atomic_read(&cb->cs_cnt));
+			cb->buf->handle, cb->ctx->asid, cb->size,
+			kref_read(&cb->buf->refcount),
+			atomic_read(&cb->buf->mmap), atomic_read(&cb->cs_cnt));
 	}
 
 	spin_unlock(&dev_entry->cb_spinlock);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bd74e0359473..dbec98736a31 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -324,7 +324,6 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	 */
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
-	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
@@ -386,14 +385,11 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 	vm_pgoff = vma->vm_pgoff;
 
 	switch (vm_pgoff & HL_MMAP_TYPE_MASK) {
-	case HL_MMAP_TYPE_CB:
-		vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
-		return hl_cb_mmap(hpriv, vma);
-
 	case HL_MMAP_TYPE_BLOCK:
 		vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
 		return hl_hw_block_mmap(hpriv, vma);
 
+	case HL_MMAP_TYPE_CB:
 	case HL_MMAP_TYPE_TS_BUFF:
 		return hl_mem_mgr_mmap(&hpriv->mem_mgr, vma, NULL);
 	}
@@ -616,7 +612,7 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_chip_info;
 
-	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
+	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
 
 	hdev->device_reset_work.wq =
 			create_singlethread_workqueue("hl_device_reset");
@@ -645,7 +641,7 @@ static int device_early_init(struct hl_device *hdev)
 	return 0;
 
 free_cb_mgr:
-	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
+	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
 free_ts_free_wq:
@@ -684,7 +680,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	mutex_destroy(&hdev->clk_throttling.lock);
 
-	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
+	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
 
 	kfree(hdev->hl_chip_info);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 47a5baf652b7..496d61ee07c5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -703,26 +703,6 @@ struct hl_cs_compl {
  * Command Buffers
  */
 
-/**
- * struct hl_cb_mgr - describes a Command Buffer Manager.
- * @cb_lock: protects cb_handles.
- * @cb_handles: an idr to hold all command buffer handles.
- */
-struct hl_cb_mgr {
-	spinlock_t		cb_lock;
-	struct idr		cb_handles; /* protected by cb_lock */
-};
-
-/**
- * struct hl_ts_mgr - describes the timestamp registration memory manager.
- * @ts_lock: protects ts_handles.
- * @ts_handles: an idr to hold all ts bufferes handles.
- */
-struct hl_ts_mgr {
-	spinlock_t		ts_lock;
-	struct idr		ts_handles;
-};
-
 /**
  * struct hl_ts_buff - describes a timestamp buffer.
  * @kernel_buff_address: Holds the internal buffer's kernel virtual address.
@@ -792,42 +772,32 @@ struct hl_mmap_mem_buf {
 
 /**
  * struct hl_cb - describes a Command Buffer.
- * @refcount: reference counter for usage of the CB.
  * @hdev: pointer to device this CB belongs to.
  * @ctx: pointer to the CB owner's context.
- * @lock: spinlock to protect mmap flows.
  * @buf: back pointer to the parent mappable memory buffer
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
  * @va_block_list: list of virtual addresses blocks of the CB if it is mapped to
  *                 the device's MMU.
- * @id: the CB's ID.
  * @kernel_address: Holds the CB's kernel virtual address.
  * @bus_address: Holds the CB's DMA address.
- * @mmap_size: Holds the CB's size that was mmaped.
  * @size: holds the CB's size.
  * @cs_cnt: holds number of CS that this CB participates in.
- * @mmap: true if the CB is currently mmaped to user.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
  * @is_internal: internaly allocated
  * @is_mmu_mapped: true if the CB is mapped to the device's MMU.
  */
 struct hl_cb {
-	struct kref		refcount;
 	struct hl_device	*hdev;
 	struct hl_ctx		*ctx;
-	spinlock_t		lock;
 	struct hl_mmap_mem_buf	*buf;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
 	struct list_head	va_block_list;
-	u64			id;
 	void			*kernel_address;
 	dma_addr_t		bus_address;
-	u32			mmap_size;
 	u32			size;
 	atomic_t		cs_cnt;
-	u8			mmap;
 	u8			is_pool;
 	u8			is_internal;
 	u8			is_mmu_mapped;
@@ -1982,7 +1952,6 @@ struct hl_fpriv {
 	struct pid		*taskpid;
 	struct hl_ctx		*ctx;
 	struct hl_ctx_mgr	ctx_mgr;
-	struct hl_cb_mgr	cb_mgr;
 	struct hl_mem_mgr	mem_mgr;
 	struct list_head	debugfs_list;
 	struct list_head	dev_node;
@@ -2663,7 +2632,6 @@ struct hl_reset_info {
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
  * @cs_mirror_lock: protects cs_mirror_list.
- * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CBs.
  * @kernel_mem_mgr: memory manager for memory buffers with lifespan of driver.
  * @event_queue: event queue for IRQ from CPU-CP.
  * @dma_pool: DMA pool for small allocations.
@@ -2796,7 +2764,6 @@ struct hl_device {
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
 	spinlock_t			cs_mirror_lock;
-	struct hl_cb_mgr		kernel_cb_mgr;
 	struct hl_mem_mgr		kernel_mem_mgr;
 	struct hl_eq			event_queue;
 	struct dma_pool			*dma_pool;
@@ -3102,21 +3069,13 @@ void hl_sysfs_fini(struct hl_device *hdev);
 int hl_hwmon_init(struct hl_device *hdev);
 void hl_hwmon_fini(struct hl_device *hdev);
 
-int hl_cb_create_unified_mem_mgr(struct hl_device *hdev, struct hl_mem_mgr *mmg,
-			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
-			bool map_cb, u64 *handle);
-int hl_cb_destroy_unified_mem_mgr(struct hl_mem_mgr *mmg, u64 cb_handle);
-int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
+int hl_cb_create(struct hl_device *hdev, struct hl_mem_mgr *mmg,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
 			bool map_cb, u64 *handle);
-int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
-int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
+int hl_cb_destroy(struct hl_mem_mgr *mmg, u64 cb_handle);
 int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
-struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
-			u32 handle);
+struct hl_cb *hl_cb_get(struct hl_mem_mgr *mmg, u64 handle);
 void hl_cb_put(struct hl_cb *cb);
-void hl_cb_mgr_init(struct hl_cb_mgr *mgr);
-void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr);
 struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 					bool internal_cb);
 int hl_cb_pool_init(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 57218e03c222..70203433e6cd 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -138,7 +138,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
 
-	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
 	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr);
 
@@ -197,7 +196,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
-	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e74ea4c2d008..8e9bdbac512e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1011,7 +1011,7 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 
 release_cb:
 	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	return rc;
 }
@@ -1473,7 +1473,7 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 		job->patched_cb = NULL;
 
 	job->job_cb_size = job->user_cb_size;
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	/* increment refcount as for external queues we get completion */
 	if (hw_queue_prop->type == QUEUE_TYPE_EXT)
@@ -5525,7 +5525,7 @@ static int gaudi_patch_cb(struct hl_device *hdev,
 static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 		struct hl_cs_parser *parser)
 {
-	u64 patched_cb_handle;
+	u64 handle;
 	u32 patched_cb_size;
 	struct hl_cb *user_cb;
 	int rc;
@@ -5541,9 +5541,9 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	else
 		parser->patched_cb_size = parser->user_cb_size;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+	rc = hl_cb_create(hdev, &hdev->kernel_mem_mgr, hdev->kernel_ctx,
 				parser->patched_cb_size, false, false,
-				&patched_cb_handle);
+				&handle);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -5552,13 +5552,10 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 		return rc;
 	}
 
-	patched_cb_handle >>= PAGE_SHIFT;
-	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
-				(u32) patched_cb_handle);
+	parser->patched_cb = hl_cb_get(&hdev->kernel_mem_mgr, handle);
 	/* hl_cb_get should never fail */
 	if (!parser->patched_cb) {
-		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%llx\n", handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -5598,8 +5595,7 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	 * cb_put will release it, but here we want to remove it from the
 	 * idr
 	 */
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
-					patched_cb_handle << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, handle);
 
 	return rc;
 }
@@ -5607,7 +5603,7 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 		struct hl_cs_parser *parser)
 {
-	u64 patched_cb_handle;
+	u64 handle;
 	int rc;
 
 	rc = gaudi_validate_cb(hdev, parser, false);
@@ -5615,22 +5611,19 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+	rc = hl_cb_create(hdev, &hdev->kernel_mem_mgr, hdev->kernel_ctx,
 				parser->patched_cb_size, false, false,
-				&patched_cb_handle);
+				&handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
 		goto free_userptr;
 	}
 
-	patched_cb_handle >>= PAGE_SHIFT;
-	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
-				(u32) patched_cb_handle);
+	parser->patched_cb = hl_cb_get(&hdev->kernel_mem_mgr, handle);
 	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
-		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
-				(u32) patched_cb_handle);
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%llx\n", handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -5647,8 +5640,7 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 	 * cb_put will release it, but here we want to remove it from the
 	 * idr
 	 */
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
-				patched_cb_handle << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, handle);
 
 free_userptr:
 	if (rc)
@@ -5761,7 +5753,6 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	struct hl_cs_job *job;
 	u32 cb_size, ctl, err_cause;
 	struct hl_cb *cb;
-	u64 id;
 	int rc;
 
 	cb = hl_cb_kernel_create(hdev, PAGE_SIZE, false);
@@ -5828,9 +5819,8 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	}
 
 release_cb:
-	id = cb->id;
 	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	return rc;
 }
@@ -5893,7 +5883,7 @@ static int gaudi_memset_registers(struct hl_device *hdev, u64 reg_base,
 
 release_cb:
 	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 75736ccdfe4b..f8fb6dc04269 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4001,7 +4001,7 @@ static int goya_patch_cb(struct hl_device *hdev,
 static int goya_parse_cb_mmu(struct hl_device *hdev,
 		struct hl_cs_parser *parser)
 {
-	u64 patched_cb_handle;
+	u64 handle;
 	u32 patched_cb_size;
 	struct hl_cb *user_cb;
 	int rc;
@@ -4014,9 +4014,9 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	parser->patched_cb_size = parser->user_cb_size +
 			sizeof(struct packet_msg_prot) * 2;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+	rc = hl_cb_create(hdev, &hdev->kernel_mem_mgr, hdev->kernel_ctx,
 				parser->patched_cb_size, false, false,
-				&patched_cb_handle);
+				&handle);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -4025,13 +4025,10 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 		return rc;
 	}
 
-	patched_cb_handle >>= PAGE_SHIFT;
-	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
-				(u32) patched_cb_handle);
+	parser->patched_cb = hl_cb_get(&hdev->kernel_mem_mgr, handle);
 	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
-		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%llx\n", handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -4071,8 +4068,7 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	 * cb_put will release it, but here we want to remove it from the
 	 * idr
 	 */
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
-					patched_cb_handle << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, handle);
 
 	return rc;
 }
@@ -4080,7 +4076,7 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 				struct hl_cs_parser *parser)
 {
-	u64 patched_cb_handle;
+	u64 handle;
 	int rc;
 
 	rc = goya_validate_cb(hdev, parser, false);
@@ -4088,22 +4084,19 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+	rc = hl_cb_create(hdev, &hdev->kernel_mem_mgr, hdev->kernel_ctx,
 				parser->patched_cb_size, false, false,
-				&patched_cb_handle);
+				&handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
 		goto free_userptr;
 	}
 
-	patched_cb_handle >>= PAGE_SHIFT;
-	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
-				(u32) patched_cb_handle);
+	parser->patched_cb = hl_cb_get(&hdev->kernel_mem_mgr, handle);
 	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
-		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%llx\n", handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -4120,8 +4113,7 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	 * cb_put will release it, but here we want to remove it from the
 	 * idr
 	 */
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
-				patched_cb_handle << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, handle);
 
 free_userptr:
 	if (rc)
@@ -4853,7 +4845,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 release_cb:
 	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
 
 	return rc;
 }
-- 
2.25.1

