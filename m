Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0248580C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiAESRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:17:31 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:49096 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242799AbiAESR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:17:29 -0500
X-IronPort-AV: E=Sophos;i="5.88,264,1635174000"; 
   d="scan'208";a="106131959"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jan 2022 03:17:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4EF1240C026A;
        Thu,  6 Jan 2022 03:17:26 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] ata: pata_of_platform: Use platform_get_irq_optional() to get the interrupt
Date:   Wed,  5 Jan 2022 18:17:21 +0000
Message-Id: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Note the code does not set the IRQ flags as this is handled automatically
for DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch is part of series [1]. I'll re-visit merging of pata_of_platform
into pata_platform at later point. As my primary focus is removal of static
setup of IRQ resource from DT core code.

[1] https://patchwork.ozlabs.org/project/linux-ide/list/?series=278349

v4->v5
* Set end member of IRQ resource
* Clear irq_res un-conditionally.

Cheers,
Prabhakar
---
 drivers/ata/pata_of_platform.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 35aa158fc976..c3a40b717dcd 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -25,11 +25,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	struct device_node *dn = ofdev->dev.of_node;
 	struct resource io_res;
 	struct resource ctl_res;
-	struct resource *irq_res;
+	struct resource irq_res;
 	unsigned int reg_shift = 0;
 	int pio_mode = 0;
 	int pio_mask;
 	bool use16bit;
+	int irq;
 
 	ret = of_address_to_resource(dn, 0, &io_res);
 	if (ret) {
@@ -45,7 +46,15 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 		return -EINVAL;
 	}
 
-	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	memset(&irq_res, 0, sizeof(irq_res));
+
+	irq = platform_get_irq_optional(ofdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq > 0) {
+		irq_res.start = irq;
+		irq_res.end = irq;
+	}
 
 	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
@@ -63,7 +72,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
-	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
+	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq > 0 ? &irq_res : NULL,
 				     reg_shift, pio_mask, &pata_platform_sht,
 				     use16bit);
 }
-- 
2.17.1

