Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53F4DA167
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbiCORkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiCORkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:40:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF5E58E41;
        Tue, 15 Mar 2022 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1647365968; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Kvu8imCV/205X9z6pdv/O03duWWurdxgxEOtz6zczms=;
        b=1HHK8mOJeDjg6wkB4fkuJ6XrAUTF9dacI6X/fneskI0OgCsbe1ULjZoO8+m/6zmBLC9yDY
        iyCcdtTASMk4VYYu7v3IvtINj86mkDNtt5tiCPRCZ5Dp9ZMao/JEK0XbDuFkVWd1VhYK0X
        vsMM9MxuT6RFJY0z/Yipfb6udtERBiA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     od@opendingux.net, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] pinctrl: ingenic: Garbage-collect code paths for SoCs disabled by config
Date:   Tue, 15 Mar 2022 17:39:22 +0000
Message-Id: <20220315173922.153389-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By being a bit smarter about how the SoC version checks are performed,
it is possible to have all the code paths that correspond to SoCs
disabled in the kernel config automatically marked as dead code by the
compiler, and therefore garbage-collected.

With this patch, when compiling a kernel that only targets the JZ4760
for instance, the driver is now about 4.5 KiB smaller.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 118 ++++++++++++++++++------------
 1 file changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2712f51eb238..61d42a5e9768 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -137,6 +137,30 @@ struct ingenic_gpio_chip {
 	unsigned int irq, reg_base;
 };
 
+static const u32 enabled_socs =
+	IS_ENABLED(CONFIG_MACH_JZ4730) << ID_JZ4730 |
+	IS_ENABLED(CONFIG_MACH_JZ4740) << ID_JZ4740 |
+	IS_ENABLED(CONFIG_MACH_JZ4725B) << ID_JZ4725B |
+	IS_ENABLED(CONFIG_MACH_JZ4750) << ID_JZ4750 |
+	IS_ENABLED(CONFIG_MACH_JZ4755) << ID_JZ4755 |
+	IS_ENABLED(CONFIG_MACH_JZ4760) << ID_JZ4760 |
+	IS_ENABLED(CONFIG_MACH_JZ4770) << ID_JZ4770 |
+	IS_ENABLED(CONFIG_MACH_JZ4775) << ID_JZ4775 |
+	IS_ENABLED(CONFIG_MACH_JZ4780) << ID_JZ4780 |
+	IS_ENABLED(CONFIG_MACH_X1000) << ID_X1000 |
+	IS_ENABLED(CONFIG_MACH_X1500) << ID_X1500 |
+	IS_ENABLED(CONFIG_MACH_X1830) << ID_X1830 |
+	IS_ENABLED(CONFIG_MACH_X2000) << ID_X2000 |
+	IS_ENABLED(CONFIG_MACH_X2100) << ID_X2100;
+
+static bool
+is_soc_or_above(const struct ingenic_pinctrl *jzpc, enum jz_version version)
+{
+	return (enabled_socs >> version) &&
+		(!(enabled_socs & GENMASK((unsigned int)version - 1, 0))
+		 || jzpc->info->version >= version);
+}
+
 static const u32 jz4730_pull_ups[4] = {
 	0x3fa3320f, 0xf200ffff, 0xffffffff, 0xffffffff,
 };
