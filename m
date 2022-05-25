Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53853349D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiEYBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiEYBH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:07:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB173795;
        Tue, 24 May 2022 18:07:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so24330357fac.11;
        Tue, 24 May 2022 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmR8wkfA7W7Cn/+i0UqXv0pjN/podOl6oVqBQojmpc0=;
        b=gx2Ov5tVlRySe3wg8tsPXf9jkU+zkLGaWaSrl1GAbrYpaR1c5AmMjO19m4u+gisqNX
         wWeGPdtC95/OdWIhhCYW+snUhZL13ssJdfnB8l2p/o+bz82+22vrM0+v5mO5SNGN2iqA
         NPxjoYTdESf0Jtr5RSrs9MqMq9CVJXPkcOOp8M5cflWTd7kjQehFntG8dI+JmLlT8SHa
         fh7m+6U9NETckeU8n+0ZQOhggQo3D/3kt1Sfd1+Q+dFt1jo0Bbz8A1cPjyQNsSVXodyh
         LJnVBFvAFRzVsx1Te5Md9i0Pnbik3CPOBlhXhogf7YJDPkmqdNOI10OlkZPW01TIMGPI
         5PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cmR8wkfA7W7Cn/+i0UqXv0pjN/podOl6oVqBQojmpc0=;
        b=Hj1o/IDlgr1HydkfMyK/2oMZco4aBfm+Y02HQQgsTV2X3Wv0uKZDHc6uRrjDWA/Zjp
         PQOQX9vlQdo6TZ0TtxCprPVt8T/sqYsFyQwZI3SKq1+uWWAAvXnx6xioMkMnHXvyvMVX
         gr/dYmK6Dx/HO8lBIpbmksXOYDYRWqi6eDudtrXlm7EE6KC3ZvxJv6NhR6LTaXav0hqq
         mpprpiEeJ3jhD5OIa2XZh2GlgyOQOhSREHVAhpvSIi6AwRzNPOYXDa1Hc1biSYA3kI6O
         u8qBzxlaGOueEYDTWVFCRPhJ9nBHxZ6D0MfRUvQycQCs5D432/lwSxXBwo3b6jIMYW+R
         Nyrg==
X-Gm-Message-State: AOAM532LNsJltsMjI9sj2OPG24w92OEKPA9UD8yrBXq2Sp2tdtHlnPzs
        yp35RRfxWEflSwxzVQw0mVq/tTqqCuzv9A==
X-Google-Smtp-Source: ABdhPJyWR2hTwJRm7HLfF9dfRCngJHKXWANPOs/YNnGGaDlKSfd2dq0WgxzWCkNlhUXW1o/kTbawjw==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr4260405oaa.9.1653440846554;
        Tue, 24 May 2022 18:07:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k123-20020a4a4a81000000b0035eb4e5a6b8sm6210195oob.14.2022.05.24.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:07:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] hwmon: (pmbus) Add support for Analog Devices LT7182S
Date:   Tue, 24 May 2022 18:07:17 -0700
Message-Id: <20220525010717.4000736-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525010717.4000736-1-linux@roeck-us.net>
References: <20220525010717.4000736-1-linux@roeck-us.net>
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

Add support for Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase
Step-Down Silent Switcher with Digital Power System Management.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch

 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/lt7182s.rst |  91 +++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |   9 ++
 drivers/hwmon/pmbus/Makefile    |   1 +
 drivers/hwmon/pmbus/lt7182s.c   | 195 ++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+)
 create mode 100644 Documentation/hwmon/lt7182s.rst
 create mode 100644 drivers/hwmon/pmbus/lt7182s.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index a72c16872ec2..f7113b0f8b2a 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -109,6 +109,7 @@ Hardware Monitoring Kernel Drivers
    lm95234
    lm95245
    lochnagar
+   lt7182s
    ltc2992
    ltc2945
    ltc2947
