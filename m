Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790E64DAF03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355406AbiCPLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355396AbiCPLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCF532D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A5C6616BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AF1C340E9;
        Wed, 16 Mar 2022 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430897;
        bh=LoPKqy7BQ2HDpkWn0CxSAIOlciMStAKCS+GshvUCe44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMQ/WUbFiGn3IeFiDHPT+WN/2Iim96RJdUkr4R7snr/KkaUFZ3neJRg6geluSjfFJ
         jSbd/qkRXCclwIWSGuQrIysVJ/dYDlNy3z1SwGgRYDyjJfsHDmEOvdKiudNO3VCqWZ
         Jpnq8fCQbZFSY56vUd1eFl9OmVQRSDxBqc2ui0fKQxhn981P4OA6WSBs6wfGEpbr6/
         DCN5JQcSanhvsMRCkirP6XmL5u3kw7NtI2jzR7SnQjJOnyxplViI+ZrDQd+KnPRjSy
         z3T9ABfoYkuk5ILdhKkOTOicA2fVuamssYZseAtGJS+ByrtzffND7p5YCodyytivHp
         KiyWCmH9co/YQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 03/11] habanalabs: change mmu_get_real_page_size to be ASIC-specific
Date:   Wed, 16 Mar 2022 13:41:21 +0200
Message-Id: <20220316114129.2520107-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch breaks the cumbersome implementation of "get real page size"
along with it's multiple inner conditions and implement each case
(according to the real complexity) inside an ASIC function.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |   4 +
 drivers/misc/habanalabs/common/mmu/mmu.c    | 204 +++++++++++---------
 drivers/misc/habanalabs/gaudi/gaudi.c       |   3 +-
 drivers/misc/habanalabs/goya/goya.c         |   3 +-
 4 files changed, 116 insertions(+), 98 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index af47accd4a56..990190fc3054 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1450,6 +1450,8 @@ struct hl_asic_funcs {
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
 	u32* (*get_stream_master_qid_arr)(void);
 	bool (*is_valid_dram_page_size)(u32 page_size);
+	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
+					u32 page_size, u32 *real_page_size, bool is_dram_addr);
 };
 
 
@@ -3109,6 +3111,8 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx);
 void hl_mmu_ctx_fini(struct hl_ctx *ctx);
 int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		u32 page_size, bool flush_pte);
+int hl_mmu_get_real_page_size(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
+				u32 page_size, u32 *real_page_size, bool is_dram_addr);
 int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 		bool flush_pte);
 int hl_mmu_map_contiguous(struct hl_ctx *ctx, u64 virt_addr,
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 810b73421ce1..eb85d9fb7462 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -9,6 +9,20 @@
 
 #include "../habanalabs.h"
 
+/**
+ * hl_mmu_get_funcs() - get MMU functions structure
+ * @hdev: habanalabs device structure.
+ * @pgt_residency: page table residency.
+ * @is_dram_addr: true if we need HMMU functions
+ *
+ * @return appropriate MMU functions structure
+ */
+static struct hl_mmu_funcs *hl_mmu_get_funcs(struct hl_device *hdev, int pgt_residency,
+									bool is_dram_addr)
+{
+	return &hdev->mmu_func[pgt_residency];
+}
+
 bool hl_is_dram_va(struct hl_device *hdev, u64 virt_addr)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -121,6 +135,53 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	mutex_destroy(&ctx->mmu_lock);
 }
 
+/*
+ * hl_mmu_get_real_page_size - get real page size to use in map/unmap operation
+ *
+ * @hdev: pointer to device data.
+ * @mmu_prop: MMU properties.
+ * @page_size: page size
+ * @real_page_size: set here the actual page size to use for the operation
+ * @is_dram_addr: true if DRAM address, otherwise false.
+ *
+ * @return 0 on success, otherwise non 0 error code
+ *
+ * note that this is general implementation that can fit most MMU arch. but as this is used as an
+ * MMU function:
+ * 1. it shall not be called directly- only from mmu_func structure instance
+ * 2. each MMU may modify the implementation internally
+ */
+int hl_mmu_get_real_page_size(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
+				u32 page_size, u32 *real_page_size, bool is_dram_addr)
+{
+	/*
+	 * The H/W handles mapping of specific page sizes. Hence if the page
+	 * size is bigger, we break it to sub-pages and map them separately.
+	 */
+	if ((page_size % mmu_prop->page_size) == 0) {
+		*real_page_size = mmu_prop->page_size;
+		return 0;
+	}
+
+	dev_err(hdev->dev, "page size of %u is not %uKB aligned, can't map\n",
+						page_size, mmu_prop->page_size >> 10);
+
+	return -EFAULT;
+}
+
+static struct hl_mmu_properties *hl_mmu_get_prop(struct hl_device *hdev, u32 page_size,
+							bool is_dram_addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	if (is_dram_addr)
+		return &prop->dmmu;
+	else if ((page_size % prop->pmmu_huge.page_size) == 0)
+		return &prop->pmmu_huge;
+
+	return &prop->pmmu;
+}
+
 /*
  * hl_mmu_unmap_page - unmaps a virtual addr
  *
@@ -142,60 +203,37 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
  * For optimization reasons PCI flush may be requested once after unmapping of
  * large area.
  */
