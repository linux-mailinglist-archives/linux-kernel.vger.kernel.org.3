Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8803B4745F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhLNPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLNPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A08C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3A0D6148D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B18BC34606;
        Tue, 14 Dec 2021 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494366;
        bh=N7WpP65bcnOb0FRo7Ek8TB4fwHfvRPmcWpO6Mia7j44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ/72eC6uRP+xSiBP/WGlRSljZYOBpl/l2cTnZ2jrLlK8PGIb+RaBZe+AL6gpEC5v
         65pgAeqEmFSu+1+rRnZBZBRrE/hm8qSAXAs8Ia5fyvXJ4k3dGpoQggJUtx62GQ6imS
         46UE6LpUJgHcA/tZnOyyPYjjG3qH/mgvXmc7yfWBKtSsZFuspblqUkCGVfWCZ2T9Wo
         9cg/n8NlpszO/9aKCLOiI3iXXK/sGuUHlcmFwiE2HkZONtkqs1FjBGzrQ9uzFpoKM/
         FzB23r48nhdHcBoYMmW1sDM7N7ACxwPK8eefvUiW8zQufKh5oBiZAy+bT0rRbNzgjb
         PHFedWFvL+RcQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 08/11] habanalabs: clean MMU headers definitions
Date:   Tue, 14 Dec 2021 17:05:48 +0200
Message-Id: <20211214150551.1568192-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

During the MMU development the MMU header files were left with unclean
definitions:

- MMU "version specific" definitions that were left in the mmu_general
  file
- unused definitions

This patch attempts, where possible, to keep definitions that can serve
multiple MMU versions (but that are not tightly bound with specific MMU
arch) in the mmu_general header file (e.g. different definitions for
number of HOPs).

Otherwise, move MMU version specific definitions (e.g. HOPs masks and
shifts) to the specific MMU version file.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu_v1.c   |  8 +++----
 drivers/misc/habanalabs/gaudi/gaudi.c         | 24 +++++++++----------
 drivers/misc/habanalabs/goya/goya.c           | 24 +++++++++----------
 .../include/hw_ip/mmu/mmu_general.h           | 19 ++++-----------
 .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   | 18 +++++++++++---
 .../habanalabs/include/hw_ip/mmu/mmu_v1_1.h   | 20 ++++++++++++----
 6 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 159da2fafd79..6134b6ae7615 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -269,7 +269,7 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
 
 	num_of_hop3 = prop->dram_size_for_default_page_mapping;
 	do_div(num_of_hop3, prop->dram_page_size);
-	do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
+	do_div(num_of_hop3, HOP_PTE_ENTRIES_512);
 
 	/* add hop1 and hop2 */
 	total_hops = num_of_hop3 + 2;
