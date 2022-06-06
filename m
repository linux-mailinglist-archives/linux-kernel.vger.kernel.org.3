Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8D53EA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiFFQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiFFQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:43 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1F1A44B4;
        Mon,  6 Jun 2022 09:06:41 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 783DECCE35;
        Mon,  6 Jun 2022 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654531569; bh=FDmhzeRJXLln4Tsh/IURDfuOWharrgHiMsf+T6eZVRk=;
        h=From:To:Cc:Subject:Date;
        b=kIXuQ34jpxSgTAlu5WQwYutKhQUg6+TwsdaWr3k9kvYEfI5uyWrGa6TrRcvbiAWxJ
         EPWQrlhfOVl/5YFwN7isG+qeC3a53HRBmMX+fMvvPOlOTjXqe7oSBMpTFt+5GJABhQ
         /m4BrcW7yN/T/rIKEVaEQfyDVZrFkCKa/mewNKD0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: qcom: msm8974: re-add missing pinctrl
Date:   Mon,  6 Jun 2022 18:04:21 +0200
Message-Id: <20220606160421.1641778-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of a recent cleanup commit, the pinctrl for a few uart and i2c
nodes was removed. Adjust the names and/or add it back and assign it to
the uart and i2c nodes.

Fixes: 1dfe967ec7cf ("ARM: dts: qcom-msm8974*: Consolidate I2C/UART/SDHCI")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Bjorn, could you please pick this up for -fixes so it lands in an
upcoming 5.19-rc?

 arch/arm/boot/dts/qcom-msm8974.dtsi | 30 +++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 814ad0b46232..c3b8a6d63027 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -506,6 +506,8 @@ blsp1_uart2: serial@f991e000 {
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart2_default>;
 			status = "disabled";
 		};
 
@@ -581,6 +583,9 @@ blsp2_uart1: serial@f995d000 {
 			interrupts = <GIC_SPI 113 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP2_UART1_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_uart1_default>;
+			pinctrl-1 = <&blsp2_uart1_sleep>;
 			status = "disabled";
 		};
 
@@ -599,6 +604,8 @@ blsp2_uart4: serial@f9960000 {
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_UART4_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_uart4_default>;
 			status = "disabled";
 		};
 
@@ -639,6 +646,9 @@ blsp2_i2c6: i2c@f9968000 {
 			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c6_default>;
+			pinctrl-1 = <&blsp2_i2c6_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -1256,7 +1266,7 @@ cd {
 				};
 			};
 
-			blsp1_uart2_active: blsp1-uart2-active {
+			blsp1_uart2_default: blsp1-uart2-default {
 				rx {
 					pins = "gpio5";
 					function = "blsp_uart2";
@@ -1272,7 +1282,7 @@ tx {
 				};
 			};
 
-			blsp2_uart1_active: blsp2-uart1-active {
+			blsp2_uart1_default: blsp2-uart1-default {
 				tx-rts {
 					pins = "gpio41", "gpio44";
 					function = "blsp_uart7";
@@ -1295,7 +1305,7 @@ blsp2_uart1_sleep: blsp2-uart1-sleep {
 				bias-pull-down;
 			};
 
-			blsp2_uart4_active: blsp2-uart4-active {
+			blsp2_uart4_default: blsp2-uart4-default {
 				tx-rts {
 					pins = "gpio53", "gpio56";
 					function = "blsp_uart10";
@@ -1406,7 +1416,19 @@ blsp2_i2c5_sleep: blsp2-i2c5-sleep {
 				bias-pull-up;
 			};
 
-			/* BLSP2_I2C6 info is missing - nobody uses it though? */
+			blsp2_i2c6_default: blsp2-i2c6-default {
+				pins = "gpio87", "gpio88";
+				function = "blsp_i2c12";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c6_sleep: blsp2-i2c6-sleep {
+				pins = "gpio87", "gpio88";
+				function = "blsp_i2c12";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
 
 			spi8_default: spi8_default {
 				mosi {
-- 
2.36.1

