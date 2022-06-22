Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E855538F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbiFVStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbiFVStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:49:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4793190F;
        Wed, 22 Jun 2022 11:49:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so171853wms.5;
        Wed, 22 Jun 2022 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JD3CVhGzKJhodjIuzbpzEj7UlthG3ar21iKOAqvLQWM=;
        b=oUqmK21G3oZkJSHALOK5ExZoZYR16MMpn6p/2TTR6XaiEed3ycYvMLlh6EaOzzOI5o
         Nu6QE6R0u3A1PxhowLKnisWwmnDE5Wys5ZFDW5Ix7p8AdvA9AoX7zPZZk/NcrE+DnN3h
         ef/7u+vba2ib5acU2Z+oi1XVzj6qnH87VMajAYbwisc93FqzqbLRu9DNCgIx/F5O2qX7
         glKKupcTPaYgygvdthQi6BwZ+o0jGcir1otko8COacrHRPtkTdmNqTNKRUNKrs69zK1f
         y0zHID0ICEpn6IXiLTa4/xecwLEPG9Udl3af8OLQ6nEjdUvrKmY7qa0w2+D57crLDu1b
         eo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JD3CVhGzKJhodjIuzbpzEj7UlthG3ar21iKOAqvLQWM=;
        b=HigK2ulrzSxfMDDC105wGcDoLzeazBYC9RDLv8I7iMmb3Ck3a3cGxBSgaQGTpJXsxP
         v7+8GlAUweoJB+swy137XhDOw2uw6UzirWT/lHrabtDbEz//RrlxdmS/eCxdA+QQe7IJ
         m8sF19NBEpu1LNk6Rh70yySkOZwCa3p3NV9k+/4+Av038j/jZ1hWqdczhecYRLphj+dF
         KJ8DlA4jSL5wXh6kQyKcPPh8Y9d210otbyMj+ejbLq+ukhPx9OyOh8X/jrkp98gsjM5o
         v4w8isfoBmUgNqtIoNNQrtx3YPQZE211+5Q8M2zSx0v7k1yc98d0iKH6zG7CeX3/l8VB
         4uzw==
X-Gm-Message-State: AOAM531+h1uo/3pWtWqSui33vGf99OrTAOP+8eHO0MBsIgVINKGYmU0P
        98XjC8SDwFRSDuQtufM3Gpw=
X-Google-Smtp-Source: ABdhPJwbSyiTrTY4YBQUfINu5k4GadZYjwdDcZ0/jFR5c5k+WAzLMBPnYUV25uKeZLddPIzVZIbiew==
X-Received: by 2002:a05:600c:4fd2:b0:39b:893e:ff79 with SMTP id o18-20020a05600c4fd200b0039b893eff79mr47380325wmq.73.1655923752715;
        Wed, 22 Jun 2022 11:49:12 -0700 (PDT)
Received: from localhost (92.40.170.233.threembb.co.uk. [92.40.170.233])
        by smtp.gmail.com with ESMTPSA id bp17-20020a5d5a91000000b0021b9870049dsm6015489wrb.82.2022.06.22.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:49:12 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org
Cc:     paul@crapouillou.net, maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] pinctrl: ingenic: Use irqd_to_hwirq()
Date:   Wed, 22 Jun 2022 19:50:09 +0100
Message-Id: <20220622185010.2022515-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220622185010.2022515-1-aidanmacdonald.0x0@gmail.com>
References: <20220622185010.2022515-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of accessing ->hwirq directly, use irqd_to_hwirq().

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 1ca11616db74..69e0d88665d3 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3393,7 +3393,7 @@ static void ingenic_gpio_irq_mask(struct irq_data *irqd)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
 	if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, true);
@@ -3405,7 +3405,7 @@ static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
 	if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, false);
@@ -3417,7 +3417,7 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
 	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
@@ -3433,7 +3433,7 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
 	ingenic_gpio_irq_mask(irqd);
 
@@ -3449,7 +3449,7 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
-	int irq = irqd->hwirq;
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 	bool high;
 
 	if ((irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) &&
@@ -3477,6 +3477,7 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
@@ -3498,12 +3499,12 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 		 * best we can do is to set up a single-edge interrupt and then
 		 * switch to the opposing edge when ACKing the interrupt.
 		 */
-		bool high = ingenic_gpio_get_value(jzgc, irqd->hwirq);
+		bool high = ingenic_gpio_get_value(jzgc, irq);
 
 		type = high ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_LEVEL_HIGH;
 	}
 
-	irq_set_type(jzgc, irqd->hwirq, type);
+	irq_set_type(jzgc, irq, type);
 	return 0;
 }
 
@@ -3668,20 +3669,22 @@ static const struct pinctrl_ops ingenic_pctlops = {
 static int ingenic_gpio_irq_request(struct irq_data *data)
 {
 	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t irq = irqd_to_hwirq(data);
 	int ret;
 
-	ret = ingenic_gpio_direction_input(gpio_chip, data->hwirq);
+	ret = ingenic_gpio_direction_input(gpio_chip, irq);
 	if (ret)
 		return ret;
 
-	return gpiochip_reqres_irq(gpio_chip, data->hwirq);
+	return gpiochip_reqres_irq(gpio_chip, irq);
 }
 
 static void ingenic_gpio_irq_release(struct irq_data *data)
 {
 	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t irq = irqd_to_hwirq(data);
 
-	return gpiochip_relres_irq(gpio_chip, data->hwirq);
+	return gpiochip_relres_irq(gpio_chip, irq);
 }
 
 static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
-- 
2.35.1

