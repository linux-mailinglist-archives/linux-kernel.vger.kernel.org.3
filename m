Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C15476FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhLPLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhLPLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFCC061763;
        Thu, 16 Dec 2021 03:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D5861D56;
        Thu, 16 Dec 2021 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9D5C36AE4;
        Thu, 16 Dec 2021 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639653227;
        bh=gMXmFhtLeMbk5UzSPS/4Gdgc3GP5hLxghjc/b2jNE9s=;
        h=From:To:Cc:Subject:Date:From;
        b=K+QjIugxSdwiZATq3e89aDOhzWpGezmWEn8qA2haQR1IMBHZyG/pUVZwzUF6+vtYI
         VpSP6k8JftD/8jl++rl+hz6wQmCMm0OZbHXMXBhC7j7NckDPzfCYLg5Sju9cuIRtGD
         E/lIVEyUnl7SZFSBWrMpZkM1YaNxPvVM+ERksoCLQovjOdkPQY5XvLfUSu641Y2iWL
         SOPQUq+KPp7E/yRWuWY821alxTINjohn+OWB+GABGpNJDRbjQhFmV3sPY5bqo2gsqA
         9udeDixOFo8n6whUiUD5iyOdJSXLXM4ovzRhmcSQdbGgVvUMedYaoX/D0/kjnbxBVK
         qYd4pvIZFrnDw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH] arm64: boot: dts: qcom: sm8150: add SPI nodes
Date:   Thu, 16 Dec 2021 13:13:41 +0200
Message-Id: <20211216111341.304151-1-balbi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

Add missing SPI nodes for SM8150.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 419 +++++++++++++++++++++++++++
 1 file changed, 419 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index eef9d79157e9..71b286c2a38b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -626,6 +626,20 @@ i2c0: i2c@880000 {
 				status = "disabled";
 			};
 
+			spi0: spi@880000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x880000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c1: i2c@884000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00884000 0 0x4000>;
@@ -639,6 +653,20 @@ i2c1: i2c@884000 {
 				status = "disabled";
 			};
 
+			spi1: spi@884000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x884000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c2: i2c@888000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00888000 0 0x4000>;
@@ -652,6 +680,20 @@ i2c2: i2c@888000 {
 				status = "disabled";
 			};
 
+			spi2: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x888000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c3: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0088c000 0 0x4000>;
@@ -665,6 +707,20 @@ i2c3: i2c@88c000 {
 				status = "disabled";
 			};
 
+			spi3: spi@88c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x88c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c4: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00890000 0 0x4000>;
@@ -678,6 +734,20 @@ i2c4: i2c@890000 {
 				status = "disabled";
 			};
 
+			spi4: spi@890000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x890000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c5: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
@@ -691,6 +761,20 @@ i2c5: i2c@894000 {
 				status = "disabled";
 			};
 
+			spi5: spi@894000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x894000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c6: i2c@898000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00898000 0 0x4000>;
@@ -704,6 +788,20 @@ i2c6: i2c@898000 {
 				status = "disabled";
 			};
 
+			spi6: spi@898000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c7: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -717,6 +815,19 @@ i2c7: i2c@89c000 {
 				status = "disabled";
 			};
 
