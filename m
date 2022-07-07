Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE056A145
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiGGLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiGGLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:51:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA47A33374;
        Thu,  7 Jul 2022 04:51:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x10so15457820edd.13;
        Thu, 07 Jul 2022 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bU2zQFkRZ2FwrZP004tARnOTDvaLoDCbqwtC2I5choc=;
        b=ksYDnSxq3vF7KQVz5MUwjcHhPCMNLafbeghfsXnXwa+R0DX8lTEEcnMig03NcFgpEI
         uEZpbrbDy5Duf5xwAFcMahDlDHCHjWkhCZcC3iFMDrl8yVPJBd795y1oS+DzmKjtiEtT
         0+lOBSp6AdblkctJsjQszrNF7lHK/HUeswvn4LBh3VfBHrzLQ6a3bN3LB7XOBvQyLJHJ
         4lwVWFcT0iYNwrx24Y9lz5i9dQN312lz/Tj9K9Fh5vBxX21ntf9pTczJDrpDF3FEUbrQ
         7sHVL+8rNtxwMJd36MirWoVrnvQjqjSUV4VZt3cpGHifMpK+WZILEVOs1SyldIOgmPFz
         G9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bU2zQFkRZ2FwrZP004tARnOTDvaLoDCbqwtC2I5choc=;
        b=Niv5OPeSWtmYlYuf99Ka60ehiZAAynX8AsF2zTWyTt9Vg2bBDIsuILRmZcODa6PU0Q
         AgfklaDsVDkyikyADKdFCC5vzqAWylgHnwRfMGdaK1gw0HgmiQidftNkOmKi/cl88e31
         R5/OE3tp+WYvhraFmxQPUJse1+B0KbBfh1euouwY94qpRzA7+AE5OeQsCV3exHiB3abc
         euFsL63928zZCk2LTiee/Vh0FuFLVFcLTv2E3sLSvm2xWwPL4K48HDH79HVs8LXyfBYS
         ivwy3k/y52t3ozYq1wu8lKCQhaat9QpL0REu9BmUo6/0aQGf97gB1wVCS1t0c1FsNyD6
         DgFQ==
X-Gm-Message-State: AJIora+mzfIkF7DeZUpjzZNIepBamdLZox4NTXlnUDHY7VyJQIT14rHL
        mVQYBWOV1uywKwH3+txz9cfZ6cxuxdc=
X-Google-Smtp-Source: AGRyM1s+vH02J06SN5ts752+F8Luu9WDi3vVXKIckVEulxgjHabPx1mdD/bPuzetpkyoL08xF/RPjg==
X-Received: by 2002:aa7:d60a:0:b0:43a:5795:b729 with SMTP id c10-20020aa7d60a000000b0043a5795b729mr28750559edr.230.1657194667922;
        Thu, 07 Jul 2022 04:51:07 -0700 (PDT)
Received: from DESKTOP-A98GP49.. (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm18759227ejk.153.2022.07.07.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:51:07 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) Move device-specific data into struct aqc_data
Date:   Thu,  7 Jul 2022 13:50:50 +0200
Message-Id: <20220707115050.90021-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for adding support for more devices in upcoming patches,
move device-specific data, such as number of fans, temperature sensors,
register offsets etc. to struct aqc_data. This is made possible by
the fact that the supported Aquacomputer devices share the same layouts
of sensor substructures. This allows aqc_raw_event() and others to stay
general and not be cluttered with similar loops for each device.

Signed-off-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Moved constants back to defines
- Converted register offsets to hex
---
 drivers/hwmon/aquacomputer_d5next.c | 244 +++++++++++-----------------
 1 file changed, 92 insertions(+), 152 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a0e69f7ece36..0e56cc711a26 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -54,56 +54,40 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
-/* Register offsets for the D5 Next pump */
-#define D5NEXT_POWER_CYCLES		24
-
-#define D5NEXT_COOLANT_TEMP		87
-
-#define D5NEXT_PUMP_SPEED		116
-#define D5NEXT_FAN_SPEED		103
-
-#define D5NEXT_PUMP_POWER		114
-#define D5NEXT_FAN_POWER		101
-
-#define D5NEXT_PUMP_VOLTAGE		110
-#define D5NEXT_FAN_VOLTAGE		97
-#define D5NEXT_5V_VOLTAGE		57
+/* Register offsets for all Aquacomputer devices */
+#define AQC_TEMP_SENSOR_SIZE		0x02
+#define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
+#define AQC_FAN_PERCENT_OFFSET		0x00
+#define AQC_FAN_VOLTAGE_OFFSET		0x02
+#define AQC_FAN_CURRENT_OFFSET		0x04
+#define AQC_FAN_POWER_OFFSET		0x06
+#define AQC_FAN_SPEED_OFFSET		0x08
 
