Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E85A9345
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiIAJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiIAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:34:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B4133F32
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:34:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so23555042lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yM7WVIgdYwlKz7xqeFTM8v62+DT+n2quP8CnsVN7ofU=;
        b=zmvPWbK0CWp+rUKGEUCulBpdox4O8QKIxbwqATfR9xgh8PqLdWu+un1NftqDjTw+MC
         jDv9Y7+2l90+b4lMQRgvnIBeKsYHAlKDBvzefuBdhHcNrz2Kq8Ebtan1ZwX87z82WCbZ
         hbDqwvjuOYojefYfUy06BCXm2qbdKxtW/nlQpGLhn72m7YmgIWMnfUx+XZYKwitfQoaf
         Xp+vNzE3YxWn0l50oaZ4rH1EsK0lQbskMKT5lRRAyLf9k6LnN/3Ct92LxDklxQ06w345
         CPTXrruKaUMeN3806urMiFyLZJr0p4vI6sKQvR3riUKbF5P8/t8sZSulvGQp42h1KAdo
         YJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yM7WVIgdYwlKz7xqeFTM8v62+DT+n2quP8CnsVN7ofU=;
        b=fXuJf2eqzeMN8KpFXKhviCfUpl2EUyZKQTBkWq0VnPQoTwc75ovSECPlhEeAON3jh4
         pTsU0fOfqxfFcZ9BQgCcPE9L/dWNrcaYx+u3+ATUPCg5LvQ9v4N0pMwEqVkoP1mXqvW/
         CsVg4g+/hRGrID/mdZmI74py52pYmP0KxRkqLW4FtZQSaXVZol4+DEgLHIHaGoJrJ815
         rAcI/504rGFgaJ1y7CYB6QqbMq1zEQYGR92ojWlYsfNPv7kj4fbCZ0gIicv5H8NRvN0N
         K22as8ghvJtkAiq/Hgp1J7CoaM1d6pcxQRL3gvKwkEr4f6ayCuLjIh6598KkR2ThIl64
         EZcQ==
X-Gm-Message-State: ACgBeo2JvvKYKAyPqixutNOn0u3YvF19/kSwsGEgTRAMeXdXVF0aZPOl
        6Dl0TQlFxa9p3BtyvrijHTPuZw==
X-Google-Smtp-Source: AA6agR75BcI/N5jihSmEzUPG6P0Vf8qlw8UrkDHZFUgjnKYyBtja8S4IVtc1lWtu5PWyeoYkHhaKbQ==
X-Received: by 2002:a05:6512:6c5:b0:494:6bab:6cca with SMTP id u5-20020a05651206c500b004946bab6ccamr5725878lff.197.1662024846092;
        Thu, 01 Sep 2022 02:34:06 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b0049486c66140sm638830lfr.119.2022.09.01.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:34:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT v2 3/4] arm64: dts: qcom: align RPM regulators node name with bindings
Date:   Thu,  1 Sep 2022 12:34:00 +0300
Message-Id: <20220901093401.134473-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901093303.134346-1-krzysztof.kozlowski@linaro.org>
References: <20220901093303.134346-1-krzysztof.kozlowski@linaro.org>
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
node to be just "regulators".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware, but I do not expect functional impact. Tested
with comparing DTB.

Changes since v1:
1. Fix more nodes.
2. Do not shuffle regulators around as it might impact probe order.
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts                | 4 ++--
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi          | 4 ++--
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts          | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi        | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts         | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts        | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts        | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi            | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts                   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi       | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi                   | 2 +-
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts        | 4 ++--
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi      | 4 ++--
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts          | 2 +-
 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts        | 4 ++--
 22 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index c1cb1ba5173c..695b6d4fccd7 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -750,7 +750,7 @@ vdd_gfx: s2@1700 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -962,7 +962,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8994-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index 567b33106556..e48193332b22 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -162,7 +162,7 @@ cd {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
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
diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index 71e373b11de9..aef92f3c49da 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -58,7 +58,7 @@ &blsp1_uart2 {
 };
 
 &rpm_requests {
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_l1-supply = <&pm8994_s1>;
@@ -281,7 +281,7 @@ pm8994_l32: l32 {
 		};
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index cbe11c060df9..c9b9ab4dc739 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -153,7 +153,7 @@ VDD_APC1: s11 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_l1-supply = <&pm8994_s7>;
@@ -363,7 +363,7 @@ pm8994_l32: l32 {
 		pm8994_lvs2: lvs2 {};
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 		vdd_s1-supply = <&vph_pwr>;
 		vdd_bst_byp-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 61ec905025b0..cc45873a820c 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -551,7 +551,7 @@ vdd_gfx: s2@1700 {
 
 &rpm_requests {
 	/* These values were taken from the original firmware ACPI tables */
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -835,7 +835,7 @@ vreg_l32a_1p8: l32 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index f430d797196f..415dfcc57ae4 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -186,7 +186,7 @@ vdd_gfx: s2@1700 {
 
 &rpm_requests {
 	/* PMI8994 should probe first, because pmi8994_bby supplies some of PM8994's regulators */
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -205,7 +205,7 @@ pmi8994_bby: boost-bypass {
 		};
 	};
 
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s3-supply = <&vph_pwr>;
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
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 1721ebe5759b..75b0954ed485 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -125,7 +125,7 @@ &remoteproc_wcss {
 };
 
 &rpm_requests {
-	pms405-regulators {
+	regulators {
 		compatible = "qcom,rpm-pms405-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 28050bc5f081..f62a74f0e8f0 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -231,7 +231,7 @@ &qusb2phy1 {
 };
 
 &rpm_requests {
-	pm660-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -313,7 +313,7 @@ vreg_l19a_3p3: l19 {
 		};
 	};
 
-	pm660l-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
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
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 891e314bc782..c238fba2fe7c 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -69,7 +69,7 @@ &sdhc_2 {
 };
 
 &rpm_requests {
-	pm8953-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8953-regulators";
 
 		vdd_l1-supply = <&pm8953_s3>;
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

