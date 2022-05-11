Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0E523400
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiEKNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbiEKNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CA245796;
        Wed, 11 May 2022 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275162; x=1683811162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=imkQ5N7HhoW7Hu6hHKmMQA9MJrZ5APJ6FDyrXBsNq9w=;
  b=PNU4nnAx42eCHWi+HwR7ik+XZgcgEeq+tNRf+OndIXfiVzeh/IeBc/YT
   S33BTdCzDulmYIfGOOMWRZ1dLX2TpyDBAFYAmKLB9bnzukYV+OfL3X0Dl
   o1Y1K7tGaxtuQeQTaJpM5JjoBPc+dHxf+DEApsTrb30mWkKZ4N7RpCKs/
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 06:19:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:19:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:19:21 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:19:17 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V12 7/9] regulator: Add a regulator driver for the PM8008 PMIC
Date:   Wed, 11 May 2022 18:48:31 +0530
Message-ID: <1652275113-10277-8-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
containing 7 LDO regulators.  Add a PM8008 regulator driver to
support PMIC regulator management via the regulator framework.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V12:
 - Get base from reg property in DT node.

Changes in V11:
 - Added of_device_id table and compatible to register the ldos.

Changes in V10:
 - Changed the driver name.
 - Removed unused header.
 - Use get_voltage_sel.

Changes in V9:
 - Nothing has changed.

Changes in V8:
 - Changed the regulators_data struct name to pm8008_regulator_data

 drivers/regulator/Kconfig                 |   9 ++
 drivers/regulator/Makefile                |   1 +
 drivers/regulator/qcom-pm8008-regulator.c | 221 ++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96..2c6d9c2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -925,6 +925,15 @@ config REGULATOR_PWM
 	  This driver supports PWM controlled voltage regulators. PWM
 	  duty cycle can increase or decrease the voltage.
 
+config REGULATOR_QCOM_PM8008
+	tristate "Qualcomm Technologies, Inc. PM8008 PMIC regulators"
+	depends on MFD_QCOM_PM8008
+	help
+	  Select this option to get support for the voltage regulators
+	  of Qualcomm Technologies, Inc. PM8008 PMIC chip. PM8008 has 7 LDO
+	  regulators. This driver provides support for basic operations like
+	  set/get voltage and enable/disable.
+
 config REGULATOR_QCOM_RPM
 	tristate "Qualcomm RPM regulator driver"
 	depends on MFD_QCOM_RPM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b..169e686 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_PM8008) += qcom-pm8008-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
