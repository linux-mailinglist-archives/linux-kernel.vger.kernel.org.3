Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAF5354C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiEZUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348978AbiEZUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034D64CE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er5so3136313edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaaIvzCyiYTJ4x9y6lOIIsQ5y/glSrLJjPzlXiGkmLs=;
        b=zlRh0lo+MBxchiA1GCSyJ8xTlymp1YzbOmSKV5VlBVoHMtv42eD9SH2d6iDos2z8S6
         TqFBnKxrfLx506s/wdQ+/Vu8pGrqd3v0n3n3p2qJX/YK3b/XRv4YdWCitJtfrRVR3H9f
         2DOMzGPHS8DBrWS48siKy6pr4msijoxDcxv791/vTPxufCTaMlf+/gSXl5qL5KkvZ0I/
         4kjudPv8sPzJHsXzS4UV3EowLvVOqN9TZYcxlo5kEcajB36OOyPhIApNfMUSgBmYMeTv
         c6NVbAwsRf/FWIln+/fGJymKM1gujerQwJzhSs9ZVxW1wjXzMGQZG/r7sCNF2v0kwFSN
         3pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaaIvzCyiYTJ4x9y6lOIIsQ5y/glSrLJjPzlXiGkmLs=;
        b=X46YB8TOB4/LUd9QU0GgCm1wOERoZiI5CB0aDdArthiV5XGasUlzMMrc2X/y82DkmL
         lxaQ4NpRQHWcZ0JuuNlBfg5kJ43ur1ouc0CXhIZ6Bbz9k8Zat4GFZzHrdKURyXcG2N8z
         /Ff12wzhArL/VDsbG53OimkhQK08Gy18X9Vfx+IKYZ2j02I9mdnMTuAuA5oNKU1rFPBR
         rKFA8HuriBlUnr2kJod0L5wjqUFmSUqRyplpCOriGQYslw6zY1ReaOa22F9APwFfeXTW
         dFwLJ42km4xI4OjR+aPj46iRU0JgNIQ1MJ0KaDqqbjC2fvPRW81Jk6pm6BX8uv49S42V
         +9BA==
X-Gm-Message-State: AOAM530XHn/mrqI/GplHX9RmUBLmvO/HFVlcdAXlqtsWxohF6Og54OLU
        0bwI26iINF2q7xpUzE21/SbNbg==
X-Google-Smtp-Source: ABdhPJzoEtsGnAD99+S/M+sNtZowI6n7v289d+qLmqwN0oP9b/E7n0C30wg9quGaBFHk4qoQ6gafzQ==
X-Received: by 2002:a50:ec87:0:b0:42b:dfd9:c0a1 with SMTP id e7-20020a50ec87000000b0042bdfd9c0a1mr3647980edr.193.1653597771732;
        Thu, 26 May 2022 13:42:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id de30-20020a1709069bde00b006f3ef214debsm810551ejc.81.2022.05.26.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:47 +0200