-int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
-		bool flush_pte)
+int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flush_pte)
 {
 	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct asic_fixed_properties *prop;
 	struct hl_mmu_properties *mmu_prop;
-	u64 real_virt_addr;
+	struct hl_mmu_funcs *mmu_funcs;
+	int i, pgt_residency, rc = 0;
 	u32 real_page_size, npages;
-	int i, rc = 0, pgt_residency;
+	u64 real_virt_addr;
 	bool is_dram_addr;
 
 	if (!hdev->mmu_enable)
 		return 0;
 
+	prop = &hdev->asic_prop;
 	is_dram_addr = hl_is_dram_va(hdev, virt_addr);
-
-	if (is_dram_addr)
-		mmu_prop = &prop->dmmu;
-	else if ((page_size % prop->pmmu_huge.page_size) == 0)
-		mmu_prop = &prop->pmmu_huge;
-	else
-		mmu_prop = &prop->pmmu;
+	mmu_prop = hl_mmu_get_prop(hdev, page_size, is_dram_addr);
 
 	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
-	/*
-	 * The H/W handles mapping of specific page sizes. Hence if the page
-	 * size is bigger, we break it to sub-pages and unmap them separately.
-	 */
-	if ((page_size % mmu_prop->page_size) == 0) {
-		real_page_size = mmu_prop->page_size;
-	} else {
-		/*
-		 * MMU page size may differ from DRAM page size.
-		 * In such case work with the DRAM page size and let the MMU
-		 * scrambling routine to handle this mismatch when
-		 * calculating the address to remove from the MMU page table
-		 */
-		if (is_dram_addr && ((page_size % prop->dram_page_size) == 0)) {
-			real_page_size = prop->dram_page_size;
-		} else {
-			dev_err(hdev->dev,
-				"page size of %u is not %uKB aligned, can't unmap\n",
-				page_size, mmu_prop->page_size >> 10);
+	mmu_funcs = hl_mmu_get_funcs(hdev, pgt_residency, is_dram_addr);
 
-			return -EFAULT;
-		}
-	}
+	rc = hdev->asic_funcs->mmu_get_real_page_size(hdev, mmu_prop, page_size, &real_page_size,
+							is_dram_addr);
+	if (rc)
+		return rc;
 
 	npages = page_size / real_page_size;
 	real_virt_addr = virt_addr;
 
 	for (i = 0 ; i < npages ; i++) {
-		rc = hdev->mmu_func[pgt_residency].unmap(ctx,
-						real_virt_addr, is_dram_addr);
+		rc = mmu_funcs->unmap(ctx, real_virt_addr, is_dram_addr);
 		if (rc)
 			break;
 
@@ -203,7 +241,7 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	}
 
 	if (flush_pte)
-		hdev->mmu_func[pgt_residency].flush(ctx);
+		mmu_funcs->flush(ctx);
 
 	return rc;
 }
@@ -230,56 +268,33 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
  * For optimization reasons PCI flush may be requested once after mapping of
  * large area.
  */
