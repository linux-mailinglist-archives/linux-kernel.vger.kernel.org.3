Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B84ADBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378709AbiBHOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378708AbiBHOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:55:08 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0825C06129A;
        Tue,  8 Feb 2022 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644332104; x=1675868104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=l4EFA2CQpRuZZAiL84oacUgBJvJHgljqKjqQu++slRU=;
  b=ZqK0I0VtuHbKjipfO9L+rK+lFEy0sgrQLlens3eW0Q67GC042/I7QD/J
   +toolmARys87qBeY1CUr4wl+9LaX6hN6WhvqLwxQFW9m7lHjmWh+PAnpG
   gsqrZomWUhNZwtIr7SAYvZOD1UeX7P5jSdlIIfjndSwixDp+95jzrQFa7
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 06:55:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:55:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:55:03 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:54:58 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008 PMIC
Date:   Tue, 8 Feb 2022 20:22:18 +0530
Message-ID: <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
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
---
Changes in V2:
 As per Mark's comments
 - Using regmap helpers for regulator enable/disable and is_enabled APIs
 - Changed pr_err to dev_err wherever possible.
 - Removed init_voltage property as it is not used.
 - Removed if check for registering LDOs
 - Other minor changes.

Changes in V3:
 As per Stephen's comments, 
 - Removed unused includes
 - Removed PM8008_MAX_LDO macro.
 - Removed pm8008_read/write APIs, using regmap_bulk_read/write APIs
 - Using le16_to_cpu/cpu_to_le16 APIs in pm8008_regulator_get/set_voltage
 - Consolidated all probe related functions into single probe function.
 - Added of_parse_cb call back and removed regulator-name matching loop.
 - Fixed other minor nits.

Changes in V4:
 - Removed unused members like rdev and of_node from pm8008_regulator struct.
 - Replaced set_voltage with set_voltage_sel
 - Removed init_data configuration as it is not needed.
 - Removed few other unused assignments from probe

