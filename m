Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BACA4E87A8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiC0MQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiC0MQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:16:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F337A08;
        Sun, 27 Mar 2022 05:15:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a8so23426389ejc.8;
        Sun, 27 Mar 2022 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPlOM/HUhBRjMnx4RsFxweD+FWKTwqz3KJ8tz6O9dak=;
        b=C9JTXaNzh84Uq+rF1EHIj2oFyPf5rSxYIhoobdZSpB35tF+yCnQfqgbMrnDuQX2NmW
         RoTMB6iJCZq5Gw0qdBlG3jTGKRqeLjutbmfEj4CyMDigYXjsaGxPv+EpO/mGQ1YSkQNg
         Tl368sxndhikpjGcm2QDVa53LMm/M+mxdhTBo2IZfDwZu3iDp2W/aRan49dfw72gDrAm
         RVCiuhj4Ryjgc6lQqCNxzqav7KHT+GaH2XiRsLROK8PngTc6MAbHwk1hldxR2ZpcXcfH
         zm7QM8SOsVcvgzVyD4T+23jRrVol0H0KC+Tf2teER+uvL/rUMdSHTKOAdS8UBPvGd/dq
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPlOM/HUhBRjMnx4RsFxweD+FWKTwqz3KJ8tz6O9dak=;
        b=t4Cm7OykpqK97EnFAGCZ6OnhE9Smf2ICg4dfGZH96nJt1UJpTe7ph4X+RxxzgOsT6c
         BiNw8qyrrcInTydi+dvuYDRtUykmVbhn5XI8PVo/q/YbaLAk2kOXyW9H/DOD5H22s7VI
         XIUzKy/zashUX74b4GNxj9BrfV0Xtv0FGOZvIsA69DC0bdQP4GFAz1BrpJutL6Qr0ycT
         2Eh6aOe7lyH8tAyHdF1KnaRMBz1RmU40V5PC+mdWr2pLQhEDOIDfARMBMwSOwTUSLbTg
         BcxRK6M6c4d4f7DBvHcqjgng8AvLbtQlFk3WA4cxBxV6QuGFo/U9j8814VhtYWQe+xBS
         3B/A==
X-Gm-Message-State: AOAM53355yXJlpVr+ucHFOp0lGD4UFIrPvBHurag9K0dTRvai57yGPMZ
        09ITrXAuDllLDZZOeMcP6+k=
X-Google-Smtp-Source: ABdhPJzSIATIQy5CjoeehGrwpXk4z8gAEU4ZK2e1fgt7MKORtUWqTcik6a5s57R6umTuXA0yijrRLA==
X-Received: by 2002:a17:907:9485:b0:6db:331:591e with SMTP id dm5-20020a170907948500b006db0331591emr21738259ejc.478.1648383310623;
        Sun, 27 Mar 2022 05:15:10 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f06c2008407e4c213cb9d01.dip0.t-ipconnect.de. [2003:cf:9f06:c200:8407:e4c2:13cb:9d01])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm4530127ejc.64.2022.03.27.05.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:15:09 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwmon: (asus-ec-sensors) add support for board families
Date:   Sun, 27 Mar 2022 14:14:03 +0200
Message-Id: <20220327121404.1702631-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
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

DSDT code for AMD 400-series chipset shows that sensor addresses differ
for this generation from those for the AMD 500-series boards.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 43 +++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 34841eeb800f..b4060ed1f0fa 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -135,8 +135,12 @@ enum ec_sensors {
 #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
 
+enum board_family {
+	family_amd_500_series,
+};
+
 /* All the known sensors for ASUS EC controllers */
-static const struct ec_sensor_info known_ec_sensors[] = {
+static const struct ec_sensor_info sensors_family_amd_500[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
 	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
@@ -177,6 +181,7 @@ struct ec_board_info {
 	 * the hardware is not guarded.
 	 */
 	const char *mutex_path;
+	enum board_family family;
 };
 
 static const struct ec_board_info board_info[] __initconst = {
@@ -185,6 +190,7 @@ static const struct ec_board_info board_info[] __initconst = {
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"Pro WS X570-ACE"},
@@ -192,6 +198,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
@@ -201,6 +208,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
@@ -209,6 +217,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {
@@ -222,6 +231,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
@@ -230,6 +240,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-E GAMING"},
@@ -237,6 +248,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-I GAMING"},
@@ -245,6 +257,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX X570-E GAMING"},
@@ -253,12 +266,14 @@ static const struct ec_board_info board_info[] __initconst = {
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
@@ -266,6 +281,7 @@ static const struct ec_board_info board_info[] __initconst = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{}
 };
@@ -328,6 +344,7 @@ static int unlock_mutex(struct lock_data *data)
 
 struct ec_sensors_data {
 	struct ec_board_info board_info;
+	const struct ec_sensor_info *sensors_info;
 	struct ec_sensor *sensors;
 	/* EC registers to read from */
 	u16 *registers;
@@ -370,7 +387,7 @@ static bool is_sensor_data_signed(const struct ec_sensor_info *si)
 static const struct ec_sensor_info *
 get_sensor_info(const struct ec_sensors_data *state, int index)
 {
-	return &known_ec_sensors[state->sensors[index].info_index];
+	return state->sensors_info + state->sensors[index].info_index;
 }
 
 static int sensor_count(const struct ec_board_info *board)
@@ -413,9 +430,9 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
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
@@ -566,8 +583,9 @@ static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
 	struct ec_sensor *s, *sensor_end;
 
 	sensor_end = ec->sensors + sensor_count(&ec->board_info);
+
 	for (s = ec->sensors; s != sensor_end; s++) {
-		si = &known_ec_sensors[s->info_index];
+		si = ec->sensors_info + s->info_index;
 		s->cached_value = get_sensor_value(si, data);
 		data += si->addr.components.size;
 	}
@@ -744,14 +762,25 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, ec_data);
 	ec_data->board_info = *pboard_info;
-	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
-					sizeof(struct ec_sensor), GFP_KERNEL);
+	switch (ec_data->board_info.family) {
+	case family_amd_500_series:
+		ec_data->sensors_info = sensors_family_amd_500;
+		break;
+	default:
+		dev_err(dev, "Unknown board family: %d",
+			ec_data->board_info.family);
+		return -EINVAL;
+	}
 
 	status = setup_lock_data(dev);
 	if (status) {
 		dev_err(dev, "Failed to setup state/EC locking: %d", status);
 		return status;
 	}
+
+	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
+					sizeof(struct ec_sensor), GFP_KERNEL);
+
 	setup_sensor_data(ec_data);
 	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
-- 
2.35.1

