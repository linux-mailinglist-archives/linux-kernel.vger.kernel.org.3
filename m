Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47C8482CC8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiABVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiABVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:11:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87239C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 13:11:37 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F04BF49;
        Sun,  2 Jan 2022 22:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641157893;
        bh=Gk+sbDxHdWUa9EYDzTWdRXK92RC1R8yXrfVFXX5Hizk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzQBsfRpItnLM9/i1jd9LkisNC491hlzJsmhpA7o7u4kFu7sLNO7ZXsum4rCS7O4Y
         avua6XA/VbVWrGMbJoYNrsYhjVjtNXb38w39YjOKXKYuObH8Z71XOahIskhaplcB8R
         FhDLqW0W8wC5laDNfvl2FEs6QutbEYFP1+iL7nm0=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Date:   Sun,  2 Jan 2022 23:11:24 +0200
Message-Id: <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Watson Chow <watson.chow@avnet.com>

The MAX20086-MAX20089 are dual/quad power protectors for cameras. Add a
driver that supports controlling the outputs individually. Additional
features, such as overcurrent detection, may be added later if needed.

Signed-off-by: Watson Chow <watson.chow@avnet.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v0:

- Remove unused regulator_config members
- Drop unused header
- Use SPDX header
- Sort headers alphabetically
- Fix macros indendation
- Removed unused macros
- Remove debugging printks
- Drop IRQ support
- Fix indentation and formatting
- Drop unsupported operations
- Allocate of_regulator_match on the stack
- Make regulator desc macro parameterized
- Reinit regulator_config for each regulator
- Disable interrupts before registering regulators
- Drop error variable in probe()
- Use sizeof(variable) instead of sizeof(type)
- Register regulators last
- Move configuration out of detection
- Move detection to separate function
- Move gpiod_get() to probe()
- Reorganize struct max20087
- Specify device ID in match data
- Specify number of outputs in info structure
- Drop min/max voltages
- Reorder functions
- Don't read CONFIG at probe time
- Fail probe() if disabling outputs fails
- Clean up messages
- Use .probe_new()
- Include vendor prefix in compatible string
- Support MAX20086, 88 and 89
- Reorder Kconfig and Makefile entries
- Reorganize regulator data
- Drop unneeded headers
- Fail if no output is found in DT
- Set enable GPIO after disabling outputs
- Add MAINTAINERS entry
- Depend on GPIOLIB and OF
- Add support for IN supply
---
 MAINTAINERS                            |   7 +
 drivers/regulator/Kconfig              |  10 +-
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max20086-regulator.c | 333 +++++++++++++++++++++++++
 4 files changed, 350 insertions(+), 1 deletion(-)
 create mode 100644 drivers/regulator/max20086-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 79fd8a012893..2891e71c0b9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11577,6 +11577,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
 F:	drivers/power/supply/max17042_battery.c
 
+MAXIM MAX20086 CAMERA POWER PROTECTOR DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
+F:	drivers/regulator/max20086-regulator.c
+
 MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6be9b1c8a615..dd5c70fe7438 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -636,6 +636,15 @@ config REGULATOR_MAX8998
 	  via I2C bus. The provided regulator is suitable for S3C6410
 	  and S5PC1XX chips to control VCC_CORE and VCC_USIM voltages.
 
+config REGULATOR_MAX20086
+	tristate "Maxim MAX20086-MAX20089 Camera Power Protectors"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver controls a Maxim MAX20086-MAX20089 camera power
+	  protectorvia I2C bus. The regulator has 2 or 4 outputs depending on
+	  the device model. This driver is only capable to turn on/off them.
+
 config REGULATOR_MAX77686
 	tristate "Maxim 77686 regulator"
 	depends on MFD_MAX77686 || COMPILE_TEST
@@ -1415,4 +1424,3 @@ config REGULATOR_QCOM_LABIBB
 	  for LCD display panel.
 
 endif
-
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b07d2a22df0b..a9e986231eb8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_REGULATOR_MAX8952) += max8952.o
 obj-$(CONFIG_REGULATOR_MAX8973) += max8973-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8997) += max8997-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8998) += max8998.o
