Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DC511ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiD0OeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiD0Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:33:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CFB37;
        Wed, 27 Apr 2022 07:30:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so2745468wrh.11;
        Wed, 27 Apr 2022 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jnubTloA50NBhVPujuweIXddbKN6CZkPHUrLGAPqaI=;
        b=H9922wGqJwq84wbVnaSaJLWvH2yqxHkhjMKA2X0CcLAh3rNN5Ur65te4IA/jA4OiyD
         IeWO+vw+E3FvYnxc2FhEUU87/+lyOXdAthjA5NrnM15lG5HtXsg79gLRADK8IgFPX8Hn
         lkb0uCs25ZgUnGPA2nQBaGVp6K1ewdjzq6LEdGln5ziC37EjiuX2EmthXHpm82K8hKPG
         4uNEbM4IBZr5TLbXZLq4gdj0if2HIJmfeMhmRpindBrWCe0e6thofEjFxs2gMD8iu++N
         uEAH6i0rXG+CqrMR2SL6S/KeSgd+rc7CfYv9aaehsgmlVZUFdbMlscoNjI4SN3dbboqK
         Yg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jnubTloA50NBhVPujuweIXddbKN6CZkPHUrLGAPqaI=;
        b=rz2haoZeSM1/wBjVbs70kPAmzIFLMjdhwBJeyHyEidzQgFuOj64sVKfhKZ4Ta/mtNg
         jZV87F+nSUh7J+jMZ27AkfLoD8X2MuKye4fAScv8lqTEoJ5J3dIpAEtdAftpHzA0bHcI
         1JOKnmNcyQPMUuiEPnOOY/IgZeRpUQGiPKjeGHbV25tyLBKLUrjoA5zEMJ3YahwpIwNF
         f6GoamhJGw7PRf8BowkFx6OMgH6DB0cu5G13lF0zlxOhtTOhgkV9DYr9p1Rc1TkuHa1B
         URQ0sSJHgVwKjdm2u/Zi4p8xeRgg29r5/OwlYZ2EZK3TzFgaD21Jv37a033zmdkyq+o2
         Ud2Q==
X-Gm-Message-State: AOAM533ZwzOsO1CfnKePzA7oFrS0NLnXr33/pp/sqwIKojgBzlw9pchI
        b4srFfGugKNE6aO8KgNaF5s=
X-Google-Smtp-Source: ABdhPJxaZpIgD2ck+2+lMm4OwQWforWeo04POHG4mbM7+oFaOPfxxB0EVqfxEogNVWQhS0cwBLZZwg==
X-Received: by 2002:a5d:434f:0:b0:205:f514:8955 with SMTP id u15-20020a5d434f000000b00205f5148955mr23252494wrr.73.1651069814001;
        Wed, 27 Apr 2022 07:30:14 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id i14-20020a1c540e000000b00393dc91e9c9sm1721625wmb.17.2022.04.27.07.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:30:13 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] hwmon: (asus-ec-sensors) add support for board families
Date:   Wed, 27 Apr 2022 16:30:00 +0200
Message-Id: <20220427143001.1443605-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
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

DSDT code for AMD 400-series chipset shows that sensor addresses differ
for this generation from those for the AMD 500-series boards.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 40 ++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 581df4053060..109c3920d77c 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -135,8 +135,13 @@ enum ec_sensors {
 #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
 
+enum board_family {
+	family_unknown,
+	family_amd_500_series,
+};
+
 /* All the known sensors for ASUS EC controllers */
-static const struct ec_sensor_info known_ec_sensors[] = {
+static const struct ec_sensor_info sensors_family_amd_500[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
 	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
@@ -177,6 +182,7 @@ struct ec_board_info {
 	 * the hardware is not guarded.
 	 */
 	const char *mutex_path;
+	enum board_family family;
 };
 
 static const struct ec_board_info board_info[] = {
@@ -185,6 +191,7 @@ static const struct ec_board_info board_info[] = {
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ProArt X570-CREATOR WIFI"},
@@ -198,6 +205,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
@@ -207,6 +215,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
@@ -215,6 +224,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {
@@ -228,6 +238,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
@@ -236,6 +247,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-E GAMING"},
@@ -243,6 +255,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-I GAMING"},
@@ -251,6 +264,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX X570-E GAMING"},
@@ -259,12 +273,14 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX X570-F GAMING"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX X570-I GAMING"},
@@ -272,6 +288,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{}
 };
@@ -323,6 +340,7 @@ static bool unlock_global_acpi_lock(struct lock_data *data)
 
 struct ec_sensors_data {
 	const struct ec_board_info *board_info;
+	const struct ec_sensor_info *sensors_info;
 	struct ec_sensor *sensors;
 	/* EC registers to read from */
 	u16 *registers;
@@ -365,7 +383,7 @@ static bool is_sensor_data_signed(const struct ec_sensor_info *si)
 static const struct ec_sensor_info *
 get_sensor_info(const struct ec_sensors_data *state, int index)
 {
-	return &known_ec_sensors[state->sensors[index].info_index];
+	return state->sensors_info + state->sensors[index].info_index;
 }
 
 static int find_ec_sensor_index(const struct ec_sensors_data *ec,
@@ -403,9 +421,9 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
 		s->info_index = i;
 		s->cached_value = 0;
 		ec->nr_registers +=
-			known_ec_sensors[s->info_index].addr.components.size;
+			ec->sensors_info[s->info_index].addr.components.size;
 		bank_found = false;
-		bank = known_ec_sensors[s->info_index].addr.components.bank;
+		bank = ec->sensors_info[s->info_index].addr.components.bank;
 		for (j = 0; j < ec->nr_banks; j++) {
 			if (ec->banks[j] == bank) {
 				bank_found = true;
@@ -556,7 +574,7 @@ static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
 
 	sensor_end = ec->sensors + ec->nr_sensors;
 	for (s = ec->sensors; s != sensor_end; s++) {
-		si = &known_ec_sensors[s->info_index];
+		si = ec->sensors_info + s->info_index;
 		s->cached_value = get_sensor_value(si, data);
 		data += si->addr.components.size;
 	}
@@ -733,6 +751,17 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, ec_data);
 	ec_data->board_info = pboard_info;
+
+	switch (ec_data->board_info->family) {
+	case family_amd_500_series:
+		ec_data->sensors_info = sensors_family_amd_500;
+		break;
+	default:
+		dev_err(dev, "Unknown board family: %d",
+			ec_data->board_info->family);
+		return -EINVAL;
+	}
+
 	ec_data->nr_sensors = hweight_long(ec_data->board_info->sensors);
 	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
 					sizeof(struct ec_sensor), GFP_KERNEL);
@@ -742,6 +771,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to setup state/EC locking: %d", status);
 		return status;
 	}
+
 	setup_sensor_data(ec_data);
 	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
-- 
2.35.1

