Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1E52C35C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiERTaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbiERTaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:30:10 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBEF11BDD88;
        Wed, 18 May 2022 12:30:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,235,1647270000"; 
   d="scan'208";a="121409036"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 May 2022 04:30:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 29E3A4004CF5;
        Thu, 19 May 2022 04:30:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/7] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
Date:   Wed, 18 May 2022 20:29:20 +0100
Message-Id: <20220518192924.20948-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
a given point a maximum of only 32 GPIO pins can be used as IRQ lines in
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
index 690035124faa..43dbc4ee9d67 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1218,7 +1218,7 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
 	gc->irq.domain = irq_domain_create_hierarchy(
 		gc->irq.parent_domain,
 		0,
-		gc->ngpio,
+		gc->irq.ngirq ?: gc->ngpio,
 		gc->irq.fwnode,
 		&gc->irq.child_irq_domain_ops,
 		gc);
@@ -1578,7 +1578,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	} else {
 		/* Some drivers provide custom irqdomain ops */
 		gc->irq.domain = irq_domain_create_simple(fwnode,
-			gc->ngpio,
+			gc->irq.ngirq ?: gc->ngpio,
 			gc->irq.first,
 			gc->irq.domain_ops ?: &gpiochip_domain_ops,
 			gc);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index cb689264f3e9..4ec3f010df7c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -51,6 +51,14 @@ struct gpio_irq_chip {
 	 */
 	const struct irq_domain_ops *domain_ops;
 
+	/**
+	 * @ngirq:
+	 *
+	 * The number of GPIO IRQ's handled by this IRQ domain; usually is
+	 * equal to ngpio. If not set, ngpio will be used.
+	 */
+	u16 ngirq;
+
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @fwnode:
-- 
2.25.1

