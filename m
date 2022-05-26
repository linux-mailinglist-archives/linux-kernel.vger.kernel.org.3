Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896A95354CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiEZUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiEZUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181329FF5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h11so3148553eda.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lS+yVw/UEROJ1LPM9xKpYs4sSd97gWwWnZwsQzSsXXk=;
        b=rLygfMR1m/HojGt0M8S3VPCphQHDEzaZaW3j/ojF7G60BWJgW1tHJURTt8+anRO8Jg
         HHfXBECykwCOb2nk1l0UJLEqTfllLYM+ptf/LGhxcHPk/yR6nBa4CFn/x6UCP+r7JXmf
         aGX8otG7MNcZjvKSqyLhj5onrBi0xc6+jryo25p1kHM8fiKQAWYrpWOpg6cgdXKXRmni
         SGaQVv2VeXcN1grJVmnW4a78kn6e7CEiqBdSt/b6osr3jl6Nl8ouJfOSDTIMbsTpGq4l
         PTJh4x8G7ZLDGNg0mtSb/KWsAr5QwZ6axrfFWeONWofyhbt0ka4UIcwcFD70Jwh+hvuf
         7wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lS+yVw/UEROJ1LPM9xKpYs4sSd97gWwWnZwsQzSsXXk=;
        b=JkjrFk8GAmHJmw8BgYjfUKpWdhbtfVkCLVkQ10mXl4CCDvuQhU7Gezb7rWK1cou0RX
         c9TR4wX+zSL2U3065t4ki6lSCwd+e644uz2w5mz4MVg4BK68PHiocPdQeXrXAr+CUH2k
         svaltnRBFCx/lYCV83VwY/8FdmE6ZhhOCo31UT+xR8qoFM6YP+SPsdkWbdHlVFRpLq01
         XfvsACiQt44xEtJ0bDxlpTuZyJXA4u0Buy57mF66KM8FmDsZzKqLAnn8ebiIKLfK522e
         d55651tJ9H2pImlJ1p61r9yjcipIdaD5nuRQlA3ahcLEPu0wuFFWzjAQhL8qYvp9tMcU
         Qf9A==
X-Gm-Message-State: AOAM530u2sRZwoCIUyV+fzxhuuMva1QYxylUgFrNrHlpMZSnl0JMHHrV
        WaWeq4xLxNfEWm+sTrbUFeBzew==
X-Google-Smtp-Source: ABdhPJyg8RWSK9D3f3fReUoyZGIrfWhUTUG+8XIlvoJy8dmRd+5mG13G6dsEiENAibzOyWlOtt4YCg==
X-Received: by 2002:a05:6402:27cd:b0:42b:5ba8:f744 with SMTP id c13-20020a05640227cd00b0042b5ba8f744mr25494976ede.81.1653597773323;
        Thu, 26 May 2022 13:42:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id de30-20020a1709069bde00b006f3ef214debsm810551ejc.81.2022.05.26.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:48 +0200
Message-Id: <20220526204248.832139-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204248.832139-1-krzysztof.kozlowski@linaro.org>
References: <20220526204248.832139-1-krzysztof.kozlowski@linaro.org>
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
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  16 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts   |  10 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts    |  14 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 150 +++++++++---------
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  32 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |   6 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           | 112 ++++++-------
 arch/arm/boot/dts/qcom-msm8960.dtsi           |  54 +++----
 .../dts/qcom-msm8974pro-fairphone-fp2.dts     |   6 +-
 9 files changed, 200 insertions(+), 200 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index ca9f73528196..beb2058fd116 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -24,9 +24,9 @@ reserved-memory {
 		ramoops@88d00000{
 			compatible = "ramoops";
 			reg = <0x88d00000 0x100000>;
-			record-size     = <0x00020000>;
-			console-size    = <0x00020000>;
-			ftrace-size     = <0x00020000>;
+			record-size = <0x00020000>;
+			console-size = <0x00020000>;
+			ftrace-size = <0x00020000>;
 		};
 	};
 
