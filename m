Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9125B114E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIHAca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIHAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41848D0231;
        Wed,  7 Sep 2022 17:31:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC6346601F82;
        Thu,  8 Sep 2022 01:31:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597075;
        bh=KoE33odj5CyvzAWPaRUWPkx5inoRUAcvU7UyZmtZi30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCfNqJJkhHfB3Y+uMtuSQZydn/iJ6wDpTfsOjajDBt/qdhP7aPZcSyYAq2bOeqxJC
         zDq+tdLks/ijAu5i84Z5EX+n8eTlvOiNax9EcSCMvykx4szAUSIbKx3YolxDIrBy4d
         bP7bHN/uz7SG36R0v9vPbdmnKsaDWhesem1OGDXJFwOE0DINTah+TekY4POxBpGJLr
         W5X6Pte2i0NWmChwupryrBQcumNFlvo2xa649QXqB2SNORQO3GDuR0BVsTH0A2t/iK
         xcEHD7nTPHV5jyOV07um/OUkbkW3vHMLaAbrD6w6Ih+Sw68LRN43IgpCkCDmQKmsFI
         e60BmARLC8AuA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 79D58480802; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
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
Subject: [PATCHv2 12/13] regulator: rk808: add rk806 support
Date:   Thu,  8 Sep 2022 02:31:06 +0200
Message-Id: <20220908003107.220143-13-sebastian.reichel@collabora.com>
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

Add rk806 support to the existing rk808 regulator
driver.

This has been implemented using shengfei Xu's rk806
specific driver from the vendor tree as reference.

Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
Signed-off-by: shengfei Xu <xsf@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 482 ++++++++++++++++++++++++++++
 1 file changed, 482 insertions(+)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index fa9fc1aa1ae3..cd1a2cff4a37 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -3,9 +3,11 @@
  * Regulator driver for Rockchip RK805/RK808/RK818
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
  *
  * Author: Chris Zhong <zyw@rock-chips.com>
  * Author: Zhang Qing <zhangqing@rock-chips.com>
+ * Author: Xu Shengfei <xsf@rock-chips.com>
  *
  * Copyright (C) 2016 PHYTEC Messtechnik GmbH
  *
@@ -39,6 +41,23 @@
 #define RK818_LDO3_ON_VSEL_MASK		0xf
 #define RK818_BOOST_ON_VSEL_MASK	0xe0
 
+#define RK806_DCDC_SLP_REG_OFFSET	0x0A
+#define RK806_NLDO_SLP_REG_OFFSET	0x05
+#define RK806_PLDO_SLP_REG_OFFSET	0x06
+
+#define RK806_BUCK_SEL_CNT		0xff
+#define RK806_LDO_SEL_CNT		0xff
+
+#define RK806_RAMP_RATE_4LSB_PER_1CLK	0x00/* LDO 100mV/uS buck 50mV/us */
+#define RK806_RAMP_RATE_2LSB_PER_1CLK	0x01/* LDO 50mV/uS buck 25mV/us */
+#define RK806_RAMP_RATE_1LSB_PER_1CLK	0x02/* LDO 25mV/uS buck 12.5mV/us */
+#define RK806_RAMP_RATE_1LSB_PER_2CLK	0x03/* LDO 12.5mV/uS buck 6.25mV/us */
+
+#define RK806_RAMP_RATE_1LSB_PER_4CLK	0x04/* LDO 6.28/2mV/uS buck 3.125mV/us */
+#define RK806_RAMP_RATE_1LSB_PER_8CLK	0x05/* LDO 3.12mV/uS buck 1.56mV/us */
+#define RK806_RAMP_RATE_1LSB_PER_13CLK	0x06/* LDO 1.9mV/uS buck 961mV/us */
+#define RK806_RAMP_RATE_1LSB_PER_32CLK	0x07/* LDO 0.78mV/uS buck 0.39mV/us */
+
 /* Ramp rate definitions for buck1 / buck2 only */
 #define RK808_RAMP_RATE_OFFSET		3
 #define RK808_RAMP_RATE_MASK		(3 << RK808_RAMP_RATE_OFFSET)
