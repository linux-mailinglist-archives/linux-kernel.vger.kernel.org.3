Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9ED54F781
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382302AbiFQM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382176AbiFQM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:28:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACE18E2D;
        Fri, 17 Jun 2022 05:27:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x5so5998455edi.2;
        Fri, 17 Jun 2022 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZV6bF1N6M/fDdBdeQQUl1WRFT6i8qExjpYE2JKv84QU=;
        b=iUHFJyqLefkvHrP4Uh2TghTM+s2k9S05eigE0yfjrJayvsqLxM4MXZVE++SeB1amJJ
         2OPBbq7OXwuBrIMTsLEQguAuxXUzmMNOrNQo3Ud+dMM4HvQDuXeVT3ORoCVJTh8oHRu5
         wEIYE8xkJgHOu34Oh0OWpW0HSrknvRj13nSPz8IHswUZJ//JV/UeQ/R8hck261zzeNvP
         Ca3InXsSdT8LxhKFREuV2u6UNo/I054JEJtHOThYn7v+hsHCFB1VknDdcV+XABLR0sGB
         eb2QrOWzzXRBPBlP4HL4fFoLyb0mxa82fcYgdL4Ir6gw2MArMDoDtoWs8k1ArryjuqPq
         pqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZV6bF1N6M/fDdBdeQQUl1WRFT6i8qExjpYE2JKv84QU=;
        b=QlhIk2P3ncU0muZ8OnM15cnU+qiX23yj/IzeeXWVXe5Gs7wK1vyhTygPiNeN2DMiLb
         Lpw9gifiwGy0bqtsewS7Dv4Wi1jWgsNzCTB/WMKYpAtG+MYa/E3xQYEosGtiXJyslTr7
         SGQHIexnorVPcz75ENtX2EqXKkxR1kEIEc+5Ofg/BU8Tn2o2gGMpFXE+t31uKIc9PHx+
         tEjgEvrxPCJbU3Jbw3NCKkuk4OfqqHxC7FawoELY3sPZVdsiD6Erx3oPIJJmxuxm88/F
         vcnWsL3ysJjgxflJM8cNaf7dX3FHKyFEtt4+FX9MuvObmpUmDV9OT9OYbb6HV1+u0qdR
         Z5IA==
X-Gm-Message-State: AJIora9PixKpM1unoWGElRZXsWWA087ZzErAobhWpzx2sbQ46d6lpZVf
        vW1fNDKb059TNy4kvH5b+hQ=
X-Google-Smtp-Source: AGRyM1tQsGRfojgQVf/3sVff7nFGuq9dmRCdRF12A/jmCQ3+fUrWM8IxkiRxjd+ZWQgcDRyyFMp5Vg==
X-Received: by 2002:aa7:cb95:0:b0:434:ef34:664f with SMTP id r21-20020aa7cb95000000b00434ef34664fmr11819392edt.236.1655468878446;
        Fri, 17 Jun 2022 05:27:58 -0700 (PDT)
Received: from localhost (92.40.168.194.threembb.co.uk. [92.40.168.194])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709064a0f00b00703671ebe65sm2070083eju.198.2022.06.17.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:27:58 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, paul@crapouillou.net
Cc:     maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl: ingenic: Use irqd_to_hwirq()
Date:   Fri, 17 Jun 2022 13:28:54 +0100
Message-Id: <20220617122855.739190-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
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

