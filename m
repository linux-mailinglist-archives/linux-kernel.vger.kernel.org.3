Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077135AEEF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIFPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbiIFPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC51C482B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7607E6134E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BBEC433C1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475415;
        bh=M0mFpSJasBL/pIlG8ZZELZjU3ge+kJx3c32lppYcjL0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GoZn240P8Bwa+gbJTcoDNXr8M7vd4oYAOyhLdxxckQDMLuvc6iojgF0FaHwDMoGmT
         piJ0d8dDNSd7TLX0PxcOWnBCjL8QOcQPsAvoiWvdv+clkNtIC7dvy3bnI5kZKXQOwn
         RWqocGBmOznWO7pFMMRHJMvCs+hQ65EkYRUuuhrxQRmYMYnZ8ahaiHZzYXNhyIr1tK
         rVQgWoMV4E122NtHAbb6RuHLJZGLIcIGmHoxpRETH7eB4Qs9ETWO6YpYO8AYLzAsbi
         HbKaPE+624iy/52uoQhJppaT35WYOhcX6uqFn1bF8lnnQtsr01hJWqsxQVQygu1jhq
         5qFAGJg+Hbrog==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] habanalabs: MMU invalidation h/w is per device
Date:   Tue,  6 Sep 2022 17:43:18 +0300
Message-Id: <20220906144318.1890416-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code used the mmu mutex to protect access to the context's page
tables and invalidation of the MMU cache. Because pgt are per
context, the mmu mutex was a member of the context object.

The problem is that the device has a single MMU invalidation h/w
(per MMU). Therefore, the mmu mutex should not be a property of the
context but a property of the device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 10 ++++-----
 drivers/misc/habanalabs/common/habanalabs.h   | 10 ++++++---
 drivers/misc/habanalabs/common/memory.c       | 14 ++++++------
 drivers/misc/habanalabs/common/mmu/mmu.c      | 22 +++++++++----------
 drivers/misc/habanalabs/gaudi/gaudi.c         |  8 +++----
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 16 +++++++-------
 6 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index d16de18863ba..2b332991ac6a 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -44,20 +44,20 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	rc = hl_mmu_map_contiguous(ctx, cb->virtual_addr, cb->bus_address, cb->roundup_size);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to map VA %#llx to CB\n", cb->virtual_addr);
 		goto err_va_umap;
 	}
 	rc = hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	cb->is_mmu_mapped = true;
 	return rc;
 
 err_va_umap:
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 	gen_pool_free(ctx->cb_va_pool, cb->virtual_addr, cb->roundup_size);
 	return rc;
 }