@@ -117,6 +136,31 @@
 	RK8XX_DESC_COM(_id, _match, _supply, _min, _max, _step, _vreg,	\
 	_vmask, _ereg, _emask, 0, 0, _etime, &rk805_reg_ops)
 
+#define RK806_REGULATOR(_name, _supply_name, _id, _ops,\
+			_n_voltages, _vr, _er, _lr, ctrl_bit, _rr, _rm)\
+[_id] = {\
+		.name = _name,\
+		.supply_name = _supply_name,\
+		.of_match = of_match_ptr(_name),\
+		.regulators_node = of_match_ptr("regulators"),\
+		.id = _id,\
+		.ops = &_ops,\
+		.type = REGULATOR_VOLTAGE,\
+		.n_voltages = _n_voltages,\
+		.linear_ranges = _lr,\
+		.n_linear_ranges = ARRAY_SIZE(_lr),\
+		.vsel_reg = _vr,\
+		.vsel_mask = 0xff,\
+		.enable_reg = _er,\
+		.enable_mask = ENABLE_MASK(ctrl_bit),\
+		.enable_val = ENABLE_MASK(ctrl_bit),\
+		.disable_val = DISABLE_VAL(ctrl_bit),\
+		.of_map_mode = rk8xx_regulator_of_map_mode,\
+		.ramp_reg = _rr,\
+		.ramp_mask = _rm,\
+		.owner = THIS_MODULE,\
+	}
+
 #define RK8XX_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
 	_vmask, _ereg, _emask, _etime)					\
 	RK8XX_DESC_COM(_id, _match, _supply, _min, _max, _step, _vreg,	\
@@ -153,6 +197,17 @@
 	RKXX_DESC_SWITCH_COM(_id, _match, _supply, _ereg, _emask,	\
 	0, 0, &rk808_switch_ops)
 
+struct rk8xx_register_bit {
+	u8 reg;
+	u8 bit;
+};
+
+#define RK8XX_REG_BIT(_reg, _bit)					\
+	{								\
+		.reg = _reg,						\
+		.bit = BIT(_bit),						\
+	}
+
 struct rk808_regulator_data {
 	struct gpio_desc *dvs_gpio[2];
 };
@@ -216,6 +271,223 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 	3000, 6300, 12500, 25000
 };
 
