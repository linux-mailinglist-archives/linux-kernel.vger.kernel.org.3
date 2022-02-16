Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B564B932A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiBPV0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:26:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiBPVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:25:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FB2AFE92;
        Wed, 16 Feb 2022 13:25:42 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6609DC70C6;
        Wed, 16 Feb 2022 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046741; bh=Swcp8J495qXS9ykY9TkjFyH8+QKLa/dZHL7wYxjsUew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ayOiI6dZxnQiGl9pNSgJyPWZRFOdsSHwsZBdZbQ4oVMWZ3EwinJoROa0LzX4hbyph
         Dtf0dijGmj5aVbYf2TUNitM8aP6LbCnBUAtTX6+j36jmjdFOt1x6A9Iq7PzykMEaG5
         MADRG9ysOE7VH8uxl2oreOdHKnxN2t7/7CblY+DY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: qcom: msm8226: Add pinctrl for sdhci nodes
Date:   Wed, 16 Feb 2022 22:24:30 +0100
Message-Id: <20220216212433.1373903-4-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216212433.1373903-1-luca@z3ntu.xyz>
References: <20220216212433.1373903-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove the pinctrl from qcom-apq8026-lg-lenok as it is the same
value as the generic pinctrl.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts | 17 ------
 arch/arm/boot/dts/qcom-msm8226.dtsi         | 57 +++++++++++++++++++++
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 1519544029e7..5ce42dd962c4 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -204,9 +204,6 @@ &sdhc_1 {
 
 	bus-width = <8>;
 	non-removable;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
 };
 
 &smbb {
@@ -219,20 +216,6 @@ &smbb {
 };
 
 &tlmm {
-	sdhc1_pin_a: sdhc1-pin-active {
-		clk {
-			pins = "sdc1_clk";
-			drive-strength = <10>;
-			bias-disable;
-		};
-
-		cmd-data {
-			pins = "sdc1_cmd", "sdc1_data";
-			drive-strength = <10>;
-			bias-pull-up;
-		};
-	};
-
 	touch_pins: touch {
 		irq {
 			pins = "gpio17";
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 103c0ab70814..dfeb47eb41a2 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -116,6 +116,8 @@ sdhc_1: sdhci@f9824900 {
 				 <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc1_default_state>;
 			status = "disabled";
 		};
 
@@ -130,6 +132,8 @@ sdhc_2: sdhci@f98a4900 {
 				 <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc2_default_state>;
 			status = "disabled";
 		};
 
@@ -144,6 +148,8 @@ sdhc_3: sdhci@f9864900 {
 				 <&gcc GCC_SDCC3_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc3_default_state>;
 			status = "disabled";
 		};
 
@@ -320,6 +326,57 @@ blsp1_i2c5_pins: blsp1-i2c5 {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			sdhc1_default_state: sdhc1-default-state {
+				clk {
+					pins = "sdc1_clk";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				cmd-data {
+					pins = "sdc1_cmd", "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdhc2_default_state: sdhc2-default-state {
+				clk {
+					pins = "sdc2_clk";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				cmd-data {
+					pins = "sdc2_cmd", "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdhc3_default_state: sdhc3-default-state {
+				clk {
+					pins = "gpio44";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				cmd {
+					pins = "gpio43";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
+
+				data {
+					pins = "gpio39", "gpio40", "gpio41", "gpio42";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		restart@fc4ab000 {
-- 
2.35.1