Message-Id: <20220526204248.832139-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 10 ++++-----
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   | 12 +++++-----
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  4 ++--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  4 ++--
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |  2 +-
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |  2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 22 +++++++++----------
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  4 ++--
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  4 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  6 ++---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sdm660.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  4 ++--
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 16 +++++++-------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  6 ++---
 .../boot/dts/qcom/sdm850-samsung-w737.dts     |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  2 +-
 24 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7c1eab605c15..6337ed8c1e19 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -20,11 +20,11 @@ aliases {
 		serial0 = &blsp1_uart2;
 		serial1 = &blsp1_uart1;
 		usid0 = &pm8916_0;
-		i2c0	= &blsp_i2c2;
-		i2c1	= &blsp_i2c6;
-		i2c3	= &blsp_i2c4;
-		spi0	= &blsp_spi5;
-		spi1	= &blsp_spi3;
+		i2c0 = &blsp_i2c2;
+		i2c1 = &blsp_i2c6;
+		i2c3 = &blsp_i2c4;
+		spi0 = &blsp_spi5;
+		spi1 = &blsp_spi3;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 49afbb1a066a..08c8f9438050 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -49,11 +49,11 @@ aliases {
 		serial0 = &blsp2_uart2;
 		serial1 = &blsp2_uart3;
 		serial2 = &blsp1_uart2;
-		i2c0	= &blsp1_i2c3;
-		i2c1	= &blsp2_i2c1;
-		i2c2	= &blsp2_i2c1;
-		spi0	= &blsp1_spi1;
-		spi1	= &blsp2_spi6;
+		i2c0 = &blsp1_i2c3;
+		i2c1 = &blsp2_i2c1;
+		i2c2 = &blsp2_i2c1;
+		spi0 = &blsp1_spi1;
+		spi1 = &blsp2_spi6;
 	};
 
 	chosen {
@@ -957,7 +957,7 @@ dai@2 {
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "DB820c";
-	audio-routing =	"RX_BIAS", "MCLK",
+	audio-routing = "RX_BIAS", "MCLK",
 		"MM_DL1",  "MultiMedia1 Playback",
 		"MM_DL2",  "MultiMedia2 Playback",
 		"MultiMedia3 Capture", "MM_UL3";
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 82893dddfdf4..8f528b8a5fec 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -321,7 +321,7 @@ i2c_0: i2c@78b6000 {
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			clock-frequency  = <400000>;
+			clock-frequency = <400000>;
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -336,7 +336,7 @@ i2c_1: i2c@78b7000 { /* BLSP1 QUP2 */
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			clock-frequency  = <400000>;
+			clock-frequency = <400000>;
 			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
 			dma-names = "tx", "rx";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 4c38b15c6fd4..23b6dcaca691 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -119,7 +119,7 @@ ssphy_1: phy@58000 {
 				<&xo>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			resets =  <&gcc GCC_USB1_PHY_BCR>,
+			resets = <&gcc GCC_USB1_PHY_BCR>,
 				<&gcc GCC_USB3PHY_1_PHY_BCR>;
 			reset-names = "phy","common";
 			status = "disabled";
@@ -162,7 +162,7 @@ ssphy_0: phy@78000 {
 				<&xo>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			resets =  <&gcc GCC_USB0_PHY_BCR>,
+			resets = <&gcc GCC_USB0_PHY_BCR>,
 				<&gcc GCC_USB3PHY_0_PHY_BCR>;
 			reset-names = "phy","common";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 22978d06f85b..12fe5b33b7fc 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -156,7 +156,7 @@ &slpi_pil {
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "gemini";
-	audio-routing =	"RX_BIAS", "MCLK",
+	audio-routing = "RX_BIAS", "MCLK",
 		"MM_DL1",  "MultiMedia1 Playback",
 		"MM_DL2",  "MultiMedia2 Playback",
 		"MultiMedia3 Capture", "MM_UL3";
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 1e2dd6763ad1..30a9e4bed4af 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -137,7 +137,7 @@ &slpi_pil {
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "scorpio";
-	audio-routing =	"RX_BIAS", "MCLK";
+	audio-routing = "RX_BIAS", "MCLK";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9932186f7ceb..dba25ce32c8b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1001,7 +1001,7 @@ gpu: gpu@b00000 {
 			#cooling-cells = <2>;
 
 			gpu_opp_table: opp-table {
-				compatible  ="operating-points-v2";
+				compatible = "operating-points-v2";
 
 				/*
 				 * 624Mhz and 560Mhz are only available on speed
@@ -1623,7 +1623,7 @@ pcie0: pcie@600000 {
 					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
 
-				clock-names =  "pipe",
+				clock-names = "pipe",
 						"aux",
 						"cfg",
 						"bus_master",
@@ -1637,7 +1637,7 @@ pcie1: pcie@608000 {
 				bus-range = <0x00 0xff>;
 				num-lanes = <1>;
 
-				status  = "disabled";
+				status = "disabled";
 
 				reg = <0x00608000 0x2000>,
 				      <0x0d000000 0xf1d>,
@@ -1677,7 +1677,7 @@ pcie1: pcie@608000 {
 					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
 
-				clock-names =  "pipe",
+				clock-names = "pipe",
 						"aux",
 						"cfg",
 						"bus_master",
@@ -1727,7 +1727,7 @@ pcie2: pcie@610000 {
 					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
 					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
 
-				clock-names =  "pipe",
+				clock-names = "pipe",
 						"aux",
 						"cfg",
 						"bus_master",
@@ -3084,7 +3084,7 @@ slimbam: dma-controller@9184000 {
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0x09184000 0x32000>;
-			num-channels  = <31>;
+			num-channels = <31>;
 			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
@@ -3096,7 +3096,7 @@ slim_msm: slim@91c0000 {
 			reg = <0x091c0000 0x2C000>;
 			reg-names = "ctrl";
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
-			dmas =	<&slimbam 3>, <&slimbam 4>,
+			dmas = <&slimbam 3>, <&slimbam 4>,
 				<&slimbam 5>, <&slimbam 6>;
 			dma-names = "rx", "tx", "tx2", "rx2";
 			#address-cells = <1>;
@@ -3108,7 +3108,7 @@ ngd@1 {
 
 				tasha_ifd: tas-ifd {
 					compatible = "slim217,1a0";
-					reg  = <0 0>;
+					reg = <0 0>;
 				};
 
 				wcd9335: codec@1{
@@ -3116,17 +3116,17 @@ wcd9335: codec@1{
 					pinctrl-names = "default";
 
 					compatible = "slim217,1a0";
-					reg  = <1 0>;
+					reg = <1 0>;
 
 					interrupt-parent = <&tlmm>;
 					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
 						     <53 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names  = "intr1", "intr2";
+					interrupt-names = "intr1", "intr2";
 					interrupt-controller;
 					#interrupt-cells = <1>;
 					reset-gpios = <&tlmm 64 0>;
 
-					slim-ifc-dev  = <&tasha_ifd>;
+					slim-ifc-dev = <&tasha_ifd>;
 
 					#sound-dai-cells = <1>;
 				};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 758c45bbbe78..83ee820e7a9a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -929,7 +929,7 @@ pcie0: pci@1c00000 {
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map =	<0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
+			interrupt-map = <0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 2 &intc 0 0 136 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 3 &intc 0 0 138 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 4 &intc 0 0 139 IRQ_TYPE_LEVEL_HIGH>;
@@ -1416,7 +1416,7 @@ adreno_gpu: gpu@5000000 {
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
-				compatible  = "operating-points-v2";
+				compatible = "operating-points-v2";
 				opp-710000097 {
 					opp-hz = /bits/ 64 <710000097>;
 					opp-level = <RPM_SMD_LEVEL_TURBO>;
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0e63f707b911..90a1810f8a31 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -915,7 +915,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&lt9611_codec 0>;
+			sound-dai = <&lt9611_codec 0>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index acdb36f4479f..1806e2cae776 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -389,7 +389,7 @@ &sdhc_2 {
 	pinctrl-names = "default","sleep";
 	pinctrl-0 = <&sdc2_on>;
 	pinctrl-1 = <&sdc2_off>;
-	vmmc-supply  = <&vreg_l9c_2p9>;
+	vmmc-supply = <&vreg_l9c_2p9>;
 	vqmmc-supply = <&vreg_l6c_2p9>;
 
 	cd-gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8619311ff2fc..3a222ac71cca 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2048,7 +2048,7 @@ adreno_smmu: iommu@5040000 {
 		};
 
 		gmu: gmu@506a000 {
-			compatible="qcom,adreno-gmu-618.0", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-618.0", "qcom,adreno-gmu";
 			reg = <0 0x0506a000 0 0x31000>, <0 0x0b290000 0 0x10000>,
 				<0 0x0b490000 0 0x10000>;
 			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
@@ -3584,7 +3584,7 @@ lpass_cpu: lpass@62d87000 {
 			compatible = "qcom,sc7180-lpass-cpu";
 
 			reg = <0 0x62d87000 0 0x68000>, <0 0x62f00000 0 0x29000>;
-			reg-names =  "lpass-hdmiif", "lpass-lpaif";
+			reg-names = "lpass-hdmiif", "lpass-lpaif";
 
 			iommus = <&apps_smmu 0x1020 0>,
 				<&apps_smmu 0x1021 0>,
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 6bc8d206a258..b387fab78bd8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2201,7 +2201,7 @@ lpass_aon: clock-controller@3380000 {
 		lpasscore: clock-controller@3900000 {
 			compatible = "qcom,sc7280-lpasscorecc";
 			reg = <0 0x03900000 0 0x50000>;
-			clocks =  <&rpmhcc RPMH_CXO_CLK>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "bi_tcxo";
 			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
 			#clock-cells = <1>;
@@ -2305,7 +2305,7 @@ opp-900000000 {
 		};
 
 		gmu: gmu@3d6a000 {
-			compatible="qcom,adreno-gmu-635.0", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-635.0", "qcom,adreno-gmu";
 			reg = <0 0x03d6a000 0 0x34000>,
 				<0 0x3de0000 0 0x10000>,
 				<0 0x0b290000 0 0x10000>;
@@ -3733,7 +3733,7 @@ mdss_dp: displayport-controller@ae90000 {
 					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
 					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
-				clock-names =	"core_iface",
+				clock-names = "core_iface",
 						"core_aux",
 						"ctrl_link",
 						"ctrl_link_iface",
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 42af1fade461..03c18c74da30 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -34,7 +34,7 @@ framebuffer0: framebuffer@9d400000 {
 			height = <1920>;
 			stride = <(1080 * 4)>;
 			format = "a8r8g8b8";
-			status= "okay";
+			status = "okay";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 1ec033834c1c..b4367339d8b9 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1051,7 +1051,7 @@ adreno_gpu: gpu@5000000 {
 			operating-points-v2 = <&gpu_sdm630_opp_table>;
 
 			gpu_sdm630_opp_table: opp-table {
-				compatible  = "operating-points-v2";
+				compatible = "operating-points-v2";
 				opp-775000000 {
 					opp-hz = /bits/ 64 <775000000>;
 					opp-level = <RPM_SMD_LEVEL_TURBO>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index 1d748c5305f4..0ae36f8e9485 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -14,7 +14,7 @@ &adreno_gpu {
 	operating-points-v2 = <&gpu_sdm660_opp_table>;
 
 	gpu_sdm660_opp_table: opp-table {
-		compatible  = "operating-points-v2";
+		compatible = "operating-points-v2";
 
 		/*
 		 * 775MHz is only available on the highest speed bin
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e7e4cc5936aa..fd79ec7d95de 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -130,7 +130,7 @@ pen-insert {
 	};
 
 	panel: panel {
-		compatible ="innolux,p120zdg-bf1";
+		compatible = "innolux,p120zdg-bf1";
 		power-supply = <&pp3300_dx_edp>;
 		backlight = <&backlight>;
 		no-hpd;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..438877ee4937 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -718,7 +718,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&lt9611_codec 0>;
+			sound-dai = <&lt9611_codec 0>;
 		};
 	};
 
@@ -733,7 +733,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 103cc40816fd..66d8f9900486 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -468,7 +468,7 @@ zap-shader {
 };
 
 &i2c5 {
-	status="okay";
+	status = "okay";
 
 	touchscreen@38 {
 		compatible = "focaltech,fts8719";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index d88dc07205f7..521020f888e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -419,7 +419,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&wcd9340 0>;
+			sound-dai = <&wcd9340 0>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 64318ef765cf..2e9d93d6b28a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3640,7 +3640,7 @@ slim: slim@171c0000 {
 			qcom,apps-ch-pipes = <0x780000>;
 			qcom,ea-pc = <0x270>;
 			status = "okay";
-			dmas =	<&slimbam 3>, <&slimbam 4>,
+			dmas = <&slimbam 3>, <&slimbam 4>,
 				<&slimbam 5>, <&slimbam 6>;
 			dma-names = "rx", "tx", "tx2", "rx2";
 
@@ -3655,13 +3655,13 @@ ngd@1 {
 
 				wcd9340_ifd: ifd@0{
 					compatible = "slim217,250";
-					reg  = <0 0>;
+					reg = <0 0>;
 				};
 
 				wcd9340: codec@1{
 					compatible = "slim217,250";
-					reg  = <1 0>;
-					slim-ifc-dev  = <&wcd9340_ifd>;
+					reg = <1 0>;
+					slim-ifc-dev = <&wcd9340_ifd>;
 
 					#sound-dai-cells = <1>;
 
@@ -3692,8 +3692,8 @@ swm: swm@c85 {
 						reg = <0xc85 0x40>;
 						interrupts-extended = <&wcd9340 20>;
 
-						qcom,dout-ports	= <6>;
-						qcom,din-ports	= <2>;
+						qcom,dout-ports = <6>;
+						qcom,din-ports = <2>;
 						qcom,ports-sinterval-low =/bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
 						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
 						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
@@ -4574,7 +4574,7 @@ adreno_smmu: iommu@5040000 {
 		};
 
 		gmu: gmu@506a000 {
-			compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
 
 			reg = <0 0x506a000 0 0x30000>,
 			      <0 0xb280000 0 0x10000>,
@@ -4939,7 +4939,7 @@ slimbam: dma-controller@17184000 {
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels  = <31>;
+			num-channels = <31>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index f1619b3f97ef..9efc3bb874bf 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -581,7 +581,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
 		};
 	};
 
@@ -611,7 +611,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&wcd9340 2>;
+			sound-dai = <&wcd9340 2>;
 		};
 	};
 };
@@ -817,5 +817,5 @@ &wifi {
 
 &crypto {
 	/* FIXME: qce_start triggers an SError */
-	status= "disable";
+	status = "disable";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 2a552d817b03..b0315eeb1320 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -509,7 +509,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
 		};
 	};
 
@@ -539,7 +539,7 @@ platform {
 		};
 
 		codec {
-			sound-dai =  <&wcd9340 2>;
+			sound-dai = <&wcd9340 2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 0da88d843cbb..c0c96c557bb0 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2187,7 +2187,7 @@ opp-257000000 {
 		};
 
 		gmu: gmu@2c6a000 {
-			compatible="qcom,adreno-gmu-640.1", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-640.1", "qcom,adreno-gmu";
 
 			reg = <0 0x02c6a000 0 0x30000>,
 			      <0 0x0b290000 0 0x10000>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b0e7a7d47f4a..e13e0e8a786b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2569,7 +2569,7 @@ opp-305000000 {
 		};
 
 		gmu: gmu@3d6a000 {
-			compatible="qcom,adreno-gmu-650.2", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-650.2", "qcom,adreno-gmu";
 
 			reg = <0 0x03d6a000 0 0x30000>,
 			      <0 0x3de0000 0 0x10000>,
-- 
2.34.1

