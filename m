Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08D4C5623
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiBZNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBZNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:31:35 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACF4D62E;
        Sat, 26 Feb 2022 05:31:00 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9587471C;
        Sat, 26 Feb 2022 05:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645882260;
        bh=wUYYxDY8AGbMdMwS9eyQ30HcvFh6YtT2MmyW4AB2xgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLXfDMLheV+mFxBoMkTU5Jt9VbzT9pxVA5qX2dBA++F1mnZOjteNpNhZvBHQ5IyqA
         fVOU3WIbAdCckRtrlOUstZ53F9gBItsyoYIOuEoCQPHuUafT6+K0EPbTcktbLElBQS
         Obx4IIzGfcoINzllQJm8BnB6X1SwXWWhvyDVFNAw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] hwmon: (nct6775) Add i2c driver
Date:   Sat, 26 Feb 2022 05:30:47 -0800
Message-Id: <20220226133047.6226-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226133047.6226-1-zev@bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
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

This driver provides an i2c I/O mechanism for the core nct6775 driver,
as might be used by a BMC.  Because the Super I/O chip is shared with
the host CPU in such a scenario (and the host should ultimately be in
control of it), the i2c driver is strictly read-only to avoid
interfering with any usage by the host (aside from the bank-select
register, which seems to be replicated for the i2c interface).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 MAINTAINERS                 |   6 ++
 drivers/hwmon/Kconfig       |  17 ++++
 drivers/hwmon/Makefile      |   1 +
 drivers/hwmon/nct6775-i2c.c | 191 ++++++++++++++++++++++++++++++++++++
 4 files changed, 215 insertions(+)
 create mode 100644 drivers/hwmon/nct6775-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d318a5580df9..d8a1f8f65df1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13293,6 +13293,12 @@ F:	drivers/hwmon/nct6775-core.c
 F:	drivers/hwmon/nct6775-platform.c
 F:	drivers/hwmon/nct6775.h
 
+NCT6775 HARDWARE MONITOR DRIVER - I2C DRIVER
+M:	Zev Weiss <zev@bewilderbeest.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/nct6775-i2c.c
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 11822e8a2cda..1c0bd536b9b3 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1483,6 +1483,23 @@ config SENSORS_NCT6775_PLATFORM
 	  This driver can also be built as a module. If so, the module
 	  will be called nct6775-platform.
 
+config SENSORS_NCT6775_I2C
+	tristate "I2C driver for Nuvoton NCT6775F and compatibles"
+	depends on I2C
+	select REGMAP_I2C
+	select SENSORS_NCT6775
+	help
+	  If you say yes here you get support for the hardware monitoring
+	  functionality of the Nuvoton NCT6106D, NCT6775F, NCT6776F, NCT6779D,
+	  NCT6791D, NCT6792D, NCT6793D, NCT6795D, NCT6796D, and compatible
+	  Super-I/O chips via their I2C interface.
+
+	  If you're not building a kernel for a BMC, this is probably
+	  not the driver you want (see CONFIG_SENSORS_NCT6775_PLATFORM).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct6775-i2c.
+
 config SENSORS_NCT7802
 	tristate "Nuvoton NCT7802Y"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 5f37b2c0f79a..385b211471e4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
 obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775-core.o
 obj-$(CONFIG_SENSORS_NCT6775_PLATFORM) += nct6775-platform.o
+obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
 obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
