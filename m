Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6356A3F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiGGNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiGGNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:41:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730F18349
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:41:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os14so2256614ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgkFOALVIy1er0x2WBguonjYu5Ajviwrn8XR9AXRkR0=;
        b=Plpsup2IE+GuUUH4ZI3nbSjTqu4fN8rK/3naA0RMrIjlKm7RGwgUvv/Hr4cdo4bec/
         OK67dwMYz4KdFWFxPddDarhY0qyVlAmSXYZ/uuTXCUIJtBcuQGzGOtPAG1WuuCuwjUTz
         q3dv7ZNZFHF9V4YalAIZomadwkAtzQnBTjuyKIuYY7sE3tRd1+lTCAQjTgDeV7Tvkg4t
         nCqQkLKOVyWh8d/QO7A5kPXE2raLXfkjgJYPeNSbXi79b1wJ5/WVH111+65ehN18GTU2
         Z+pg5m9D9bCZ97z6hogGk/6mUjTWXoiz1MqxlRcMQjIQZ/0zoxE8rudmwC7rREjqbaeK
         10+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgkFOALVIy1er0x2WBguonjYu5Ajviwrn8XR9AXRkR0=;
        b=0QhuPeQm6LLUhr1mPHtJCn2iQJm/37iQiNO+OjkUeqLBzwnmIQrI0mG2e4QyQa9Xgr
         47OpPyqiJfb924peTyI/wkSFfy9CBPw0m2yKozoKVEqRMarKbBffTZmi1NbNwAN7523s
         kAvzWgGKWg40tqEQ5+VPGw4Y7jnc3xrK/OpvG7o+PUZVuw9vQ3Z/7iaGvFMOF6HvgyS6
         SZzyBFx3NaBayb2DUOBqxwiDHyoOM3yWyyBH6TEKO2kCMNEWWSQAAXVLrv6U+v6v1V3f
         CVl2lwwv4gPDuH+g9yj0xkmgICw5FHVh/16o9yVjy8OneAbdLfO27cPCi6LPHa/u8WLP
         pn0A==
X-Gm-Message-State: AJIora+9bWYRfELwwW12C7TsagkSPfqQ8foXQkR8WDnZtVnqg9lG2RzT
        a5lvzfNGI3+ERXLTjdVwT/wVFG3eBigVC89l
X-Google-Smtp-Source: AGRyM1t5i2P6mNQL70ooJQlU/gsGMSxyj7UTcN+uhAz3jRt2jBZ9iPwe3b9DYqaja8Wr7FSSHq29+w==
X-Received: by 2002:a17:907:2cf0:b0:72a:aec1:2bcb with SMTP id hz16-20020a1709072cf000b0072aaec12bcbmr26500501ejc.565.1657201308466;
        Thu, 07 Jul 2022 06:41:48 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id eg37-20020a05640228a500b0043a587eb95dsm9550141edb.5.2022.07.07.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:41:48 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 2/5] mfd: max597x: Add support for MAX5970 and MAX5978
Date:   Thu,  7 Jul 2022 15:41:38 +0200
Message-Id: <20220707134141.1172300-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
References: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement a regulator driver with IRQ support for fault management.
Written against documentation [1] and [2] and tested on real hardware.

Every channel has it's own regulator supply nammed 'vss1-supply' and
'vss2-supply'. The regulator supply is used to determine the output
voltage, as the smart switch provides no output regulation.
The driver requires the 'shunt-resistor-micro-ohms' to be present in
the devicetree to properly calculate current related values.

You must specify compatible devictree layout:

regulator@3a {
        reg = <0x3a>;
        vss1-supply = <&p3v3>;
        compatible = "maxim,max5978";

        ...

        regulators {
                sw0_ref: SW0 {
                        regulator-compatible = "SW0";
                        shunt-resistor-micro-ohms = <12000>;
                        ...
                }
        }
}

1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/mfd/Kconfig         |  12 ++++
 drivers/mfd/Makefile        |   2 +
 drivers/mfd/max597x.c       | 109 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max597x.h | 100 +++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..2422ae155118 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -253,6 +253,18 @@ config MFD_MADERA_SPI
 	  Support for the Cirrus Logic Madera platform audio SoC
 	  core functionality controlled via SPI.
 
+config MFD_MAX597X
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This driver controls a Maxim 5970/5978 switch via I2C bus.
+	  The MAX5970/5978 is a smart switch with no output regulation, but
+	  fault protection and voltage and current monitoring capabilities.
+	  Also it supports upto 4 indication leds.
+
 config MFD_CS47L15
 	bool "Cirrus Logic CS47L15"
 	select PINCTRL_CS47L15
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..f5f46b86401f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -95,6 +95,8 @@ obj-$(CONFIG_MFD_MADERA)	+= madera.o
 obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
 obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
 