@@ -66,10 +66,10 @@ static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	hl_mmu_unmap_contiguous(ctx, cb->virtual_addr, cb->roundup_size);
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	gen_pool_free(ctx->cb_va_pool, cb->virtual_addr, cb->roundup_size);
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4d7681a2b40a..f2910ac7aa22 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1793,8 +1793,6 @@ struct hl_cs_outcome_store {
  *                 command submissions for a long time after CS id wraparound.
  * @va_range: holds available virtual addresses for host and dram mappings.
  * @mem_hash_lock: protects the mem_hash.
- * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
- *            MMU hash or walking the PGT requires talking this lock.
  * @hw_block_list_lock: protects the HW block memory list.
  * @debugfs_list: node in debugfs list of contexts.
  * @hw_block_mem_list: list of HW block virtual mapped addresses.
@@ -1831,7 +1829,6 @@ struct hl_ctx {
 	struct hl_cs_outcome_store	outcome_store;
 	struct hl_va_range		*va_range[HL_VA_RANGE_TYPE_MAX];
 	struct mutex			mem_hash_lock;
-	struct mutex			mmu_lock;
 	struct mutex			hw_block_list_lock;
 	struct list_head		debugfs_list;
 	struct list_head		hw_block_mem_list;
@@ -3079,6 +3076,12 @@ struct hl_reset_info {
  * @asid_mutex: protects asid_bitmap.
  * @send_cpu_message_lock: enforces only one message in Host <-> CPU-CP queue.
  * @debug_lock: protects critical section of setting debug mode for device
+ * @mmu_lock: protects the MMU page tables and invalidation h/w. Although the
+ *            page tables are per context, the invalidation h/w is per MMU.
+ *            Therefore, we can't allow multiple contexts (we only have two,
+ *            user and kernel) to access the invalidation h/w at the same time.
+ *            In addition, any change to the PGT, modifying the MMU hash or
+ *            walking the PGT requires talking this lock.
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
@@ -3244,6 +3247,7 @@ struct hl_device {
 	struct mutex			asid_mutex;
 	struct mutex			send_cpu_message_lock;
 	struct mutex			debug_lock;
+	struct mutex			mmu_lock;
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 0a653fff08d4..096fa3c1ae95 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1210,18 +1210,18 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 		goto va_block_err;
 	}
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 
 	rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
 		dev_err(hdev->dev, "mapping page pack failed for handle %u\n", handle);
-		mutex_unlock(&ctx->mmu_lock);
+		mutex_unlock(&hdev->mmu_lock);
 		goto map_err;
 	}
 
 	rc = hl_mmu_invalidate_cache_range(hdev, false, *vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
 				ctx->asid, ret_vaddr, phys_pg_pack->total_size);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 	if (rc)
 		goto map_err;
 
@@ -1362,7 +1362,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	else
 		vaddr &= ~(((u64) phys_pg_pack->page_size) - 1);
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 
 	unmap_phys_pg_pack(ctx, vaddr, phys_pg_pack);
 
@@ -1375,7 +1375,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		rc = hl_mmu_invalidate_cache_range(hdev, true, *vm_type, ctx->asid, vaddr,
 							phys_pg_pack->total_size);
 
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	/*
 	 * If the context is closing we don't need to check for the MMU cache
@@ -2771,13 +2771,13 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		unmap_device_va(ctx, &args, true);
 	}
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 
 	/* invalidate the cache once after the unmapping loop */
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_PHYS_PACK);
 
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	INIT_LIST_HEAD(&free_list);
 
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 264f3b9edc88..cf8946266615 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -47,6 +47,8 @@ int hl_mmu_init(struct hl_device *hdev)
 	if (!hdev->mmu_enable)
 		return 0;
 
