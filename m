Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B31E5354BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbiEZUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348940AbiEZUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:41:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37710F2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so5155122ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvjtADRzPgn8u2TEuVbI92RL0rL45EX7a5WsFGxR0SM=;
        b=wHM2l7QuYp3WDuIazn43EPsw/Yx8DrNxZY+P1sz+TwFvfzxpF2L+6EBaBRQ56KYEmB
         RI9wLpSjTjxDLX0jl/MGxmE/a3PcosIX2//JFbAcx3ugoJidFiUSDMnyuC4beeIpgprt
         uP5xU8IbEE68jRpZjKm2RxyT1PFbWQQ8eElo/uv/7MyIZ6HgHBkpU43sAXmQHXXmRpRy
         DNZuNTk4KgWWcaKB8FTA3t7cv8yYzWyZcEcMnUbtB9fy1fXElvfNuhyGiL0CE8p+LU5H
         nqWbFBN4ZRJgxaWst0KD6QVZ8bNc7mywHI5ZxqrSb4v1VwqwwtuNoFF50R6adWDZCpyW
         SCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvjtADRzPgn8u2TEuVbI92RL0rL45EX7a5WsFGxR0SM=;
        b=kCq8b3uRvMQWNrP5KiN6rFaOSbpHdTy3iTSQVnxZy2777n2kkln87uKGoz7NJ22/LE
         +/cLILA/gzXAarrz3UPeefGy/3A2tURoSRxFPLxKbFIDazYyuxikl5fDNauQFIKmfSce
         i28m9Uk5mwMpzetFGutBu59b2QM/CP9sZjLuKoQeCEOOv8jrWjo3t2pJoKVRgsvI4itd
         QFQmyM/CfYEIt5XmovAzk7jz6yYn/wMHrJQF+VnYtdJb2bpMo5eC6QH10mqtSz06CRoC
         VGwAZmgr/BvnGXIQrtcxwGGkYnICyakGAx5OqJMGEaNJ+vU86RJwOW2fwxVFr6UsD3ch
         Jq1g==
X-Gm-Message-State: AOAM530xfFZ0dPMnI97826KxlodqdkixoVF3WSrmuZKNLUaYAETo6TDI
        cQQCIctoOQ9Tdr6cpqbwCBEPNA==
X-Google-Smtp-Source: ABdhPJy4snBjm8ufiK4QdfiVHsuHXwJoWTrmwVmRD/26SrHup+DpJrLQfpIk8mBBEQdWaGQrV0PB2Q==
X-Received: by 2002:a17:907:629c:b0:6e1:6ad:5dd8 with SMTP id nd28-20020a170907629c00b006e106ad5dd8mr34740156ejc.641.1653597706285;
        Thu, 26 May 2022 13:41:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906a40b00b006f3ef214ddbsm829547ejz.65.2022.05.26.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:41:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Barker <paul.barker@sancloud.com>,
        Marc Murphy <marc.murphy@sancloud.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: ti: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:41:37 +0200
