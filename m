Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8A5354DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbiEZUox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349027AbiEZUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:44:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED6913D4C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:44:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n22so208709eda.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgzdTe7fcPDB2gZCUSY8XDUZGwLpeoTk6dRLrKInLZw=;
        b=nfHEhi7ujlgHOW7VWTy7u/ez0jnBhNWYtx7YskXCH2/UMTlUXvVqZ8r4hDdc+eccdZ
         eDQJSL5qDd4CHFuv5+VR0rJBcZQwBLEhXoXQxcWSwoO5DPbdMWv6cBbwraUVhbzLHGFl
         YFEF6FjrPWGOCtI48xOZQV/AWbmpKgL2yntfvgn3Pi9fKgofLL9X6i3RjWbtgescg4A2
         J7zFnkfDvfRGJF1aPlerzZJWjlDQtLz/2g34UhyhB+KvpnNIW3qXfYGv3Ozf0JR1Oq1E
         VETk/7mEwjWgVTAgIgbPjLEmhRCgqlqHaW7tm5FOLqZK0WnqmLJgsSuMxGMMNCSNhEKd
         Y50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgzdTe7fcPDB2gZCUSY8XDUZGwLpeoTk6dRLrKInLZw=;
        b=YqAXXBHheRULDc5a+seML2ujmu/ag4KC8opK7pI96M3xJ954txDMcA64wVS6aWwcUa
         Ifm7QZR8SlOJSl3wRoC6hyD16WL6bkyqLE51SqRWdb7pdYDoS1NFcyZOTjNud6JmNWGA
         c3gEcuxvgB3QAdRZ421nzGppLGGZkFKI90ntN7DMzpUF026rQp8RAcQ1eHAMhIbY7e3R
         CjTW6pH5EeAVFyvgYrtJPx6Lk8RGSW8TvC51T340cz+j9TuClN4oS3m5/ow+9VSvMKck
         Upo8X42431dRkto2JGtfND4f0McUvUXNo6M6o+4uOg4DPkpwpaqIWJpaCPVgTgY85gaF
         nqlA==
X-Gm-Message-State: AOAM532bpeP/m9MFzQ+lWFBb6sIH5PJhO9ERFlRG62lLfmQP6Zkio5h8
        k9A6R8VtLGr6jNWa/lDfSvsVEw==
X-Google-Smtp-Source: ABdhPJzmbatH19Rfb7UpYoZN8s5POPS+jX9M0kXvrf1DSf2MQ6Y2AyfXy9WcElSAeYt6XR2aaTKIyg==
X-Received: by 2002:a50:ed18:0:b0:42b:b880:3f27 with SMTP id j24-20020a50ed18000000b0042bb8803f27mr12083288eds.187.1653597845910;
        Thu, 26 May 2022 13:44:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709061ccf00b006fec5cef701sm803475ejh.197.2022.05.26.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:44:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: mediatek: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:44:01 +0200
