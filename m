Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76D4FB6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbiDKJKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiDKJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FE3EF39
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C97C3B81190
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43642C385A4;
        Mon, 11 Apr 2022 09:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668094;
        bh=Rb8QLCzSU5BLpT18tWscIflqR7xQ7C21znb26BOTJj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/WggN8EE2ajILmEe+aH8lZhG14OV6vLBnv5WjhbvNmV+T/JB8OzzET1cy4tQ6J/o
         3o/xbkLTMTOAQDwvpE053Ief0eU/oYdZE9NuDoIhs8ojM8Zim4QBvOyrp7hX8PZdI5
         7TCUPXWZhO24srbHhbh1CEbKWGjs1TdZAq1dgNTljBVB8pgH49DmEj4qx7E8yfqLjt
         LHi1LtXEp3j0vzd0KxVRQj+9H4JVu6gkLwC/XMU+eHNgdbITMCTseGBVNftXHGZXFj
         /G7oLe1mQJrUCvNGOy41Fdn4B0ptBWQgt/SbOqtGQQ/ab6LKiL+kENi8wBh4cc1Hh8
         Ce5AFbziMt0kg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/7] habanalabs: refactor HOP functions in MMU V1
Date:   Mon, 11 Apr 2022 12:08:02 +0300
Message-Id: <20220411090805.1617112-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

Take advantage of the HOPs shift/masks now defined as arrays.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 297 ++++++--------------
 1 file changed, 88 insertions(+), 209 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index f43657ad442b..e2d91a69acc2 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -10,6 +10,8 @@
 
 #include <linux/slab.h>
 
+#define MMU_V1_MAX_HOPS	(MMU_HOP4 + 1)
+
 static inline u64 get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr);
 
 static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 hop_addr)
@@ -170,51 +172,15 @@ static inline int put_pte(struct hl_ctx *ctx, u64 hop_addr)
 	return num_of_ptes_left;
 }
 
-static inline u64 get_hopN_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-					u64 virt_addr, u64 mask, u64 shift)
-{
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & mask) >> shift);
-}
-
-static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_prop,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP0],
-					mmu_prop->hop_shifts[MMU_HOP0]);
-}
-
-static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_prop,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP1],
-					mmu_prop->hop_shifts[MMU_HOP1]);
-}
-
-static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_prop,
-					u64 hop_addr, u64 vaddr)
+static inline u64 get_hop_pte_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
+					u64 *hop_addr_arr, u64 virt_addr, enum mmu_hop_num hop_idx)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP2],
-					mmu_prop->hop_shifts[MMU_HOP2]);
-}
+	u64 mask, shift;
 
-static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_prop,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP3],
-					mmu_prop->hop_shifts[MMU_HOP3]);
-}
-
-static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_prop,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop_masks[MMU_HOP4],
-					mmu_prop->hop_shifts[MMU_HOP4]);
+	mask = mmu_prop->hop_masks[hop_idx];
+	shift = mmu_prop->hop_shifts[hop_idx];
+	return hop_addr_arr[hop_idx] +
+			ctx->hdev->asic_prop.mmu_pte_size * ((virt_addr & mask) >> shift);
 }
 
 static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
@@ -516,74 +482,50 @@ static void hl_mmu_v1_ctx_fini(struct hl_ctx *ctx)
 	}
 }
 
