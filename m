Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE054AD94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiFNJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbiFNJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35F433BD;
        Tue, 14 Jun 2022 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655200180; x=1686736180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lpQ2BLqwSdzVU8Nyxss4MrFFaolEwyiQ0l6jL1lmJVw=;
  b=zoa0Fn9ubMydP7+B3SARE13ThtPqh+jUIG6negeFZA0VxJFAoBk6LZvW
   TUqApoRsPRVNKeV/Pv22+JLSzqtlq+IIlMXkw/uB+Tv2z2shcJj/td6Nl
   EU0X6qmi9a6Ou4+uznKBFkIGrv2lig5t79+ajrKF8Qrz19AROzA9kXsPU
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jun 2022 02:49:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:49:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:39 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:34 -0700
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
Subject: [PATCH V15 7/9] regulator: Add a regulator driver for the PM8008 PMIC
Date:   Tue, 14 Jun 2022 15:18:29 +0530
Message-ID: <1655200111-18357-8-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
containing 7 LDO regulators.  Add a PM8008 regulator driver to
support PMIC regulator management via the regulator framework.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Changes in V15:
 - Removed unused variables from pm8008_regulator struct.
 - Replaced static_assert with BUILD_BUG_ON.

Changes in V14:
 - Remove unused headers and debug prints.
 - Remove min_uv and max_uv from reg_data[] and set the min/max based
   on the voltage_range pointer.
 - In get_voltage_sel read voltage from hw and calculate selector instead
   of using selector from set_voltage.
 - Add errro check after regulator_list_voltage_linear_range().
 - Use static_assert to make sure nldo_ranges & pldo_ranges doesn't become
   larger and we forget to update the pm8008_reg->rdesc.n_linear_ranges

Changes in V13:
 - Added if check to avoid buffer overflow warnings.
   for (i = 0; i < ARRAY_SIZE(reg_data); i++)
     if (strstr(name, reg_data[i].name))
       break;
   if (i == ARRAY_SIZE(reg_data)) {
     dev_err(dev, "Invalid regulator name %s\n", name);
     return -EINVAL;
   }
 - Removed unused headers.

 drivers/regulator/Kconfig                 |   9 ++
 drivers/regulator/Makefile                |   1 +
 drivers/regulator/qcom-pm8008-regulator.c | 242 ++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
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
index 0000000..c999a7c
--- /dev/null
+++ b/drivers/regulator/qcom-pm8008-regulator.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/qcom_pm8008.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
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
+#define NLDO_MIN_UV			528000
+#define NLDO_MAX_UV			1504000
+
+#define PLDO_MIN_UV			1504000
+#define PLDO_MAX_UV			3400000
+
+struct pm8008_regulator_data {
+	const char			*name;
+	const char			*supply_name;
+	int				min_dropout_uv;
+	const struct linear_range	*voltage_range;
+};
+
+struct pm8008_regulator {
+	struct regmap		*regmap;
+	struct regulator_desc	rdesc;
+	u16			base;
+	int			step_rate;
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
+	/* name  parent       headroom_uv voltage_range */
+	{ "ldo1", "vdd_l1_l2", 225000, nldo_ranges, },
+	{ "ldo2", "vdd_l1_l2", 225000, nldo_ranges, },
+	{ "ldo3", "vdd_l3_l4", 300000, pldo_ranges, },
+	{ "ldo4", "vdd_l3_l4", 300000, pldo_ranges, },
+	{ "ldo5", "vdd_l5",    200000, pldo_ranges, },
+	{ "ldo6", "vdd_l6",    200000, pldo_ranges, },
+	{ "ldo7", "vdd_l7",    200000, pldo_ranges, },
+};
+
+static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
+	__le16 mV;
+	int uV;
+
+	regmap_bulk_read(pm8008_reg->regmap,
+			LDO_VSET_LB_REG(pm8008_reg->base), (void *)&mV, 2);
+
+	uV = le16_to_cpu(mV) * 1000;
+	return (uV - pm8008_reg->rdesc.min_uV) / pm8008_reg->rdesc.uV_step;
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
+	rc = regulator_list_voltage_linear_range(rdev, selector);
+	if (rc < 0)
+		return rc;
+
+	/* voltage control register is set with voltage in millivolts */
+	mV = DIV_ROUND_UP(rc, 1000);
+
+	rc = pm8008_write_voltage(pm8008_reg, mV);
+	if (rc < 0)
+		return rc;
+
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
+	rc = of_property_read_string(dev->of_node, "regulator-name", &name);
+	if (rc)
+		return rc;
+
+	/* get the required regulator data */
+	for (i = 0; i < ARRAY_SIZE(reg_data); i++)
+		if (strstr(name, reg_data[i].name))
+			break;
+
+	if (i == ARRAY_SIZE(reg_data)) {
+		dev_err(dev, "Invalid regulator name %s\n", name);
+		return -EINVAL;
+	}
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
+	pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
+	pm8008_reg->rdesc.n_linear_ranges = 1;
+	BUILD_BUG_ON((ARRAY_SIZE(pldo_ranges) != 1) ||
+				(ARRAY_SIZE(nldo_ranges) != 1));
+
+	if (reg_data[i].voltage_range == nldo_ranges) {
+		pm8008_reg->rdesc.min_uV = NLDO_MIN_UV;
+		pm8008_reg->rdesc.n_voltages
+				= ((NLDO_MAX_UV - NLDO_MIN_UV)
+					/ pm8008_reg->rdesc.uV_step) + 1;
+	} else {
+		pm8008_reg->rdesc.min_uV = PLDO_MIN_UV;
+		pm8008_reg->rdesc.n_voltages
+				= ((PLDO_MAX_UV - PLDO_MIN_UV)
+					/ pm8008_reg->rdesc.uV_step) + 1;
+	}
+
+	pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
+	pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
+	pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
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
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. PM8008 PMIC Regulator Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

