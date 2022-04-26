Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED550F980
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348624AbiDZKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348351AbiDZKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:03:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D422282;
        Tue, 26 Apr 2022 02:24:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i5so5487746wrc.13;
        Tue, 26 Apr 2022 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BpQdx7LqZtnrpQOLQZKpg3ZPN9JoGnOuz7V1LQA8IA=;
        b=XDz1V4Ikd6galbxTyA0j4N9KyNS/jpL2qAztaYQmaAZdBLBuJ38wPSFf5qE8sIy3Z8
         Z+0Nszymf9TX/bkBKzjLcnQHBufQr2NsGfhyzyB1ZN2hR7BcbN3DNUQlAocC7lCSI1DV
         Ef08fBbGWbV4IKw4IAuow5Rtelg301JQIRbRhMYEoNR+h1EnsXkWF55F28SLff/Xpz9P
         JJqkoWkZZiQPIzOOZkMARcgrONculwKlfmqp7XXgxOoCJI1UB2uYoXd9jMoaW15otO4k
         2xb2zNTALs7Q0tPsGe3T4C1glhx8H0n6iMlT7SyNBBNlTUN9SoSjFdTWfDjiLRZJe6ZD
         5UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BpQdx7LqZtnrpQOLQZKpg3ZPN9JoGnOuz7V1LQA8IA=;
        b=kbsI/SOB8hv2ubcuwQMR6JVRlhSGdFpb5jB7+ICXFwghE4xdgE3iiEWYsQR2WFx5l/
         FMK7FqAyzZHB9Ks3scJS22JgBgKQuaBNygij9CKSqYfFcXQmj/nUrlAE373Iez9NeLTe
         GrLgtRkXz8GBvX4uhkEnJMP60tj3NOpoVGYHnufEUlfhi4LCN+8I3G6rlBPYFVb8qzcM
         DOvSxPhz/8hHqBaixJYMqqzw3vJmiJ36rwjsBstAHETxAQy4TRbtKgyOcDQXp5WhfmXI
         2Y9WO/j8rjH8nsCl1sv3iG6Uvy6O6zZWOyfRUq+ZxkXPvENbncHQsKZYvvjZoLxioc86
         GGbw==
X-Gm-Message-State: AOAM531HF+D6j/J7vxQBlL+3Du3O4vPdYq+pljJ9CHckdQttpJAOcns6
        xJmXxsC9vBC6GxRpQKp9WZU=
X-Google-Smtp-Source: ABdhPJxrp7Ez0lsy4q/vveGi/CfyGypokv38oepO9f5OBkywKPZc8GCgN9k/yFAdtCMHeUKOBuq4Kw==
X-Received: by 2002:adf:de83:0:b0:20a:cbb5:903a with SMTP id w3-20020adfde83000000b0020acbb5903amr15659591wrl.544.1650965040678;
        Tue, 26 Apr 2022 02:24:00 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id 9-20020a056000154900b0020a849e1c41sm13125094wry.13.2022.04.26.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:24:00 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] hwmon: (asus-ec-sensors) add support for board families
Date:   Tue, 26 Apr 2022 11:23:39 +0200
Message-Id: <20220426092340.495704-4-eugene.shalygin@gmail.com>
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

DSDT code for AMD 400-series chipset shows that sensor addresses differ
for this generation from those for the AMD 500-series boards.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 7267682de191..b52e3679476a 100644
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
 
 static const struct ec_board_info board_info[] = {
@@ -185,6 +190,7 @@ static const struct ec_board_info board_info[] = {
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ProArt X570-CREATOR WIFI"},
@@ -198,6 +204,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
@@ -207,6 +214,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
@@ -215,6 +223,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {
@@ -228,6 +237,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
@@ -236,6 +246,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-E GAMING"},
@@ -243,6 +254,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
 			SENSOR_FAN_CPU_OPT,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX B550-I GAMING"},
@@ -251,6 +263,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{
 		.board_names = {"ROG STRIX X570-E GAMING"},
@@ -259,12 +272,14 @@ static const struct ec_board_info board_info[] = {
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
@@ -272,6 +287,7 @@ static const struct ec_board_info board_info[] = {
 			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 			SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
 	},
 	{}
 };
@@ -323,6 +339,7 @@ static bool unlock_global_acpi_lock(struct lock_data *data)
 
 struct ec_sensors_data {
 	const struct ec_board_info *board_info;
+	const struct ec_sensor_info *sensors_info;
 	struct ec_sensor *sensors;
 	/* EC registers to read from */
 	u16 *registers;
@@ -365,7 +382,7 @@ static bool is_sensor_data_signed(const struct ec_sensor_info *si)
 static const struct ec_sensor_info *
 get_sensor_info(const struct ec_sensors_data *state, int index)
 {
-	return &known_ec_sensors[state->sensors[index].info_index];
+	return state->sensors_info + state->sensors[index].info_index;
 }
 
 static int find_ec_sensor_index(const struct ec_sensors_data *ec,
@@ -403,9 +420,9 @@ static void __init setup_sensor_data(struct ec_sensors_data *ec)
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
@@ -556,7 +573,7 @@ static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
 
 	sensor_end = ec->sensors + ec->nr_sensors;
 	for (s = ec->sensors; s != sensor_end; s++) {
-		si = &known_ec_sensors[s->info_index];
+		si = ec->sensors_info + s->info_index;
 		s->cached_value = get_sensor_value(si, data);
 		data += si->addr.components.size;
 	}
@@ -733,6 +750,17 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 
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
@@ -742,6 +770,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to setup state/EC locking: %d", status);
 		return status;
 	}
+
 	setup_sensor_data(ec_data);
 	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
-- 
2.35.1

