Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DB50F974
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbiDZKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiDZKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:03:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CD60A83;
        Tue, 26 Apr 2022 02:24:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k36-20020a05600c1ca400b00393f18c8fc5so1118312wms.4;
        Tue, 26 Apr 2022 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgMoFM22a1pXbC0ROfYTg43rXumt1gFFaxfK/H/STx8=;
        b=aOQkPkeHou/ylBED5XmEHi/6CgtMdRGuPYjJP8ZWscAP7ZS9z6B34xh44u4ixKGYdr
         FecbKMllrbD1IWOKt7rAi4mau22bY4XnXJimU3+tiqAUsFpqJf1IpoILrnaeM3NU0Pep
         tMh2yRmzTSEPV+1QcDqj1rlqRRE5vOflQ2GPPjUW4w1Tz5fXOMQELw5/+X2zso27tyOi
         2+6v/5Nk13Yu1nRxK4wAQwsOifL7oMaD++2/SZLtW1l3P8qnPCefxmayjQNWvWNTwyRT
         LbECjwJPUKXRBdn3ihtibPR8KEx8TEYh7lnX2guE7VQdMFv+xUwIxHaJsAkk/7ffx+2r
         8/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgMoFM22a1pXbC0ROfYTg43rXumt1gFFaxfK/H/STx8=;
        b=L+jRjSzReveCaM0JWOALsqruYwpe7ZEtAJDkplbL0wlSCLgbvxCLMIV612PHJm4Di9
         dT2wNJtA6Hbgp2fHHvHnwTo8X9kK9/qaBOgH7C1HqrZMAE4xiAmhg7f5qw0lVaeNex2b
         OaeO6RXzgmRau8Tf9SK3RNPGpV/kVD9F1L/54JsY7edMsHmTV9/aaIjU50uNnV+/SuKq
         aZNhf3NIsFUFkDKUsZbz6opVSCm1GD35pcT7cHHD17MgJQmCJpvULHJFpzIEUY8OsTXm
         SZ/XJZcZwKdLUUOXioiCeGhhk+agUvsL4if8hy0yaOqNWbtkqNn2uveUNiwzVi3G4rXx
         FHCg==
X-Gm-Message-State: AOAM532hQ/2E1+miIzWvPlcDyG5HatpWtqUPAqiNWIZlfUIizDeul05S
        tgtNpzcfQRoh/cUZZb3tp3s=
X-Google-Smtp-Source: ABdhPJxdnyUTyQyQdiD4TwO9gOHXMsMOaA4i5pPuVw3EwOAOL1bYkxe9A6O9LE9BPspqUXHQ3fIeGw==
X-Received: by 2002:a1c:a185:0:b0:392:206d:209d with SMTP id k127-20020a1ca185000000b00392206d209dmr19798036wme.168.1650965041783;
        Tue, 26 Apr 2022 02:24:01 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id 9-20020a056000154900b0020a849e1c41sm13125094wry.13.2022.04.26.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:24:01 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Date:   Tue, 26 Apr 2022 11:23:40 +0200
Message-Id: <20220426092340.495704-5-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426092340.495704-1-eugene.shalygin@gmail.com>
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board is supposed to be handled by the asus-wmi-sensors driver,
but due to a buggy WMI implementation the driver and the official ASUS
software make the BIOS hang together with fan controls [1, 2].

This driver complements values provided by the SIO chip and does not
freeze the BIOS, as tested by a user [2].

[1] https://github.com/electrified/asus-wmi-sensors/blob/master/README.md
[2] https://github.com/zeule/asus-ec-sensors/issues/12

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b52e3679476a..3af4b22fd3c5 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -136,10 +136,41 @@ enum ec_sensors {
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
 
 enum board_family {
+	family_amd_400_series,
 	family_amd_500_series,
 };
 
 /* All the known sensors for ASUS EC controllers */
+static const struct ec_sensor_info sensors_family_amd_400[] = {
+	[ec_sensor_temp_chipset] =
+		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
+	[ec_sensor_temp_cpu] =
+		EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
+	[ec_sensor_temp_mb] =
+		EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[ec_sensor_temp_vrm] =
+		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
+	[ec_sensor_in_cpu_core] =
+		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_fan_vrm_hs] =
+		EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
+	[ec_sensor_fan_chipset] =
+		/* no chipset fans in this generation */
+		EC_SENSOR("Chipset", hwmon_fan, 0, 0x00, 0x00),
+	[ec_sensor_fan_water_flow] =
+		EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xb4),
+	[ec_sensor_curr_cpu] =
+		EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4),
+	[ec_sensor_temp_water_in] =
+		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x0d),
+	[ec_sensor_temp_water_out] =
+		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x0b),
+};
+
 static const struct ec_sensor_info sensors_family_amd_500[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
@@ -185,6 +216,15 @@ struct ec_board_info {
 };
 
 static const struct ec_board_info board_info[] = {
+	{
+		.board_names = {"PRIME X470-PRO"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+			SENSOR_FAN_CPU_OPT |
+			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+		.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+		.family = family_amd_400_series,
+	},
 	{
 		.board_names = {"PRIME X570-PRO"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
@@ -752,6 +792,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	ec_data->board_info = pboard_info;
 
 	switch (ec_data->board_info->family) {
+	case family_amd_400_series:
+		ec_data->sensors_info = sensors_family_amd_400;
+		break;
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
-- 
2.35.1

