Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E94E6123
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349257AbiCXJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349250AbiCXJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DE1CFDC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA400B82324
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676E0C340F0;
        Thu, 24 Mar 2022 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114440;
        bh=zWf6vji3Aufe1CgcpK0HacTp2TVKtrEDOJLNB2pz4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwlHjsFKZ2Ke+PlGYWxxCq1VKtzGERA05E3hDCTYHiTrA3mOpIrSfL9WGgT3YhRR1
         hqjv/xhDtlPsrpksXOhvp15hC1oxUJlBrfVXf/mZITyE0IOfylKkZGG96AlVFpAviP
         /+Vm0c32sD7YFH7fxCk69edkH+44qNaQkxfrFBNunBwQDOIFLrR6UCi5UfzskTGRqt
         hfyAC5l2D3k/Y7IVn/3A8xrdufciSrSbVhFcVJpb3rfjZC6PgRj67Zi8nHR/5cECV7
         JiQXy05k+OyL4JsCz5lQXU2KUuLpVIhfYYdy1osAP6iQZe+uLzBOOn5cW69MZ4QJD0
         M6H1ySg/S+iZQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/7] habanalabs: add MMU prefetch to ASIC-specific code
Date:   Thu, 24 Mar 2022 11:33:46 +0200
Message-Id: <20220324093349.3245973-4-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

This is necessary pre-requisite for future ASIC support, where MMU
TLB prefetch is supported.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  7 +++++--
 drivers/misc/habanalabs/common/memory.c     | 15 ++++++++++-----
 drivers/misc/habanalabs/common/mmu/mmu.c    | 11 +++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c       |  7 +++++++
 drivers/misc/habanalabs/goya/goya.c         |  7 +++++++
 5 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a6c6d9fd30db..1f7758fed51e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1283,8 +1283,8 @@ struct fw_load_mgr {
  * @write_pte: write MMU page table entry to DRAM.
  * @mmu_invalidate_cache: flush MMU STLB host/DRAM cache, either with soft
  *                        (L1 only) or hard (L0 & L1) flush.
- * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
- *                              ASID-VA-size mask.
+ * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with ASID-VA-size mask.
+ * @mmu_prefetch_cache_range: pre-fetch specific MMU STLB cache lines with ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to CPU-CP and verify response.
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
@@ -1416,6 +1416,8 @@ struct hl_asic_funcs {
 					u32 flags);
 	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 				u32 flags, u32 asid, u64 va, u64 size);
+	int (*mmu_prefetch_cache_range)(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
+				u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
@@ -3143,6 +3145,7 @@ int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size);
 int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags);
 int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 					u32 flags, u32 asid, u64 va, u64 size);
+int hl_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va, u64 size);
 u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte);
 u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
 					u8 hop_idx, u64 hop_addr, u64 virt_addr);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a9bf1a5f4a86..5b09c15bff48 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1241,20 +1241,23 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
-		mutex_unlock(&ctx->mmu_lock);
-		dev_err(hdev->dev, "mapping page pack failed for handle %u\n",
-				handle);
+		dev_err(hdev->dev, "mapping page pack failed for handle %u\n", handle);
 		goto map_err;
 	}
 
 	rc = hl_mmu_invalidate_cache_range(hdev, false, *vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
 				ctx->asid, ret_vaddr, phys_pg_pack->total_size);
+	if (rc)
+		goto map_err;
 
-	mutex_unlock(&ctx->mmu_lock);
-
+	/* already prefetch the relevant translations to the cache */
+	rc = hl_mmu_prefetch_cache_range(hdev, *vm_type, ctx->asid, ret_vaddr,
+						phys_pg_pack->total_size);
 	if (rc)
 		goto map_err;
 
+	mutex_unlock(&ctx->mmu_lock);
+
 	ret_vaddr += phys_pg_pack->offset;
 
 	hnode->ptr = vm_type;
@@ -1272,6 +1275,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 
 map_err:
+	mutex_unlock(&ctx->mmu_lock);
+
 	if (add_va_block(hdev, va_range, ret_vaddr,
 				ret_vaddr + phys_pg_pack->total_size - 1))
 		dev_warn(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 27c9088bf347..dcd59d76da27 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -665,6 +665,17 @@ int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 	return rc;
 }
 
+int hl_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va, u64 size)
+{
+	int rc;
+
+	rc = hdev->asic_funcs->mmu_prefetch_cache_range(hdev, flags, asid, va, size);
+	if (rc)
+		dev_err_ratelimited(hdev->dev, "MMU cache range prefetch failed\n");
+
+	return rc;
+}
+
 u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
 {
 	return (curr_pte & PAGE_PRESENT_MASK) ? (curr_pte & HOP_PHYS_ADDR_MASK) : ULLONG_MAX;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 66d56efb55ee..68c066e39660 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9377,6 +9377,12 @@ static void gaudi_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_si
 	info->page_order_bitmask = 0;
 }
 
+static int gaudi_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
+						u64 size)
+{
+	return 0;
+}
+
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9444,6 +9450,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.write_pte = gaudi_write_pte,
 	.mmu_invalidate_cache = gaudi_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = gaudi_mmu_invalidate_cache_range,
+	.mmu_prefetch_cache_range = gaudi_mmu_prefetch_cache_range,
 	.send_heartbeat = gaudi_send_heartbeat,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0bc2b077d9f6..bc8431e4b50b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5680,6 +5680,12 @@ static void goya_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_siz
 	info->page_order_bitmask = 0;
 }
 
+static int goya_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
+					u64 size)
+{
+	return 0;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5724,6 +5730,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.write_pte = goya_write_pte,
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
+	.mmu_prefetch_cache_range = goya_mmu_prefetch_cache_range,
 	.send_heartbeat = goya_send_heartbeat,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
-- 
2.25.1

