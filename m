Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE9568C75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiGFPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiGFPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:16:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A906237EF;
        Wed,  6 Jul 2022 08:16:08 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B97622248;
        Wed,  6 Jul 2022 17:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657120566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1fHJMZl7JVZVxeg5jiWFWDAPjazuTqXidgDNR+l1Uo=;
        b=qUclemBVdHEmkD5WOlJeHrjDeWl26LsOZpTtHl6Oer9NZMsIUybGx/uckf3ddAAJVd+58j
        jvBAR3biT7aKoYBP9ju5hN6pJ1j9S4crhcum3voJ3A8y81aFjp+KOMzCnuz+zLgX7ywyY7
        qFf77ixPqHdD4DE0Hc8XJmB83GigeC0=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] pinctrl: ocelot: make irq_chip immutable
Date:   Wed,  6 Jul 2022 17:15:53 +0200
Message-Id: <20220706151553.1580790-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706151553.1580790-1-michael@walle.cc>
References: <20220706151553.1580790-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

[    2.593426] gpio gpiochip0: (ocelot-gpio): not an immutable chip, please consider fixing it!

Make it const, flag it as IRQCHIP_IMMUTABLE, add the new helper
functions and call the appropriate gpiolib functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 349e063a04fa..5902a77be5ef 100644
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
-- 
2.30.2

