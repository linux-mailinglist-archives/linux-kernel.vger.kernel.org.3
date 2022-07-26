Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E258149E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbiGZNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiGZNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:55:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A51CE39
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id id17so8803162wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N02ENN8wREPX4veIj3cGqV28PXqeQzl2/6jGMwhV5k4=;
        b=vO9zvYPT5F1jd3WhvAXktLAz6qcb8YZgGeLh1fXmtfpqcsBFp8Js3hB+qnqryJRuBl
         2tV1KtKbEj+iw2CLAXaujRN8QpTGItj84cZdY3YIt8Wqcxrq1Y9Tqqf0XdvmBml1R99U
         MVrxwDL2oeW8hl/hZs/K4zffKdBlG573cIGBw0SoXvP78XIxAg7fGITYYjJfOFl7NLZj
         Sv+SuVeq9vsL5XPjan/wzSLX4NWjqAoRiTF4uXqC1huzb6719k+s+RsdiBN7mKdU0vlk
         AxQnUwdaAbm/Bi5jSow290CBHv1JEdr0DF4WeHltdnDaKon0HvytQGi+Q3w5aqyJ8ZvY
         4jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N02ENN8wREPX4veIj3cGqV28PXqeQzl2/6jGMwhV5k4=;
        b=YZW0kQqkDM/aJRKkoXg9myHgTva1laeSOaOUzJIChGpVzMptkEO857ojHu97CN8LeH
         dRxfvmvmsdukU4x3mP+zyVBVFuIHmx0tR43oBvajzBKPWSnSJuGnXIcD8MhnE/tZvXlb
         VtpUFWhT+CWrZQXMPfDpWHi+ZhaYVW7uuls6IdLfem8q+vNDjixiCnXR6GDFtKZF/xW8
         jDD4V7YypnZHSuIeM42kaeq58IEN13YIlo7txdG378UAU1Et+nw4xNsRjFDPAa9r8AsO
         nmSb9tgcX215wRnzBO1xKls7oJxdjuY8iGohr385JCmaw2g/qEvJVTn9kHnL+0+8SglV
         Jriw==
X-Gm-Message-State: AJIora+XUwkShI8Ke6qmAObwo5WiMur+CDH7qNgq/rlpXmUW5eh1bZrx
        xlWMq3H50r8jg8IY35UleBEXhg==
X-Google-Smtp-Source: AGRyM1vhX7RgKC8IGy97eICF/591FulDH1b+GwMaL7So30RUVSvED/g4XVgQWTuECYQ6Gn9vbOzMZQ==
X-Received: by 2002:a1c:2783:0:b0:3a2:fd82:bf46 with SMTP id n125-20020a1c2783000000b003a2fd82bf46mr24814709wmn.29.1658843723039;
        Tue, 26 Jul 2022 06:55:23 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:22 -0700 (PDT)
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
Subject: [PATCH v8 6/6] arm64: dts: mt8195: Add thermal zone
Date:   Tue, 26 Jul 2022 15:55:06 +0200
Message-Id: <20220726135506.485108-7-bchihi@baylibre.com>
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

This adds the thermal zone for the mt8195.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 115 ++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 4fbf24b5d202..78017224930c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2022 MediaTek Inc.
  * Author: Seiya Wang <seiya.wang@mediatek.com>
  */
 
@@ -11,6 +11,9 @@
 #include <dt-bindings/memory/mt8195-memory-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/power/mt8195-power.h>
+#include <dt-bindings/reset/mt8195-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -810,6 +813,28 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvtsap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8195-lvts-ap";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x400>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
+		};
+
+		lvtsmcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8195-lvts-mcu";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x11278000 0 0x400>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi",
 				     "mediatek,mt6765-spi";
@@ -1613,4 +1638,92 @@ vencsys_core1: clock-controller@1b000000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-big1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 0>;
+		};
+		cpu-big2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 1>;
+		};
+		cpu-big3-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 2>;
+		};
+		cpu-big4-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 3>;
+		};
+		cpu-little1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 4>;
+		};
+		cpu-little2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 5>;
+		};
+		cpu-little3-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 6>;
+		};
+		cpu-little4-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsmcu 7>;
+		};
+		vpu1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 0>;
+		};
+		vpu2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 1>;
+		};
+		gpu1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 2>;
+		};
+		gpu2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 3>;
+		};
+		vdec-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 4>;
+		};
+		img-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 5>;
+		};
+		infra-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 6>;
+		};
+		cam1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 7>;
+		};
+		cam2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvtsap 8>;
+		};
+	};
 };
-- 
2.34.1

