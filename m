Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A804C5A88A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiHaVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiHaVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:54:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16A5F97;
        Wed, 31 Aug 2022 14:54:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72F246601EA9;
        Wed, 31 Aug 2022 22:54:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661982887;
        bh=SmSEE72mpl4yzeQrQc4oxt0MYqr/9/Szsu435ZDpKAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBZz/yGJHH38Eta1z2932lEMZUxjHFAdsG+uVRnsn1xIlXNH6CkpYLEX7P+8dqbXM
         BWXnldIuskPAG+PHYrG7Pshd8TxtkZBnw8jcE9MkwjcKfBHf0aRApRGHLq0q2gjFy7
         JbyoOqqMuYBAKyTlI+FL2SWWgnrfEeT93QYx7Y4np5MDnClbSig+o5lv6i2ZenEs25
         Xc2pspVXQknbuqbdsX1D3St90bDoTb+dqp2uX0gdZynpVjvQtOzRa8OuXnxmwTrDVi
         RhlrqBnX3NnOmzWimya+64wZ/1Pxlh5Lfs4HtRmTKYFqRzZ22RoPFVvElBrHDErgm6
         0XOAkzUIsP+SQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 49EE3481226; Wed, 31 Aug 2022 23:54:43 +0200 (CEST)
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
Subject: [PATCH 12/13] regulator: rk808: add rk806 support
Date:   Wed, 31 Aug 2022 23:54:36 +0200
Message-Id: <20220831215437.117880-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831215437.117880-1-sebastian.reichel@collabora.com>
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
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
 drivers/regulator/rk808-regulator.c | 470 ++++++++++++++++++++++++++++
 1 file changed, 470 insertions(+)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index fa9fc1aa1ae3..60195e9addae 100644
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
@@ -216,6 +271,229 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 	3000, 6300, 12500, 25000
 };
 
+static int rk806_get_reg_offset(int id)
+{
+	int reg_offset = 0;
+
+	if (id >= RK806_ID_DCDC1 && id <= RK806_ID_DCDC10)
+		reg_offset = RK806_DCDC_SLP_REG_OFFSET;
+	else if ((id >= RK806_ID_NLDO1 && id <= RK806_ID_NLDO4) ||
+		 (id == RK806_ID_NLDO5))
+		reg_offset = RK806_NLDO_SLP_REG_OFFSET;
+	else if (id >= RK806_ID_PLDO1 && id <= RK806_ID_PLDO6)
+		reg_offset = RK806_PLDO_SLP_REG_OFFSET;
+
+	return reg_offset;
+}
+
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
+static int rk806_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int rid = rdev_get_id(rdev);
+	int ctr_bit, reg;
+
+	if (rid > RK806_ID_DCDC10)
+		return 0;
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
+static unsigned int rk806_get_mode(struct regulator_dev *rdev)
+{
+	int rid = rdev_get_id(rdev);
+	int ctr_bit, reg;
+	unsigned int val;
+	int err;
+
+	if (rid > RK806_ID_DCDC10)
+		return 0;
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
+static int rk806_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+	int rid = rdev_get_id(rdev);
+	int regval, ret;
+
+	if (rid <= RK806_ID_DCDC10) {
+		switch (ramp_delay) {
+		case 1 ... 390:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_32CLK;
+			break;
+		case 391 ... 961:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_13CLK;
+			break;
+		case 962 ... 1560:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_8CLK;
+			break;
+		case 1561 ... 3125:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_4CLK;
+			break;
+		case 3126 ... 6250:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_2CLK;
+			break;
+		case 6251 ... 12500:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_1CLK;
+			break;
+		case 12501 ... 25000:
+			ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+			break;
+		case 25001 ... 50000: /* 50mV/us */
+			ramp_value = RK806_RAMP_RATE_4LSB_PER_1CLK;
+			break;
+		default:
+			dev_warn(rdev_get_dev(rdev),
+				 "%s ramp_delay: %d not supported, setting 10000\n",
+				 rdev->desc->name, ramp_delay);
+		}
+
+		regval = ramp_value << (ffs(rdev->desc->ramp_mask) - 1);
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+					 rdev->desc->ramp_mask, regval);
+		if (ret)
+			return ret;
+
+		regval = (ramp_value >> 2) & 0x1 ? rk806_dcdc_rate2[rid].bit : 0;
+		return regmap_update_bits(rdev->regmap, rk806_dcdc_rate2[rid].reg,
+					  rk806_dcdc_rate2[rid].bit,
+					  regval);
+	} else {
+		switch (ramp_delay) {
+		case 1 ... 780:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_32CLK;
+			break;
+		case 781 ... 1900:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_13CLK;
+			break;
+		case 1901 ... 3120:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_8CLK;
+			break;
+		case 3121 ... 6280:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_4CLK;
+			break;
+		case 6281 ... 12500:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_2CLK;
+			break;
+		case 12501 ... 25000:
+			ramp_value = RK806_RAMP_RATE_1LSB_PER_1CLK;
+			break;
+		case 25001 ... 50000:
+			ramp_value = RK806_RAMP_RATE_2LSB_PER_1CLK;
+			break;
+		case 50001 ... 100000:
+			ramp_value = RK806_RAMP_RATE_4LSB_PER_1CLK;
+			break;
+		default:
+			pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
+				rdev->desc->name, ramp_delay);
+		}
+
+		regval = ramp_value << (ffs(rdev->desc->ramp_mask) - 1);
+		return regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+					  rdev->desc->ramp_mask, regval);
+	}
+}
+
+static int rk806_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
+{
+	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
+	int rid = rdev_get_id(rdev);
+	int reg_offset;
+	unsigned int reg;
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg_offset = rk806_get_reg_offset(rid);
+	reg = rdev->desc->vsel_reg + reg_offset;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->vsel_mask,
+				  sel);
+}
+
 static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
 	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
