Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E444B8106
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiBPHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:08:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiBPHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:08:44 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26382557A2;
        Tue, 15 Feb 2022 23:08:16 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so1462135ooo.13;
        Tue, 15 Feb 2022 23:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEzli4abNeZGgC8Rfd//hwt4EvmKIIeqWGpaHW8Rs3g=;
        b=EjZpfwalv6QzCQBvE7jJdSw3lTDglQbSfR8LOwSkNeXNnEzuRci0pbcYGW51jms3MI
         OCc6FXxgNR2ubkPUCvKqB4SNIpWk+P9KF5gXzLxM1BNqdOPF3vN+dIWN6t2vrTluKvpK
         w3472GPRgfNE5QS4VnaqvuxReZ95VaOJOeNtLRdGqZIm6r3MW+6onVbeFtuLxy3zD6TL
         GjXDZZNkybAxYvI72nI368MrbEgdJs2vkHi+WPSpin1RSdJP5krS0Nz3FgV4FOtZ5LoU
         Tgyw/DUYe7hGV0B0zINo8CQwRG760PXw0yP5uLXIUwGZL1I6u+sY+wQTpWjppM41WNIi
         97+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AEzli4abNeZGgC8Rfd//hwt4EvmKIIeqWGpaHW8Rs3g=;
        b=3MMjJiKwDmvWQNHs6UQGzFPbyTbeLYyaNSqElkA3D3FqAwE5eNma3dvGeYzVr8Xk8U
         csa/Eq/U4KSUtCVDOtpuNqVDctJI8Q9HXzZWP8n5KoWdlH6mVSeJJFQbG5ru1Ice53L1
         qfG/QPcQdeOP6t+cVix3pxHoqfBxo+8pXPUdACE1drrvbAcwHYvQIBGTtm9lYhPDPreP
         RLyY8wXK4nws6CRFPZh64+xMz798pO+I32oAw1e+GTs6obbiObVqaSoh/rbPYFKxL8xv
         2yeoQWwz4zqLHspBAwgk/yrDAiDj3jPE4S0ESUnCZCF2zGO4doDUOtX4u1FUWUXiMtFB
         4Alg==
X-Gm-Message-State: AOAM531OKafx0CjdQs2xu0iSePlqQ7UOGks/vyqthqpNltOqOBXpt+CN
        lTsTm0ryGrHPGEIcw3nuFmJjoVPwH/hnLQ==
X-Google-Smtp-Source: ABdhPJwW362KxDbvw9f92Bm/3fpzNI5QqdZTusuVOuuq17mxA/Lsarj95163XTWX0r1CWBp+kYSGTw==
X-Received: by 2002:a05:6870:c189:b0:ce:c0c9:651 with SMTP id h9-20020a056870c18900b000cec0c90651mr51738oad.163.1644995246878;
        Tue, 15 Feb 2022 23:07:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17sm14427081otk.62.2022.02.15.23.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 23:07:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
Subject: [PATCH v3 2/2] hwmon: Add driver for Texas Instruments TMP464 and TMP468
Date:   Tue, 15 Feb 2022 23:07:20 -0800
Message-Id: <20220216070720.2131761-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216070720.2131761-1-linux@roeck-us.net>
References: <20220216070720.2131761-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instruments TMP464 and TMP468 temperature sensor
ICs.

TI's TMP464 is an I2C temperature sensor chip. This chip is
similar to TI's TMP421 chip, but with 16bit-wide registers (instead
of 8bit-wide registers). The chip has one local sensor and four
remote sensors. TMP468 is similar to TMP464 but has one local and
eight remote sensors.

Originally-from: Agathe Porte <agathe.porte@nokia.com>
Cc: Agathe Porte <agathe.porte@nokia.com>
Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Added support for TMP468
- Added support for various limits, temperature hysteresis, alarm attributes,
  and update interval
- Use regmap instead of local caching
- Use static chip configuration
- Unlock check if needed when loading driver, and lock it when unloading it
  - Call tmp464_init_client() before calling tmp464_probe_from_dt()
    since the latter changes registers, which requires the chip to be
    unlocked.