@@ -3203,7 +3227,7 @@ static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
 static void ingenic_gpio_set_bit(struct ingenic_gpio_chip *jzgc,
 		u8 reg, u8 offset, bool set)
 {
-	if (jzgc->jzpc->info->version == ID_JZ4730) {
+	if (!is_soc_or_above(jzgc->jzpc, ID_JZ4740)) {
 		regmap_update_bits(jzgc->jzpc->map, jzgc->reg_base + reg,
 				BIT(offset), set ? BIT(offset) : 0);
 		return;
@@ -3261,9 +3285,9 @@ static inline bool ingenic_gpio_get_value(struct ingenic_gpio_chip *jzgc,
 static void ingenic_gpio_set_value(struct ingenic_gpio_chip *jzgc,
 				   u8 offset, int value)
 {
-	if (jzgc->jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
-	else if (jzgc->jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_DATA, offset, !!value);
@@ -3298,10 +3322,10 @@ static void irq_set_type(struct ingenic_gpio_chip *jzgc,
 		break;
 	}
 
-	if (jzgc->jzpc->info->version >= ID_JZ4770) {
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770)) {
 		reg1 = JZ4770_GPIO_PAT1;
 		reg2 = JZ4770_GPIO_PAT0;
-	} else if (jzgc->jzpc->info->version >= ID_JZ4740) {
+	} else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740)) {
 		reg1 = JZ4740_GPIO_TRIG;
 		reg2 = JZ4740_GPIO_DIR;
 	} else {
@@ -3311,12 +3335,12 @@ static void irq_set_type(struct ingenic_gpio_chip *jzgc,
 		return;
 	}
 
-	if (jzgc->jzpc->info->version >= ID_X2000) {
+	if (is_soc_or_above(jzgc->jzpc, ID_X2000)) {
 		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
 		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
 		ingenic_gpio_shadow_set_bit_load(jzgc);
 		ingenic_gpio_set_bit(jzgc, X2000_GPIO_EDG, offset, val3);
-	} else if (jzgc->jzpc->info->version >= ID_X1000) {
+	} else if (is_soc_or_above(jzgc->jzpc, ID_X1000)) {
 		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
 		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
 		ingenic_gpio_shadow_set_bit_load(jzgc);
@@ -3332,7 +3356,7 @@ static void ingenic_gpio_irq_mask(struct irq_data *irqd)
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 	int irq = irqd->hwirq;
 
-	if (jzgc->jzpc->info->version >= ID_JZ4740)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, true);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIMR, irq, true);
@@ -3344,7 +3368,7 @@ static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 	int irq = irqd->hwirq;
 
-	if (jzgc->jzpc->info->version >= ID_JZ4740)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, false);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIMR, irq, false);
@@ -3356,9 +3380,9 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 	int irq = irqd->hwirq;
 
-	if (jzgc->jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
-	else if (jzgc->jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, true);
@@ -3374,9 +3398,9 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
 
 	ingenic_gpio_irq_mask(irqd);
 
-	if (jzgc->jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
-	else if (jzgc->jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
@@ -3390,7 +3414,7 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
 	bool high;
 
 	if ((irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) &&
-		(jzgc->jzpc->info->version < ID_X2000)) {
+	    !is_soc_or_above(jzgc->jzpc, ID_X2000)) {
 		/*
 		 * Switch to an interrupt for the opposite edge to the one that
 		 * triggered the interrupt being ACKed.
@@ -3402,9 +3426,9 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
 			irq_set_type(jzgc, irq, IRQ_TYPE_LEVEL_HIGH);
 	}
 
-	if (jzgc->jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
-	else if (jzgc->jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPFR, irq, false);
@@ -3429,7 +3453,7 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 		irq_set_handler_locked(irqd, handle_bad_irq);
 	}
 
-	if ((type == IRQ_TYPE_EDGE_BOTH) && (jzgc->jzpc->info->version < ID_X2000)) {
+	if ((type == IRQ_TYPE_EDGE_BOTH) && !is_soc_or_above(jzgc->jzpc, ID_X2000)) {
 		/*
 		 * The hardware does not support interrupts on both edges. The
 		 * best we can do is to set up a single-edge interrupt and then
@@ -3461,9 +3485,9 @@ static void ingenic_gpio_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(irq_chip, desc);
 
-	if (jzgc->jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		flag = ingenic_gpio_read_reg(jzgc, JZ4770_GPIO_FLAG);
-	else if (jzgc->jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
 		flag = ingenic_gpio_read_reg(jzgc, JZ4740_GPIO_FLAG);
 	else
 		flag = ingenic_gpio_read_reg(jzgc, JZ4730_GPIO_GPFR);
@@ -3508,14 +3532,14 @@ static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
 	unsigned int offt = pin / PINS_PER_GPIO_CHIP;
 
 	if (set) {
-		if (jzpc->info->version >= ID_JZ4740)
+		if (is_soc_or_above(jzpc, ID_JZ4740))
 			regmap_write(jzpc->map, offt * jzpc->info->reg_offset +
 					REG_SET(reg), BIT(idx));
 		else
 			regmap_set_bits(jzpc->map, offt * jzpc->info->reg_offset +
 					reg, BIT(idx));
 	} else {
-		if (jzpc->info->version >= ID_JZ4740)
+		if (is_soc_or_above(jzpc, ID_JZ4740))
 			regmap_write(jzpc->map, offt * jzpc->info->reg_offset +
 					REG_CLEAR(reg), BIT(idx));
 		else
@@ -3574,12 +3598,12 @@ static int ingenic_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	struct ingenic_pinctrl *jzpc = jzgc->jzpc;
 	unsigned int pin = gc->base + offset;
 
-	if (jzpc->info->version >= ID_JZ4770) {
+	if (is_soc_or_above(jzpc, ID_JZ4770)) {
 		if (ingenic_get_pin_config(jzpc, pin, JZ4770_GPIO_INT) ||
 		    ingenic_get_pin_config(jzpc, pin, JZ4770_GPIO_PAT1))
 			return GPIO_LINE_DIRECTION_IN;
 		return GPIO_LINE_DIRECTION_OUT;
-	} else if (jzpc->info->version == ID_JZ4730) {
+	} else if (!is_soc_or_above(jzpc, ID_JZ4740)) {
 		if (!ingenic_get_pin_config(jzpc, pin, JZ4730_GPIO_GPDIR))
 			return GPIO_LINE_DIRECTION_IN;
 		return GPIO_LINE_DIRECTION_OUT;
@@ -3630,18 +3654,18 @@ static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
 	dev_dbg(jzpc->dev, "set pin P%c%u to function %u\n",
 			'A' + offt, idx, func);
 
-	if (jzpc->info->version >= ID_X1000) {
+	if (is_soc_or_above(jzpc, ID_X1000)) {
 		ingenic_shadow_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
 		ingenic_shadow_config_pin(jzpc, pin, GPIO_MSK, false);
 		ingenic_shadow_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, func & 0x2);
 		ingenic_shadow_config_pin(jzpc, pin, JZ4770_GPIO_PAT0, func & 0x1);
 		ingenic_shadow_config_pin_load(jzpc, pin);
-	} else if (jzpc->info->version >= ID_JZ4770) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4770)) {
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
 		ingenic_config_pin(jzpc, pin, GPIO_MSK, false);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, func & 0x2);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT0, func & 0x1);
-	} else if (jzpc->info->version >= ID_JZ4740) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4740)) {
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_FUNC, true);
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_TRIG, func & 0x2);
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_SELECT, func & 0x1);
@@ -3699,16 +3723,16 @@ static int ingenic_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	dev_dbg(pctldev->dev, "set pin P%c%u to %sput\n",
 			'A' + offt, idx, input ? "in" : "out");
 
-	if (jzpc->info->version >= ID_X1000) {
+	if (is_soc_or_above(jzpc, ID_X1000)) {
 		ingenic_shadow_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
 		ingenic_shadow_config_pin(jzpc, pin, GPIO_MSK, true);
 		ingenic_shadow_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, input);
 		ingenic_shadow_config_pin_load(jzpc, pin);
-	} else if (jzpc->info->version >= ID_JZ4770) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4770)) {
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_INT, false);
 		ingenic_config_pin(jzpc, pin, GPIO_MSK, true);
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, input);
-	} else if (jzpc->info->version >= ID_JZ4740) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4740)) {
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_SELECT, false);
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_DIR, !input);
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_FUNC, false);
@@ -3740,7 +3764,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 	unsigned int bias, reg;
 	bool pull, pullup, pulldown;
 
-	if (jzpc->info->version >= ID_X2000) {
+	if (is_soc_or_above(jzpc, ID_X2000)) {
 		pullup = ingenic_get_pin_config(jzpc, pin, X2000_GPIO_PEPU) &&
 				!ingenic_get_pin_config(jzpc, pin, X2000_GPIO_PEPD) &&
 				(jzpc->info->pull_ups[offt] & BIT(idx));
@@ -3748,7 +3772,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 				!ingenic_get_pin_config(jzpc, pin, X2000_GPIO_PEPU) &&
 				(jzpc->info->pull_downs[offt] & BIT(idx));
 
-	} else if (jzpc->info->version >= ID_X1830) {
+	} else if (is_soc_or_above(jzpc, ID_X1830)) {
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
 
@@ -3765,9 +3789,9 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 		pulldown = (bias == GPIO_PULL_DOWN) && (jzpc->info->pull_downs[offt] & BIT(idx));
 
 	} else {
-		if (jzpc->info->version >= ID_JZ4770)
+		if (is_soc_or_above(jzpc, ID_JZ4770))
 			pull = !ingenic_get_pin_config(jzpc, pin, JZ4770_GPIO_PEN);
-		else if (jzpc->info->version >= ID_JZ4740)
+		else if (is_soc_or_above(jzpc, ID_JZ4740))
 			pull = !ingenic_get_pin_config(jzpc, pin, JZ4740_GPIO_PULL_DIS);
 		else
 			pull = ingenic_get_pin_config(jzpc, pin, JZ4730_GPIO_GPPUR);
@@ -3796,9 +3820,9 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		if (jzpc->info->version >= ID_X2000)
+		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SMT;
-		else if (jzpc->info->version >= ID_X1830)
+		else if (is_soc_or_above(jzpc, ID_X1830))
 			reg = X1830_GPIO_SMT;
 		else
 			return -EINVAL;
@@ -3807,9 +3831,9 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_SLEW_RATE:
-		if (jzpc->info->version >= ID_X2000)
+		if (is_soc_or_above(jzpc, ID_X2000))
 			reg = X2000_GPIO_SR;
-		else if (jzpc->info->version >= ID_X1830)
+		else if (is_soc_or_above(jzpc, ID_X1830))
 			reg = X1830_GPIO_SR;
 		else
 			return -EINVAL;
@@ -3828,7 +3852,7 @@ static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
 static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 		unsigned int pin, unsigned int bias)
 {
-	if (jzpc->info->version >= ID_X2000) {
+	if (is_soc_or_above(jzpc, ID_X2000)) {
 		switch (bias) {
 		case GPIO_PULL_UP:
 			ingenic_config_pin(jzpc, pin, X2000_GPIO_PEPD, false);
@@ -3846,7 +3870,7 @@ static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 			ingenic_config_pin(jzpc, pin, X2000_GPIO_PEPD, false);
 		}
 
-	} else if (jzpc->info->version >= ID_X1830) {
+	} else if (is_soc_or_above(jzpc, ID_X1830)) {
 		unsigned int idx = pin % PINS_PER_GPIO_CHIP;
 		unsigned int half = PINS_PER_GPIO_CHIP / 2;
 		unsigned int idxh = (pin % half) * 2;
@@ -3864,9 +3888,9 @@ static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 					REG_SET(X1830_GPIO_PEH), bias << idxh);
 		}
 
-	} else if (jzpc->info->version >= ID_JZ4770) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4770)) {
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PEN, !bias);
-	} else if (jzpc->info->version >= ID_JZ4740) {
+	} else if (is_soc_or_above(jzpc, ID_JZ4740)) {
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_PULL_DIS, !bias);
 	} else {
 		ingenic_config_pin(jzpc, pin, JZ4730_GPIO_GPPUR, bias);
@@ -3876,7 +3900,7 @@ static void ingenic_set_bias(struct ingenic_pinctrl *jzpc,
 static void ingenic_set_schmitt_trigger(struct ingenic_pinctrl *jzpc,
 		unsigned int pin, bool enable)
 {
-	if (jzpc->info->version >= ID_X2000)
+	if (is_soc_or_above(jzpc, ID_X2000))
 		ingenic_config_pin(jzpc, pin, X2000_GPIO_SMT, enable);
 	else
 		ingenic_config_pin(jzpc, pin, X1830_GPIO_SMT, enable);
@@ -3885,9 +3909,9 @@ static void ingenic_set_schmitt_trigger(struct ingenic_pinctrl *jzpc,
 static void ingenic_set_output_level(struct ingenic_pinctrl *jzpc,
 				     unsigned int pin, bool high)
 {
-	if (jzpc->info->version >= ID_JZ4770)
+	if (is_soc_or_above(jzpc, ID_JZ4770))
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT0, high);
-	else if (jzpc->info->version >= ID_JZ4740)
+	else if (is_soc_or_above(jzpc, ID_JZ4740))
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_DATA, high);
 	else
 		ingenic_config_pin(jzpc, pin, JZ4730_GPIO_DATA, high);
@@ -3896,7 +3920,7 @@ static void ingenic_set_output_level(struct ingenic_pinctrl *jzpc,
 static void ingenic_set_slew_rate(struct ingenic_pinctrl *jzpc,
 		unsigned int pin, unsigned int slew)
 {
-	if (jzpc->info->version >= ID_X2000)
+	if (is_soc_or_above(jzpc, ID_X2000))
 		ingenic_config_pin(jzpc, pin, X2000_GPIO_SR, slew);
 	else
 		ingenic_config_pin(jzpc, pin, X1830_GPIO_SR, slew);
@@ -3952,7 +3976,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-			if (jzpc->info->version < ID_X1830)
+			if (!is_soc_or_above(jzpc, ID_X1830))
 				return -EINVAL;
 
 			ingenic_set_schmitt_trigger(jzpc, pin, arg);
@@ -3967,7 +3991,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_SLEW_RATE:
-			if (jzpc->info->version < ID_X1830)
+			if (!is_soc_or_above(jzpc, ID_X1830))
 				return -EINVAL;
 
 			ingenic_set_slew_rate(jzpc, pin, arg);
-- 
2.35.1

