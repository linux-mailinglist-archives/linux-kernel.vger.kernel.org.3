Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC072515F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382991AbiD3Q1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbiD3Q1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:23 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189775F8D8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:24:01 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BB2BA3F722;
        Sat, 30 Apr 2022 18:23:58 +0200 (CEST)
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
Subject: [PATCH 02/14] arm64: dts: qcom: msm8998-clamshell: Clean up the DT
Date:   Sat, 30 Apr 2022 18:23:40 +0200
Message-Id: <20220430162353.607709-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220430162353.607709-1-konrad.dybcio@somainline.org>
References: <20220430162353.607709-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the nodes and includes in order, clean up unnecessary properties & nodes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 118 ++++++++++--------
 arch/arm64/boot/dts/qcom/pm8005.dtsi          |   4 +
 2 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 6e70c1ead5e1..a8756bcdad3b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -8,13 +8,10 @@
  */
 
 #include "msm8998.dtsi"
-#include "pm8998.dtsi"
 #include "pm8005.dtsi"
+#include "pm8998.dtsi"
 
 / {
-	chosen {
-	};
-
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -37,6 +34,28 @@ bluetooth {
 	};
 };
 
+&blsp1_uart3_on {
+	rx {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-up on 45 (RX). This is needed to
+		 * avoid garbage data when the TX pin of the Bluetooth
+		 * module is in tri-state (module powered off or not
+		 * driving the signal yet).
+		 */
+		bias-pull-up;
+	};
+
+	cts {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-down on 47 (CTS) to match the pull
+		 * of the Bluetooth module.
+		 */
+		bias-pull-down;
+	};
+};
+
 /*
  * The laptop FW does not appear to support the retention state as it is
  * not advertised as enabled in ACPI, and enabling it in DT can cause boot
@@ -82,20 +101,16 @@ &pcie_phy {
 	status = "okay";
 };
 
-&pm8005_lsid1 {
-	pm8005-regulators {
-		compatible = "qcom,pm8005-regulators";
-
-		vdd_s1-supply = <&vph_pwr>;
+&pm8005_regulators {
+	vdd_s1-supply = <&vph_pwr>;
 
-		pm8005_s1: s1 { /* VDD_GFX supply */
-			regulator-min-microvolt = <524000>;
-			regulator-max-microvolt = <1100000>;
-			regulator-enable-ramp-delay = <500>;
+	pm8005_s1: s1 { /* VDD_GFX supply */
+		regulator-min-microvolt = <524000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-enable-ramp-delay = <500>;
 
-			/* hack until we rig up the gpu consumer */
-			regulator-always-on;
-		};
+		/* hack until we rig up the gpu consumer */
+		regulator-always-on;
 	};
 };
 
@@ -143,127 +158,156 @@ vreg_s3a_1p35: s3 {
 			regulator-min-microvolt = <1352000>;
 			regulator-max-microvolt = <1352000>;
 		};
+
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
 			regulator-max-microvolt = <2040000>;
 		};
+
 		vreg_s7a_1p025: s7 {
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1028000>;
 		};
+
 		vreg_l1a_0p875: l1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l2a_1p2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l3a_1p0: l3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l5a_0p8: l5 {
 			regulator-min-microvolt = <800000>;
 			regulator-max-microvolt = <800000>;
 		};
+
 		vreg_l6a_1p8: l6 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <1808000>;
 		};
+
 		vreg_l7a_1p8: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l8a_1p2: l8 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 		};
+
 		vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l10a_1p8: l10 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l11a_1p0: l11 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l12a_1p8: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l13a_2p95: l13 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l14a_1p88: l14 {
 			regulator-min-microvolt = <1880000>;
 			regulator-max-microvolt = <1880000>;
 		};
+
 		vreg_l15a_1p8: l15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l16a_2p7: l16 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l17a_1p3: l17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l18a_2p7: l18 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l19a_3p0: l19 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
 		};
+
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
 			regulator-allow-set-load;
 			regulator-system-load = <800000>;
 		};
+
 		vreg_l22a_2p85: l22 {
 			regulator-min-microvolt = <2864000>;
 			regulator-max-microvolt = <2864000>;
 		};
+
 		vreg_l23a_3p3: l23 {
 			regulator-min-microvolt = <3312000>;
 			regulator-max-microvolt = <3312000>;
 		};
+
 		vreg_l24a_3p075: l24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
 		};
+
 		vreg_l25a_3p3: l25 {
 			regulator-min-microvolt = <3104000>;
 			regulator-max-microvolt = <3312000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 		};
+
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
@@ -278,7 +322,6 @@ vreg_lvs2a_1p8: lvs2 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
-
 	};
 };
 
@@ -286,15 +329,6 @@ &remoteproc_mss {
 	status = "okay";
 };
 
-&tlmm {
-	gpio-reserved-ranges = <0 4>, <81 4>;
-
-	touchpad: touchpad-pin {
-		pins = "gpio123";
-		bias-pull-up;
-	};
-};
-
 &sdhc2 {
 	status = "okay";
 
@@ -306,6 +340,15 @@ &sdhc2 {
 	pinctrl-1 = <&sdc2_off &sdc2_cd>;
 };
 
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	touchpad: touchpad-pin {
+		pins = "gpio123";
+		bias-pull-up;
+	};
+};
+
 &ufshc {
 	status = "okay";
 };
@@ -339,26 +382,3 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 };
-
-/* PINCTRL - board-specific pinctrl */
-&blsp1_uart3_on {
-	rx {
-		/delete-property/ bias-disable;
-		/*
-		 * Configure a pull-up on 45 (RX). This is needed to
-		 * avoid garbage data when the TX pin of the Bluetooth
-		 * module is in tri-state (module powered off or not
-		 * driving the signal yet).
-		 */
-		bias-pull-up;
-	};
-
-	cts {
-		/delete-property/ bias-disable;
-		/*
-		 * Configure a pull-down on 47 (CTS) to match the pull
-		 * of the Bluetooth module.
-		 */
-		bias-pull-down;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
index 3f97607d8baa..50fb6c753bf8 100644
--- a/arch/arm64/boot/dts/qcom/pm8005.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
@@ -28,5 +28,9 @@ pm8005_lsid1: pmic@5 {
 		reg = <0x5 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8005_regulators: regulators {
+			compatible = "qcom,pm8005-regulators";
+		};
 	};
 };
-- 
2.35.2

