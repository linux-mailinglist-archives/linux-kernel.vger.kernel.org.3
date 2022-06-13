Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23255482F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiFMJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiFMJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:06:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D8E0C1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so6232715wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5SOedyPHIPVspC0y9CdJw4U0stHggu/6GlcHBr0lFk=;
        b=dzWU8GeodPO2AD2DsVNZh1JzqkzMVCk/alOsuAB0+IuG3fLrYonvE4DuH4O8CYq+2j
         DL7SGRsP7Brx+dhusXX2Qg1fuH4WSx+Bi9PwObwU2ti6Y28KdC7DWe2By6knupfhytkL
         DMaPpJ6ZX/b4wCAUvFucJTllOcHlk51+Z0CjJygXf7VnVNIi5lWbiDH7SUIYyxlPAuD5
         6x8UR9o5cv7SQYkmje+oMwQuaQXvv2fYS0YpAo4GXHQxJIMo5HbhOLdb98G6AzQ+gNiA
         F4fvgdHrdB0mEIYzg7ta0EnBwwQcfhwowAgFALWF4LqfVdFKaRHn3aInaut6GkrocVsa
         xeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5SOedyPHIPVspC0y9CdJw4U0stHggu/6GlcHBr0lFk=;
        b=Gpd3cIHXJbzIpX4pKZslqyEJ8xMFEGHaeawzq46XCPMddU/lejYddo070YODIZciQr
         KK59FN7bR9KiJbfT9Zg0F2T0zTtgcIxsteV5MiTduiD6DZBcMx58MNMdBoxvoCfFubvN
         Vz+/rm2LKkcsyUmJUiCz5lnk8/O4cE5pEYWTmh4AE2FzXH+BnrTwFw+nc8O6r6FM9kpl
         uyunn+RgLuW3JypW5rjHvMuPg4d+p3A3Asa93ajFlQutr5fu7S49IpRIUFc/R+dNzX9r
         HZmsP6GpZ3NLzYldVO3/DKjcV+fseliox1zZCG6kTd5U0w0h4MYAItbiCjvj8oCYqr/w
         C4IA==
X-Gm-Message-State: AOAM533zUg5khILukXpvrLfHy6ri4Ra9g6TWbALDQbxFbjDVvnRBhPSK
        qBhZOIIHw+mTK4RCtUTh1igXiA==
X-Google-Smtp-Source: ABdhPJy8Sfqw2948KcBmZuidcNms+4yDY2KbwynrPZTa7BNE7WTCg/NKdypskfsl1Ged4BpQX/1UAA==
X-Received: by 2002:a05:6000:16c2:b0:213:bb0e:383b with SMTP id h2-20020a05600016c200b00213bb0e383bmr49368612wrf.276.1655111173774;
        Mon, 13 Jun 2022 02:06:13 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm7806465wrr.39.2022.06.13.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:06:13 -0700 (PDT)
From:   Jerome NEANNE <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, will@kernel.org,
        lee.jones@linaro.org, jneanne@baylibre.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/5] regulator: drivers: Add TI TPS65219 PMIC regulators support
Date:   Mon, 13 Jun 2022 11:06:02 +0200
Message-Id: <20220613090604.9975-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613090604.9975-1-jneanne@baylibre.com>
References: <20220613090604.9975-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulators set consists of 3 bucks DCDCs and 4 LDOs. The output
voltages are configurable and are meant to supply power to the
main processor and other components.

Validation:
Visual check: cat /sys/kernel/debug/regulator/regulator_summary
Validation: userspace-consumer and virtual-regulator required
to test further

Enable/Disable:
cat /sys/devices/platform/userspace-consumer-VDDSHV_SD_IO_PMIC/state
echo disabled > /sys/devices/platform/
userspace-consumer-VDDSHV_SD_IO_PMIC/state
echo enabled > /sys/devices/platform/
userspace-consumer-VDDSHV_SD_IO_PMIC/state

Change voltage:
cat /sys/devices/platform/regulator-virtual-ldo1/min_microvolts
echo 1000000 > /sys/devices/platform/regulator-virtual-ldo1/
min_microvolts
echo 3000000 > /sys/devices/platform/regulator-virtual-ldo1/
max_microvolts

Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
---
 drivers/regulator/Kconfig              |   9 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/tps65219-regulator.c | 334 +++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 drivers/regulator/tps65219-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 24ce9a17ab4f..1a17b925264c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1291,6 +1291,15 @@ config REGULATOR_TPS65218
 	  voltage regulators. It supports software based voltage control
 	  for different voltage domains
 