-static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
+static int hl_mmu_v1_unmap(struct hl_ctx *ctx,
 				u64 virt_addr, bool is_dram_addr)
 {
+	u64 hop_addr[MMU_V1_MAX_HOPS] = {0}, hop_pte_addr[MMU_V1_MAX_HOPS] = {0}, curr_pte = 0;
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_mmu_properties *mmu_prop;
-	u64 hop0_addr = 0, hop0_pte_addr = 0,
-		hop1_addr = 0, hop1_pte_addr = 0,
-		hop2_addr = 0, hop2_pte_addr = 0,
-		hop3_addr = 0, hop3_pte_addr = 0,
-		hop4_addr = 0, hop4_pte_addr = 0,
-		curr_pte;
 	bool is_huge, clear_hop3 = true;
+	int hop_idx;
 
 	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
 	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
 
-	hop0_addr = get_hop0_addr(ctx);
-	hop0_pte_addr = get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
-
-	curr_pte = *(u64 *) (uintptr_t) hop0_pte_addr;
-
-	hop1_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
-
-	if (hop1_addr == ULLONG_MAX)
-		goto not_mapped;
-
-	hop1_pte_addr = get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
-
-	curr_pte = *(u64 *) (uintptr_t) hop1_pte_addr;
-
-	hop2_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
-
-	if (hop2_addr == ULLONG_MAX)
-		goto not_mapped;
-
-	hop2_pte_addr = get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
-
-	curr_pte = *(u64 *) (uintptr_t) hop2_pte_addr;
-
-	hop3_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
-
-	if (hop3_addr == ULLONG_MAX)
-		goto not_mapped;
+	for (hop_idx = MMU_HOP0; hop_idx < MMU_HOP4; hop_idx++) {
+		if (hop_idx == MMU_HOP0) {
+			hop_addr[hop_idx] = get_hop0_addr(ctx);
+		} else {
+			hop_addr[hop_idx] = hl_mmu_get_next_hop_addr(ctx, curr_pte);
+			if (hop_addr[hop_idx] == ULLONG_MAX)
+				goto not_mapped;
+		}
 
-	hop3_pte_addr = get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
+		hop_pte_addr[hop_idx] =
+				get_hop_pte_addr(ctx, mmu_prop, hop_addr, virt_addr, hop_idx);
 
-	curr_pte = *(u64 *) (uintptr_t) hop3_pte_addr;
+		curr_pte = *(u64 *) (uintptr_t) hop_pte_addr[hop_idx];
+	}
 
 	is_huge = curr_pte & mmu_prop->last_mask;
 
 	if (is_dram_addr && !is_huge) {
-		dev_err(hdev->dev,
-				"DRAM unmapping should use huge pages only\n");
+		dev_err(hdev->dev, "DRAM unmapping should use huge pages only\n");
 		return -EFAULT;
 	}
 
 	if (!is_huge) {
-		hop4_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
-
-		if (hop4_addr == ULLONG_MAX)
+		hop_idx = MMU_HOP4;
+		hop_addr[hop_idx] = hl_mmu_get_next_hop_addr(ctx, curr_pte);
+		if (hop_addr[hop_idx] == ULLONG_MAX)
 			goto not_mapped;
 
-		hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
-							virt_addr);
-
-		curr_pte = *(u64 *) (uintptr_t) hop4_pte_addr;
-
+		hop_pte_addr[hop_idx] =
+				get_hop_pte_addr(ctx, mmu_prop, hop_addr, virt_addr, hop_idx);
+		curr_pte = *(u64 *) (uintptr_t) hop_pte_addr[hop_idx];
 		clear_hop3 = false;
 	}
 
@@ -605,39 +547,33 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 			goto not_mapped;
 		}
 
-		write_final_pte(ctx, hop3_pte_addr, default_pte);
-		put_pte(ctx, hop3_addr);
+		hop_idx = MMU_HOP3;
+		write_final_pte(ctx, hop_pte_addr[hop_idx], default_pte);
+		put_pte(ctx, hop_addr[hop_idx]);
 	} else {
 		if (!(curr_pte & PAGE_PRESENT_MASK))
 			goto not_mapped;
 
-		if (hop4_addr)
-			clear_pte(ctx, hop4_pte_addr);
+		if (hop_addr[MMU_HOP4])
+			clear_pte(ctx, hop_pte_addr[MMU_HOP4]);
 		else
-			clear_pte(ctx, hop3_pte_addr);
+			clear_pte(ctx, hop_pte_addr[MMU_HOP3]);
 
-		if (hop4_addr && !put_pte(ctx, hop4_addr))
+		if (hop_addr[MMU_HOP4] && !put_pte(ctx, hop_addr[MMU_HOP4]))
 			clear_hop3 = true;
 
 		if (!clear_hop3)
 			goto mapped;
 
-		clear_pte(ctx, hop3_pte_addr);
+		for (hop_idx = MMU_HOP3; hop_idx >= 0; hop_idx--) {
+			clear_pte(ctx, hop_pte_addr[hop_idx]);
 
-		if (put_pte(ctx, hop3_addr))
-			goto mapped;
+			if (hop_idx == MMU_HOP0)
+				break;
 
-		clear_pte(ctx, hop2_pte_addr);
-
-		if (put_pte(ctx, hop2_addr))
-			goto mapped;
-
-		clear_pte(ctx, hop1_pte_addr);
-
-		if (put_pte(ctx, hop1_addr))
-			goto mapped;
-
-		clear_pte(ctx, hop0_pte_addr);
+			if (put_pte(ctx, hop_addr[hop_idx]))
+				goto mapped;
+		}
 	}
 
 mapped:
