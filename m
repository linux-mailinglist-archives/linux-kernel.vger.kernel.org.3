Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4456A6FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiGGPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiGGPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:31:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B931DC4;
        Thu,  7 Jul 2022 08:31:01 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EHRZ2012226;
        Thu, 7 Jul 2022 11:30:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h5u9s2qtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 11:30:45 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 267FUiwk010663
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 11:30:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 11:30:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 11:30:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Jul 2022 11:30:43 -0400
Received: from euswvd-wpr-621.reddog.microsoft.com ([10.140.226.135])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 267FTmbJ008137;
        Thu, 7 Jul 2022 11:30:33 -0400
From:   Atif Ofluoglu <Atif.Ofluoglu@analog.com>
To:     <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Atif Ofluoglu <atif.ofluoglu@analog.com>,
        Atif Ofluoglu <Atif.Ofluoglu@analog.com>
Subject: [PATCH 1/2] hwmon: (pmbus/max20754) Add support for MAX20754
Date:   Thu, 7 Jul 2022 15:29:17 +0000
Message-ID: <3659043f92b0ca9e538679e00f7dcc214525ff2e.1657204859.git.atif.ofluoglu@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657204859.git.atif.ofluoglu@analog.com>
References: <cover.1657204859.git.atif.ofluoglu@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 05orWxmTXXV64X_Viz6w8lSbS_noqW9b
X-Proofpoint-ORIG-GUID: 05orWxmTXXV64X_Viz6w8lSbS_noqW9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atif Ofluoglu <atif.ofluoglu@analog.com>

Signed-off-by: Atif Ofluoglu <Atif.Ofluoglu@analog.com>
---
 drivers/hwmon/pmbus/Kconfig    |   9 +
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/max20754.c | 390 +++++++++++++++++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/max20754.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index dfae76db65ae..f259b8739766 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -254,6 +254,15 @@ config SENSORS_MAX20751
 	  This driver can also be built as a module. If so, the module will
 	  be called max20751.
 
+config SENSORS_MAX20754
+	tristate "Maxim MAX20754"
+	help
+	  If you say yes here you get hardware monitoring support for Maxim
+	  MAX20754.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max20754.
+
 config SENSORS_MAX31785
 	tristate "Maxim MAX31785 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4678fba5012c..b8b1d8a84b3b 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX16601)	+= max16601.o
 obj-$(CONFIG_SENSORS_MAX20730)	+= max20730.o
 obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
+obj-$(CONFIG_SENSORS_MAX20751)	+= max20754.o
 obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
