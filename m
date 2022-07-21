Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9457CE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiGUOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGUOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC026549;
        Thu, 21 Jul 2022 07:50:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DDAB6601AAF;
        Thu, 21 Jul 2022 15:50:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415029;
        bh=iCe3nCCYP+CXI4lEolJz5G4aPJpz8Pwnh2r8Gx2Y2to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awtLGO2z/IVaa/9TR30oGf/O6xtPL8RZe/1QTAELT4kg6HOyl/GK/K8De+8jQRqMd
         znBpAK/DD7dehom2b5bfcZCprsbz0O96KiUNMt/7CIdX8Ixn6qLO42tmvhtlsOmxF2
         ebGndDoSoRar6bxJW9kGf/F6+COboH9SJ9mFS1rMN1tqJWcPgEalEDH31Y/nPTGa3U
         yGnQMXFrGKpGlqJg4D3bHR78taYD8ZXG5polIVwxQxXrKhFdYYykfI7YgtLCe0bjG2
         wskXi9GCrIj5NTPxSQecHiq9765t0L86yZqXSHAMTAhSNM+iBx2zczvvjA+oAxomPP
         10U7x0jvPfKEA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/8] arm64: dts: mediatek: cherry: Wire up the ChromeOS EC and GSC
Date:   Thu, 21 Jul 2022 16:50:11 +0200
Message-Id: <20220721145017.918102-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the ChromeOS Embedded Controller on SPI0 and its communication
channel via SCP RPMSG along with all of the offered functionality,
including Keyboard, Smart Battery Metrics (SBS), PWM controller, I2C
tunnel, regulators and Type-C connector management.

While at it, also add support for the Cr50 Google Security Chip (GSC)
found on this platform on I2C3 to support TPM and also use it as an
entropy source for the kernel.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index feebbe367e93..87ac2b4f9814 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -149,6 +149,14 @@ &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
+
+	cr50@50 {
+		compatible = "google,cr50";
+		reg = <0x50>;
+		interrupts-extended = <&pio 88 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cr50_int>;
+	};
 };
 
 &i2c4 {
@@ -426,6 +434,21 @@ &pio {
 		"AP_SPI_FLASH_MOSI",
 		"AP_SPI_FLASH_MISO";
 
+	cr50_int: cr50-irq-default-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO88__FUNC_GPIO88>;
+			input-enable;
+		};
+	};
+
+	cros_ec_int: cros-ec-irq-default-pins {
+		pins-ec-ap-int-odl {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			input-enable;
+		};
+	};
+
 	i2c0_pins: i2c0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
@@ -669,6 +692,11 @@ &scp {
 	memory-region = <&scp_mem>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&scp_pins>;
+
+	cros-ec-rpmsg {
+		compatible = "google,cros-ec-rpmsg";
+		mediatek,rpmsg-name = "cros-ec-rpmsg";
+	};
 };
 
 &spi0 {
@@ -677,6 +705,68 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
 	mediatek,pad-select = <0>;
+
+	cros_ec: ec@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		interrupts-extended = <&pio 4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cros_ec_int>;
+		spi-max-frequency = <3000000>;
+
+		cros_ec_pwm: ec-pwm {
+			compatible = "google,cros-ec-pwm";
+			#pwm-cells = <1>;
+		};
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mt_pmic_vmc_ldo_reg: regulator@0 {
+			compatible = "google,cros-ec-regulator";
+			reg = <0>;
+			regulator-name = "mt_pmic_vmc_ldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		mt_pmic_vmch_ldo_reg: regulator@1 {
+			compatible = "google,cros-ec-regulator";
+			reg = <1>;
+			regulator-name = "mt_pmic_vmch_ldo";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+
+			usb_c1: connector@1 {
+				compatible = "usb-c-connector";
+				reg = <1>;
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+		};
+	};
 };
 
 &u3phy0 {
@@ -728,3 +818,6 @@ &xhci3 {
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
 };
+
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>
-- 
2.35.1

