Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023575AD4BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiIEO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiIEOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:25:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DCF42AE5;
        Mon,  5 Sep 2022 07:25:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so17504153ejc.1;
        Mon, 05 Sep 2022 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UfRHBRZ9xqITbW1zBp8kJA3t/bk2cuuGqYXQgZb7GIY=;
        b=LMf74VUe6z53994mSaVPIbYPhv1rYZsAV5X6IXoaOE+nTKaMKY+OM7rEpRw3IsEEn5
         FiBE4CVYOfJL+9/y4WPoZQn82y3tYcvdQe4FkfiIYlJAn8/ck3Ee8UXuL/m7L4Owt/23
         f030ZmmoUfjLJ4V7zBjARekjTzB7kzSMvTDLuQ7dA0JOT89irsuEQ3zid+8TDDq8xMqB
         Vq8Xm0/lfUVEX/rbxgs+cUg/mOyjwU9vdS+ZNDlcvG2+ES+5p1LcD8sfkJd7m0jpXrSd
         MjGw7+MInVl6CTdIT653UBCqp9N2IzJHUr3aeDVTA+lBmEmoRRtvYK7dL95mL9fmHI5Q
         Nu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UfRHBRZ9xqITbW1zBp8kJA3t/bk2cuuGqYXQgZb7GIY=;
        b=I0QyHJnQfgcteNAHP6kSMyHr3mf8PQRj1wAGUKqjTjJOw+Kh3//YGF8vBZUN2Df8Kv
         tmfGD0KyuvGowzznggl0u56+HIH5W9m8fX35BQ3mzt+9uNaINvLyZYeVECpIfxiWrvw8
         G05GxnWJ1q88W1Qj1Ete58pLa5f15p650WNhrfmwcIOzI9r01NJOWP75oKV7LtIQggjs
         M5cHPdi4cxeVzmlI1h1i9foZWE7TEDN+SPyluuMvgUe/oUSmnqc966RG3FcZfNB3c1h7
         7Clcoq23MkqJkR65DwVDK8jS3dLmV9QV3bF71gcOTamfGqZR1alVvwo76CY+jliVHtz1
         /kCg==
X-Gm-Message-State: ACgBeo2Cs8TM0EnW6okNNZBCzuw9yN43egyRCuD7LYZSfZ1dAX8JVsAK
        Fc2ds6/ugLO9jfjyUyrLFw+EYxlLW+g=
X-Google-Smtp-Source: AA6agR7ET5WWI6MUz8j2y3SltSYP3KL6v8eH7Xv6XObxif3Ld2Ts10mJUtfLIC9YdJoqkpLYC8HLpA==
X-Received: by 2002:a17:907:720b:b0:731:6e49:dc93 with SMTP id dr11-20020a170907720b00b007316e49dc93mr36740115ejc.421.1662387955237;
        Mon, 05 Sep 2022 07:25:55 -0700 (PDT)
Received: from fedora.. ([87.116.166.59])
        by smtp.gmail.com with ESMTPSA id cz19-20020a0564021cb300b0044780b6debasm6616214edb.32.2022.09.05.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:25:54 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow Next
Date:   Mon,  5 Sep 2022 16:25:21 +0200
Message-Id: <20220905142521.6674-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose various hardware
sensors of the Aquacomputer High Flow Next flow sensor, which
communicates through a proprietary USB HID protocol.

The High Flow Next exposes +5V voltages, water quality, conductivity
and flow readings. A temperature sensor can be connected to it, in
which case it provides its reading and an estimation of the
dissipated/absorbed power in the liquid cooling loop.

Additionally, serial number and firmware version are exposed through
debugfs.

Registry offsets were discovered and tested by users on Github [1] [2].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/8
[2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/34

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  4 +
 drivers/hwmon/Kconfig                       |  6 +-
 drivers/hwmon/aquacomputer_d5next.c         | 88 ++++++++++++++++++++-
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index b63a78d47624..3d044b1a9aed 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -43,6 +43,10 @@ voltage and current.
 The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
 sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
 
+The High Flow Next exposes +5V voltages, water quality, conductivity and flow readings.
+A temperature sensor can be connected to it, in which case it provides its reading
+and an estimation of the dissipated/absorbed power in the liquid cooling loop.
+
 Depending on the device, not all sysfs and debugfs entries will be available.
 Writing to virtual temperature sensors is not currently supported.
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d32f1705915c..f604f599a341 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -257,14 +257,14 @@ config SENSORS_AHT10
 	  will be called aht10.
 
 config SENSORS_AQUACOMPUTER_D5NEXT
-	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, and Farbwerk 360"
+	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 360, High Flow Next"
 	depends on USB_HID
 	select CRC16
 	help
 	  If you say yes here you get support for sensors and fans of
 	  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
-	  controllers, Farbwerk and Farbwerk 360 RGB controllers, where
-	  available.
+	  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flow
+	  Next sensor, where available.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aquacomputer_d5next.
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index b2b0c4fdfa84..a715142a3d0c 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
- * Quadro)
+ * Quadro, High Flow Next)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values.
@@ -34,7 +34,8 @@ static const char *const aqc_device_names[] = {
 	[farbwerk] = "farbwerk",
 	[farbwerk360] = "farbwerk360",
 	[octo] = "octo",
-	[quadro] = "quadro"
+	[quadro] = "quadro",
+	[highflownext] = "highflownext"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -120,6 +121,16 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 /* Fan speed registers in Quadro control report (from 0-100%) */
 static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 };
 
