Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6A552BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbiFUHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiFUHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:25:30 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 00:25:29 PDT
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1C1A04B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:25:29 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1E53426ED1B;
        Tue, 21 Jun 2022 09:18:51 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Hector Martin <marcan@marcan.st>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iommu/io-pgtable-dart: Add DART PTE support for t6000
Date:   Tue, 21 Jun 2022 09:18:47 +0200
Message-Id: <20220621071848.14834-5-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621071848.14834-1-j@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
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
They also come with mandatory sub-page protection now which we just
configure to always allow access to the entire page. This feature is
already present but optional on the previous DARTs which allows to
unconditionally configure it.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>

---

Changes in v3:
- apply change to io-pgtable-dart.c
- handle pte <> paddr conversion based on the pte format instead of
  the output address size

Changes in v2:
- add APPLE_DART2 PTE format

 drivers/iommu/io-pgtable-dart.c | 51 +++++++++++++++++++++++++++------
 drivers/iommu/io-pgtable.c      |  1 +
 include/linux/io-pgtable.h      |  1 +
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index fa8025c03bb5..9c3c2505f3dc 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -68,12 +68,19 @@
 #define APPLE_DART_PTE_SUBPAGE_END     GENMASK_ULL(51, 40)
 
 #define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
+#define APPLE_DART2_PADDR_MASK	GENMASK_ULL(37, 10)
+#define APPLE_DART2_PADDR_SHIFT	(4)
 
 /* Apple DART1 protection bits */
 #define APPLE_DART1_PTE_PROT_NO_READ	BIT(8)
 #define APPLE_DART1_PTE_PROT_NO_WRITE	BIT(7)
 #define APPLE_DART1_PTE_PROT_SP_DIS	BIT(1)
 
+/* Apple DART2 protection bits */
+#define APPLE_DART2_PTE_PROT_NO_READ	BIT(3)
+#define APPLE_DART2_PTE_PROT_NO_WRITE	BIT(2)
+#define APPLE_DART2_PTE_PROT_NO_CACHE	BIT(1)
+
 /* marks PTE as valid */
 #define APPLE_DART_PTE_VALID		BIT(0)
 
@@ -101,13 +108,31 @@ static inline bool iopte_leaf(dart_iopte pte, int lvl,
 static dart_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct dart_io_pgtable *data)
 {
-	return paddr & APPLE_DART1_PADDR_MASK;
+	dart_iopte pte;
+
+	if (data->iop.fmt == APPLE_DART)
+		return paddr & APPLE_DART1_PADDR_MASK;
+
+	/* format is APPLE_DART2 */
+	pte = paddr >> APPLE_DART2_PADDR_SHIFT;
+	pte &= APPLE_DART2_PADDR_MASK;
+
+	return pte;
 }
 
 static phys_addr_t iopte_to_paddr(dart_iopte pte,
 				  struct dart_io_pgtable *data)
 {
-	return pte & APPLE_DART1_PADDR_MASK;
+	u64 paddr;
+
+	if (data->iop.fmt == APPLE_DART)
+		return pte & APPLE_DART1_PADDR_MASK;
+
+	/* format is APPLE_DART2 */
+	paddr = pte & APPLE_DART2_PADDR_MASK;
+	paddr <<= APPLE_DART2_PADDR_SHIFT;
+
+	return paddr;
 }
 
 static void *__dart_alloc_pages(size_t size, gfp_t gfp,
@@ -139,7 +164,7 @@ static void __dart_init_pte(struct dart_io_pgtable *data,
 	size_t sz = DART_BLOCK_SIZE(lvl, data);
 	int i;
 
-	if (lvl == DART_MAX_LEVELS - 1)
+	if (lvl == DART_MAX_LEVELS - 1 && data->iop.fmt == APPLE_DART)
 		pte |= APPLE_DART1_PTE_PROT_SP_DIS;
 
 	pte |= APPLE_DART_PTE_VALID;
@@ -251,10 +276,20 @@ static dart_iopte dart_prot_to_pte(struct dart_io_pgtable *data,
 {
 	dart_iopte pte = 0;
 
-	if (!(prot & IOMMU_WRITE))
-		pte |= APPLE_DART1_PTE_PROT_NO_WRITE;
-	if (!(prot & IOMMU_READ))
-		pte |= APPLE_DART1_PTE_PROT_NO_READ;
+	if (data->iop.fmt == APPLE_DART) {
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART1_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART1_PTE_PROT_NO_READ;
+	}
+	if (data->iop.fmt == APPLE_DART2) {
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART2_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART2_PTE_PROT_NO_READ;
+		if (!(prot & IOMMU_CACHE))
+			pte |= APPLE_DART2_PTE_PROT_NO_CACHE;
+	}
 
 	return pte;
 }
@@ -536,7 +571,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	if (!cfg->coherent_walk)
 		return NULL;
 
-	if (cfg->oas > 36)
+	if (cfg->oas != 36 && cfg->oas != 42)
 		return NULL;
 
 	data = dart_alloc_pgtable(cfg);
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index e6edc6686859..a5d0f01afa7b 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -23,6 +23,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #endif
 #ifdef CONFIG_APPLE_DART
 	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
+	[APPLE_DART2] = &io_pgtable_apple_dart_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86af6f0a00a2..76b98511cbc8 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -17,6 +17,7 @@ enum io_pgtable_fmt {
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
 	APPLE_DART,
+	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
 };
 
-- 
2.35.1