@@ -330,7 +330,7 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
 
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		hop3_pte_addr = ctx->dram_default_hops[i];
-		for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
+		for (j = 0 ; j < HOP_PTE_ENTRIES_512 ; j++) {
 			write_final_pte(ctx, hop3_pte_addr, pte_val);
 			get_pte(ctx, ctx->dram_default_hops[i]);
 			hop3_pte_addr += HL_PTE_SIZE;
@@ -369,7 +369,7 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 
 	num_of_hop3 = prop->dram_size_for_default_page_mapping;
 	do_div(num_of_hop3, prop->dram_page_size);
-	do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
+	do_div(num_of_hop3, HOP_PTE_ENTRIES_512);
 
 	hop0_addr = get_hop0_addr(ctx);
 	/* add hop1 and hop2 */
@@ -379,7 +379,7 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 
 	for (i = 0 ; i < num_of_hop3 ; i++) {
 		hop3_pte_addr = ctx->dram_default_hops[i];
-		for (j = 0 ; j < PTE_ENTRIES_IN_HOP ; j++) {
+		for (j = 0 ; j < HOP_PTE_ENTRIES_512 ; j++) {
 			clear_pte(ctx, hop3_pte_addr);
 			put_pte(ctx, ctx->dram_default_hops[i]);
 			hop3_pte_addr += HL_PTE_SIZE;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 07e03d44930e..b3431eac4f04 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -593,21 +593,21 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	else
 		prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
 	prop->mmu_pte_size = HL_PTE_SIZE;
-	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
-	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
+	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
 	prop->dram_supports_virtual_memory = false;
 
-	prop->pmmu.hop0_shift = HOP0_SHIFT;
-	prop->pmmu.hop1_shift = HOP1_SHIFT;
-	prop->pmmu.hop2_shift = HOP2_SHIFT;
-	prop->pmmu.hop3_shift = HOP3_SHIFT;
-	prop->pmmu.hop4_shift = HOP4_SHIFT;
-	prop->pmmu.hop0_mask = HOP0_MASK;
-	prop->pmmu.hop1_mask = HOP1_MASK;
-	prop->pmmu.hop2_mask = HOP2_MASK;
-	prop->pmmu.hop3_mask = HOP3_MASK;
-	prop->pmmu.hop4_mask = HOP4_MASK;
+	prop->pmmu.hop0_shift = MMU_V1_1_HOP0_SHIFT;
+	prop->pmmu.hop1_shift = MMU_V1_1_HOP1_SHIFT;
+	prop->pmmu.hop2_shift = MMU_V1_1_HOP2_SHIFT;
+	prop->pmmu.hop3_shift = MMU_V1_1_HOP3_SHIFT;
+	prop->pmmu.hop4_shift = MMU_V1_1_HOP4_SHIFT;
+	prop->pmmu.hop0_mask = MMU_V1_1_HOP0_MASK;
+	prop->pmmu.hop1_mask = MMU_V1_1_HOP1_MASK;
+	prop->pmmu.hop2_mask = MMU_V1_1_HOP2_MASK;
+	prop->pmmu.hop3_mask = MMU_V1_1_HOP3_MASK;
+	prop->pmmu.hop4_mask = MMU_V1_1_HOP4_MASK;
 	prop->pmmu.start_addr = VA_HOST_SPACE_START;
 	prop->pmmu.end_addr =
 			(VA_HOST_SPACE_START + VA_HOST_SPACE_SIZE / 2) - 1;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8d0f2cd608fc..f4473013f1ee 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -410,21 +410,21 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	else
 		prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
 	prop->mmu_pte_size = HL_PTE_SIZE;
-	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
-	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
+	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
 	prop->dram_supports_virtual_memory = true;
 
-	prop->dmmu.hop0_shift = HOP0_SHIFT;
-	prop->dmmu.hop1_shift = HOP1_SHIFT;
-	prop->dmmu.hop2_shift = HOP2_SHIFT;
-	prop->dmmu.hop3_shift = HOP3_SHIFT;
-	prop->dmmu.hop4_shift = HOP4_SHIFT;
-	prop->dmmu.hop0_mask = HOP0_MASK;
-	prop->dmmu.hop1_mask = HOP1_MASK;
-	prop->dmmu.hop2_mask = HOP2_MASK;
-	prop->dmmu.hop3_mask = HOP3_MASK;
-	prop->dmmu.hop4_mask = HOP4_MASK;
+	prop->dmmu.hop0_shift = MMU_V1_0_HOP0_SHIFT;
+	prop->dmmu.hop1_shift = MMU_V1_0_HOP1_SHIFT;
+	prop->dmmu.hop2_shift = MMU_V1_0_HOP2_SHIFT;
+	prop->dmmu.hop3_shift = MMU_V1_0_HOP3_SHIFT;
+	prop->dmmu.hop4_shift = MMU_V1_0_HOP4_SHIFT;
+	prop->dmmu.hop0_mask = MMU_V1_0_HOP0_MASK;
+	prop->dmmu.hop1_mask = MMU_V1_0_HOP1_MASK;
+	prop->dmmu.hop2_mask = MMU_V1_0_HOP2_MASK;
+	prop->dmmu.hop3_mask = MMU_V1_0_HOP3_MASK;
+	prop->dmmu.hop4_mask = MMU_V1_0_HOP4_MASK;
 	prop->dmmu.start_addr = VA_DDR_SPACE_START;
 	prop->dmmu.end_addr = VA_DDR_SPACE_END;
 	prop->dmmu.page_size = PAGE_SIZE_2MB;
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index dedf20e8f956..758f246627f8 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -16,27 +16,18 @@
 #define PAGE_PRESENT_MASK		0x0000000000001ull
 #define SWAP_OUT_MASK			0x0000000000004ull
 #define LAST_MASK			0x0000000000800ull
-#define HOP0_MASK			0x3000000000000ull
-#define HOP1_MASK			0x0FF8000000000ull
-#define HOP2_MASK			0x0007FC0000000ull
-#define HOP3_MASK			0x000003FE00000ull
-#define HOP4_MASK			0x00000001FF000ull
 #define FLAGS_MASK			0x0000000000FFFull
 
-#define HOP0_SHIFT			48
-#define HOP1_SHIFT			39
-#define HOP2_SHIFT			30
-#define HOP3_SHIFT			21
-#define HOP4_SHIFT			12
-
 #define MMU_ARCH_5_HOPS			5
 
 #define HOP_PHYS_ADDR_MASK		(~FLAGS_MASK)
 
 #define HL_PTE_SIZE			sizeof(u64)
-#define HOP_TABLE_SIZE			PAGE_SIZE_4KB
-#define PTE_ENTRIES_IN_HOP		(HOP_TABLE_SIZE / HL_PTE_SIZE)
-#define HOP0_TABLES_TOTAL_SIZE		(HOP_TABLE_SIZE * MAX_ASID)
+
+/* definitions for HOP with 512 PTE entries */
+#define HOP_PTE_ENTRIES_512		512
+#define HOP_TABLE_SIZE_512_PTE		(HOP_PTE_ENTRIES_512 * HL_PTE_SIZE)
+#define HOP0_512_PTE_TABLES_TOTAL_SIZE	(HOP_TABLE_SIZE_512_PTE * MAX_ASID)
 
 #define MMU_HOP0_PA43_12_SHIFT		12
 #define MMU_HOP0_PA49_44_SHIFT		(12 + 32)
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
index 8539dd041f2c..86511002e367 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
@@ -8,8 +8,20 @@
 #ifndef INCLUDE_MMU_V1_0_H_
 #define INCLUDE_MMU_V1_0_H_
 
-#define MMU_HOP0_PA43_12	0x490004
-#define MMU_HOP0_PA49_44	0x490008
-#define MMU_ASID_BUSY		0x490000
+#define MMU_V1_0_HOP0_MASK		0x3000000000000ull
+#define MMU_V1_0_HOP1_MASK		0x0FF8000000000ull
+#define MMU_V1_0_HOP2_MASK		0x0007FC0000000ull
+#define MMU_V1_0_HOP3_MASK		0x000003FE00000ull
+#define MMU_V1_0_HOP4_MASK		0x00000001FF000ull
+
+#define MMU_V1_0_HOP0_SHIFT		48
+#define MMU_V1_0_HOP1_SHIFT		39
+#define MMU_V1_0_HOP2_SHIFT		30
+#define MMU_V1_0_HOP3_SHIFT		21
+#define MMU_V1_0_HOP4_SHIFT		12
+
+#define MMU_HOP0_PA43_12		0x490004
+#define MMU_HOP0_PA49_44		0x490008
+#define MMU_ASID_BUSY			0x490000
 
 #endif /* INCLUDE_MMU_V1_0_H_ */
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h
index b2a9570583ac..9c727a5d47b4 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h
@@ -8,9 +8,21 @@
 #ifndef INCLUDE_MMU_V1_1_H_
 #define INCLUDE_MMU_V1_1_H_
 
-#define MMU_ASID		0xC12004
-#define MMU_HOP0_PA43_12	0xC12008
-#define MMU_HOP0_PA49_44	0xC1200C
-#define MMU_BUSY		0xC12000
+#define MMU_V1_1_HOP0_MASK		0x3000000000000ull
+#define MMU_V1_1_HOP1_MASK		0x0FF8000000000ull
+#define MMU_V1_1_HOP2_MASK		0x0007FC0000000ull
+#define MMU_V1_1_HOP3_MASK		0x000003FE00000ull
+#define MMU_V1_1_HOP4_MASK		0x00000001FF000ull
+
+#define MMU_V1_1_HOP0_SHIFT		48
+#define MMU_V1_1_HOP1_SHIFT		39
+#define MMU_V1_1_HOP2_SHIFT		30
+#define MMU_V1_1_HOP3_SHIFT		21
+#define MMU_V1_1_HOP4_SHIFT		12
+
+#define MMU_ASID			0xC12004
+#define MMU_HOP0_PA43_12		0xC12008
+#define MMU_HOP0_PA49_44		0xC1200C
+#define MMU_BUSY			0xC12000
 
 #endif /* INCLUDE_MMU_V1_1_H_ */
-- 
2.25.1