- Restore configuration register when unloading driver
- ti,n-factor is optional, so don't fail if the property is not present

Notes:
- Tested with real TMP468. Module tested for TMP464.
- I was not able to test with a system supporting devicetree;
  especially negative values for "ti,n-factor" need testing
  (and I wonder if of_property_read_s8() would be needed to
   support this properly).

 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/tmp464.rst |  73 ++++
 MAINTAINERS                    |   2 +
 drivers/hwmon/Kconfig          |  11 +
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/tmp464.c         | 693 +++++++++++++++++++++++++++++++++
 6 files changed, 781 insertions(+)
 create mode 100644 Documentation/hwmon/tmp464.rst
 create mode 100644 drivers/hwmon/tmp464.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..37590db85e65 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -193,6 +193,7 @@ Hardware Monitoring Kernel Drivers
    tmp108
    tmp401
    tmp421
+   tmp464
    tmp513
    tps23861
    tps40422
diff --git a/Documentation/hwmon/tmp464.rst b/Documentation/hwmon/tmp464.rst
new file mode 100644
index 000000000000..7596e7623d06
--- /dev/null
+++ b/Documentation/hwmon/tmp464.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver tmp464
+====================
+
+Supported chips:
+
+  * Texas Instruments TMP464
+
+    Prefix: 'tmp464'
+
+    Addresses scanned: I2C 0x48, 0x49, 0x4a and 0x4b
+
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp464.html
+
+  * Texas Instruments TMP468
+
+    Prefix: 'tmp468'
+
+    Addresses scanned: I2C 0x48, 0x49, 0x4a and 0x4b
+
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp468.html
+
+Authors:
+
+	Agathe Porte <agathe.porte@nokia.com>
+	Guenter Roeck <linux@roeck-us.net>
+
+Description
+-----------
+
+This driver implements support for Texas Instruments TMP464 and TMP468
+temperature sensor chips. TMP464 provides one local and four remote
+sensors. TMP468 provides one local and eight remote sensors.
+Temperature is measured in degrees Celsius. The chips are wired over
+I2C/SMBus and specified over a temperature range of -40 to +125 degrees
+Celsius. Resolution for both the local and remote channels is 0.0625
+degree C.
+
+The chips support only temperature measurements. The driver exports
+temperature values, limits, and alarms via the following sysfs files:
+
+**temp[1-9]_input**
+
+**temp[1-9]_max**
+
+**temp[1-9]_max_hyst**
+
+**temp[1-9]_max_alarm**
+
+**temp[1-9]_crit**
+
+**temp[1-9]_crit_alarm**
+
+**temp[1-9]_crit_hyst**
+
+**temp[2-9]_offset**
+
+**temp[2-9]_fault**
+
+Each sensor can be individually disabled via Devicetree or from sysfs
+via:
+
+**temp[1-9]_enable**
+
+If labels were specified in Devicetree, additional sysfs files will
+be present:
+
+**temp[1-9]_label**
+
+The update interval is configurable with the following sysfs attribute.
+
+**update_interval**
diff --git a/MAINTAINERS b/MAINTAINERS
index f51bc7c7e439..9b51bf5ca3b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19495,6 +19495,8 @@ M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
+F:	Documentation/hwmon/tmp464.rst
+F:	drivers/hwmon/tmp464.c
 
 TMP513 HARDWARE MONITOR DRIVER
 M:	Eric Tremblay <etremblay@distech-controls.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8df25f1079ba..b84932fd0c13 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1979,6 +1979,17 @@ config SENSORS_TMP421
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp421.
 
+config SENSORS_TMP464
+	tristate "Texas Instruments TMP464 and compatible"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for Texas Instruments TMP464
+	  and TMP468 temperature sensor chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called tmp464.
+
 config SENSORS_TMP513
 	tristate "Texas Instruments TMP513 and compatibles"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 185f946d698b..a1f2d6686227 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_TMP103)	+= tmp103.o
 obj-$(CONFIG_SENSORS_TMP108)	+= tmp108.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