diff --git a/Documentation/hwmon/lt7182s.rst b/Documentation/hwmon/lt7182s.rst
new file mode 100644
index 000000000000..aac7789d807b
--- /dev/null
+++ b/Documentation/hwmon/lt7182s.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0
+Kernel driver lt7182s
+=====================
+
+Supported chips:
+
+  * ADI LT7182S
+
+    Prefix: 'lt7182s'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/lt7182s.html
+
+Author: Guenter Roeck <linux@roeck-us.net>
+
+
+Description
+-----------
+
+LT7182S is a Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher with
+Digital Power System Management support.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantiate
+devices explicitly.
+
+Example: the following commands will load the driver for a LT7182S
+at address 0x4f on I2C bus #4::
+
+    # modprobe lt7182s
+    # echo lt7182s 0x4f > /sys/bus/i2c/devices/i2c-4/new_device
+
+It can also be instantiated by declaring an entry in device tree.
+
+
+Sysfs attributes
+----------------
+
+======================  ====================================
+curr[1-2]_label		"iin[12]"
+curr[1-2]_input		Measured input current
+curr[1-2]_max		Maximum input current
+curr[1-2]_max_alarm	Current high alarm
+
+curr[3-4]_label		"iout[1-2]"
+curr[3-4]_input		Measured output current
+curr[3-4]_highest	Highest measured output current
+curr[3-4]_max		Maximum output current
+curr[3-4]_max_alarm	Output current high alarm
+
+in[1-2]_label		"vin[12]"
+in[1-2]_input		Measured input voltage
+in[1-2]_highest		Highest measured input voltage
+in[1-2]_crit		Critical maximum input voltage
+in[1-2]_crit_alarm	Input voltage critical high alarm
+in[1-2]_min		Minimum input voltage
+in[1-2]_min_alarm	Input voltage low alarm
+in[1-2]_rated_min	Rated minimum input voltage
+in[1-2]_rated_max	Rated maximum input voltage
+in1_reset_history	Write to reset history for all attributes
+
+in[3-5]_label		"vmon[1-3]"
+in[3-5]_input		Measured voltage on ITH1/ITH2/EXTVCC pins
+			Only available if enabled with MFR_ADC_CONTROL_LT7182S
+			command.
+
+in[3-4|6-7]_label	"vout[1-2]"
+in[3-4|6-7]_input	Measured output voltage
+in[3-4|6-7]_highest	Highest measured output voltage
+in[3-4|6-7]_lcrit	Critical minimum output voltage
+in[3-4|6-7]_lcrit_alarm	Output voltage critical low alarm
+in[3-4|6-7]_min		Minimum output voltage
+in[3-4|6-7]_max_alarm	Output voltage low alarm
+in[3-4|6-7]_max		Maximum output voltage
+in[3-4|6-7]_max_alarm	Output voltage high alarm
+in[3-4|6-7]_crit	Critical maximum output voltage
+in[3-4|6-7]_crit_alarm	Output voltage critical high alarm
+
+power[1-2]_label	"pout[1-2]"
+power[1-2]_input	Measured output power
+
+temp1_input		Measured temperature
+temp1_crit		Critical high temperature
+temp1_crit_alarm	Chip temperature critical high alarm
+temp1_max		Maximum temperature
+temp1_max_alarm		Chip temperature high alarm
+======================  ====================================
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index dfae76db65ae..951e4a9ff2d6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -181,6 +181,15 @@ config SENSORS_LM25066_REGULATOR
 	  If you say yes here you get regulator support for National
 	  Semiconductor LM25066, LM5064, and LM5066.
 
+config SENSORS_LT7182S
+	tristate "Analog Devices LT7182S"
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices LT7182S.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called lt7182s.
+
 config SENSORS_LTC2978
 	tristate "Linear Technologies LTC2978 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4678fba5012c..e2fe86f98965 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
 obj-$(CONFIG_SENSORS_IRPS5401)	+= irps5401.o
 obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
 obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
+obj-$(CONFIG_SENSORS_LT7182S)	+= lt7182s.o
 obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
 obj-$(CONFIG_SENSORS_LTC3815)	+= ltc3815.o
 obj-$(CONFIG_SENSORS_MAX15301)	+= max15301.o