+			spi7: spi@89c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x89c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		gpi_dma1: dma-controller@a00000 {
@@ -767,6 +878,20 @@ i2c8: i2c@a80000 {
 				status = "disabled";
 			};
 
+			spi8: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa80000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a84000 0 0x4000>;
@@ -780,6 +905,20 @@ i2c9: i2c@a84000 {
 				status = "disabled";
 			};
 
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa84000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c10: i2c@a88000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a88000 0 0x4000>;
@@ -793,6 +932,20 @@ i2c10: i2c@a88000 {
 				status = "disabled";
 			};
 
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa88000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a8c000 0 0x4000>;
@@ -806,6 +959,20 @@ i2c11: i2c@a8c000 {
 				status = "disabled";
 			};
 
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			uart2: serial@a90000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x00a90000 0x0 0x4000>;
@@ -828,6 +995,20 @@ i2c12: i2c@a90000 {
 				status = "disabled";
 			};
 
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa90000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c16: i2c@94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0094000 0 0x4000>;
@@ -840,6 +1021,20 @@ i2c16: i2c@94000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			spi16: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xa94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi16_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		gpi_dma2: dma-controller@c00000 {
@@ -891,6 +1086,20 @@ i2c17: i2c@c80000 {
 				status = "disabled";
 			};
 
+			spi17: spi@c80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc80000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi17_default>;
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@c84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c84000 0 0x4000>;
@@ -904,6 +1113,20 @@ i2c18: i2c@c84000 {
 				status = "disabled";
 			};
 
+			spi18: spi@c84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc84000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi18_default>;
+				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c19: i2c@c88000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c88000 0 0x4000>;
@@ -917,6 +1140,20 @@ i2c19: i2c@c88000 {
 				status = "disabled";
 			};
 
+			spi19: spi@c88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc88000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi19_default>;
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c13: i2c@c8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c8c000 0 0x4000>;
@@ -930,6 +1167,20 @@ i2c13: i2c@c8c000 {
 				status = "disabled";
 			};
 
+			spi13: spi@c8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi13_default>;
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;
@@ -943,6 +1194,20 @@ i2c14: i2c@c90000 {
 				status = "disabled";
 			};
 
+			spi14: spi@c90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc90000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi14_default>;
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c15: i2c@c94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c94000 0 0x4000>;
@@ -955,6 +1220,20 @@ i2c15: i2c@c94000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			spi15: spi@c94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0xc94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi15_default>;
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency = <50000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		config_noc: interconnect@1500000 {
@@ -1296,6 +1575,13 @@ config {
 				};
 			};
 
+			qup_spi0_default: qup-spi0-default {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "qup0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c1_default: qup-i2c1-default {
 				mux {
 					pins = "gpio114", "gpio115";
@@ -1309,6 +1595,13 @@ config {
 				};
 			};
 
+			qup_spi1_default: qup-spi1-default {
+				pins = "gpio114", "gpio115", "gpio116", "gpio117";
+				function = "qup1";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c2_default: qup-i2c2-default {
 				mux {
 					pins = "gpio126", "gpio127";
@@ -1322,6 +1615,13 @@ config {
 				};
 			};
 
+			qup_spi2_default: qup-spi2-default {
+				pins = "gpio126", "gpio127", "gpio128", "gpio129";
+				function = "qup2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c3_default: qup-i2c3-default {
 				mux {
 					pins = "gpio144", "gpio145";
@@ -1335,6 +1635,13 @@ config {
 				};
 			};
 
+			qup_spi3_default: qup-spi3-default {
+				pins = "gpio144", "gpio145", "gpio146", "gpio147";
+				function = "qup3";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c4_default: qup-i2c4-default {
 				mux {
 					pins = "gpio51", "gpio52";
@@ -1348,6 +1655,13 @@ config {
 				};
 			};
 
+			qup_spi4_default: qup-spi4-default {
+				pins = "gpio51", "gpio52", "gpio53", "gpio54";
+				function = "qup4";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c5_default: qup-i2c5-default {
 				mux {
 					pins = "gpio121", "gpio122";
@@ -1361,6 +1675,13 @@ config {
 				};
 			};
 
+			qup_spi5_default: qup-spi5-default {
+				pins = "gpio119", "gpio120", "gpio121", "gpio122";
+				function = "qup5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c6_default: qup-i2c6-default {
 				mux {
 					pins = "gpio6", "gpio7";
@@ -1374,6 +1695,13 @@ config {
 				};
 			};
 
+			qup_spi6_default: qup-spi6_default {
+				pins = "gpio4", "gpio5", "gpio6", "gpio7";
+				function = "qup6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c7_default: qup-i2c7-default {
 				mux {
 					pins = "gpio98", "gpio99";
@@ -1387,6 +1715,13 @@ config {
 				};
 			};
 
+			qup_spi7_default: qup-spi7_default {
+				pins = "gpio98", "gpio99", "gpio100", "gpio101";
+				function = "qup7";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c8_default: qup-i2c8-default {
 				mux {
 					pins = "gpio88", "gpio89";
@@ -1400,6 +1735,13 @@ config {
 				};
 			};
 
+			qup_spi8_default: qup-spi8-default {
+				pins = "gpio88", "gpio89", "gpio90", "gpio91";
+				function = "qup8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c9_default: qup-i2c9-default {
 				mux {
 					pins = "gpio39", "gpio40";
@@ -1413,6 +1755,13 @@ config {
 				};
 			};
 
+			qup_spi9_default: qup-spi9-default {
+				pins = "gpio39", "gpio40", "gpio41", "gpio42";
+				function = "qup9";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c10_default: qup-i2c10-default {
 				mux {
 					pins = "gpio9", "gpio10";
@@ -1426,6 +1775,13 @@ config {
 				};
 			};
 
+			qup_spi10_default: qup-spi10-default {
+				pins = "gpio9", "gpio10", "gpio11", "gpio12";
+				function = "qup10";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c11_default: qup-i2c11-default {
 				mux {
 					pins = "gpio94", "gpio95";
@@ -1439,6 +1795,13 @@ config {
 				};
 			};
 
+			qup_spi11_default: qup-spi11-default {
+				pins = "gpio92", "gpio93", "gpio94", "gpio95";
+				function = "qup11";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c12_default: qup-i2c12-default {
 				mux {
 					pins = "gpio83", "gpio84";
@@ -1452,6 +1815,13 @@ config {
 				};
 			};
 
+			qup_spi12_default: qup-spi12-default {
+				pins = "gpio83", "gpio84", "gpio85", "gpio86";
+				function = "qup12";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c13_default: qup-i2c13-default {
 				mux {
 					pins = "gpio43", "gpio44";
@@ -1465,6 +1835,13 @@ config {
 				};
 			};
 
+			qup_spi13_default: qup-spi13-default {
+				pins = "gpio43", "gpio44", "gpio45", "gpio46";
+				function = "qup13";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c14_default: qup-i2c14-default {
 				mux {
 					pins = "gpio47", "gpio48";
@@ -1478,6 +1855,13 @@ config {
 				};
 			};
 
+			qup_spi14_default: qup-spi14-default {
+				pins = "gpio47", "gpio48", "gpio49", "gpio50";
+				function = "qup14";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c15_default: qup-i2c15-default {
 				mux {
 					pins = "gpio27", "gpio28";
@@ -1491,6 +1875,13 @@ config {
 				};
 			};
 
+			qup_spi15_default: qup-spi15-default {
+				pins = "gpio27", "gpio28", "gpio29", "gpio30";
+				function = "qup15";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c16_default: qup-i2c16-default {
 				mux {
 					pins = "gpio86", "gpio85";
@@ -1504,6 +1895,13 @@ config {
 				};
 			};
 
+			qup_spi16_default: qup-spi16-default {
+				pins = "gpio83", "gpio84", "gpio85", "gpio86";
+				function = "qup16";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c17_default: qup-i2c17-default {
 				mux {
 					pins = "gpio55", "gpio56";
@@ -1517,6 +1915,13 @@ config {
 				};
 			};
 
+			qup_spi17_default: qup-spi17-default {
+				pins = "gpio55", "gpio56", "gpio57", "gpio58";
+				function = "qup17";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c18_default: qup-i2c18-default {
 				mux {
 					pins = "gpio23", "gpio24";
@@ -1530,6 +1935,13 @@ config {
 				};
 			};
 
+			qup_spi18_default: qup-spi18-default {
+				pins = "gpio23", "gpio24", "gpio25", "gpio26";
+				function = "qup18";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_i2c19_default: qup-i2c19-default {
 				mux {
 					pins = "gpio57", "gpio58";
@@ -1542,6 +1954,13 @@ config {
 					bias-disable;
 				};
 			};
+
+			qup_spi19_default: qup-spi19-default {
+				pins = "gpio55", "gpio56", "gpio57", "gpio58";
+				function = "qup19";
+				drive-strength = <6>;
+				bias-disable;
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
-- 
2.34.1

