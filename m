Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2669A51F3C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiEIFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiEIFOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:14:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEA826269;
        Sun,  8 May 2022 22:10:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,210,1647270000"; 
   d="scan'208";a="120333429"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 May 2022 14:10:40 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B97D54004199;
        Mon,  9 May 2022 14:10:35 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
Date:   Mon,  9 May 2022 06:09:52 +0100
Message-Id: <20220509050953.11005-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supported GPIO IRQs by the chip is not always equal to the number of GPIO
pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
a give point a maximum of only 32 GPIO pins can be used as IRQ lines in
the IRQC domain.

This patch adds ngirq member to struct gpio_irq_chip and passes this as a
size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
being set in the driver otherwise fallbacks to using ngpio.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpiolib.c      | 4 ++--
 include/linux/gpio/driver.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7be01c70ee4e..4b402141580e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1221,7 +1221,7 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
 	gc->irq.domain = irq_domain_create_hierarchy(
 		gc->irq.parent_domain,
 		0,
-		gc->ngpio,
+		gc->irq.ngirq ?: gc->ngpio,
 		gc->irq.fwnode,
 		&gc->irq.child_irq_domain_ops,
 		gc);
@@ -1574,7 +1574,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	} else {
 		/* Some drivers provide custom irqdomain ops */
 		gc->irq.domain = irq_domain_create_simple(fwnode,
-			gc->ngpio,
+			gc->irq.ngirq ?: gc->ngpio,
 			gc->irq.first,
 			gc->irq.domain_ops ?: &gpiochip_domain_ops,
 			gc);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 874aabd270c9..ed6df186907d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -51,6 +51,14 @@ struct gpio_irq_chip {
 	 */
 	const struct irq_domain_ops *domain_ops;
 
+	/**
+	 * @ngirq:
+	 *
+	 * The number of GPIO IRQ's handled by this IRQ domain; usually is
+	 * equal to ngpio.
+	 */
+	u16 ngirq;
+
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @fwnode:
-- 
2.25.1

