Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB49C4791B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhLQQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhLQQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:43:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A79C061574;
        Fri, 17 Dec 2021 08:43:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z9so10094102edb.5;
        Fri, 17 Dec 2021 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh7sGhttlhZbI7NSh0VENOm0Oc3Ab680O6iIj+Zj98c=;
        b=PN7v8sFTRwC48pHhs/K7W5lpdbgq1KL3qZop5D6AublSdfyxzdYfI3LqkHNG5ijUv6
         7p8mchGXJcD2mYo7TcxQvI1Kp4adcHVjRLqlL45XS3wqUfpHvzk2k45ajsyQbK/uVrRT
         grOn+ZlcqaC4Q3WN3dKpiCZQcD7HeF1aA3gwu0yMJyx3iznFq4me0whhnXGfiu0aGite
         VHNSarEAaVzjvJvu2eZJlE7vdjvY5t4B1x9l0YrnV4q/XFkRyygjZbCRX/YIbb6J30un
         OFYvbutlNZ6KIVdySJOUcpeNZDdsMGUNvK9Ayp6J74XmeSLjsra2bdbBtLGbj/pra7N5
         LseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh7sGhttlhZbI7NSh0VENOm0Oc3Ab680O6iIj+Zj98c=;
        b=zj0f9djWSkgpv6YYSQNkDFPHqrtwWpLHbT+isv10PDF2jCQeKvPz5Y/viq2cqjeBY0
         2RKh8MNl40wdCbw5MfOANW+82QBXLRB56/nMVINtalL3RHs6ndqx4ghnGEXpejdpGKx7
         9DYJFUAHZRzdFDqda8HiIZtV+v1x2LmAlXuq/ZpuFSdHlC6FXKqE6gcI6cjPACRCNx8G
         2yWPOl7RDXBNf0IyIWMv15kSkwTytdB5vSwKPJo+qazeHZhwstIPrAhlhF1rqoo7ipdD
         sg6VFYePTWcsrelM12tzc8e3BVOb+KRncZXbAYxARPOGQ0jOX6G4cWcabKYQWTZdbYvb
         GflA==
X-Gm-Message-State: AOAM531cYCVpY/yxkk4J30QeHREbXhXHNmAcz5ciHesgJRkb0z3uyd5a
        MuNO7IiV+teXnma+28ximKihkE8uuVmdVJFX
X-Google-Smtp-Source: ABdhPJw6bNjp20/hoJnCsJVhyj8lFau1bnquWcZa3d9HSPRJlQuZ4TcfJ/desFQXfErh9CaPsBr5Uw==
X-Received: by 2002:a05:6402:2706:: with SMTP id y6mr3660664edd.29.1639759414150;
        Fri, 17 Dec 2021 08:43:34 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f34ba00f711d38e28b691af.dip0.t-ipconnect.de. [2003:cf:9f34:ba00:f711:d38e:28b6:91af])
        by smtp.googlemail.com with ESMTPSA id f22sm3955906edf.93.2021.12.17.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:43:33 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Date:   Fri, 17 Dec 2021 17:43:04 +0100
Message-Id: <20211217164307.1514192-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
References: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides the same data as the asus_wmi_ec_sensors driver
(and gets it from the same source) but does not use WMI, polling
the ACPI EC directly.

That provides two enhancements: sensor reading became quicker (on some
systems or kernel configuration it took almost a full second to read
all the sensors, that transfers less than 15 bytes of data), the driver
became more flexible. The driver now relies on ACPI mutex to lock access
to the EC in the same way as the WMI code does.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 MAINTAINERS                     |   6 +
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/asus-ec-sensors.c | 790 ++++++++++++++++++++++++++++++++
 4 files changed, 808 insertions(+)
 create mode 100644 drivers/hwmon/asus-ec-sensors.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fddd28d3db15..845f09bc0457 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3012,6 +3012,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus_wmi_ec_sensors.c
 