new file mode 100644
index 0000000..0361f02
--- /dev/null
+++ b/drivers/regulator/qcom-pm8008-regulator.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/qcom_pm8008.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define VSET_STEP_MV			8
+#define VSET_STEP_UV			(VSET_STEP_MV * 1000)
+
+#define LDO_ENABLE_REG(base)		((base) + 0x46)
+#define ENABLE_BIT			BIT(7)
+
+#define LDO_VSET_LB_REG(base)		((base) + 0x40)
+
+#define LDO_STEPPER_CTL_REG(base)	((base) + 0x3b)
+#define DEFAULT_VOLTAGE_STEPPER_RATE	38400
+#define STEP_RATE_MASK			GENMASK(1, 0)
+
+struct pm8008_regulator_data {
+	const char			*name;
+	const char			*supply_name;
+	int				min_uv;
+	int				max_uv;
+	int				min_dropout_uv;
+	const struct linear_range	*voltage_range;
+};
+
+struct pm8008_regulator {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct regulator_desc	rdesc;
+	u16			base;
+	int			step_rate;
+	int			voltage_selector;
+};
+
+static const struct linear_range nldo_ranges[] = {
+	REGULATOR_LINEAR_RANGE(528000, 0, 122, 8000),
+};
+
+static const struct linear_range pldo_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1504000, 0, 237, 8000),
+};
+
+static const struct pm8008_regulator_data reg_data[] = {
+	/* name  parent       min_uv  max_uv  headroom_uv voltage_range */
+	{ "ldo1", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
+	{ "ldo2", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
+	{ "ldo3", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
+	{ "ldo4", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
+	{ "ldo5", "vdd_l5",    1504000, 3400000, 200000, pldo_ranges, },
+	{ "ldo6", "vdd_l6",    1504000, 3400000, 200000, pldo_ranges, },
+	{ "ldo7", "vdd_l7",    1504000, 3400000, 200000, pldo_ranges, },
+};
+
+static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
+
+	return pm8008_reg->voltage_selector;
+}
+
+static inline int pm8008_write_voltage(struct pm8008_regulator *pm8008_reg,
+							int mV)
+{
+	__le16 vset_raw;
+
+	vset_raw = cpu_to_le16(mV);
+
+	return regmap_bulk_write(pm8008_reg->regmap,
+			LDO_VSET_LB_REG(pm8008_reg->base),
+			(const void *)&vset_raw, sizeof(vset_raw));
+}
+
+static int pm8008_regulator_set_voltage_time(struct regulator_dev *rdev,
+				int old_uV, int new_uv)
+{
+	struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
+
+	return DIV_ROUND_UP(abs(new_uv - old_uV), pm8008_reg->step_rate);
+}
+
+static int pm8008_regulator_set_voltage(struct regulator_dev *rdev,
+					unsigned int selector)
+{
+	struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
+	int rc, mV;
+
+	/* voltage control register is set with voltage in millivolts */
+	mV = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev, selector),
+						1000);
+	if (mV < 0)
+		return mV;
+
+	rc = pm8008_write_voltage(pm8008_reg, mV);
+	if (rc < 0)
+		return rc;
+
+	pm8008_reg->voltage_selector = selector;
+	dev_dbg(&rdev->dev, "voltage set to %d\n", mV * 1000);
+	return 0;
+}
+
+static const struct regulator_ops pm8008_regulator_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage_sel	= pm8008_regulator_set_voltage,
+	.get_voltage_sel	= pm8008_regulator_get_voltage,
+	.list_voltage		= regulator_list_voltage_linear,
+	.set_voltage_time	= pm8008_regulator_set_voltage_time,
+};
+
+static int pm8008_regulator_probe(struct platform_device *pdev)
+{
+	int rc, i;
+	u32 base;
+	unsigned int reg;
+	const char *name;
+	struct device *dev = &pdev->dev;
+	struct regulator_config reg_config = {};
+	struct regulator_dev    *rdev;
+	const struct pm8008_data *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm8008_regulator *pm8008_reg;
+
+	pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
+	if (!pm8008_reg)
+		return -ENOMEM;
+
+	pm8008_reg->regmap = pm8008_get_regmap(chip);
+	if (!pm8008_reg->regmap) {
+		dev_err(dev, "parent regmap is missing\n");
+		return -EINVAL;
+	}
+
+	pm8008_reg->dev = dev;
+
+	rc = of_property_read_string(dev->of_node, "regulator-name", &name);
+	if (rc)
+		return rc;
+
+	/* get the required regulator data */
+	for (i = 0; i < ARRAY_SIZE(reg_data); i++)
+		if (strstr(name, reg_data[i].name))
+			break;
+
+	rc = of_property_read_u32_index(dev->of_node, "reg", 1, &base);
+	if (rc < 0) {
+		dev_err(dev, "%s: failed to get regulator base rc=%d\n", name, rc);
+		return rc;
+	}
+	pm8008_reg->base = base;
+
+	/* get slew rate */
+	rc = regmap_bulk_read(pm8008_reg->regmap,
+			LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
+	if (rc < 0) {
+		dev_err(dev, "failed to read step rate configuration rc=%d\n", rc);
+		return rc;
+	}
+	reg &= STEP_RATE_MASK;
+	pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
+
+	pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
+	pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
+	pm8008_reg->rdesc.name = reg_data[i].name;
+	pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
+	pm8008_reg->rdesc.of_match = reg_data[i].name;
+	pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
+	pm8008_reg->rdesc.min_uV = reg_data[i].min_uv;
+	pm8008_reg->rdesc.n_voltages
+		= ((reg_data[i].max_uv - reg_data[i].min_uv)
+			/ pm8008_reg->rdesc.uV_step) + 1;
+	pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
+	pm8008_reg->rdesc.n_linear_ranges = 1;
+	pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
+	pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
+	pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
+	pm8008_reg->voltage_selector = -ENOTRECOVERABLE;
+
+	reg_config.dev = dev->parent;
+	reg_config.driver_data = pm8008_reg;
+	reg_config.regmap = pm8008_reg->regmap;
+
+	rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
+	if (IS_ERR(rdev)) {
+		rc = PTR_ERR(rdev);
+		dev_err(dev, "%s: failed to register regulator rc=%d\n",
+				reg_data[i].name, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pm8008_regulator_match_table[] = {
+	{ .compatible = "qcom,pm8008-regulator", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pm8008_regulator_match_table);
+
+static struct platform_driver pm8008_regulator_driver = {
+	.driver	= {
+		.name		= "qcom-pm8008-regulator",
+		.of_match_table	= pm8008_regulator_match_table,
+	},
+	.probe	= pm8008_regulator_probe,
+};
+
+module_platform_driver(pm8008_regulator_driver);
+
+MODULE_DESCRIPTION("Qualcomm PM8008 PMIC Regulator Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

