Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04484745F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhLNPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhLNPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E7C1B81A01
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F2EC34606
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494360;
        bh=h+sqXqE5tXQUARIGvQFMQgFAGo0Db81e4pl0fToZM+c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=taUlTmYiBBWVLXqOApPtaGZKa+aITDPAoU1NYGKp3uzmQBXP9mrvUyWJWMe+07LeN
         no2qgNyNsFe/jXv106lWI/tBHhZNRO+kErG7jhXat7HdzlykbwItW4jA0EaqV8JTSK
         Ks56um3Zlw3DJ9sa36tSFa0IguwJdr/sZavCCLxiAjn3Kq69hZSMv2oe1I+V7+dFf5
         gppXekPNYPQJlf4n+UBTe1CJg7KD9Q0MThG3THIP5/Nt07KerxWyX0vz0OK4uU4ZVy
         ltmj6pOpLSv7tqvMlQwPQ8+xQHY/KncnolhfQt8R9WJQ13MbyPDSqkaG2447hSwreR
         WfvAtT9/kaYhQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] habanalabs: fix hwmon handling for legacy f/w
Date:   Tue, 14 Dec 2021 17:05:44 +0200
Message-Id: <20211214150551.1568192-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In legacy f/w that use old hwmon.h file, the values of the hwmon
enums are different than the values that are in newer kernels (5.6
and above).

Therefore, to support working with those f/w, we need to do some
fixup before registering with the hwmon subsystem and also when
calling the functions that communicate with the f/w to retrieve
sensors information.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hwmon.c | 201 +++++++++++++++++++++----
 1 file changed, 169 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 70182b42940d..57f5d2c48330 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -10,17 +10,148 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
-#define HWMON_NR_SENSOR_TYPES		(hwmon_pwm + 1)
+#define HWMON_NR_SENSOR_TYPES		(hwmon_max)
 
