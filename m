Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3D5A9282
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiIAI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiIAI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:56:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4812D53C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:56:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so17189098ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=R4lf3dEer0vPud9r0M9Q82OVYzKOE4VmrHcOQ1wXewU=;
        b=N/znKsmHhXm8bYuzkx7yNjeWw0Oi6XeU762er+IZu9W6tiNsBzNyQfyFOL76Rsxm9c
         ShBUs1cfSvNVZNqAm8KXXWYkZLE5090R/kbXlX4+Ck5mQeu+gYkQUdaSAqAQmak3GJoA
         j8hm1kip0Tgs5FMnCt27aw7IYIBl9gnn7Ml/U/mgmS3dn1pboJt2ZFzCcY6IKlUmC9Dr
         0ce16921KHz/g/vYWfLUnoRaUia+uS3L17pRbbmS1BDnlNmay/+jEV64e5TtF3ITkHBy
         wBUsmZ3BOTcCYsp8DZijqWZY6ltdRUtyRdVIhdirhvVXAgcSqdk79qad8mosV80ltSWi
         9Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R4lf3dEer0vPud9r0M9Q82OVYzKOE4VmrHcOQ1wXewU=;
        b=KWJ17KXUA7pERXg8QiPu4aFG7JohX7QjaJi5KLbH3Y9HnQRDiFUt2bmb9k74cpzuan
         J+7TajECqP9FJWsYSpTHBnKDNT1GWSISod18+RsJiholWqRzndFuTvp0MJ3bZBwX77pK
         MwjlKIOChlRoZiQJDZpGcQT4lodF2+BCI7OmJSfWRNORFDJ5+axKXsWMKzDxC9MiCKL3
         oQ+F9WW31a5EvrAWWml9Tg3kBK/8Qdd6p8GELWnD1KUQA8cQsf40j2uHv3K9cjjxlMM6
         qKaRtIGiHeVmZNGeg5WhxX9CfPjtoB+EQpJ2/KXjrzptHKvhxKGfe/lT7yaeA/0+gcaR
         1fpg==
X-Gm-Message-State: ACgBeo2YzbYvnoLatPSK1rlvRa3uxfcg3brUU1bP6qDGb83ZDxC80k1O
        gnhBgRTaE1lmdt9U061SIwHHUBGEfeYMAs+L
X-Google-Smtp-Source: AA6agR5ghEOC5Hw7ojJWwRLshH/M7n8/BroyBqdzk6lEMoo0vYUdFuTf37vST1Qd0mqSzGjceBzDdA==
X-Received: by 2002:a05:651c:1953:b0:268:983a:c6de with SMTP id bs19-20020a05651c195300b00268983ac6demr1763841ljb.218.1662022572998;
        Thu, 01 Sep 2022 01:56:12 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b004947984bc78sm883856lfs.188.2022.09.01.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 01:56:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 2/3] arm64: dts: qcom: align RPM regulators node name with bindings
Date:   Thu,  1 Sep 2022 11:56:08 +0300
Message-Id: <20220901085609.95624-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901085609.95624-1-krzysztof.kozlowski@linaro.org>
References: <20220901085609.95624-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names should be generic and new DT schema expects RPM regulators
node to be just "regulators".  Rename them while keeping similar naming
style within PMIC families on different boards, e.g.
	pm660l-regulators -> regulators-0
	pm660-regulators -> regulators-1