@@ -98,8 +98,8 @@ s3 {
 				 * tabla2x-slim-VDDIO_CDC
 				 */
 				s4 {
-					regulator-min-microvolt	= <1800000>;
-					regulator-max-microvolt	= <1800000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					qcom,switch-mode-frequency = <3200000>;
 					regulator-always-on;
 				};
@@ -349,9 +349,9 @@ reboot-mode {
 				compatible = "syscon-reboot-mode";
 				offset = <0x65c>;
 
-				mode-normal	= <0x77665501>;
-				mode-bootloader	= <0x77665500>;
-				mode-recovery	= <0x77665502>;
+				mode-normal = <0x77665501>;
+				mode-bootloader = <0x77665500>;
+				mode-recovery = <0x77665502>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index e068a8d0adf0..17a4f5a7083f 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -82,8 +82,8 @@ s3 {
 				};
 
 				s4 {
-					regulator-min-microvolt	= <1800000>;
-					regulator-max-microvolt	= <1800000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
@@ -230,9 +230,9 @@ sdcc1: mmc@12400000 {
 			sdcc3: mmc@12180000 {
 				status = "okay";
 				vmmc-supply = <&v3p3_fixed>;
-				pinctrl-names	= "default";
-				pinctrl-0	= <&card_detect>;
-				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&card_detect>;
+				cd-gpios = <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
 			};
 			/* WLAN */
 			sdcc4: mmc@121c0000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 2638b380be20..ef4de9fec470 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -108,8 +108,8 @@ s3 {
 				};
 
 				s4 {
-					regulator-min-microvolt	= <1800000>;
-					regulator-max-microvolt	= <1800000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
@@ -240,8 +240,8 @@ sata_phy0: phy@1b400000 {
 		};
 
 		sata0: sata@29000000 {
-			status		= "okay";
-			target-supply	= <&pm8921_s4>;
+			status = "okay";
+			target-supply = <&pm8921_s4>;
 		};
 
 		/* OTG */
@@ -324,9 +324,9 @@ sdcc1: mmc@12400000 {
 			sdcc3: mmc@12180000 {
 				status = "okay";
 				vmmc-supply = <&pm8921_l6>;
-				pinctrl-names	= "default";
-				pinctrl-0	= <&card_detect>;
-				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&card_detect>;
+				cd-gpios = <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
 			};
 			/* WLAN */
 			sdcc4: mmc@121c0000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 34c0ba7fa358..b8736304a8f1 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -430,8 +430,8 @@ saw3: power-controller@20b9000 {
 		};
 
 		sps_sic_non_secure: sps-sic-non-secure@12100000 {
-			compatible	= "syscon";
-			reg		= <0x12100000 0x10000>;
+			compatible = "syscon";
+			reg = <0x12100000 0x10000>;
 		};
 
 		gsbi1: gsbi@12440000 {
@@ -796,10 +796,10 @@ ref_muxoff: adc-channel@f {
 		};
 
 		qfprom: qfprom@700000 {
-			compatible	= "qcom,qfprom";
-			reg		= <0x00700000 0x1000>;
-			#address-cells	= <1>;
-			#size-cells	= <1>;
+			compatible = "qcom,qfprom";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			ranges;
 			tsens_calib: calib {
 				reg = <0x404 0x10>;
@@ -836,22 +836,22 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
-			reg		= <0x2011000 0x1000>;
+			compatible = "qcom,kpss-gcc", "syscon";
+			reg = <0x2011000 0x1000>;
 		};
 
 		rpm@108000 {
-			compatible	= "qcom,rpm-apq8064";
-			reg		= <0x108000 0x1000>;
-			qcom,ipc	= <&l2cc 0x8 2>;
+			compatible = "qcom,rpm-apq8064";
+			reg = <0x108000 0x1000>;
+			qcom,ipc = <&l2cc 0x8 2>;
 
-			interrupts	= <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names	= "ack", "err", "wakeup";
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ack", "err", "wakeup";
 
 			rpmcc: clock-controller {
-				compatible	= "qcom,rpmcc-apq8064", "qcom,rpmcc";
+				compatible = "qcom,rpmcc-apq8064", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
 
@@ -1004,39 +1004,39 @@ usb_hs4_phy: phy {
 		};
 
 		sata_phy0: phy@1b400000 {
-			compatible	= "qcom,apq8064-sata-phy";
-			status		= "disabled";
-			reg		= <0x1b400000 0x200>;
-			reg-names	= "phy_mem";
-			clocks		= <&gcc SATA_PHY_CFG_CLK>;
-			clock-names	= "cfg";
-			#phy-cells	= <0>;
+			compatible = "qcom,apq8064-sata-phy";
+			status = "disabled";
+			reg = <0x1b400000 0x200>;
+			reg-names = "phy_mem";
+			clocks = <&gcc SATA_PHY_CFG_CLK>;
+			clock-names = "cfg";
+			#phy-cells = <0>;
 		};
 
 		sata0: sata@29000000 {
-			compatible		= "qcom,apq8064-ahci", "generic-ahci";
-			status			= "disabled";
-			reg			= <0x29000000 0x180>;
-			interrupts		= <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks			= <&gcc SFAB_SATA_S_H_CLK>,
-						<&gcc SATA_H_CLK>,
-						<&gcc SATA_A_CLK>,
-						<&gcc SATA_RXOOB_CLK>,
-						<&gcc SATA_PMALIVE_CLK>;
-			clock-names		= "slave_iface",
-						"iface",
-						"bus",
-						"rxoob",
-						"core_pmalive";
-
-			assigned-clocks		= <&gcc SATA_RXOOB_CLK>,
-						<&gcc SATA_PMALIVE_CLK>;
-			assigned-clock-rates	= <100000000>, <100000000>;
-
-			phys			= <&sata_phy0>;
-			phy-names		= "sata-phy";
-			ports-implemented	= <0x1>;
+			compatible = "qcom,apq8064-ahci", "generic-ahci";
+			status	 = "disabled";
+			reg	 = <0x29000000 0x180>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc SFAB_SATA_S_H_CLK>,
+				 <&gcc SATA_H_CLK>,
+				 <&gcc SATA_A_CLK>,
+				 <&gcc SATA_RXOOB_CLK>,
+				 <&gcc SATA_PMALIVE_CLK>;
+			clock-names = "slave_iface",
+				      "iface",
+				      "bus",
+				      "rxoob",
+				      "core_pmalive";
+
+			assigned-clocks = <&gcc SATA_RXOOB_CLK>,
+					  <&gcc SATA_PMALIVE_CLK>;
+			assigned-clock-rates = <100000000>, <100000000>;
+
+			phys = <&sata_phy0>;
+			phy-names = "sata-phy";
+			ports-implemented = <0x1>;
 		};
 
 		/* Temporary fixed regulator */
@@ -1076,18 +1076,18 @@ amba {
 			#size-cells = <1>;
 			ranges;
 			sdcc1: mmc@12400000 {
-				status		= "disabled";
-				compatible	= "arm,pl18x", "arm,primecell";
-				pinctrl-names	= "default";
-				pinctrl-0	= <&sdcc1_pins>;
+				status = "disabled";
+				compatible = "arm,pl18x", "arm,primecell";
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdcc1_pins>;
 				arm,primecell-periphid = <0x00051180>;
-				reg		= <0x12400000 0x2000>;
-				interrupts	= <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <8>;
-				max-frequency	= <96000000>;
+				reg = <0x12400000 0x2000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
+				max-frequency = <96000000>;
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
@@ -1096,36 +1096,36 @@ sdcc1: mmc@12400000 {
 			};
 
 			sdcc3: mmc@12180000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x12180000 0x2000>;
-				interrupts	= <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
+				status = "disabled";
+				reg = <0x12180000 0x2000>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency	= <192000000>;
+				max-frequency = <192000000>;
 				no-1-8-v;
 				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
 				dma-names = "tx", "rx";
 			};
 
 			sdcc4: mmc@121c0000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x121c0000 0x2000>;
-				interrupts	= <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
+				status = "disabled";
+				reg = <0x121c0000 0x2000>;
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency	= <48000000>;
+				max-frequency = <48000000>;
 				dmas = <&sdcc4bam 2>, <&sdcc4bam 1>;
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 808ea1862283..25ee50123d27 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1184,16 +1184,16 @@ amba: amba {
 			ranges;
 
 			sdcc1: mmc@12400000 {
-				status          = "disabled";
-				compatible      = "arm,pl18x", "arm,primecell";
+				status = "disabled";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				reg             = <0x12400000 0x2000>;
-				interrupts      = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x12400000 0x2000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "cmd_irq";
-				clocks          = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
-				clock-names     = "mclk", "apb_pclk";
-				bus-width       = <8>;
-				max-frequency   = <96000000>;
+				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
+				max-frequency = <96000000>;
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
@@ -1204,18 +1204,18 @@ sdcc1: mmc@12400000 {
 			};
 
 			sdcc3: mmc@12180000 {
-				compatible      = "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status          = "disabled";
-				reg             = <0x12180000 0x2000>;
-				interrupts      = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				reg = <0x12180000 0x2000>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "cmd_irq";
-				clocks          = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
-				clock-names     = "mclk", "apb_pclk";
-				bus-width       = <8>;
+				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency   = <192000000>;
+				max-frequency = <192000000>;
 				sd-uhs-sdr104;
 				sd-uhs-ddr50;
 				vqmmc-supply = <&vsdcc_fixed>;
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 8f0752ce1c7b..4993dcac0769 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -361,7 +361,7 @@ sdcc1: mmc@12180000 {
 				arm,primecell-periphid = <0x00051180>;
 				reg = <0x12180000 0x2000>;
 				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
+				interrupt-names = "cmd_irq";
 				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
 				clock-names = "mclk", "apb_pclk";
 				bus-width = <8>;
@@ -381,7 +381,7 @@ sdcc2: mmc@12140000 {
 				status = "disabled";
 				reg = <0x12140000 0x2000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
+				interrupt-names = "cmd_irq";
 				clocks = <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
 				clock-names = "mclk", "apb_pclk";
 				bus-width = <4>;
@@ -411,7 +411,7 @@ rpm: rpm@108000 {
 			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names	= "ack", "err", "wakeup";
+			interrupt-names = "ack", "err", "wakeup";
 
 			regulators {
 				compatible = "qcom,rpm-pm8018-regulators";
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 47b97daecef1..b9cded35b1cc 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -392,24 +392,24 @@ vibrator@4a {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
-			reg		= <0x02082000 0x1000>;
+			compatible = "qcom,kpss-gcc", "syscon";
+			reg = <0x02082000 0x1000>;
 		};
 
 		rpm: rpm@104000 {
-			compatible	= "qcom,rpm-msm8660";
-			reg		= <0x00104000 0x1000>;
-			qcom,ipc	= <&l2cc 0x8 2>;
-
-			interrupts	= <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names	= "ack", "err", "wakeup";
+			compatible = "qcom,rpm-msm8660";
+			reg = <0x00104000 0x1000>;
+			qcom,ipc = <&l2cc 0x8 2>;
+
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ack", "err", "wakeup";
 			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
 			clock-names = "ram";
 
 			rpmcc: clock-controller {
-				compatible	= "qcom,rpmcc-msm8660", "qcom,rpmcc";
+				compatible = "qcom,rpmcc-msm8660", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
 
@@ -486,80 +486,80 @@ amba {
 			#size-cells = <1>;
 			ranges;
 			sdcc1: mmc@12400000 {
-				status		= "disabled";
-				compatible	= "arm,pl18x", "arm,primecell";
+				status = "disabled";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				reg		= <0x12400000 0x8000>;
-				interrupts	= <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <8>;
-				max-frequency	= <48000000>;
+				reg = <0x12400000 0x8000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
+				max-frequency = <48000000>;
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 			};
 
 			sdcc2: mmc@12140000 {
-				status		= "disabled";
-				compatible	= "arm,pl18x", "arm,primecell";
+				status = "disabled";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				reg		= <0x12140000 0x8000>;
-				interrupts	= <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <8>;
-				max-frequency	= <48000000>;
+				reg = <0x12140000 0x8000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
+				max-frequency = <48000000>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 			};
 
 			sdcc3: mmc@12180000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x12180000 0x8000>;
-				interrupts	= <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
+				status = "disabled";
+				reg = <0x12180000 0x8000>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency	= <48000000>;
+				max-frequency = <48000000>;
 				no-1-8-v;
 			};
 
 			sdcc4: mmc@121c0000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x121c0000 0x8000>;
-				interrupts	= <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
-				max-frequency	= <48000000>;
+				status = "disabled";
+				reg = <0x121c0000 0x8000>;
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
+				max-frequency = <48000000>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 			};
 
 			sdcc5: mmc@12200000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x12200000 0x8000>;
-				interrupts	= <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC5_CLK>, <&gcc SDC5_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
+				status = "disabled";
+				reg = <0x12200000 0x8000>;
+				interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC5_CLK>, <&gcc SDC5_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency	= <48000000>;
+				max-frequency = <48000000>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 4a2d74cf01d2..19554f3b5196 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -148,19 +148,19 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
-			reg		= <0x2011000 0x1000>;
+			compatible = "qcom,kpss-gcc", "syscon";
+			reg = <0x2011000 0x1000>;
 		};
 
 		rpm@108000 {
-			compatible	= "qcom,rpm-msm8960";
-			reg		= <0x108000 0x1000>;
-			qcom,ipc	= <&l2cc 0x8 2>;
+			compatible = "qcom,rpm-msm8960";
+			reg = <0x108000 0x1000>;
+			qcom,ipc = <&l2cc 0x8 2>;
 
-			interrupts	= <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-					  <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names	= "ack", "err", "wakeup";
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ack", "err", "wakeup";
 
 			regulators {
 				compatible = "qcom,rpm-pm8921-regulators";
@@ -268,16 +268,16 @@ amba {
 			#size-cells = <1>;
 			ranges;
 			sdcc1: mmc@12400000 {
-				status		= "disabled";
-				compatible	= "arm,pl18x", "arm,primecell";
+				status = "disabled";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				reg		= <0x12400000 0x8000>;
-				interrupts	= <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <8>;
-				max-frequency	= <96000000>;
+				reg = <0x12400000 0x8000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <8>;
+				max-frequency = <96000000>;
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
@@ -285,18 +285,18 @@ sdcc1: mmc@12400000 {
 			};
 
 			sdcc3: mmc@12180000 {
-				compatible	= "arm,pl18x", "arm,primecell";
+				compatible = "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-				status		= "disabled";
-				reg		= <0x12180000 0x8000>;
-				interrupts	= <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "cmd_irq";
-				clocks		= <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
-				clock-names	= "mclk", "apb_pclk";
-				bus-width	= <4>;
+				status = "disabled";
+				reg = <0x12180000 0x8000>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
+				clock-names = "mclk", "apb_pclk";
+				bus-width = <4>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				max-frequency	= <192000000>;
+				max-frequency = <192000000>;
 				no-1-8-v;
 				vmmc-supply = <&vsdcc_fixed>;
 			};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 58cb2ce1e4df..670612b055bb 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -78,9 +78,9 @@ &blsp1_uart2 {
 
 &imem {
 	reboot-mode {
-		mode-normal	= <0x77665501>;
-		mode-bootloader	= <0x77665500>;
-		mode-recovery	= <0x77665502>;
+		mode-normal = <0x77665501>;
+		mode-bootloader = <0x77665500>;
+		mode-recovery = <0x77665502>;
 	};
 };
 
-- 
2.34.1

