Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7455F58AAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiHEMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiHEMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2867969C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b96so3249459edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=syRgqvLlRIW5BUXBXSYKcB6w+IB0NOavd0Y5qbVcTcE=;
        b=z3CY2ja5H4IWuYuPSmHcXu2YdiNtBnUnztsQxjyc2c16TuZfZJFWpOyFu5WAoetS76
         fnc6kn0rCJxsmI4/KgDQHA9GaN0ndkd1LfXV3hjlSwWEj4dbVBcipjqtAwh9JS9NJb/m
         jjw6SdkZFg5eI5LzuJwT704txvIpXMX7lx+iCFmeSD5TXyQxnxBklgxa4OJelwiXBZKX
         fX21VTr6pGLV1jDq2Vn/47295ja9thO8/Mc/CKJzJzVmM6b3GJiBhiZUXiz9uLeXbxqG
         U+uj4RXPgvAAe5JH/7XysLRWVR0BELSfDpHVZhE9q1Au7yQh9623sxdbNG1QJjijoJX/
         W36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=syRgqvLlRIW5BUXBXSYKcB6w+IB0NOavd0Y5qbVcTcE=;
        b=iJr80WispItbdWu/UAO61lU9vQLQMTxpm6SYb/HdnUqVZf0FRKZ6v3O9GmMchTQ9JO
         90WDvNIEx11Dxg0wWhZhSijN8UMq+E8t+gJ3ppCUY6LbIeWFR7rvzhB1Xo8AbCWurBQc
         WbBswHBHyc2mo1E1v/MnP0XL2ZkYsINziRhuIrQZOAP74lt36mVDYgInRts8GhgU4z6e
         mt0+1ZcIO1wgCTdHzG386P+KGtEGudXl++swPAkc71vwsxRPvO/FizP0HkRzLnrAKefB
         nBuGzeXO5wzX0TJ/GmxXZBje3Ml8PYhfveapy63fROY/+CU5aZJJdIl/+Dgw4+8a7658
         xkfQ==
X-Gm-Message-State: ACgBeo3DjB8f0C5Ikw1Spm765eVmqXiMTSuZc+wnGDCjalJPzajRsett
        HbuNqTKmpyukp6/MT9vVoPCOBg==
X-Google-Smtp-Source: AA6agR7VPA/mE/lrNexdRwlmsrXo7oohV5DpHPwWaGlIUV0U5lEiW0rXDw0h6AkCjA+6h1Pdyu0rSw==
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id y4-20020aa7ccc4000000b0043d9e0eb7ffmr6552038edt.14.1659701971445;
        Fri, 05 Aug 2022 05:19:31 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:30 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 08/10] regulator: drivers: Add TI TPS65219 PMIC regulators support
Date:   Fri,  5 Aug 2022 14:18:50 +0200
Message-Id: <20220805121852.21254-9-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                            |   1 +
 drivers/regulator/Kconfig              |   9 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/tps65219-regulator.c | 416 +++++++++++++++++++++++++
 4 files changed, 427 insertions(+)
 create mode 100644 drivers/regulator/tps65219-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ffd533b8debc..faa9b2b7851b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14850,6 +14850,7 @@ F:	drivers/regulator/palmas-regulator*.c
 F:	drivers/regulator/pbias-regulator.c
 F:	drivers/regulator/tps65217-regulator.c
 F:	drivers/regulator/tps65218-regulator.c
+F:	drivers/regulator/tps65219-regulator.c
 F:	drivers/regulator/tps65910-regulator.c
 F:	drivers/regulator/twl-regulator.c
 F:	drivers/regulator/twl6030-regulator.c
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 23e3e4a35cc9..f9bd683baa38 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1384,6 +1384,15 @@ config REGULATOR_TPS65218
 	  voltage regulators. It supports software based voltage control
 	  for different voltage domains
 
