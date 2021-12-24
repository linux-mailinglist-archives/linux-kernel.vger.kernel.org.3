Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732C47EFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353018AbhLXO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:58:03 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:52340 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352999AbhLXO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:58:02 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104624983"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:58:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6487142C25A2;
        Fri, 24 Dec 2021 23:57:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-gpio@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pinctrl: at91-pio4: Use platform_get_irq_optional() to get the interrupt
Date:   Fri, 24 Dec 2021 14:57:48 +0000
Message-Id: <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index fafd1f55cba7..ebfb106be97d 100644
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
+		ret = platform_get_irq_optional(pdev, i);
+		if (ret < 0) {
 			dev_err(dev, "missing irq resource for group %c\n",
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