diff --git a/drivers/hwmon/nct6775-i2c.c b/drivers/hwmon/nct6775-i2c.c
new file mode 100644
index 000000000000..efee78cb16f3
--- /dev/null
+++ b/drivers/hwmon/nct6775-i2c.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * nct6775-i2c - I2C driver for the hardware monitoring functionality of
+ *	         Nuvoton NCT677x Super-I/O chips
+ *
+ * Copyright (C) 2021 Zev Weiss <zev@bewilderbeest.net>
+ *
+ * This driver interacts with the chip via it's "back door" i2c interface, as
+ * is often exposed to a BMC.  Because the host may still be operating the
+ * chip via the ("front door") LPC interface, this driver cannot assume that
+ * it actually has full control of the chip, and in particular must avoid
+ * making any changes that could confuse the host's LPC usage of it.  It thus
+ * operates in a strictly read-only fashion, with the only exception being the
+ * bank-select register (which seems, thankfully, to be replicated for the i2c
+ * interface so it doesn't affect the LPC interface).
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include "nct6775.h"
+
+static u16 nct6775_i2c_read_value(struct nct6775_data *data, u16 reg)
+{
+	int ret;
+	u32 tmp, val;
+	u8 bank = reg >> 8;
+	struct regmap *regmap = data->driver_data;
+	struct device *dev = regmap_get_device(regmap);
+
+	if (bank != data->bank) {
+		ret = regmap_write(regmap, NCT6775_REG_BANK, bank);
+		if (ret) {
+			dev_warn_ratelimited(dev, "bank %02x select regmap_write() failed: %d\n",
+					     bank, ret);
+			return 0;
+		}
+		data->bank = bank;
+	}
+
+	ret = regmap_read(regmap, reg & 0xff, &val);
+	if (ret) {
+		dev_warn_ratelimited(dev, "regmap_read(%03x) failed: %d\n", reg, ret);
+		return 0;
+	}
+
+	if (nct6775_reg_is_word_sized(data, reg)) {
+		ret = regmap_read(regmap, (reg & 0xff) + 1, &tmp);
+		if (ret) {
+			dev_warn_ratelimited(dev, "second-byte regmap_read(%03x) failed: %d\n",
+					     reg, ret);
+			return 0;
+		}
+		val = (val << 8) | tmp;
+	}
+
+	return val;
+}
+
+/*
+ * The write operation is a dummy so as not to disturb anything being done
+ * with the chip via LPC.
+ */
+static int nct6775_i2c_write_value(struct nct6775_data *data, u16 reg, u16 value)
+{
+	struct device *dev = regmap_get_device(data->driver_data);
+
+	dev_dbg(dev, "skipping attempted write: %02x -> %03x\n", value, reg);
+
+	/*
+	 * This is a lie, but writing anything but the bank-select register is
+	 * something this driver shouldn't be doing.  (Though at least at time
+	 * of writing no callers actually check this return value anyway.)
+	 */
+	return 0;
+}
+
+static const struct regmap_config nct6775_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct of_device_id __maybe_unused nct6775_i2c_of_match[] = {
+	{ .compatible = "nuvoton,nct6106", .data = (void *)nct6106, },
+	{ .compatible = "nuvoton,nct6116", .data = (void *)nct6116, },
+	{ .compatible = "nuvoton,nct6775", .data = (void *)nct6775, },
+	{ .compatible = "nuvoton,nct6776", .data = (void *)nct6776, },
+	{ .compatible = "nuvoton,nct6779", .data = (void *)nct6779, },
+	{ .compatible = "nuvoton,nct6791", .data = (void *)nct6791, },
+	{ .compatible = "nuvoton,nct6792", .data = (void *)nct6792, },
+	{ .compatible = "nuvoton,nct6793", .data = (void *)nct6793, },
+	{ .compatible = "nuvoton,nct6795", .data = (void *)nct6795, },
+	{ .compatible = "nuvoton,nct6796", .data = (void *)nct6796, },
+	{ .compatible = "nuvoton,nct6797", .data = (void *)nct6797, },
+	{ .compatible = "nuvoton,nct6798", .data = (void *)nct6798, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nct6775_i2c_of_match);
+
+static const struct i2c_device_id nct6775_i2c_id[] = {
+	{ "nct6106", nct6106 },
+	{ "nct6116", nct6116 },
+	{ "nct6775", nct6775 },
+	{ "nct6776", nct6776 },
+	{ "nct6779", nct6779 },
+	{ "nct6791", nct6791 },
+	{ "nct6792", nct6792 },
+	{ "nct6793", nct6793 },
+	{ "nct6795", nct6795 },
+	{ "nct6796", nct6796 },
+	{ "nct6797", nct6797 },
+	{ "nct6798", nct6798 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nct6775_i2c_id);
+
+static int nct6775_i2c_probe_init(struct nct6775_data *data)
+{
+	/*
+	 * The i2c interface doesn't provide access to the control registers
+	 * needed to determine the presence of other fans, but fans 1 and 2
+	 * are (in principle) always there.
+	 *
+	 * In practice this is perhaps a little silly, because the system
+	 * using this driver is mostly likely a BMC, and hence probably has
+	 * totally separate fan tachs & pwms of its own that are actually
+	 * controlling/monitoring the fans -- these are thus unlikely to be
+	 * doing anything actually useful.
+	 */
+	data->has_fan = 0x03;
+	data->has_fan_min = 0x03;
+	data->has_pwm = 0x03;
+	return 0;
+}
+
+static int nct6775_i2c_probe(struct i2c_client *client)
+{
+	struct nct6775_data *data;
+	const struct of_device_id *of_id;
+	const struct i2c_device_id *i2c_id;
+	struct regmap *regmap;
+	struct device *dev = &client->dev;
+
+	of_id = of_match_device(nct6775_i2c_of_match, dev);
+	i2c_id = i2c_match_id(nct6775_i2c_id, client);
+
+	if (of_id && (unsigned long)of_id->data != i2c_id->driver_data)
+		dev_notice(dev, "Device mismatch: %s in device tree, %s detected\n",
+			   of_id->name, i2c_id->name);
+
+	regmap = devm_regmap_init_i2c(client, &nct6775_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->kind = i2c_id->driver_data;
+	data->read_value = nct6775_i2c_read_value;
+	data->write_value = nct6775_i2c_write_value;
+
+	data->read_only = true;
+	data->driver_data = regmap;
+	data->driver_init = nct6775_i2c_probe_init;
+
+	return nct6775_probe(dev, data);
+}
+
+static struct i2c_driver nct6775_i2c_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "nct6775-i2c",
+		.of_match_table = of_match_ptr(nct6775_i2c_of_match),
+	},
+	.probe_new = nct6775_i2c_probe,
+	.id_table = nct6775_i2c_id,
+};
+
+module_i2c_driver(nct6775_i2c_driver);
+
+MODULE_AUTHOR("Zev Weiss <zev@bewilderbeest.net>");
+MODULE_DESCRIPTION("I2C driver for NCT6775F and compatible chips");
+MODULE_LICENSE("GPL");
-- 
2.35.1

