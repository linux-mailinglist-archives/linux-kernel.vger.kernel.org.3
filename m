Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3B47C8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhLUV1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:27:12 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10647 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236809AbhLUV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:27:10 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104266477"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 06:27:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 490DA41082DB;
        Wed, 22 Dec 2021 06:27:08 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] mtd: rawnand: gpmi: Use platform_get_irq_byname() to get the interrupt
Date:   Tue, 21 Dec 2021 21:26:09 +0000
Message-Id: <20211221212609.31290-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221212609.31290-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221212609.31290-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_byname().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index feccff8bdd15..1b64c5a5140d 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -991,16 +991,13 @@ static int acquire_bch_irq(struct gpmi_nand_data *this, irq_handler_t irq_h)
 {
 	struct platform_device *pdev = this->pdev;
 	const char *res_name = GPMI_NAND_BCH_INTERRUPT_RES_NAME;
-	struct resource *r;
 	int err;
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res_name);
-	if (!r) {
-		dev_err(this->dev, "Can't get resource for %s\n", res_name);
-		return -ENODEV;
-	}
+	err = platform_get_irq_byname(pdev, res_name);
+	if (err < 0)
+		return err;
 
-	err = devm_request_irq(this->dev, r->start, irq_h, 0, res_name, this);
+	err = devm_request_irq(this->dev, err, irq_h, 0, res_name, this);
 	if (err)
 		dev_err(this->dev, "error requesting BCH IRQ\n");
 
-- 
2.17.1

