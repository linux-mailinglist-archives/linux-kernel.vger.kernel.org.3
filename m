Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F3532D85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiEXP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiEXP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:28:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112A9CF28
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so25609325wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXAnLmzQrgqQaSJtyjFJWoEYu8dDLIqEgDWHqFINN08=;
        b=cv59JtLB1DMCmnpxy0QvDJStxO8ZvCXtCfCY4OCgVkzrBXQTcf8ujp/k2ONKQRYaPX
         wtke5nkEcRjpRVA0Aa/CoVsiD7WaUgQMRCXsn49xDzBfk+GM3NStDzNP9VCTuFpwzzaq
         unjaa+Ag+9+bZwk595FWb+MVNMylT1Zm4M5bqwaVDD+12GgQuIRH8993Ny3gFJ5MdSfy
         5LHu1KGgF7DOtyUzAgrCutpnhb1csg88pJr2wgEtQmFM4mZkqmRGgnv6RfhccH5x1wic
         3YBj6Aw9qVpCNcGKB2/cD35dJRTpJnAe0EOdD0feeNkfI40MElsFceNS3cSS0six95uS
         bf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXAnLmzQrgqQaSJtyjFJWoEYu8dDLIqEgDWHqFINN08=;
        b=Hj1JUULjsXuGrb2A6o//kXSs3BpPHsITBnmbw2Xt4egRnMYoxzh/qK1t0IuT2VIlwO
         VurwhEbGvymTfnMUBA0uCGAWrp8myaGmPAKe5UPSBa4N9HVqBJW7Wz5/hItyXx6HpSUf
         IAzD0qZe9oQqs75rfY/8IvGS6iyF2CVmXCM1onQju1hSbCqiVI185Fkqgq79PM1rScB+
         qsur2srVT1PZkD0eunmZy3mNq8QKQi9dpttbiAW7+JWaBee1dQ256N+EVq0R50tf/fd9
         3/6t+iLM54ynHXKqJkzsrBjFupkP6ZJQSqk+YU3Wf9kDe/11j1/nCnXlWIKQ0E45Dn8t
         vG0g==
X-Gm-Message-State: AOAM531w3PjZWXg3CgDU7rCR8orKl+B8oWKCIWwegiYY8iYXkIq5zDeC
        yLMBcTXJbfPWi5tIASgyfxm7rg==
X-Google-Smtp-Source: ABdhPJzb9pI/bDL6XkMTlf8Z6N07rnuBuKsU8LO2ruGUS0CBYqbWdTzI3s4eD78oq8NcuY2+KRas2Q==
X-Received: by 2002:a5d:574a:0:b0:20d:70c:3aa8 with SMTP id q10-20020a5d574a000000b0020d070c3aa8mr23475115wrw.255.1653406091891;
        Tue, 24 May 2022 08:28:11 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:28:11 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Tinghan Shen <tinghan.shen@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v7 6/6] arm64: dts: mt8195: Add thermal zone
Date:   Tue, 24 May 2022 17:25:53 +0200
Message-Id: <20220524152552.246193-7-abailon@baylibre.com>
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

From: Tinghan Shen <tinghan.shen@mediatek.com>

This adds the thermal zone for the mt8195.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 104 +++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 51443e83d906..8421cf35ae03 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
+#include <dt-bindings/reset/mt8195-resets.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -812,6 +813,21 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts: lvts@1100b000 {
+			compatible = "mediatek,mt8195-lvts";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>,
+				<0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+					<GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>,
+				 <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+
+			nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
+			nvmem-cell-names = "e_data1","e_data2";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi",
 				     "mediatek,mt6765-spi";
@@ -1616,4 +1632,92 @@ vencsys_core1: clock-controller@1b000000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-big1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 0>;
+		};
+		cpu-big2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 1>;
+		};
+		cpu-big3-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 2>;
+		};
+		cpu-big4-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 3>;
+		};
+		cpu-little1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 4>;
+		};
+		cpu-little2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 5>;
+		};
+		cpu-little3-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 6>;
+		};
+		cpu-little4-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 7>;
+		};
+		vpu1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 8>;
+		};
+		vpu2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 9>;
+		};
+		gpu1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 10>;
+		};
+		gpu2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 11>;
+		};
+		vdec-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 12>;
+		};
+		img-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 13>;
+		};
+		infra-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 14>;
+		};
+		cam1-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 15>;
+		};
+		cam2-thermal {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 16>;
+		};
+	};
 };
-- 
2.35.1

