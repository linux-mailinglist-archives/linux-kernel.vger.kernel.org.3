Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023C524CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353713AbiELMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353665AbiELMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D7124735D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d5so7024557wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQMVyVqHgBWr9jrth3XGcb0oJTmc+ZSSOROdsenztjQ=;
        b=EI5SK+x2NOPcWAR0ZjAzXIc1jlEF/SB9Fbehmu8SsfBBkbmbBQIAsRnBRasB3L8DRd
         VIUWoiiTfSO1te4Tld0MYxOBuvqZV6klL8d3U5ttww/hvKZerH8ajUGxx2vvCmWMSFwh
         VMjwUIFKiurnw/aYrxIu8qrKoP9No2+SO4ROvXduNwE+gpLKnSnl59TibGRy0zNimL+g
         XTwtsw+cNX9VRZzaOIKaU5ZZId3crQh8ucJachBS1cHxEQKjpprnfI9irH5YbWSOna8F
         Sp5gro8X/z7WH0/h0bns/01hZf96UHpF/toQEbELjQNBq8TlOBuxhkkB+x8GtO1hcADO
         Rbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQMVyVqHgBWr9jrth3XGcb0oJTmc+ZSSOROdsenztjQ=;
        b=pq9q78psDF1HAYTA+XdJ9xOv87CymhRk6bZXxfHU22cZPFRoLXqy+DE+z/XxajNEAZ
         J2CjJLoWrGorOm15H9e4NPshzAHNTBmXda4vc17njPRRY+zSGXRtJzstvxVuccW7zN2P
         ScaSOEoSADwFdm3VCbCVvct1bn3coLO/Kaw2z2gq1HJNSdAu319Y7EbpCQWNUhKedFa4
         wv7tbG2HkevPZFKQhk/8NjZ+pXC0spgbFbXii8suBot6Ux2pK7XWmbOrGHdvXTDkApHm
         Ummi8MwfogmwxTkaNrgXmWPH6C792On9xTaR7cCZYwzTfbFGv12Iu9KWQDH0elaqcaOw
         QtPQ==
X-Gm-Message-State: AOAM530iHAxHt2pt/6yfl1wtIT0TvVJcS9CAo3WJJtH5skmBagGr8MzC
        WaTetS5npKNQo90tYkHoJjUk1w==
X-Google-Smtp-Source: ABdhPJwoYdXx8akupLRzTqMljKIUVeJymrNlpE7RVAeYS77j644kQJr6ac3Xa8fscPzbbEsY7SxgMg==
X-Received: by 2002:a5d:6843:0:b0:20a:def2:5545 with SMTP id o3-20020a5d6843000000b0020adef25545mr27456759wrw.89.1652358282399;
        Thu, 12 May 2022 05:24:42 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:42 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v6 5/7] thermal: mediatek: Add thermal zone settings for mt8195
Date:   Thu, 12 May 2022 14:24:31 +0200
Message-Id: <20220512122433.1399802-6-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add thermal zone settings for mt8195

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/mediatek/soc_temp_lvts.c | 206 +++++++++++++++++++++--
 1 file changed, 192 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
index 145ddd5fe409..1c83c4f9aa64 100644
--- a/drivers/thermal/mediatek/soc_temp_lvts.c
+++ b/drivers/thermal/mediatek/soc_temp_lvts.c
@@ -53,6 +53,7 @@
 
 #define CLOCK_26MHZ_CYCLE_NS	(38)
 #define BUS_ACCESS_US		(2)
+#define GOLDEN_TEMP_MAX		(62)
 
 #define FEATURE_DEVICE_AUTO_RCK	(BIT(0))
 #define FEATURE_CK26M_ACTIVE	(BIT(1))
@@ -549,21 +550,10 @@ static int prepare_calibration_data(struct lvts_data *lvts_data)
 	if (!cal_data->count_rc)
 		return -ENOMEM;
 
-	if (ops->efuse_to_cal_data)
+	if (ops->efuse_to_cal_data && !cal_data->use_fake_efuse)
 		ops->efuse_to_cal_data(lvts_data);
