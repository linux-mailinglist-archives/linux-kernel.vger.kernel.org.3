Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7A4A9C46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376274AbiBDPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:52:50 -0500
Received: from smtp2.axis.com ([195.60.68.18]:54919 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359867AbiBDPwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643989966;
  x=1675525966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEFl0IDx9piLP8bHlv+kRc+UofmjW22E2dtACMTdADI=;
  b=dXvEpt16uN/GZCMhY1PP5c+HHBuwuJcs1S80K/TjOPQ/vvibg+t8ojtG
   AFLpHRekX0Mq5XBm7NI6DUT8uXfzEZOoOe5leky5nGER++PePHFliAaZZ
   79D6WaCazHI2Z9kAnDusAZKDn2H0n38C5SJ4ClFhyPaXgHh2p32Vwemws
   ZUj7w2JwKcHqbXppUvCMmpn16h/svvJZyYSqxggiB7x4dimsCIRKuktvb
   iD97vy4SmHzDLzfxD+NiNM1dTTs9U3rwtOAVDY7wFO5cM43mCHz+ekhmk
   7mq6XLcNPO94pj2AygPe+idseNGpoDSHgP/HlXTrmd6Tzxu6MHQKs3UFk
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] regulator: Add support for TPS6286x
Date:   Fri, 4 Feb 2022 16:52:41 +0100
Message-ID: <20220204155241.576342-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204155241.576342-1-vincent.whitchurch@axis.com>
References: <20220204155241.576342-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's TPS62864/TPS6286/TPS62868/TPS62869 are high-frequency synchronous
step-down converters controlled via I2C.  There are differences in the
electrical characteristics and packaging between the variants, but the
register interfaces are identical.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/Kconfig              |   9 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/tps6286x-regulator.c | 159 +++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/regulator/tps6286x-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 1c35fed20d34..49e26f187742 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1263,6 +1263,15 @@ config REGULATOR_TPS62360
 	  high-frequency synchronous step down dc-dc converter optimized
 	  for battery-powered portable applications.
 
+config REGULATOR_TPS6286X
+	tristate "TI TPS6286x Power Regulator"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  This driver supports TPS6236x voltage regulator chips. These are
+	  high-frequency synchronous step-down converters with an I2C
+	  interface.
+
 config REGULATOR_TPS65023
 	tristate "TI TPS65023 Power regulators"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2e1b087489fa..4b8794a73e17 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_REGULATOR_SY8827N) += sy8827n.o
 obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
+obj-$(CONFIG_REGULATOR_TPS6286X) += tps6286x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6507X) += tps6507x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65086) += tps65086-regulator.o
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
new file mode 100644
index 000000000000..e29deda30d75
--- /dev/null
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright Axis Communications AB
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
+
+#include <dt-bindings/regulator/ti,tps62864.h>
+
+#define TPS6286X_VOUT1		0x01
+#define TPS6286X_VOUT1_VO1_SET	GENMASK(7, 0)
+
+#define TPS6286X_CONTROL	0x03
+#define TPS6286X_CONTROL_FPWM	BIT(4)
+#define TPS6286X_CONTROL_SWEN	BIT(5)
+
+#define TPS6286X_MIN_MV		400
+#define TPS6286X_MAX_MV		1675
+#define TPS6286X_STEP_MV	5
+
+static const struct regmap_config tps6286x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int tps6286x_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	unsigned int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	case REGULATOR_MODE_FAST:
+		val = TPS6286X_CONTROL_FPWM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, TPS6286X_CONTROL,
+				  TPS6286X_CONTROL_FPWM, val);
+}
+
+static unsigned int tps6286x_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, TPS6286X_CONTROL, &val);
+	if (ret < 0)
+		return 0;
+
+	return (val & TPS6286X_CONTROL_FPWM) ? REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops tps6286x_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_mode = tps6286x_set_mode,
+	.get_mode = tps6286x_get_mode,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+};
+
+static unsigned int tps6286x_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case TPS62864_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case TPS62864_MODE_FPWM:
+		return REGULATOR_MODE_FAST;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static const struct regulator_desc tps6286x_reg = {
+	.name = "tps6286x",
+	.of_match = of_match_ptr("SW"),
+	.owner = THIS_MODULE,
+	.ops = &tps6286x_regulator_ops,
+	.of_map_mode = tps6286x_of_map_mode,
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = ((TPS6286X_MAX_MV - TPS6286X_MIN_MV) / TPS6286X_STEP_MV) + 1,
+	.min_uV = TPS6286X_MIN_MV * 1000,
+	.uV_step = TPS6286X_STEP_MV * 1000,
+	.vsel_reg = TPS6286X_VOUT1,
+	.vsel_mask = TPS6286X_VOUT1_VO1_SET,
+	.enable_reg = TPS6286X_CONTROL,
+	.enable_mask = TPS6286X_CONTROL_SWEN,
+	.ramp_delay = 1000,
+	/* tDelay + tRamp, rounded up */
+	.enable_time = 3000,
+};
+
+static const struct of_device_id tps6286x_dt_ids[] = {
+	{ .compatible = "ti,tps62864", },
+	{ .compatible = "ti,tps62866", },
+	{ .compatible = "ti,tps62868", },
+	{ .compatible = "ti,tps62869", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tps6286x_dt_ids);
+
+static int tps6286x_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &tps6286x_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	config.dev = &i2c->dev;
+	config.of_node = dev->of_node;
+	config.regmap = regmap;
+
+	rdev = devm_regulator_register(&i2c->dev, &tps6286x_reg, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(&i2c->dev, "Failed to register tps6286x regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id tps6286x_i2c_id[] = {
+	{ "tps62864", 0 },
+	{ "tps62866", 0 },
+	{ "tps62868", 0 },
+	{ "tps62869", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, tps6286x_i2c_id);
+
+static struct i2c_driver tps6286x_regulator_driver = {
+	.driver = {
+		.name = "tps6286x",
+		.of_match_table = of_match_ptr(tps6286x_dt_ids),
+	},
+	.probe = tps6286x_i2c_probe,
+	.id_table = tps6286x_i2c_id,
+};
+
+module_i2c_driver(tps6286x_regulator_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