Message-Id: <20220526204402.832393-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts          |  2 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts    |  8 ++++----
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts         |  8 ++++----
 arch/arm64/boot/dts/mediatek/mt7622.dtsi             | 10 +++++-----
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi            |  4 ++--
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi         | 12 ++++++------
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts          | 12 ++++++------
 arch/arm64/boot/dts/mediatek/mt8173.dtsi             |  8 ++++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi             |  8 ++++----
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts          |  8 ++++----
 10 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 11aa135aa0f3..9b1af9c80130 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -106,7 +106,7 @@ &cpu2 {
 };
 
 &eth {
-	phy-mode ="rgmii-rxid";
+	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethernet_phy0>;
 	mediatek,tx-delay-ps = <1530>;
 	snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 2b9bf8dd14ec..ada06d3de1c9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -336,14 +336,14 @@ mux {
 	i2c1_pins: i2c1-pins {
 		mux {
 			function = "i2c";
-			groups =  "i2c1_0";
+			groups = "i2c1_0";
 		};
 	};
 
 	i2c2_pins: i2c2-pins {
 		mux {
 			function = "i2c";
-			groups =  "i2c2_0";
+			groups = "i2c2_0";
 		};
 	};
 
@@ -366,14 +366,14 @@ conf {
 	irrx_pins: irrx-pins {
 		mux {
 			function = "ir";
-			groups =  "ir_1_rx";
+			groups = "ir_1_rx";
 		};
 	};
 
 	irtx_pins: irtx-pins {
 		mux {
 			function = "ir";
-			groups =  "ir_1_tx";
+			groups = "ir_1_tx";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 596c073d8b05..3ee392d805d8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -298,14 +298,14 @@ mux {
 	i2c1_pins: i2c1-pins {
 		mux {
 			function = "i2c";
-			groups =  "i2c1_0";
+			groups = "i2c1_0";
 		};
 	};
 
 	i2c2_pins: i2c2-pins {
 		mux {
 			function = "i2c";
-			groups =  "i2c2_0";
+			groups = "i2c2_0";
 		};
 	};
 
@@ -328,14 +328,14 @@ conf {
 	irrx_pins: irrx-pins {
 		mux {
 			function = "ir";
-			groups =  "ir_1_rx";
+			groups = "ir_1_rx";
 		};
 	};
 
 	irtx_pins: irtx-pins {
 		mux {
 			function = "ir";
-			groups =  "ir_1_tx";
+			groups = "ir_1_tx";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index dbcee8b4d8d8..146e18b5b1f4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -118,8 +118,8 @@ clk25m: oscillator {
 	};
 
 	psci {
-		compatible  = "arm,psci-0.2";
-		method      = "smc";
+		compatible = "arm,psci-0.2";
+		method = "smc";
 	};
 
 	pmu {
@@ -616,9 +616,9 @@ audsys: clock-controller@11220000 {
 
 		afe: audio-controller {
 			compatible = "mediatek,mt7622-audio";
-			interrupts =  <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
-				      <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
-			interrupt-names	= "afe", "asys";
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "afe", "asys";
 
 			clocks = <&infracfg CLK_INFRA_AUDIO_PD>,
 				 <&topckgen CLK_TOP_AUD1_SEL>,
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index d2636a0ed152..e3a407d03551 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -57,8 +57,8 @@ cpu3: cpu@3 {
 	};
 
 	psci {
-		compatible  = "arm,psci-0.2";
-		method      = "smc";
+		compatible = "arm,psci-0.2";
+		method = "smc";
 	};
 
 	reserved-memory {
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 9c75fbb31f98..0d8f9459e35d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -300,8 +300,8 @@ da9211_vcpu_reg: BUCKA {
 				regulator-name = "VBUCKA";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1310000>;
-				regulator-min-microamp  = <2000000>;
-				regulator-max-microamp  = <4400000>;
+				regulator-min-microamp = <2000000>;
+				regulator-max-microamp = <4400000>;
 				regulator-ramp-delay = <10000>;
 				regulator-always-on;
 				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
@@ -312,8 +312,8 @@ da9211_vgpu_reg: BUCKB {
 				regulator-name = "VBUCKB";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1310000>;
-				regulator-min-microamp  = <2000000>;
-				regulator-max-microamp  = <3000000>;
+				regulator-min-microamp = <2000000>;
+				regulator-max-microamp = <3000000>;
 				regulator-ramp-delay = <10000>;
 			};
 		};
@@ -374,8 +374,8 @@ &mmc0 {
 	mmc-hs400-1_8v;
 	cap-mmc-hw-reset;
 	hs400-ds-delay = <0x14015>;
-	mediatek,hs200-cmd-int-delay=<30>;
-	mediatek,hs400-cmd-int-delay=<14>;
+	mediatek,hs200-cmd-int-delay = <30>;
+	mediatek,hs400-cmd-int-delay = <14>;
 	mediatek,hs400-cmd-resp-sel-rising;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4fa1e93302c7..0b5f154007be 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -122,8 +122,8 @@ da9211_vcpu_reg: BUCKA {
 				regulator-name = "VBUCKA";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1310000>;
-				regulator-min-microamp	= <2000000>;
-				regulator-max-microamp	= <4400000>;
+				regulator-min-microamp = <2000000>;
+				regulator-max-microamp = <4400000>;
 				regulator-ramp-delay = <10000>;
 				regulator-always-on;
 			};
@@ -132,8 +132,8 @@ da9211_vgpu_reg: BUCKB {
 				regulator-name = "VBUCKB";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1310000>;
-				regulator-min-microamp	= <2000000>;
-				regulator-max-microamp	= <3000000>;
+				regulator-min-microamp = <2000000>;
+				regulator-max-microamp = <3000000>;
 				regulator-ramp-delay = <10000>;
 			};
 		};
@@ -148,8 +148,8 @@ &mmc0 {
 	bus-width = <8>;
 	max-frequency = <50000000>;
 	cap-mmc-highspeed;
-	mediatek,hs200-cmd-int-delay=<26>;
-	mediatek,hs400-cmd-int-delay=<14>;
+	mediatek,hs200-cmd-int-delay = <26>;
+	mediatek,hs400-cmd-int-delay = <14>;
 	mediatek,hs400-cmd-resp-sel-rising;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 40d7b47fc52e..5e903ab5884c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -246,9 +246,9 @@ pmu_a72 {
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
 		method = "smc";
-		cpu_suspend   = <0x84000001>;
-		cpu_off	      = <0x84000002>;
-		cpu_on	      = <0x84000003>;
+		cpu_suspend = <0x84000001>;
+		cpu_off	 = <0x84000002>;
+		cpu_on	 = <0x84000003>;
 	};
 
 	clk26m: oscillator0 {
@@ -1505,7 +1505,7 @@ larb5: larb@19001000 {
 
 		vcodec_enc_vp8: vcodec@19002000 {
 			compatible = "mediatek,mt8173-vcodec-enc-vp8";
-			reg =  <0 0x19002000 0 0x1000>; /* VENC_LT_SYS */
+			reg = <0 0x19002000 0 0x1000>; /* VENC_LT_SYS */
 			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
 			iommus = <&iommu M4U_PORT_VENC_RCPU_SET2>,
 				 <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 01e650251928..42b208132a88 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -295,8 +295,8 @@ pmu-a73 {
 	};
 
 	psci {
-		compatible      = "arm,psci-1.0";
-		method          = "smc";
+		compatible = "arm,psci-1.0";
+		method = "smc";
 	};
 
 	clk26m: oscillator {
@@ -504,7 +504,7 @@ power-domain@MT8183_POWER_DOMAIN_CONN {
 
 				power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
-					clocks =  <&topckgen CLK_TOP_MUX_MFG>;
+					clocks = <&topckgen CLK_TOP_MUX_MFG>;
 					clock-names = "mfg";
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1150,7 +1150,7 @@ i2c8: i2c@1101b000 {
 		};
 
 		ssusb: usb@11201000 {
-			compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
+			compatible = "mediatek,mt8183-mtu3", "mediatek,mtu3";
 			reg = <0 0x11201000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
 			reg-names = "mac", "ippc";
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
index db25a515e420..690dc7717f2c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
@@ -139,19 +139,19 @@ pins {
 };
 
 &u3phy0 {
-	status="okay";
+	status = "okay";
 };
 
 &u3phy1 {
-	status="okay";
+	status = "okay";
 };
 
 &u3phy2 {
-	status="okay";
+	status = "okay";
 };
 
 &u3phy3 {
-	status="okay";
+	status = "okay";
 };
 
 &uart0 {
-- 
2.34.1

