Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D3515F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377122AbiD3Q1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiD3Q1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:22 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D75F8D3;
        Sat, 30 Apr 2022 09:23:59 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 79A5E3F728;
        Sat, 30 Apr 2022 18:23:57 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] arm64: dts: qcom: msm8998*: Fix TLMM and pin nodes
Date:   Sat, 30 Apr 2022 18:23:39 +0200
Message-Id: <20220430162353.607709-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary level of indentation, commonize SDC2 pins and notice
that SDCC2_CD_ON and _OFF is identical, deduplicate it!

Also, remove some unnecessary overrides and use decimal values in #-cells

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/msm8998-asus-novago-tp370ql.dts  |  9 ---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 12 ++-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     |  4 +-
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 75 ++++++-------------
 5 files changed, 33 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dts b/arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dts
index e204b7050441..37f994351565 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dts
@@ -37,12 +37,3 @@ keyboard@3a {
 &sdhc2 {
 	cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 };
-
-&tlmm {
-	touchpad: touchpad {
-		config {
-			pins = "gpio123";
-			bias-pull-up;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index b3b352530d76..6e70c1ead5e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -289,11 +289,9 @@ &remoteproc_mss {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	touchpad: touchpad {
-		config {
-			pins = "gpio123";
-			bias-pull-up;           /* pull up */
-		};
+	touchpad: touchpad-pin {
+		pins = "gpio123";
+		bias-pull-up;
 	};
 };
 
@@ -304,8 +302,8 @@ &sdhc2 {
 	vqmmc-supply = <&vreg_l13a_2p95>;
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_on &sdc2_cd>;
+	pinctrl-1 = <&sdc2_off &sdc2_cd>;
 };
 
 &ufshc {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index af67c641df4e..8368af2d78e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -348,8 +348,8 @@ &sdhc2 {
 	vqmmc-supply = <&vreg_l13a_2p95>;
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_on &sdc2_cd>;
+	pinctrl-1 = <&sdc2_off &sdc2_cd>;
 };
 
 &stm {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 03fa66646d47..fd65dee55626 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -580,8 +580,8 @@ &sdhc2 {
 	vqmmc-supply = <&vreg_l13a_2p95>;
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_on &sdc2_cd>;
+	pinctrl-1 = <&sdc2_off &sdc2_cd>;
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2fda21e810c9..69cdbb104e4c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1042,85 +1042,58 @@ tlmm: pinctrl@3400000 {
 			reg = <0x03400000 0xc00000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-			#gpio-cells = <0x2>;
+			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <0x2>;
+			#interrupt-cells = <2>;
 
-			sdc2_clk_on: sdc2_clk_on {
-				config {
+			sdc2_on: sdc2-on {
+				clk {
 					pins = "sdc2_clk";
-					bias-disable;
 					drive-strength = <16>;
-				};
-			};
-
-			sdc2_clk_off: sdc2_clk_off {
-				config {
-					pins = "sdc2_clk";
 					bias-disable;
-					drive-strength = <2>;
 				};
-			};
 
-			sdc2_cmd_on: sdc2_cmd_on {
-				config {
+				cmd {
 					pins = "sdc2_cmd";
-					bias-pull-up;
 					drive-strength = <10>;
-				};
-			};
-
-			sdc2_cmd_off: sdc2_cmd_off {
-				config {
-					pins = "sdc2_cmd";
 					bias-pull-up;
-					drive-strength = <2>;
 				};
-			};
 
-			sdc2_data_on: sdc2_data_on {
-				config {
+				data {
 					pins = "sdc2_data";
-					bias-pull-up;
 					drive-strength = <10>;
+					bias-pull-up;
 				};
 			};
 
-			sdc2_data_off: sdc2_data_off {
-				config {
-					pins = "sdc2_data";
-					bias-pull-up;
+			sdc2_off: sdc2-off {
+				clk {
+					pins = "sdc2_clk";
 					drive-strength = <2>;
+					bias-disable;
 				};
-			};
 
-			sdc2_cd_on: sdc2_cd_on {
-				mux {
-					pins = "gpio95";
-					function = "gpio";
+				cmd {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
 				};
 
-				config {
-					pins = "gpio95";
-					bias-pull-up;
+				data {
+					pins = "sdc2_data";
 					drive-strength = <2>;
+					bias-pull-up;
 				};
 			};
 
-			sdc2_cd_off: sdc2_cd_off {
-				mux {
-					pins = "gpio95";
-					function = "gpio";
-				};
-
-				config {
-					pins = "gpio95";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
+			sdc2_cd: sdc2-cd {
+				pins = "gpio95";
+				function = "gpio";
+				bias-pull-up;
+				drive-strength = <2>;
 			};
 
-			blsp1_uart3_on: blsp1_uart3_on {
+			blsp1_uart3_on: blsp1-uart3-on {
 				tx {
 					pins = "gpio45";
 					function = "blsp_uart3_a";
-- 
2.35.2