+/* Register offsets for the High Flow Next */
+#define HIGHFLOWNEXT_NUM_SENSORS	2
+#define HIGHFLOWNEXT_SENSOR_START	85
+#define HIGHFLOWNEXT_FLOW		81
+#define HIGHFLOWNEXT_WATER_QUALITY	89
+#define HIGHFLOWNEXT_POWER		91
+#define HIGHFLOWNEXT_CONDUCTIVITY	95
+#define HIGHFLOWNEXT_5V_VOLTAGE		97
+#define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
+
 /* Labels for D5 Next */
 static const char *const label_d5next_temp[] = {
 	"Coolant temp"
@@ -228,6 +239,27 @@ static const char *const label_quadro_speeds[] = {
 	"Flow speed [dL/h]"
 };
 
+/* Labels for High Flow Next */
+static const char *const label_highflownext_temp_sensors[] = {
+	"Coolant temp",
+	"External sensor"
+};
+
+static const char *const label_highflownext_fan_speed[] = {
+	"Flow [dL/h]",
+	"Water quality [%]",
+	"Conductivity [nS/cm]",
+};
+
+static const char *const label_highflownext_power[] = {
+	"Dissipated power",
+};
+
+static const char *const label_highflownext_voltage[] = {
+	"+5V voltage",
+	"+5V USB voltage"
+};
+
 struct aqc_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
@@ -390,6 +422,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		break;
 	case hwmon_fan:
 		switch (priv->kind) {
+		case highflownext:
+			/* Special case to support flow sensor, water quality and conductivity */
+			if (channel < 3)
+				return 0444;
+			break;
 		case quadro:
 			/* Special case to support flow sensor */
 			if (channel < priv->num_fans + 1)
@@ -402,6 +439,18 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		}
 		break;
 	case hwmon_power:
+		switch (priv->kind) {
+		case highflownext:
+			/* Special case to support one power sensor */
+			if (channel == 0)
+				return 0444;
+			break;
+		default:
+			if (channel < priv->num_fans)
+				return 0444;
+			break;
+		}
+		break;
 	case hwmon_curr:
 		if (channel < priv->num_fans)
 			return 0444;
@@ -413,6 +462,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (channel < priv->num_fans + 2)
 				return 0444;
 			break;
+		case highflownext:
+			/* Special case to support two voltage sensors */
+			if (channel < 2)
+				return 0444;
+			break;
 		default:
 			if (channel < priv->num_fans)
 				return 0444;
@@ -679,6 +733,22 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	case quadro:
 		priv->speed_input[4] = get_unaligned_be16(data + priv->flow_sensor_offset);
 		break;
+	case highflownext:
+		/* If external temp sensor is not connected, its power reading is also N/A */
+		if (priv->temp_input[1] == -ENODATA)
+			priv->power_input[0] = -ENODATA;
+		else
+			priv->power_input[0] =
+			    get_unaligned_be16(data + HIGHFLOWNEXT_POWER) * 1000000;
+
+		priv->voltage_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE) * 10;
+		priv->voltage_input[1] =
+		    get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE_USB) * 10;
+
+		priv->speed_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_FLOW);
+		priv->speed_input[1] = get_unaligned_be16(data + HIGHFLOWNEXT_WATER_QUALITY);
+		priv->speed_input[2] = get_unaligned_be16(data + HIGHFLOWNEXT_CONDUCTIVITY);
+		break;
 	default:
 		break;
 	}
@@ -851,6 +921,19 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
 		break;
+	case USB_PRODUCT_ID_HIGHFLOWNEXT:
+		priv->kind = highflownext;
+
+		priv->num_fans = 0;
+		priv->num_temp_sensors = HIGHFLOWNEXT_NUM_SENSORS;
+		priv->temp_sensor_start_offset = HIGHFLOWNEXT_SENSOR_START;
+		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
+
+		priv->temp_label = label_highflownext_temp_sensors;
+		priv->speed_label = label_highflownext_fan_speed;
+		priv->power_label = label_highflownext_power;
+		priv->voltage_label = label_highflownext_voltage;
+		break;
 	default:
 		break;
 	}
@@ -907,6 +990,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
 	{ }
 };
 
-- 
2.37.2

