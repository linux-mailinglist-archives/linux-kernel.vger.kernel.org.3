Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B21517D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiECGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiECGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:34:07 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D96381A5;
        Mon,  2 May 2022 23:30:35 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id AEDAD26E9B5;
        Tue,  3 May 2022 08:23:03 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] iommu/io-pgtable: Add DART PTE support for t6000
Date:   Tue,  3 May 2022 08:23:00 +0200
Message-Id: <20220503062301.20872-4-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503062301.20872-1-j@jannau.net>
References: <20220503062301.20872-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
They support a 42bit physical address space by shifting the paddr and
extending its mask inside the PTE.
PTE flags are incompatible with iopte_type() since BIT(1) in the PTE
tags "uncached" mappings.
They also come with mandatory sub-page protection now which we just
configure to always allow access to the entire page. This feature is
already present but optional on the previous DARTs which allows to
unconditionally configure it.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes since v1:
 - add APPLE_DART2 PTE format
---
 drivers/iommu/io-pgtable-arm.c | 68 ++++++++++++++++++++++++++++++++--
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  3 ++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 71570bbc9096..f9121251fb57 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -134,9 +134,20 @@
 #define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
 #define APPLE_DART_PTE_PROT_NO_READ (1<<8)
 
+#define APPLE_DART_PTE_VALID BIT(0) // identical to ARM_LPAE_PTE_TYPE_BLOCK
+
+#define APPLE_DART2_PTE_PROT_NO_CACHE BIT(1)
+#define APPLE_DART2_PTE_PROT_NO_WRITE BIT(2)
+#define APPLE_DART2_PTE_PROT_NO_READ BIT(3)
+
 #define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
 #define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
 
+#define APPLE_DART_PADDR_MASK_PS_36BIT	GENMASK_ULL(35, 12)
+#define APPLE_DART_PADDR_SHIFT_PS_36BIT	(0)
+#define APPLE_DART_PADDR_MASK_PS_42BIT	GENMASK_ULL(37, 10)
+#define APPLE_DART_PADDR_SHIFT_PS_42BIT	(4)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -160,6 +171,10 @@ typedef u64 arm_lpae_iopte;
 static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
 			      enum io_pgtable_fmt fmt)
 {
+	if (fmt == APPLE_DART2)
+		return lvl == (ARM_LPAE_MAX_LEVELS - 1) &&
+			FIELD_GET(APPLE_DART_PTE_VALID, pte);
+
 	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
 		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
 
@@ -171,6 +186,13 @@ static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 {
 	arm_lpae_iopte pte = paddr;
 
+	if (data->iop.fmt == APPLE_DART || data->iop.fmt == APPLE_DART2) {
+		pte = paddr >> data->iop.cfg.apple_dart_cfg.paddr_shift;
+		pte &= data->iop.cfg.apple_dart_cfg.paddr_mask;
+
+		return pte;
+	}
+
 	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
 	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
 }
@@ -180,6 +202,12 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 {
 	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
+	if (data->iop.fmt == APPLE_DART || data->iop.fmt == APPLE_DART2) {
+		paddr = pte & data->iop.cfg.apple_dart_cfg.paddr_mask;
+		paddr <<= data->iop.cfg.apple_dart_cfg.paddr_shift;
+		return paddr;
+	}
+
 	if (ARM_LPAE_GRANULE(data) < SZ_64K)
 		return paddr;
 
@@ -272,12 +300,13 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	int i;
 
-	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
+	if ((data->iop.fmt != ARM_MALI_LPAE && data->iop.fmt != APPLE_DART2) &&
+		lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	if (data->iop.fmt == APPLE_DART) {
+	if (data->iop.fmt == APPLE_DART || data->iop.fmt == APPLE_DART2) {
 		/* subpage protection: always allow access to the entire page */
 		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
 		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
@@ -330,7 +359,18 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 	arm_lpae_iopte old, new;
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
+	new = paddr_to_iopte(__pa(table), data);
+	/*
+	 * The APPLE_DART2 PTE format is incompatible with ARM_LPAE_PTE_TYPE_*
+	 * since BIT(1) is used to tag "uncached" mappings.
+	 * This is the only place where ARM_LPAE_PTE_TYPE_TABLE has to be
+	 * taken into account since APPLE_DART2 supports only a single block
+	 * size.
+	 */
+	if (data->iop.fmt == APPLE_DART2)
+		new |= APPLE_DART_PTE_VALID;
+	else
+		new |= ARM_LPAE_PTE_TYPE_TABLE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_LPAE_PTE_NSTABLE;
 
@@ -424,6 +464,16 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 			pte |= APPLE_DART_PTE_PROT_NO_READ;
 		return pte;
 	}
+	if (data->iop.fmt == APPLE_DART2) {
+		pte = 0;
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART2_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART2_PTE_PROT_NO_READ;
+		if (!(prot & IOMMU_CACHE))
+			pte |= APPLE_DART2_PTE_PROT_NO_CACHE;
+		return pte;
+	}
 
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
@@ -1123,8 +1173,18 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 	int i;
 
-	if (cfg->oas > 36)
+	switch (cfg->oas) {
+	case 36:
+		cfg->apple_dart_cfg.paddr_shift = APPLE_DART_PADDR_SHIFT_PS_36BIT;
+		cfg->apple_dart_cfg.paddr_mask = APPLE_DART_PADDR_MASK_PS_36BIT;
+		break;
+	case 42:
+		cfg->apple_dart_cfg.paddr_shift = APPLE_DART_PADDR_SHIFT_PS_42BIT;
+		cfg->apple_dart_cfg.paddr_mask = APPLE_DART_PADDR_MASK_PS_42BIT;
+		break;
+	default:
 		return NULL;
+	}
 
 	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index f4bfcef98297..a217d2e85520 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -21,6 +21,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
 	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
+	[APPLE_DART2] = &io_pgtable_apple_dart_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86af6f0a00a2..36f251dc6f6b 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -17,6 +17,7 @@ enum io_pgtable_fmt {
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
 	APPLE_DART,
+	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -136,6 +137,8 @@ struct io_pgtable_cfg {
 		struct {
 			u64 ttbr[4];
 			u32 n_ttbrs;
+			u32 paddr_shift;
+			u64 paddr_mask;
 		} apple_dart_cfg;
 	};
 };
-- 
2.35.1