diff --git a/drivers/hwmon/pmbus/lt7182s.c b/drivers/hwmon/pmbus/lt7182s.c
new file mode 100644
index 000000000000..4cfe476fc92d
--- /dev/null
+++ b/drivers/hwmon/pmbus/lt7182s.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Analog Devices LT7182S
+ *
+ * Copyright (c) 2022 Guenter Roeck
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include "pmbus.h"
+
+#define LT7182S_NUM_PAGES	2
+
+#define MFR_READ_EXTVCC		0xcd
+#define MFR_READ_ITH		0xce
+#define MFR_CONFIG_ALL_LT7182S	0xd1
+#define MFR_IOUT_PEAK		0xd7
+#define MFR_ADC_CONTROL_LT7182S 0xd8
+
+#define MFR_DEBUG_TELEMETRY	BIT(0)
+
+#define MFR_VOUT_PEAK		0xdd
+#define MFR_VIN_PEAK		0xde
+#define MFR_TEMPERATURE_1_PEAK	0xdf
+#define MFR_CLEAR_PEAKS		0xe3
+
+#define MFR_CONFIG_IEEE		BIT(8)
+
+static int lt7182s_read_word_data(struct i2c_client *client, int page, int phase, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_READ_VMON:
+		if (page == 0 || page == 1)
+			ret = pmbus_read_word_data(client, page, phase, MFR_READ_ITH);
+		else
+			ret = pmbus_read_word_data(client, 0, phase, MFR_READ_EXTVCC);
+		break;
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase, MFR_IOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_VOUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase, MFR_VOUT_PEAK);
+		break;
+	case PMBUS_VIRT_READ_VIN_MAX:
+		ret = pmbus_read_word_data(client, page, phase, MFR_VIN_PEAK);
+		break;
+	case PMBUS_VIRT_READ_TEMP_MAX:
+		ret = pmbus_read_word_data(client, page, phase, MFR_TEMPERATURE_1_PEAK);
+		break;
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+		ret = (page == 0) ? 0 : -ENODATA;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static int lt7182s_write_word_data(struct i2c_client *client, int page, int reg, u16 word)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIRT_RESET_VIN_HISTORY:
+		ret = pmbus_write_byte(client, 0, MFR_CLEAR_PEAKS);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info lt7182s_info = {
+	.pages = LT7182S_NUM_PAGES,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_POWER] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT |
+	  PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
+	  PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+	  PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
+	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT |
+	  PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
+	  PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+	  PMBUS_HAVE_STATUS_INPUT,
+	.read_word_data = lt7182s_read_word_data,
+	.write_word_data = lt7182s_write_word_data,
+};
+
+static int lt7182s_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pmbus_driver_info *info;
+	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA |
+				     I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read PMBUS_MFR_ID\n");
+		return ret;
+	}
+	if (ret != 3 || strncmp(buf, "ADI", 3)) {
+		buf[ret] = '\0';
+		dev_err(dev, "Manufacturer '%s' not supported\n", buf);
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
+		return ret;
+	}
+	if (ret != 7 || strncmp(buf, "LT7182S", 7)) {
+		buf[ret] = '\0';
+		dev_err(dev, "Model '%s' not supported\n", buf);
+		return -ENODEV;
+	}
+
+	info = devm_kmemdup(dev, &lt7182s_info,
+			    sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	/* Set data format to IEEE754 if configured */
+	ret = i2c_smbus_read_word_data(client, MFR_CONFIG_ALL_LT7182S);
+	if (ret < 0)
+		return ret;
+	if (ret & MFR_CONFIG_IEEE) {
+		info->format[PSC_VOLTAGE_IN] = ieee754;
+		info->format[PSC_VOLTAGE_OUT] = ieee754;
+		info->format[PSC_CURRENT_IN] = ieee754;
+		info->format[PSC_CURRENT_OUT] = ieee754;
+		info->format[PSC_TEMPERATURE] = ieee754;
+		info->format[PSC_POWER] = ieee754;
+	}
+
+	/* Enable VMON output if configured */
+	ret = i2c_smbus_read_byte_data(client, MFR_ADC_CONTROL_LT7182S);
+	if (ret < 0)
+		return ret;
+	if (ret & MFR_DEBUG_TELEMETRY) {
+		info->pages = 3;
+		info->func[0] |= PMBUS_HAVE_VMON;
+		info->func[1] |= PMBUS_HAVE_VMON;
+		info->func[2] = PMBUS_HAVE_VMON;
+	}
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id lt7182s_id[] = {
+	{ "lt7182s", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, lt7182s_id);
+
+static const struct of_device_id __maybe_unused lt7182s_of_match[] = {
+	{ .compatible = "adi,lt7182s" },
+	{}
+};
+
+static struct i2c_driver lt7182s_driver = {
+	.driver = {
+		.name = "lt7182s",
+		.of_match_table = of_match_ptr(lt7182s_of_match),
+	},
+	.probe_new = lt7182s_probe,
+	.id_table = lt7182s_id,
+};
+
+module_i2c_driver(lt7182s_driver);
+
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices LT7182S");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.35.1

