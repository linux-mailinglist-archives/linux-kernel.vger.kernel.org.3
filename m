Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76990496DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiAVT57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiAVT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B8C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE3DACE0171
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA0C340E4;
        Sat, 22 Jan 2022 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881464;
        bh=+HsgcPDORH9jvfYj3nc9Ra/1wTgXAkkZi2lXmwHS4fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=om3OfHMaC+ygWnould2go0n9rezl+Ze7OTeqfEbzZ3FA6BpaM12fWDghFelYBSu50
         Mq/sZ+mknWwIFtG/uEbSNhuK7xh3q5yPZIHQQdNSu6DnupXSe4pE3I1SwDWXb54wv8
         kYTxxBwcWqX7ZAsAGaz3RMbpgzJHY2cSqqgEHUU7PWbGRS18XeX0o57LimEOPeBwnV
         jsjgXlDKKBMgVfppktHihvSzewh+9lbkXbTEjXn2nnjB3sFfAb4NLNmJr/bXCsTPpY
         eO6l4zh+9CDwxqj2PZFKFZoek2LkNmEKmxDsTkmkzH0FFzh9F+VFIvPm5nTyXhVWCl
         5oJYSziejoglA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 06/30] habanalabs: make some MMU functions common
Date:   Sat, 22 Jan 2022 21:57:07 +0200
Message-Id: <20220122195731.934494-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Some MMU functions can be used by different versions of our MMUs, so
move them to be common.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  9 ++++
 drivers/misc/habanalabs/common/mmu/mmu.c    | 55 +++++++++++++++++++++
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 45 +++--------------
 3 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 24962807e2cf..e96f26e7e804 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -402,8 +402,11 @@ enum hl_device_hw_state {
  * @hop4_mask: mask to get the PTE address in hop 4.
  * @hop5_mask: mask to get the PTE address in hop 5.
  * @last_mask: mask to get the bit indicating this is the last hop.
+ * @pgt_size: size for page tables.
  * @page_size: default page size used to allocate memory.
  * @num_hops: The amount of hops supported by the translation table.
+ * @hop_table_size: HOP table size.
+ * @hop0_tables_total_size: total size for all HOP0 tables.
  * @host_resident: Should the MMU page table reside in host memory or in the
  *                 device DRAM.
  */
@@ -423,8 +426,11 @@ struct hl_mmu_properties {
 	u64	hop4_mask;
 	u64	hop5_mask;
 	u64	last_mask;
+	u64	pgt_size;
 	u32	page_size;
 	u32	num_hops;
+	u32	hop_table_size;
+	u32	hop0_tables_total_size;
 	u8	host_resident;
 };
 
@@ -3015,6 +3021,9 @@ int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size);
 int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags);
 int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 					u32 flags, u32 asid, u64 va, u64 size);
+u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte);
+u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
+					u8 hop_idx, u64 hop_addr, u64 virt_addr);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 9153a1f55175..810b73421ce1 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -662,3 +662,58 @@ int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 	return rc;
 }
 
+u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
+{
+	return (curr_pte & PAGE_PRESENT_MASK) ? (curr_pte & HOP_PHYS_ADDR_MASK) : ULLONG_MAX;
+}
+
+/**
+ * hl_mmu_get_hop_pte_phys_addr() - extract PTE address from HOP
+ * @ctx: pointer to the context structure to initialize.
+ * @hop_idx: HOP index.
+ * @hop_addr: HOP address.
+ * @virt_addr: virtual address fro the translation.
+ *
+ * @return the matching PTE value on success, otherwise U64_MAX.
+ */
+u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
+					u8 hop_idx, u64 hop_addr, u64 virt_addr)
+{
+	u64 mask, shift;
+
+	if (hop_idx >= mmu_prop->num_hops) {
+		dev_err_ratelimited(ctx->hdev->dev, "Invalid hop index %d\n", hop_idx);
+		return U64_MAX;
+	}
+
+	/* currently max number of HOPs is 6 */
+	switch (hop_idx) {
+	case 0:
+		mask = mmu_prop->hop0_mask;
+		shift = mmu_prop->hop0_shift;
+		break;
+	case 1:
+		mask = mmu_prop->hop1_mask;
+		shift = mmu_prop->hop1_shift;
+		break;
+	case 2:
+		mask = mmu_prop->hop2_mask;
+		shift = mmu_prop->hop2_shift;
+		break;
+	case 3:
+		mask = mmu_prop->hop3_mask;
+		shift = mmu_prop->hop3_shift;
+		break;
+	case 4:
+		mask = mmu_prop->hop4_mask;
+		shift = mmu_prop->hop4_shift;
+		break;
+	default:
+		mask = mmu_prop->hop5_mask;
+		shift = mmu_prop->hop5_shift;
+		break;
+	}
+
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size * ((virt_addr & mask) >> shift);
+}
+
diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 3cadef97817d..d03786d0c407 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -217,18 +217,10 @@ static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
 					mmu_prop->hop4_shift);
 }
 