-
-	cal_data->use_fake_efuse = 1;
-	if (cal_data->golden_temp != 0) {
-		cal_data->use_fake_efuse = 0;
-	} else {
-		for (i = 0; i < lvts_data->num_sensor; i++) {
-			if (cal_data->count_r[i] != 0 ||
-			    cal_data->count_rc[i] != 0) {
-				cal_data->use_fake_efuse = 0;
-				break;
-			}
-		}
-	}
+	if (cal_data->golden_temp == 0 || cal_data->golden_temp > GOLDEN_TEMP_MAX)
+		cal_data->use_fake_efuse = 1;
 
 	if (cal_data->use_fake_efuse) {
 		/* It means all efuse data are equal to 0 */
@@ -1247,6 +1237,190 @@ static struct lvts_data mt6873_lvts_data = {
 	},
 };
 
+/*==================================================
+ * LVTS MT8195
+ *==================================================
+ */
+
+#define MT8195_NUM_LVTS (ARRAY_SIZE(mt8195_tc_settings))
+
+enum mt8195_lvts_domain {
+	MT8195_AP_DOMAIN,
+	MT8195_MCU_DOMAIN,
+	MT8195_NUM_DOMAIN
+};
+
+enum mt8195_lvts_sensor_enum {
+	MT8195_TS1_0,
+	MT8195_TS1_1,
+	MT8195_TS2_0,
+	MT8195_TS2_1,
+	MT8195_TS3_0,
+	MT8195_TS3_1,
+	MT8195_TS3_2,
+	MT8195_TS3_3,
+	MT8195_TS4_0,
+	MT8195_TS4_1,
+	MT8195_TS5_0,
+	MT8195_TS5_1,
+	MT8195_TS6_0,
+	MT8195_TS6_1,
+	MT8195_TS6_2,
+	MT8195_TS7_0,
+	MT8195_TS7_1,
+	MT8195_NUM_TS
+};
+
+static void mt8195_efuse_to_cal_data(struct lvts_data *lvts_data)
+{
+	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
+
+	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, 31, 24);
+	cal_data->count_r[MT8195_TS1_0] = GET_CAL_DATA_BITMASK(1, 23, 0);
+	cal_data->count_r[MT8195_TS1_1] = (GET_CAL_DATA_BITMASK(2, 15, 0) << 8) +
+					   GET_CAL_DATA_BITMASK(1, 31, 24);
+	cal_data->count_r[MT8195_TS2_0] = GET_CAL_DATA_BITMASK(3, 31, 8);
+	cal_data->count_r[MT8195_TS2_1] = GET_CAL_DATA_BITMASK(4, 23, 0);
+	cal_data->count_r[MT8195_TS3_0] = (GET_CAL_DATA_BITMASK(6, 7, 0) << 16) +
+					   GET_CAL_DATA_BITMASK(5, 31, 16);
+	cal_data->count_r[MT8195_TS3_1] = GET_CAL_DATA_BITMASK(6, 31, 8);
+	cal_data->count_r[MT8195_TS3_2] = GET_CAL_DATA_BITMASK(7, 23, 0);
+	cal_data->count_r[MT8195_TS3_3] = (GET_CAL_DATA_BITMASK(8, 15, 0) << 8) +
+					   GET_CAL_DATA_BITMASK(7, 31, 24);
+	cal_data->count_r[MT8195_TS4_0] = GET_CAL_DATA_BITMASK(9, 31, 8);
+	cal_data->count_r[MT8195_TS4_1] = GET_CAL_DATA_BITMASK(10, 23, 0);
+	cal_data->count_r[MT8195_TS5_0] = (GET_CAL_DATA_BITMASK(12, 7, 0) << 16) +
+					   GET_CAL_DATA_BITMASK(11, 31, 16);
+	cal_data->count_r[MT8195_TS5_1] = GET_CAL_DATA_BITMASK(12, 31, 8);
+	cal_data->count_r[MT8195_TS6_0] = (GET_CAL_DATA_BITMASK(14, 15, 0) << 8) +
+					   GET_CAL_DATA_BITMASK(13, 31, 24);
+	cal_data->count_r[MT8195_TS6_1] = (GET_CAL_DATA_BITMASK(15, 7, 0) << 16) +
+					   GET_CAL_DATA_BITMASK(14, 31, 16);
+	cal_data->count_r[MT8195_TS6_2] = GET_CAL_DATA_BITMASK(15, 31, 8);
+	cal_data->count_r[MT8195_TS7_0] = (GET_CAL_DATA_BITMASK(17, 15, 0) << 8) +
+					   GET_CAL_DATA_BITMASK(16, 31, 24);
+	cal_data->count_r[MT8195_TS7_1] = (GET_CAL_DATA_BITMASK(18, 7, 0) << 16) +
+					   GET_CAL_DATA_BITMASK(17, 31, 16);
+	cal_data->count_rc[MT8195_TS1_0] = (GET_CAL_DATA_BITMASK(3, 7, 0) << 16) +
+					    GET_CAL_DATA_BITMASK(2, 31, 16);
+	cal_data->count_rc[MT8195_TS2_0] = (GET_CAL_DATA_BITMASK(5, 15, 0) << 8) +
+					    GET_CAL_DATA_BITMASK(4, 31, 24);
+	cal_data->count_rc[MT8195_TS3_0] = (GET_CAL_DATA_BITMASK(9, 7, 0) << 16) +
+					    GET_CAL_DATA_BITMASK(8, 31, 16);
+	cal_data->count_rc[MT8195_TS4_0] = (GET_CAL_DATA_BITMASK(11, 15, 0) << 8) +
+					    GET_CAL_DATA_BITMASK(10, 31, 24);
+	cal_data->count_rc[MT8195_TS5_0] = GET_CAL_DATA_BITMASK(13, 23, 0);
+	cal_data->count_rc[MT8195_TS6_0] = GET_CAL_DATA_BITMASK(16, 23, 0);
+	cal_data->count_rc[MT8195_TS7_0] = GET_CAL_DATA_BITMASK(18, 31, 8);
+}
+
+static struct tc_settings mt8195_tc_settings[] = {
+	[0] = {
+		.domain_index = MT8195_MCU_DOMAIN,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS1_0, MT8195_TS1_1},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(3),
+	},
+	[1] = {
+		.domain_index = MT8195_MCU_DOMAIN,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS2_0, MT8195_TS2_1},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(4),
+	},
+	[2] = {
+		.domain_index = MT8195_MCU_DOMAIN,
+		.addr_offset = 0x200,
+		.num_sensor = 4,
+		.sensor_map = {MT8195_TS3_0, MT8195_TS3_1, MT8195_TS3_2, MT8195_TS3_3},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(5),
+	},
+	[3] = {
+		.domain_index = MT8195_AP_DOMAIN,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS4_0, MT8195_TS4_1},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(3),
+	},
+	[4] = {
+		.domain_index = MT8195_AP_DOMAIN,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS5_0, MT8195_TS5_1},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(4),
+	},
+	[5] = {
+		.domain_index = MT8195_AP_DOMAIN,
+		.addr_offset = 0x200,
+		.num_sensor = 3,
+		.sensor_map = {MT8195_TS6_0, MT8195_TS6_1, MT8195_TS6_2},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(5),
+	},
+	[6] = {
+		.domain_index = MT8195_AP_DOMAIN,
+		.addr_offset = 0x300,
+		.num_sensor = 2,
+		.sensor_map = {MT8195_TS7_0, MT8195_TS7_1},
+		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = 117000,
+		.irq_bit = BIT(6),
+	}
+};
+
+static struct lvts_data mt8195_lvts_data = {
+	.num_domain = MT8195_NUM_DOMAIN,
+	.num_tc = MT8195_NUM_LVTS,
+	.tc = mt8195_tc_settings,
+	.num_sensor = MT8195_NUM_TS,
+	.ops = {
+		.efuse_to_cal_data = mt8195_efuse_to_cal_data,
+		.device_enable_and_init = device_enable_and_init_v4,
+		.device_enable_auto_rck = device_enable_auto_rck_v4,
+		.device_read_count_rc_n = device_read_count_rc_n_v4,
+		.set_cal_data = set_calibration_data_v4,
+		.init_controller = init_controller_v4,
+	},
+	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
+	.num_efuse_addr = 22,
+	.num_efuse_block = 2,
+	.cal_data = {
+		.default_golden_temp = 50,
+		.default_count_r = 35000,
+		.default_count_rc = 2750,
+	},
+	.coeff = {
+		.a = -250460,
+		.b = 250460,
+	},
+};
+
 /*==================================================
  *==================================================
  * Support chips
@@ -1257,6 +1431,10 @@ static const struct of_device_id lvts_of_match[] = {
 		.compatible = "mediatek,mt6873-lvts",
 		.data = (void *)&mt6873_lvts_data,
 	},
+	{
+		.compatible = "mediatek,mt8195-lvts",
+		.data = (void *)&mt8195_lvts_data,
+	},
 	{
 	},
 };
-- 
2.35.1

