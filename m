Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28871550726
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiFRVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiFRVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1FFD18;
        Sat, 18 Jun 2022 14:40:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y19so14586514ejq.6;
        Sat, 18 Jun 2022 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nl7z0tExnKw45HWY+96OFJvn6+pWo9OoqPRG2M0UkM=;
        b=blAT0KVa1AbrFFN+MId0cx9vTHtluF1XuqB9HiS8So8koWJ5RoIs6vjZ9aNShU74P7
         dzTuVwe7qbnkmlsYMI5CX1PnSSZ8ykODKW6hBXepq1wRAZnRBqHbnS75q25oaI9W2W9x
         bKgGmdbbtBFPAdpvWpj925iNInqaW0aVLyPuuohY1rrxtMFbsLQVMogZZVtOf7eY5v2H
         TlT129uE1Z4H6PvRqsJRdGvZi5sgUtVKGGmQhJ2YNNSdgM/Uzb97yeiURgeXzQcSqgI7
         AdUJC5fKwwdboVzTSnrjJNeUBfG8MsL2DyUOR26Qm+ZuS1A48kMv1vtNnYAzyUuI+PxK
         tWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nl7z0tExnKw45HWY+96OFJvn6+pWo9OoqPRG2M0UkM=;
        b=LVRi8/Pu51F7DFFElyB9fgayw+1b+90Sxe2lc5JPIy19FnocG6goXa9M/QRhJJ1k1w
         5ZblM5N6dmR3lTScwbf6yqcYdh29KBe0iTKgHvqD5my3Jm0c1zFlo/qQ/Nq6j/X4P7/E
         9x8T7aBQ/8foewOaPFVxjtx+I0zKmubCgZhYEMvo+9NREZUZnmcTPEiWezEsLnxaUfsO
         Nkyr0v5fCzGcHVJGqDaTfxiqmdrJbEJsVrbszGsZOhnlHjs1ii7hoEgsLQmO0lrG+94g
         PfuFviG0C0HjNwy1ebdoDVPx1mIfqSZ//MDel5zioAipau3+Gw9xjFC99khXRY+lNIb3
         zv0w==
X-Gm-Message-State: AJIora+P/XCVvVi49M/meV3QMuW4wE3aSVeJYsyoy8O5SAe/r4oxGcF0
        g0WGeOygNz2k51TMqBC+B+M=
X-Google-Smtp-Source: AGRyM1t7BdEGw9jHZWhTa8qiQmvrphDmcLY0bqNxND3UfcpwEK63ILLuO/2rNWhCzYC1c8Qu12UoQg==
X-Received: by 2002:a17:906:1c56:b0:70e:ad6d:5e87 with SMTP id l22-20020a1709061c5600b0070ead6d5e87mr15258716ejg.491.1655588416638;
        Sat, 18 Jun 2022 14:40:16 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b0070bdc059ab2sm3826993ejn.138.2022.06.18.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:16 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
Date:   Sat, 18 Jun 2022 22:40:06 +0100
Message-Id: <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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

The AXP192 PMIC's GPIO registers are much different from the GPIO
registers of the AXP20x and AXP813 PMICs supported by the existing
pinctrl-axp209 driver. It makes more sense to add a new driver for
the AXP192, rather than add support in the existing axp20x driver.

The pinctrl-axp192 driver is considerably more flexible in terms of
register layout and should be able to support other X-Powers PMICs.
Interrupts and pull down resistor configuration are supported too.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/Kconfig          |  14 +
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-axp192.c | 562 +++++++++++++++++++++++++++++++
 3 files changed, 577 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-axp192.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f52960d2dfbe..a71e35de333d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -113,6 +113,20 @@ config PINCTRL_AT91PIO4
 	  Say Y here to enable the at91 pinctrl/gpio driver for Atmel PIO4
 	  controller available on sama5d2 SoC.
 