-int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
-		u32 page_size, bool flush_pte)
+int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
+			bool flush_pte)
 {
+	int i, rc, pgt_residency, mapped_cnt = 0;
 	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct asic_fixed_properties *prop;
 	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr, real_phys_addr;
+	struct hl_mmu_funcs *mmu_funcs;
 	u32 real_page_size, npages;
-	int i, rc, pgt_residency, mapped_cnt = 0;
 	bool is_dram_addr;
 
 
 	if (!hdev->mmu_enable)
 		return 0;
 
+	prop = &hdev->asic_prop;
 	is_dram_addr = hl_is_dram_va(hdev, virt_addr);
-
-	if (is_dram_addr)
-		mmu_prop = &prop->dmmu;
-	else if ((page_size % prop->pmmu_huge.page_size) == 0)
-		mmu_prop = &prop->pmmu_huge;
-	else
-		mmu_prop = &prop->pmmu;
+	mmu_prop = hl_mmu_get_prop(hdev, page_size, is_dram_addr);
 
 	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
+	mmu_funcs = hl_mmu_get_funcs(hdev, pgt_residency, is_dram_addr);
 
-	/*
-	 * The H/W handles mapping of specific page sizes. Hence if the page
-	 * size is bigger, we break it to sub-pages and map them separately.
-	 */
-	if ((page_size % mmu_prop->page_size) == 0) {
-		real_page_size = mmu_prop->page_size;
-	} else if (is_dram_addr && ((page_size % prop->dram_page_size) == 0) &&
-			(prop->dram_page_size < mmu_prop->page_size)) {
-		/*
-		 * MMU page size may differ from DRAM page size.
-		 * In such case work with the DRAM page size and let the MMU
-		 * scrambling routine handle this mismatch when calculating
-		 * the address to place in the MMU page table. (in that case
-		 * also make sure that the dram_page_size smaller than the
-		 * mmu page size)
-		 */
-		real_page_size = prop->dram_page_size;
-	} else {
-		dev_err(hdev->dev,
-			"page size of %u is not %uKB aligned, can't map\n",
-			page_size, mmu_prop->page_size >> 10);
-
-		return -EFAULT;
-	}
+	rc = hdev->asic_funcs->mmu_get_real_page_size(hdev, mmu_prop, page_size, &real_page_size,
+							is_dram_addr);
+	if (rc)
+		return rc;
 
 	/*
 	 * Verify that the phys and virt addresses are aligned with the
@@ -302,9 +317,8 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	real_phys_addr = phys_addr;
 
 	for (i = 0 ; i < npages ; i++) {
-		rc = hdev->mmu_func[pgt_residency].map(ctx,
-						real_virt_addr, real_phys_addr,
-						real_page_size, is_dram_addr);
+		rc = mmu_funcs->map(ctx, real_virt_addr, real_phys_addr, real_page_size,
+										is_dram_addr);
 		if (rc)
 			goto err;
 
@@ -314,22 +328,21 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	}
 
 	if (flush_pte)
-		hdev->mmu_func[pgt_residency].flush(ctx);
+		mmu_funcs->flush(ctx);
 
 	return 0;
 
 err:
 	real_virt_addr = virt_addr;
 	for (i = 0 ; i < mapped_cnt ; i++) {
-		if (hdev->mmu_func[pgt_residency].unmap(ctx,
-						real_virt_addr, is_dram_addr))
+		if (mmu_funcs->unmap(ctx, real_virt_addr, is_dram_addr))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap va: 0x%llx\n", real_virt_addr);
 
 		real_virt_addr += real_page_size;
 	}
 
-	hdev->mmu_func[pgt_residency].flush(ctx);
+	mmu_funcs->flush(ctx);
 
 	return rc;
 }
@@ -508,7 +521,7 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 		/*
 		 * Bit arithmetics cannot be used for non power of two page
 		 * sizes. In addition, since bit arithmetics is not used,
-		 * we cannot ignore dram base. All that shall be considerd.
+		 * we cannot ignore dram base. All that shall be considered.
 		 */
 
 		dram_page_size = prop->dram_page_size;
@@ -557,40 +570,39 @@ int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 			struct hl_mmu_hop_info *hops)
 {
 	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct asic_fixed_properties *prop;
 	struct hl_mmu_properties *mmu_prop;
-	int rc;
+	struct hl_mmu_funcs *mmu_funcs;
+	int pgt_residency, rc;
 	bool is_dram_addr;
 
 	if (!hdev->mmu_enable)
 		return -EOPNOTSUPP;
 
+	prop = &hdev->asic_prop;
 	hops->scrambled_vaddr = virt_addr;      /* assume no scrambling */
 
 	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
-						prop->dmmu.start_addr,
-						prop->dmmu.end_addr);
+								prop->dmmu.start_addr,
+								prop->dmmu.end_addr);
 
-	/* host-residency is the same in PMMU and HPMMU, use one of them */
+	/* host-residency is the same in PMMU and PMMU huge, no need to distinguish here */
 	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
+	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
+	mmu_funcs = hl_mmu_get_funcs(hdev, pgt_residency, is_dram_addr);
 
 	mutex_lock(&ctx->mmu_lock);
-
-	if (mmu_prop->host_resident)
-		rc = hdev->mmu_func[MMU_HR_PGT].get_tlb_info(ctx,
-							virt_addr, hops);
-	else
-		rc = hdev->mmu_func[MMU_DR_PGT].get_tlb_info(ctx,
-							virt_addr, hops);
-
+	rc = mmu_funcs->get_tlb_info(ctx, virt_addr, hops);
 	mutex_unlock(&ctx->mmu_lock);
 
+	if (rc)
+		return rc;
+
 	/* add page offset to physical address */
 	if (hops->unscrambled_paddr)
-		hl_mmu_pa_page_with_offset(ctx, virt_addr, hops,
-					&hops->unscrambled_paddr);
+		hl_mmu_pa_page_with_offset(ctx, virt_addr, hops, &hops->unscrambled_paddr);
 
-	return rc;
+	return 0;
 }
 
 int hl_mmu_if_set_funcs(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index feb1323a8f4a..47afc5d1aef4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9487,7 +9487,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
-	.is_valid_dram_page_size = NULL
+	.is_valid_dram_page_size = NULL,
+	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5bd665188ea6..e4b7b9706d1a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5765,7 +5765,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
-	.is_valid_dram_page_size = NULL
+	.is_valid_dram_page_size = NULL,
+	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 };
 
 /*
-- 
2.25.1