Message-Id: <20220526204139.831895-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
References: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 .../arm/boot/dts/am335x-boneblack-wireless.dts |  2 +-
 arch/arm/boot/dts/am335x-boneblue.dts          |  2 +-
 .../arm/boot/dts/am335x-bonegreen-wireless.dts |  2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts           |  4 ++--
 .../dts/am335x-sancloud-bbe-extended-wifi.dts  |  2 +-
 arch/arm/boot/dts/am3517-evm-ui.dtsi           |  6 +++---
 arch/arm/boot/dts/am3874-iceboard.dts          |  4 ++--
 arch/arm/boot/dts/am437x-l4.dtsi               |  2 +-
 arch/arm/boot/dts/da850-evm.dts                | 18 +++++++++---------
 arch/arm/boot/dts/da850.dtsi                   | 12 ++++++------
 arch/arm/boot/dts/dm8148-evm.dts               |  2 +-
 arch/arm/boot/dts/dm8168-evm.dts               |  2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts         |  2 +-
 arch/arm/boot/dts/dra76x.dtsi                  |  6 +++---
 14 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index c72b09ab8da0..207d2b63e0eb 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -19,7 +19,7 @@ wlan_en_reg: fixedregulator@2 {
 		regulator-name = "wlan-en-regulator";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		startup-delay-us= <70000>;
+		startup-delay-us = <70000>;
 
 		/* WL_EN */
 		gpio = <&gpio3 9 0>;
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 147c00de3795..34579e98636e 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -106,7 +106,7 @@ wlan_en_reg: fixedregulator@2 {
 		regulator-name = "wlan-en-regulator";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		startup-delay-us= <70000>;
+		startup-delay-us = <70000>;
 
 		/* WL_EN */
 		gpio = <&gpio3 9 0>;
diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 215f279e476b..d388cffa1a4d 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -18,7 +18,7 @@ wlan_en_reg: fixedregulator@2 {
 		regulator-name = "wlan-en-regulator";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-		startup-delay-us= <70000>;
+		startup-delay-us = <70000>;
 
 		/* WL_EN */
 		gpio = <&gpio0 26 0>;
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index d9f003d886bf..993b13420699 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -325,7 +325,7 @@ ext_rtc: em3027@56 {
 	tlv320aic23: codec@1a {
 		compatible = "ti,tlv320aic23";
 		reg = <0x1a>;
-		#sound-dai-cells= <0>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 	};
 };
@@ -491,7 +491,7 @@ &mcasp1 {
 		tx-num-evt = <1>;
 		rx-num-evt = <1>;
 
-		#sound-dai-cells= <0>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts b/arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts
index 246a1a9b3e44..a2676d10c24a 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe-extended-wifi.dts
@@ -23,7 +23,7 @@ wlan_en_reg: fixedregulator@2 {
 		regulator-name = "wlan-en-regulator";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		startup-delay-us= <100000>;
+		startup-delay-us = <100000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/am3517-evm-ui.dtsi b/arch/arm/boot/dts/am3517-evm-ui.dtsi
index 7d8f32bf70db..5b7b291fc477 100644
--- a/arch/arm/boot/dts/am3517-evm-ui.dtsi
+++ b/arch/arm/boot/dts/am3517-evm-ui.dtsi
@@ -137,14 +137,14 @@ &i2c2 {
 	tlv320aic23_1: codec@1a {
 		compatible = "ti,tlv320aic23";
 		reg = <0x1a>;
-		#sound-dai-cells= <0>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 	};
 
 	tlv320aic23_2: codec@1b {
 		compatible = "ti,tlv320aic23";
 		reg = <0x1b>;
-		#sound-dai-cells= <0>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 	};
 };
@@ -154,7 +154,7 @@ &i2c3 {
 	tlv320aic23_3: codec@1a {
 		compatible = "ti,tlv320aic23";
 		reg = <0x1a>;
-		#sound-dai-cells= <0>;
+		#sound-dai-cells = <0>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index c9323d1df303..d039af879367 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -213,7 +213,7 @@ u42: pca9575@21 {
 
 			u48: pca9575@22 {
 				compatible = "nxp,pca9575";
-				reg=<0x22>;
+				reg = <0x22>;
 				gpio-controller;
 				#gpio-cells = <2>;
 
@@ -232,7 +232,7 @@ u48: pca9575@22 {
 
 			u59: pca9575@23 {
 				compatible = "nxp,pca9575";
-				reg=<0x23>;
+				reg = <0x23>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				gpio-line-names =
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 8f2268c02778..415210b034ef 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -2407,7 +2407,7 @@ mag {
 
 				adc {
 					#io-channel-cells = <1>;
-					compatible ="ti,am4372-adc";
+					compatible = "ti,am4372-adc";
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index e9aecac4f5b5..1fdd9a249165 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -52,15 +52,15 @@ panel {
 		enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>; /* lcd_panel_pwr */
 
 		panel-info {
-			ac-bias		= <255>;
-			ac-bias-intrpt	= <0>;
-			dma-burst-sz	= <16>;
-			bpp		= <16>;
-			fdd		= <0x80>;
-			sync-edge	= <0>;
-			sync-ctrl	= <1>;
-			raster-order	= <0>;
-			fifo-th		= <0>;
+			ac-bias = <255>;
+			ac-bias-intrpt = <0>;
+			dma-burst-sz = <16>;
+			bpp = <16>;
+			fdd = <0x80>;
+			sync-edge = <0>;
+			sync-ctrl = <1>;
+			raster-order = <0>;
+			fifo-th = <0>;
 		};
 
 		display-timings {
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c3942b4e82ad..58e09ffe1052 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -419,7 +419,7 @@ async3_clk: async3 {
 		edma0: edma@0 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
-			reg =	<0x0 0x8000>;
+			reg = <0x0 0x8000>;
 			reg-names = "edma3_cc";
 			interrupts = <11 12>;
 			interrupt-names = "edma3_ccint", "edma3_ccerrint";
@@ -430,14 +430,14 @@ edma0: edma@0 {
 		};
 		edma0_tptc0: tptc@8000 {
 			compatible = "ti,edma3-tptc";
-			reg =	<0x8000 0x400>;
+			reg = <0x8000 0x400>;
 			interrupts = <13>;
 			interrupt-names = "edm3_tcerrint";
 			power-domains = <&psc0 1>;
 		};
 		edma0_tptc1: tptc@8400 {
 			compatible = "ti,edma3-tptc";
-			reg =	<0x8400 0x400>;
+			reg = <0x8400 0x400>;
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
 			power-domains = <&psc0 2>;
@@ -445,7 +445,7 @@ edma0_tptc1: tptc@8400 {
 		edma1: edma@230000 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC1: 0x01e3 0000 - 0x01e3 7fff */
-			reg =	<0x230000 0x8000>;
+			reg = <0x230000 0x8000>;
 			reg-names = "edma3_cc";
 			interrupts = <93 94>;
 			interrupt-names = "edma3_ccint", "edma3_ccerrint";
@@ -456,7 +456,7 @@ edma1: edma@230000 {
 		};
 		edma1_tptc0: tptc@238000 {
 			compatible = "ti,edma3-tptc";
-			reg =	<0x238000 0x400>;
+			reg = <0x238000 0x400>;
 			interrupts = <95>;
 			interrupt-names = "edm3_tcerrint";
 			power-domains = <&psc1 21>;
@@ -672,7 +672,7 @@ &cppi41dma 0 1 &cppi41dma 1 1
 
 			cppi41dma: dma-controller@201000 {
 				compatible = "ti,da830-cppi41";
-				reg =  <0x201000 0x1000
+				reg = <0x201000 0x1000
 					0x202000 0x1000
 					0x204000 0x4000>;
 				reg-names = "controller",
diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 8ef48c00f98d..fe3f9a970b18 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -51,7 +51,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>; /* termcount */
-		linux,mtd-name= "micron,mt29f2g16aadwp";
+		linux,mtd-name = "micron,mt29f2g16aadwp";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 778796c10af8..244a957f9ba3 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -119,7 +119,7 @@ &gpmc {
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
-		linux,mtd-name= "micron,mt29f2g16aadwp";
+		linux,mtd-name = "micron,mt29f2g16aadwp";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index c16e183822be..577114c4c20a 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -51,7 +51,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>; /* termcount */
-		linux,mtd-name= "micron,mt29f2g16aadwp";
+		linux,mtd-name = "micron,mt29f2g16aadwp";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index bc4ae91cba16..931db7932c11 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -90,8 +90,8 @@ dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
 		clocks = <&dpll_gmac_x2_ck>;
 		ti,max-div = <63>;
 		reg = <0x03fc>;
-		ti,bit-shift=<20>;
-		ti,latch-bit=<26>;
+		ti,bit-shift = <20>;
+		ti,latch-bit = <26>;
 		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
 		assigned-clock-rates = <80000000>;
 	};
@@ -102,7 +102,7 @@ dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
 		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
 		reg = <0x3fc>;
 		ti,bit-shift = <29>;
-		ti,latch-bit=<26>;
+		ti,latch-bit = <26>;
 		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
 		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
 	};
-- 
2.34.1