-#define D5NEXT_PUMP_CURRENT		112
-#define D5NEXT_FAN_CURRENT		99
+/* Register offsets for the D5 Next pump */
+#define D5NEXT_POWER_CYCLES		0x18
+#define D5NEXT_COOLANT_TEMP		0x57
+#define D5NEXT_NUM_FANS			2
+#define D5NEXT_NUM_SENSORS		1
+#define D5NEXT_PUMP_OFFSET		0x6c
+#define D5NEXT_FAN_OFFSET		0x5f
+#define D5NEXT_5V_VOLTAGE		0x39
+static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
 /* Register offsets for the Farbwerk RGB controller */
 #define FARBWERK_NUM_SENSORS		4
 #define FARBWERK_SENSOR_START		0x2f
-#define FARBWERK_SENSOR_SIZE		0x02
-#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
 
 /* Register offsets for the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS		4
 #define FARBWERK360_SENSOR_START	0x32
-#define FARBWERK360_SENSOR_SIZE		0x02
-#define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
 
 /* Register offsets for the Octo fan controller */
 #define OCTO_POWER_CYCLES		0x18
 #define OCTO_NUM_FANS			8
-#define OCTO_FAN_PERCENT_OFFSET		0x00
-#define OCTO_FAN_VOLTAGE_OFFSET		0x02
-#define OCTO_FAN_CURRENT_OFFSET		0x04
-#define OCTO_FAN_POWER_OFFSET		0x06
-#define OCTO_FAN_SPEED_OFFSET		0x08
-
-static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
-
 #define OCTO_NUM_SENSORS		4
 #define OCTO_SENSOR_START		0x3D
-#define OCTO_SENSOR_SIZE		0x02
-#define OCTO_SENSOR_DISCONNECTED	0x7FFF
-
-#define OCTO_CTRL_REPORT_SIZE			0x65F
-#define OCTO_CTRL_REPORT_CHECKSUM_OFFSET	0x65D
-#define OCTO_CTRL_REPORT_CHECKSUM_START		0x01
-#define OCTO_CTRL_REPORT_CHECKSUM_LENGTH	0x65C
+#define OCTO_CTRL_REPORT_SIZE		0x65F
+static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Fan speed registers in Octo control report (from 0-100%) */
 static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
@@ -201,11 +185,18 @@ struct aqc_data {
 	int checksum_length;
 	int checksum_offset;
 
+	int num_fans;
+	u8 *fan_sensor_offsets;
+	u16 *fan_ctrl_offsets;
+	int num_temp_sensors;
+	int temp_sensor_start_offset;
+	u16 power_cycle_count_offset;
+
 	/* General info, same across all devices */
 	u32 serial_number[2];
 	u16 firmware_version;
 
-	/* How many times the device was powered on */
+	/* How many times the device was powered on, if available */
 	u32 power_cycles;
 
 	/* Sensor values */
@@ -323,56 +314,35 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 
 	switch (type) {
 	case hwmon_temp:
-		switch (priv->kind) {
-		case d5next:
-			if (channel == 0)
-				return 0444;
-			break;
-		case farbwerk:
-		case farbwerk360:
-		case octo:
+		if (channel < priv->num_temp_sensors)
 			return 0444;
-		default:
-			break;
-		}
 		break;
 	case hwmon_pwm:
-		switch (priv->kind) {
-		case octo:
+		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
 			switch (attr) {
 			case hwmon_pwm_input:
 				return 0644;
 			default:
 				break;
 			}
-			break;
-		default:
-			break;
 		}
 		break;
 	case hwmon_fan:
 	case hwmon_power:
 	case hwmon_curr:
-		switch (priv->kind) {
-		case d5next:
-			if (channel < 2)
-				return 0444;
-			break;
-		case octo:
+		if (channel < priv->num_fans)
 			return 0444;
-		default:
-			break;
-		}
 		break;
 	case hwmon_in:
 		switch (priv->kind) {
 		case d5next:
-			if (channel < 3)
+			/* Special case to support voltage sensor */
+			if (channel < priv->num_fans + 1)
 				return 0444;
 			break;
-		case octo:
-			return 0444;
 		default:
+			if (channel < priv->num_fans)
+				return 0444;
 			break;
 		}
 		break;
@@ -406,16 +376,12 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		*val = priv->power_input[channel];
 		break;
 	case hwmon_pwm:
-		switch (priv->kind) {
-		case octo:
-			ret = aqc_get_ctrl_val(priv, octo_ctrl_fan_offsets[channel]);
+		if (priv->fan_ctrl_offsets) {
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel]);
 			if (ret < 0)
 				return ret;
 
 			*val = aqc_percent_to_pwm(ret);
-			break;
-		default:
-			break;
 		}
 		break;
 	case hwmon_in:
@@ -469,19 +435,15 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
-			switch (priv->kind) {
-			case octo:
+			if (priv->fan_ctrl_offsets) {
 				pwm_value = aqc_pwm_to_percent(val);
 				if (pwm_value < 0)
 					return pwm_value;
 
-				ret = aqc_set_ctrl_val(priv, octo_ctrl_fan_offsets[channel],
+				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
 						       pwm_value);
 				if (ret < 0)
 					return ret;
-				break;
-			default:
-				break;
 			}
 			break;
 		default:
@@ -576,76 +538,38 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
 	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
 
-	/* Sensor readings */
-	switch (priv->kind) {
-	case d5next:
-		priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
-
-		priv->temp_input[0] = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
+	/* Temperature sensor readings */
+	for (i = 0; i < priv->num_temp_sensors; i++) {
+		sensor_value = get_unaligned_be16(data +
+						  priv->temp_sensor_start_offset +
+						  i * AQC_TEMP_SENSOR_SIZE);
+		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+			priv->temp_input[i] = -ENODATA;
+		else
+			priv->temp_input[i] = sensor_value * 10;
+	}
 
-		priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
-		priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
+	/* Fan speed and related readings */
+	for (i = 0; i < priv->num_fans; i++) {
+		priv->speed_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_SPEED_OFFSET);
+		priv->power_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       AQC_FAN_POWER_OFFSET) * 10000;
+		priv->voltage_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] +
+				       AQC_FAN_VOLTAGE_OFFSET) * 10;
+		priv->current_input[i] =
+		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_CURRENT_OFFSET);
+	}
 