@@ -393,6 +671,45 @@ static int rk805_set_suspend_disable(struct regulator_dev *rdev)
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
@@ -561,6 +878,48 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
+static const struct regulator_ops rk806_ops_dcdc = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+
+	.get_voltage_sel	= rk806_get_voltage_sel_regmap,
+	.set_voltage		= rk806_set_voltage,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.set_mode		= rk806_set_mode,
+	.get_mode		= rk806_get_mode,
+
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+
+	.set_suspend_mode	= rk806_set_mode,
+	.set_ramp_delay		= rk806_set_ramp_delay,
+
+	.set_suspend_voltage	= rk806_set_suspend_voltage_range,
+	.set_suspend_enable	= rk806_set_suspend_enable,
+	.set_suspend_disable	= rk806_set_suspend_disable,
+};
+
+static const struct regulator_ops rk806_ops_ldo = {
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
+	.set_suspend_mode	= rk806_set_mode,
+	.set_ramp_delay		= rk806_set_ramp_delay,
+
+	.set_suspend_voltage	= rk806_set_suspend_voltage_range,
+	.set_suspend_enable	= rk806_set_suspend_enable,
+	.set_suspend_disable	= rk806_set_suspend_disable,
+};
+
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -743,6 +1102,112 @@ static const struct regulator_desc rk805_reg[] = {
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
+	RK806_REGULATOR("DCDC_REG1", "vcc1", RK806_ID_DCDC1, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK1_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK1_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG2", "vcc2", RK806_ID_DCDC2, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK2_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK2_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG3", "vcc3", RK806_ID_DCDC3, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK3_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 2,
+			RK806_BUCK3_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG4", "vcc4", RK806_ID_DCDC4, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK4_ON_VSEL,
+			RK806_POWER_EN0, rk806_buck_voltage_ranges, 3,
+			RK806_BUCK4_CONFIG, 0xc0),
+
+	RK806_REGULATOR("DCDC_REG5", "vcc5", RK806_ID_DCDC5, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK5_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK5_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG6", "vcc6", RK806_ID_DCDC6, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK6_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK6_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG7", "vcc7", RK806_ID_DCDC7, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK7_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 2,
+			RK806_BUCK7_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG8", "vcc8", RK806_ID_DCDC8, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK8_ON_VSEL,
+			RK806_POWER_EN1, rk806_buck_voltage_ranges, 3,
+			RK806_BUCK8_CONFIG, 0xc0),
+
+	RK806_REGULATOR("DCDC_REG9", "vcc9", RK806_ID_DCDC9, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK9_ON_VSEL,
+			RK806_POWER_EN2, rk806_buck_voltage_ranges, 0,
+			RK806_BUCK9_CONFIG, 0xc0),
+	RK806_REGULATOR("DCDC_REG10", "vcc10", RK806_ID_DCDC10, rk806_ops_dcdc,
+			RK806_BUCK_SEL_CNT, RK806_BUCK10_ON_VSEL,
+			RK806_POWER_EN2, rk806_buck_voltage_ranges, 1,
+			RK806_BUCK10_CONFIG, 0xc0),
+
+	RK806_REGULATOR("NLDO_REG1", "vcc13", RK806_ID_NLDO1, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO1_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+	RK806_REGULATOR("NLDO_REG2", "vcc13", RK806_ID_NLDO2, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO2_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+	RK806_REGULATOR("NLDO_REG3", "vcc13", RK806_ID_NLDO3, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO3_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+	RK806_REGULATOR("NLDO_REG4", "vcc14", RK806_ID_NLDO4, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO4_ON_VSEL,
+			RK806_POWER_EN3, rk806_ldo_voltage_ranges, 3,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("NLDO_REG5", "vcc14", RK806_ID_NLDO5, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_NLDO5_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("PLDO_REG1", "vcc11", RK806_ID_PLDO1, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO1_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+	RK806_REGULATOR("PLDO_REG2", "vcc11", RK806_ID_PLDO2, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO2_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 2,
+			0xEA, 0x38),
+	RK806_REGULATOR("PLDO_REG3", "vcc11", RK806_ID_PLDO3, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO3_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 3,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("PLDO_REG4", "vcc12", RK806_ID_PLDO4, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO4_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+	RK806_REGULATOR("PLDO_REG5", "vcc12", RK806_ID_PLDO5, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO5_ON_VSEL,
+			RK806_POWER_EN5, rk806_ldo_voltage_ranges, 1,
+			0xEA, 0x38),
+
+	RK806_REGULATOR("PLDO_REG6", "vcca", RK806_ID_PLDO6, rk806_ops_ldo,
+			RK806_LDO_SEL_CNT, RK806_PLDO6_ON_VSEL,
+			RK806_POWER_EN4, rk806_ldo_voltage_ranges, 0,
+			0xEA, 0x38),
+};
+
+
 static const struct regulator_desc rk808_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -1312,6 +1777,10 @@ static int rk808_regulator_probe(struct platform_device *pdev)
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
@@ -1365,5 +1834,6 @@ MODULE_AUTHOR("Tony xie <tony.xie@rock-chips.com>");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
+MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rk808-regulator");
-- 
2.35.1

