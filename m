Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B4517D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiECGeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiECGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:34:07 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E45381A6;
        Mon,  2 May 2022 23:30:35 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 30E1126E9B7;
        Tue,  3 May 2022 08:23:04 +0200 (CEST)
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
Subject: [PATCH v2 4/4] iommu: dart: Support t6000 variant
Date:   Tue,  3 May 2022 08:23:01 +0200
Message-Id: <20220503062301.20872-5-j@jannau.net>
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

The M1 Pro/Max/Ultra SoCs come with a new variant of DART which
supports a larger physical address space with a different PTE format.
Pass through the correct paddr address space size and the PTE format
to the io-pgtable code which will take care of the rest.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes since v1:
 - use APPLE_DART PTE format for dart-t6000
---
 drivers/iommu/apple-dart.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..fe0dedd67fd8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -81,10 +81,16 @@
 #define DART_TTBR_VALID BIT(31)
 #define DART_TTBR_SHIFT 12
 
+struct apple_dart_hw {
+	u32 oas;
+	enum io_pgtable_fmt fmt;
+};
+
 /*
  * Private structure associated with each DART device.
  *
  * @dev: device struct
+ * @hw: SoC-specific hardware data
  * @regs: mapped MMIO region
  * @irq: interrupt number, can be shared with other DARTs
  * @clks: clocks associated with this DART
@@ -98,6 +104,7 @@
  */
 struct apple_dart {
 	struct device *dev;
+	const struct apple_dart_hw *hw;
 
 	void __iomem *regs;
 
@@ -421,13 +428,13 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 	pgtbl_cfg = (struct io_pgtable_cfg){
 		.pgsize_bitmap = dart->pgsize,
 		.ias = 32,
-		.oas = 36,
+		.oas = dart->hw->oas,
 		.coherent_walk = 1,
 		.iommu_dev = dart->dev,
 	};
 
 	dart_domain->pgtbl_ops =
-		alloc_io_pgtable_ops(APPLE_DART, &pgtbl_cfg, domain);
+		alloc_io_pgtable_ops(dart->hw->fmt, &pgtbl_cfg, domain);
 	if (!dart_domain->pgtbl_ops) {
 		ret = -ENOMEM;
 		goto done;
@@ -857,6 +864,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dart->dev = dev;
+	dart->hw = of_device_get_match_data(dev);
 	spin_lock_init(&dart->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -946,8 +954,18 @@ static int apple_dart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_dart_hw apple_dart_hw_t8103 = {
+	.oas = 36,
+	.fmt = APPLE_DART,
+};
+static const struct apple_dart_hw apple_dart_hw_t6000 = {
+	.oas = 42,
+	.fmt = APPLE_DART2,
+};
+
 static const struct of_device_id apple_dart_of_match[] = {
-	{ .compatible = "apple,t8103-dart", .data = NULL },
+	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
+	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, apple_dart_of_match);
-- 
2.35.1