+config REGULATOR_TPS65219
+	tristate "TI TPS65219 Power regulators"
+	depends on MFD_TPS65219 && OF
+	help
+	  This driver supports TPS65219 voltage regulator chips.
+	  TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs
+	  voltage regulators. It supports software based voltage control
+	  for different voltage domains
+
 config REGULATOR_TPS6524X
 	tristate "TI TPS6524X Power regulators"
 	depends on SPI
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8c2f82206b94..790839810e8e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_REGULATOR_TPS65086) += tps65086-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65090) += tps65090-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65217) += tps65217-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65218) += tps65218-regulator.o
+obj-$(CONFIG_REGULATOR_TPS65219) += tps65219-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6524X) += tps6524x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
new file mode 100644
index 000000000000..0e176e15daa6
--- /dev/null
+++ b/drivers/regulator/tps65219-regulator.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tps65219-regulator.c
+ *
+ * Regulator driver for TPS65219 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+/* This implementation derived from tps65218 authored by "J Keerthy <j-keerthy@ti.com>" */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/tps65219.h>
+
+#define TPS65219_REGULATOR(_name, _of, _id, _type, _ops, _n, _vr, _vm, _er, \
+			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, \
+			   _ct, _ncl, _bpm) \
+	{								\
+		.name			= _name,			\
+		.of_match		= _of,				\
+		.regulators_node	= of_match_ptr("regulators"),	\
+		.supply_name    = _of,					\
+		.id			= _id,				\
+		.ops			= &_ops,			\
+		.n_voltages		= _n,				\
+		.type			= _type,			\
+		.owner			= THIS_MODULE,			\
+		.vsel_reg		= _vr,				\
+		.vsel_mask		= _vm,				\
+		.csel_reg		= _cr,				\
+		.csel_mask		= _cm,				\
+		.curr_table		= _ct,				\
+		.n_current_limits	= _ncl,				\
+		.enable_reg		= _er,				\
+		.enable_mask		= _em,				\
+		.volt_table		= NULL,				\
+		.linear_ranges		= _lr,				\
+		.n_linear_ranges	= _nlr,				\
+		.ramp_delay		= _delay,			\
+		.fixed_uV		= _fuv,				\
+		.bypass_reg		= _vr,				\
+		.bypass_mask		= _bpm,				\
+		.bypass_val_on		= 1,				\
+	}								\
+
+static const struct linear_range bucks_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x1f, 25000),
+	REGULATOR_LINEAR_RANGE(1400000, 0x20, 0x33, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x34, 0x3f, 0),
+};
+
+static const struct linear_range ldos_1_2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x37, 50000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x38, 0x3f, 0),
+};
+
+static const struct linear_range ldos_3_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x0, 0xC, 0),
+	REGULATOR_LINEAR_RANGE(1250000, 0xD, 0x35, 50000),
+	REGULATOR_LINEAR_RANGE(3300000, 0x36, 0x3F, 0),
+};
+
+static int tps65219_pmic_set_voltage_sel(struct regulator_dev *dev,
+					 unsigned int selector)
+{
+	int ret;
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+
+	/* Set the voltage based on vsel value */
+	ret = tps65219_set_bits(tps, dev->desc->vsel_reg, dev->desc->vsel_mask,
+				selector);
+	dev_dbg(tps->dev, "%s failed for regulator %s: %d ", __func__, dev->desc->name, ret);
+	return ret;
+}
+
+static int tps65219_pmic_enable(struct regulator_dev *dev)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	int rid = rdev_get_id(dev);
+	int ret;
+
+
+
+	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
+		return -EINVAL;
+
+	ret = tps65219_set_bits(tps, dev->desc->enable_reg,
+				 dev->desc->enable_mask, dev->desc->enable_mask);
+	return ret;
+}
+
+static int tps65219_pmic_disable(struct regulator_dev *dev)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	int rid = rdev_get_id(dev);
+
+
+	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
+		return -EINVAL;
+
+
+	return tps65219_clear_bits(tps, dev->desc->enable_reg,
+				   dev->desc->enable_mask);
+}
+
+static int tps65219_set_mode(struct regulator_dev *dev, unsigned int mode)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+
+	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
+		return -EINVAL;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		return tps65219_set_bits(tps, TPS65219_REG_STBY_1_CONFIG, dev->desc->enable_mask,
+				dev->desc->enable_mask);
+
+	case REGULATOR_MODE_STANDBY:
+		return tps65219_clear_bits(tps, TPS65219_REG_STBY_1_CONFIG, dev->desc->enable_mask);
+	}
+
+	return -EINVAL;
+}
+static unsigned int tps65219_get_mode(struct regulator_dev *dev)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+	int ret, value = 0;
+
+	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
+		return -EINVAL;
+
+	ret = tps65219_reg_read(tps, TPS65219_REG_STBY_1_CONFIG, &value);
+	value = (value & BIT(rid)) >> rid;
+	if (!(value & BUCKS_LDOS_STBY_ON_BIT))
+		ret = REGULATOR_MODE_STANDBY;
+	else
+		ret = REGULATOR_MODE_NORMAL;
+	return ret;
+}
+
+/* generic regulator_set_bypass_regmap does not match requirements use custom instead */
+static int tps65219_set_bypass(struct regulator_dev *dev, bool enable)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+	int ret = 0;
+
+	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
+		return -EINVAL;
+
+	if (rid < TPS65219_LDO_1 || rid > TPS65219_LDO_2) {
+		dev_err(tps->dev, "%s bypass allowed for LDO1/2 only ", __func__);
+		return -EPERM;
+	}
+
+	if (dev->desc->ops->is_enabled) {
+		dev_err(tps->dev, "%s LDO%d is enabled, should be shut down to set bypass ",
+					 __func__, rid);
+		return -EBUSY;
+	}
+
+	if (enable) {
+		dev_dbg(tps->dev, "%s, LDO%d already in bypass mode", __func__, rid);
+		return ret;
+	}
+
+	ret = tps65219_set_bits(tps, dev->desc->vsel_reg, TPS65219_LDOS_BYP_CONFIG_MASK,
+				 TPS65219_LDOS_BYP_CONFIG_MASK);
+	dev_dbg(tps->dev, "%s LDO%d switched to bypass mode", __func__, rid);
+	return ret;
+}
+
+/* Operations permitted on BUCK1/2/3 */
+static const struct regulator_ops tps65219_bucks_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= tps65219_pmic_enable,
+	.disable		= tps65219_pmic_disable,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= tps65219_pmic_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+
+};
+
+/* Operations permitted on LDO1/2 */
+static const struct regulator_ops tps65219_ldos_1_2_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= tps65219_pmic_enable,
+	.disable		= tps65219_pmic_disable,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= tps65219_pmic_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_bypass	= tps65219_set_bypass,
+	.get_bypass	= regulator_get_bypass_regmap,
+};
+
+/* Operations permitted on LDO3/4 */
+static const struct regulator_ops tps65219_ldos_3_4_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= tps65219_pmic_enable,
+	.disable		= tps65219_pmic_disable,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= tps65219_pmic_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+};
+
+static const struct regulator_desc regulators[] = {
+	TPS65219_REGULATOR("BUCK1", "buck1", TPS65219_BUCK_1,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK1_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK1_EN, 0, 0, bucks_ranges,
+			   3, 4000, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("BUCK2", "buck2", TPS65219_BUCK_2,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK2_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK2_EN, 0, 0, bucks_ranges,
+			   3, 4000, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("BUCK3", "buck3", TPS65219_BUCK_3,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK3_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK3_EN, 0, 0, bucks_ranges, 3,
+			   0, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("LDO1", "ldo1", TPS65219_LDO_1,
+			   REGULATOR_VOLTAGE, tps65219_ldos_1_2_ops, 64,
+			   TPS65219_REG_LDO1_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO1_EN, 0, 0, ldos_1_2_ranges,
+			   2, 0, 0, NULL, 0, TPS65219_LDOS_BYP_CONFIG_MASK),
+	TPS65219_REGULATOR("LDO2", "ldo2", TPS65219_LDO_2,
+			   REGULATOR_VOLTAGE, tps65219_ldos_1_2_ops, 64,
+			   TPS65219_REG_LDO2_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO2_EN, 0, 0, ldos_1_2_ranges,
+			   2, 0, 0, NULL, 0, TPS65219_LDOS_BYP_CONFIG_MASK),
+	TPS65219_REGULATOR("LDO3", "ldo3", TPS65219_LDO_3,
+			   REGULATOR_VOLTAGE, tps65219_ldos_3_4_ops, 64,
+			   TPS65219_REG_LDO3_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO3_EN, 0, 0, ldos_3_4_ranges,
+			   3, 0, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("LDO4", "ldo4", TPS65219_LDO_4,
+			   REGULATOR_VOLTAGE, tps65219_ldos_3_4_ops, 64,
+			   TPS65219_REG_LDO4_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK, TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO4_EN, 0, 0, ldos_3_4_ranges,
+			   3, 0, 0, NULL, 0, 0),
+};
+
+static int tps65219_regulator_probe(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	int i, ret;
+	unsigned int val;
+
+
+	config.dev = tps->dev;
+	config.driver_data = tps;
+	config.regmap = tps->regmap;
+
+	/* Allocate memory for strobes */
+	tps->strobes = devm_kcalloc(&pdev->dev,
+				    TPS65219_NUM_REGULATOR, sizeof(u8),
+				    GFP_KERNEL);
+	if (!tps->strobes)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		pr_debug("tps65219 regul i= %d START", i);
+		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(tps->dev, "failed to register %s regulator\n",
+				pdev->name);
+			return PTR_ERR(rdev);
+		}
+
+		ret = regmap_read(tps->regmap, regulators[i].bypass_reg, &val);
+		if (ret) {
+			dev_err(tps->dev, "dev_err failed to map register for %s regulator\n",
+				pdev->name);
+			return ret;
+		}
+		pr_debug("tps65219 regul i= %d COMPLETED", i);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id tps65219_regulator_id_table[] = {
+	{ "tps65219-regulator", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65219_regulator_id_table);
+
+static struct platform_driver tps65219_regulator_driver = {
+	.driver = {
+		.name = "tps65219-pmic",
+	},
+	.probe = tps65219_regulator_probe,
+	.id_table = tps65219_regulator_id_table,
+};
+
+module_platform_driver(tps65219_regulator_driver);
+
+MODULE_AUTHOR("J Neanne <j-neanne@baylibre.com>");
+MODULE_DESCRIPTION("TPS65219 voltage regulator driver");
+MODULE_ALIAS("platform:tps65219-pmic");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

