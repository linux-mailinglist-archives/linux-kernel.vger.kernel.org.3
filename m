Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3347C8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhLUV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:27:09 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10647 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236738AbhLUV1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:27:08 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104266473"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 06:27:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 11EDC41082DB;
        Wed, 22 Dec 2021 06:27:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] mtd: rawnand: omap_elm: Use platform_get_irq() to get the interrupt
Date:   Tue, 21 Dec 2021 21:26:08 +0000
Message-Id: <20211221212609.31290-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221212609.31290-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221212609.31290-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/nand/raw/omap_elm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 8bab753211e9..db105d9b560c 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -384,8 +384,8 @@ static irqreturn_t elm_isr(int this_irq, void *dev_id)
 static int elm_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct resource *irq;
 	struct elm_info *info;
+	int irq;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -393,20 +393,18 @@ static int elm_probe(struct platform_device *pdev)
 
 	info->dev = &pdev->dev;
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource defined\n");
-		return -ENODEV;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	info->elm_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->elm_base))
 		return PTR_ERR(info->elm_base);
 
-	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
-			pdev->name, info);
+	ret = devm_request_irq(&pdev->dev, irq, elm_isr, 0,
+			       pdev->name, info);
 	if (ret) {
-		dev_err(&pdev->dev, "failure requesting %pr\n", irq);
+		dev_err(&pdev->dev, "failure requesting %d\n", irq);
 		return ret;
 	}
 
-- 
2.17.1

