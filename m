Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F5596AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiHQIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiHQIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:08:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5652474
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay12so6339478wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vqBN/1lbDDUExS5IZ7DoqaWZVSkfYt/y1o6RlIQJrH0=;
        b=uf6YkzyFQ14zCs70XWWzM9dZH85T8/q1k7HQueBM2LvFHPbhfDqQ3HCMcckugNviMF
         F3NTw3U9cE6D3PKUY4SiDVjpZPa/l28lAxVKqhMxhJFRdj+TPItJoKMYa84Wb5Gs+61i
         5quMuW8tDoJQE+FKH5KhTQif+vaYwz/xadhYpKJZbqwlXcscHpegS/HlXIfHsdK2uWiI
         YMaAR9BDfwnVGAd9HgjVPCBBymXtyUMZVC5AvYv3307rNL5mDFZATXExEwpBcsWeb6hB
         bRxJGncCU4QJ3pHX9TvxeDwLDuXSkwfKs9OTcDZ+Dhv8rcaYIAJa2oT4l5ToHsr2dz9Q
         CWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vqBN/1lbDDUExS5IZ7DoqaWZVSkfYt/y1o6RlIQJrH0=;
        b=W/Wyg3LlxctPM65MkO2oIWCaNQ2oyuuNSN1UVGeurmOpu9zDLdKZs60mIoTJf/iCKj
         BWoQp+tUJ/TfD4S5m+djvEtp0Kl5lxs5+tOxjbv5L6pZsFp1esF030yzTVRTrUAMB8Sc
         3LXs597zPxOirFydZvWaamL7gowV41EGD1B/mCNpPxOKgGa2XERXLeTA6wMUKMVrYnSo
         Dqfx1/GjtwFjJaRDGAsnIOTQPbKJ/qKOs9Ax07XPwG4ikeAIOeZUp09oNu7/BB8AU7lY
         tWkZfvpdoQoAKbfgG43GFydXKJS2RzF4XVruvDLeoJEOHGabFTXwuWMPRfVbJbiEnCDy
         Cczw==
X-Gm-Message-State: ACgBeo3JAGNdMESj/yPGqvZswpkvVmD6qMNycuIOXofmZQtcpHEnkZBZ
        zB4FxL59wKQmEAqOrSnbUzHx0A==
X-Google-Smtp-Source: AA6agR7xyAkug/0FUS2iV/tqnv/KSc31hp2N9qhVSWYwlEjmgU4SC/wDn1yaJLlWRb74RXcsko3bfA==
X-Received: by 2002:a05:600c:1497:b0:3a5:f608:d765 with SMTP id c23-20020a05600c149700b003a5f608d765mr1264422wmh.19.1660723732364;
        Wed, 17 Aug 2022 01:08:52 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:51 -0700 (PDT)
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
Subject: [PATCH v9,6/7] arm64: dts: mt8195: Add thermal zones and thermal nodes
Date:   Wed, 17 Aug 2022 10:07:56 +0200
Message-Id: <20220817080757.352021-7-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080757.352021-1-bchihi@baylibre.com>
References: <20220817080757.352021-1-bchihi@baylibre.com>
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

From: Tinghan Shen <tinghan.shen@mediatek.com>

Add thermal zones and thermal nodes for the mt8195.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Co-developed-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 111 +++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 95967a0196d8..aafbbe83e6ba 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/reset/mt8195-resets.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -452,6 +453,28 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8195-lvts-ap";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
+		};
+
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8195-lvts-mcu";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x11278000 0 0x1000>;
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
@@ -1106,4 +1129,92 @@ vencsys_core1: clock-controller@1b000000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 0>;
+		};
+		cpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 1>;
+		};
+		cpu2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 2>;
+		};
+		cpu3-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 3>;
+		};
+		cpu4-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 4>;
+		};
+		cpu5-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 5>;
+		};
+		cpu6-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu 6>;
+		};
+		cpu7-thermal {
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