-static inline u64 get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
-{
-	if (curr_pte & PAGE_PRESENT_MASK)
-		return curr_pte & HOP_PHYS_ADDR_MASK;
-	else
-		return ULLONG_MAX;
-}
-
 static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
 						bool *is_new_hop)
 {
-	u64 hop_addr = get_next_hop_addr(ctx, curr_pte);
+	u64 hop_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
 
 	if (hop_addr == ULLONG_MAX) {
 		hop_addr = alloc_hop(ctx);
@@ -546,7 +538,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 
 	curr_pte = *(u64 *) (uintptr_t) hop0_pte_addr;
 
-	hop1_addr = get_next_hop_addr(ctx, curr_pte);
+	hop1_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
 
 	if (hop1_addr == ULLONG_MAX)
 		goto not_mapped;
@@ -555,7 +547,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 
 	curr_pte = *(u64 *) (uintptr_t) hop1_pte_addr;
 
-	hop2_addr = get_next_hop_addr(ctx, curr_pte);
+	hop2_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
 
 	if (hop2_addr == ULLONG_MAX)
 		goto not_mapped;
@@ -564,7 +556,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 
 	curr_pte = *(u64 *) (uintptr_t) hop2_pte_addr;
 
-	hop3_addr = get_next_hop_addr(ctx, curr_pte);
+	hop3_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
 
 	if (hop3_addr == ULLONG_MAX)
 		goto not_mapped;
@@ -582,7 +574,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 	}
 
 	if (!is_huge) {
-		hop4_addr = get_next_hop_addr(ctx, curr_pte);
+		hop4_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
 
 		if (hop4_addr == ULLONG_MAX)
 			goto not_mapped;
@@ -845,27 +837,6 @@ static void hl_mmu_v1_swap_in(struct hl_ctx *ctx)
 
 }
 
-static inline u64 get_hop_pte_addr(struct hl_ctx *ctx,
-				struct hl_mmu_properties *mmu_prop,
-				int hop_num, u64 hop_addr, u64 virt_addr)
-{
-	switch (hop_num) {
-	case 0:
-		return get_hop0_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	case 1:
-		return get_hop1_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	case 2:
-		return get_hop2_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	case 3:
-		return get_hop3_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	case 4:
-		return get_hop4_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	default:
-		break;
-	}
-	return U64_MAX;
-}
-
 static int hl_mmu_v1_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 				struct hl_mmu_hop_info *hops)
 {
@@ -906,7 +877,7 @@ static int hl_mmu_v1_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 
 	hops->hop_info[0].hop_addr = get_phys_hop0_addr(ctx);
 	hops->hop_info[0].hop_pte_addr =
-			get_hop_pte_addr(ctx, mmu_prop, 0,
+			hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, 0,
 					hops->hop_info[0].hop_addr, virt_addr);
 	hops->hop_info[0].hop_pte_val =
 			hdev->asic_funcs->read_pte(hdev,
@@ -914,13 +885,13 @@ static int hl_mmu_v1_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 
 	for (i = 1 ; i < used_hops ; i++) {
 		hops->hop_info[i].hop_addr =
-			get_next_hop_addr(ctx,
+			hl_mmu_get_next_hop_addr(ctx,
 					hops->hop_info[i - 1].hop_pte_val);
 		if (hops->hop_info[i].hop_addr == ULLONG_MAX)
 			return -EFAULT;
 
 		hops->hop_info[i].hop_pte_addr =
-				get_hop_pte_addr(ctx, mmu_prop, i,
+				hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, i,
 						hops->hop_info[i].hop_addr,
 						virt_addr);
 		hops->hop_info[i].hop_pte_val =
-- 
2.25.1

