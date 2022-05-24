Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1107532D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiEXP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiEXP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:28:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323A703E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z15so2390471wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiZa6xk9MkUsy0kBV1AgKPR3/ZpYc0vk8ORsY9H10YQ=;
        b=a6pZyNQk1oLcpgXHQFlCdF82gbQ+jAFaGJS7ahHCWYosCtQFt9hMXTJ1Y1qDUf/9Di
         jJY0wgDr3LkG6kFEc6po4aQzKwta9MPI84Zomtj68ImxOZIOx1NoPaZhOIpuwiRAYj/p
         U/QJWQsNu2oO29aO3IHh/5w5s8m3RCCEFDQ81lS2gA/H66m5TMlRrtAqMqE9T47Ecwdg
         IoNBtr7VS2SNV9cgaXbohLFvS3nYCyw/jjtlw8FRMsWWLLOAD9Kkd10U1Vqfh4kmaUSJ
         VgsIAR4B1+HNYkfKg/ECBpCBSeF5YkCySY0gp/CxvorOGEhjXP/6HUMCvbSAzLUDEqLK
         LHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiZa6xk9MkUsy0kBV1AgKPR3/ZpYc0vk8ORsY9H10YQ=;
        b=opFGB5+wvaQcKw5f0OXEHhX5uDyNBDYtt+yXLiuqZIbiDM68X4TOXOe7Koo83pHNUl
         CcU+nvmTdwSsm/RdDC9VlNxOAEdi4K2aW8ewQd2cDZEjgvueLcFUKDbHmBX1Vu4ikZJk
         f9j5V694jvzqRZ9sEZJQHrTdbvrJ3X1V8kwZ0whmsQSWGt698SMWd8Zmk+WVNjlUMtEG
         pNZl7/wrQ6fZaHz/ebCaTzBGI2PL6g0UCq+b1RDbDcp1bFzZbf7KkexwE64+1X+3wltz
         6+TXVnt8ksnKt9W/7gZkMY9Z89aoVSqjOrJnE/SFpJzKG6tNldlJixTrCtTzfiwPyflm
         72RQ==
X-Gm-Message-State: AOAM532He8B8Qb6wuUKNe+DAYxFnpNFXcmz4uXr9/O5CWkLaj2WF/sqU
        NyL6DA1tyWPfcumBCpcl3Is0NQ==
X-Google-Smtp-Source: ABdhPJzwznNhzRnRJe9SBGSdROAKleFzJajsmTMMwtYuH0j8wO3fYlV5oMaRMTCRqlmUmpct/YYseA==
X-Received: by 2002:a5d:4e87:0:b0:20d:116f:2e2f with SMTP id e7-20020a5d4e87000000b0020d116f2e2fmr23581121wru.177.1653406088867;
        Tue, 24 May 2022 08:28:08 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:28:08 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Michael Kao <michael.kao@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v7 4/6] thermal: mediatek: Add thermal zone settings for mt8195
Date:   Tue, 24 May 2022 17:25:51 +0200
Message-Id: <20220524152552.246193-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152552.246193-1-abailon@baylibre.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/mediatek/soc_temp_lvts.c | 201 +++++++++++++++++++++--
 1 file changed, 187 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
index 4b8c4c419f8e..c77c045d2599 100644
--- a/drivers/thermal/mediatek/soc_temp_lvts.c
+++ b/drivers/thermal/mediatek/soc_temp_lvts.c
@@ -49,6 +49,7 @@
 
 #define CLOCK_26MHZ_CYCLE_NS	(38)
 #define BUS_ACCESS_US		(2)
+#define GOLDEN_TEMP_MAX		(62)
 
 #define FEATURE_DEVICE_AUTO_RCK	(BIT(0))
 #define FEATURE_CK26M_ACTIVE	(BIT(1))
@@ -544,21 +545,10 @@ static int prepare_calibration_data(struct lvts_data *lvts_data)
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
@@ -1233,11 +1223,194 @@ static const struct lvts_data mt8192_lvts_data = {
 	},
 };
 
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
+static const struct tc_settings mt8195_tc_settings[] = {
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
+static const struct lvts_data mt8195_lvts_data = {
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
 static const struct of_device_id lvts_of_match[] = {
 	{
 		.compatible = "mediatek,mt8192-lvts",
 		.data = (void *)&mt8192_lvts_data,
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

