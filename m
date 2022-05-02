Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1D516BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359101AbiEBILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359250AbiEBIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977373BBD6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54690B811CC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41393C385A4;
        Mon,  2 May 2022 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478759;
        bh=Ae5J0Ss/0O2cTeTVjME3Ca5F632NNVEqsthAzk8yoRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/vbiqGFLqT+l+O8cvR2EAI0KSd8quAoPF9UBC3ksM10PyfoYxj+I6LFmw+nIm7aC
         oOrizz9VmbHJHJ1n/8gPwWNb2pBXfwVSUN9iFbD8YEhzWeyeVTk1WbLe3WWVubMlvd
         fhhgqx5FVdl3D9pMUtEND1eT6BEAYPGBZ027AKfV77vqKGmkFiiKU3+4WsmBLeX0Jr
         znQO7lrTYY8SlImwws8OPIhpkd3R/r1M80hgFNs73Q+ksuu1t14ZBdYnmTwPTEA06A
         bnt31u3RdX6kimPYCfSU3YOaOyXSiYTfX5c7oJgpcFX0WE+74k6cbbOSvJEo27CVBo
         1Gb7WCgWQ/cWg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 4/6] habanalabs: unified memory manager new code for CB flow
Date:   Mon,  2 May 2022 11:05:47 +0300
Message-Id: <20220502080549.230411-4-ogabbay@kernel.org>
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

This commit adds the new code needed for command buffer flow using the
new unified memory manager, without changing the actual functionality.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 156 ++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |   8 +
 2 files changed, 164 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index a507110f6443..a2a97f4876bd 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -378,6 +378,162 @@ int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle)
 	return rc;
 }
 