+static int rk806_get_voltage_sel_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int vsel_reg, ret;
+
+	vsel_reg = rdev->desc->vsel_reg;
+
+	ret = regmap_read(rdev->regmap, vsel_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	return val;
+}
+
+static int rk806_set_voltage(struct regulator_dev *rdev,
+			     int req_min_uV, int req_max_uV,
+			     unsigned int *selector)
+{
+	int vsel_reg, ret, sel;
+
+	ret = regulator_map_voltage_linear_range(rdev, req_min_uV, req_max_uV);
+	if (ret >= 0) {
+		*selector = ret;
+		sel = ret;
+	} else {
+		return -EINVAL;
+	}
+
+	vsel_reg = rdev->desc->vsel_reg;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+
+	ret = regmap_update_bits(rdev->regmap, vsel_reg,
+				 rdev->desc->vsel_mask, sel);
+
+	return ret;
+}
+
+static int rk806_set_mode_dcdc(struct regulator_dev *rdev, unsigned int mode)
+{
+	int rid = rdev_get_id(rdev);
+	int ctr_bit, reg;
+
+	reg = RK806_POWER_FPWM_EN0 + rid / 8;
+	ctr_bit = rid % 8;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		return regmap_update_bits(rdev->regmap, reg,
+					  PWM_MODE_MSK << ctr_bit,
+					  FPWM_MODE << ctr_bit);
+	case REGULATOR_MODE_NORMAL:
+		return regmap_update_bits(rdev->regmap, reg,
+					  PWM_MODE_MSK << ctr_bit,
+					  AUTO_PWM_MODE << ctr_bit);
+	default:
+		dev_err(rdev_get_dev(rdev), "mode unsupported: %u\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int rk806_get_mode_dcdc(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+	int ctr_bit, reg;
+	unsigned int val;
+	int err;
+
+	reg = RK806_POWER_FPWM_EN0 + rid / 8;
+	ctr_bit = rid % 8;
+
+	err = regmap_read(rdev->regmap, reg, &val);
+	if (err)
+		return err;
+
+	if ((val >> ctr_bit) & FPWM_MODE)
+		return REGULATOR_MODE_FAST;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static const struct rk8xx_register_bit rk806_dcdc_rate2[] = {
+	RK8XX_REG_BIT(0xEB, 0),
+	RK8XX_REG_BIT(0xEB, 1),
+	RK8XX_REG_BIT(0xEB, 2),
+	RK8XX_REG_BIT(0xEB, 3),
+	RK8XX_REG_BIT(0xEB, 4),
+	RK8XX_REG_BIT(0xEB, 5),
+	RK8XX_REG_BIT(0xEB, 6),
+	RK8XX_REG_BIT(0xEB, 7),
+	RK8XX_REG_BIT(0xEA, 0),
+	RK8XX_REG_BIT(0xEA, 1),
+};
+
+static int rk806_set_ramp_delay_dcdc(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+	int rid = rdev_get_id(rdev);
+	int regval, ret;
+
+	switch (ramp_delay) {
+	case 1 ... 390:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_32CLK;
+		break;
+	case 391 ... 961:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_13CLK;
+		break;
+	case 962 ... 1560:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_8CLK;
+		break;
+	case 1561 ... 3125:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_4CLK;
+		break;
+	case 3126 ... 6250:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_2CLK;
+		break;
+	case 6251 ... 12500:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_1CLK;
+		break;
+	case 12501 ... 25000:
+		ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+		break;
+	case 25001 ... 50000: /* 50mV/us */
+		ramp_value = RK806_RAMP_RATE_4LSB_PER_1CLK;
+		break;
+	default:
+		dev_warn(rdev_get_dev(rdev),
+			 "%s ramp_delay: %d not supported, setting 10000\n",
+			 rdev->desc->name, ramp_delay);
+	}
+
+	regval = ramp_value << (ffs(rdev->desc->ramp_mask) - 1);
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, regval);
+	if (ret)
+		return ret;
+
+	regval = (ramp_value >> 2) & 0x1 ? rk806_dcdc_rate2[rid].bit : 0;
+	return regmap_update_bits(rdev->regmap, rk806_dcdc_rate2[rid].reg,
+				  rk806_dcdc_rate2[rid].bit,
+				  regval);
+}
+
+
+static int rk806_set_ramp_delay_ldo(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+	int regval;
+
+	switch (ramp_delay) {
+	case 1 ... 780:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_32CLK;
+		break;
+	case 781 ... 1900:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_13CLK;
+		break;
+	case 1901 ... 3120:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_8CLK;
+		break;
+	case 3121 ... 6280:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_4CLK;
+		break;
+	case 6281 ... 12500:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_2CLK;
+		break;
+	case 12501 ... 25000:
+		ramp_value = RK806_RAMP_RATE_1LSB_PER_1CLK;
+		break;
+	case 25001 ... 50000:
+		ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+		break;
+	case 50001 ... 100000:
+		ramp_value = RK806_RAMP_RATE_4LSB_PER_1CLK;
+		break;
+	default:
+		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
+			rdev->desc->name, ramp_delay);
+	}
+
+	regval = ramp_value << (ffs(rdev->desc->ramp_mask) - 1);
+	return regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+				  rdev->desc->ramp_mask, regval);
+}
+
+static int rk806_set_suspend_voltage_range(struct regulator_dev *rdev, int reg_offset, int uv)
+{
+	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
+	unsigned int reg;
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg = rdev->desc->vsel_reg + reg_offset;
+
+	return regmap_update_bits(rdev->regmap, reg, rdev->desc->vsel_mask, sel);
+}
+
+static int rk806_set_suspend_voltage_range_dcdc(struct regulator_dev *rdev, int uv)
+{
+	return rk806_set_suspend_voltage_range(rdev, RK806_DCDC_SLP_REG_OFFSET, uv);
+}
+
+static int rk806_set_suspend_voltage_range_nldo(struct regulator_dev *rdev, int uv)
+{
+	return rk806_set_suspend_voltage_range(rdev, RK806_NLDO_SLP_REG_OFFSET, uv);
+}
+
+static int rk806_set_suspend_voltage_range_pldo(struct regulator_dev *rdev, int uv)
+{
+	return rk806_set_suspend_voltage_range(rdev, RK806_PLDO_SLP_REG_OFFSET, uv);
+}
+
 static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
 	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