which creates in few places big diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware, but I do not expect functional impact.
---
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi  |   2 +-
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   4 +-
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |   2 +-
 .../boot/dts/qcom/msm8998-clamshell.dtsi      |   2 +-
 .../boot/dts/qcom/msm8998-fxtec-pro1.dts      |   4 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts      |   4 +-
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi |   4 +-
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi |   4 +-
 .../boot/dts/qcom/sda660-inforce-ifc6560.dts  | 166 +++++++++---------
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |   4 +-
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  |   4 +-
 14 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 539823b2c36e..8cac23b5240c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -47,7 +47,7 @@ &usb_hs_phy {
 };
 
 &rpm_requests {
-	smd_rpm_regulators: pm8916-regulators {
+	smd_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";
 
 		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index e165b5e890a0..9c74c3b7b08c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -629,7 +629,7 @@ &pmi8994_wled {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 627649979891..60f13da46ada 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -370,7 +370,7 @@ &wcd9335 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -555,7 +555,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8994-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 25f30ec277c1..3d84bab35f78 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -218,7 +218,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l17a_2p8: l17 {
 			regulator-name = "vreg_l17a_2p8";
 			regulator-min-microvolt = <2500000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
index ff4673ee9e81..7526f8f473b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
@@ -164,7 +164,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l3a_0p875: l3 {
 			regulator-name = "vreg_l3a_0p875";
 			regulator-min-microvolt = <850000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 30a9e4bed4af..8937d0c1b649 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -196,7 +196,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l3a_0p875: l3 {
 			regulator-name = "vreg_l3a_0p875";
 			regulator-min-microvolt = <850000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 7928b8197474..63413e39572c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -137,7 +137,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 429ba57e20f7..a7a79ddd3bea 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -390,7 +390,7 @@ &replicator1 {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -588,7 +588,7 @@ vreg_lvs2a_1p8: lvs2 {
 
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index a3ca58100aee..abea3ffa0094 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -168,7 +168,7 @@ &replicator1 {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -366,7 +366,7 @@ vreg_lvs2a_1p8: lvs2 {
 
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 62bda23791bb..3af6deed2e86 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -288,7 +288,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -477,7 +477,7 @@ vreg_l28_3p0: l28 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index d08639082247..47cd3caa6927 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -375,7 +375,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -538,7 +538,7 @@ vreg_l28_3p0: l28 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 28050bc5f081..02dfcece7d69 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -231,89 +231,7 @@ &qusb2phy1 {
 };
 
 &rpm_requests {
-	pm660-regulators {
-		compatible = "qcom,rpm-pm660-regulators";
-
-		vdd_s1-supply = <&vph_pwr>;
-		vdd_s2-supply = <&vph_pwr>;
-		vdd_s3-supply = <&vph_pwr>;
-		vdd_s4-supply = <&vph_pwr>;
-		vdd_s5-supply = <&vph_pwr>;
-		vdd_s6-supply = <&vph_pwr>;
-
-		vdd_l1_l6_l7-supply = <&vreg_s5a_1p35>;
-		vdd_l2_l3-supply = <&vreg_s2b_1p05>;
-		vdd_l5-supply = <&vreg_s2b_1p05>;
-		vdd_l8_l9_l10_l11_l12_l13_l14-supply = <&vreg_s4a_2p04>;
-		vdd_l15_l16_l17_l18_l19-supply = <&vreg_bob>;
-
-		vreg_s4a_2p04: s4 {
-			regulator-min-microvolt = <1805000>;
-			regulator-max-microvolt = <2040000>;
-			regulator-enable-ramp-delay = <200>;
-			regulator-ramp-delay = <0>;
-			regulator-always-on;
-		};
-
-		vreg_s5a_1p35: s5 {
-			regulator-min-microvolt = <1224000>;
-			regulator-max-microvolt = <1350000>;
-			regulator-enable-ramp-delay = <200>;
-			regulator-ramp-delay = <0>;
-		};
-
-		vreg_l1a_1p225: l1 {
-			regulator-min-microvolt = <1150000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l6a_1p3: l6 {
-			regulator-min-microvolt = <1304000>;
-			regulator-max-microvolt = <1368000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-ramp-delay = <0>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l8a_1p8: l8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-ramp-delay = <0>;
-			regulator-system-load = <325000>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l9a_1p8: l9 {
-			regulator-min-microvolt = <1804000>;
-			regulator-max-microvolt = <1896000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-ramp-delay = <0>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l13a_1p8: l13 {
-			/* This gives power to the LPDDR4: never turn it off! */
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1944000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-ramp-delay = <0>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		vreg_l19a_3p3: l19 {
-			regulator-min-microvolt = <3312000>;
-			regulator-max-microvolt = <3400000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-ramp-delay = <0>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pm660l-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -398,6 +316,88 @@ vreg_bob: bob {
 			regulator-ramp-delay = <0>;
 		};
 	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pm660-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+
+		vdd_l1_l6_l7-supply = <&vreg_s5a_1p35>;
+		vdd_l2_l3-supply = <&vreg_s2b_1p05>;
+		vdd_l5-supply = <&vreg_s2b_1p05>;
+		vdd_l8_l9_l10_l11_l12_l13_l14-supply = <&vreg_s4a_2p04>;
+		vdd_l15_l16_l17_l18_l19-supply = <&vreg_bob>;
+
+		vreg_s4a_2p04: s4 {
+			regulator-min-microvolt = <1805000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+		};
+
+		vreg_s5a_1p35: s5 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l1a_1p225: l1 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6a_1p3: l6 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1368000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l8a_1p8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-system-load = <325000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1804000>;
+			regulator-max-microvolt = <1896000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l13a_1p8: l13 {
+			/* This gives power to the LPDDR4: never turn it off! */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1944000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_l19a_3p3: l19 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+	};
 };
 
 &sdc2_state_on {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 09c07800793a..f9e1d599466a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -260,7 +260,7 @@ &qusb2phy0 {
 };
 
 &rpm_requests {
-	pm660l-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -394,7 +394,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm660-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index a3559f6e34a5..fea2c3e416e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -111,7 +111,7 @@ &qusb2phy0 {
 };
 
 &rpm_requests {
-	pm660l-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -206,7 +206,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm660-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
-- 
2.34.1