+struct hl_cb_mmap_mem_alloc_args {
+	struct hl_device *hdev;
+	struct hl_ctx *ctx;
+	u32 cb_size;
+	bool internal_cb;
+	bool map_cb;
+};
+
+static void hl_cb_mmap_mem_release(struct hl_mmap_mem_buf *buf)
+{
+	struct hl_cb *cb = buf->private;
+
+	hl_debugfs_remove_cb(cb);
+
+	if (cb->is_mmu_mapped)
+		cb_unmap_mem(cb->ctx, cb);
+
+	hl_ctx_put(cb->ctx);
+
+	cb_do_release(cb->hdev, cb);
+}
+
+static int hl_cb_mmap_mem_alloc(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
+{
+	struct hl_cb_mmap_mem_alloc_args *cb_args = args;
+	struct hl_cb *cb;
+	int rc, ctx_id = cb_args->ctx->asid;
+	bool alloc_new_cb = true;
+
+	if (!cb_args->internal_cb) {
+		/* Minimum allocation must be PAGE SIZE */
+		if (cb_args->cb_size < PAGE_SIZE)
+			cb_args->cb_size = PAGE_SIZE;
+
+		if (ctx_id == HL_KERNEL_ASID_ID &&
+				cb_args->cb_size <= cb_args->hdev->asic_prop.cb_pool_cb_size) {
+
+			spin_lock(&cb_args->hdev->cb_pool_lock);
+			if (!list_empty(&cb_args->hdev->cb_pool)) {
+				cb = list_first_entry(&cb_args->hdev->cb_pool,
+						typeof(*cb), pool_list);
+				list_del(&cb->pool_list);
+				spin_unlock(&cb_args->hdev->cb_pool_lock);
+				alloc_new_cb = false;
+			} else {
+				spin_unlock(&cb_args->hdev->cb_pool_lock);
+				dev_dbg(cb_args->hdev->dev, "CB pool is empty\n");
+			}
+		}
+	}
+
+	if (alloc_new_cb) {
+		cb = hl_cb_alloc(cb_args->hdev, cb_args->cb_size, ctx_id, cb_args->internal_cb);
+		if (!cb)
+			return -ENOMEM;
+	}
+
+	cb->hdev = cb_args->hdev;
+	cb->ctx = cb_args->ctx;
+	cb->buf = buf;
+	cb->buf->mappable_size = cb->size;
+	cb->buf->private = cb;
+
+	hl_ctx_get(cb_args->hdev, cb->ctx);
+
+	if (cb_args->map_cb) {
+		if (ctx_id == HL_KERNEL_ASID_ID) {
+			dev_err(cb_args->hdev->dev,
+				"CB mapping is not supported for kernel context\n");
+			rc = -EINVAL;
+			goto release_cb;
+		}
+
+		rc = cb_map_mem(cb_args->ctx, cb);
+		if (rc)
+			goto release_cb;
+	}
+
+	hl_debugfs_add_cb(cb);
+
+	return 0;
+
+release_cb:
+	hl_ctx_put(cb->ctx);
+	cb_do_release(cb_args->hdev, cb);
+
+	return rc;
+}
+
+static int hl_cb_mmap_unified_mem_mgr(struct hl_mmap_mem_buf *buf,
+				      struct vm_area_struct *vma, void *args)
+{
+	struct hl_cb *cb = buf->private;
+
+	return cb->hdev->asic_funcs->mmap(cb->hdev, vma, cb->kernel_address,
+					cb->bus_address, cb->size);
+}
+
+static struct hl_mmap_mem_buf_behavior cb_behavior = {
+	.mem_id = HL_MMAP_TYPE_CB,
+	.alloc = hl_cb_mmap_mem_alloc,
+	.release = hl_cb_mmap_mem_release,
+	.mmap = hl_cb_mmap_unified_mem_mgr,
+};
+
+int hl_cb_create_unified_mem_mgr(struct hl_device *hdev, struct hl_mem_mgr *mmg,
+			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
+			bool map_cb, u64 *handle)
+{
+	struct hl_cb_mmap_mem_alloc_args args = {
+		.hdev = hdev,
+		.ctx = ctx,
+		.cb_size = cb_size,
+		.internal_cb = internal_cb,
+		.map_cb = map_cb,
+	};
+	struct hl_mmap_mem_buf *buf;
+	int ctx_id = ctx->asid;
+
+	if ((hdev->disabled) || (hdev->reset_info.in_reset && (ctx_id != HL_KERNEL_ASID_ID))) {
+		dev_warn_ratelimited(hdev->dev,
+			"Device is disabled or in reset. Can't create new CBs\n");
+		return -EBUSY;
+	}
+
+	if (cb_size > SZ_2M) {
+		dev_err(hdev->dev, "CB size %d must be less than %d\n",
+			cb_size, SZ_2M);
+		return -EINVAL;
+	}
+
+	buf = hl_mmap_mem_buf_alloc(
+		mmg, &cb_behavior,
+		ctx_id == HL_KERNEL_ASID_ID ? GFP_ATOMIC : GFP_KERNEL, &args);
+	if (!buf)
+		return -ENOMEM;
+
+	*handle = buf->handle;
+
+	return 0;
+}
+
+int hl_cb_destroy_unified_mem_mgr(struct hl_mem_mgr *mmg, u64 cb_handle)
+{
+	int rc;
+
+	rc = hl_mmap_mem_buf_put_handle(mmg, cb_handle);
+	if (rc < 0)
+		return rc; /* Invalid handle */
+
+	if (rc == 0)
+		dev_warn(mmg->dev, "CB 0x%llx is destroyed while still in use\n", cb_handle);
+
+	return 0;
+}
+
 static int hl_cb_info(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 			u64 cb_handle, u32 flags, u32 *usage_cnt, u64 *device_va)
 {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cfe349ebd0bb..47a5baf652b7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -796,6 +796,7 @@ struct hl_mmap_mem_buf {
  * @hdev: pointer to device this CB belongs to.
  * @ctx: pointer to the CB owner's context.
  * @lock: spinlock to protect mmap flows.
+ * @buf: back pointer to the parent mappable memory buffer
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
  * @va_block_list: list of virtual addresses blocks of the CB if it is mapped to
@@ -816,6 +817,7 @@ struct hl_cb {
 	struct hl_device	*hdev;
 	struct hl_ctx		*ctx;
 	spinlock_t		lock;
+	struct hl_mmap_mem_buf	*buf;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
 	struct list_head	va_block_list;
@@ -2662,6 +2664,7 @@ struct hl_reset_info {
  * @cs_mirror_list: CS mirror list for TDR.
  * @cs_mirror_lock: protects cs_mirror_list.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CBs.
+ * @kernel_mem_mgr: memory manager for memory buffers with lifespan of driver.
  * @event_queue: event queue for IRQ from CPU-CP.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: Host <-> CPU-CP shared memory CPU address.
@@ -2794,6 +2797,7 @@ struct hl_device {
 	struct list_head		cs_mirror_list;
 	spinlock_t			cs_mirror_lock;
 	struct hl_cb_mgr		kernel_cb_mgr;
+	struct hl_mem_mgr		kernel_mem_mgr;
 	struct hl_eq			event_queue;
 	struct dma_pool			*dma_pool;
 	void				*cpu_accessible_dma_mem;
@@ -3098,6 +3102,10 @@ void hl_sysfs_fini(struct hl_device *hdev);
 int hl_hwmon_init(struct hl_device *hdev);
 void hl_hwmon_fini(struct hl_device *hdev);
 
+int hl_cb_create_unified_mem_mgr(struct hl_device *hdev, struct hl_mem_mgr *mmg,
+			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
+			bool map_cb, u64 *handle);
+int hl_cb_destroy_unified_mem_mgr(struct hl_mem_mgr *mmg, u64 cb_handle);
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
 			bool map_cb, u64 *handle);
-- 
2.25.1