+obj-$(CONFIG_MFD_MAX597X) += max597x.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
new file mode 100644
index 000000000000..b2450e64d3eb
--- /dev/null
+++ b/drivers/mfd/max597x.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/version.h>
+#include <linux/mfd/max597x.h>
+
+static const struct regmap_config max597x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX_REGISTERS,
+};
+
+static const struct mfd_cell max597x_devs[] = {
+	{
+	 .name = "max597x-regulator",
+	 },
+	{
+	 .name = "max597x-iio",
+	 },
+	{
+	 .name = "max597x-led",
+	 },
+};
+
+static int max597x_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct max597x_data *max597x;
+	struct regmap *regmap;
+	enum max597x_chip_type chip = id->driver_data;
+
+	max597x =
+	    devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);
+	switch (chip) {
+	case MAX597x_TYPE_MAX5970:
+		max597x->num_switches = 2;
+		break;
+	case MAX597x_TYPE_MAX5978:
+		max597x->num_switches = 1;
+		break;
+	}
+
+	regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "No regmap\n");
+		return -EINVAL;
+	}
+	max597x->regmap = regmap;
+	max597x->irq = i2c->irq;
+	max597x->dev = &i2c->dev;
+	i2c_set_clientdata(i2c, max597x);
+
+	return devm_mfd_add_devices(max597x->dev, PLATFORM_DEVID_AUTO,
+				    max597x_devs, ARRAY_SIZE(max597x_devs),
+				    NULL, 0, NULL);
+}
+
+static const struct i2c_device_id max597x_table[] = {
+	{.name = "max5970", MAX597x_TYPE_MAX5970},
+	{.name = "max5978", MAX597x_TYPE_MAX5978},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, max597x_table);
+
+static const struct of_device_id max597x_of_match[] = {
+	{	.compatible = "maxim,max5970",
+		.data = (void *)MAX597x_TYPE_MAX5970
+	},
+	{	.compatible = "maxim,max5978",
+		.data = (void *)MAX597x_TYPE_MAX5978
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, max597x_of_match);
+
+static struct i2c_driver max597x_driver = {
+	.id_table = max597x_table,
+	.driver = {
+		   .name = "max597x",
+		   .of_match_table = of_match_ptr(max597x_of_match),
+		   },
+	.probe = max597x_probe,
+};
+
+module_i2c_driver(max597x_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
new file mode 100644
index 000000000000..ac7e9c84d06c
--- /dev/null
+++ b/include/linux/mfd/max597x.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#ifndef _MAX597X_H
+#define _MAX597X_H
+
+#include <linux/regmap.h>
+
+#define MAX5970_NUM_SWITCHES 2
+#define MAX5978_NUM_SWITCHES 1
+#define MAX597X_NUM_LEDS     4
+
+struct max597x_data {
+	struct device *dev;
+	int irq;
+	int num_switches;
+	struct regmap *regmap;
+	u32 irng[MAX5970_NUM_SWITCHES];
+	u32 mon_rng[MAX5970_NUM_SWITCHES];
+	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+};
+
+enum max597x_chip_type {
+	MAX597x_TYPE_MAX5978 = 1,
+	MAX597x_TYPE_MAX5970,
+};
+
+#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
+#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
+#define MAX5970_REG_MON_RANGE			0x18
+#define  MAX5970_MON_MASK			0x3
+#define  MAX5970_MON(reg, ch) \
+	(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
+#define  MAX5970_MON_MAX_RANGE_UV		16000000
+
+#define MAX5970_REG_CH_UV_WARN_H(ch)		(0x1A + (ch) * 10)
+#define MAX5970_REG_CH_UV_WARN_L(ch)		(0x1B + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_H(ch)		(0x1C + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_L(ch)		(0x1D + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_H(ch)		(0x1E + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_L(ch)		(0x1F + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_H(ch)		(0x20 + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_L(ch)		(0x21 + (ch) * 10)
+
+#define  MAX5970_VAL2REG_H(x)		(((x) >> 2) & 0xFF)
+#define  MAX5970_VAL2REG_L(x)		((x) & 0x3)
+
+#define MAX5970_REG_DAC_FAST(ch)	(0x2E + (ch))
+
+#define MAX5970_FAST2SLOW_RATIO		200
+
+#define MAX5970_REG_STATUS0		0x31
+#define  MAX5970_CB_IFAULTF(ch)		(1 << (ch))
+#define  MAX5970_CB_IFAULTS(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_STATUS1		0x32
+#define  STATUS1_PROT_MASK		0x3
+#define  STATUS1_PROT(reg) \
+	(((reg) >> 6) & STATUS1_PROT_MASK)
+#define  STATUS1_PROT_SHUTDOWN		0
+#define  STATUS1_PROT_CLEAR_PG		1
+#define  STATUS1_PROT_ALERT_ONLY	2
+
+#define MAX5970_REG_STATUS2		0x33
+#define  MAX5970_IRNG_MASK		0x3
+#define  MAX5970_IRNG(reg, ch) \
+	(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
+
+#define MAX5970_REG_STATUS3		0x34
+#define  MAX5970_STATUS3_ALERT		BIT(4)
+#define  MAX5970_STATUS3_PG(ch)		BIT(ch)
+
+#define MAX5970_REG_FAULT0		0x35
+#define  UV_STATUS_WARN(ch)		(1 << (ch))
+#define  UV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_FAULT1		0x36
+#define  OV_STATUS_WARN(ch)		(1 << (ch))
+#define  OV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_FAULT2		0x37
+#define  OC_STATUS_WARN(ch)		(1 << (ch))
+
+#define MAX5970_REG_CHXEN		0x3b
+#define  CHXEN(ch)			(3 << ((ch) * 2))
+
+#define MAX5970_REG_LED_FLASH		0x43
+
+#define MAX_REGISTERS			0x49
+#define ADC_MASK			0x3FF
+
+#endif				/* _MAX597X_H */
-- 
2.35.3