+config PINCTRL_AXP192
+	tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
+	depends on MFD_AXP20X
+	depends on OF
+	select PINMUX
+	select GENERIC_PINCONF
+	select GPIOLIB
+	help
+	  AXP PMICs provides multiple GPIOs that can be muxed for different
+	  functions. This driver bundles a pinctrl driver to select the function
+	  muxing and a GPIO driver to handle the GPIO when the GPIO function is
+	  selected.
+	  Say Y to enable pinctrl and GPIO support for the AXP192 PMIC.
+
 config PINCTRL_AXP209
 	tristate "X-Powers AXP209 PMIC pinctrl and GPIO Support"
 	depends on MFD_AXP20X
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e76f5cdc64b0..9d2b6420c5dd 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PINCTRL_ARTPEC6)	+= pinctrl-artpec6.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)	+= pinctrl-at91-pio4.o
+obj-$(CONFIG_PINCTRL_AXP192)	+= pinctrl-axp192.o
 obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_BM1880)	+= pinctrl-bm1880.o
 obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
diff --git a/drivers/pinctrl/pinctrl-axp192.c b/drivers/pinctrl/pinctrl-axp192.c
new file mode 100644
index 000000000000..6a920258662d
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-axp192.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AXP192 pinctrl and GPIO driver
+ *
+ * Copyright (C) 2022 Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+enum {
+	AXP192_FUNC_OUTPUT = 0,
+	AXP192_FUNC_INPUT,
+	AXP192_FUNC_LDO,
+	AXP192_FUNC_PWM,
+	AXP192_FUNC_ADC,
+	AXP192_FUNC_LOW_OUTPUT,
+	AXP192_FUNC_FLOATING,
+	AXP192_FUNC_EXT_CHG_CTL,
+	AXP192_FUNC_LDO_STATUS,
+	AXP192_FUNCS_NB,
+};
+
+struct axp192_pctl_function {
+	const char		*name;
+	/* Mux value written to the control register to select the function (-1 if unsupported) */
+	const u8		*muxvals;
+	const char * const	*groups;
+	unsigned int		ngroups;
+};
+
+struct axp192_pctl_reg_info {
+	u8 reg;
+	u8 mask;
+};
+
+struct axp192_pctl_desc {
+	unsigned int				npins;
+	const struct pinctrl_pin_desc		*pins;
+	/* Description of the function control register for each pin */
+	const struct axp192_pctl_reg_info	*ctrl_regs;
+	/* Description of the output signal register for each pin */
+	const struct axp192_pctl_reg_info	*out_regs;
+	/* Description of the input signal register for each pin */
+	const struct axp192_pctl_reg_info	*in_regs;
+	/* Description of the pull down resistor config register for each pin */
+	const struct axp192_pctl_reg_info	*pull_down_regs;
+
+	unsigned int				nfunctions;
+	const struct axp192_pctl_function	*functions;
+};
+
+static const struct pinctrl_pin_desc axp192_pins[] = {
+	PINCTRL_PIN(0, "GPIO0"),
+	PINCTRL_PIN(1, "GPIO1"),
+	PINCTRL_PIN(2, "GPIO2"),
+	PINCTRL_PIN(3, "GPIO3"),
+	PINCTRL_PIN(4, "GPIO4"),
+	PINCTRL_PIN(5, "N_RSTO"),
+};
+
+static const char * const axp192_io_groups[] = { "GPIO0", "GPIO1", "GPIO2",
+						 "GPIO3", "GPIO4", "N_RSTO" };
+static const char * const axp192_ldo_groups[] = { "GPIO0" };
+static const char * const axp192_pwm_groups[] = { "GPIO1", "GPIO2" };
+static const char * const axp192_adc_groups[] = { "GPIO0", "GPIO1", "GPIO2", "GPIO3" };
+static const char * const axp192_extended_io_groups[] = { "GPIO0", "GPIO1", "GPIO2" };
+static const char * const axp192_ext_chg_ctl_groups[] = { "GPIO3", "GPIO4" };
+static const char * const axp192_ldo_status_groups[] = { "N_RSTO" };
+
+static const u8 axp192_output_muxvals[]		= {  0,  0,  0,  1,  1,  2 };
+static const u8 axp192_input_muxvals[]		= {  1,  1,  1,  2,  2,  3 };
+static const u8 axp192_ldo_muxvals[]		= {  2, -1, -1, -1, -1, -1 };
+static const u8 axp192_pwm_muxvals[]		= { -1,  2,  2, -1, -1, -1 };
+static const u8 axp192_adc_muxvals[]		= {  4,  4,  4,  3, -1, -1 };
+static const u8 axp192_low_output_muxvals[]	= {  5,  5,  5, -1, -1, -1 };
+static const u8 axp192_floating_muxvals[]	= {  6,  6,  6, -1, -1, -1 };
+static const u8 axp192_ext_chg_ctl_muxvals[]	= { -1, -1, -1,  0,  0, -1 };
+static const u8 axp192_ldo_status_muxvals[]	= { -1, -1, -1, -1, -1,  0 };
+
+static const struct axp192_pctl_function axp192_functions[AXP192_FUNCS_NB] = {
+	[AXP192_FUNC_OUTPUT] = {
+		.name = "output",
+		.muxvals = axp192_output_muxvals,
+		.groups = axp192_io_groups,
+		.ngroups = ARRAY_SIZE(axp192_io_groups),
+	},
+	[AXP192_FUNC_INPUT] = {
+		.name = "input",
+		.muxvals = axp192_input_muxvals,
+		.groups = axp192_io_groups,
+		.ngroups = ARRAY_SIZE(axp192_io_groups),
+	},
+	[AXP192_FUNC_LDO] = {
+		.name = "ldo",
+		.muxvals = axp192_ldo_muxvals,
+		.groups = axp192_ldo_groups,
+		.ngroups = ARRAY_SIZE(axp192_ldo_groups),
+	},
+	[AXP192_FUNC_PWM] = {
+		.name = "pwm",
+		.muxvals = axp192_pwm_muxvals,
+		.groups = axp192_pwm_groups,
+		.ngroups = ARRAY_SIZE(axp192_pwm_groups),
+	},
+	[AXP192_FUNC_ADC] = {
+		.name = "adc",
+		.muxvals = axp192_adc_muxvals,
+		.groups = axp192_adc_groups,
+		.ngroups = ARRAY_SIZE(axp192_adc_groups),
+	},
+	[AXP192_FUNC_LOW_OUTPUT] = {
+		.name = "low_output",
+		.muxvals = axp192_low_output_muxvals,
+		.groups = axp192_extended_io_groups,
+		.ngroups = ARRAY_SIZE(axp192_extended_io_groups),
+	},
+	[AXP192_FUNC_FLOATING] = {
+		.name = "floating",
+		.muxvals = axp192_floating_muxvals,
+		.groups = axp192_extended_io_groups,
+		.ngroups = ARRAY_SIZE(axp192_extended_io_groups),
+	},
+	[AXP192_FUNC_EXT_CHG_CTL] = {
+		.name = "ext_chg_ctl",
+		.muxvals = axp192_ext_chg_ctl_muxvals,
+		.groups = axp192_ext_chg_ctl_groups,
+		.ngroups = ARRAY_SIZE(axp192_ext_chg_ctl_groups),
+	},
+	[AXP192_FUNC_LDO_STATUS] = {
+		.name = "ldo_status",
+		.muxvals = axp192_ldo_status_muxvals,
+		.groups = axp192_ldo_groups,
+		.ngroups = ARRAY_SIZE(axp192_ldo_status_groups),
+	},
+};
+
+static const struct axp192_pctl_reg_info axp192_pin_ctrl_regs[] = {
+	{ .reg = AXP192_GPIO0_CTRL,   .mask = GENMASK(2, 0) },
+	{ .reg = AXP192_GPIO1_CTRL,   .mask = GENMASK(2, 0) },
+	{ .reg = AXP192_GPIO2_CTRL,   .mask = GENMASK(2, 0) },
+	{ .reg = AXP192_GPIO4_3_CTRL, .mask = GENMASK(1, 0) },
+	{ .reg = AXP192_GPIO4_3_CTRL, .mask = GENMASK(3, 2) },
+	{ .reg = AXP192_N_RSTO_CTRL,  .mask = GENMASK(7, 6) },
+};
+
+static const struct axp192_pctl_reg_info axp192_pin_in_regs[] = {
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(4) },
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(5) },
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(6) },
+	{ .reg = AXP192_GPIO4_3_STATE, .mask = BIT(4) },
+	{ .reg = AXP192_GPIO4_3_STATE, .mask = BIT(5) },
+	{ .reg = AXP192_N_RSTO_CTRL,   .mask = BIT(4) },
+};
+
+static const struct axp192_pctl_reg_info axp192_pin_out_regs[] = {
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(0) },
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(1) },
+	{ .reg = AXP192_GPIO2_0_STATE, .mask = BIT(2) },
+	{ .reg = AXP192_GPIO4_3_STATE, .mask = BIT(0) },
+	{ .reg = AXP192_GPIO4_3_STATE, .mask = BIT(1) },
+	{ .reg = AXP192_N_RSTO_CTRL,   .mask = BIT(5) },
+};
+
+static const struct axp192_pctl_reg_info axp192_pull_down_regs[] = {
+	{ .reg = AXP192_GPIO2_0_PULL, .mask = BIT(0) },
+	{ .reg = AXP192_GPIO2_0_PULL, .mask = BIT(1) },
+	{ .reg = AXP192_GPIO2_0_PULL, .mask = BIT(2) },
+	{ .reg = 0, .mask = 0 /* unsupported */ },
+	{ .reg = 0, .mask = 0 /* unsupported */ },
+	{ .reg = 0, .mask = 0 /* unsupported */ },
+};
+
+static const struct axp192_pctl_desc axp192_data = {
+	.npins = ARRAY_SIZE(axp192_pins),
+	.pins = axp192_pins,
+	.ctrl_regs = axp192_pin_ctrl_regs,
+	.out_regs = axp192_pin_out_regs,
+	.in_regs = axp192_pin_in_regs,
+	.pull_down_regs = axp192_pull_down_regs,
+
+	.nfunctions = ARRAY_SIZE(axp192_functions),
+	.functions = axp192_functions,
+};
+
+
+struct axp192_pctl {
+	struct gpio_chip		chip;
+	struct regmap			*regmap;
+	struct regmap_irq_chip_data	*regmap_irqc;
+	struct pinctrl_dev		*pctl_dev;
+	struct device			*dev;
+	const struct axp192_pctl_desc	*desc;
+	int				*irqs;
+};
+
+static int axp192_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct axp192_pctl *pctl = gpiochip_get_data(chip);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->in_regs[offset];
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & reginfo->mask);
+}
+
+static int axp192_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct axp192_pctl *pctl = gpiochip_get_data(chip);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->ctrl_regs[offset];
+	const u8 *input_muxvals = pctl->desc->functions[AXP192_FUNC_INPUT].muxvals;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
+	if (ret)
+		return ret;
+
+	if ((val & reginfo->mask) == (input_muxvals[offset] << (ffs(reginfo->mask) - 1)))
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static void axp192_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct axp192_pctl *pctl = gpiochip_get_data(chip);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->out_regs[offset];
+
+	regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask, value ? reginfo->mask : 0);
+}
+
+static int axp192_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(chip->base + offset);
+}
+
+static int axp192_gpio_direction_output(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	chip->set(chip, offset, value);
+	return 0;
+}
+
+static int axp192_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct axp192_pctl *pctl = gpiochip_get_data(chip);
+
+	/* GPIO IRQs are optional */
+	if (!pctl->irqs[offset])
+		return 0;
+
+	return regmap_irq_get_virq(pctl->regmap_irqc, pctl->irqs[offset]);
+}
+
+static int axp192_pinconf_get_pull_down(struct pinctrl_dev *pctldev, unsigned int pin)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->pull_down_regs[pin];
+	unsigned int val;
+	int ret;
+
+	if (!reginfo->mask)
+		return -ENOTSUPP;
+
+	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & reginfo->mask);
+}
+
+static int axp192_pinconf_set_pull_down(struct pinctrl_dev *pctldev, unsigned int pin, int value)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->pull_down_regs[pin];
+
+	if (!reginfo->mask)
+		return -ENOTSUPP;
+
+	return regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask,
+				  value ? reginfo->mask : 0);
+}
+
+static int axp192_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin, unsigned long *config)
+{
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	unsigned int arg = 1;
+	int ret;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		ret = axp192_pinconf_get_pull_down(pctldev, pin);
+		if (ret < 0)
+			return ret;
+		else if (ret != 0)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		ret = axp192_pinconf_get_pull_down(pctldev, pin);
+		if (ret < 0)
+			return ret;
+		else if (ret == 0)
+			return -EINVAL;
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int axp192_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			      unsigned long *configs, unsigned int num_configs)
+{
+	int ret;
+	unsigned int cfg;
+
+	for (cfg = 0; cfg < num_configs; ++cfg) {
+		switch (pinconf_to_config_param(configs[cfg])) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			ret = axp192_pinconf_set_pull_down(pctldev, pin, 0);
+			if (ret)
+				return ret;
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			ret = axp192_pinconf_set_pull_down(pctldev, pin, 1);
+			if (ret)
+				return ret;
+			break;
+
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops axp192_conf_ops = {
+	.is_generic = true,
+	.pin_config_get = axp192_pinconf_get,
+	.pin_config_set = axp192_pinconf_set,
+	.pin_config_group_get = axp192_pinconf_get,
+	.pin_config_group_set = axp192_pinconf_set,
+};
+
+static int axp192_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset, u8 config)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->ctrl_regs[offset];
+	unsigned int regval = config << (ffs(reginfo->mask) - 1);
+
+	return regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask, regval);
+}
+
+static int axp192_pmx_func_cnt(struct pinctrl_dev *pctldev)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->desc->nfunctions;
+}
+
+static const char *axp192_pmx_func_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->desc->functions[selector].name;
+}
+
+static int axp192_pmx_func_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+				  const char * const **groups, unsigned int *num_groups)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctl->desc->functions[selector].groups;
+	*num_groups = pctl->desc->functions[selector].ngroups;
+
+	return 0;
+}
+
+static int axp192_pmx_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int function, unsigned int group)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const u8 *muxvals = pctl->desc->functions[function].muxvals;
+
+	if (muxvals[group] == U8_MAX)
+		return -EINVAL;
+
+	/*
+	 * Switching to LDO or PWM function will enable LDO/PWM output, so it's
+	 * better to ignore these requests and let the regulator or PWM drivers
+	 * handle muxing to avoid interfering with them.
+	 */
+	if (function == AXP192_FUNC_LDO || function == AXP192_FUNC_PWM)
+		return 0;
+
+	return axp192_pmx_set(pctldev, group, muxvals[group]);
+}
+
+static int axp192_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int offset, bool input)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const u8 *muxvals = input ? pctl->desc->functions[AXP192_FUNC_INPUT].muxvals
+				  : pctl->desc->functions[AXP192_FUNC_OUTPUT].muxvals;
+
+	return axp192_pmx_set(pctldev, offset, muxvals[offset]);
+}
+
+static const struct pinmux_ops axp192_pmx_ops = {
+	.get_functions_count	= axp192_pmx_func_cnt,
+	.get_function_name	= axp192_pmx_func_name,
+	.get_function_groups	= axp192_pmx_func_groups,
+	.set_mux		= axp192_pmx_set_mux,
+	.gpio_set_direction	= axp192_pmx_gpio_set_direction,
+	.strict			= true,
+};
+
+static int axp192_groups_cnt(struct pinctrl_dev *pctldev)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->desc->npins;
+}
+
+static const char *axp192_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->desc->pins[selector].name;
+}
+
+static int axp192_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+			     const unsigned int **pins, unsigned int *num_pins)
+{
+	struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = &pctl->desc->pins[selector].number;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops axp192_pctrl_ops = {
+	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
+	.dt_free_map		= pinconf_generic_dt_free_map,
+	.get_groups_count	= axp192_groups_cnt,
+	.get_group_name		= axp192_group_name,
+	.get_group_pins		= axp192_group_pins,
+};
+
+static int axp192_pctl_probe(struct platform_device *pdev)
+{
+	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct axp192_pctl *pctl;
+	struct pinctrl_desc *pctrl_desc;
+	int ret, i;
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	pctl->desc = device_get_match_data(&pdev->dev);
+	pctl->regmap = axp20x->regmap;
+	pctl->regmap_irqc = axp20x->regmap_irqc;
+	pctl->dev = &pdev->dev;
+
+	pctl->chip.base			= -1;
+	pctl->chip.can_sleep		= true;
+	pctl->chip.request		= gpiochip_generic_request;
+	pctl->chip.free			= gpiochip_generic_free;
+	pctl->chip.parent		= &pdev->dev;
+	pctl->chip.label		= dev_name(&pdev->dev);
+	pctl->chip.owner		= THIS_MODULE;
+	pctl->chip.get			= axp192_gpio_get;
+	pctl->chip.get_direction	= axp192_gpio_get_direction;
+	pctl->chip.set			= axp192_gpio_set;
+	pctl->chip.direction_input	= axp192_gpio_direction_input;
+	pctl->chip.direction_output	= axp192_gpio_direction_output;
+	pctl->chip.to_irq		= axp192_gpio_to_irq;
+	pctl->chip.ngpio		= pctl->desc->npins;
+
+	pctl->irqs = devm_kcalloc(&pdev->dev, pctl->desc->npins, sizeof(int), GFP_KERNEL);
+	if (!pctl->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->desc->npins; ++i) {
+		ret = platform_get_irq_byname_optional(pdev, pctl->desc->pins[i].name);
+		if (ret > 0)
+			pctl->irqs[i] = ret;
+	}
+
+	platform_set_drvdata(pdev, pctl);
+
+	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+
+	pctrl_desc->name = dev_name(&pdev->dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = pctl->desc->pins;
+	pctrl_desc->npins = pctl->desc->npins;
+	pctrl_desc->pctlops = &axp192_pctrl_ops;
+	pctrl_desc->pmxops = &axp192_pmx_ops;
+	pctrl_desc->confops = &axp192_conf_ops;
+
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
+	if (IS_ERR(pctl->pctl_dev))
+		dev_err_probe(&pdev->dev, PTR_ERR(pctl->pctl_dev),
+			      "couldn't register pinctrl driver\n");
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctl->chip, pctl);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "Failed to register GPIO chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id axp192_pctl_match[] = {
+	{ .compatible = "x-powers,axp192-gpio", .data = &axp192_data, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axp192_pctl_match);
+
+static struct platform_driver axp192_pctl_driver = {
+	.probe		= axp192_pctl_probe,
+	.driver = {
+		.name		= "axp192-gpio",
+		.of_match_table	= axp192_pctl_match,
+	},
+};
+module_platform_driver(axp192_pctl_driver);
+
+MODULE_AUTHOR("Aidan MacDonald <aidanmacdonald.0x0@gmail.com>");
+MODULE_DESCRIPTION("AXP192 PMIC pinctrl and GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