+config REGULATOR_TPS65219
+	tristate "TI TPS65219 Power regulators"
+	depends on MFD_TPS65219 && OF
+	help
+	  This driver supports TPS65219 voltage regulator chips.
+	  TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs
+	  voltage regulators. It supports software based voltage control
+	  for different voltage domains.
+
 config REGULATOR_TPS6524X
 	tristate "TI TPS6524X Power regulators"
 	depends on SPI
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index fa49bb6cc544..d7734a8dfbaf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_REGULATOR_TPS65086) += tps65086-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65090) += tps65090-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65217) += tps65217-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65218) += tps65218-regulator.o
+obj-$(CONFIG_REGULATOR_TPS65219) += tps65219-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6524X) += tps6524x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
new file mode 100644
index 000000000000..7ba2594e437c
--- /dev/null
+++ b/drivers/regulator/tps65219-regulator.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// tps65219-regulator.c
+//
+// Regulator driver for TPS65219 PMIC
+//
+// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+//
+// This implementation derived from tps65218 authored by
+// "J Keerthy <j-keerthy@ti.com>"
+//
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
+struct tps65219_regulator_irq_type {
+	const char *irq_name;
+	const char *regulator_name;
+	const char *event_name;
+	unsigned long event;
+};
+
+struct tps65219_regulator_irq_type tps65219_regulator_irq_types[] = {
+	{ "LDO3_SCG", "LDO3", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "LDO3_OC", "LDO3", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "LDO3_UV", "LDO3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "LDO4_SCG", "LDO4", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "LDO4_OC", "LDO4", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "LDO4_UV", "LDO4", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "LDO1_SCG", "LDO1", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "LDO1_OC", "LDO1", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "LDO1_UV", "LDO1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "LDO2_SCG", "LDO2", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "LDO2_OC", "LDO2", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "LDO2_UV", "LDO2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "BUCK3_SCG", "BUCK3", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "BUCK3_OC", "BUCK3", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK3_NEG_OC", "BUCK3", "negative overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK3_UV", "BUCK3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "BUCK1_SCG", "BUCK1", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "BUCK1_OC", "BUCK1", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK1_NEG_OC", "BUCK1", "negative overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK1_UV", "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "BUCK2_SCG", "BUCK2", "short circuit to ground", REGULATOR_EVENT_REGULATION_OUT },
+	{ "BUCK2_OC", "BUCK2", "overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK2_NEG_OC", "BUCK2", "negative overcurrent", REGULATOR_EVENT_OVER_CURRENT },
+	{ "BUCK2_UV", "BUCK2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ "BUCK1_RV", "BUCK1", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "BUCK2_RV", "BUCK2", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "BUCK3_RV", "BUCK3", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO1_RV", "LDO1", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO2_RV", "LDO2", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO3_RV", "LDO3", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO4_RV", "LDO4", "residual voltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "BUCK1_RV_SD", "BUCK1", "residual voltage on shutdown",
+	 REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "BUCK2_RV_SD", "BUCK2", "residual voltage on shutdown",
+	 REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "BUCK3_RV_SD", "BUCK3", "residual voltage on shutdown",
+	 REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO1_RV_SD", "LDO1", "residual voltage on shutdown", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO2_RV_SD", "LDO2", "residual voltage on shutdown", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO3_RV_SD", "LDO3", "residual voltage on shutdown", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "LDO4_RV_SD", "LDO4", "residual voltage on shutdown", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ "SENSOR_3_WARM", "SENSOR3", "warm temperature", REGULATOR_EVENT_OVER_TEMP_WARN},
+	{ "SENSOR_2_WARM", "SENSOR2", "warm temperature", REGULATOR_EVENT_OVER_TEMP_WARN },
+	{ "SENSOR_1_WARM", "SENSOR1", "warm temperature", REGULATOR_EVENT_OVER_TEMP_WARN },
+	{ "SENSOR_0_WARM", "SENSOR0", "warm temperature", REGULATOR_EVENT_OVER_TEMP_WARN },
+	{ "SENSOR_3_HOT", "SENSOR3", "hot temperature", REGULATOR_EVENT_OVER_TEMP},
+	{ "SENSOR_2_HOT", "SENSOR2", "hot temperature", REGULATOR_EVENT_OVER_TEMP },
+	{ "SENSOR_1_HOT", "SENSOR1", "hot temperature", REGULATOR_EVENT_OVER_TEMP },
+	{ "SENSOR_0_HOT", "SENSOR0", "hot temperature", REGULATOR_EVENT_OVER_TEMP },
+	{ "TIMEOUT", "", "", REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE },
+};
+
+struct tps65219_regulator_irq_data {
+	struct device *dev;
+	struct tps65219_regulator_irq_type *type;
+	struct regulator_dev *rdev;
+};
+
+#define TPS65219_REGULATOR(_name, _of, _id, _type, _ops, _n, _vr, _vm, _er, \
+			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, \
+			   _ct, _ncl, _bpm) \
+	{								\
+		.name			= _name,			\
+		.of_match		= _of,				\
+		.regulators_node	= of_match_ptr("regulators"),	\
+		.supply_name		= _of,				\
+		.id			= _id,				\
+		.ops			= &(_ops),			\
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
+static int tps65219_set_mode(struct regulator_dev *dev, unsigned int mode)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		return regmap_set_bits(tps->regmap, TPS65219_REG_STBY_1_CONFIG,
+				       dev->desc->enable_mask);
+
+	case REGULATOR_MODE_STANDBY:
+		return regmap_clear_bits(tps->regmap,
+					 TPS65219_REG_STBY_1_CONFIG,
+					 dev->desc->enable_mask);
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int tps65219_get_mode(struct regulator_dev *dev)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+	int ret, value = 0;
+
+	ret = regmap_read(tps->regmap, TPS65219_REG_STBY_1_CONFIG, &value);
+	if (ret) {
+		dev_dbg(tps->dev, "%s failed for regulator %s: %d ",
+			__func__, dev->desc->name, ret);
+		return ret;
+	}
+	value = (value & BIT(rid)) >> rid;
+	if (value)
+		return REGULATOR_MODE_STANDBY;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+/*
+ * generic regulator_set_bypass_regmap does not fully match requirements
+ * TPS65219 Requires explicitly that regulator is disabled before switch
+ */
+static int tps65219_set_bypass(struct regulator_dev *dev, bool enable)
+{
+	struct tps65219 *tps = rdev_get_drvdata(dev);
+	unsigned int rid = rdev_get_id(dev);
+	int ret = 0;
+
+	if (dev->desc->ops->enable) {
+		dev_err(tps->dev,
+			"%s LDO%d enabled, must be shut down to set bypass ",
+			__func__, rid);
+		return -EBUSY;
+	}
+	ret =  regulator_set_bypass_regmap(dev, enable);
+	return ret;
+}
+
+/* Operations permitted on BUCK1/2/3 */
+static const struct regulator_ops tps65219_bucks_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+
+};
+
+/* Operations permitted on LDO1/2 */
+static const struct regulator_ops tps65219_ldos_1_2_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_bypass		= tps65219_set_bypass,
+	.get_bypass		= regulator_get_bypass_regmap,
+};
+
+/* Operations permitted on LDO3/4 */
+static const struct regulator_ops tps65219_ldos_3_4_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.set_mode		= tps65219_set_mode,
+	.get_mode		= tps65219_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+};
+
+static const struct regulator_desc regulators[] = {
+	TPS65219_REGULATOR("BUCK1", "buck1", TPS65219_BUCK_1,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK1_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK1_EN_MASK, 0, 0, bucks_ranges,
+			   3, 4000, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("BUCK2", "buck2", TPS65219_BUCK_2,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK2_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK2_EN_MASK, 0, 0, bucks_ranges,
+			   3, 4000, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("BUCK3", "buck3", TPS65219_BUCK_3,
+			   REGULATOR_VOLTAGE, tps65219_bucks_ops, 64,
+			   TPS65219_REG_BUCK3_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_BUCK3_EN_MASK, 0, 0, bucks_ranges,
+			   3, 0, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("LDO1", "ldo1", TPS65219_LDO_1,
+			   REGULATOR_VOLTAGE, tps65219_ldos_1_2_ops, 64,
+			   TPS65219_REG_LDO1_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO1_EN_MASK, 0, 0, ldos_1_2_ranges,
+			   2, 0, 0, NULL, 0, TPS65219_LDOS_BYP_CONFIG_MASK),
+	TPS65219_REGULATOR("LDO2", "ldo2", TPS65219_LDO_2,
+			   REGULATOR_VOLTAGE, tps65219_ldos_1_2_ops, 64,
+			   TPS65219_REG_LDO2_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO2_EN_MASK, 0, 0, ldos_1_2_ranges,
+			   2, 0, 0, NULL, 0, TPS65219_LDOS_BYP_CONFIG_MASK),
+	TPS65219_REGULATOR("LDO3", "ldo3", TPS65219_LDO_3,
+			   REGULATOR_VOLTAGE, tps65219_ldos_3_4_ops, 64,
+			   TPS65219_REG_LDO3_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO3_EN_MASK, 0, 0, ldos_3_4_ranges,
+			   3, 0, 0, NULL, 0, 0),
+	TPS65219_REGULATOR("LDO4", "ldo4", TPS65219_LDO_4,
+			   REGULATOR_VOLTAGE, tps65219_ldos_3_4_ops, 64,
+			   TPS65219_REG_LDO4_VOUT,
+			   TPS65219_BUCKS_LDOS_VOUT_VSET_MASK,
+			   TPS65219_REG_ENABLE_CTRL,
+			   TPS65219_ENABLE_LDO4_EN_MASK, 0, 0, ldos_3_4_ranges,
+			   3, 0, 0, NULL, 0, 0),
+};
+
+static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
+{
+	struct tps65219_regulator_irq_data *irq_data = data;
+
+	if (irq_data->type->event_name[0] == '\0') {
+		/* This is the timeout interrupt no specific regulator */
+		dev_err(irq_data->dev,
+			"System was put in shutdown due to timeout during an active or standby transition.\n");
+		return IRQ_HANDLED;
+	}
+
+	regulator_notifier_call_chain(irq_data->rdev,
+				      irq_data->type->event, NULL);
+
+	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
+		irq_data->type->event_name, irq_data->type->regulator_name);
+	return IRQ_HANDLED;
+}
+
+static int tps65219_get_rdev_by_name(const char *regulator_name,
+				     struct regulator_dev *rdevtbl[7],
+				     struct regulator_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		if (strcmp(regulator_name, regulators[i].name) == 0) {
+			dev = rdevtbl[i];
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int tps65219_regulator_probe(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	int i;
+	int error;
+	int irq;
+	struct tps65219_regulator_irq_data *irq_data;
+	struct tps65219_regulator_irq_type *irq_type;
+	struct regulator_dev *rdevtbl[7];
+
+	config.dev = tps->dev;
+	config.driver_data = tps;
+	config.regmap = tps->regmap;
+
+	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		dev_dbg(tps->dev, "%s regul i= %d START", __func__, i);
+		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(tps->dev, "failed to register %s regulator\n",
+				pdev->name);
+			return PTR_ERR(rdev);
+		}
+		rdevtbl[i] = rdev;
+		dev_dbg(tps->dev, "%s regul i= %d COMPLETED", __func__, i);
+	}
+
+	irq_data = devm_kmalloc(tps->dev,
+				ARRAY_SIZE(tps65219_regulator_irq_types) *
+				sizeof(struct tps65219_regulator_irq_data),
+				GFP_KERNEL);
+	if (!irq_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(tps65219_regulator_irq_types); ++i) {
+		irq_type = &tps65219_regulator_irq_types[i];
+
+		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
+		if (irq < 0) {
+			dev_err(tps->dev, "Failed to get IRQ %s: %d\n",
+				irq_type->irq_name, irq);
+			return -EINVAL;
+		}
+		irq_data[i].dev = tps->dev;
+		irq_data[i].type = irq_type;
+
+		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
+		if (rdev < 0) {
+			dev_err(tps->dev, "Failed to get rdev for %s\n",
+				irq_type->regulator_name);
+			return -EINVAL;
+		}
+		irq_data[i].rdev = rdev;
+
+		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+						  tps65219_regulator_irq_handler,
+						  IRQF_ONESHOT,
+						  irq_type->irq_name,
+						  &irq_data[i]);
+		if (error) {
+			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
+				irq_type->irq_name, irq, error);
+			return error;
+		}
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
+MODULE_AUTHOR("Jerome Neanne <j-neanne@baylibre.com>");
+MODULE_DESCRIPTION("TPS65219 voltage regulator driver");
+MODULE_ALIAS("platform:tps65219-pmic");
+MODULE_LICENSE("GPL");
-- 
2.17.1

