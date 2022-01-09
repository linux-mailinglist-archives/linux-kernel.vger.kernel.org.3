Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5C488C2C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiAIUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:03:37 -0500
Received: from ixit.cz ([94.230.151.217]:53120 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbiAIUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:03:36 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C69432243C;
        Sun,  9 Jan 2022 21:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641758614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wFkft0CzkB4uaaTqJMU1+7/bcgLx79HrA1YTAV+YSWw=;
        b=dHWkB+hFlaifxqkARmY1gZbghkvtP8IirCsBIMjzu/Wmts8xQO+GW+IJHe+P531de3CMfH
        eqSRPjEjiVfQaeBXk642cxa9DBCDyuvsv8ufLlotMmB8lSzRJK9janKN3O0qRg6bAYcPrY
        bs05e9iLaD9g3sSCRyd0eCT2wnurV+Q=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: msm8960: Sort out rpm node duplication
Date:   Sun,  9 Jan 2022 21:03:31 +0100
Message-Id: <20220109200332.41474-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On other platforms are usually regulators enumerated in platform and
used in devices, follow the pattern on MSM8960 too.

No functional changes.

Original author: Bjorn Andersson

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 73 +++++++++++++-------------
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 43 +++++++++++++++
 2 files changed, 79 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 830703759466..7c4c3cb79d05 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -49,7 +49,6 @@ sdcc3: mmc@12180000 {
 
 		rpm@108000 {
 			regulators {
-				compatible = "qcom,rpm-pm8921-regulators";
 				vin_lvs1_3_6-supply = <&pm8921_s4>;
 				vin_lvs2-supply = <&pm8921_s4>;
 				vin_lvs4_5_7-supply = <&pm8921_s4>;
@@ -62,7 +61,7 @@ regulators {
 				vdd_l28-supply = <&pm8921_s7>;
 
 				/* Buck SMPS */
-				pm8921_s1: s1 {
+				s1 {
 					regulator-always-on;
 					regulator-min-microvolt = <1225000>;
 					regulator-max-microvolt = <1225000>;
@@ -70,21 +69,21 @@ pm8921_s1: s1 {
 					bias-pull-down;
 				};
 
-				pm8921_s2: s2 {
+				s2 {
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
 					qcom,switch-mode-frequency = <1600000>;
 					bias-pull-down;
 				};
 
-				pm8921_s3: s3 {
+				s3 {
 					regulator-min-microvolt = <500000>;
 					regulator-max-microvolt = <1150000>;
 					qcom,switch-mode-frequency = <4800000>;
 					bias-pull-down;
 				};
 
-				pm8921_s4: s4 {
+				s4 {
 					regulator-always-on;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -93,14 +92,14 @@ pm8921_s4: s4 {
 					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
 				};
 
-				pm8921_s7: s7 {
+				s7 {
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					qcom,switch-mode-frequency = <3200000>;
 					bias-pull-down;
 				};
 
-				pm8921_s8: s8 {
+				s8 {
 					regulator-always-on;
 					regulator-min-microvolt = <2050000>;
 					regulator-max-microvolt = <2050000>;
@@ -109,137 +108,137 @@ pm8921_s8: s8 {
 				};
 
 				/* PMOS LDO */
-				pm8921_l1: l1 {
+				l1 {
 					regulator-always-on;
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 					bias-pull-down;
 				};
 
-				pm8921_l2: l2 {
+				l2 {
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					bias-pull-down;
 				};
 
-				pm8921_l3: l3 {
+				l3 {
 					regulator-min-microvolt = <3075000>;
 					regulator-max-microvolt = <3075000>;
 					bias-pull-down;
 				};
 
-				pm8921_l4: l4 {
+				l4 {
 					regulator-always-on;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l5: l5 {
+				l5 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l6: l6 {
+				l6 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l7: l7 {
+				l7 {
 					regulator-always-on;
 					regulator-min-microvolt = <1850000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l8: l8 {
+				l8 {
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <3000000>;
 					bias-pull-down;
 				};
 
-				pm8921_l9: l9 {
+				l9 {
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
 					bias-pull-down;
 				};
 
-				pm8921_l10: l10 {
+				l10 {
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
 					bias-pull-down;
 				};
 
-				pm8921_l11: l11 {
+				l11 {
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
 					bias-pull-down;
 				};
 
-				pm8921_l12: l12 {
+				l12 {
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					bias-pull-down;
 				};
 
-				pm8921_l14: l14 {
+				l14 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l15: l15 {
+				l15 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l16: l16 {
+				l16 {
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l17: l17 {
+				l17 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l18: l18 {
+				l18 {
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
 					bias-pull-down;
 				};
 
-				pm8921_l21: l21 {
+				l21 {
 					regulator-min-microvolt = <1900000>;
 					regulator-max-microvolt = <1900000>;
 					bias-pull-down;
 				};
 
-				pm8921_l22: l22 {
+				l22 {
 					regulator-min-microvolt = <2750000>;
 					regulator-max-microvolt = <2750000>;
 					bias-pull-down;
 				};
 
-				pm8921_l23: l23 {
+				l23 {
 					regulator-always-on;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l24: l24 {
+				l24 {
 					regulator-min-microvolt = <750000>;
 					regulator-max-microvolt = <1150000>;
 					bias-pull-down;
 				};
 
-				pm8921_l25: l25 {
+				l25 {
 					regulator-always-on;
 					regulator-min-microvolt = <1250000>;
 					regulator-max-microvolt = <1250000>;
@@ -247,35 +246,35 @@ pm8921_l25: l25 {
 				};
 
 				/* Low Voltage Switch */
-				pm8921_lvs1: lvs1 {
+				lvs1 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs2: lvs2 {
+				lvs2 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs3: lvs3 {
+				lvs3 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs4: lvs4 {
+				lvs4 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs5: lvs5 {
+				lvs5 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs6: lvs6 {
+				lvs6 {
 					bias-pull-down;
 				};
 
-				pm8921_lvs7: lvs7 {
+				lvs7 {
 					bias-pull-down;
 				};
 
-				pm8921_ncp: ncp {
+				ncp {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					qcom,switch-mode-frequency = <1600000>;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index d9033912c7f3..ffedc60f9ec1 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -154,6 +154,49 @@ rpm@108000 {
 
 			regulators {
 				compatible = "qcom,rpm-pm8921-regulators";
+
+				/* Buck SMPS */
+				pm8921_s1: s1 {};
+				pm8921_s2: s2 {};
+				pm8921_s3: s3 {};
+				pm8921_s4: s4 {};
+				pm8921_s7: s7 {};
+				pm8921_s8: s8 {};
+
+				/* PMOS LDO */
+				pm8921_l1: l1 {};
+				pm8921_l2: l2 {};
+				pm8921_l3: l3 {};
+				pm8921_l4: l4 {};
+				pm8921_l5: l5 {};
+				pm8921_l6: l6 {};
+				pm8921_l7: l7 {};
+				pm8921_l8: l8 {};
+				pm8921_l9: l9 {};
+				pm8921_l10: l10 {};
+				pm8921_l11: l11 {};
+				pm8921_l12: l12 {};
+				pm8921_l14: l14 {};
+				pm8921_l15: l15 {};
+				pm8921_l16: l16 {};
+				pm8921_l17: l17 {};
+				pm8921_l18: l18 {};
+				pm8921_l21: l21 {};
+				pm8921_l22: l22 {};
+				pm8921_l23: l23 {};
+				pm8921_l24: l24 {};
+				pm8921_l25: l25 {};
+
+				/* Low Voltage Switch */
+				pm8921_lvs1: lvs1 {};
+				pm8921_lvs2: lvs2 {};
+				pm8921_lvs3: lvs3 {};
+				pm8921_lvs4: lvs4 {};
+				pm8921_lvs5: lvs5 {};
+				pm8921_lvs6: lvs6 {};
+				pm8921_lvs7: lvs7 {};
+
+				pm8921_ncp: ncp {};
 			};
 		};
 
-- 
2.34.1