Changes in V5:
 - Removed Compatible string.
 - Changed the probe function accordingly to probe LDOs using mfd driver.
 - Added max headrooms for LDOs and removed the part reading min-dropout from DT.
 - Added base reg values in the regulator_data struct instead of reading it from DT.

 drivers/regulator/Kconfig                 |   9 ++
 drivers/regulator/Makefile                |   1 +
 drivers/regulator/qcom-pm8008-regulator.c | 234 ++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 22503e4..4372ad7 100644
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
index 2e1b087..9ab3ad7 100644
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
index 0000000..86043b4
--- /dev/null
+++ b/drivers/regulator/qcom-pm8008-regulator.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021, The Linux Foundation. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define STARTUP_DELAY_USEC		20
+#define VSET_STEP_MV			8
+#define VSET_STEP_UV			(VSET_STEP_MV * 1000)
+
+#define LDO_ENABLE_REG(base)		((base) + 0x46)
+#define ENABLE_BIT			BIT(7)
+
+#define LDO_STATUS1_REG(base)		((base) + 0x08)
+#define VREG_READY_BIT			BIT(7)
+
+#define LDO_VSET_LB_REG(base)		((base) + 0x40)
+
+#define LDO_STEPPER_CTL_REG(base)	((base) + 0x3b)
+#define DEFAULT_VOLTAGE_STEPPER_RATE	38400
+#define STEP_RATE_MASK			GENMASK(1, 0)
+
+#define PM8008_NUM_LDOS			7
+
+struct regulator_data {
+	const char			*name;
+	const char			*supply_name;
+	u16				base;
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
+static const struct regulator_data reg_data[] = {
+	/* name  parent       base   min_uv  max_uv  headroom_uv voltage_range */
+	{ "LDO1", "vdd_l1_l2", 0x4000,  528000, 1504000, 225000, nldo_ranges, },
+	{ "LDO2", "vdd_l1_l2", 0x4100,  528000, 1504000, 225000, nldo_ranges, },
+	{ "LDO3", "vdd_l3_l4", 0x4200, 1504000, 3400000, 300000, pldo_ranges, },
+	{ "LDO4", "vdd_l3_l4", 0x4300, 1504000, 3400000, 300000, pldo_ranges, },
+	{ "LDO5", "vdd_l5",    0x4400, 1504000, 3400000, 200000, pldo_ranges, },
+	{ "LDO6", "vdd_l6",    0x4500, 1504000, 3400000, 200000, pldo_ranges, },
+	{ "LDO7", "vdd_l7",    0x4600, 1504000, 3400000, 200000, pldo_ranges, },
+};
+
+static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
+	__le16 mV;
+	int rc;
+
+	rc = regmap_bulk_read(pm8008_reg->regmap,
+			LDO_VSET_LB_REG(pm8008_reg->base), (void *)&mV, 2);
+	if (rc < 0) {
+		dev_err(&rdev->dev, "failed to read regulator voltage rc=%d\n", rc);
+		return rc;
+	}
+
+	return le16_to_cpu(mV) * 1000;
+}
+
+static inline int pm8008_write_voltage(struct pm8008_regulator *pm8008_reg,
+							int mV)
+{
+	int rc;
+	u16 vset_raw;
+
+	vset_raw = cpu_to_le16(mV);
+
+	rc = regmap_bulk_write(pm8008_reg->regmap,
+			LDO_VSET_LB_REG(pm8008_reg->base),
+			(const void *)&vset_raw, sizeof(vset_raw));
+	if (rc < 0) {
+		dev_err(pm8008_reg->dev, "failed to write voltage rc=%d\n", rc);
+		return rc;
+	}
+
+	return 0;
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
+	dev_dbg(&rdev->dev, "voltage set to %d\n", mV * 1000);
+	return 0;
+}
+
+static const struct regulator_ops pm8008_regulator_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage_sel	= pm8008_regulator_set_voltage,
+	.get_voltage		= pm8008_regulator_get_voltage,
+	.list_voltage		= regulator_list_voltage_linear,
+	.set_voltage_time	= pm8008_regulator_set_voltage_time,
+};
+
+static int pm8008_regulator_of_parse(struct device_node *node,
+			const struct regulator_desc *desc,
+			struct regulator_config *config)
+{
+	struct pm8008_regulator *pm8008_reg = config->driver_data;
+	int rc;
+	unsigned int reg;
+
+	/* get slew rate */
+	rc = regmap_bulk_read(pm8008_reg->regmap,
+			LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
+	if (rc < 0) {
+		dev_err(pm8008_reg->dev,
+			"%s: failed to read step rate configuration rc=%d\n",
+			pm8008_reg->rdesc.name, rc);
+		return rc;
+	}
+	reg &= STEP_RATE_MASK;
+	pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
+
+	return 0;
+}
+
+static int pm8008_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int id = pdev->id % PM8008_NUM_LDOS;
+	struct regulator_dev    *rdev;
+	struct pm8008_regulator *pm8008_reg;
+	struct regmap *regmap;
+	struct regulator_config reg_config = {};
+	int rc;
+
+	dev_dbg(dev, "DEBUG: Probing LDO%d\n", id + 1);
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap) {
+		dev_err(dev, "parent regmap is missing\n");
+		return -EINVAL;
+	}
+
+	pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
+	if (!pm8008_reg)
+		return -ENOMEM;
+
+	pm8008_reg->regmap = regmap;
+	pm8008_reg->dev = dev;
+	pm8008_reg->base = reg_data[id].base;
+
+	pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
+	pm8008_reg->rdesc.regulators_node = of_match_ptr("regulators");
+	pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
+	pm8008_reg->rdesc.name = reg_data[id].name;
+	pm8008_reg->rdesc.supply_name = reg_data[id].supply_name;
+	pm8008_reg->rdesc.of_match = reg_data[id].name;
+	pm8008_reg->rdesc.of_parse_cb = pm8008_regulator_of_parse;
+	pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
+	pm8008_reg->rdesc.min_uV = reg_data[id].min_uv;
+	pm8008_reg->rdesc.n_voltages
+		= ((reg_data[id].max_uv - reg_data[id].min_uv)
+			/ pm8008_reg->rdesc.uV_step) + 1;
+	pm8008_reg->rdesc.linear_ranges = reg_data[id].voltage_range;
+	pm8008_reg->rdesc.n_linear_ranges = 1;
+	pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
+	pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
+	pm8008_reg->rdesc.min_dropout_uV = reg_data[id].min_dropout_uv;
+
+	reg_config.dev = dev->parent;
+	reg_config.driver_data = pm8008_reg;
+
+	rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
+	if (IS_ERR(rdev)) {
+		rc = PTR_ERR(rdev);
+		dev_err(dev, "%s: failed to register regulator rc=%d\n",
+				reg_data[id].name, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static struct platform_driver pm8008_regulator_driver = {
+	.driver	= {
+		.name		= "qcom,pm8008-regulators",
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

