Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAB4DE9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiCSRtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiCSRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:41 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E924782D;
        Sat, 19 Mar 2022 10:47:17 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 1DCE13F3EF;
        Sat, 19 Mar 2022 18:47:15 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] arm64: dts: qcom: msm8994-kitakami: Update regulator configuration
Date:   Sat, 19 Mar 2022 18:46:41 +0100
Message-Id: <20220319174645.340379-12-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319174645.340379-1-konrad.dybcio@somainline.org>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove regulator-always-on property where not necessary and mark regulators
that are not supposed to be voted active on boot with regulator-boot-on.
While at it, reorder the load properties to make it look more decent.

Reorder PMICs to fix a probe defer caused by messy dependencies and Linux's
inability to handle them (at least for now).

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom/msm8994-sony-xperia-kitakami.dtsi    | 82 ++++++++++---------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index 5e93ab0a649b..e5a45af0bd12 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -187,26 +187,38 @@ vdd_gfx: s2@1700 {
 };
 
 &rpm_requests {
+	/* PMI8994 should probe first, because pmi8994_bby supplies some of PM8994's regulators */
+	pmi8994_regulators: pmi8994-regulators {
+		compatible = "qcom,rpm-pmi8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_bst_byp-supply = <&vph_pwr>;
+
+		pmi8994_s1: s1 {
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
+		};
+
+		/* S2 & S3 - VDD_GFX */
+
+		pmi8994_bby: boost-bypass {
+			regulator-min-microvolt = <3150000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+
 	pm8994_regulators: pm8994-regulators {
 		compatible = "qcom,rpm-pm8994-regulators";
 
-		vdd_s1-supply = <&vph_pwr>;
-		vdd_s2-supply = <&vph_pwr>;
 		vdd_s3-supply = <&vph_pwr>;
 		vdd_s4-supply = <&vph_pwr>;
 		vdd_s5-supply = <&vph_pwr>;
 		vdd_s6-supply = <&vph_pwr>;
 		vdd_s7-supply = <&vph_pwr>;
-		vdd_s8-supply = <&vph_pwr>;
-		vdd_s9-supply = <&vph_pwr>;
-		vdd_s10-supply = <&vph_pwr>;
-		vdd_s11-supply = <&vph_pwr>;
-		vdd_s12-supply = <&vph_pwr>;
 		vdd_l1-supply = <&pmi8994_s1>;
 		vdd_l2_l26_l28-supply = <&pm8994_s3>;
 		vdd_l3_l11-supply = <&pm8994_s3>;
 		vdd_l4_l27_l31-supply = <&pm8994_s3>;
-		vdd_l5_l7-supply = <&pm8994_s5>;
 		vdd_l6_l12_l32-supply = <&pm8994_s5>;
 		vdd_l8_l16_l30-supply = <&vph_pwr>;
 		vdd_l9_l10_l18_l22-supply = <&pmi8994_bby>;
@@ -227,9 +239,9 @@ pm8994_s3: s3 {
 		pm8994_s4: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-system-load = <325000>;
 			regulator-allow-set-load;
 			regulator-always-on;
-			regulator-system-load = <325000>;
 		};
 
 		pm8994_s5: s5 {
@@ -255,13 +267,14 @@ pm8994_l1: l1 {
 		pm8994_l2: l2 {
 			regulator-min-microvolt = <1250000>;
 			regulator-max-microvolt = <1250000>;
-			regulator-allow-set-load;
 			regulator-system-load = <10000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l3: l3 {
 			regulator-min-microvolt = <1100000>;
 			regulator-max-microvolt = <1100000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l4: l4 {
@@ -301,8 +314,8 @@ pm8994_l11: l11 {
 		pm8994_l12: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
-			regulator-allow-set-load;
 			regulator-system-load = <10000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l13: l13 {
@@ -313,8 +326,9 @@ pm8994_l13: l13 {
 		pm8994_l14: l14 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
-			regulator-allow-set-load;
 			regulator-system-load = <10000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
 		};
 
 		pm8994_l15: l15 {
@@ -330,44 +344,47 @@ pm8994_l16: l16 {
 		pm8994_l17: l17 {
 			regulator-min-microvolt = <2200000>;
 			regulator-max-microvolt = <2200000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l18: l18 {
 			regulator-min-microvolt = <2850000>;
 			regulator-max-microvolt = <2850000>;
 			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		pm8994_l19: l19 {
 			regulator-min-microvolt = <2850000>;
 			regulator-max-microvolt = <2850000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l20: l20 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
-			regulator-always-on;
-			regulator-boot-on;
-			regulator-allow-set-load;
 			regulator-system-load = <570000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l21: l21 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
-			regulator-always-on;
-			regulator-allow-set-load;
 			regulator-system-load = <800000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l22: l22 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l23: l23 {
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		pm8994_l24: l24 {
@@ -378,6 +395,7 @@ pm8994_l24: l24 {
 		pm8994_l25: l25 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l26: l26 {
@@ -388,30 +406,33 @@ pm8994_l26: l26 {
 		pm8994_l27: l27 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l28: l28 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
-			regulator-allow-set-load;
 			regulator-system-load = <10000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l29: l29 {
 			regulator-min-microvolt = <2700000>;
 			regulator-max-microvolt = <2700000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l30: l30 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 		};
 
 		pm8994_l31: l31 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			regulator-allow-set-load;
 			regulator-system-load = <10000>;
+			regulator-allow-set-load;
 		};
 
 		pm8994_l32: l32 {
@@ -419,26 +440,11 @@ pm8994_l32: l32 {
 			regulator-max-microvolt = <1800000>;
 		};
 
-		pm8994_lvs1: lvs1 {};
-		pm8994_lvs2: lvs2 {};
-	};
-
-	pmi8994_regulators: pmi8994-regulators {
-		compatible = "qcom,rpm-pmi8994-regulators";
-
-		vdd_s1-supply = <&vph_pwr>;
-		vdd_bst_byp-supply = <&vph_pwr>;
-
-		pmi8994_s1: s1 {
-			regulator-min-microvolt = <1025000>;
-			regulator-max-microvolt = <1025000>;
+		pm8994_lvs1: lvs1 {
+			regulator-boot-on;
 		};
-
-		/* S2 & S3 - VDD_GFX */
-
-		pmi8994_bby: boost-bypass {
-			regulator-min-microvolt = <3150000>;
-			regulator-max-microvolt = <3600000>;
+		pm8994_lvs2: lvs2 {
+			regulator-boot-on;
 		};
 	};
 };
-- 
2.35.1