+obj-$(CONFIG_SENSORS_TMP464)	+= tmp464.o
 obj-$(CONFIG_SENSORS_TMP513)	+= tmp513.o
 obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
new file mode 100644
index 000000000000..098c53c65393
--- /dev/null
+++ b/drivers/hwmon/tmp464.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Driver for the Texas Instruments TMP464 SMBus temperature sensor IC.
+ * Supported models: TMP464, TMP468
+
+ * Copyright (C) 2022 Agathe Porte <agathe.porte@nokia.com>
+ * Preliminary support by:
+ * Lionel Pouliquen <lionel.lp.pouliquen@nokia.com>
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
+
+#define TMP464_NUM_CHANNELS		5	/* chan 0 is internal, 1-4 are remote */
+#define TMP468_NUM_CHANNELS		9	/* chan 0 is internal, 1-8 are remote */
+
+#define MAX_CHANNELS			9
+
+#define TMP464_TEMP_REG(channel)	(channel)
+#define TMP464_TEMP_OFFSET_REG(channel)	(0x40 + ((channel) - 1) * 8)
+#define TMP464_N_FACTOR_REG(channel)	(0x41 + ((channel) - 1) * 8)
+
+static const u8 TMP464_THERM_LIMIT[MAX_CHANNELS] = {
+	0x39, 0x42, 0x4A, 0x52, 0x5A, 0x62, 0x6a, 0x72, 0x7a };
+static const u8 TMP464_THERM2_LIMIT[MAX_CHANNELS] = {
+	0x3A, 0x43, 0x4B, 0x53, 0x5B, 0x63, 0x6b, 0x73, 0x7b };
+
+#define TMP464_THERM_STATUS_REG			0x21
+#define TMP464_THERM2_STATUS_REG		0x22
+#define TMP464_REMOTE_OPEN_REG			0x23
+#define TMP464_CONFIG_REG			0x30
+#define TMP464_TEMP_HYST_REG			0x38
+#define TMP464_LOCK_REG				0xc4
+
+/* Identification */
+#define TMP464_MANUFACTURER_ID_REG		0xFE
+#define TMP464_DEVICE_ID_REG			0xFF
+
+/* Flags */
+#define TMP464_CONFIG_SHUTDOWN			BIT(5)
+#define TMP464_CONFIG_RANGE			0x04
+#define TMP464_CONFIG_REG_REN(x)		(BIT(7 + (x)))
+#define TMP464_CONFIG_REG_REN_MASK		GENMASK(15, 7)
+#define TMP464_CONFIG_CONVERSION_RATE_B0	2
+#define TMP464_CONFIG_CONVERSION_RATE_B2	4
+#define TMP464_CONFIG_CONVERSION_RATE_MASK      GENMASK(TMP464_CONFIG_CONVERSION_RATE_B2, \
+							TMP464_CONFIG_CONVERSION_RATE_B0)
+
+#define TMP464_UNLOCK_VAL			0xeb19
+#define TMP464_LOCK_VAL				0x5ca6
+#define TMP464_LOCKED				0x8000
+
+/* Manufacturer / Device ID's */
+#define TMP464_MANUFACTURER_ID			0x5449
+#define TMP464_DEVICE_ID			0x1468
+#define TMP468_DEVICE_ID			0x0468
+
+static const struct i2c_device_id tmp464_id[] = {
+	{ "tmp464", TMP464_NUM_CHANNELS },
+	{ "tmp468", TMP468_NUM_CHANNELS },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tmp464_id);
+
+static const struct of_device_id __maybe_unused tmp464_of_match[] = {
+	{
+		.compatible = "ti,tmp464",
+		.data = (void *)TMP464_NUM_CHANNELS
+	},
+	{
+		.compatible = "ti,tmp468",
+		.data = (void *)TMP468_NUM_CHANNELS
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tmp464_of_match);
+
+struct tmp464_channel {
+	const char *label;
+	bool enabled;
+};
+
+struct tmp464_data {
+	struct regmap *regmap;
+	struct mutex update_lock;
+	int channels;
+	s16 config_orig;
+	struct tmp464_channel channel[MAX_CHANNELS];
+};
+
+static int temp_from_reg(s16 reg)
+{
+	return DIV_ROUND_CLOSEST((reg >> 3) * 625, 10);
+}
+
+static s16 temp_to_limit_reg(long temp)
+{
+	return DIV_ROUND_CLOSEST(temp, 500) << 6;
+}
+
+static s16 temp_to_offset_reg(long temp)
+{
+	return DIV_ROUND_CLOSEST(temp * 10, 625) << 3;
+}
+
+static int tmp464_enable_channels(struct tmp464_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	u16 enable = 0;
+	int i;
+
+	for (i = 0; i < data->channels; i++)
+		if (data->channel[i].enabled)
+			enable |= TMP464_CONFIG_REG_REN(i);
+
+	return regmap_update_bits(regmap, TMP464_CONFIG_REG, TMP464_CONFIG_REG_REN_MASK, enable);
+}
+
+static int tmp464_chip_read(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct tmp464_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int status;
+	int err;
+
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		err = regmap_read(regmap, TMP464_CONFIG_REG, &status);
+		if (err)
+			return err;
+		status = (status & TMP464_CONFIG_CONVERSION_RATE_MASK) >>
+					TMP464_CONFIG_CONVERSION_RATE_B0;
+		*val = 125 << (7 - status);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tmp464_temp_read(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct tmp464_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval, regval2;
+	int err = 0;
+
+	switch (attr) {
+	case hwmon_temp_max_alarm:
+		err = regmap_read(regmap, TMP464_THERM_STATUS_REG, &regval);
+		if (err < 0)
+			break;
+		*val = !!(regval & BIT(channel + 7));
+		break;
+	case hwmon_temp_crit_alarm:
+		err = regmap_read(regmap, TMP464_THERM2_STATUS_REG, &regval);
+		if (err < 0)
+			break;
+		*val = !!(regval & BIT(channel + 7));
+		break;
+	case hwmon_temp_fault:
+		err = regmap_read(regmap, TMP464_REMOTE_OPEN_REG, &regval);
+		if (err < 0)
+			break;
+		*val = !!(regval & BIT(channel + 7));
+		break;
+	case hwmon_temp_max_hyst:
+		mutex_lock(&data->update_lock);
+		err = regmap_read(regmap, TMP464_THERM_LIMIT[channel], &regval);
+		if (err < 0)
+			goto unlock_max;
+		err = regmap_read(regmap, TMP464_TEMP_HYST_REG, &regval2);
+		if (err < 0)
+			goto unlock_max;
+		regval -= regval2;
+		*val = temp_from_reg(regval);
+unlock_max:
+		mutex_unlock(&data->update_lock);
+		break;
+	case hwmon_temp_max:
+		err = regmap_read(regmap, TMP464_THERM_LIMIT[channel], &regval);
+		if (err < 0)
+			break;
+		*val = temp_from_reg(regval);
+		break;
+	case hwmon_temp_crit_hyst:
+		mutex_lock(&data->update_lock);
+		err = regmap_read(regmap, TMP464_THERM2_LIMIT[channel], &regval);
+		if (err < 0)
+			goto unlock_crit;
+		err = regmap_read(regmap, TMP464_TEMP_HYST_REG, &regval2);
+		if (err < 0)
+			goto unlock_crit;
+		regval -= regval2;
+		*val = temp_from_reg(regval);
+unlock_crit:
+		mutex_unlock(&data->update_lock);
+		break;
+	case hwmon_temp_crit:
+		err = regmap_read(regmap, TMP464_THERM2_LIMIT[channel], &regval);
+		if (err < 0)
+			break;
+		*val = temp_from_reg(regval);
+		break;
+	case hwmon_temp_offset:
+		err = regmap_read(regmap, TMP464_TEMP_OFFSET_REG(channel), &regval);
+		if (err < 0)
+			break;
+		*val = temp_from_reg(regval);
+		break;
+	case hwmon_temp_input:
+		if (!data->channel[channel].enabled)
+			return -ENODATA;
+		err = regmap_read(regmap, TMP464_TEMP_REG(channel), &regval);
+		if (err < 0)
+			break;
+		*val = temp_from_reg(regval);
+		break;
+	case hwmon_temp_enable:
+		*val = data->channel[channel].enabled;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return err;
+}
+
+static int tmp464_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return tmp464_chip_read(dev, attr, channel, val);
+	case hwmon_temp:
+		return tmp464_temp_read(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tmp464_read_string(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, const char **str)
+{
+	struct tmp464_data *data = dev_get_drvdata(dev);
+
+	*str = data->channel[channel].label;
+
+	return 0;
+}
+
+static int tmp464_set_convrate(struct regmap *regmap, long interval)
+{
+	int rate;
+
+	/*
+	 * For valid rates, interval in milli-seconds can be calculated as
+	 *      interval = 125 << (7 - rate);
+	 * or
+	 *      interval = (1 << (7 - rate)) * 125;
+	 * The rate is therefore
+	 *      rate = 7 - __fls(interval / 125);
+	 * and the rounded rate is
+	 *      rate = 7 - __fls(interval * 4 / (125 * 3));
+	 * Use clamp_val() to avoid overflows, and to ensure valid input
+	 * for __fls.
+	 */
+	interval = clamp_val(interval, 125, 16000);
+	rate = 7 - __fls(interval * 4 / (125 * 3));
+
+	return regmap_update_bits(regmap, TMP464_CONFIG_REG,
+				  TMP464_CONFIG_CONVERSION_RATE_MASK,
+				  rate << TMP464_CONFIG_CONVERSION_RATE_B0);
+}
+
+static int tmp464_chip_write(struct device *dev, u32 attr, int channel, long val)
+{
+	struct tmp464_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		return tmp464_set_convrate(data->regmap, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tmp464_temp_write(struct device *dev, u32 attr, int channel, long val)
+{
+	struct tmp464_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int err = 0;
+
+	switch (attr) {
+	case hwmon_temp_max_hyst:
+		mutex_lock(&data->update_lock);
+		err = regmap_read(regmap, TMP464_THERM_LIMIT[0], &regval);
+		if (err < 0)
+			goto unlock;
+		val = clamp_val(val, -256000, 256000);	/* prevent overflow/underflow */
+		val = clamp_val(temp_from_reg(regval) - val, 0, 255000);
+		err = regmap_write(regmap, TMP464_TEMP_HYST_REG,
+				   DIV_ROUND_CLOSEST(val, 1000) << 7);
+unlock:
+		mutex_unlock(&data->update_lock);
+		break;
+	case hwmon_temp_max:
+		val = temp_to_limit_reg(clamp_val(val, -255000, 255500));
+		err = regmap_write(regmap, TMP464_THERM_LIMIT[channel], val);
+		break;
+	case hwmon_temp_crit:
+		val = temp_to_limit_reg(clamp_val(val, -255000, 255500));
+		err = regmap_write(regmap, TMP464_THERM2_LIMIT[channel], val);
+		break;
+	case hwmon_temp_offset:
+		val = temp_to_offset_reg(clamp_val(val, -128000, 127937));
+		err = regmap_write(regmap, TMP464_TEMP_OFFSET_REG(channel), val);
+		break;
+	case hwmon_temp_enable:
+		mutex_lock(&data->update_lock);
+		data->channel[channel].enabled = !!val;
+		err = tmp464_enable_channels(data);
+		mutex_unlock(&data->update_lock);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int tmp464_write(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return tmp464_chip_write(dev, attr, channel, val);
+	case hwmon_temp:
+		return tmp464_temp_write(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t tmp464_is_visible(const void *_data, enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	const struct tmp464_data *data = _data;
+
+	if (channel >= data->channels)
+		return 0;
+
+	if (type == hwmon_chip) {
+		if (attr == hwmon_chip_update_interval)
+			return 0644;
+		return 0;
+	}
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_crit_hyst:
+		return 0444;
+	case hwmon_temp_enable:
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+		return 0644;
+	case hwmon_temp_max_hyst:
+		if (!channel)
+			return 0644;
+		return 0444;
+	case hwmon_temp_label:
+		if (data->channel[channel].label)
+			return 0444;
+		return 0;
+	case hwmon_temp_fault:
+		if (channel)
+			return 0444;
+		return 0;
+	case hwmon_temp_offset:
+		if (channel)
+			return 0644;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static void tmp464_restore_lock(void *regmap)
+{
+	regmap_write(regmap, TMP464_LOCK_REG, TMP464_LOCK_VAL);
+}
+
+static void tmp464_restore_config(void *_data)
+{
+	struct tmp464_data *data = _data;
+
+	regmap_write(data->regmap, TMP464_CONFIG_REG, data->config_orig);
+}
+
+static int tmp464_init_client(struct device *dev, struct tmp464_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int err;
+
+	err = regmap_read(regmap, TMP464_LOCK_REG, &regval);
+	if (err)
+		return err;
+	if (regval == TMP464_LOCKED) {
+		/* Explicitly unlock chip if it is locked */
+		err = regmap_write(regmap, TMP464_LOCK_REG, TMP464_UNLOCK_VAL);
+		if (err)
+			return err;
+		/* and lock it again when unloading the driver */
+		err = devm_add_action_or_reset(dev, tmp464_restore_lock, regmap);
+		if (err)
+			return err;
+	}
+
+	err = regmap_read(regmap, TMP464_CONFIG_REG, &regval);
+	if (err)
+		return err;
+	data->config_orig = regval;
+	err = devm_add_action_or_reset(dev, tmp464_restore_config, data);
+	if (err)
+		return err;
+
+	/* Default to 500 ms update interval */
+	err = regmap_update_bits(regmap, TMP464_CONFIG_REG,
+				 TMP464_CONFIG_CONVERSION_RATE_MASK | TMP464_CONFIG_SHUTDOWN,
+				 BIT(TMP464_CONFIG_CONVERSION_RATE_B0) |
+				 BIT(TMP464_CONFIG_CONVERSION_RATE_B2));
+	if (err)
+		return err;
+
+	return tmp464_enable_channels(data);
+}
+
+static int tmp464_detect(struct i2c_client *client,
+			 struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	char *name, *chip;
+	int reg;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	reg = i2c_smbus_read_word_swapped(client, TMP464_MANUFACTURER_ID_REG);
+	if (reg < 0)
+		return reg;
+	if (reg != TMP464_MANUFACTURER_ID)
+		return -ENODEV;
+
+	/* Check for "always return zero" bits */
+	reg = i2c_smbus_read_word_swapped(client, TMP464_THERM_STATUS_REG);
+	if (reg < 0)
+		return reg;
+	if (reg & 0x1f)
+		return -ENODEV;
+	reg = i2c_smbus_read_word_swapped(client, TMP464_THERM2_STATUS_REG);
+	if (reg < 0)
+		return reg;
+	if (reg & 0x1f)
+		return -ENODEV;
+
+	reg = i2c_smbus_read_word_swapped(client, TMP464_DEVICE_ID_REG);
+	if (reg < 0)
+		return reg;
+	switch (reg) {
+	case TMP464_DEVICE_ID:
+		name = "tmp464";
+		chip = "TMP464";
+		break;
+	case TMP468_DEVICE_ID:
+		name = "tmp468";
+		chip = "TMP468";
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	strscpy(info->type, name, I2C_NAME_SIZE);
+	dev_info(&adapter->dev, "Detected TI %s chip at 0x%02x\n", chip, client->addr);
+
+	return 0;
+}
+
+static int tmp464_probe_child_from_dt(struct device *dev,
+				      struct device_node *child,
+				      struct tmp464_data *data)
+
+{
+	struct regmap *regmap = data->regmap;
+	u32 channel;
+	s32 val;
+	int err;
+
+	err = of_property_read_u32(child, "reg", &channel);
+	if (err) {
+		dev_err(dev, "missing reg property of %pOFn\n", child);
+		return err;
+	}
+
+	if (channel >= data->channels) {
+		dev_err(dev, "invalid reg %d of %pOFn\n", channel, child);
+		return -EINVAL;
+	}
+
+	of_property_read_string(child, "label", &data->channel[channel].label);
+
+	data->channel[channel].enabled = of_device_is_available(child);
+
+	err = of_property_read_s32(child, "ti,n-factor", &val);
+	if (err && err != -EINVAL)
+		return err;
+	if (!err) {
+		if (channel == 0) {
+			dev_err(dev, "n-factor can't be set for internal channel\n");
+			return -EINVAL;
+		}
+		if (val > 127 || val < -128) {
+			dev_err(dev, "n-factor for channel %d invalid (%d)\n",
+				channel, val);
+			return -EINVAL;
+		}
+		err = regmap_write(regmap, TMP464_N_FACTOR_REG(channel), val);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tmp464_probe_from_dt(struct device *dev, struct tmp464_data *data)
+{
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int err;
+
+	for_each_child_of_node(np, child) {
+		if (strcmp(child->name, "channel"))
+			continue;
+
+		err = tmp464_probe_child_from_dt(dev, child, data);
+		if (err) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops tmp464_ops = {
+	.is_visible = tmp464_is_visible,
+	.read = tmp464_read,
+	.read_string = tmp464_read_string,
+	.write = tmp464_write,
+};
+
+static const struct hwmon_channel_info *tmp464_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_OFFSET | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT_ALARM | HWMON_T_FAULT),
+	NULL
+};
+
+static const struct hwmon_chip_info tmp464_chip_info = {
+	.ops = &tmp464_ops,
+	.info = tmp464_info,
+};
+
+/* regmap */
+
+static bool tmp464_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return (reg < TMP464_TEMP_REG(TMP468_NUM_CHANNELS) ||
+		reg == TMP464_THERM_STATUS_REG ||
+		reg == TMP464_THERM2_STATUS_REG ||
+		reg == TMP464_REMOTE_OPEN_REG);
+}
+
+static const struct regmap_config tmp464_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = TMP464_DEVICE_ID_REG,
+	.volatile_reg = tmp464_is_volatile_reg,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int tmp464_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct tmp464_data *data;
+	int i, err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(&client->dev, "i2c functionality check failed\n");
+		return -ENODEV;
+	}
+	data = devm_kzalloc(dev, sizeof(struct tmp464_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->update_lock);
+
+	if (dev->of_node)
+		data->channels = (int)(unsigned long)of_device_get_match_data(&client->dev);
+	else
+		data->channels = i2c_match_id(tmp464_id, client)->driver_data;
+
+	data->regmap = devm_regmap_init_i2c(client, &tmp464_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	for (i = 0; i < data->channels; i++)
+		data->channel[i].enabled = true;
+
+	err = tmp464_init_client(dev, data);
+	if (err)
+		return err;
+
+	if (dev->of_node) {
+		err = tmp464_probe_from_dt(dev, data);
+		if (err)
+			return err;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data, &tmp464_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct i2c_driver tmp464_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "tmp464",
+		.of_match_table = of_match_ptr(tmp464_of_match),
+	},
+	.probe_new = tmp464_probe,
+	.id_table = tmp464_id,
+	.detect = tmp464_detect,
+	.address_list = normal_i2c,
+};
+
+module_i2c_driver(tmp464_driver);
+
+MODULE_AUTHOR("Agathe Porte <agathe.porte@nokia.com>");
+MODULE_DESCRIPTION("Texas Instruments TMP464 temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