@@ -393,6 +665,45 @@ static int rk805_set_suspend_disable(struct regulator_dev *rdev)
 				  0);
 }
 
+static const struct rk8xx_register_bit rk806_suspend_bits[] = {
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 0),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 1),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 2),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 3),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 4),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 5),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 6),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN0, 7),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 6),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 7),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 0),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 1),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 2),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 3),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN1, 4),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 1),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 2),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 3),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 4),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 5),
+	RK8XX_REG_BIT(RK806_POWER_SLP_EN2, 0),
+};
+
+static int rk806_set_suspend_enable(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+	return regmap_update_bits(rdev->regmap, rk806_suspend_bits[rid].reg,
+				  rk806_suspend_bits[rid].bit,
+				  rk806_suspend_bits[rid].bit);
+}
+
+static int rk806_set_suspend_disable(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+	return regmap_update_bits(rdev->regmap, rk806_suspend_bits[rid].reg,
+				  rk806_suspend_bits[rid].bit, 0);
+}
+
 static int rk808_set_suspend_enable(struct regulator_dev *rdev)
 {
 	unsigned int reg;
@@ -561,6 +872,66 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
+static const struct regulator_ops rk806_ops_dcdc = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+
+	.get_voltage_sel	= rk806_get_voltage_sel_regmap,
+	.set_voltage		= rk806_set_voltage,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.set_mode		= rk806_set_mode_dcdc,
+	.get_mode		= rk806_get_mode_dcdc,
+
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+
+	.set_suspend_mode	= rk806_set_mode_dcdc,
+	.set_ramp_delay		= rk806_set_ramp_delay_dcdc,
+
+	.set_suspend_voltage	= rk806_set_suspend_voltage_range_dcdc,
+	.set_suspend_enable	= rk806_set_suspend_enable,
+	.set_suspend_disable	= rk806_set_suspend_disable,
+};
+
+static const struct regulator_ops rk806_ops_nldo = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+
+	.get_voltage_sel	= rk806_get_voltage_sel_regmap,
+	.set_voltage		= rk806_set_voltage,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+
+	.set_ramp_delay		= rk806_set_ramp_delay_ldo,
+
+	.set_suspend_voltage	= rk806_set_suspend_voltage_range_nldo,
+	.set_suspend_enable	= rk806_set_suspend_enable,
+	.set_suspend_disable	= rk806_set_suspend_disable,
+};
+
+static const struct regulator_ops rk806_ops_pldo = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+
+	.get_voltage_sel	= rk806_get_voltage_sel_regmap,
+	.set_voltage		= rk806_set_voltage,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+
+	.set_ramp_delay		= rk806_set_ramp_delay_ldo,
+
+	.set_suspend_voltage	= rk806_set_suspend_voltage_range_pldo,
+	.set_suspend_enable	= rk806_set_suspend_enable,
+	.set_suspend_disable	= rk806_set_suspend_disable,
+};
+
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -743,6 +1114,112 @@ static const struct regulator_desc rk805_reg[] = {
 		BIT(2), 400),
 };
 
