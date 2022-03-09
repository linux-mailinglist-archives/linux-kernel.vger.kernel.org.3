Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92A4D2936
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiCIG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:58:53 -0500
X-Greylist: delayed 1808 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 22:57:46 PST
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4099B1EAC9;
        Tue,  8 Mar 2022 22:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=spWd4
        NNF6j6yB55aXC5x9VoCFOM86XlKgGcme/hus20=; b=TJiXZLkmtG40v8bpBY1XO
        zMnYkvrrvpF3sxIqGAM+xHxrfGEhC3sQGJDpseS893UEz0JM5mfa6pdynn2+szdC
        Z0x9DayryK+vREuSz9Sx9h1nlY/BDpcKNE13Aw2J37aW4AXQ7ARgk9gJt1SLOlQj
        1YHVROouQwly5JHTfR2WCM=
Received: from localhost (unknown [114.85.182.207])
        by smtp7 (Coremail) with SMTP id DsmowABnBsu7SChi1o8KBQ--.12252S2;
        Wed, 09 Mar 2022 14:27:08 +0800 (CST)
From:   "jiajia.feng" <jiajia.feng@deltaww.com>
To:     jiajia.feng@deltaww.com, xiao.mx.ma@deltaww.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon:Driver for Delta power supplies D380S840A
Date:   Wed,  9 Mar 2022 06:27:04 +0000
Message-Id: <20220309062704.6056-1-jiajia.feng@deltaww.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABnBsu7SChi1o8KBQ--.12252S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfZry8ZF1DAF13Cr4DtF1xAFb_yoW8uFy3Wo
        W3tr45uF1UGry5AryruF4fCFZrur1DtrWkAry3trW7WF9xJan5ta47tws0g3ZxAF4YgFyI
        kry5X34SyaySk34Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw18BDUUUU
X-Originating-IP: [114.85.182.207]
Sender: jiajia_feng_77@126.com
X-CM-SenderInfo: xmldyxpdbiv0ljbxlqqrswhudrp/1tbiIRi+clpEDgPXdwACsE
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

The driver supports D380S840A series modules of Delta.
Standard attributes are in sysfs, and other attributes are in debugfs.

Signed-off-by: jiajia.feng <jiajia.feng@deltaww.com>
---
 Documentation/hwmon/d380s840a.rst |  72 ++++
 Documentation/hwmon/index.rst     |   1 +
 drivers/hwmon/pmbus/Kconfig       |   9 +
 drivers/hwmon/pmbus/Makefile      |   1 +
 drivers/hwmon/pmbus/d380s840a.c   | 598 ++++++++++++++++++++++++++++++
 5 files changed, 681 insertions(+)
 create mode 100644 Documentation/hwmon/d380s840a.rst
 create mode 100644 drivers/hwmon/pmbus/d380s840a.c

diff --git a/Documentation/hwmon/d380s840a.rst b/Documentation/hwmon/d380s840a.rst
new file mode 100644
index 000000000000..b4175bd5083d
--- /dev/null
+++ b/Documentation/hwmon/d380s840a.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver d380s840a
+========================
+
+Supported chips:
+
+  * DELTA D380S840A, D380S840C
+
+    Prefix: 'd380s840a'
+
+    Addresses scanned: -
+
+    Datasheet: https://filecenter.delta-china.com.cn/products/download/01/0102/datasheet/DS_D380S840A.pdf
+
+Authors:
+    jiajia.Feng <jiajia.Feng@deltaww.com>
+
+
+Description
+-----------
+
+This driver implements support for DELTA D380S840A, D380S840C isolated Regulated Power
+Module with PMBus support.
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+
+Sysfs entries
+-------------
+
+===================== ===== ==================================================
+curr1_alarm           RO    Input current alarm
+curr1_input           RO    Input current
+curr1_label           RO    'iin'
+curr2_crit            RW    Output current limit
+curr2_crit_alarm      RO    Output current alarm state
+curr2_input           RO    Output current
+curr2_label           RO    'iout1'
+curr2_max             RW    Output current warning
+curr2_max_alarm       RO    Output current warning state
+curr2_rated_max       RO    Output current rated value
+in1_alarm             RO    Input voltage alarm state
+in1_input             RO    Input voltage
+in1_label             RO    'vin'
+in2_crit              RW    Output voltage limit
+in2_crit_alarm        RO    Output voltage alarm state
+in2_input             RO    Output voltage
+in2_label             RO    'vout1'
+in2_max               RW    Output voltage warning
+in2_max_alarm         RO    Output voltage warning state
+power1_alarm          RO    Input power alarm state
+power1_input          RO    Input power
+power1_label          RO    'pin'
+power2_input          RO    Output power
+power2_label          RO    'pout'
+power2_rated_max      RO    Output power rated value
+temp1_crit            RW    Temperature limit
+temp1_crit_alarm      RO    Temperature alarm state
+temp1_input           RO    temperature
+temp1_max             RW    temperature warning
+temp1_max_alarm       RO    temperature warning state
+===================== ===== ==================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..354d1d250dea 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -52,6 +52,7 @@ Hardware Monitoring Kernel Drivers
    coretemp
    corsair-cpro
    corsair-psu
