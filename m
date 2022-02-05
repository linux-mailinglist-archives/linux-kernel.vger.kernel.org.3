Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365F4AAB81
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381609AbiBES40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:56:26 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41147 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381102AbiBESzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:09 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E76324000E;
        Sat,  5 Feb 2022 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFgB4m27O07rnmur1ieq1ePYGmAaOz1tQ2Kuen+iRL8=;
        b=dsEl8oIejDBXr8Q18aN37r9Qod3PW3OicinBxdM3b0G4Q65BD9WI4ZtIckqLyVripOs1ta
        SzziDBzEfEMvgvftK/NSQJbsW2vXD6K+m+his05M5qPJi/HkLnbXEpyZn2UG55WKK7y9cQ
        GhOpuDeSL8zggDr0fDcTTc3tA5EE8Q623SQqloEN5Zn8beXrDnA3ipAIFL4BHTF7S0Pewq
        wiG4sezRLNERX6+BgoAe+90x8EikBFfdLJXgyxjva5Ud8fxD1TaPQPVUKsLbGrQsNqaYkH
        390QSoSWWndIQUIvbgDNPM0YdR6L3md129teCks8BHpjTBLWYUWbVJMMmAYI3g==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
Subject: [PATCH NOT FOR MERGE v2 16/66] ARM: dts: sun8i: a83t: bananapi-m3: Enable MIPI CSI-2 with OV8865
Date:   Sat,  5 Feb 2022 19:53:39 +0100
Message-Id: <20220205185429.2278860-17-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kévin L'hôpital <kevin.lhopital@bootlin.com>

The Bananapi M3 supports a camera module which includes an OV8865 sensor
connected via the parallel CSI interface and an OV8865 sensor connected
via MIPI CSI-2.

The I2C2 bus is shared by the two sensors as well as the (active-low)
reset signal, but each sensor has it own shutdown line.

Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 5a7e1bd5f825..80fd99cf24b2 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -85,6 +85,30 @@ led-1 {
 		};
 	};
 
+	reg_ov8865_avdd: ov8865-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-avdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_dldo4>;
+	};
+
+	reg_ov8865_dovdd: ov8865-dovdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-dovdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_dldo4>;
+	};
+
+	reg_ov8865_dvdd: ov8865-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_eldo1>;
+	};
+
 	reg_usb1_vbus: reg-usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -115,6 +139,23 @@ &cpu100 {
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&csi {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			csi_in_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_out_csi>;
+			};
+		};
+	};
+};
+
 &de {
 	status = "okay";
 };
@@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pe_pins>;
+	status = "okay";
+
+	ov8865: camera@36 {
+		compatible = "ovti,ov8865";
+		reg = <0x36>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&csi_mclk_pin>;
+		clocks = <&ccu CLK_CSI_MCLK>;
+		assigned-clocks = <&ccu CLK_CSI_MCLK>;
+		assigned-clock-rates = <24000000>;
+		avdd-supply = <&reg_ov8865_avdd>;
+		dovdd-supply = <&reg_ov8865_dovdd>;
+		dvdd-supply = <&reg_ov8865_dvdd>;
+		powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
+
+		port {
+			ov8865_out_mipi_csi2: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <360000000>;
+
+				remote-endpoint = <&mipi_csi2_in_ov8865>;
+			};
+		};
+	};
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&mipi_csi2 {
+	status = "okay";
+};
+
+&mipi_csi2_in {
+	mipi_csi2_in_ov8865: endpoint {
+		data-lanes = <1 2 3 4>;
+
+		remote-endpoint = <&ov8865_out_mipi_csi2>;
+	};
+};
+
+&mipi_csi2_out {
+	mipi_csi2_out_csi: endpoint {
+		remote-endpoint = <&csi_in_mipi_csi2>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -327,11 +416,24 @@ &reg_dldo3 {
 	regulator-name = "vcc-pd";
 };
 
+&reg_dldo4 {
+	regulator-always-on;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
 &reg_drivevbus {
 	regulator-name = "usb0-vbus";
 	status = "okay";
 };
 
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "dvdd-csi-r";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1080000>;
 	regulator-max-microvolt = <1320000>;
-- 
2.34.1

