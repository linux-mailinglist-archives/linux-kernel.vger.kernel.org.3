Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156A04AD630
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355432AbiBHLWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiBHJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:43:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07927C03FEC0;
        Tue,  8 Feb 2022 01:43:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j14so27115517ejy.6;
        Tue, 08 Feb 2022 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq+dKx41RUjgzj8JvU9gnjviVgG4UdA+iyRcp+19UfA=;
        b=kzTiv9B2U7Wc0fxzGKxQg8uhdYfgfO/xIoYNmhC/rgC3OhSFBPSSSVQO2K03kmbWfV
         +UGcT+3CXBaxmU4wl8vygy23F0/n2OIZj2wwoZZ6M8tTxHSy5w2XasdRhToXb6F0ZJL/
         5huGHAex9ROgFLbGyHXavnKHmZg06VqvEs+lU3tVrec1MwOb4gQ+YZnPEYUEScn8yWtG
         WF55TzQTCmLzqEGG4Wwt1SN9T/qVgfgZxo3olqp4twStPc8Fvlq9EMbnn/OX0tq+yMTp
         Nu1gS0AV+TRUTP19KVXQYe2RVt0OjPTJ8exsji8O9JmPiZQToxuJaegip/FXmkOFrhBJ
         PJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq+dKx41RUjgzj8JvU9gnjviVgG4UdA+iyRcp+19UfA=;
        b=q5js+0T8YuxD/PeJk01Wx/XllnlZgCF/Zj1js5uulnlweydHDse+Jmyzk6pi+Z178R
         GY1xrd4G1PYw7fjh2Bt84dsMCdyqkP1AdpgokWUegGQId6/hDq0ZAiAzcI0+wpv3gatL
         5alRv6j8uVKhZfgc9VJFPp4Aubskx17aSri7qKsN54e2cDLk+LvTFolwHnf0zNwkqTiM
         0ZQiSQesn0mtB+ZwiQvliQ8NyMcJaYUI8uefN/+YDHe6aUOde1ju35IKWIuIehaB4p4x
         GAnClsUMLqz0kdLXbFg7lpNVwOxaaOeVIjmoxPCKomJK24tK040U8fw7O24OXRFzL5xP
         BZPg==
X-Gm-Message-State: AOAM532l7rVUk+WT/IYG/IIZYuBNZeqHps3bPT6ovJITC+OkKdJ+P6TB
        dK/MDRN0+s0LeSyWUhpp3ts=
X-Google-Smtp-Source: ABdhPJwAZUEHLlmX1IkuCQdKZVNT6gCfYtB0CZnvNZIAtRmMvtzYnBBVouYUplHQTTxgvw/iOFbdAA==
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr2996031ejb.192.1644313395453;
        Tue, 08 Feb 2022 01:43:15 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id v14sm585931edq.13.2022.02.08.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:43:14 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add CPU core voltage
Date:   Tue,  8 Feb 2022 10:42:43 +0100
Message-Id: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user discovered [1] the CPU Core voltage sensor, which spans 2
registers and provides output in mV. Althroug the discovery was made
with a X470 chipset, the sensor is present in X570 (tested with C8H).
For now simply add it to each board with the CPU current sensor present.

[1] https://github.com/zeule/asus-ec-sensors/issues/12

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 29 ++++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 22de1b037cfb..e7e8f1640f45 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -39,6 +39,7 @@ The driver is aware of and reads the following sensors:
 9. Readings from the "Water flow meter" header (RPM)
 10. Readings from the "Water In" and "Water Out" temperature headers
 11. CPU current
+12. CPU core voltage
 
 Sensor values are read from EC registers, and to avoid race with the board
 firmware the driver acquires ACPI mutex, the one used by the WMI when its
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index dd7b207d062f..bfac08a5dc57 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -18,6 +18,7 @@
  * - VRM Heat Sink fan RPM
  * - Water Flow fan RPM
  * - CPU current
+ * - CPU core voltage
  */
 
 #include <linux/acpi.h>
@@ -100,6 +101,8 @@ enum ec_sensors {
 	ec_sensor_temp_t_sensor,
 	/* VRM temperature [℃] */
 	ec_sensor_temp_vrm,
+	/* CPU Core voltage [mV] */
+	ec_sensor_in_cpu_core,
 	/* CPU_Opt fan [RPM] */
 	ec_sensor_fan_cpu_opt,
 	/* VRM heat sink fan [RPM] */
@@ -121,6 +124,7 @@ enum ec_sensors {
 #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
 #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
 #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
+#define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
 #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
 #define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
 #define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
@@ -139,6 +143,8 @@ static const struct ec_sensor_info known_ec_sensors[] = {
 	[ec_sensor_temp_t_sensor] =
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
 	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+	[ec_sensor_in_cpu_core] =
+		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
 	[ec_sensor_fan_cpu_opt] =
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 	[ec_sensor_fan_vrm_hs] = EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
@@ -172,32 +178,34 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
-		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
+		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
 			      "ROG CROSSHAIR VIII DARK HERO",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
 			      "ROG CROSSHAIR VIII FORMULA",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_CURR_CPU),
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
 		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
 			      "ROG CROSSHAIR VIII HERO (WI-FI)",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
 		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
 			      "ROG CROSSHAIR VIII IMPACT",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
+		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -205,17 +213,19 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU),
+		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
+		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
-		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
+		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	{}
 };
 
@@ -467,7 +477,6 @@ static long scale_sensor_value(s32 value, int data_type)
 	switch (data_type) {
 	case hwmon_curr:
 	case hwmon_temp:
-	case hwmon_in:
 		return value * MILLI;
 	default:
 		return value;
-- 
2.35.1