@@ -650,21 +586,15 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 	return -EINVAL;
 }
 
-static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
+static int hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 			u32 page_size, bool is_dram_addr)
 {
+	u64 hop_addr[MMU_V1_MAX_HOPS] = {0}, hop_pte_addr[MMU_V1_MAX_HOPS] = {0}, curr_pte = 0;
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_mmu_properties *mmu_prop;
-	u64 hop0_addr = 0, hop0_pte_addr = 0,
-		hop1_addr = 0, hop1_pte_addr = 0,
-		hop2_addr = 0, hop2_pte_addr = 0,
-		hop3_addr = 0, hop3_pte_addr = 0,
-		hop4_addr = 0, hop4_pte_addr = 0,
-		curr_pte = 0;
-	bool hop1_new = false, hop2_new = false, hop3_new = false,
-		hop4_new = false, is_huge;
-	int rc = -ENOMEM;
+	bool is_huge, hop_new[MMU_V1_MAX_HOPS] = {false};
+	int num_hops, hop_idx, prev_hop, rc = -ENOMEM;
 
 	/*
 	 * This mapping function can map a page or a huge page. For huge page
@@ -684,39 +614,21 @@ static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		is_huge = false;
 	}
 
-	hop0_addr = get_hop0_addr(ctx);
-	hop0_pte_addr = get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
-	curr_pte = *(u64 *) (uintptr_t) hop0_pte_addr;
-
-	hop1_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop1_new);
-	if (hop1_addr == ULLONG_MAX)
-		goto err;
-
-	hop1_pte_addr = get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
-	curr_pte = *(u64 *) (uintptr_t) hop1_pte_addr;
-
-	hop2_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop2_new);
-	if (hop2_addr == ULLONG_MAX)
-		goto err;
-
-	hop2_pte_addr = get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
-	curr_pte = *(u64 *) (uintptr_t) hop2_pte_addr;
+	num_hops = is_huge ? (MMU_V1_MAX_HOPS - 1) : MMU_V1_MAX_HOPS;
 
-	hop3_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop3_new);
-	if (hop3_addr == ULLONG_MAX)
-		goto err;
-
-	hop3_pte_addr = get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
-	curr_pte = *(u64 *) (uintptr_t) hop3_pte_addr;
-
-	if (!is_huge) {
-		hop4_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop4_new);
-		if (hop4_addr == ULLONG_MAX)
-			goto err;
+	for (hop_idx = MMU_HOP0; hop_idx < num_hops; hop_idx++) {
+		if (hop_idx == MMU_HOP0) {
+			hop_addr[hop_idx] = get_hop0_addr(ctx);
+		} else {
+			hop_addr[hop_idx] =
+					get_alloc_next_hop_addr(ctx, curr_pte, &hop_new[hop_idx]);
+			if (hop_addr[hop_idx] == ULLONG_MAX)
+				goto err;
+		}
 
-		hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
-							virt_addr);
-		curr_pte = *(u64 *) (uintptr_t) hop4_pte_addr;
+		hop_pte_addr[hop_idx] =
+				get_hop_pte_addr(ctx, mmu_prop, hop_addr, virt_addr, hop_idx);
+		curr_pte = *(u64 *) (uintptr_t) hop_pte_addr[hop_idx];
 	}
 
 	if (hdev->dram_default_page_mapping && is_dram_addr) {
@@ -732,30 +644,22 @@ static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 			goto err;
 		}
 
-		if (hop1_new || hop2_new || hop3_new || hop4_new) {
-			dev_err(hdev->dev,
-				"DRAM mapping should not allocate more hops\n");
-			rc = -EFAULT;
-			goto err;
+		for (hop_idx = MMU_HOP1; hop_idx < num_hops; hop_idx++) {
+			if (hop_new[hop_idx]) {
+				dev_err(hdev->dev, "DRAM mapping should not allocate more hops\n");
+				rc = -EFAULT;
+				goto err;
+			}
 		}
 	} else if (curr_pte & PAGE_PRESENT_MASK) {
 		dev_err(hdev->dev,
 			"mapping already exists for virt_addr 0x%llx\n",
 				virt_addr);
 
-		dev_dbg(hdev->dev, "hop0 pte: 0x%llx (0x%llx)\n",
-			*(u64 *) (uintptr_t) hop0_pte_addr, hop0_pte_addr);
-		dev_dbg(hdev->dev, "hop1 pte: 0x%llx (0x%llx)\n",
-			*(u64 *) (uintptr_t) hop1_pte_addr, hop1_pte_addr);
-		dev_dbg(hdev->dev, "hop2 pte: 0x%llx (0x%llx)\n",
-			*(u64 *) (uintptr_t) hop2_pte_addr, hop2_pte_addr);
-		dev_dbg(hdev->dev, "hop3 pte: 0x%llx (0x%llx)\n",
-			*(u64 *) (uintptr_t) hop3_pte_addr, hop3_pte_addr);
-
-		if (!is_huge)
-			dev_dbg(hdev->dev, "hop4 pte: 0x%llx (0x%llx)\n",
-				*(u64 *) (uintptr_t) hop4_pte_addr,
-				hop4_pte_addr);
+		for (hop_idx = MMU_HOP0; hop_idx < num_hops; hop_idx++)
+			dev_dbg(hdev->dev, "hop%d pte: 0x%llx (0x%llx)\n", hop_idx,
+					*(u64 *) (uintptr_t) hop_pte_addr[hop_idx],
+					hop_pte_addr[hop_idx]);
 
 		rc = -EINVAL;
 		goto err;
@@ -764,53 +668,28 @@ static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	curr_pte = (phys_addr & HOP_PHYS_ADDR_MASK) | mmu_prop->last_mask
 			| PAGE_PRESENT_MASK;
 
-	if (is_huge)
-		write_final_pte(ctx, hop3_pte_addr, curr_pte);
-	else
-		write_final_pte(ctx, hop4_pte_addr, curr_pte);
+	write_final_pte(ctx, hop_pte_addr[num_hops - 1], curr_pte);
 
-	if (hop1_new) {
-		curr_pte =
-			(hop1_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
-		write_pte(ctx, hop0_pte_addr, curr_pte);
-	}
-	if (hop2_new) {
-		curr_pte =
-			(hop2_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
-		write_pte(ctx, hop1_pte_addr, curr_pte);
-		get_pte(ctx, hop1_addr);
-	}
-	if (hop3_new) {
-		curr_pte =
-			(hop3_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
-		write_pte(ctx, hop2_pte_addr, curr_pte);
-		get_pte(ctx, hop2_addr);
-	}
+	for (hop_idx = MMU_HOP1; hop_idx < num_hops; hop_idx++) {
+		prev_hop = hop_idx - 1;
 
-	if (!is_huge) {
-		if (hop4_new) {
-			curr_pte = (hop4_addr & HOP_PHYS_ADDR_MASK) |
-					PAGE_PRESENT_MASK;
-			write_pte(ctx, hop3_pte_addr, curr_pte);
-			get_pte(ctx, hop3_addr);
+		if (hop_new[hop_idx]) {
+			curr_pte = (hop_addr[hop_idx] & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+			write_pte(ctx, hop_pte_addr[prev_hop], curr_pte);
+			if (hop_idx != MMU_HOP1)
+				get_pte(ctx, hop_addr[prev_hop]);
 		}
-
-		get_pte(ctx, hop4_addr);
-	} else {
-		get_pte(ctx, hop3_addr);
 	}
 
+	get_pte(ctx, hop_addr[num_hops - 1]);
+
 	return 0;
 
 err:
-	if (hop4_new)
-		free_hop(ctx, hop4_addr);
-	if (hop3_new)
-		free_hop(ctx, hop3_addr);
-	if (hop2_new)
-		free_hop(ctx, hop2_addr);
-	if (hop1_new)
-		free_hop(ctx, hop1_addr);
+	for (hop_idx = num_hops; hop_idx > MMU_HOP0; hop_idx--) {
+		if (hop_new[hop_idx])
+			free_hop(ctx, hop_addr[hop_idx]);
+	}
 
 	return rc;
 }
@@ -928,8 +807,8 @@ void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu)
 	mmu->fini = hl_mmu_v1_fini;
 	mmu->ctx_init = hl_mmu_v1_ctx_init;
 	mmu->ctx_fini = hl_mmu_v1_ctx_fini;
-	mmu->map = _hl_mmu_v1_map;
-	mmu->unmap = _hl_mmu_v1_unmap;
+	mmu->map = hl_mmu_v1_map;
+	mmu->unmap = hl_mmu_v1_unmap;
 	mmu->flush = flush;
 	mmu->swap_out = hl_mmu_v1_swap_out;
 	mmu->swap_in = hl_mmu_v1_swap_in;
-- 
2.25.1

