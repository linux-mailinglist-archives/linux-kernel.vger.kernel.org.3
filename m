Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B153463C17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbhK3Qqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:46:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhK3Qqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:46:37 -0500
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDEC21447;
        Tue, 30 Nov 2021 17:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638290596;
        bh=jlB2sdg+kf/oR6NWJ2UZDgcX8xPpxtftObNb0ng3GPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=En3iFUHA1mfxCdJ8mA1eIX25GHjNzikYZ7UCNAWOweF67/OcBRDy/VBbnflicxZTv
         yDKYMhDEQwoX0nIK67Z9bsMysMtZGnav74estXCOhTMcUUDVHHnyJdR2KIjE0lcOZh
         PqZUM8XXVQ1MZjMoytczSIuurfbyqFg4c9h1xIdw=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/2] arm64: dts: renesas: r8a779a0: falcon-cpu: Add DSI display output
Date:   Tue, 30 Nov 2021 16:43:11 +0000
Message-Id: <20211130164311.2909616-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com>
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the display output using the sn65dsi86 MIPI DSI bridge

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v3:
 - Fix the voltage regulator values
 - No longer override the clocks
 - use clk-x6 as clock node name

v4:
 - No change

v5:
 - Override/define dsi0_out endpoints entirely

 .../boot/dts/renesas/r8a779a0-falcon-cpu.dtsi | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
index cd2f0d60f21a..b82f2e53403c 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
@@ -98,6 +98,15 @@ memory@700000000 {
 		reg = <0x7 0x00000000 0x0 0x80000000>;
 	};
 
+	reg_1p2v: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -115,6 +124,41 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	mini-dp-con {
+		compatible = "dp-connector";
+		label = "CN5";
+		type = "mini";
+
+		port {
+			mini_dp_con_in: endpoint {
+				remote-endpoint = <&sn65dsi86_out>;
+			};
+		};
+	};
+
+	sn65dsi86_refclk: clk-x6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
+};
+
+&dsi0 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			dsi0_out: endpoint {
+				remote-endpoint = <&sn65dsi86_in>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&du {
+	status = "okay";
 };
 
 &extal_clk {
@@ -146,6 +190,41 @@ &i2c1 {
 
 	status = "okay";
 	clock-frequency = <400000>;
+
+	sn65dsi86@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+
+		clocks = <&sn65dsi86_refclk>;
+		clock-names = "refclk";
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+
+		vccio-supply = <&reg_1p8v>;
+		vpll-supply = <&reg_1p8v>;
+		vcca-supply = <&reg_1p2v>;
+		vcc-supply = <&reg_1p2v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sn65dsi86_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				sn65dsi86_out: endpoint {
+					remote-endpoint = <&mini_dp_con_in>;
+				};
+			};
+		};
+	};
 };
 
 &i2c6 {
-- 
2.30.2