+ASUS EC HARDWARE MONITOR DRIVER
+M:	Eugene Shalygin <eugene.shalygin@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/asus-ec-sensors.c
+
 ASUS WIRELESS RADIO CONTROL DRIVER
 M:	João Paulo Rechi Vita <jprvita@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 43e5245874ad..2c16b19d2c03 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2253,6 +2253,17 @@ config SENSORS_ASUS_WMI_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_wmi_sensors_ec.
 
+config SENSORS_ASUS_EC
+	tristate "ASUS EC Sensors"
+	help
+	  If you say yes here you get support for the ACPI embedded controller
+	  hardware monitoring interface found in ASUS motherboards. The driver
+	  currently supports B550/X570 boards, although other ASUS boards might
+	  provide this monitoring interface as well.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus_ec_sensors.
+
 endif # ACPI
 
 endif # HWMON
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3a1551b3d570..2e5c216bb5d7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 # APCI drivers
 obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
 obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
+obj-$(CONFIG_SENSORS_ASUS_EC)	+= asus-ec-sensors.o
 obj-$(CONFIG_SENSORS_ASUS_WMI)	+= asus_wmi_sensors.o
 obj-$(CONFIG_SENSORS_ASUS_WMI_EC)	+= asus_wmi_ec_sensors.o
 
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
new file mode 100644
index 000000000000..d7e44be00aae
--- /dev/null
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -0,0 +1,790 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for ASUS motherboards that publish some sensor values
+ * via the embedded controller registers.
+ *
+ * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
+
+ * EC provides:
+ * - Chipset temperature
+ * - CPU temperature
+ * - Motherboard temperature
+ * - T_Sensor temperature
+ * - VRM temperature
+ * - Water In temperature
+ * - Water Out temperature
+ * - CPU Optional fan RPM
+ * - Chipset fan RPM
+ * - VRM Heat Sink fan RPM
+ * - Water Flow fan RPM
+ * - CPU current
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/dev_printk.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sort.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+static char *mutex_path_override;
+
+/** Writing to this EC register switches EC bank */
+#define ASUS_EC_BANK_REGISTER 0xff
+#define SENSOR_LABEL_LEN 16
+
+/**
+ * Arbitrary set max. allowed bank number. Required for sorting banks and
+ * currently is overkill with just 2 banks used at max, but for the sake
+ * of alignment let's set it to a higher value.
+ */
+#define ASUS_EC_MAX_BANK 3
+
+#define ACPI_LOCK_DELAY_MS 500
+
+/* ACPI mutex for locking access to the EC for the firmware */
+#define ASUS_HW_ACCESS_MUTEX_ASMX "\\AMW0.ASMX"
+
+/* There are two variants of the vendor spelling */
+#define VENDOR_ASUS_UPPER_CASE "ASUSTeK COMPUTER INC."
+
+typedef union {
+	u32 value;
+	struct {
+		u8 index;
+		u8 bank;
+		u8 size;
+		u8 dummy;
+	} components;
+} sensor_address;
+
+#define MAKE_SENSOR_ADDRESS(size, bank, index) {                               \
+		.value = (size << 16) + (bank << 8) + index                    \
+	}
+
+static u32 hwmon_attributes[hwmon_max] = {
+	[hwmon_chip] = HWMON_C_REGISTER_TZ,
+	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
+	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
+	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
+	[hwmon_fan] = HWMON_F_INPUT | HWMON_F_LABEL,
+};
+
+struct ec_sensor_info {
+	char label[SENSOR_LABEL_LEN];
+	enum hwmon_sensor_types type;
+	sensor_address addr;
+};
+
+#define EC_SENSOR(sensor_label, sensor_type, size, bank, index)	{              \
+		.label = sensor_label, .type = sensor_type,                    \
+		.addr = MAKE_SENSOR_ADDRESS(size, bank, index),                \
+	}
+
+enum ec_sensors {
+	/** chipset temperature [℃] */
+	ec_sensor_temp_chipset,
+	/** CPU temperature [℃] */
+	ec_sensor_temp_cpu,
+	/** motherboard temperature [℃] */
+	ec_sensor_temp_mb,
+	/** "T_Sensor" temperature sensor reading [℃] */
+	ec_sensor_temp_t_sensor,
+	/** VRM temperature [℃] */
+	ec_sensor_temp_vrm,
+	/** CPU_Opt fan [RPM] */
+	ec_sensor_fan_cpu_opt,
+	/** VRM heat sink fan [RPM] */
+	ec_sensor_fan_vrm_hs,
+	/** Chipset fan [RPM] */
+	ec_sensor_fan_chipset,
+	/** Water flow sensor reading [RPM] */
+	ec_sensor_fan_water_flow,
+	/** CPU current [A] */
+	ec_sensor_curr_cpu,
+	/** "Water_In" temperature sensor reading [℃] */
+	ec_sensor_temp_water_in,
+	/** "Water_Out" temperature sensor reading [℃] */
+	ec_sensor_temp_water_out,
+};
+
+#define SENSOR_TEMP_CHIPSET BIT(ec_sensor_temp_chipset)
+#define SENSOR_TEMP_CPU BIT(ec_sensor_temp_cpu)
+#define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
+#define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
+#define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
+#define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
+#define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
+#define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
+#define SENSOR_FAN_WATER_FLOW BIT(ec_sensor_fan_water_flow)
+#define SENSOR_CURR_CPU BIT(ec_sensor_curr_cpu)
+#define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
+#define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
+
+/**
+ * All the known sensors for ASUS EC controllers
+ */
+static const struct ec_sensor_info known_ec_sensors[] = {
+	[ec_sensor_temp_chipset] =
+		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
+	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
+	[ec_sensor_temp_mb] =
+		EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
+	[ec_sensor_fan_vrm_hs] = EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
+	[ec_sensor_fan_chipset] =
+		EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4),
+	[ec_sensor_fan_water_flow] =
+		EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_curr_cpu] = EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
+	[ec_sensor_temp_water_in] =
+		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
+	[ec_sensor_temp_water_out] =
+		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+};
+
+struct asus_ec_board_versioned_mutex_path {
+	/** Minimal applicable BIOS version */
+	int version;
+	const char *value;
+};
+
+struct asus_ec_board_info {
+	unsigned long sensors;
+	struct asus_ec_board_versioned_mutex_path mutex_path[];
+};
+
+/* Shortcuts for common combinations */
+#define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
+	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
+#define SENSOR_SET_TEMP_WATER (SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT)
+
+static struct asus_ec_board_info board_P_X570_P = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		   SENSOR_FAN_CHIPSET,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_PW_X570_A = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		   SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_R_C8H = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		   SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+		   SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+/* Same as Hero but without chipset fan */
+static struct asus_ec_board_info board_R_C8DH = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		   SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+/* Same as Hero but without water */
+static struct asus_ec_board_info board_R_C8F = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+		   SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_R_C8I = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_RS_B550_E_G = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_RS_B550_I_G = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_RS_X570_E_G = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		   SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+static struct asus_ec_board_info board_RS_X570_I_G = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
+		   SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU,
+	.mutex_path = { { 0, ASUS_HW_ACCESS_MUTEX_ASMX }, {} }
+};
+
+#define DMI_EXACT_MATCH_BOARD(vendor, name, sensors) {                         \
+	.matches = {                                                           \
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, vendor),                     \
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),                         \
+	},                                                                     \
+	.driver_data = sensors, \
+}
+
+static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "PRIME X570-PRO",
+			      &board_P_X570_P),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
+			      &board_PW_X570_A),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
+			      "ROG CROSSHAIR VIII DARK HERO", &board_R_C8DH),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
+			      "ROG CROSSHAIR VIII FORMULA", &board_R_C8F),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
+			      &board_R_C8H),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
+			      "ROG CROSSHAIR VIII IMPACT", &board_R_C8I),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
+			      &board_RS_B550_E_G),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
+			      &board_RS_B550_I_G),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
+			      &board_RS_X570_E_G),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
+			      &board_RS_X570_I_G),
+	{}
+};
+
+struct ec_sensor {
+	unsigned int info_index;
+	u32 cached_value;
+};
+
+struct ec_sensors_data {
+	const struct asus_ec_board_info *board;
+	struct ec_sensor *sensors;
+	/** EC registers to read from */
+	u16 *registers;
+	u8 *read_buffer;
+	/** sorted list of unique register banks */
+	u8 banks[ASUS_EC_MAX_BANK + 1];
+	/** in jiffies */
+	unsigned long last_updated;
+	acpi_handle aml_mutex;
+	/** number of board EC sensors */
+	u8 nr_sensors;
+	/** number of EC registers to read (sensor might span more than 1 register) */
+	u8 nr_registers;
+	/** number of unique register banks */
+	u8 nr_banks;
+};
+
+static u8 register_bank(u16 reg)
+{
+	return reg >> 8;
+}
+
+static u8 register_index(u16 reg)
+{
+	return reg & 0x00ff;
+}
+
+static const struct ec_sensor_info *
+get_sensor_info(const struct ec_sensors_data *state, int index)
+{
+	return &known_ec_sensors[state->sensors[index].info_index];
+}
+
+static int find_ec_sensor_index(const struct ec_sensors_data *ec,
+				enum hwmon_sensor_types type, int channel)
+{
+	unsigned int i;
+
+	for (i = 0; i < ec->nr_sensors; i++) {
+		if (get_sensor_info(ec, i)->type == type) {
+			if (channel == 0)
+				return i;
+			channel--;
+		}
+	}
+	return -ENOENT;
+}
+
+static int __init bank_compare(const void *a, const void *b)
+{
+	return *((const s8 *)a) - *((const s8 *)b);
+}
+
+static int __init board_sensors_count(const struct asus_ec_board_info *board)
+{
+	return hweight_long(board->sensors);
+}
+
+static void __init setup_sensor_data(struct ec_sensors_data *ec)
+{
+	struct ec_sensor *s = ec->sensors;
+	bool bank_found;
+	int i, j;
+	u8 bank;
+
+	ec->nr_banks = 0;
+	ec->nr_registers = 0;
+
+	for_each_set_bit(i, &ec->board->sensors,
+			  BITS_PER_TYPE(ec->board->sensors)) {
+		s->info_index = i;
+		s->cached_value = 0;
+		ec->nr_registers +=
+			known_ec_sensors[s->info_index].addr.components.size;
+		bank_found = false;
+		bank = known_ec_sensors[s->info_index].addr.components.bank;
+		for (j = 0; j < ec->nr_banks; j++) {
+			if (ec->banks[j] == bank) {
+				bank_found = true;
+				break;
+			}
+		}
+		if (!bank_found) {
+			ec->banks[ec->nr_banks++] = bank;
+		}
+		s++;
+	}
+	sort(ec->banks, ec->nr_banks, 1, bank_compare, NULL);
+}
+
+static void __init fill_ec_registers(struct ec_sensors_data *ec)
+{
+	const struct ec_sensor_info *si;
+	unsigned int i, j, register_idx = 0;
+
+	for (i = 0; i < ec->nr_sensors; ++i) {
+		si = get_sensor_info(ec, i);
+		for (j = 0; j < si->addr.components.size; ++j, ++register_idx) {
+			ec->registers[register_idx] =
+				(si->addr.components.bank << 8) +
+				si->addr.components.index + j;
+		}
+	}
+}
+
+static int get_bios_version(int *version)
+{
+	return kstrtoint(dmi_get_system_info(DMI_BIOS_VERSION), 10, version);
+}
+
+static int mutex_versions_count(
+	const struct asus_ec_board_versioned_mutex_path *mutex_info)
+{
+	int res;
+
+	for (res = 0; mutex_info[res].value; res++) {
+	}
+	return res;
+}
+
+static acpi_handle asus_hw_access_mutex(struct device *dev)
+{
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
+	int versions_count = mutex_versions_count(state->board->mutex_path);
+	int bios_version, status, i;
+	const char *mutex_path;
+	acpi_handle res;
+
+	if (mutex_path_override) {
+		mutex_path = mutex_path_override;
+	} else if (versions_count == 1) {
+		/*
+		 * We do not check bios version in this case, maybe it's
+		 * even broken or in a format we can't parse.
+		 */
+		mutex_path = state->board->mutex_path[0].value;
+	} else {
+		status = get_bios_version(&bios_version);
+		if (status) {
+			dev_err(dev, "Could not get BIOS version: error %d",
+				status);
+			return NULL;
+		}
+		/*
+		 * otherwise we choose the first version which is less or equal to
+		 * the BIOS version
+		 */
+		for (i = versions_count - 1; i > 0; i--) {
+			if (state->board->mutex_path[i].version <= bios_version)
+				break;
+		}
+		mutex_path = state->board->mutex_path[i].value;
+	}
+
+	status = acpi_get_handle(NULL, (acpi_string)mutex_path, &res);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev,
+			"Could not get hardware access guard mutex '%s': error %d",
+			mutex_path, status);
+		return NULL;
+	}
+	return res;
+}
+
+static int asus_ec_bank_switch(u8 bank, u8 *old)
+{
+	int status = 0;
+
+	if (old) {
+		status = ec_read(ASUS_EC_BANK_REGISTER, old);
+	}
+	if (status || (old && (*old == bank)))
+		return status;
+	return ec_write(ASUS_EC_BANK_REGISTER, bank);
+}
+
+static int asus_ec_block_read(const struct device *dev,
+			      struct ec_sensors_data *ec)
+{
+	int ireg, ibank, status;
+	u8 bank, reg_bank, prev_bank;
+
+	bank = 0;
+	status = asus_ec_bank_switch(bank, &prev_bank);
+	if (status) {
+		dev_warn(dev, "EC bank switch failed");
+		return status;
+	}
+
+	if (prev_bank) {
+		/* oops... somebody else is working with the EC too */
+		dev_warn(dev,
+			"Concurrent access to the ACPI EC detected.\nRace condition possible.");
+	}
+
+	/*
+	 * read registers minimizing bank switches.
+	 */
+	for (ibank = 0; ibank < ec->nr_banks; ibank++) {
+		if (bank != ec->banks[ibank]) {
+			bank = ec->banks[ibank];
+			if (asus_ec_bank_switch(bank, NULL)) {
+				dev_warn(dev, "EC bank switch to %d failed",
+					 bank);
+				break;
+			}
+		}
+		for (ireg = 0; ireg < ec->nr_registers; ireg++) {
+			reg_bank = register_bank(ec->registers[ireg]);
+			if (reg_bank < bank) {
+				continue;
+			}
+			ec_read(register_index(ec->registers[ireg]),
+				ec->read_buffer + ireg);
+		}
+	}
+
+	status = asus_ec_bank_switch(prev_bank, NULL);
+	return status;
+}
+
+static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
+{
+	switch (si->addr.components.size) {
+	case 1:
+		return *data;
+	case 2:
+		return get_unaligned_be16(data);
+	case 4:
+		return get_unaligned_be32(data);
+	default:
+		return 0;
+	}
+}
+
+static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
+{
+	const struct ec_sensor_info *si;
+	struct ec_sensor *s;
+
+	for (s = ec->sensors; s != ec->sensors + ec->nr_sensors; s++) {
+		si = &known_ec_sensors[s->info_index];
+		s->cached_value = get_sensor_value(si, data);
+		data += si->addr.components.size;
+	}
+}
+
+static int update_ec_sensors(const struct device *dev,
+			     struct ec_sensors_data *ec)
+{
+	int status;
+
+	/*
+	 * ASUS DSDT does not specify that access to the EC has to be guarded,
+	 * but firmware does access it via ACPI
+	 */
+	if (ACPI_FAILURE(acpi_acquire_mutex(ec->aml_mutex, NULL,
+					    ACPI_LOCK_DELAY_MS))) {
+		dev_err(dev, "Failed to acquire AML mutex");
+		status = -EBUSY;
+		goto cleanup;
+	}
+
+	status = asus_ec_block_read(dev, ec);
+
+	if (!status) {
+		update_sensor_values(ec, ec->read_buffer);
+	}
+	if (ACPI_FAILURE(acpi_release_mutex(ec->aml_mutex, NULL))) {
+		dev_err(dev, "Failed to release AML mutex");
+	}
+cleanup:
+	return status;
+}
+
+static int scale_sensor_value(u32 value, int data_type)
+{
+	switch (data_type) {
+	case hwmon_curr:
+	case hwmon_temp:
+	case hwmon_in:
+		return value * MILLI;
+	default:
+		return value;
+	}
+}
+
+static int get_cached_value_or_update(const struct device *dev,
+				      int sensor_index,
+				      struct ec_sensors_data *state, u32 *value)
+{
+	if (time_after(jiffies, state->last_updated + HZ)) {
+		if (update_ec_sensors(dev, state)) {
+			dev_err(dev, "update_ec_sensors() failure\n");
+			return -EIO;
+		}
+
+		state->last_updated = jiffies;
+	}
+
+	*value = state->sensors[sensor_index].cached_value;
+	return 0;
+}
+
+/*
+ * Now follow the functions that implement the hwmon interface
+ */
+
+static int asus_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	int ret;
+	u32 value = 0;
+
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
+	int sidx = find_ec_sensor_index(state, type, channel);
+
+	if (sidx < 0) {
+		return sidx;
+	}
+
+	ret = get_cached_value_or_update(dev, sidx, state, &value);
+	if (!ret) {
+		*val = scale_sensor_value(value,
+					  get_sensor_info(state, sidx)->type);
+	}
+
+	return ret;
+}
+
+static int asus_ec_hwmon_read_string(struct device *dev,
+				     enum hwmon_sensor_types type, u32 attr,
+				     int channel, const char **str)
+{
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
+	int sensor_index = find_ec_sensor_index(state, type, channel);
+	*str = get_sensor_info(state, sensor_index)->label;
+
+	return 0;
+}
+
+static umode_t asus_ec_hwmon_is_visible(const void *drvdata,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel)
+{
+	const struct ec_sensors_data *state = drvdata;
+
+	return find_ec_sensor_index(state, type, channel) >= 0 ? S_IRUGO : 0;
+}
+
+static int
+asus_ec_hwmon_add_chan_info(struct hwmon_channel_info *asus_ec_hwmon_chan,
+			     struct device *dev, int num,
+			     enum hwmon_sensor_types type, u32 config)
+{
+	int i;
+	u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg)
+		return -ENOMEM;
+
+	asus_ec_hwmon_chan->type = type;
+	asus_ec_hwmon_chan->config = cfg;
+	for (i = 0; i < num; i++, cfg++)
+		*cfg = config;
+
+	return 0;
+}
+
+static const struct hwmon_ops asus_ec_hwmon_ops = {
+	.is_visible = asus_ec_hwmon_is_visible,
+	.read = asus_ec_hwmon_read,
+	.read_string = asus_ec_hwmon_read_string,
+};
+
+static struct hwmon_chip_info asus_ec_chip_info = {
+	.ops = &asus_ec_hwmon_ops,
+};
+
+static const struct asus_ec_board_info *__init
+get_board_info(const struct device *dev)
+{
+	const struct dmi_system_id *dmi_entry;
+
+	dmi_entry = dmi_first_match(asus_ec_dmi_table);
+	if (!dmi_entry) {
+		dev_info(dev, "Unsupported board");
+		return NULL;
+	}
+
+	return dmi_entry->driver_data;
+}
+
+static int __init configure_sensor_setup(struct device *dev)
+{
+	struct ec_sensors_data *ec_data = dev_get_drvdata(dev);
+	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
+	struct device *hwdev;
+	struct hwmon_channel_info *asus_ec_hwmon_chan;
+	const struct hwmon_channel_info **ptr_asus_ec_ci;
+	const struct hwmon_chip_info *chip_info;
+	const struct ec_sensor_info *si;
+	enum hwmon_sensor_types type;
+	unsigned int i;
+
+	ec_data->board = get_board_info(dev);
+	if (!ec_data->board) {
+		return -ENODEV;
+	}
+
+	ec_data->nr_sensors = board_sensors_count(ec_data->board);
+	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
+					sizeof(struct ec_sensor), GFP_KERNEL);
+
+	setup_sensor_data(ec_data);
+	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
+					  sizeof(u16), GFP_KERNEL);
+	ec_data->read_buffer = devm_kcalloc(dev, ec_data->nr_registers,
+					    sizeof(u8), GFP_KERNEL);
+
+	if (!ec_data->registers || !ec_data->read_buffer) {
+		return -ENOMEM;
+	}
+
+	fill_ec_registers(ec_data);
+
+	ec_data->aml_mutex = asus_hw_access_mutex(dev);
+
+	for (i = 0; i < ec_data->nr_sensors; ++i) {
+		si = get_sensor_info(ec_data, i);
+		if (!nr_count[si->type])
+			++nr_types;
+		++nr_count[si->type];
+	}
+
+	if (nr_count[hwmon_temp])
+		nr_count[hwmon_chip]++, nr_types++;
+
+	asus_ec_hwmon_chan = devm_kcalloc(
+		dev, nr_types, sizeof(*asus_ec_hwmon_chan), GFP_KERNEL);
+	if (!asus_ec_hwmon_chan)
+		return -ENOMEM;
+
+	ptr_asus_ec_ci = devm_kcalloc(dev, nr_types + 1,
+				       sizeof(*ptr_asus_ec_ci), GFP_KERNEL);
+	if (!ptr_asus_ec_ci)
+		return -ENOMEM;
+
+	asus_ec_chip_info.info = ptr_asus_ec_ci;
+	chip_info = &asus_ec_chip_info;
+
+	for (type = 0; type < hwmon_max; ++type) {
+		if (!nr_count[type])
+			continue;
+
+		asus_ec_hwmon_add_chan_info(asus_ec_hwmon_chan, dev,
+					     nr_count[type], type,
+					     hwmon_attributes[type]);
+		*ptr_asus_ec_ci++ = asus_ec_hwmon_chan++;
+	}
+
+	dev_info(dev, "board has %d EC sensors that span %d registers",
+		 ec_data->nr_sensors, ec_data->nr_registers);
+
+	hwdev = devm_hwmon_device_register_with_info(dev, "asus-ec-sensors",
+						     ec_data, chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwdev);
+}
+
+static int __init asus_ec_probe(struct platform_device *pdev)
+{
+	struct asus_ec_sensors *state;
+	int status = 0;
+
+	state = devm_kzalloc(&pdev->dev, sizeof(struct ec_sensors_data),
+			     GFP_KERNEL);
+
+	if (!state) {
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&pdev->dev, state);
+	status = configure_sensor_setup(&pdev->dev);
+	return status;
+}
+
+static const struct acpi_device_id acpi_ec_ids[] = {
+	/* Embedded Controller Device */
+	{ "PNP0C09", 0 },
+	{}
+};
+
+static struct platform_driver asus_ec_sensors_platform_driver = {
+	.driver = {
+		.name	= "asus-ec-sensors",
+		.acpi_match_table = acpi_ec_ids,
+	},
+};
+
+MODULE_DEVICE_TABLE(dmi, asus_ec_dmi_table);
+module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);
+
+module_param_named(mutex_path, mutex_path_override, charp, 0);
+MODULE_PARM_DESC(mutex_path,
+		 "Override ACPI mutex path used to guard access to hardware");
+
+MODULE_AUTHOR("Eugene Shalygin <eugene.shalygin@gmail.com>");
+MODULE_DESCRIPTION(
+	"HWMON driver for sensors accessible via EC in ASUS motherboards");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
-- 
2.34.1