diff --git a/drivers/hwmon/pmbus/max20754.c b/drivers/hwmon/pmbus/max20754.c
new file mode 100644
index 000000000000..5e29e8f8009b
--- /dev/null
+++ b/drivers/hwmon/pmbus/max20754.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Maxim MAX20754 Dual-Output, Configurable Multiphase
+ * Power-Supply Controller with PMBus Interface
+ * and Internal Buck Converter Driver
+ *
+ * Author: Atif Emre Ofluoglu <atif.ofluoglu@analog.com>
+ * Copyright (C) 2022 Analog Devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under  the terms of  the GNU General  Public License as published
+ * by the Free Software Foundation;  either version 2 of the  License,
+ * or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include "pmbus.h"
+
+enum chips { max20754 };
+
+#define MAX20754_NUM_PHASES 6
+#define MAX20754_LINEAR_EXPONENT -10
+
+struct max20754_data {
+	enum chips id;
+	struct pmbus_driver_info info;
+	struct i2c_client *rail2;
+	bool smbus_i2c_block_read;
+};
+
+#define to_max20754_data(x) container_of(x, struct max20754_data, info)
+
+enum max20754_reg_index {
+	operation_index,
+	on_off_config_index,
+	vout_command_index,
+	num_regs,
+};
+
+static const u8 max20754_regs[num_regs][2] = {
+	[operation_index] = {PMBUS_OPERATION, 1},
+	[on_off_config_index] = {PMBUS_ON_OFF_CONFIG, 1},
+	[vout_command_index] = {PMBUS_VOUT_COMMAND, 2},
+};
+
+static u16 val_to_linear16(int val)
+{
+	return ((u16)val * 1000LL) >> -MAX20754_LINEAR_EXPONENT;
+}
+
+static long linear16_to_val(s64 val)
+{
+	if (val == 0)
+		return 0;
+
+	val <<= -MAX20754_LINEAR_EXPONENT;
+	val = DIV_ROUND_CLOSEST_ULL(val, 1000);
+	val = clamp_val(val, 0, 0xffff);
+	return val;
+}
+
+static int max20754_read_block_data(struct i2c_client *client, int reg,
+				    u8 length, u8 *values)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+	int ret;
+
+	if (data->smbus_i2c_block_read) {
+		ret = i2c_smbus_read_i2c_block_data(client, reg, length, values);
+		if (ret < 1)
+			return ret;
+		ret = ret - 1;
+		memcpy(values, &values[1], ret);
+	} else {
+		ret = i2c_smbus_read_block_data(client, reg, values);
+	}
+
+	return ret;
+}
+
+static int max20754_read_word(struct i2c_client *client, int page, int phase,
+			      int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+
+	if (reg > 0xFF)
+		return -ENXIO;
+
+	if (reg == PMBUS_MFR_VOUT_MAX)
+		reg = PMBUS_VOUT_MAX;
+
+	switch (page) {
+	case 0:		/* RAIL1 */
+		return i2c_smbus_read_word_data(client, reg);
+	case 1:		/* RAIL2 */
+		return i2c_smbus_read_word_data(data->rail2, reg);
+	default:
+		return -ENODATA;
+	}
+
+	return -ENODATA;
+}
+
+static int max20754_write_word(struct i2c_client *client, int page, int reg, u16 value)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+
+	switch (reg) {
+	case PMBUS_OPERATION:
+		if (value >= 0x90 && value <= 0x93)
+			return -EOPNOTSUPP;
+		break;
+	case PMBUS_MFR_VOUT_MAX:
+		reg = PMBUS_VOUT_MAX;
+		break;
+	default:
+		break;
+	}
+
+	switch (page) {
+	case 0:		/* RAIL1 */
+		return i2c_smbus_write_word_data(client, reg, value);
+	case 1:		/* RAIL2 */
+		return i2c_smbus_write_word_data(data->rail2, reg, value);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return -ENODATA;
+}
+
+static int max20754_read_byte(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+	int vout_mode;
+
+	if (reg == PMBUS_VOUT_MODE) {
+		vout_mode = i2c_smbus_read_byte_data(client, reg);
+		if (vout_mode != 0x2C)
+			vout_mode = 0x16;
+		return vout_mode;
+	}
+
+	switch (page) {
+	case 0:		/* RAIL1 */
+		return i2c_smbus_read_byte_data(client, reg);
+	case 1:		/* RAIL2 */
+		return i2c_smbus_read_byte_data(data->rail2, reg);
+	default:
+		return -ENODATA;
+	}
+	return -ENODATA;
+}
+
+static int max20754_write_byte(struct i2c_client *client, int page, u8 reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+
+	if (reg == PMBUS_CLEAR_FAULTS) {
+		switch (page) {
+		case 0:
+			return i2c_smbus_write_byte(client, reg);
+		case 1:
+			return i2c_smbus_write_byte(data->rail2, reg);
+		default:
+			return -ENODATA;
+		}
+	}
+	return -ENODATA;
+}
+
+static int max20754_identify(struct i2c_client *client,
+			     struct pmbus_driver_info *info)
+{
+	struct device *dev = &client->dev;
+	u8 buf[9] = {0};
+	int ret;
+
+	ret = max20754_read_block_data(client,
+				       PMBUS_IC_DEVICE_ID, 9,
+				       buf);
+
+	if (ret < 0 || ret < 8)
+		return -ENODEV;
+
+	/*
+	 * PMBUS_IC_DEVICE_ID is expected to return "MAX20754"
+	 */
+
+	if (strncmp(buf, "MAX20754", 8)) {
+		buf[ret] = '\0';
+		dev_err(dev, "Unsupported chip '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static ssize_t max20754_register_store(struct device *dev,
+				       struct device_attribute *attr, const char *buf,
+				       size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max20754_data *data = to_max20754_data(info);
+
+	u8 cmd = max20754_regs[sattr->index][0];
+	u8 reg_size = max20754_regs[sattr->index][1];
+	u8 rail_number = sattr->nr;
+	long val = 0;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (rail_number == 1)
+		client = data->rail2;
+
+	if (cmd == PMBUS_VOUT_COMMAND)
+		val = linear16_to_val(val);
+
+	switch (reg_size) {
+	case 1:
+		ret = i2c_smbus_write_byte_data(client, cmd, val);
+		break;
+	case 2:
+		ret = i2c_smbus_write_word_data(client, cmd, val);
+		break;
+	default:
+		break;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t max20754_register_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+
+	int ret_val = 0;
+	u8 cmd = max20754_regs[sattr->index][0];
+	u8 reg_size = max20754_regs[sattr->index][1];
+	u8 rail_number = sattr->nr;
+
+	switch (reg_size) {
+	case 1:
+		ret_val = max20754_read_byte(client, rail_number, cmd);
+		break;
+	case 2:
+		ret_val = max20754_read_word(client, rail_number, 0, cmd);
+		break;
+	default:
+		break;
+	}
+
+	if (ret_val < 0)
+		return -ENODATA;
+
+	if (cmd == PMBUS_VOUT_COMMAND)
+		ret_val = val_to_linear16(ret_val);
+
+	return sprintf(buf, "%d\n", ret_val);
+}
+
+#define MAX20754_REGISTER_ATTR_RW(__name, __reg_index, __size) \
+	SENSOR_DEVICE_ATTR_2_RW(__name, max20754_register, __size, __reg_index)
+
+static MAX20754_REGISTER_ATTR_RW(operation, operation_index, 0);
+static MAX20754_REGISTER_ATTR_RW(on_off_config, on_off_config_index, 0);
+
+static MAX20754_REGISTER_ATTR_RW(vout1_command, vout_command_index, 0);
+static MAX20754_REGISTER_ATTR_RW(vout2_command, vout_command_index, 1);
+
+static struct attribute *max20754_attrs[] = {
+	&sensor_dev_attr_operation.dev_attr.attr,
+	&sensor_dev_attr_on_off_config.dev_attr.attr,
+	&sensor_dev_attr_vout1_command.dev_attr.attr,
+	&sensor_dev_attr_vout2_command.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max20754);
+
+static struct pmbus_driver_info max20754_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.vrm_version[0] = vr12,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP,
+	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_INPUT |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP,
+	.identify = max20754_identify,
+	.read_byte_data = max20754_read_byte,
+	.read_word_data = max20754_read_word,
+	.write_byte = max20754_write_byte,
+	.write_word_data = max20754_write_word,
+};
+
+static void max20754_remove(void *_data)
+{
+	struct max20754_data *data = _data;
+
+	i2c_unregister_device(data->rail2);
+}
+
+static int max20754_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max20754_data *data;
+	bool i2c_block_data_ok = false;
+	int ret = 0;
+
+	ret = i2c_check_functionality(client->adapter,
+				      I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				      I2C_FUNC_SMBUS_READ_BLOCK_DATA);
+
+	if (!ret) {
+		ret = i2c_check_functionality(client->adapter,
+					      I2C_FUNC_SMBUS_READ_BYTE_DATA |
+					      I2C_FUNC_SMBUS_I2C_BLOCK);
+		if (!ret)
+			return -ENODEV;
+
+		i2c_block_data_ok = true;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->rail2 = i2c_new_dummy_device(client->adapter, client->addr + 1);
+	if (IS_ERR(data->rail2)) {
+		dev_err(dev, "Failed to register rail2 client\n");
+		return PTR_ERR(data->rail2);
+	}
+	ret = devm_add_action_or_reset(dev, max20754_remove, data);
+	if (ret)
+		return ret;
+
+	data->info = max20754_info;
+	data->info.groups = max20754_groups;
+	data->smbus_i2c_block_read = i2c_block_data_ok;
+
+	return pmbus_do_probe(client, &data->info);
+}
+
+static const struct i2c_device_id max20754_id[] = {
+	{"max20754", max20754},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max20754_id);
+
+static struct i2c_driver max20754_driver = {
+	.driver = {
+		   .name = "max20754",
+		   },
+	.probe_new = max20754_probe,
+	.remove = pmbus_do_remove,
+	.id_table = max20754_id,
+};
+
+module_i2c_driver(max20754_driver);
+
+MODULE_AUTHOR("Atif Emre Ofluoglu <atif.ofluoglu@analog.com>");
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX20754");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1

