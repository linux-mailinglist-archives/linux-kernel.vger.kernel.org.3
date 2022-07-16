Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38FE576D58
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiGPKvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 06:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 06:51:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFD1261D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 03:51:20 -0700 (PDT)
Date:   Sat, 16 Jul 2022 10:51:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657968679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ToVnBR8bVfwYff6uOctrSKz9LEqnHLVISbMa8FmLdY=;
        b=voCQ6g8S1traEjaju7S1pW9SIMzktpb94gWgQIvr9ePXf3rho2ApjmpAU9A9jWimYTZD1e
        IQSXgbHKjzQhQBzIMEjeV3J5cPLYDpnqhDu1Q3y9snzdWvbUmsXgRR5x8PqA/wA7i40Ist
        T0bWek6kMiR6WHxr/VAblJgQDH9JhJBv8g1FWJTKqvKUwctLrHCzLGabQrKOUC2YBmHtil
        YF7xrFEfD+iOaa9r87631xlfuzzGujCiEgZF+CO0vtJKg6Gf2DVabS+jpFXTGCqfUqrC/V
        vhwKXJr1P/7Upo7qHOHiEShAzMutG1My7aNDpVqHDgMgo4297yrCrwI+wShxaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657968679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ToVnBR8bVfwYff6uOctrSKz9LEqnHLVISbMa8FmLdY=;
        b=BS76s1S+JeZlFvFCb6oUymYcnogO9pTIdaoJ63E6ouwi/qpKoN00zpFxW/IJ19efWCcyvt
        ociKcaxfbwWvA4DQ==
From:   "irqchip-bot for Michael Walle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: ocelot: Make irq_chip immutable
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220706151553.1580790-2-michael@walle.cc>
References: <20220706151553.1580790-2-michael@walle.cc>
MIME-Version: 1.0
Message-ID: <165796867790.15455.12863870206141352541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     51ff93923e21ed2862e83f208706e3ca31d6f409
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/51ff93923e21ed2862e83f208706e3ca31d6f409
Author:        Michael Walle <michael@walle.cc>
AuthorDate:    Wed, 06 Jul 2022 17:15:53 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Jul 2022 11:47:45 +01:00

pinctrl: ocelot: Make irq_chip immutable

Since recently, the kernel is nagging about mutable irq_chips:

[    2.593426] gpio gpiochip0: (ocelot-gpio): not an immutable chip, please consider fixing it!

Make it const, flag it as IRQCHIP_IMMUTABLE, add the new helper
functions and call the appropriate gpiolib functions.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220706151553.1580790-2-michael@walle.cc
---
 drivers/pinctrl/pinctrl-ocelot.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 5f4a8c5..425c1a9 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1761,6 +1761,7 @@ static void ocelot_irq_mask(struct irq_data *data)
 
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   BIT(gpio % 32), 0);
+	gpiochip_disable_irq(chip, gpio);
 }
 
 static void ocelot_irq_unmask(struct irq_data *data)
@@ -1769,6 +1770,7 @@ static void ocelot_irq_unmask(struct irq_data *data)
 	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int gpio = irqd_to_hwirq(data);
 
+	gpiochip_enable_irq(chip, gpio);
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   BIT(gpio % 32), BIT(gpio % 32));
 }
@@ -1790,8 +1792,10 @@ static struct irq_chip ocelot_eoi_irqchip = {
 	.irq_mask	= ocelot_irq_mask,
 	.irq_eoi	= ocelot_irq_ack,
 	.irq_unmask	= ocelot_irq_unmask,
-	.flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,
+	.flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+			  IRQCHIP_IMMUTABLE,
 	.irq_set_type	= ocelot_irq_set_type,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
 
 static struct irq_chip ocelot_irqchip = {
@@ -1800,6 +1804,8 @@ static struct irq_chip ocelot_irqchip = {
 	.irq_ack	= ocelot_irq_ack,
 	.irq_unmask	= ocelot_irq_unmask,
 	.irq_set_type	= ocelot_irq_set_type,
+	.flags          = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
 
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type)
@@ -1863,7 +1869,7 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		girq = &gc->irq;
-		girq->chip = &ocelot_irqchip;
+		gpio_irq_chip_set_chip(girq, &ocelot_irqchip);
 		girq->parent_handler = ocelot_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,
