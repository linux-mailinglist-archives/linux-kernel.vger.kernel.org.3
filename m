Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE455E324
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiF0WzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiF0WzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:55:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BBC7;
        Mon, 27 Jun 2022 15:55:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so6714592wma.1;
        Mon, 27 Jun 2022 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lOPeA9vvaiwrc8RGmW70icF1DKGIzZjDJ8+Ucf9WO4=;
        b=VJ4YBLCw3078xk+8dyLf3gwBU8Cd14dymqoyGFBawCGZ4DiG+T+7vqp1+ifKk6RWDa
         wY5WoCGzReh6CVns+YdYrBhmGLi/3LHvyfDJdPXR73tE9tIj/8UHYtCFxUzSQ+Nmho26
         drGVqmEzBP/85LgtqvK0OGNiTzZAsYhyqrx+Yc+Yba5l7K2fFkz5lW841wAC9tEQChMp
         yCU3CVivhw6cbYOVcWMWTmEvaAzoEi3pYHiwwqG/kvya5NLHNLIHy54bzRFKJp8VU7jr
         +JAjP1a622aw2D2MzMwyceCKS5jzgweedT3lsHQM5CQLE4HMQpR246iJFE4q8sNZhTaN
         ZyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lOPeA9vvaiwrc8RGmW70icF1DKGIzZjDJ8+Ucf9WO4=;
        b=B6TWpTGSWfRKpkyhy9Ij73xWvGLqTLk9MrYGcHHVJ/JfRFeTOFRsmQhytisceqhwe7
         bmGDKTSMb82lLTDGiLs1pXOykTsgEzOV8mDhdCZP5U4IAz6axdNhjm47C+M9TJslukKj
         m5s6bMO56m3t62DnI3j0Q8n/DT9o6Yeavy9as8uX4yV1mnR9m/Y2J+zTWiDJUekNiurS
         4OFZYyBTH4IHJx3jfqrSJIbBjjPiuvYV+6+gRFyRelWPy1XaRoacy9sTQYg2FykXYZtF
         FFvIjFJJqK98oQoaVSQndmcWdvpKSKLmaNDESD1gPMSVexIwdWB2CE9lTz6YTJFC9oqv
         oGQw==
X-Gm-Message-State: AJIora/QNdQYnW4NPrZ2llW0S+2+2KKMp9o2Oklf5eb+pPgaGUiWlIrl
        X5rBGFoskst1pyGY9ctIeOc=
X-Google-Smtp-Source: AGRyM1s05tbhpIkS7r5444R7Er2lvhy/C6+ddfXV+91UnOAS071/QdcOboJQXguFNaiuQC/j3mEXIw==
X-Received: by 2002:a05:600c:886:b0:3a0:49d7:d8b9 with SMTP id l6-20020a05600c088600b003a049d7d8b9mr9804184wmp.115.1656370509478;
        Mon, 27 Jun 2022 15:55:09 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1a9e008d6dafec091202b8.dip0.t-ipconnect.de. [2003:cf:9f1a:9e00:8d6d:afec:912:2b8])
        by smtp.googlemail.com with ESMTPSA id n8-20020a05600c304800b003a04b248896sm4163502wmh.35.2022.06.27.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:55:08 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add support for Maximus XI Hero
Date:   Tue, 28 Jun 2022 00:54:36 +0200
Message-Id: <20220627225437.87462-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Carns <mike@carns.com>

Add definitions for ROG MAXIMUS XI HERO and ROG MAXIMUS XI HERO (WI-FI)
boards.

Signed-off-by: Michael Carns <mike@carns.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  2 ++
 drivers/hwmon/asus-ec-sensors.c         | 36 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 00d8c46ef9e0..1e40c123db77 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -13,6 +13,8 @@ Supported boards:
  * ROG CROSSHAIR VIII FORMULA
  * ROG CROSSHAIR VIII HERO
  * ROG CROSSHAIR VIII IMPACT
+ * ROG MAXIMUS XI HERO
+ * ROG MAXIMUS XI HERO (WI-FI)
  * ROG STRIX B550-E GAMING
  * ROG STRIX B550-I GAMING
  * ROG STRIX X570-E GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 19d3ca71b360..625c2baa35ec 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -141,6 +141,7 @@ enum board_family {
 	family_unknown,
 	family_amd_400_series,
 	family_amd_500_series,
+	family_intel_300_series,
 	family_intel_600_series
 };
 
@@ -200,6 +201,26 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
 };
 
+static const struct ec_sensor_info sensors_family_intel_300[] = {
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
+	[ec_sensor_fan_water_flow] =
+		EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_temp_water_in] =
+		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
+	[ec_sensor_temp_water_out] =
+		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+};
+
 static const struct ec_sensor_info sensors_family_intel_600[] = {
 	[ec_sensor_temp_t_sensor] =
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
@@ -281,6 +302,18 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 		.family = family_amd_500_series,
 	},
+	{
+		.board_names = {
+			"ROG MAXIMUS XI HERO",
+			"ROG MAXIMUS XI HERO (WI-FI)",
+		},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR |
+			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_intel_300_series,
+	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
@@ -814,6 +847,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
+	case family_intel_300_series:
+		ec_data->sensors_info = sensors_family_intel_300;
+		break;
 	case family_intel_600_series:
 		ec_data->sensors_info = sensors_family_intel_600;
 		break;
-- 
2.35.1

