Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEAC484310
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiADOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:10:08 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53871 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232748AbiADOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:10:07 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="106004409"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jan 2022 23:10:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 728D141F57FF;
        Tue,  4 Jan 2022 23:10:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: at91-pio4: Use platform_get_irq() to get the interrupt
Date:   Tue,  4 Jan 2022 14:09:13 +0000
Message-Id: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
code use platform_get_irq().

While at it, replace the dev_err() with dev_dbg() as platform_get_irq()
prints an error message upon error.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Switched using platform_get_irq()
* Replaced dev_err() with dev_dbg()

v1: https://lore.kernel.org/lkml/20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index fafd1f55cba7..517f2a6330ad 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1045,7 +1045,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	const char **group_names;
 	const struct of_device_id *match;
 	int i, ret;
-	struct resource	*res;
 	struct atmel_pioctrl *atmel_pioctrl;
 	const struct atmel_pioctrl_data *atmel_pioctrl_data;
 
@@ -1164,16 +1163,15 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 
 	/* There is one controller but each bank has its own irq line. */
 	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			dev_err(dev, "missing irq resource for group %c\n",
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0) {
+			dev_dbg(dev, "missing irq resource for group %c\n",
 				'A' + i);
-			return -EINVAL;
+			return ret;
 		}
-		atmel_pioctrl->irqs[i] = res->start;
-		irq_set_chained_handler_and_data(res->start,
-			atmel_gpio_irq_handler, atmel_pioctrl);
-		dev_dbg(dev, "bank %i: irq=%pr\n", i, res);
+		atmel_pioctrl->irqs[i] = ret;
+		irq_set_chained_handler_and_data(ret, atmel_gpio_irq_handler, atmel_pioctrl);
+		dev_dbg(dev, "bank %i: irq=%d\n", i, ret);
 	}
 
 	atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
-- 
2.17.1

