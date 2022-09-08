Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF27A5B114C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIHAcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiIHAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5CA5718;
        Wed,  7 Sep 2022 17:31:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7A616601F7F;
        Thu,  8 Sep 2022 01:31:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597075;
        bh=XYYcbtJgv25KvQnOUHgNscwzxwqtYPVJyKex1PCPoKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlGmjVVzqOM5wEBDIyOplN6EJceYlDScrjsNpi054wNUUACeMzKYLSG1fHPciCnWv
         02jwkCu91qI9zGhzO32zToyNfYS48d6YZcIii4zhCGuSYxhFkTD6k9yKkyMThhc5Nn
         VnzeB1WI3SS5d5044Mqf/NZ3c2Qier0EPAwAFIVeorEBj9e98ZeFKuQPCfdzJlDkBr
         yR7i5/aXRxkwTEHL04WEo4bdBFV5HJG/sCT73PofZaIL/HU0h/JFFSNb2GC6F4S7a5
         aeD+S8cO5khtH0vdE/iBDMjMcGmGB5f5/HNtUGZ+6+ESJjyAWtpEj+I5blmcHIV5B9
         lFt6ziLnB0TPw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7466D48079F; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, shengfei Xu <xsf@rock-chips.com>
Subject: [PATCHv2 10/13] pinctrl: rk805: add rk806 pinctrl support
Date:   Thu,  8 Sep 2022 02:31:04 +0200
Message-Id: <20220908003107.220143-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908003107.220143-1-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for rk806 dvs pinctrl to the existing rk805
driver.

This has been implemented using shengfei Xu's rk806
specific driver from the vendor tree as reference.

Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
Signed-off-by: shengfei Xu <xsf@rock-chips.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pinctrl/pinctrl-rk805.c | 189 ++++++++++++++++++++++++++++----
 1 file changed, 168 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 7c1f7408fb9a..2639a9ee82cd 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Pinctrl driver for Rockchip RK805 PMIC
+ * Pinctrl driver for Rockchip RK805/RK806 PMIC
  *
  * Copyright (c) 2017, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
  *
  * Author: Joseph Chen <chenjh@rock-chips.com>
+ * Author: Xu Shengfei <xsf@rock-chips.com>
  *
  * Based on the pinctrl-as3722 driver
  */