+	mutex_init(&hdev->mmu_lock);
+
 	if (hdev->mmu_func[MMU_DR_PGT].init != NULL) {
 		rc = hdev->mmu_func[MMU_DR_PGT].init(hdev);
 		if (rc)
@@ -88,6 +90,8 @@ void hl_mmu_fini(struct hl_device *hdev)
 
 	if (hdev->mmu_func[MMU_HR_PGT].fini != NULL)
 		hdev->mmu_func[MMU_HR_PGT].fini(hdev);
+
+	mutex_destroy(&hdev->mmu_lock);
 }
 
 /**
@@ -106,8 +110,6 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 	if (!hdev->mmu_enable)
 		return 0;
 
-	mutex_init(&ctx->mmu_lock);
-
 	if (hdev->mmu_func[MMU_DR_PGT].ctx_init != NULL) {
 		rc = hdev->mmu_func[MMU_DR_PGT].ctx_init(ctx);
 		if (rc)
@@ -151,8 +153,6 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 
 	if (hdev->mmu_func[MMU_HR_PGT].ctx_fini != NULL)
 		hdev->mmu_func[MMU_HR_PGT].ctx_fini(ctx);
-
-	mutex_destroy(&ctx->mmu_lock);
 }
 
 /*
@@ -609,9 +609,9 @@ int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
 	mmu_funcs = hl_mmu_get_funcs(hdev, pgt_residency, is_dram_addr);
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	rc = mmu_funcs->get_tlb_info(ctx, virt_addr, hops);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	if (rc)
 		return rc;
@@ -701,16 +701,16 @@ static void hl_mmu_prefetch_work_function(struct work_struct *work)
 {
 	struct hl_prefetch_work *pfw = container_of(work, struct hl_prefetch_work, pf_work);
 	struct hl_ctx *ctx = pfw->ctx;
+	struct hl_device *hdev = ctx->hdev;
 
-	if (!hl_device_operational(ctx->hdev, NULL))
+	if (!hl_device_operational(hdev, NULL))
 		goto put_ctx;
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 
-	ctx->hdev->asic_funcs->mmu_prefetch_cache_range(ctx, pfw->flags, pfw->asid,
-								pfw->va, pfw->size);
+	hdev->asic_funcs->mmu_prefetch_cache_range(ctx, pfw->flags, pfw->asid, pfw->va, pfw->size);
 
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 put_ctx:
 	/*
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2b328cb62096..48ff3b103b9f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8405,13 +8405,13 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 		goto destroy_internal_cb_pool;
 	}
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	rc = hl_mmu_map_contiguous(ctx, hdev->internal_cb_va_base,
 			hdev->internal_cb_pool_dma_addr,
 			HOST_SPACE_INTERNAL_CB_SZ);
 
 	hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	if (rc)
 		goto unreserve_internal_cb_pool;
@@ -8438,13 +8438,13 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
 		return;
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	hl_mmu_unmap_contiguous(ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	gen_pool_destroy(hdev->internal_cb_pool);
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index f749f7377ea6..5761ca5d50ae 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9302,12 +9302,12 @@ static int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, v
 	}
 
 	/* Create mapping on asic side */
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	rc = hl_mmu_map_contiguous(ctx, reserved_va_base, host_mem_dma_addr, SZ_2M);
 	hl_mmu_invalidate_cache_range(hdev, false,
 				      MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV,
 				      ctx->asid, reserved_va_base, SZ_2M);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to create mapping on asic mmu\n");
 		goto unreserve_va;
@@ -9340,11 +9340,11 @@ static int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, v
 
 	gaudi2_kdma_set_mmbp_asid(hdev, true, HL_KERNEL_ASID_ID);
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	hl_mmu_unmap_contiguous(ctx, reserved_va_base, SZ_2M);
 	hl_mmu_invalidate_cache_range(hdev, false, MMU_OP_USERPTR,
 				      ctx->asid, reserved_va_base, SZ_2M);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 unreserve_va:
 	hl_unreserve_va_block(hdev, ctx, reserved_va_base, SZ_2M);
 free_data_buffer:
@@ -9397,11 +9397,11 @@ static int gaudi2_internal_cb_pool_init(struct hl_device *hdev, struct hl_ctx *c
 		goto destroy_internal_cb_pool;
 	}
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	rc = hl_mmu_map_contiguous(ctx, hdev->internal_cb_va_base, hdev->internal_cb_pool_dma_addr,
 					HOST_SPACE_INTERNAL_CB_SZ);
 	hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	if (rc)
 		goto unreserve_internal_cb_pool;
@@ -9426,11 +9426,11 @@ static void gaudi2_internal_cb_pool_fini(struct hl_device *hdev, struct hl_ctx *
 	if (!(gaudi2->hw_cap_initialized & HW_CAP_PMMU))
 		return;
 
-	mutex_lock(&ctx->mmu_lock);
+	mutex_lock(&hdev->mmu_lock);
 	hl_mmu_unmap_contiguous(ctx, hdev->internal_cb_va_base, HOST_SPACE_INTERNAL_CB_SZ);
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base, HOST_SPACE_INTERNAL_CB_SZ);
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-	mutex_unlock(&ctx->mmu_lock);
+	mutex_unlock(&hdev->mmu_lock);
 
 	gen_pool_destroy(hdev->internal_cb_pool);
 
-- 
2.25.1

