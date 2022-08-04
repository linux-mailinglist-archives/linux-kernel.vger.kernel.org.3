Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50AA589C42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiHDNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHDNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:10:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729618E21
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:10:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so21008483wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ts9wGXUYExk6gtCsSPDiHLEprUWAxTPstjlSxz/66wI=;
        b=bMwcYGHsBIEMrbYzlqomUHZufeEAWm8D1KStc+1SHQNZmazstd2ArhFBuu/ztF9QHj
         H3kz2IfvpwimKU818GmMAmRDWXueM8lHfGBtN229jA0npnntym3dU8IPoUYQ0OUaPDIv
         mVVe0jJJcyN69Bwh+Sttsael1VYjQz04wd2lsfayRx+JLK5hbMcYlpE0DR6yI4xN3OZj
         Pkc/MRvr3Xcyj31H3scdaxgzPpEUZUMrQcmKrt8OOD8kIgwsmD8seSjCea6FPTQxdZBs
         d3YquQOuxz/SyCOgKlC8WNv+6YltIlnRVg/qmXLQZTYXGBbwVS0K64jNV8ggb5OJzw0G
         elAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ts9wGXUYExk6gtCsSPDiHLEprUWAxTPstjlSxz/66wI=;
        b=5A603/K8H1iH9e9TbrEpeomL528BtK1bPPTuVMM/AFmONkKcxqEtfaxuDwkf2L9VXB
         v9fjhxgvT22Atzi20ptjCsOrkdh19KRX2M7lujlaC7G48ZCY5BGDWbVRf3Qh5tiM1bGD
         UWq+FzCwliYWtkq4FRkkP0yEqgf0nOP8PwG5lydMUcYAGbovAFdHSxTKEj5WQxCadpRb
         XCAj68wLgQ0xFAPGTmyYNSR/m6YRK/CaEaW6nYQ6aastqmwJQsbVQ6xNKvm+nnQW+Mxq
         lFFgxwLT0xuNYbklKSGUkmNt62wPLN+3pWRpKO3LaN3tYGSkSXePJf3CtYj9pm6G8yHi
         Y7uA==
X-Gm-Message-State: ACgBeo1fzrN2CbiCcL4wfFIiqB8z0CCkciunUBdIdWhr9Qqsn2reoHcy
        YLKBThO5aftWvecBvkVd/mskDQ==
X-Google-Smtp-Source: AA6agR4hBf9nrcJv9jI+ROSaWAYZZoaanOEqB2H5H2YmKYmGpgitvUOLLcF93mI+x3J0h5O+UNCjhQ==
X-Received: by 2002:adf:d090:0:b0:220:7188:ac8b with SMTP id y16-20020adfd090000000b002207188ac8bmr1413517wrh.389.1659618601454;
        Thu, 04 Aug 2022 06:10:01 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.. (235.163.185.81.rev.sfr.net. [81.185.163.235])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm1156817wrj.47.2022.08.04.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:10:00 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8.1, 3/7] arm64: dts: mt8192: Add thermal zone
Date:   Thu,  4 Aug 2022 15:09:08 +0200
Message-Id: <20220804130912.676043-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804130912.676043-1-bchihi@baylibre.com>
References: <20220804130912.676043-1-bchihi@baylibre.com>
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

From: Balsam CHIHI <bchihi@baylibre.com>

This adds the thermal zone for the mt8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 113 ++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index cbae5a5ee4a0..3320b5c14ee3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright (C) 2020 MediaTek Inc.
+ * Copyright (C) 2022 MediaTek Inc.
  * Author: Seiya Wang <seiya.wang@mediatek.com>
  */
 
@@ -12,6 +12,7 @@
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8192-power.h>
+#include <dt-bindings/reset/mt8192-resets.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -599,6 +600,28 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8192-lvts-ap";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts_calib_data1";
+		};
+
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8192-lvts-mcu";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts_calib_data1";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8192-spi",
 				     "mediatek,mt6765-spi";
@@ -1457,4 +1480,92 @@ larb2: larb@1f002000 {
 			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-big1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 0>;
+		};
+		cpu-big2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 1>;
+		};
+		cpu-big3-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 2>;
+		};
+		cpu-big4-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 3>;
+		};
+		cpu-little1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 4>;
+		};
+		cpu-little2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 5>;
+		};
+		cpu-little3-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 6>;
+		};
+		cpu-little4-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 7>;
+		};
+		vpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 0>;
+		};
+		vpu2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 1>;
+		};
+		gpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 2>;
+		};
+		gpu2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 3>;
+		};
+		vdec-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 4>;
+		};
+		img-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 5>;
+		};
+		infra-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 6>;
+		};
+		cam1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 7>;
+		};
+		cam2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap 8>;
+		};
+	};
 };
-- 
2.34.1