@@ -44,6 +46,7 @@ struct rk805_pin_group {
 
 /*
  * @reg: gpio setting register;
+ * @fun_reg: functions select register;
  * @fun_mask: functions select mask value, when set is gpio;
  * @dir_mask: input or output mask value, when set is output, otherwise input;
  * @val_mask: gpio set value, when set is level high, otherwise low;
@@ -56,6 +59,7 @@ struct rk805_pin_group {
  */
 struct rk805_pin_config {
 	u8 reg;
+	u8 fun_reg;
 	u8 fun_msk;
 	u8 dir_msk;
 	u8 val_msk;
@@ -80,22 +84,50 @@ enum rk805_pinmux_option {
 	RK805_PINMUX_GPIO,
 };
 
+enum rk806_pinmux_option {
+	RK806_PINMUX_FUN0 = 0,
+	RK806_PINMUX_FUN1,
+	RK806_PINMUX_FUN2,
+	RK806_PINMUX_FUN3,
+	RK806_PINMUX_FUN4,
+	RK806_PINMUX_FUN5,
+};
+
 enum {
 	RK805_GPIO0,
 	RK805_GPIO1,
 };
 
+enum {
+	RK806_GPIO_DVS1,
+	RK806_GPIO_DVS2,
+	RK806_GPIO_DVS3
+};
+
 static const char *const rk805_gpio_groups[] = {
 	"gpio0",
 	"gpio1",
 };
 
+static const char *const rk806_gpio_groups[] = {
+	"gpio_pwrctrl1",
+	"gpio_pwrctrl2",
+	"gpio_pwrctrl3",
+};
+
 /* RK805: 2 output only GPIOs */
 static const struct pinctrl_pin_desc rk805_pins_desc[] = {
 	PINCTRL_PIN(RK805_GPIO0, "gpio0"),
 	PINCTRL_PIN(RK805_GPIO1, "gpio1"),
 };
 
+/* RK806 */
+static const struct pinctrl_pin_desc rk806_pins_desc[] = {
+	PINCTRL_PIN(RK806_GPIO_DVS1, "gpio_pwrctrl1"),
+	PINCTRL_PIN(RK806_GPIO_DVS2, "gpio_pwrctrl2"),
+	PINCTRL_PIN(RK806_GPIO_DVS3, "gpio_pwrctrl3"),
+};
+
 static const struct rk805_pin_function rk805_pin_functions[] = {
 	{
 		.name = "gpio",
@@ -105,6 +137,45 @@ static const struct rk805_pin_function rk805_pin_functions[] = {
 	},
 };
 
+static const struct rk805_pin_function rk806_pin_functions[] = {
+	{
+		.name = "pin_fun0",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN0,
+	},
+	{
+		.name = "pin_fun1",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN1,
+	},
+	{
+		.name = "pin_fun2",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN2,
+	},
+	{
+		.name = "pin_fun3",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN3,
+	},
+	{
+		.name = "pin_fun4",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN4,
+	},
+	{
+		.name = "pin_fun5",
+		.groups = rk806_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk806_gpio_groups),
+		.mux_option = RK806_PINMUX_FUN5,
+	},
+};
+
 static const struct rk805_pin_group rk805_pin_groups[] = {
 	{
 		.name = "gpio0",
@@ -118,6 +189,24 @@ static const struct rk805_pin_group rk805_pin_groups[] = {
 	},
 };
 
+static const struct rk805_pin_group rk806_pin_groups[] = {
+	{
+		.name = "gpio_pwrctrl1",
+		.pins = { RK806_GPIO_DVS1 },
+		.npins = 1,
+	},
+	{
+		.name = "gpio_pwrctrl2",
+		.pins = { RK806_GPIO_DVS2 },
+		.npins = 1,
+	},
+	{
+		.name = "gpio_pwrctrl3",
+		.pins = { RK806_GPIO_DVS3 },
+		.npins = 1,
+	}
+};
+
 #define RK805_GPIO0_VAL_MSK	BIT(0)
 #define RK805_GPIO1_VAL_MSK	BIT(1)
 
@@ -132,6 +221,40 @@ static const struct rk805_pin_config rk805_gpio_cfgs[] = {
 	},
 };
 
+#define RK806_PWRCTRL1_DR	BIT(0)
+#define RK806_PWRCTRL2_DR	BIT(1)
+#define RK806_PWRCTRL3_DR	BIT(2)
+#define RK806_PWRCTRL1_DATA	BIT(4)
+#define RK806_PWRCTRL2_DATA	BIT(5)
+#define RK806_PWRCTRL3_DATA	BIT(6)
+#define RK806_PWRCTRL1_FUN	GENMASK(2, 0)
+#define RK806_PWRCTRL2_FUN	GENMASK(6, 4)
+#define RK806_PWRCTRL3_FUN	GENMASK(2, 0)
+
+static struct rk805_pin_config rk806_gpio_cfgs[] = {
+	{
+		.fun_reg = RK806_SLEEP_CONFIG0,
+		.fun_msk = RK806_PWRCTRL1_FUN,
+		.reg = RK806_SLEEP_GPIO,
+		.val_msk = RK806_PWRCTRL1_DATA,
+		.dir_msk = RK806_PWRCTRL1_DR,
+	},
+	{
+		.fun_reg = RK806_SLEEP_CONFIG0,
+		.fun_msk = RK806_PWRCTRL2_FUN,
+		.reg = RK806_SLEEP_GPIO,
+		.val_msk = RK806_PWRCTRL2_DATA,
+		.dir_msk = RK806_PWRCTRL2_DR,
+	},
+	{
+		.fun_reg = RK806_SLEEP_CONFIG1,
+		.fun_msk = RK806_PWRCTRL3_FUN,
+		.reg = RK806_SLEEP_GPIO,
+		.val_msk = RK806_PWRCTRL3_DATA,
+		.dir_msk = RK806_PWRCTRL3_DR,
+	}
+};
+
 /* generic gpio chip */
 static int rk805_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
@@ -289,19 +412,13 @@ static int _rk805_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	if (!pci->pin_cfg[offset].fun_msk)
 		return 0;
 
-	if (mux == RK805_PINMUX_GPIO) {
-		ret = regmap_update_bits(pci->rk808->regmap,
-					 pci->pin_cfg[offset].reg,
-					 pci->pin_cfg[offset].fun_msk,
-					 pci->pin_cfg[offset].fun_msk);
-		if (ret) {
-			dev_err(pci->dev, "set gpio%d GPIO failed\n", offset);
-			return ret;
-		}
-	} else {
-		dev_err(pci->dev, "Couldn't find function mux %d\n", mux);
-		return -EINVAL;
-	}
+	mux <<= ffs(pci->pin_cfg[offset].fun_msk) - 1;
+	ret = regmap_update_bits(pci->rk808->regmap,
+				 pci->pin_cfg[offset].fun_reg,
+				 pci->pin_cfg[offset].fun_msk, mux);
+
+	if (ret)
+		dev_err(pci->dev, "set gpio%d func%d failed\n", offset, mux);
 
 	return 0;
 }
@@ -317,6 +434,22 @@ static int rk805_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	return _rk805_pinctrl_set_mux(pctldev, offset, mux);
 }
 
