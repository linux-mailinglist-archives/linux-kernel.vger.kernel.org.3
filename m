Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39A4DAF04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355413AbiCPLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355403AbiCPLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4156C28
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D6D616CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D56C340F1;
        Wed, 16 Mar 2022 11:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430898;
        bh=+j7gv2F/ChXKZrhzrTScQ78MrD5zgTPKY0QLZvBQqBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cnn4usE0myluYjQoEkeEUYXcjvoP0OdJBIfvkLw+Zih2UjW9Va8yoK+U4TKJtDeBe
         HJkIpvWtO1PZbPvLBfj1Hlcg366w75yxAtfAIX5vKueS/vON/c1FTpxpiaQ2tg5URS
         I2TAf0q6lf69aqO7vl9X3XzAOe3JcaO1jtNqXRaCpB2IWqSqzkwD82TsroYllaSIye
         3wW6s/SbQ9HhE6DZ1jvYlWMWmOCZ9YN6GsaXlFRZdkJN5uL9NJguKMKE63NquBmdT7
         krJnPp/JIGs7A4lNqL/v4ME10w0GeqEeHkhwJ1GI6UHXgBiT46k41Lf5CHIsY0rMtM
         zfFnxElRWvEcQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 04/11] habanalabs: convert all MMU masks/shifts to arrays
Date:   Wed, 16 Mar 2022 13:41:22 +0200
Message-Id: <20220316114129.2520107-4-ogabbay@kernel.org>
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

There is no need to hold each MMU mask/shift as a denoted structure
member (e.g. hop0_mask).