+   d380s840a
    da9052
    da9055
    dell-smm-hwmon
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 41f6cbf96d3b..5ed150ad2ae0 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -66,6 +66,15 @@ config SENSORS_BPA_RS600
 	  This driver can also be built as a module. If so, the module will
 	  be called bpa-rs600.
 
+config SENSORS_D380S840A
+	tristate "Delta Power Supplies D380S840A"
+	help
+	  If you say yes here you get hardware monitoring support for Delta
+	  D380S840A series Power Supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called d380s840a.
+
 config SENSORS_DELTA_AHE50DC_FAN
 	tristate "Delta AHE-50DC fan control module"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index e5935f70c9e0..8d4417869adc 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_BPA_RS600)	+= bpa-rs600.o
+obj-$(CONFIG_SENSORS_D380S840A)	+= d380s840a.o
 obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
 obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
diff --git a/drivers/hwmon/pmbus/d380s840a.c b/drivers/hwmon/pmbus/d380s840a.c
new file mode 100644
index 000000000000..674705d7ce79
--- /dev/null
+++ b/drivers/hwmon/pmbus/d380s840a.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Delta modules, D380S840A - High Voltage
+ * Node Intermediate Voltage Converter
+ *
+ * Copyright 2022 Delta LLC.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define PAGE_PLUS_WRITE          0x05
+#define PAGE_PLUS_READ           0x06
+#define STORE_DEFAULT_ALL        0x11
+#define RESTORE_DEFAULT_ALL      0x12
+#define TON_DELAY                0x60
+#define TON_RISE                 0x61
+#define READ_EIN                 0x86
+#define READ_EOUT                0x87
+#define APP_PROFILE_SUPPORT      0x9F
+#define MFR_FW_REVISION          0xD9
+#define MFR_IOUT_MAX_CAPABILITY  0xF1
+
+#define VOUT_EXP                 9
+#define TEMPERATURE_EXP          2
+#define TON_DELAY_EXP            1
+#define TON_RISE_EXP             1
+
+enum chips {
+	d380s840a
+};
+
+enum {
+	D380S840A_DEBUGFS_OPERATION = 0,
+	D380S840A_DEBUGFS_ON_OFF_CONFIG,
+	D380S840A_DEBUGFS_CLEARFAULT,
+	D380S840A_DEBUGFS_PAGE_PLUS_WRITE,
+	D380S840A_DEBUGFS_PAGE_PLUS_READ,
+	D380S840A_DEBUGFS_STOREDEFAULT,
+	D380S840A_DEBUGFS_RESTOREDEFAULT,
+	D380S840A_DEBUGFS_CAPABILITY,
+	D380S840A_DEBUGFS_QUERY,
+	D380S840A_DEBUGFS_VOUT_MODE,
+	D380S840A_DEBUGFS_VOUT_COMMAND,
+	D380S840A_DEBUGFS_COEFFICIENTS,
+	D380S840A_DEBUGFS_TON_DELAY,
+	D380S840A_DEBUGFS_TON_RISE,
+	D380S840A_DEBUGFS_EIN,
+	D380S840A_DEBUGFS_EOUT,
+	D380S840A_DEBUGFS_PMBUS_REVISION,
+	D380S840A_DEBUGFS_APP_PROFILE,
+	D380S840A_DEBUGFS_POUT_MAX,
+	D380S840A_DEBUGFS_TEMP_MAX2,
+	D380S840A_DEBUGFS_FW_REVISION,
+	D380S840A_DEBUGFS_IOUT_CAPABILITY,
+	D380S840A_DEBUGFS_NUM_ENTRIES
+};
+
+struct d380s840a_data {
+	enum chips chip;
+	struct i2c_client *client;
+
+	int debugfs_entries[D380S840A_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of((x), struct d380s840a_data, debugfs_entries[(y)])
+
+static struct pmbus_driver_info d380s840a_info[] = {
+	[d380s840a] = {
+		.pages = 1,
+
+		/* Source : Delta D380S840A */
+		.format[PSC_TEMPERATURE] = linear,
+		.format[PSC_VOLTAGE_IN] = linear,
+		.format[PSC_CURRENT_OUT] = linear,
+		.format[PSC_CURRENT_IN] = linear,
+		.format[PSC_POWER] = linear,
+
+		.func[0] = PMBUS_HAVE_VIN |
+		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+		PMBUS_HAVE_IIN  | PMBUS_HAVE_STATUS_INPUT |
+		PMBUS_HAVE_PIN  | PMBUS_HAVE_POUT,
+	},
+};
+
+static ssize_t d380s840a_debugfs_read(struct file *file, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	int rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct d380s840a_data *psu = to_psu(idxp, idx);
+	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char *res;
+	u8 byte_num;
+	u8 index;
+	u16 word_data;
+	u32 long_data;
+	union i2c_smbus_data process_data;
+	struct i2c_client *client = psu->client;
+
+	switch (idx) {
+	case D380S840A_DEBUGFS_OPERATION:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case D380S840A_DEBUGFS_ON_OFF_CONFIG:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case D380S840A_DEBUGFS_PAGE_PLUS_READ:
+		rc = kstrtou32_from_user(buf, count, 0, &long_data);
+		if (rc < 0)
+			return rc;
+
+		process_data.block[0] = (long_data & 0x00FF0000) >> 16;
+		process_data.block[1] = (long_data & 0x0000FF00) >> 8;
+		process_data.block[2] = long_data & 0x000000FF;
+
+		if (process_data.block[2] == PMBUS_STATUS_WORD)
+			byte_num = 3;
+		else
+			byte_num = 2;
+
+		rc = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, PMBUS_QUERY,
+				I2C_SMBUS_BLOCK_PROC_CALL, &process_data);
+
+		if (rc < 0)
+			return rc;
+
+		for (index = 0; index < byte_num; index++)
+			data_char[index] = process_data.block[index];
+
+		res = bin2hex(data, data_char, byte_num);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_CAPABILITY:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_CAPABILITY);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case D380S840A_DEBUGFS_QUERY:
+		rc = kstrtou16_from_user(buf, count, 0, &word_data);
+		if (rc < 0)
+			return rc;
+
+		process_data.word = word_data;
+
+		rc = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+					I2C_SMBUS_READ, PMBUS_QUERY,
+					I2C_SMBUS_BLOCK_PROC_CALL, &process_data);
+
+		if (rc < 0)
+			return rc;
+
+		data_char[0] = process_data.block[0];
+		data_char[1] = process_data.block[1];
+
+		res = bin2hex(data, data_char, 2);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_VOUT_MODE:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case D380S840A_DEBUGFS_VOUT_COMMAND:
+		rc = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
+		if (rc < 0)
+			return rc;
+
+		rc = rc * 1000 / (1 << VOUT_EXP);
+
+		rc = snprintf(data, 6, "%05d", rc);
+		break;
+	case D380S840A_DEBUGFS_COEFFICIENTS:
+		rc = kstrtou16_from_user(buf, count, 0, &word_data);
+		if (rc < 0)
+			return rc;
+
+		process_data.word = word_data;
+
+		rc = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+					I2C_SMBUS_READ, PMBUS_COEFFICIENTS,
+					I2C_SMBUS_BLOCK_PROC_CALL, &process_data);
+
+		if (rc < 0)
+			return rc;
+
+		data_char[0] = process_data.block[0];
+		data_char[1] = process_data.block[1];
+		data_char[2] = process_data.block[2];
+		data_char[3] = process_data.block[3];
+		data_char[4] = process_data.block[4];
+		data_char[5] = process_data.block[5];
+
+		res = bin2hex(data, data_char, 6);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_TON_DELAY:
+		rc = i2c_smbus_read_word_data(psu->client, TON_DELAY);
+		if (rc < 0)
+			return rc;
+
+		rc = (rc & (0x07FF)) / (1 << TON_DELAY_EXP);
+
+		rc = snprintf(data, 3, "%d", rc);
+		break;
+	case D380S840A_DEBUGFS_TON_RISE:
+		rc = i2c_smbus_read_word_data(psu->client, TON_RISE);
+		if (rc < 0)
+			return rc;
+
+		rc = (rc & (0x07FF)) / (1 << TON_RISE_EXP);
+
+		rc = snprintf(data, 4, "%d", rc);
+		break;
+	case D380S840A_DEBUGFS_EIN:
+		rc = i2c_smbus_read_block_data(psu->client, READ_EIN, data_char);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 6);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_EOUT:
+		rc = i2c_smbus_read_block_data(psu->client, READ_EOUT, data_char);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 6);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_PMBUS_REVISION:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case D380S840A_DEBUGFS_APP_PROFILE:
+		rc = i2c_smbus_read_block_data(psu->client, APP_PROFILE_SUPPORT, data_char);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 1);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_POUT_MAX:
+		rc = i2c_smbus_read_word_data(psu->client, PMBUS_MFR_POUT_MAX);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 4, "%03d", rc);
+		break;
+	case D380S840A_DEBUGFS_TEMP_MAX2:
+		rc = i2c_smbus_read_word_data(psu->client, PMBUS_MFR_MAX_TEMP_2);
+		if (rc < 0)
+			return rc;
+
+		rc = (rc & (0x07FF)) / (1 << TEMPERATURE_EXP);
+
+		rc = snprintf(data, 4, "%03d", rc);
+		break;
+	case D380S840A_DEBUGFS_FW_REVISION:
+		rc = i2c_smbus_read_block_data(psu->client, MFR_FW_REVISION, data_char);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 3);
+		rc = res - data;
+
+		break;
+	case D380S840A_DEBUGFS_IOUT_CAPABILITY:
+		rc = i2c_smbus_read_block_data(psu->client, MFR_IOUT_MAX_CAPABILITY, data_char);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 14);
+		rc = res - data;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data[rc] = '\n';
+	rc += 2;
+
+	return simple_read_from_buffer(buf, count, ppos, data, rc);
+}
+
+static ssize_t d380s840a_debugfs_write(struct file *file, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	u8 data_buff[4];
+	u8 dst_data;
+	u16 word_data;
+	u32 long_data;
+	ssize_t rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct d380s840a_data *psu = to_psu(idxp, idx);
+
+	switch (idx) {
+	case D380S840A_DEBUGFS_OPERATION:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_OPERATION, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_ON_OFF_CONFIG:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_ON_OFF_CONFIG, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_CLEARFAULT:
+		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_PAGE_PLUS_WRITE:
+		rc = kstrtou32_from_user(buf, count, 0, &long_data);
+		if (rc < 0)
+			return rc;
+
+		data_buff[0] = (u8)((long_data & 0xFF000000) >> 24);
+		data_buff[1] = (u8)((long_data & 0x00FF0000) >> 16);
+		data_buff[2] = (u8)((long_data & 0x0000FF00) >> 8);
+		data_buff[3] = (u8)(long_data & 0x000000FF);
+
+		rc = i2c_smbus_write_block_data(psu->client, PAGE_PLUS_WRITE, 3, (data_buff + 1));
+		if (rc < 0)
+			return rc;
+		break;
+	case D380S840A_DEBUGFS_STOREDEFAULT:
+		rc = i2c_smbus_write_byte(psu->client, STORE_DEFAULT_ALL);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_RESTOREDEFAULT:
+		rc = i2c_smbus_write_byte(psu->client, RESTORE_DEFAULT_ALL);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_VOUT_COMMAND:
+		rc = kstrtou16_from_user(buf, count, 0, &word_data);
+		if (rc < 0)
+			return rc;
+
+		word_data = (int)word_data * (1 << VOUT_EXP) / 1000;
+
+		rc = i2c_smbus_write_word_data(psu->client, PMBUS_VOUT_COMMAND, word_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_TON_DELAY:
+		rc = kstrtou16_from_user(buf, count, 0, &word_data);
+		if (rc < 0)
+			return rc;
+
+		word_data = (word_data * (1 << TON_DELAY_EXP)) + 0xF800;
+
+		rc = i2c_smbus_write_word_data(psu->client, TON_DELAY, word_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case D380S840A_DEBUGFS_TON_RISE:
+		rc = kstrtou16_from_user(buf, count, 0, &word_data);
+		if (rc < 0)
+			return rc;
+
+		word_data = (word_data * (1 << TON_RISE_EXP)) + 0xF800;
+
+		rc = i2c_smbus_write_word_data(psu->client, TON_RISE, word_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations d380s840a_fops = {
+	.llseek = noop_llseek,
+	.read = d380s840a_debugfs_read,
+	.write = d380s840a_debugfs_write,
+	.open = simple_open,
+};
+
+static const struct i2c_device_id d380s840a_id[] = {
+	{ "d380s840a", d380s840a },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, d380s840a_id);
+
+static int d380s840a_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
+	enum chips chip_id;
+	int ret, i;
+	struct dentry *debugfs;
+	struct dentry *d380s840a_dir;
+	struct d380s840a_data *psu;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	if (client->dev.of_node)
+		chip_id = (enum chips)(unsigned long)of_device_get_match_data(dev);
+	else
+		chip_id = i2c_match_id(d380s840a_id, client)->driver_data;
+
+	ret = i2c_smbus_read_block_data(client, MFR_FW_REVISION, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read Manufacturer Revision\n");
+		return ret;
+	}
+	if (ret != 3) {
+		buf[ret] = '\0';
+		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	ret = pmbus_do_probe(client, &d380s840a_info[chip_id]);
+	if (ret)
+		return ret;
+
+	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+
+	psu->client = client;
+
+	debugfs = pmbus_get_debugfs_dir(client);
+
+	d380s840a_dir = debugfs_create_dir(client->name, debugfs);
+
+	for (i = 0; i < D380S840A_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] = i;
+
+	debugfs_create_file("operation", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_OPERATION],
+			    &d380s840a_fops);
+
+	debugfs_create_file("on_off_config", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_ON_OFF_CONFIG],
+			    &d380s840a_fops);
+
+	debugfs_create_file("clear_fault", 0200, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_CLEARFAULT],
+			    &d380s840a_fops);
+
+	debugfs_create_file("page_plus_write", 0200, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_PAGE_PLUS_WRITE],
+			    &d380s840a_fops);
+
+	debugfs_create_file("page_plus_read", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_PAGE_PLUS_READ],
+			    &d380s840a_fops);
+
+	debugfs_create_file("store_default", 0200, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_STOREDEFAULT],
+			    &d380s840a_fops);
+
+	debugfs_create_file("restore_default", 0200, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_RESTOREDEFAULT],
+			    &d380s840a_fops);
+
+	debugfs_create_file("capability", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_CAPABILITY],
+			    &d380s840a_fops);
+
+	debugfs_create_file("query", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_QUERY],
+			    &d380s840a_fops);
+
+	debugfs_create_file("vout_mode", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_VOUT_MODE],
+			    &d380s840a_fops);
+
+	debugfs_create_file("vout_command", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_VOUT_COMMAND],
+			    &d380s840a_fops);
+
+	debugfs_create_file("coefficients", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_COEFFICIENTS],
+			    &d380s840a_fops);
+
+	debugfs_create_file("ton_delay", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_TON_DELAY],
+			    &d380s840a_fops);
+
+	debugfs_create_file("ton_rise", 0644, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_TON_RISE],
+			    &d380s840a_fops);
+
+	debugfs_create_file("ein", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_EIN],
+			    &d380s840a_fops);
+
+	debugfs_create_file("eout", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_EOUT],
+			    &d380s840a_fops);
+
+	debugfs_create_file("pmbus_revision", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_PMBUS_REVISION],
+			    &d380s840a_fops);
+
+	debugfs_create_file("app_profile_support", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_APP_PROFILE],
+			    &d380s840a_fops);
+
+	debugfs_create_file("mfr_pout_max", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_POUT_MAX],
+			    &d380s840a_fops);
+
+	debugfs_create_file("mfr_max_temperature", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_TEMP_MAX2],
+			    &d380s840a_fops);
+
+	debugfs_create_file("mfr_fw_revision", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_FW_REVISION],
+			    &d380s840a_fops);
+
+	debugfs_create_file("mfr_iout_capability", 0444, d380s840a_dir,
+			    &psu->debugfs_entries[D380S840A_DEBUGFS_IOUT_CAPABILITY],
+			    &d380s840a_fops);
+	return 0;
+}
+
+static const struct of_device_id d380s840a_of_match[] = {
+	{ .compatible = "delta,d380s840a", .data = (void *)d380s840a },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, d380s840a_of_match);
+
+static struct i2c_driver d380s840a_driver = {
+	.driver = {
+		.name = "d380s840a",
+		.of_match_table = d380s840a_of_match,
+	},
+	.probe_new = d380s840a_probe,
+	.id_table = d380s840a_id,
+};
+
+module_i2c_driver(d380s840a_driver);
+
+MODULE_AUTHOR("Jiajia.Feng <jiajia.Feng@deltaww.com>");
+MODULE_DESCRIPTION("PMBus driver for Delta D380S840A series modules");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.20.1