+static int rk805_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
+					     struct pinctrl_gpio_range *range,
+					     unsigned int offset)
+{
+	struct rk805_pctrl_info *pci = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (pci->rk808->variant) {
+	case RK805_ID:
+		return _rk805_pinctrl_set_mux(pctldev, offset, RK805_PINMUX_GPIO);
+	case RK806_ID:
+		return _rk805_pinctrl_set_mux(pctldev, offset, RK806_PINMUX_FUN5);
+	}
+
+	return -ENOTSUPP;
+}
+
 static int rk805_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					struct pinctrl_gpio_range *range,
 					unsigned int offset, bool input)
@@ -324,13 +457,6 @@ static int rk805_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct rk805_pctrl_info *pci = pinctrl_dev_get_drvdata(pctldev);
 	int ret;
 
-	/* switch to gpio function */
-	ret = _rk805_pinctrl_set_mux(pctldev, offset, RK805_PINMUX_GPIO);
-	if (ret) {
-		dev_err(pci->dev, "set gpio%d mux failed\n", offset);
-		return ret;
-	}
-
 	/* set direction */
 	if (!pci->pin_cfg[offset].dir_msk)
 		return 0;
@@ -352,6 +478,7 @@ static const struct pinmux_ops rk805_pinmux_ops = {
 	.get_function_name	= rk805_pinctrl_get_func_name,
 	.get_function_groups	= rk805_pinctrl_get_func_groups,
 	.set_mux		= rk805_pinctrl_set_mux,
+	.gpio_request_enable	= rk805_pinctrl_gpio_request_enable,
 	.gpio_set_direction	= rk805_pmx_gpio_set_direction,
 };
 
@@ -364,6 +491,7 @@ static int rk805_pinconf_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_OUTPUT:
+	case PIN_CONFIG_INPUT_ENABLE:
 		arg = rk805_gpio_get(&pci->gpio_chip, pin);
 		break;
 	default:
@@ -393,6 +521,12 @@ static int rk805_pinconf_set(struct pinctrl_dev *pctldev,
 			rk805_gpio_set(&pci->gpio_chip, pin, arg);
 			rk805_pmx_gpio_set_direction(pctldev, NULL, pin, false);
 			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			if (pci->rk808->variant != RK805_ID && arg) {
+				rk805_pmx_gpio_set_direction(pctldev, NULL, pin, true);
+				break;
+			}
+			fallthrough;
 		default:
 			dev_err(pci->dev, "Properties not supported\n");
 			return -ENOTSUPP;
@@ -448,6 +582,18 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 		pci->pin_cfg = rk805_gpio_cfgs;
 		pci->gpio_chip.ngpio = ARRAY_SIZE(rk805_gpio_cfgs);
 		break;
+	case RK806_ID:
+		pci->pins = rk806_pins_desc;
+		pci->num_pins = ARRAY_SIZE(rk806_pins_desc);
+		pci->functions = rk806_pin_functions;
+		pci->num_functions = ARRAY_SIZE(rk806_pin_functions);
+		pci->groups = rk806_pin_groups;
+		pci->num_pin_groups = ARRAY_SIZE(rk806_pin_groups);
+		pci->pinctrl_desc.pins = rk806_pins_desc;
+		pci->pinctrl_desc.npins = ARRAY_SIZE(rk806_pins_desc);
+		pci->pin_cfg = rk806_gpio_cfgs;
+		pci->gpio_chip.ngpio = ARRAY_SIZE(rk806_gpio_cfgs);
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported RK805 ID %lu\n",
 			pci->rk808->variant);
@@ -488,5 +634,6 @@ static struct platform_driver rk805_pinctrl_driver = {
 module_platform_driver(rk805_pinctrl_driver);
 
 MODULE_DESCRIPTION("RK805 pin control and GPIO driver");
+MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
 MODULE_AUTHOR("Joseph Chen <chenjh@rock-chips.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.35.1