Instead converting it to array will result in smaller and more readable
code.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h   | 28 ++---------
 drivers/misc/habanalabs/common/mmu/mmu.c      | 46 ++++---------------
 drivers/misc/habanalabs/common/mmu/mmu_v1.c   | 20 ++++----
 drivers/misc/habanalabs/gaudi/gaudi.c         | 20 ++++----
 drivers/misc/habanalabs/goya/goya.c           | 20 ++++----
 .../include/hw_ip/mmu/mmu_general.h           | 10 ++++
 6 files changed, 52 insertions(+), 92 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 990190fc3054..6eb35e4124c2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -394,18 +394,8 @@ enum hl_device_hw_state {
  * struct hl_mmu_properties - ASIC specific MMU address translation properties.
  * @start_addr: virtual start address of the memory region.
  * @end_addr: virtual end address of the memory region.
- * @hop0_shift: shift of hop 0 mask.
- * @hop1_shift: shift of hop 1 mask.
- * @hop2_shift: shift of hop 2 mask.
- * @hop3_shift: shift of hop 3 mask.
- * @hop4_shift: shift of hop 4 mask.
- * @hop5_shift: shift of hop 5 mask.
- * @hop0_mask: mask to get the PTE address in hop 0.
- * @hop1_mask: mask to get the PTE address in hop 1.
- * @hop2_mask: mask to get the PTE address in hop 2.
- * @hop3_mask: mask to get the PTE address in hop 3.
- * @hop4_mask: mask to get the PTE address in hop 4.
- * @hop5_mask: mask to get the PTE address in hop 5.
+ * @hop_shifts: array holds HOPs shifts.
+ * @hop_masks: array holds HOPs masks.
  * @last_mask: mask to get the bit indicating this is the last hop.
  * @pgt_size: size for page tables.
  * @page_size: default page size used to allocate memory.
@@ -418,18 +408,8 @@ enum hl_device_hw_state {
 struct hl_mmu_properties {
 	u64	start_addr;
 	u64	end_addr;
-	u64	hop0_shift;
-	u64	hop1_shift;
-	u64	hop2_shift;
-	u64	hop3_shift;
-	u64	hop4_shift;
-	u64	hop5_shift;
-	u64	hop0_mask;
-	u64	hop1_mask;
-	u64	hop2_mask;
-	u64	hop3_mask;
-	u64	hop4_mask;
-	u64	hop5_mask;
+	u64	hop_shifts[MMU_HOP_MAX];
+	u64	hop_masks[MMU_HOP_MAX];
 	u64	last_mask;
 	u64	pgt_size;
 	u32	page_size;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index eb85d9fb7462..b5d439aceb32 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -493,11 +493,9 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 						struct hl_mmu_hop_info *hops,
 						u64 *phys_addr)
 {
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct asic_fixed_properties *prop = &ctx->hdev->asic_prop;
 	u64 offset_mask, addr_mask, hop_shift, tmp_phys_addr;
-	u32 hop0_shift_off;
-	void *p;
+	struct hl_mmu_properties *mmu_prop;
 
 	/* last hop holds the phys address and flags */
 	if (hops->unscrambled_paddr)
@@ -506,11 +504,11 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 		tmp_phys_addr = hops->hop_info[hops->used_hops - 1].hop_pte_val;
 
 	if (hops->range_type == HL_VA_RANGE_TYPE_HOST_HUGE)
-		p = &prop->pmmu_huge;
+		mmu_prop = &prop->pmmu_huge;
 	else if (hops->range_type == HL_VA_RANGE_TYPE_HOST)
-		p = &prop->pmmu;
+		mmu_prop = &prop->pmmu;
 	else /* HL_VA_RANGE_TYPE_DRAM */
-		p = &prop->dmmu;
+		mmu_prop = &prop->dmmu;
 
 	if ((hops->range_type == HL_VA_RANGE_TYPE_DRAM) &&
 			!is_power_of_2(prop->dram_page_size)) {
@@ -539,10 +537,7 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 		 * structure in order to determine the right masks
 		 * for the page offset.
 		 */
-		hop0_shift_off = offsetof(struct hl_mmu_properties, hop0_shift);
-		p = (char *)p + hop0_shift_off;
-		p = (char *)p + ((hops->used_hops - 1) * sizeof(u64));
-		hop_shift = *(u64 *)p;
+		hop_shift = mmu_prop->hop_shifts[hops->used_hops - 1];
 		offset_mask = (1ull << hop_shift) - 1;
 		addr_mask = ~(offset_mask);
 		*phys_addr = (tmp_phys_addr & addr_mask) |
@@ -698,33 +693,8 @@ u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *m
 		return U64_MAX;
 	}
 
-	/* currently max number of HOPs is 6 */
-	switch (hop_idx) {
-	case 0:
-		mask = mmu_prop->hop0_mask;
-		shift = mmu_prop->hop0_shift;
-		break;
-	case 1:
-		mask = mmu_prop->hop1_mask;
-		shift = mmu_prop->hop1_shift;
-		break;
-	case 2:
-		mask = mmu_prop->hop2_mask;
-		shift = mmu_prop->hop2_shift;
-		break;
-	case 3:
-		mask = mmu_prop->hop3_mask;
-		shift = mmu_prop->hop3_shift;
-		break;
-	case 4:
-		mask = mmu_prop->hop4_mask;
-		shift = mmu_prop->hop4_shift;
-		break;
-	default:
-		mask = mmu_prop->hop5_mask;
-		shift = mmu_prop->hop5_shift;
-		break;
-	}
+	shift = mmu_prop->hop_shifts[hop_idx];
+	mask = mmu_prop->hop_masks[hop_idx];
 
 	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size * ((virt_addr & mask) >> shift);
 }
diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index d03786d0c407..f43657ad442b 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -181,40 +181,40 @@ static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx,
 					struct hl_mmu_properties *mmu_prop,
 					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop0_mask,
-					mmu_prop->hop0_shift);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP0],
+					mmu_prop->hop_shifts[MMU_HOP0]);
 }
 
 static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx,
 					struct hl_mmu_properties *mmu_prop,
 					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop1_mask,
-					mmu_prop->hop1_shift);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP1],
+					mmu_prop->hop_shifts[MMU_HOP1]);
 }
 
 static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx,
 					struct hl_mmu_properties *mmu_prop,
 					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop2_mask,
-					mmu_prop->hop2_shift);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP2],
+					mmu_prop->hop_shifts[MMU_HOP2]);
 }
 
 static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx,
 					struct hl_mmu_properties *mmu_prop,
 					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop3_mask,
-					mmu_prop->hop3_shift);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP3],
+					mmu_prop->hop_shifts[MMU_HOP3]);
 }
 
 static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
 					struct hl_mmu_properties *mmu_prop,
 					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop4_mask,
-					mmu_prop->hop4_shift);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP4],
+					mmu_prop->hop_shifts[MMU_HOP4]);
 }
 
 static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 47afc5d1aef4..5979434d1905 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -598,16 +598,16 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = false;
 