-int hl_build_hwmon_channel_info(struct hl_device *hdev,
-				struct cpucp_sensor *sensors_arr)
+#ifdef _HAS_HWMON_HWMON_T_ENABLE
+
+static u32 fixup_flags_legacy_fw(struct hl_device *hdev, enum hwmon_sensor_types type,
+					u32 cpucp_flags)
 {
-	u32 counts[HWMON_NR_SENSOR_TYPES] = {0};
-	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {NULL};
+	u32 flags;
+
+	switch (type) {
+	case hwmon_temp:
+		flags = (cpucp_flags << 1) | HWMON_T_ENABLE;
+		break;
+
+	case hwmon_in:
+		flags = (cpucp_flags << 1) | HWMON_I_ENABLE;
+		break;
+
+	case hwmon_curr:
+		flags = (cpucp_flags << 1) | HWMON_C_ENABLE;
+		break;
+
+	case hwmon_fan:
+		flags = (cpucp_flags << 1) | HWMON_F_ENABLE;
+		break;
+
+	case hwmon_power:
+		flags = (cpucp_flags << 1) | HWMON_P_ENABLE;
+		break;
+
+	case hwmon_pwm:
+		/* enable bit was here from day 1, so no need to adjust */
+		flags = cpucp_flags;
+		break;
+
+	default:
+		dev_err(hdev->dev, "unsupported h/w sensor type %d\n", type);
+		flags = cpucp_flags;
+		break;
+	}
+
+	return flags;
+}
+
+static u32 fixup_attr_legacy_fw(u32 attr)
+{
+	return (attr - 1);
+}
+
+#else
+
+static u32 fixup_flags_legacy_fw(struct hl_device *hdev, enum hwmon_sensor_types type,
+						u32 cpucp_flags)
+{
+	return cpucp_flags;
+}
+
+static u32 fixup_attr_legacy_fw(u32 attr)
+{
+	return attr;
+}
+
+#endif /* !_HAS_HWMON_HWMON_T_ENABLE */
+
+static u32 adjust_hwmon_flags(struct hl_device *hdev, enum hwmon_sensor_types type, u32 cpucp_flags)
+{
+	u32 flags, cpucp_input_val;
+	bool use_cpucp_enum;
+
+	use_cpucp_enum = (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_MAP_HWMON_EN) ? true : false;
+
+	/* If f/w is using it's own enum, we need to check if the properties values are aligned.
+	 * If not, it means we need to adjust the values to the new format that is used in the
+	 * kernel since 5.6 (enum values were incremented by 1 by adding a new enable value).
+	 */
+	if (use_cpucp_enum) {
+		switch (type) {
+		case hwmon_temp:
+			cpucp_input_val = cpucp_temp_input;
+			if (cpucp_input_val == hwmon_temp_input)
+				flags = cpucp_flags;
+			else
+				flags = (cpucp_flags << 1) | HWMON_T_ENABLE;
+			break;
+
+		case hwmon_in:
+			cpucp_input_val = cpucp_in_input;
+			if (cpucp_input_val == hwmon_in_input)
+				flags = cpucp_flags;
+			else
+				flags = (cpucp_flags << 1) | HWMON_I_ENABLE;
+			break;
+
+		case hwmon_curr:
+			cpucp_input_val = cpucp_curr_input;
+			if (cpucp_input_val == hwmon_curr_input)
+				flags = cpucp_flags;
+			else
+				flags = (cpucp_flags << 1) | HWMON_C_ENABLE;
+			break;
+
+		case hwmon_fan:
+			cpucp_input_val = cpucp_fan_input;
+			if (cpucp_input_val == hwmon_fan_input)
+				flags = cpucp_flags;
+			else
+				flags = (cpucp_flags << 1) | HWMON_F_ENABLE;
+			break;
+
+		case hwmon_pwm:
+			/* enable bit was here from day 1, so no need to adjust */
+			flags = cpucp_flags;
+			break;
+
+		case hwmon_power:
+			cpucp_input_val = CPUCP_POWER_INPUT;
+			if (cpucp_input_val == hwmon_power_input)
+				flags = cpucp_flags;
+			else
+				flags = (cpucp_flags << 1) | HWMON_P_ENABLE;
+			break;
+
+		default:
+			dev_err(hdev->dev, "unsupported h/w sensor type %d\n", type);
+			flags = cpucp_flags;
+			break;
+		}
+	} else {
+		flags = fixup_flags_legacy_fw(hdev, type, cpucp_flags);
+	}
+
+	return flags;
+}
+
+int hl_build_hwmon_channel_info(struct hl_device *hdev, struct cpucp_sensor *sensors_arr)
+{
+	u32 num_sensors_for_type, flags, num_active_sensor_types = 0, arr_size = 0, *curr_arr;
 	u32 sensors_by_type_next_index[HWMON_NR_SENSOR_TYPES] = {0};
+	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {NULL};
 	struct hwmon_channel_info **channels_info;
-	u32 num_sensors_for_type, num_active_sensor_types = 0,
-			arr_size = 0, *curr_arr;
+	u32 counts[HWMON_NR_SENSOR_TYPES] = {0};
 	enum hwmon_sensor_types type;
 	int rc, i, j;
 
@@ -31,8 +162,7 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 			break;
 
 		if (type >= HWMON_NR_SENSOR_TYPES) {
-			dev_err(hdev->dev,
-				"Got wrong sensor type %d from device\n", type);
+			dev_err(hdev->dev, "Got wrong sensor type %d from device\n", type);
 			return -EINVAL;
 		}
 
@@ -45,8 +175,9 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 			continue;
 
 		num_sensors_for_type = counts[i] + 1;
-		curr_arr = kcalloc(num_sensors_for_type, sizeof(*curr_arr),
-				GFP_KERNEL);
+		dev_dbg(hdev->dev, "num_sensors_for_type %d = %d\n", i, num_sensors_for_type);
+
+		curr_arr = kcalloc(num_sensors_for_type, sizeof(*curr_arr), GFP_KERNEL);
 		if (!curr_arr) {
 			rc = -ENOMEM;
 			goto sensors_type_err;
@@ -59,20 +190,18 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	for (i = 0 ; i < arr_size ; i++) {
 		type = le32_to_cpu(sensors_arr[i].type);
 		curr_arr = sensors_by_type[type];
-		curr_arr[sensors_by_type_next_index[type]++] =
-				le32_to_cpu(sensors_arr[i].flags);
+		flags = adjust_hwmon_flags(hdev, type, le32_to_cpu(sensors_arr[i].flags));
+		curr_arr[sensors_by_type_next_index[type]++] = flags;
 	}
 
-	channels_info = kcalloc(num_active_sensor_types + 1,
-			sizeof(*channels_info), GFP_KERNEL);
+	channels_info = kcalloc(num_active_sensor_types + 1, sizeof(*channels_info), GFP_KERNEL);
 	if (!channels_info) {
 		rc = -ENOMEM;
 		goto channels_info_array_err;
 	}
 
 	for (i = 0 ; i < num_active_sensor_types ; i++) {
-		channels_info[i] = kzalloc(sizeof(*channels_info[i]),
-				GFP_KERNEL);
+		channels_info[i] = kzalloc(sizeof(*channels_info[i]), GFP_KERNEL);
 		if (!channels_info[i]) {
 			rc = -ENOMEM;
 			goto channel_info_err;
@@ -88,18 +217,19 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 		j++;
 	}
 
-	hdev->hl_chip_info->info =
-			(const struct hwmon_channel_info **)channels_info;
+	hdev->hl_chip_info->info = (const struct hwmon_channel_info **)channels_info;
 
 	return 0;
 
 channel_info_err:
-	for (i = 0 ; i < num_active_sensor_types ; i++)
+	for (i = 0 ; i < num_active_sensor_types ; i++) {
 		if (channels_info[i]) {
 			kfree(channels_info[i]->config);
 			kfree(channels_info[i]);
 		}
+	}
 	kfree(channels_info);
+
 channels_info_array_err:
 sensors_type_err:
 	for (i = 0 ; i < HWMON_NR_SENSOR_TYPES ; i++)
@@ -112,14 +242,16 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
-	int rc;
+	bool use_cpucp_enum;
 	u32 cpucp_attr;
-	bool use_cpucp_enum = (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
-				CPU_BOOT_DEV_STS0_MAP_HWMON_EN) ? true : false;
+	int rc;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
+	use_cpucp_enum = (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_MAP_HWMON_EN) ? true : false;
+
 	switch (type) {
 	case hwmon_temp:
 		switch (attr) {
@@ -151,7 +283,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_temperature(hdev, channel, cpucp_attr, val);
 		else
-			rc = hl_get_temperature(hdev, channel, attr, val);
+			rc = hl_get_temperature(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_in:
 		switch (attr) {
@@ -174,7 +306,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_voltage(hdev, channel, cpucp_attr, val);
 		else
-			rc = hl_get_voltage(hdev, channel, attr, val);
+			rc = hl_get_voltage(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_curr:
 		switch (attr) {
@@ -197,7 +329,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_current(hdev, channel, cpucp_attr, val);
 		else
-			rc = hl_get_current(hdev, channel, attr, val);
+			rc = hl_get_current(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_fan:
 		switch (attr) {
@@ -217,7 +349,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_fan_speed(hdev, channel, cpucp_attr, val);
 		else
-			rc = hl_get_fan_speed(hdev, channel, attr, val);
+			rc = hl_get_fan_speed(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_pwm:
 		switch (attr) {
@@ -234,6 +366,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_pwm_info(hdev, channel, cpucp_attr, val);
 		else
+			/* no need for fixup as pwm was aligned from day 1 */
 			rc = hl_get_pwm_info(hdev, channel, attr, val);
 		break;
 	case hwmon_power:
@@ -251,7 +384,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			rc = hl_get_power(hdev, channel, cpucp_attr, val);
 		else
-			rc = hl_get_power(hdev, channel, attr, val);
+			rc = hl_get_power(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	default:
 		return -EINVAL;
@@ -286,7 +419,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			hl_set_temperature(hdev, channel, cpucp_attr, val);
 		else
-			hl_set_temperature(hdev, channel, attr, val);
+			hl_set_temperature(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_pwm:
 		switch (attr) {
@@ -303,6 +436,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			hl_set_pwm_info(hdev, channel, cpucp_attr, val);
 		else
+			/* no need for fixup as pwm was aligned from day 1 */
 			hl_set_pwm_info(hdev, channel, attr, val);
 		break;
 	case hwmon_in:
@@ -317,7 +451,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			hl_set_voltage(hdev, channel, cpucp_attr, val);
 		else
-			hl_set_voltage(hdev, channel, attr, val);
+			hl_set_voltage(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_curr:
 		switch (attr) {
@@ -331,7 +465,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			hl_set_current(hdev, channel, cpucp_attr, val);
 		else
-			hl_set_current(hdev, channel, attr, val);
+			hl_set_current(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	case hwmon_power:
 		switch (attr) {
@@ -345,7 +479,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		if (use_cpucp_enum)
 			hl_set_power(hdev, channel, cpucp_attr, val);
 		else
-			hl_set_power(hdev, channel, attr, val);
+			hl_set_power(hdev, channel, fixup_attr_legacy_fw(attr), val);
 		break;
 	default:
 		return -EINVAL;
@@ -444,6 +578,9 @@ int hl_get_temperature(struct hl_device *hdev,
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
+	dev_dbg(hdev->dev, "get temp, ctl 0x%x, sensor %d, type %d\n",
+		pkt.ctl, pkt.sensor_index, pkt.type);
+
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						0, &result);
 
-- 
2.25.1

