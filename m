Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0135814A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiGZN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbiGZNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:55:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8742BC88
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso5619202wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CZBmbwDCXgNLdGpaOHynEyzE4pnUpEsKD255mYPzmA=;
        b=KMf0lK6d2t7GZK4KC9sAyDRiAjUIRZ076dLLBQOnc4nigBLWdkG6c8go80moNYZOZM
         rbGvhMRVNQOOpNkOClUsVYKdKEEvjgCMnPNvxVxBE8zIADSdqcAWWbA9iwzy/1WmsA9u
         wVv8idsgr2KxCnpKdcCj6lm5oVnpHkvfzAbulhlyLQL2c+sIMTszC9ow7XRK1QSf6KFG
         TcWvuf57FKmG/l6eaBMCXHb77rpTHQAuOU04PXQGf9CzoM/aD/E0blKTB19LZaUabFZ6
         y5qzBVAQaXGNiEws1gDNtRjQtmG+F9fBhuCF2xDuRmjgqLefhNPOhF7gpoLY5OulunS5
         Vrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CZBmbwDCXgNLdGpaOHynEyzE4pnUpEsKD255mYPzmA=;
        b=XoP/oASVPJ+F0pcnZSbE+s7uVKo6zGPfUhdhO5uvdCaNCoHt2cmr/pdSoRLUKfE7dX
         iwUIGhWzpfpQu+Ue5jNnA58eE76eE/3rs0kVoO2yNqVCEq7S6b7rZKjBb2DAzReN/P3p
         woXu/1o1O/6UgJJULV4FGUpZbrlP4iPopTwdD6jNUzTX+4YCNzjzqRu0XG0DLuNxU+lc
         HVd/oHVnYk/mOSFQEo1Sw+/+L4F++bYE70O3GV3i0wclP4VeU2JhulSv7YEhk1LIMnzR
         5kDtCBbJRbVrtWyalISH/RmjI/ZBFbf5V4ghrv0nS8gO5L9T4m2k01WgRlI31pO5lpxl
         /W+w==
X-Gm-Message-State: AJIora+OM6l/sQYCH9MQOy3hSY2lekOYjJw+h58c8tSx3o68/CZIBOq2
        5UB6hhtHakvfLW808MOYNQx6OQ==
X-Google-Smtp-Source: AGRyM1sb99neA7rUNjtoz+9t6fgPqvS/VA2p8n6nk7h8PnseEo62uflNSjE7wVP9pR7dscQi/9ruzA==
X-Received: by 2002:a05:600c:3d93:b0:3a3:3a93:fb16 with SMTP id bi19-20020a05600c3d9300b003a33a93fb16mr16802518wmb.190.1658843719936;
        Tue, 26 Jul 2022 06:55:19 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:19 -0700 (PDT)
From:   Balsam CHIHI <bchihi@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8 3/6] thermal: mediatek: Add LVTS drivers for SoC theraml zones for mt8192
Date:   Tue, 26 Jul 2022 15:55:03 +0200
Message-Id: <20220726135506.485108-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726135506.485108-1-bchihi@baylibre.com>
References: <20220726135506.485108-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a LVTS (Low voltage thermal sensor) driver to report junction
temperatures in Mediatek SoC mt8192 and register the maximum temperature
of sensors and each sensor as a thermal zone.

Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/Kconfig         |  27 +
 drivers/thermal/mediatek/Makefile        |   2 +
 drivers/thermal/mediatek/lvts_mt8192.c   | 241 ++++++
 drivers/thermal/mediatek/soc_temp.c      |   2 +-
 drivers/thermal/mediatek/soc_temp_lvts.c | 928 +++++++++++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.h | 365 +++++++++
 6 files changed, 1564 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/mediatek/lvts_mt8192.c
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h

diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
index 9c41e9079fc3..7fc04237dd50 100644
--- a/drivers/thermal/mediatek/Kconfig
+++ b/drivers/thermal/mediatek/Kconfig
@@ -20,4 +20,31 @@ config MTK_SOC_THERMAL
 		configures thermal controllers to collect temperature
 		via AUXADC interface.
 
+config MTK_SOC_THERMAL_LVTS
+	tristate "LVTS (Low voltage thermal sensor) driver for Mediatek SoCs"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_TI_SYSCON
+	help
+		Enable this option if you want to get SoC temperature
+		information for MediaTek platforms. This driver
+		configures LVTS thermal controllers to collect temperatures
+		via Analog Serial Interface(ASIF).
+
+endif
+
+if MTK_SOC_THERMAL_LVTS
+
+config LVTS_MT8192
+	tristate "LVTS driver for MediaTek MT8192 SoC"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_TI_SYSCON
+	depends on MTK_SOC_THERMAL_LVTS
+	help
+		Enable this option if you want to get SoC temperature
+		information for MT8192. This driver
+		configures LVTS thermal controllers to collect temperatures
+		via ASIF.
+
 endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
index 4b4cb04a358f..5ff1197e80ab 100644
--- a/drivers/thermal/mediatek/Makefile
+++ b/drivers/thermal/mediatek/Makefile
@@ -1 +1,3 @@
 obj-$(CONFIG_MTK_SOC_THERMAL)		+= soc_temp.o
+obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)	+= soc_temp_lvts.o
+obj-$(CONFIG_LVTS_MT8192)			+= lvts_mt8192.o
diff --git a/drivers/thermal/mediatek/lvts_mt8192.c b/drivers/thermal/mediatek/lvts_mt8192.c
new file mode 100644
index 000000000000..19e4e82c410b
--- /dev/null
+++ b/drivers/thermal/mediatek/lvts_mt8192.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include "soc_temp_lvts.h"
+
+enum mt8192_lvts_mcu_sensor_enum {
+	MT8192_TS1_0,
+	MT8192_TS1_1,
+	MT8192_TS2_0,
+	MT8192_TS2_1,
+	MT8192_TS3_0,
+	MT8192_TS3_1,
+	MT8192_TS3_2,
+	MT8192_TS3_3,
+	MT8192_NUM_TS_MCU
+};
+
+enum mt8192_lvts_ap_sensor_enum {
+	MT8192_TS4_0,
+	MT8192_TS4_1,
+	MT8192_TS5_0,
+	MT8192_TS5_1,
+	MT8192_TS6_0,
+	MT8192_TS6_1,
+	MT8192_TS7_0,
+	MT8192_TS7_1,
+	MT8192_TS7_2,
+	MT8192_NUM_TS_AP
+};
+
+static void mt8192_mcu_efuse_to_cal_data(struct lvts_data *lvts_data)
+{
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+	unsigned int i, j;
+	const unsigned int mt8192_TS[] = {MT8192_TS2_0, MT8192_TS3_0};
+
+	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
+
+	for (i = 0; i < MT8192_NUM_TS_MCU; i++)
+		cal_data->count_r[i] = GET_CAL_DATA_BITMASK(i + 1, lvts_data, 23, 0);
+
+	cal_data->count_rc[MT8192_TS1_0] = GET_CAL_DATA_BITMASK(21, lvts_data, 23, 0);
+
+	for (i = 0; i < (ARRAY_SIZE(mt8192_TS)); i++) {
+		for (j = 1; j <= 18; j++) {
+			cal_data->count_rc[mt8192_TS[i]] = (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 16) +
+				(GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 8) +
+					GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24);
+		}
+	}
+}
+
+static void mt8192_ap_efuse_to_cal_data(struct lvts_data *lvts_data)
+{
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+	unsigned int i, j;
+	const unsigned int mt8192_TS[] = {MT8192_TS4_0, MT8192_TS5_0, MT8192_TS6_0, MT8192_TS7_0};
+
+	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
+
+	for (i = 0; i < MT8192_NUM_TS_AP; i++)
+		cal_data->count_r[i] = GET_CAL_DATA_BITMASK(i + 1, lvts_data, 23, 0);
+
+	for (i = 0; i < (ARRAY_SIZE(mt8192_TS)); i++) {
+		for (j = 1; j <= 18; j++) {
+			cal_data->count_rc[mt8192_TS[i]] = (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 16) +
+				(GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 8) +
+					GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24);
+		}
+	}
+}
+
+static struct lvts_speed_settings tc_speed_mt8192 = {
+	.period_unit = PERIOD_UNIT,
+	.group_interval_delay = GROUP_INTERVAL_DELAY,
+	.filter_interval_delay = FILTER_INTERVAL_DELAY,
+	.sensor_interval_delay = SENSOR_INTERVAL_DELAY,
+};
+
+static const struct lvts_tc_settings mt8192_tc_mcu_settings[] = {
+	[0] = {
+		.dev_id = 0x81,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = {MT8192_TS1_0, MT8192_TS1_1},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(3),
+	},
+	[1] = {
+		.dev_id = 0x82,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = {MT8192_TS2_0, MT8192_TS2_1},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(4),
+	},
+	[2] = {
+		.dev_id = 0x83,
+		.addr_offset = 0x200,
+		.num_sensor = 4,
+		.sensor_map = {MT8192_TS3_0, MT8192_TS3_1, MT8192_TS3_2, MT8192_TS3_3},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(5),
+	}
+};
+
+static const struct lvts_tc_settings mt8192_tc_ap_settings[] = {
+	[0] = {
+		.dev_id = 0x84,
+		.addr_offset = 0x0,
+		.num_sensor = 2,
+		.sensor_map = {MT8192_TS4_0, MT8192_TS4_1},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT0,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(3),
+	},
+	[1] = {
+		.dev_id = 0x85,
+		.addr_offset = 0x100,
+		.num_sensor = 2,
+		.sensor_map = {MT8192_TS5_0, MT8192_TS5_1},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(4),
+	},
+	[2] = {
+		.dev_id = 0x86,
+		.addr_offset = 0x200,
+		.num_sensor = 2,
+		.sensor_map = {MT8192_TS6_0, MT8192_TS6_1},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT1,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(5),
+	},
+	[3] = {
+		.dev_id = 0x87,
+		.addr_offset = 0x300,
+		.num_sensor = 3,
+		.sensor_map = {MT8192_TS7_0, MT8192_TS7_1, MT8192_TS7_2},
+		.tc_speed = &tc_speed_mt8192,
+		.hw_filter = LVTS_FILTER_2_OF_4,
+		.dominator_sensing_point = SENSING_POINT2,
+		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
+		.irq_bit = BIT(6),
+	}
+};
+
+static const struct lvts_data mt8192_lvts_mcu_data = {
+	.num_tc = (ARRAY_SIZE(mt8192_tc_mcu_settings)),
+	.tc = mt8192_tc_mcu_settings,
+	.num_sensor = MT8192_NUM_TS_MCU,
+	.ops = {
+		.efuse_to_cal_data = mt8192_mcu_efuse_to_cal_data,
+		.device_enable_and_init = lvts_device_enable_and_init_v4,
+		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
+		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
+		.set_cal_data = lvts_set_calibration_data_v4,
+		.init_controller = lvts_init_controller_v4,
+	},
+	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
+	.num_efuse_addr = NUM_EFUSE_ADDR,
+	.num_efuse_block = NUM_EFUSE_BLOCK_MT8192,
+	.cal_data = {
+		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
+		.default_count_r = DEFAULT_CUONT_R,
+		.default_count_rc = DEFAULT_CUONT_RC,
+	},
+	.coeff = {
+		.a = COEFF_A,
+		.b = COEFF_B,
+	},
+};
+
+static const struct lvts_data mt8192_lvts_ap_data = {
+	.num_tc = (ARRAY_SIZE(mt8192_tc_ap_settings)),
+	.tc = mt8192_tc_ap_settings,
+	.num_sensor = MT8192_NUM_TS_AP,
+	.ops = {
+		.efuse_to_cal_data = mt8192_ap_efuse_to_cal_data,
+		.device_enable_and_init = lvts_device_enable_and_init_v4,
+		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
+		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
+		.set_cal_data = lvts_set_calibration_data_v4,
+		.init_controller = lvts_init_controller_v4,
+	},
+	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
+	.num_efuse_addr = NUM_EFUSE_ADDR,
+	.num_efuse_block = NUM_EFUSE_BLOCK_MT8192,
+	.cal_data = {
+		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
+		.default_count_r = DEFAULT_CUONT_R,
+		.default_count_rc = DEFAULT_CUONT_RC,
+	},
+	.coeff = {
+		.a = COEFF_A,
+		.b = COEFF_B,
+	},
+};
+
+static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data, },
+	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lvts_of_match);
+
+static struct platform_driver soc_temp_lvts = {
+	.probe = lvts_probe,
+	.remove = lvts_remove,
+	.suspend = lvts_suspend,
+	.resume = lvts_resume,
+	.driver = {
+		.name = "mtk-soc-temp-lvts-mt8192",
+		.of_match_table = lvts_of_match,
+	},
+};
+module_platform_driver(soc_temp_lvts);
+
+MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
+MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek soc temperature driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/mediatek/soc_temp.c b/drivers/thermal/mediatek/soc_temp.c
index ede94eadddda..60924f8f98e9 100644
--- a/drivers/thermal/mediatek/soc_temp.c
+++ b/drivers/thermal/mediatek/soc_temp.c
@@ -23,7 +23,7 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
new file mode 100644
index 000000000000..ee7efc0de65f
--- /dev/null
+++ b/drivers/thermal/mediatek/soc_temp_lvts.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/thermal.h>
+#include "soc_temp_lvts.h"
+
+static int lvts_raw_to_temp(struct lvts_formula_coeff *co, unsigned int msr_raw)
+{
+	/* This function returns degree mC */
+
+	int temp;
+
+	temp = (co->a * ((unsigned long long)msr_raw)) >> 14;
+	temp = temp + co->golden_temp * 500 + co->b;
+
+	return temp;
+}
+
+static unsigned int lvts_temp_to_raw(struct lvts_formula_coeff *co, int temp)
+{
+	unsigned int msr_raw;
+
+	msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14,
+		(-1 * co->a));
+
+	return msr_raw;
+}
+
+static int soc_temp_lvts_read_temp(void *data, int *temperature)
+{
+	struct soc_temp_tz *lvts_tz = (struct soc_temp_tz *)data;
+	struct lvts_data *lvts_data = lvts_tz->lvts_data;
+	unsigned int msr_raw;
+
+	msr_raw = readl(lvts_data->reg[lvts_tz->id]) & MRS_RAW_MASK;
+	if (msr_raw == 0)
+		return -EINVAL;
+
+	*temperature = lvts_raw_to_temp(&lvts_data->coeff, msr_raw);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops soc_temp_lvts_ops = {
+	.get_temp = soc_temp_lvts_read_temp,
+};
+
+static void lvts_write_device(struct lvts_data *lvts_data, unsigned int data,
+	int tc_id)
+{
+	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
+
+	writel(DEVICE_WRITE | data, LVTS_CONFIG_0 + base);
+
+	usleep_range(5, 15);
+}
+
+static unsigned int lvts_read_device(struct lvts_data *lvts_data,
+	unsigned int reg_idx, int tc_id)
+{
+	struct device *dev = lvts_data->dev;
+	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
+	unsigned int data;
+	int ret;
+
+	writel(READ_DEVICE_REG(reg_idx), LVTS_CONFIG_0 + base);
+
+	usleep_range(5, 15);
+
+	ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
+		!(data & DEVICE_ACCESS_STARTUS), 2, 200);
+	if (ret)
+		dev_err(dev,
+			"Error: LVTS %d DEVICE_ACCESS_START is not ready\n", tc_id);
+
+	data = readl(LVTSRDATA0_0 + base);
+
+	return data;
+}
+
+static const char * const lvts_error_table[] = {"IDLE", "Write transaction",
+	"Waiting for read after Write", "Disable Continue fetching on Device",
+	"Read transaction", "Set Device special Register for Voltage threshold",
+	"Set TSMCU number for Fetch"};
+
+static void wait_all_tc_sensing_point_idle(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	unsigned int mask, error_code, is_error;
+	void __iomem *base;
+	int i, cnt, ret;
+
+	mask = BIT(10) | BIT(7) | BIT(0);
+
+	for (cnt = 0; cnt < 2; cnt++) {
+		is_error = 0;
+		for (i = 0; i < lvts_data->num_tc; i++) {
+			base = GET_BASE_ADDR(lvts_data, i);
+			ret = readl_poll_timeout(LVTSMSRCTL1_0 + base, error_code,
+						 !(error_code & mask), 2, 200);
+
+			error_code = ((error_code & BIT(10)) >> 8) +
+				((error_code & BIT(7)) >> 6) +
+				(error_code & BIT(0));
+
+			if (ret)
+				dev_err(dev, "LVTS %d error: %s\n",
+					i, lvts_error_table[error_code]);
+
+			if (error_code != 0)
+				is_error = 1;
+		}
+
+		if (is_error == 0)
+			break;
+	}
+}
+
+static void lvts_reset(struct lvts_data *lvts_data)
+{
+	if (lvts_data->reset)
+		reset_control_assert(lvts_data->reset);
+	if (lvts_data->reset)
+		reset_control_deassert(lvts_data->reset);
+}
+
+static void device_identification(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	unsigned int i, data;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+
+		writel(ENABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
+		lvts_write_device(lvts_data, RESET_ALL_DEVICES, i);
+		writel(READ_BACK_DEVICE_ID, LVTS_CONFIG_0 + base);
+
+		usleep_range(5, 15);
+
+		/* Check LVTS device ID */
+		data = (readl(LVTS_ID_0 + base) & DEVICE_REG_DATA);
+		if (data != (lvts_data->tc->dev_id + i))
+			dev_err(dev, "LVTS_TC_%d, Device ID should be 0x%x, but 0x%x\n",
+				i, (lvts_data->tc->dev_id + i), data);
+	}
+}
+
+static void disable_all_sensing_points(struct lvts_data *lvts_data)
+{
+	unsigned int i;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+		writel(DISABLE_SENSING_POINT, LVTSMONCTL0_0 + base);
+	}
+}
+
+static void enable_all_sensing_points(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	unsigned int i, num;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+		num = tc[i].num_sensor;
+
+		if (num > ALL_SENSING_POINTS) {
+			dev_err(dev,
+				"%s, LVTS%d, illegal number of sensors: %d\n",
+				__func__, i, tc[i].num_sensor);
+			continue;
+		}
+
+		writel(ENABLE_SENSING_POINT(num), LVTSMONCTL0_0 + base);
+	}
+}
+
+static void set_polling_speed(struct lvts_data *lvts_data, int tc_id)
+{
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	unsigned int lvts_mon_ctl_1, lvts_mon_ctl_2;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+
+	lvts_mon_ctl_1 = ((tc[tc_id].tc_speed->group_interval_delay << 20) & GENMASK(29, 20)) |
+		(tc[tc_id].tc_speed->period_unit & GENMASK(9, 0));
+	lvts_mon_ctl_2 = ((tc[tc_id].tc_speed->filter_interval_delay << 16) & GENMASK(25, 16)) |
+		(tc[tc_id].tc_speed->sensor_interval_delay & GENMASK(9, 0));
+	/*
+	 * Clock source of LVTS thermal controller is 26MHz.
+	 * Period unit is a base for all interval delays
+	 * All interval delays must multiply it to convert a setting to time.
+	 * Filter interval delay is a delay between two samples of the same sensor
+	 * Sensor interval delay is a delay between two samples of differnet sensors
+	 * Group interval delay is a delay between different rounds.
+	 * For example:
+	 *     If Period unit = C, filter delay = 1, sensor delay = 2, group delay = 1,
+	 *     and two sensors, TS1 and TS2, are in a LVTS thermal controller
+	 *     and then
+	 *     Period unit = C * 1/26M * 256 = 12 * 38.46ns * 256 = 118.149us
+	 *     Filter interval delay = 1 * Period unit = 118.149us
+	 *     Sensor interval delay = 2 * Period unit = 236.298us
+	 *     Group interval delay = 1 * Period unit = 118.149us
+	 *
+	 *     TS1    TS1 ... TS1    TS2    TS2 ... TS2    TS1...
+	 *        <--> Filter interval delay
+	 *                       <--> Sensor interval delay
+	 *                                             <--> Group interval delay
+	 */
+	writel(lvts_mon_ctl_1, LVTSMONCTL1_0 + base);
+	writel(lvts_mon_ctl_2, LVTSMONCTL2_0 + base);
+
+	dev_dbg(dev, "LVTS_TC_%d, LVTSMONCTL1_0= 0x%x, LVTSMONCTL2_0= 0x%x\n",
+		 tc_id, readl(LVTSMONCTL1_0 + base),
+		 readl(LVTSMONCTL2_0 + base));
+}
+
+static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
+{
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	unsigned int option;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+	option = tc[tc_id].hw_filter & 0x7;
+	/*
+	 * hw filter
+	 * 000: Get one sample
+	 * 001: Get 2 samples and average them
+	 * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
+	 * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
+	 * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
+	 * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
+	 */
+	option = (option << 9) | (option << 6) | (option << 3) | option;
+
+	writel(option, LVTSMSRCTL0_0 + base);
+	dev_dbg(dev, "LVTS_TC_%d, LVTSMSRCTL0_0= 0x%x\n",
+		 tc_id, readl(LVTSMSRCTL0_0 + base));
+}
+
+static int get_dominator_index(struct lvts_data *lvts_data, int tc_id)
+{
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	int d_index;
+
+	if (tc[tc_id].dominator_sensing_point == ALL_SENSING_POINTS) {
+		d_index = ALL_SENSING_POINTS;
+	} else if (tc[tc_id].dominator_sensing_point <
+		tc[tc_id].num_sensor){
+		d_index = tc[tc_id].dominator_sensing_point;
+	} else {
+		dev_err(dev,
+			"Error: LVTS%d, dominator_sensing_point= %d should smaller than num_sensor= %d\n",
+			tc_id, tc[tc_id].dominator_sensing_point,
+			tc[tc_id].num_sensor);
+
+		dev_err(dev, "Use the sensing point 0 as the dominated sensor\n");
+		d_index = SENSING_POINT0;
+	}
+
+	return d_index;
+}
+
+static void disable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
+{
+	unsigned int temp;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+
+	/*
+	 * LVTS thermal controller has two interrupts for thermal HW reboot
+	 * One is for AP SW and the other is for RGU
+	 * The interrupt of AP SW can turn off by a bit of a register, but
+	 * the other for RGU cannot.
+	 * To prevent rebooting device accidentally, we are going to add
+	 * a huge offset to LVTS and make LVTS always report extremely low
+	 * temperature.
+	 */
+
+	/*
+	 * After adding the huge offset 0x3FFF, LVTS alawys adds the
+	 * offset to MSR_RAW.
+	 * When MSR_RAW is larger, SW will convert lower temperature/
+	 */
+	temp = readl(LVTSPROTCTL_0 + base);
+	writel(temp | 0x3FFF, LVTSPROTCTL_0 + base);
+
+	/* Disable the interrupt of AP SW */
+	temp = readl(LVTSMONINT_0 + base);
+	writel(temp & ~(STAGE3_INT_EN), LVTSMONINT_0 + base);
+}
+
+static void enable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
+{
+	unsigned int temp;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+
+	/* Enable the interrupt of AP SW */
+	temp = readl(LVTSMONINT_0 + base);
+	writel(temp | STAGE3_INT_EN, LVTSMONINT_0 + base);
+	/* Clear the offset */
+	temp = readl(LVTSPROTCTL_0 + base);
+	writel(temp & ~PROTOFFSET, LVTSPROTCTL_0 + base);
+}
+
+static void set_tc_hw_reboot_threshold(struct lvts_data *lvts_data,
+	int trip_point, int tc_id)
+{
+	struct device *dev = lvts_data->dev;
+	unsigned int msr_raw, temp, config, d_index;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+	d_index = get_dominator_index(lvts_data, tc_id);
+
+	dev_info(dev, "lvts_tc_%d: dominator sensing point = %d\n", tc_id, d_index);
+
+	disable_hw_reboot_interrupt(lvts_data, tc_id);
+
+	temp = readl(LVTSPROTCTL_0 + base);
+	if (d_index == ALL_SENSING_POINTS) {
+		/* Maximum of 4 sensing points */
+		config = (0x1 << 16);
+		writel(config | temp, LVTSPROTCTL_0 + base);
+	} else {
+		/* Select protection sensor */
+		config = ((d_index << 2) + 0x2) << 16;
+		writel(config | temp, LVTSPROTCTL_0 + base);
+	}
+
+	msr_raw = lvts_temp_to_raw(&lvts_data->coeff, trip_point);
+	writel(msr_raw, LVTSPROTTC_0 + base);
+
+	enable_hw_reboot_interrupt(lvts_data, tc_id);
+}
+
+static void set_all_tc_hw_reboot(struct lvts_data *lvts_data)
+{
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	int i, trip_point;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		trip_point = tc[i].hw_reboot_trip_point;
+
+		if (tc[i].num_sensor == 0)
+			continue;
+
+		if (trip_point == THERMAL_TEMP_INVALID)
+			continue;
+
+		set_tc_hw_reboot_threshold(lvts_data, trip_point, i);
+	}
+}
+
+static int lvts_init(struct lvts_data *lvts_data)
+{
+	struct platform_ops *ops = &lvts_data->ops;
+	struct device *dev = lvts_data->dev;
+	int ret;
+
+	ret = clk_prepare_enable(lvts_data->clk);
+	if (ret) {
+		dev_err(dev,
+			"Error: Failed to enable lvts controller clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	lvts_reset(lvts_data);
+
+	device_identification(lvts_data);
+	if (ops->device_enable_and_init)
+		ops->device_enable_and_init(lvts_data);
+
+	if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK)) {
+		if (ops->device_enable_auto_rck)
+			ops->device_enable_auto_rck(lvts_data);
+	} else {
+		if (ops->device_read_count_rc_n)
+			ops->device_read_count_rc_n(lvts_data);
+	}
+
+	if (ops->set_cal_data)
+		ops->set_cal_data(lvts_data);
+
+	disable_all_sensing_points(lvts_data);
+	wait_all_tc_sensing_point_idle(lvts_data);
+	if (ops->init_controller)
+		ops->init_controller(lvts_data);
+	enable_all_sensing_points(lvts_data);
+
+	set_all_tc_hw_reboot(lvts_data);
+
+	return 0;
+}
+
+static int prepare_calibration_data(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+	struct platform_ops *ops = &lvts_data->ops;
+	int i, offset;
+	char buffer[512];
+
+	cal_data->count_r = devm_kcalloc(dev, lvts_data->num_sensor,
+		sizeof(*cal_data->count_r), GFP_KERNEL);
+	if (!cal_data->count_r)
+		return -ENOMEM;
+
+	cal_data->count_rc = devm_kcalloc(dev, lvts_data->num_sensor,
+		sizeof(*cal_data->count_rc), GFP_KERNEL);
+	if (!cal_data->count_rc)
+		return -ENOMEM;
+
+	if (ops->efuse_to_cal_data && !cal_data->use_fake_efuse)
+		ops->efuse_to_cal_data(lvts_data);
+	if (cal_data->golden_temp == 0 || cal_data->golden_temp > GOLDEN_TEMP_MAX)
+		cal_data->use_fake_efuse = 1;
+
+	if (cal_data->use_fake_efuse) {
+		/* It means all efuse data are equal to 0 */
+		dev_err(dev,
+			"%s: This sample is not calibrated, fake !!\n", __func__);
+
+		cal_data->golden_temp = cal_data->default_golden_temp;
+		for (i = 0; i < lvts_data->num_sensor; i++) {
+			cal_data->count_r[i] = cal_data->default_count_r;
+			cal_data->count_rc[i] = cal_data->default_count_rc;
+		}
+	}
+
+	lvts_data->coeff.golden_temp = cal_data->golden_temp;
+
+	dev_dbg(dev, "golden_temp = %d\n", cal_data->golden_temp);
+
+	offset = snprintf(buffer, sizeof(buffer), "[lvts_cal] num:g_count:g_count_rc ");
+	for (i = 0; i < lvts_data->num_sensor; i++)
+		offset += snprintf(buffer + offset, sizeof(buffer) - offset, "%d:%d:%d ",
+			i, cal_data->count_r[i], cal_data->count_rc[i]);
+
+	buffer[offset] = '\0';
+
+	return 0;
+}
+
+static int get_calibration_data(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	char cell_name[32];
+	struct nvmem_cell *cell;
+	u32 *buf;
+	size_t len;
+	int i, j, index = 0, ret;
+
+	lvts_data->efuse = devm_kcalloc(dev, lvts_data->num_efuse_addr,
+					sizeof(*lvts_data->efuse), GFP_KERNEL);
+	if (!lvts_data->efuse)
+		return -ENOMEM;
+
+	for (i = 0; i < lvts_data->num_efuse_block; i++) {
+		snprintf(cell_name, sizeof(cell_name), "lvts_calib_data%d", i + 1);
+		cell = nvmem_cell_get(dev, cell_name);
+		if (IS_ERR(cell)) {
+			dev_err(dev, "Error: Failed to get nvmem cell %s\n", cell_name);
+			return PTR_ERR(cell);
+		}
+
+		buf = (u32 *)nvmem_cell_read(cell, &len);
+		nvmem_cell_put(cell);
+
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
+
+		for (j = 0; j < (len / sizeof(u32)); j++) {
+			if (index >= lvts_data->num_efuse_addr) {
+				dev_err(dev, "Array efuse is going to overflow");
+				kfree(buf);
+				return -EINVAL;
+			}
+
+			lvts_data->efuse[index] = buf[j];
+			index++;
+		}
+
+		kfree(buf);
+	}
+
+	ret = prepare_calibration_data(lvts_data);
+
+	return ret;
+}
+
+static int lvts_init_tc_regs(struct device *dev, struct lvts_data *lvts_data)
+{
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	unsigned int i, j, s_index;
+	void __iomem *base;
+
+	lvts_data->reg = devm_kcalloc(dev, lvts_data->num_sensor,
+		sizeof(*lvts_data->reg), GFP_KERNEL);
+	if (!lvts_data->reg)
+		return -ENOMEM;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+		for (j = 0; j < tc[i].num_sensor; j++) {
+			s_index = tc[i].sensor_map[j];
+			lvts_data->reg[s_index] = LVTSMSR0_0 + base + 0x4 * j;
+		}
+	}
+
+	return 0;
+}
+
+static int of_update_lvts_data(struct lvts_data *lvts_data,
+	struct platform_device *pdev)
+{
+	struct device *dev = lvts_data->dev;
+	struct resource *res;
+	int ret;
+
+	lvts_data->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(lvts_data->clk))
+		return PTR_ERR(lvts_data->clk);
+
+	/* Get base address */
+	res = platform_get_mem_or_io(pdev, 0);
+	if (!res) {
+		dev_err(dev, "No IO resource\n");
+		return -ENXIO;
+	}
+
+	lvts_data->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lvts_data->base)) {
+		dev_err(dev, "Failed to remap io\n");
+		return PTR_ERR(lvts_data->base);
+	}
+
+	/* Get interrupt number */
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "No irq resource\n");
+		return -EINVAL;
+	}
+	lvts_data->irq_num = ret;
+
+	/* Get reset control */
+	lvts_data->reset = devm_reset_control_get_by_index(dev, 0);
+	if (IS_ERR(lvts_data->reset)) {
+		dev_err(dev, "Failed to get reset control\n");
+		return PTR_ERR(lvts_data->reset);
+	}
+
+	ret = lvts_init_tc_regs(dev, lvts_data);
+	if (ret)
+		return ret;
+
+	ret = get_calibration_data(lvts_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void lvts_device_close(struct lvts_data *lvts_data)
+{
+	unsigned int i;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+		lvts_write_device(lvts_data, RESET_ALL_DEVICES, i);
+		writel(DISABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
+	}
+}
+
+static void lvts_close(struct lvts_data *lvts_data)
+{
+	disable_all_sensing_points(lvts_data);
+	wait_all_tc_sensing_point_idle(lvts_data);
+	lvts_device_close(lvts_data);
+	clk_disable_unprepare(lvts_data->clk);
+}
+
+static void tc_irq_handler(struct lvts_data *lvts_data, int tc_id)
+{
+	const struct device *dev = lvts_data->dev;
+	unsigned int ret = 0;
+	void __iomem *base;
+
+	base = GET_BASE_ADDR(lvts_data, tc_id);
+
+	ret = readl(LVTSMONINTSTS_0 + base);
+	/* Write back to clear interrupt status */
+	writel(ret, LVTSMONINTSTS_0 + base);
+
+	dev_dbg(dev, "LVTS thermal controller %d, LVTSMONINTSTS=0x%08x\n", tc_id, ret);
+
+	if (ret & THERMAL_PROTECTION_STAGE_3)
+		dev_dbg(dev, "Thermal protection stage 3 interrupt triggered\n");
+}
+
+static irqreturn_t irq_handler(int irq, void *dev_id)
+{
+	struct lvts_data *lvts_data = (struct lvts_data *)dev_id;
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	unsigned int i, *irq_bitmap;
+	void __iomem *base;
+
+	irq_bitmap = kcalloc(1, sizeof(*irq_bitmap), GFP_ATOMIC);
+
+	if (!irq_bitmap)
+		return IRQ_NONE;
+
+	base = lvts_data->base;
+	*irq_bitmap = readl(THERMINTST + base);
+	dev_dbg(dev, "THERMINTST = 0x%x\n", *irq_bitmap);
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		if (tc[i].irq_bit == 0)
+			tc_irq_handler(lvts_data, i);
+	}
+
+	kfree(irq_bitmap);
+
+	return IRQ_HANDLED;
+}
+
+static int lvts_register_irq_handler(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	int ret;
+
+	ret = devm_request_irq(dev, lvts_data->irq_num, irq_handler,
+		IRQF_TRIGGER_HIGH, "mtk_lvts", lvts_data);
+
+	if (ret) {
+		dev_err(dev, "Failed to register LVTS IRQ, ret %d, irq_num %d\n",
+			ret, lvts_data->irq_num);
+		lvts_close(lvts_data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lvts_register_thermal_zones(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	struct thermal_zone_device *tzdev;
+	struct soc_temp_tz *lvts_tz;
+	int i, ret;
+
+	for (i = 0; i < lvts_data->num_sensor; i++) {
+		lvts_tz = devm_kzalloc(dev, sizeof(*lvts_tz), GFP_KERNEL);
+		if (!lvts_tz) {
+			lvts_close(lvts_data);
+			return -ENOMEM;
+		}
+
+		lvts_tz->id = i;
+		lvts_tz->lvts_data = lvts_data;
+
+		tzdev = devm_thermal_zone_of_sensor_register(dev, lvts_tz->id,
+			lvts_tz, &soc_temp_lvts_ops);
+
+		if (IS_ERR(tzdev)) {
+			if (lvts_tz->id != 0)
+				return 0;
+
+			ret = PTR_ERR(tzdev);
+			dev_err(dev, "Error: Failed to register lvts tz %d, ret = %d\n",
+				lvts_tz->id, ret);
+			lvts_close(lvts_data);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void lvts_device_enable_and_init_v4(struct lvts_data *lvts_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		lvts_write_device(lvts_data, STOP_COUNTING_V4, i);
+		lvts_write_device(lvts_data, SET_RG_TSFM_LPDLY_V4, i);
+		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US1_V4, i);
+		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US2_V4, i);
+		lvts_write_device(lvts_data, TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4, i);
+		lvts_write_device(lvts_data, TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4, i);
+		lvts_write_device(lvts_data, SET_TS_RSV_V4, i);
+		lvts_write_device(lvts_data, SET_TS_EN_V4, i);
+		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST1_V4, i);
+		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST2_V4, i);
+	}
+
+	lvts_data->counting_window_us = 20;
+}
+EXPORT_SYMBOL_GPL(lvts_device_enable_and_init_v4);
+
+void lvts_device_enable_auto_rck_v4(struct lvts_data *lvts_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < lvts_data->num_tc; i++)
+		lvts_write_device(lvts_data, SET_LVTS_AUTO_RCK_V4, i);
+}
+EXPORT_SYMBOL_GPL(lvts_device_enable_auto_rck_v4);
+
+int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data)
+{
+	/* Resistor-Capacitor Calibration */
+	/* count_RC_N: count RC now */
+	struct device *dev = lvts_data->dev;
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+	unsigned int offset, size, s_index, data;
+	void __iomem *base;
+	int ret, i, j;
+	char buffer[512];
+
+	cal_data->count_rc_now = devm_kcalloc(dev, lvts_data->num_sensor,
+		sizeof(*cal_data->count_rc_now), GFP_KERNEL);
+	if (!cal_data->count_rc_now)
+		return -ENOMEM;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+		for (j = 0; j < tc[i].num_sensor; j++) {
+			s_index = tc[i].sensor_map[j];
+
+			lvts_write_device(lvts_data, SELECT_SENSOR_RCK_V4(j), i);
+			lvts_write_device(lvts_data, SET_DEVICE_SINGLE_MODE_V4, i);
+			usleep_range(10, 20);
+
+			lvts_write_device(lvts_data, KICK_OFF_RCK_COUNTING_V4, i);
+			usleep_range(30, 40);
+
+			ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
+						 !(data & DEVICE_SENSING_STATUS), 2, 200);
+			if (ret)
+				dev_err(dev,
+					"Error: LVTS %d DEVICE_SENSING_STATUS didn't ready\n", i);
+
+			data = lvts_read_device(lvts_data, 0x00, i);
+
+			cal_data->count_rc_now[s_index] = (data & GENMASK(23, 0));
+		}
+
+		/* Recover Setting for Normal Access on
+		 * temperature fetch
+		 */
+		lvts_write_device(lvts_data, SET_SENSOR_NO_RCK_V4, i);
+		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
+	}
+
+	size = sizeof(buffer);
+	offset = snprintf(buffer, size, "[COUNT_RC_NOW] ");
+	for (i = 0; i < lvts_data->num_sensor; i++)
+		offset += snprintf(buffer + offset, size - offset, "%d:%d ",
+			i, cal_data->count_rc_now[i]);
+
+	buffer[offset] = '\0';
+	dev_dbg(dev, "%s\n", buffer);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lvts_device_read_count_rc_n_v4);
+
+void lvts_set_calibration_data_v4(struct lvts_data *lvts_data)
+{
+	const struct lvts_tc_settings *tc = lvts_data->tc;
+	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
+	unsigned int i, j, s_index, lvts_calib_data;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+
+		for (j = 0; j < tc[i].num_sensor; j++) {
+			s_index = tc[i].sensor_map[j];
+			if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK))
+				lvts_calib_data = cal_data->count_r[s_index];
+			else
+				lvts_calib_data = (((unsigned long long)
+					cal_data->count_rc_now[s_index]) *
+					cal_data->count_r[s_index]) >> 14;
+
+			writel(lvts_calib_data, LVTSEDATA00_0 + base + 0x4 * j);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(lvts_set_calibration_data_v4);
+
+void lvts_init_controller_v4(struct lvts_data *lvts_data)
+{
+	struct device *dev = lvts_data->dev;
+	unsigned int i;
+	void __iomem *base;
+
+	for (i = 0; i < lvts_data->num_tc; i++) {
+		base = GET_BASE_ADDR(lvts_data, i);
+
+		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
+
+		writel(SET_SENSOR_INDEX, LVTSTSSEL_0 + base);
+		writel(SET_CALC_SCALE_RULES, LVTSCALSCALE_0 + base);
+
+		set_polling_speed(lvts_data, i);
+		set_hw_filter(lvts_data, i);
+
+		dev_info(dev, "lvts_tc_%d: read all %d sensors in %d us, one in %d us\n",
+			i, GET_TC_SENSOR_NUM(lvts_data, i), GROUP_LATENCY_US(i), SENSOR_LATENCY_US(i));
+	}
+}
+EXPORT_SYMBOL_GPL(lvts_init_controller_v4);
+
+int lvts_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lvts_data *lvts_data;
+	int ret;
+
+	lvts_data = (struct lvts_data *)of_device_get_match_data(dev);
+
+	if (!lvts_data)	{
+		dev_err(dev, "Error: Failed to get lvts platform data\n");
+		return -ENODATA;
+	}
+
+	lvts_data->dev = &pdev->dev;
+
+	ret = of_update_lvts_data(lvts_data, pdev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, lvts_data);
+
+	ret = lvts_init(lvts_data);
+	if (ret)
+		return ret;
+
+	ret = lvts_register_irq_handler(lvts_data);
+	if (ret)
+		return ret;
+
+	ret = lvts_register_thermal_zones(lvts_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int lvts_remove(struct platform_device *pdev)
+{
+	struct lvts_data *lvts_data;
+
+	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
+
+	lvts_close(lvts_data);
+
+	return 0;
+}
+
+int lvts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct lvts_data *lvts_data;
+
+	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
+
+	lvts_close(lvts_data);
+
+	return 0;
+}
+
+int lvts_resume(struct platform_device *pdev)
+{
+	int ret;
+	struct lvts_data *lvts_data;
+
+	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
+
+	ret = lvts_init(lvts_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
+MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek soc temperature driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/mediatek/soc_temp_lvts.h b/drivers/thermal/mediatek/soc_temp_lvts.h
new file mode 100644
index 000000000000..6f8b6e3af98c
--- /dev/null
+++ b/drivers/thermal/mediatek/soc_temp_lvts.h
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __MTK_SOC_TEMP_LVTS_H__
+#define __MTK_SOC_TEMP_LVTS_H__
+
+#define PERIOD_UNIT				12
+#define GROUP_INTERVAL_DELAY	1
+#define FILTER_INTERVAL_DELAY	1
+#define SENSOR_INTERVAL_DELAY	1
+
+#define HW_REBOOT_TRIP_POINT	117000
+
+#define FEATURE_DEVICE_AUTO_RCK	BIT(0)
+#define NUM_EFUSE_ADDR			22
+#define NUM_EFUSE_BLOCK_MT8192	1
+#define DEFAULT_GOLDEN_TEMP		50
+#define DEFAULT_CUONT_R			35000
+#define DEFAULT_CUONT_RC		2750
+#define COEFF_A					-250460
+#define COEFF_B					250460
+
+#define CLOCK_26MHZ_CYCLE_NS	38
+#define BUS_ACCESS_US			2
+#define GOLDEN_TEMP_MAX			62
+
+/* LVTS device register */
+#define RG_TSFM_DATA_0			0x00
+#define RG_TSFM_DATA_1			0x01
+#define RG_TSFM_DATA_2			0x02
+#define RG_TSFM_CTRL_0			0x03
+#define RG_TSFM_CTRL_1			0x04
+#define RG_TSFM_CTRL_2			0x05
+#define RG_TSFM_CTRL_3			0x06
+#define RG_TSFM_CTRL_4			0x07
+#define RG_TSV2F_CTRL_0			0x08
+#define RG_TSV2F_CTRL_1			0x09
+#define RG_TSV2F_CTRL_2			0x0A
+#define RG_TSV2F_CTRL_3			0x0B
+#define RG_TSV2F_CTRL_4			0x0C
+#define RG_TSV2F_CTRL_5			0x0D
+#define RG_TSV2F_CTRL_6			0x0E
+#define RG_TEMP_DATA_0			0x10
+#define RG_TEMP_DATA_1			0x11
+#define RG_TEMP_DATA_2			0x12
+#define RG_TEMP_DATA_3			0x13
+#define RG_RC_DATA_0			0x14
+#define RG_RC_DATA_1			0x15
+#define RG_RC_DATA_2			0x16
+#define RG_RC_DATA_3			0x17
+#define RG_DIV_DATA_0			0x18
+#define RG_DIV_DATA_1			0x19
+#define RG_DIV_DATA_2			0x1A
+#define RG_DIV_DATA_3			0x1B
+#define RG_TST_DATA_0			0x70
+#define RG_TST_DATA_1			0x71
+#define RG_TST_DATA_2			0x72
+#define RG_TST_CTRL				0x73
+#define RG_DBG_FQMTR			0xF0
+#define RG_DBG_LPSEQ			0xF1
+#define RG_DBG_STATE			0xF2
+#define RG_DBG_CHKSUM			0xF3
+#define RG_DID_LVTS				0xFC
+#define RG_DID_REV				0xFD
+#define RG_TSFM_RST				0xFF
+
+/* LVTS controller register */
+#define LVTSMONCTL0_0				0x000
+#define ENABLE_SENSING_POINT(num)	(LVTS_SINGLE_SENSE | GENMASK(((num) - 1), 0))
+#define DISABLE_SENSING_POINT		(LVTS_SINGLE_SENSE | 0x0)
+#define LVTSMONCTL1_0				0x004
+#define LVTSMONCTL2_0				0x008
+#define LVTSMONINT_0				0x00C
+#define STAGE3_INT_EN				BIT(31)
+#define LVTSMONINTSTS_0				0x010
+#define LVTSMONIDET0_0				0x014
+#define LVTSMONIDET1_0				0x018
+#define LVTSMONIDET2_0				0x01C
+#define LVTSMONIDET3_0				0x020
+#define LVTSH2NTHRE_0				0x024
+#define LVTSHTHRE_0					0x028
+#define LVTSCTHRE_0					0x02C
+#define LVTSOFFSETH_0				0x030
+#define LVTSOFFSETL_0				0x034
+#define LVTSMSRCTL0_0				0x038
+#define LVTSMSRCTL1_0				0x03C
+#define LVTSTSSEL_0					0x040
+#define SET_SENSOR_INDEX			0x13121110
+#define LVTSDEVICETO_0				0x044
+#define LVTSCALSCALE_0				0x048
+#define SET_CALC_SCALE_RULES		0x00000300
+#define LVTS_ID_0					0x04C
+#define LVTS_CONFIG_0				0x050
+
+#define SCK_ONLY					BIT(31)
+#define BROADCAST_ID_UPDATE			BIT(26)
+#define DEVICE_SENSING_STATUS		BIT(25)
+#define DEVICE_ACCESS_STARTUS		BIT(24)
+#define READ_32BIT_ACCESS			BIT(17)
+#define WRITE_ACCESS				BIT(16)
+#define LVTS_SINGLE_SENSE			BIT(9)
+#define FEATURE_CK26M_ACTIVE		BIT(1)
+#define DEVICE_REG_DATA				GENMASK(7, 0)
+
+#define LVTSEDATA00_0				0x054
+#define LVTSEDATA01_0				0x058
+#define LVTSEDATA02_0				0x05C
+#define LVTSEDATA03_0				0x060
+#define LVTSMSR0_0					0x090
+#define MRS_RAW_MASK				GENMASK(15, 0)
+#define MRS_RAW_VALID_BIT			BIT(16)
+#define LVTSMSR1_0					0x094
+#define LVTSMSR2_0					0x098
+#define LVTSMSR3_0					0x09C
+#define LVTSIMMD0_0					0x0A0
+#define LVTSIMMD1_0					0x0A4
+#define LVTSIMMD2_0					0x0A8
+#define LVTSIMMD3_0					0x0AC
+#define LVTSRDATA0_0				0x0B0
+#define LVTSRDATA1_0				0x0B4
+#define LVTSRDATA2_0				0x0B8
+#define LVTSRDATA3_0				0x0BC
+#define LVTSPROTCTL_0				0x0C0
+#define PROTOFFSET					GENMASK(15, 0)
+#define LVTSPROTTA_0				0x0C4
+#define LVTSPROTTB_0				0x0C8
+#define LVTSPROTTC_0				0x0CC
+#define LVTSCLKEN_0					0x0E4
+#define ENABLE_LVTS_CTRL_CLK		(1)
+#define DISABLE_LVTS_CTRL_CLK		(0)
+#define LVTSDBGSEL_0				0x0E8
+#define LVTSDBGSIG_0				0x0EC
+#define LVTSSPARE0_0				0x0F0
+#define LVTSSPARE1_0				0x0F4
+#define LVTSSPARE2_0				0x0F8
+#define LVTSSPARE3_0				0x0FC
+#define THERMINTST					0xF04
+
+/* LVTS register mask */
+#define THERMAL_COLD_INTERRUPT_0			BIT(0)
+#define THERMAL_HOT_INTERRUPT_0				BIT(1)
+#define THERMAL_LOW_OFFSET_INTERRUPT_0		BIT(2)
+#define THERMAL_HIGH_OFFSET_INTERRUPT_0		BIT(3)
+#define THERMAL_HOT2NORMAL_INTERRUPT_0		BIT(4)
+#define THERMAL_COLD_INTERRUPT_1			BIT(5)
+#define THERMAL_HOT_INTERRUPT_1				BIT(6)
+#define THERMAL_LOW_OFFSET_INTERRUPT_1		BIT(7)
+#define THERMAL_HIGH_OFFSET_INTERRUPT_1		BIT(8)
+#define THERMAL_HOT2NORMAL_INTERRUPT_1		BIT(9)
+#define THERMAL_COLD_INTERRUPT_2			BIT(10)
+#define THERMAL_HOT_INTERRUPT_2				BIT(11)
+#define THERMAL_LOW_OFFSET_INTERRUPT_2		BIT(12)
+#define THERMAL_HIGH_OFFSET_INTERRUPT_2		BIT(13)
+#define THERMAL_HOT2NORMAL_INTERRUPT_2		BIT(14)
+#define THERMAL_AHB_TIMEOUT_INTERRUPT		BIT(15)
+#define THERMAL_DEVICE_TIMEOUT_INTERRUPT	BIT(15)
+#define THERMAL_IMMEDIATE_INTERRUPT_0		BIT(16)
+#define THERMAL_IMMEDIATE_INTERRUPT_1		BIT(17)
+#define THERMAL_IMMEDIATE_INTERRUPT_2		BIT(18)
+#define THERMAL_FILTER_INTERRUPT_0			BIT(19)
+#define THERMAL_FILTER_INTERRUPT_1			BIT(20)
+#define THERMAL_FILTER_INTERRUPT_2			BIT(21)
+#define THERMAL_COLD_INTERRUPT_3			BIT(22)
+#define THERMAL_HOT_INTERRUPT_3				BIT(23)
+#define THERMAL_LOW_OFFSET_INTERRUPT_3		BIT(24)
+#define THERMAL_HIGH_OFFSET_INTERRUPT_3		BIT(25)
+#define THERMAL_HOT2NORMAL_INTERRUPT_3		BIT(26)
+#define THERMAL_IMMEDIATE_INTERRUPT_3		BIT(27)
+#define THERMAL_FILTER_INTERRUPT_3			BIT(28)
+#define THERMAL_PROTECTION_STAGE_1			BIT(29)
+#define THERMAL_PROTECTION_STAGE_2			BIT(30)
+#define THERMAL_PROTECTION_STAGE_3			BIT(31)
+
+#define CFG_REGISTER(reg, value)	(reg << 8 | value)
+#define STOP_COUNTING_V4					CFG_REGISTER(RG_TSFM_CTRL_0, 0x00)
+#define SET_RG_TSFM_LPDLY_V4				CFG_REGISTER(RG_TSFM_CTRL_4, 0xA6)
+#define SET_COUNTING_WINDOW_20US1_V4		CFG_REGISTER(RG_TSFM_CTRL_2, 0x00)
+#define SET_COUNTING_WINDOW_20US2_V4		CFG_REGISTER(RG_TSFM_CTRL_1, 0x20)
+#define TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4	CFG_REGISTER(RG_TSV2F_CTRL_2, 0x84)
+#define TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4	CFG_REGISTER(RG_TSV2F_CTRL_4, 0x7C)
+#define SET_TS_RSV_V4						CFG_REGISTER(RG_TSV2F_CTRL_1, 0x8D)
+#define SET_TS_EN_V4						CFG_REGISTER(RG_TSV2F_CTRL_0, 0xF4)
+#define TOGGLE_RG_TSV2F_VCO_RST1_V4			CFG_REGISTER(RG_TSV2F_CTRL_0, 0xFC)
+#define TOGGLE_RG_TSV2F_VCO_RST2_V4			CFG_REGISTER(RG_TSV2F_CTRL_0, 0xF4)
+
+#define SET_LVTS_AUTO_RCK_V4				CFG_REGISTER(RG_TSV2F_CTRL_6, 0x01)
+#define SELECT_SENSOR_RCK_V4(id)			CFG_REGISTER(RG_TSV2F_CTRL_5, (id))
+#define SET_DEVICE_SINGLE_MODE_V4			CFG_REGISTER(RG_TSFM_CTRL_3, 0x78)
+#define KICK_OFF_RCK_COUNTING_V4			CFG_REGISTER(RG_TSFM_CTRL_0, 0x02)
+#define SET_SENSOR_NO_RCK_V4				CFG_REGISTER(RG_TSV2F_CTRL_5, 0x10)
+#define SET_DEVICE_LOW_POWER_SINGLE_MODE_V4	CFG_REGISTER(RG_TSFM_CTRL_3, 0xB8)
+
+#define HAS_FEATURE(lvts_data, feature)		(lvts_data->feature_bitmap & (feature))
+#define GET_BASE_ADDR(lvts_data, tc_id)		(lvts_data->base + lvts_data->tc[tc_id].addr_offset)
+#define GET_CAL_DATA_BITMASK(index, lvts_data, h, l)	(((index) < lvts_data->num_efuse_addr) \
+	? ((lvts_data->efuse[(index)] & GENMASK(h, l)) >> l) : 0)
+
+#define GET_TC_SENSOR_NUM(lvts_data, tc_id)		(lvts_data->tc[tc_id].num_sensor)
+#define ONE_SAMPLE		(lvts_data->counting_window_us + 2 * BUS_ACCESS_US)
+#define NUM_OF_SAMPLE(tc_id)	((lvts_data->tc[tc_id].hw_filter < LVTS_FILTER_2) ? 1 :	\
+	((lvts_data->tc[tc_id].hw_filter > LVTS_FILTER_16_OF_18) ? 1 :	\
+	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_16_OF_18) ? 18 : \
+	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_8_OF_10) ? 10 :	\
+	(lvts_data->tc[tc_id].hw_filter * 2)))))
+
+#define PERIOD_UNIT_US(tc_id)	((lvts_data->tc[tc_id].tc_speed->period_unit * 256 * \
+	CLOCK_26MHZ_CYCLE_NS) / 1000)
+#define FILTER_INT_US(tc_id)	(lvts_data->tc[tc_id].tc_speed->filter_interval_delay * \
+	PERIOD_UNIT_US(tc_id))
+#define SENSOR_INT_US(tc_id)	(lvts_data->tc[tc_id].tc_speed->sensor_interval_delay * \
+	PERIOD_UNIT_US(tc_id))
+#define GROUP_INT_US(tc_id)		(lvts_data->tc[tc_id].tc_speed->group_interval_delay * \
+	PERIOD_UNIT_US(tc_id))
+#define SENSOR_LATENCY_US(tc_id)	((NUM_OF_SAMPLE(tc_id) - 1) * FILTER_INT_US(tc_id) + \
+	NUM_OF_SAMPLE(tc_id) * ONE_SAMPLE)
+#define GROUP_LATENCY_US(tc_id)		(GET_TC_SENSOR_NUM(lvts_data, tc_id) * \
+	SENSOR_LATENCY_US(tc_id) + (GET_TC_SENSOR_NUM(lvts_data, tc_id) - 1) * SENSOR_INT_US(tc_id) + \
+	GROUP_INT_US(tc_id))
+
+#define CK26M_ACTIVE(lvts_data)	(((lvts_data->feature_bitmap & FEATURE_CK26M_ACTIVE) ? 1 : 0) << 30)
+#define DEVICE_ACCESS			(SCK_ONLY | DEVICE_ACCESS_STARTUS | READ_32BIT_ACCESS)
+#define DEVICE_READ				(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS)
+#define DEVICE_WRITE			(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | WRITE_ACCESS)
+#define READ_BACK_DEVICE_ID		(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | BROADCAST_ID_UPDATE | \
+	RG_DID_LVTS << 8)
+#define READ_DEVICE_REG(reg_idx)	(DEVICE_READ | (reg_idx) << 8 | 0x00)
+#define RESET_ALL_DEVICES			(DEVICE_WRITE | RG_TSFM_RST << 8 | 0xFF)
+
+/*
+ * LVTS HW filter settings
+ * 000: Get one sample
+ * 001: Get 2 samples and average them
+ * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
+ * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
+ * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
+ * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
+ */
+enum lvts_hw_filter {
+	LVTS_FILTER_1,
+	LVTS_FILTER_2,
+	LVTS_FILTER_2_OF_4,
+	LVTS_FILTER_4_OF_6,
+	LVTS_FILTER_8_OF_10,
+	LVTS_FILTER_16_OF_18
+};
+
+enum lvts_sensing_point {
+	SENSING_POINT0,
+	SENSING_POINT1,
+	SENSING_POINT2,
+	SENSING_POINT3,
+	ALL_SENSING_POINTS
+};
+
+struct lvts_data;
+
+/**
+ * struct lvts_speed_settings - A structure to hold the data related to polling rate
+ * @period_unit: Period unit is a base for all interval delays
+ * @group_interval_delay:  Delay between different rounds
+ * @filter_interval_delay: Delay between two samples of the same sensor
+ * @sensor_interval_delay: Delay between two samples of differnet sensors
+ *
+ * Calculation is achieved with the following equations:
+ * For the period unit: (period_us * 1000) / (256 * clock_26mhz_cycle_ns)
+ * For the interval delays: delay / period_us
+ */
+struct lvts_speed_settings {
+	unsigned int period_unit;
+	unsigned int group_interval_delay;
+	unsigned int filter_interval_delay;
+	unsigned int sensor_interval_delay;
+};
+
+struct lvts_tc_settings {
+	unsigned int dev_id;
+	unsigned int addr_offset;
+	unsigned int num_sensor;
+	unsigned int sensor_map[ALL_SENSING_POINTS];	/* In sensor ID */
+	struct lvts_speed_settings *tc_speed;
+	/*
+	 * HW filter setting
+	 * 000: Get one sample
+	 * 001: Get 2 samples and average them
+	 * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
+	 * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
+	 * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
+	 * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
+	 */
+	unsigned int hw_filter;
+	/*
+	 * Dominator_sensing point is used to select a sensing point
+	 * and reference its temperature to trigger Thermal HW Reboot
+	 * When it is ALL_SENSING_POINTS, it will select all sensing points
+	 */
+	int dominator_sensing_point;
+	int hw_reboot_trip_point;		/* -274000: Disable HW reboot */
+	unsigned int irq_bit;
+};
+
+struct lvts_formula_coeff {
+	int a;
+	int b;
+	unsigned int golden_temp;
+};
+
+struct lvts_sensor_cal_data {
+	int use_fake_efuse;				/* 1: Use fake efuse, 0: Use real efuse */
+	unsigned int golden_temp;
+	unsigned int *count_r;
+	unsigned int *count_rc;
+	unsigned int *count_rc_now;
+	unsigned int default_golden_temp;
+	unsigned int default_count_r;
+	unsigned int default_count_rc;
+};
+
+struct platform_ops {
+	void (*efuse_to_cal_data)(struct lvts_data *lvts_data);
+	void (*device_enable_and_init)(struct lvts_data *lvts_data);
+	void (*device_enable_auto_rck)(struct lvts_data *lvts_data);
+	int (*device_read_count_rc_n)(struct lvts_data *lvts_data);
+	void (*set_cal_data)(struct lvts_data *lvts_data);
+	void (*init_controller)(struct lvts_data *lvts_data);
+};
+
+struct lvts_data {
+	struct device *dev;
+	struct clk *clk;
+	void __iomem *base;				/* LVTS base addresses */
+	unsigned int irq_num;			/* LVTS interrupt numbers */
+	struct reset_control *reset;
+	int num_tc;						/* Number of LVTS thermal controllers */
+	const struct lvts_tc_settings *tc;
+	int counting_window_us;			/* LVTS device counting window */
+	int num_sensor;					/* Number of sensors in this platform */
+	void __iomem **reg;
+	struct platform_ops ops;
+	int feature_bitmap;				/* Show what features are enabled */
+	unsigned int num_efuse_addr;
+	unsigned int *efuse;
+	unsigned int num_efuse_block;	/* Number of contiguous efuse indexes */
+	struct lvts_sensor_cal_data cal_data;
+	struct lvts_formula_coeff coeff;
+};
+
+struct soc_temp_tz {
+	unsigned int id;
+	struct lvts_data *lvts_data;
+};
+
+extern void lvts_device_enable_and_init_v4(struct lvts_data *lvts_data);
+extern void lvts_device_enable_auto_rck_v4(struct lvts_data *lvts_data);
+extern int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data);
+extern void lvts_set_calibration_data_v4(struct lvts_data *lvts_data);
+extern void lvts_init_controller_v4(struct lvts_data *lvts_data);
+
+extern int lvts_probe(struct platform_device *pdev);
+extern int lvts_remove(struct platform_device *pdev);
+extern int lvts_suspend(struct platform_device *pdev, pm_message_t state);
+extern int lvts_resume(struct platform_device *pdev);
+
+#endif /* __MTK_SOC_TEMP_LVTS_H__ */
-- 
2.34.1