-	prop->pmmu.hop0_shift = MMU_V1_1_HOP0_SHIFT;
-	prop->pmmu.hop1_shift = MMU_V1_1_HOP1_SHIFT;
-	prop->pmmu.hop2_shift = MMU_V1_1_HOP2_SHIFT;
-	prop->pmmu.hop3_shift = MMU_V1_1_HOP3_SHIFT;
-	prop->pmmu.hop4_shift = MMU_V1_1_HOP4_SHIFT;
-	prop->pmmu.hop0_mask = MMU_V1_1_HOP0_MASK;
-	prop->pmmu.hop1_mask = MMU_V1_1_HOP1_MASK;
-	prop->pmmu.hop2_mask = MMU_V1_1_HOP2_MASK;
-	prop->pmmu.hop3_mask = MMU_V1_1_HOP3_MASK;
-	prop->pmmu.hop4_mask = MMU_V1_1_HOP4_MASK;
+	prop->pmmu.hop_shifts[MMU_HOP0] = MMU_V1_1_HOP0_SHIFT;
+	prop->pmmu.hop_shifts[MMU_HOP1] = MMU_V1_1_HOP1_SHIFT;
+	prop->pmmu.hop_shifts[MMU_HOP2] = MMU_V1_1_HOP2_SHIFT;
+	prop->pmmu.hop_shifts[MMU_HOP3] = MMU_V1_1_HOP3_SHIFT;
+	prop->pmmu.hop_shifts[MMU_HOP4] = MMU_V1_1_HOP4_SHIFT;
+	prop->pmmu.hop_masks[MMU_HOP0] = MMU_V1_1_HOP0_MASK;
+	prop->pmmu.hop_masks[MMU_HOP1] = MMU_V1_1_HOP1_MASK;
+	prop->pmmu.hop_masks[MMU_HOP2] = MMU_V1_1_HOP2_MASK;
+	prop->pmmu.hop_masks[MMU_HOP3] = MMU_V1_1_HOP3_MASK;
+	prop->pmmu.hop_masks[MMU_HOP4] = MMU_V1_1_HOP4_MASK;
 	prop->pmmu.start_addr = VA_HOST_SPACE_START;
 	prop->pmmu.end_addr =
 			(VA_HOST_SPACE_START + VA_HOST_SPACE_SIZE / 2) - 1;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e4b7b9706d1a..ec347bd3bb69 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -416,16 +416,16 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = true;
 
-	prop->dmmu.hop0_shift = MMU_V1_0_HOP0_SHIFT;
-	prop->dmmu.hop1_shift = MMU_V1_0_HOP1_SHIFT;
-	prop->dmmu.hop2_shift = MMU_V1_0_HOP2_SHIFT;
-	prop->dmmu.hop3_shift = MMU_V1_0_HOP3_SHIFT;
-	prop->dmmu.hop4_shift = MMU_V1_0_HOP4_SHIFT;
-	prop->dmmu.hop0_mask = MMU_V1_0_HOP0_MASK;
-	prop->dmmu.hop1_mask = MMU_V1_0_HOP1_MASK;
-	prop->dmmu.hop2_mask = MMU_V1_0_HOP2_MASK;
-	prop->dmmu.hop3_mask = MMU_V1_0_HOP3_MASK;
-	prop->dmmu.hop4_mask = MMU_V1_0_HOP4_MASK;
+	prop->dmmu.hop_shifts[MMU_HOP0] = MMU_V1_0_HOP0_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP1] = MMU_V1_0_HOP1_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP2] = MMU_V1_0_HOP2_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP3] = MMU_V1_0_HOP3_SHIFT;
+	prop->dmmu.hop_shifts[MMU_HOP4] = MMU_V1_0_HOP4_SHIFT;
+	prop->dmmu.hop_masks[MMU_HOP0] = MMU_V1_0_HOP0_MASK;
+	prop->dmmu.hop_masks[MMU_HOP1] = MMU_V1_0_HOP1_MASK;
+	prop->dmmu.hop_masks[MMU_HOP2] = MMU_V1_0_HOP2_MASK;
+	prop->dmmu.hop_masks[MMU_HOP3] = MMU_V1_0_HOP3_MASK;
+	prop->dmmu.hop_masks[MMU_HOP4] = MMU_V1_0_HOP4_MASK;
 	prop->dmmu.start_addr = VA_DDR_SPACE_START;
 	prop->dmmu.end_addr = VA_DDR_SPACE_END;
 	prop->dmmu.page_size = PAGE_SIZE_2MB;
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index 758f246627f8..cae8ac8bc5b1 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -34,4 +34,14 @@
 
 #define MMU_CONFIG_TIMEOUT_USEC		2000 /* 2 ms */
 
+enum mmu_hop_num {
+	MMU_HOP0,
+	MMU_HOP1,
+	MMU_HOP2,
+	MMU_HOP3,
+	MMU_HOP4,
+	MMU_HOP5,
+	MMU_HOP_MAX,
+};
+
 #endif /* INCLUDE_MMU_GENERAL_H_ */
-- 
2.25.1

