Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18254031B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbiFGPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbiFGPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB02193C5;
        Tue,  7 Jun 2022 08:52:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so2787509eja.1;
        Tue, 07 Jun 2022 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkqoJ8hk3ZkkFUbeKR2f5faZoPCUA3E3sl1P1aOekGM=;
        b=JCnietNcpG5VyzKBAjhmnW+jIn6bH5j6D3o73xgdsMHdQF1rTAF+mz/PL2+wKbsI2X
         ue+z0D7OPztcBZ6lC/Lz4DpG8cGLm1ImqWvT/tig2WEKEZrstyw0yDzxAad3LgcayLQ5
         tiZq2TuIXc0XiEULk2+A1NuNCgo5onBKcARwmtHzdcxfg74KS0nd10iMWJo9JVO66XS+
         wKtU8m/3QJ1462psu7cPYx8T/Rb7iL9hpgd0V2S2hiKFVDp/GbtNx9/XvUvJvRxPcU/e
         537beUcNFVgKhSb1jlVuc/ArtrnP21Vsh/DjqgCuenxwVPchW4bL2hvP/wEdzDmZ1cIc
         Tntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkqoJ8hk3ZkkFUbeKR2f5faZoPCUA3E3sl1P1aOekGM=;
        b=wbAlxVpJTHQ1BlVMgI7APNGKN9vq099t0k8T6eiU2XRokWJ5eY2pzT6wo8csTi580f
         YgCFHEEhNkT6C+sUoVs1P/9FOXsNUCEkrqks7z4saTgdKDbVKEG1Rx3ENmqaJcDyZOzu
         2Mz7qiOJCC0Yho0WrFY15IRmIU1RT3BhTZz/I+Jq1nh6IHppF8diKVax/wAZuCMy3t7+
         8TNm5DRA6XS3iJOYqVHtUQlGv51V0vRLqcn1HB3FRZPv3UadbIrBit8ZKX6vGGytzV44
         Obc8off7D2OVyowMU7cMUChE26Rayx6/GD5l+VkesB8zPa5uTsPn1AgJO+Ac/4IUyeFE
         wyPg==
X-Gm-Message-State: AOAM533gASkCT9mDQSUJnU/Zb84X1xQC459I+0patmvwEOrwlEo2zzgF
        8WTLWmc8i0maDDrOk1tXV4I=
X-Google-Smtp-Source: ABdhPJyjmlORdnZ4K5Ub+Nepzy1sdU/BKC9mZyCZQguFKrvQh2SisDrV37S2fKouHZkmqP3y2paWmQ==
X-Received: by 2002:a17:907:980e:b0:711:5342:7547 with SMTP id ji14-20020a170907980e00b0071153427547mr14604177ejc.544.1654617168887;
        Tue, 07 Jun 2022 08:52:48 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090685c700b007104b37aab7sm4949268ejy.106.2022.06.07.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:48 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 14/17] pinctrl: Add AXP192 pin control driver
Date:   Tue,  7 Jun 2022 16:53:21 +0100
Message-Id: <20220607155324.118102-15-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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
 drivers/pinctrl/pinctrl-axp192.c | 589 +++++++++++++++++++++++++++++++
 3 files changed, 604 insertions(+)
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
index 000000000000..0ff2d0b84978
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-axp192.c
@@ -0,0 +1,589 @@
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
+	{ .reg = AXP192_GPIO0_CTRL,   .mask = 0x07 },
+	{ .reg = AXP192_GPIO1_CTRL,   .mask = 0x07 },
+	{ .reg = AXP192_GPIO2_CTRL,   .mask = 0x07 },
+	{ .reg = AXP192_GPIO4_3_CTRL, .mask = 0x03 },
+	{ .reg = AXP192_GPIO4_3_CTRL, .mask = 0x0c },
+	{ .reg = AXP192_N_RSTO_CTRL,  .mask = 0xc0 },
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
+	else
+		return GPIO_LINE_DIRECTION_OUT;
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
+	return pctl->irqs[offset];
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
+		return -EOPNOTSUPP;
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
+		return -EOPNOTSUPP;
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
+		return -EOPNOTSUPP;
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
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			continue;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
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
+			/* unreachable */
+			break;
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
+	if (muxvals[group] == (u8)-1)
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
+	if (!of_device_is_available(pdev->dev.of_node))
+		return -ENODEV;
+
+	if (!axp20x) {
+		dev_err(&pdev->dev, "Parent drvdata not set\n");
+		return -EINVAL;
+	}
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	pctl->desc = of_device_get_match_data(&pdev->dev);
+	pctl->regmap = axp20x->regmap;
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
+			pctl->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, ret);
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
+	if (IS_ERR(pctl->pctl_dev)) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return PTR_ERR(pctl->pctl_dev);
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctl->chip, pctl);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
+		return ret;
+	}
+
+	ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
+				     pctl->desc->pins->number,
+				     pctl->desc->pins->number,
+				     pctl->desc->npins);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pin range\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "AXP192 pinctrl and GPIO driver loaded\n");
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
+
+module_platform_driver(axp192_pctl_driver);
+
+MODULE_AUTHOR("Aidan MacDonald <aidanmacdonald.0x0@gmail.com>");
+MODULE_DESCRIPTION("AXP192 PMIC pinctrl and GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