+obj-$(CONFIG_REGULATOR_MAX20086) += max20086-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77686) += max77686-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77693) += max77693-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77802) += max77802-regulator.o
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
new file mode 100644
index 000000000000..8edefb0090c4
--- /dev/null
+++ b/drivers/regulator/max20086-regulator.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * max20086-regulator.c - MAX20086-MAX20089 camera power protector driver
+ *
+ * Copyright (C) 2022 Laurent Pinchart <laurent.pinchart@idesonboard.com>
+ * Copyright (C) 2018 Avnet, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+/* Register Offset */
+#define MAX20086_REG_MASK		0x00
+#define MAX20086_REG_CONFIG		0x01
+#define	MAX20086_REG_ID			0x02
+#define	MAX20086_REG_STAT1		0x03
+#define	MAX20086_REG_STAT2_L		0x04
+#define	MAX20086_REG_STAT2_H		0x05
+#define	MAX20086_REG_ADC1		0x06
+#define	MAX20086_REG_ADC2		0x07
+#define	MAX20086_REG_ADC3		0x08
+#define	MAX20086_REG_ADC4		0x09
+
+/* DEVICE IDs */
+#define MAX20086_DEVICE_ID_MAX20086	0x40
+#define MAX20086_DEVICE_ID_MAX20087	0x20
+#define MAX20086_DEVICE_ID_MAX20088	0x10
+#define MAX20086_DEVICE_ID_MAX20089	0x00
+#define DEVICE_ID_MASK			0xf0
+
+/* Register bits */
+#define MAX20086_EN_MASK		0x0f
+#define MAX20086_EN_OUT1		0x01
+#define MAX20086_EN_OUT2		0x02
+#define MAX20086_EN_OUT3		0x04
+#define MAX20086_EN_OUT4		0x08
+#define MAX20086_INT_DISABLE_ALL	0x3f
+
+#define MAX20086_MAX_REGULATORS		4
+
+struct max20086_chip_info {
+	u8 id;
+	unsigned int num_outputs;
+};
+
+struct max20086_regulator {
+	struct device_node *of_node;
+	struct regulator_init_data *init_data;
+	const struct regulator_desc *desc;
+	struct regulator_dev *rdev;
+};
+
+struct max20086 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *gpio_en;
+
+	const struct max20086_chip_info *info;
+	unsigned int num_outputs;
+
+	struct max20086_regulator regulators[MAX20086_MAX_REGULATORS];
+};
+
+static const struct regulator_ops max20086_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+#define MAX20086_REGULATOR_DESC(n)		\
+{						\
+	.name = max20086_output_names[n],	\
+	.supply_name = "in",			\
+	.id = (n),				\
+	.ops = &max20086_buck_ops,		\
+	.type = REGULATOR_VOLTAGE,		\
+	.owner = THIS_MODULE,			\
+	.enable_reg = MAX20086_REG_CONFIG,	\
+	.enable_mask = (1 << (n)),		\
+	.enable_val = (1 << (n)),		\
+	.disable_val = 0,			\
+}
+
+static const char * const max20086_output_names[] = {
+	"OUT1",
+	"OUT2",
+	"OUT3",
+	"OUT4",
+};
+
+static const struct regulator_desc max20086_regulators[] = {
+	MAX20086_REGULATOR_DESC(0),
+	MAX20086_REGULATOR_DESC(1),
+	MAX20086_REGULATOR_DESC(2),
+	MAX20086_REGULATOR_DESC(3),
+};
+
+static int max20086_regulators_register(struct max20086 *chip)
+{
+	unsigned int i;
+
+	for (i = 0; i < chip->num_outputs; i++) {
+		struct max20086_regulator *reg = &chip->regulators[i];
+		struct regulator_config config = { };
+		struct regulator_dev *rdev;
+
+		config.init_data = reg->init_data;
+		config.dev = chip->dev;
+		config.driver_data = chip;
+		config.regmap = chip->regmap;
+		config.of_node = reg->of_node;
+
+		rdev = devm_regulator_register(chip->dev, reg->desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(chip->dev,
+				"Failed to register regulator output %s\n",
+				reg->desc->name);
+			return PTR_ERR(rdev);
+		}
+
+		reg->rdev = rdev;
+	}
+
+	return 0;
+}
+
+static int max20086_parse_regulators_dt(struct max20086 *chip)
+{
+	struct of_regulator_match matches[MAX20086_MAX_REGULATORS] = { };
+	struct device_node *node;
+	unsigned int i;
+	unsigned int n;
+	int num;
+
+	node = of_get_child_by_name(chip->dev->of_node, "regulators");
+	if (!node) {
+		dev_err(chip->dev, "regulators node not found\n");
+		return PTR_ERR(node);
+	}
+
+	for (i = 0; i < chip->info->num_outputs; ++i)
+		matches[i].name = max20086_output_names[i];
+
+	num = of_regulator_match(chip->dev, node, matches,
+				 chip->info->num_outputs);
+	of_node_put(node);
+	if (num <= 0) {
+		dev_err(chip->dev, "Failed to match regulators\n");
+		return -EINVAL;
+	}
+
+	chip->num_outputs = num;
+
+	for (i = 0, n = 0; i < chip->num_outputs; i++) {
+		struct max20086_regulator *reg = &chip->regulators[n];
+
+		if (!matches[i].init_data)
+			continue;
+
+		reg->init_data = matches[i].init_data;
+		reg->of_node = matches[i].of_node;
+		reg->desc = &max20086_regulators[i];
+
+		dev_dbg(chip->dev, "Found output %s\n", reg->desc->name);
+		n++;
+	}
+
+	return 0;
+}
+
+static int max20086_detect(struct max20086 *chip)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(chip->regmap, MAX20086_REG_ID, &data);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read DEVICE_ID reg: %d\n", ret);
+		return ret;
+	}
+
+	if ((data & DEVICE_ID_MASK) != chip->info->id) {
+		dev_err(chip->dev, "Invalid device ID 0x%02x\n", data);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static bool max20086_gen_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX20086_REG_MASK:
+	case MAX20086_REG_CONFIG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config max20086_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = max20086_gen_is_writeable_reg,
+	.max_register = 0x9,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int max20086_i2c_probe(struct i2c_client *i2c)
+{
+	struct max20086 *chip;
+	int ret;
+
+	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &i2c->dev;
+	chip->info = device_get_match_data(chip->dev);
+
+	i2c_set_clientdata(i2c, chip);
+
+	chip->regmap = devm_regmap_init_i2c(i2c, &max20086_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(chip->dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	ret = max20086_parse_regulators_dt(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = max20086_detect(chip);
+	if (ret < 0)
+		return ret;
+
+	/* Turn off all outputs. */
+	ret = regmap_update_bits(chip->regmap, MAX20086_REG_CONFIG,
+				 MAX20086_EN_MASK, 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to disable outputs: %d\n", ret);
+		return ret;
+	}
+
+	/* Until IRQ support is added, just disable all interrupts. */
+	ret = regmap_update_bits(chip->regmap, MAX20086_REG_MASK,
+				 MAX20086_INT_DISABLE_ALL,
+				 MAX20086_INT_DISABLE_ALL);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to disable interrupts: %d\n", ret);
+		return ret;
+	}
+
+	/* Get the chip out of low-power shutdown state. */
+	chip->gpio_en = devm_gpiod_get(chip->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->gpio_en)) {
+		ret = PTR_ERR(chip->gpio_en);
+		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
+		return ret;
+	}
+
+	ret = max20086_regulators_register(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to register regulators: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id max20086_i2c_id[] = {
+	{ "max20086" },
+	{ "max20087" },
+	{ "max20088" },
+	{ "max20089" },
+	{ /* Sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
+
+static const struct of_device_id max20086_dt_ids[] = {
+	{
+		.compatible = "maxim,max20086",
+		.data = &(const struct max20086_chip_info) {
+			.id = MAX20086_DEVICE_ID_MAX20086,
+			.num_outputs = 4,
+		}
+	}, {
+		.compatible = "maxim,max20087",
+		.data = &(const struct max20086_chip_info) {
+			.id = MAX20086_DEVICE_ID_MAX20087,
+			.num_outputs = 4,
+		}
+	}, {
+		.compatible = "maxim,max20088",
+		.data = &(const struct max20086_chip_info) {
+			.id = MAX20086_DEVICE_ID_MAX20088,
+			.num_outputs = 2,
+		}
+	}, {
+		.compatible = "maxim,max20089",
+		.data = &(const struct max20086_chip_info) {
+			.id = MAX20086_DEVICE_ID_MAX20089,
+			.num_outputs = 2,
+		}
+	},
+	{ /* Sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, max20086_dt_ids);
+
+static struct i2c_driver max20086_regulator_driver = {
+	.driver = {
+		.name = "max20086",
+		.of_match_table = of_match_ptr(max20086_dt_ids),
+	},
+	.probe_new = max20086_i2c_probe,
+	.id_table = max20086_i2c_id,
+};
+
+module_i2c_driver(max20086_regulator_driver);
+
+MODULE_AUTHOR("Watson Chow <watson.chow@avnet.com>");
+MODULE_DESCRIPTION("MAX20086-MAX20089 Camera Power Protector Driver");
+MODULE_LICENSE("GPL");
-- 
Regards,

Laurent Pinchart

