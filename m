Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0A47D5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbhLVRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:19:44 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:43460 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344252AbhLVRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:19:30 -0500
X-IronPort-AV: E=Sophos;i="5.88,227,1635174000"; 
   d="scan'208";a="104377841"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 02:19:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 118B040062B3;
        Thu, 23 Dec 2021 02:19:27 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] gpio: rcar: Use platform_get_irq() to get the interrupt
Date:   Wed, 22 Dec 2021 17:19:15 +0000
Message-Id: <20211222171915.9053-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index f7b653314e7e..437baecc434e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -477,7 +477,6 @@ static void gpio_rcar_enable_inputs(struct gpio_rcar_priv *p)
 static int gpio_rcar_probe(struct platform_device *pdev)
 {
 	struct gpio_rcar_priv *p;
-	struct resource *irq;
 	struct gpio_chip *gpio_chip;
 	struct irq_chip *irq_chip;
 	struct gpio_irq_chip *girq;
@@ -502,12 +501,10 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(dev, "missing IRQ\n");
-		ret = -EINVAL;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto err0;
-	}
+	p->irq_parent = ret;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base)) {
@@ -555,8 +552,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	p->irq_parent = irq->start;
-	if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
+	if (devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
 			     IRQF_SHARED, name, p)) {
 		dev_err(dev, "failed to request IRQ\n");
 		ret = -ENOENT;
-- 
2.17.1