+static const struct linear_range rk806_buck_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 160, 6250), /* 500mV ~ 1500mV */
+	REGULATOR_LINEAR_RANGE(1500000, 161, 237, 25000), /* 1500mV ~ 3400mV */
+	REGULATOR_LINEAR_RANGE(3400000, 238, 255, 0),
+};
+
+static const struct linear_range rk806_ldo_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 232, 12500), /* 500mV ~ 3400mV */
+	REGULATOR_LINEAR_RANGE(3400000, 233, 255, 0), /* 500mV ~ 3400mV */
+};
+
+static const struct regulator_desc rk806_reg[] = {
+	RK806_REGULATOR("dcdc-reg1", "vcc1", RK806_ID_DCDC1, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK1_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK1_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg2", "vcc2", RK806_ID_DCDC2, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK2_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK2_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg3", "vcc3", RK806_ID_DCDC3, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK3_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 2,
+			RK806_BUCK3_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg4", "vcc4", RK806_ID_DCDC4, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK4_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 3,
+			RK806_BUCK4_CONFIG, 0xc0),
+
+	RK806_REGULATOR("dcdc-reg5", "vcc5", RK806_ID_DCDC5, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK5_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK5_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg6", "vcc6", RK806_ID_DCDC6, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK6_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK6_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg7", "vcc7", RK806_ID_DCDC7, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK7_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 2,
+			RK806_BUCK7_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg8", "vcc8", RK806_ID_DCDC8, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK8_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 3,
+			RK806_BUCK8_CONFIG, 0xc0),
+
+	RK806_REGULATOR("dcdc-reg9", "vcc9", RK806_ID_DCDC9, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK9_ON_VSEL,
+			RK806_POWER_EN2, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK9_CONFIG, 0xc0),
+	RK806_REGULATOR("dcdc-reg10", "vcc10", RK806_ID_DCDC10, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK10_ON_VSEL,
+			RK806_POWER_EN2, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK10_CONFIG, 0xc0),
+
+	RK806_REGULATOR("nldo-reg1", "vcc13", RK806_ID_NLDO1, rk806_ops_nldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO1_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+	RK806_REGULATOR("nldo-reg2", "vcc13", RK806_ID_NLDO2, rk806_ops_nldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO2_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+	RK806_REGULATOR("nldo-reg3", "vcc13", RK806_ID_NLDO3, rk806_ops_nldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO3_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+	RK806_REGULATOR("nldo-reg4", "vcc14", RK806_ID_NLDO4, rk806_ops_nldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO4_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 3,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("nldo-reg5", "vcc14", RK806_ID_NLDO5, rk806_ops_nldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO5_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("pldo-reg1", "vcc11", RK806_ID_PLDO1, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO1_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+	RK806_REGULATOR("pldo-reg2", "vcc11", RK806_ID_PLDO2, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO2_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+	RK806_REGULATOR("pldo-reg3", "vcc11", RK806_ID_PLDO3, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO3_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 3,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("pldo-reg4", "vcc12", RK806_ID_PLDO4, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO4_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+	RK806_REGULATOR("pldo-reg5", "vcc12", RK806_ID_PLDO5, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO5_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("pldo-reg6", "vcca", RK806_ID_PLDO6, rk806_ops_pldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO6_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+};
+
+
 static const struct regulator_desc rk808_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -1312,6 +1789,10 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 		regulators = rk805_reg;
 		nregulators = RK805_NUM_REGULATORS;
 		break;
+	case RK806_ID:
+		regulators = rk806_reg;
+		nregulators = ARRAY_SIZE(rk806_reg);
+		break;
 	case RK808_ID:
 		regulators = rk808_reg;
 		nregulators = RK808_NUM_REGULATORS;
@@ -1365,5 +1846,6 @@ MODULE_AUTHOR("Tony xie <tony.xie@rock-chips.com>");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
+MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rk808-regulator");
-- 
2.35.1