-		priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
-		priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
+	if (priv->power_cycle_count_offset != 0)
+		priv->power_cycles = get_unaligned_be32(data + priv->power_cycle_count_offset);
 
-		priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
-		priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
+	/* Special-case sensor readings */
+	switch (priv->kind) {
+	case d5next:
 		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
-
-		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
-		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
-		break;
-	case farbwerk:
-		/* Temperature sensor readings */
-		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
-							  i * FARBWERK_SENSOR_SIZE);
-			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
-		break;
-	case farbwerk360:
-		/* Temperature sensor readings */
-		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + FARBWERK360_SENSOR_START +
-							  i * FARBWERK360_SENSOR_SIZE);
-			if (sensor_value == FARBWERK360_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
-		break;
-	case octo:
-		priv->power_cycles = get_unaligned_be32(data + OCTO_POWER_CYCLES);
-
-		/* Fan speed and related readings */
-		for (i = 0; i < OCTO_NUM_FANS; i++) {
-			priv->speed_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_SPEED_OFFSET);
-			priv->power_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_POWER_OFFSET) * 10000;
-			priv->voltage_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_VOLTAGE_OFFSET) * 10;
-			priv->current_input[i] =
-			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
-					       OCTO_FAN_CURRENT_OFFSET);
-		}
-
-		/* Temperature sensor readings */
-		for (i = 0; i < OCTO_NUM_SENSORS; i++) {
-			sensor_value = get_unaligned_be16(data + OCTO_SENSOR_START +
-							  i * OCTO_SENSOR_SIZE);
-			if (sensor_value == OCTO_SENSOR_DISCONNECTED)
-				priv->temp_input[i] = -ENODATA;
-			else
-				priv->temp_input[i] = sensor_value * 10;
-		}
 		break;
 	default:
 		break;
@@ -699,14 +623,8 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
 	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
 
-	switch (priv->kind) {
-	case d5next:
-	case octo:
+	if (priv->power_cycle_count_offset != 0)
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
-		break;
-	default:
-		break;
-	}
 }
 
 #else
@@ -747,6 +665,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_PRODUCT_ID_D5NEXT:
 		priv->kind = d5next;
 
+		priv->num_fans = D5NEXT_NUM_FANS;
+		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
+		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
+		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
+		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
+
 		priv->temp_label = label_d5next_temp;
 		priv->speed_label = label_d5next_speeds;
 		priv->power_label = label_d5next_power;
@@ -756,19 +680,29 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_PRODUCT_ID_FARBWERK:
 		priv->kind = farbwerk;
 
+		priv->num_fans = 0;
+		priv->num_temp_sensors = FARBWERK_NUM_SENSORS;
+		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
 
+		priv->num_fans = 0;
+		priv->num_temp_sensors = FARBWERK360_NUM_SENSORS;
+		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_OCTO:
 		priv->kind = octo;
+
+		priv->num_fans = OCTO_NUM_FANS;
+		priv->fan_sensor_offsets = octo_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = octo_ctrl_fan_offsets;
+		priv->num_temp_sensors = OCTO_NUM_SENSORS;
+		priv->temp_sensor_start_offset = OCTO_SENSOR_START;
+		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
-		priv->checksum_start = OCTO_CTRL_REPORT_CHECKSUM_START;
-		priv->checksum_length = OCTO_CTRL_REPORT_CHECKSUM_LENGTH;
-		priv->checksum_offset = OCTO_CTRL_REPORT_CHECKSUM_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->speed_label = label_fan_speed;
@@ -780,6 +714,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
+	if (priv->buffer_size != 0) {
+		priv->checksum_start = 0x01;
+		priv->checksum_length = priv->buffer_size - 3;
+		priv->checksum_offset = priv->buffer_size - 2;
+	}
+
 	priv->name = aqc_device_names[priv->kind];
 
 	priv->buffer = devm_kzalloc(&hdev->dev, priv->buffer_size, GFP_KERNEL);
-- 
2.36.1

