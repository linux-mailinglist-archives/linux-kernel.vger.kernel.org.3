Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1415A9344
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiIAJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiIAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:34:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1644133F37
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:34:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x10so17244774ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pCsNP9MbZ025gHs9OjCXOsmaJmHix0BqZR8j/xHE3Mo=;
        b=x2ByYfRaEeVq05W02vKtaLFmP6XetOzHQF0mYm7moturGUufU7dPL40XdMLX9Ufoig
         6Y3Q/gmSLSEgQe5Dckiwy+YVgtRdO+Zb1oSQjgrtJ+3P+H7+jzvUoei8BTavGbmecvRe
         lRsIat19pUFTP91ZPcg032Elh7dvoO4WRTWyZdQNRe32wxUjR5yPt3Pij55rcNd8+j6V
         sQa7L22OmT+2h5WV8RrdSbtU8Z9iAKUUQJINVEy0fc3mbeW1/K4eOjlJag3wrdZS7/nf
         FKzZykMSI44ebu6oscvn1ACW1BK/DRrSd+sgEusnpLL4lbXAPvLIRJV0ub3d24TbUjD2
         Kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pCsNP9MbZ025gHs9OjCXOsmaJmHix0BqZR8j/xHE3Mo=;
        b=teG3Pqdj7A2YuYLYiIXWqQmqezGPY/jdszWAB2x3c6aGegXQKswRAiJKl1zEh8CtwV
         iP18b5FlB7J6r12t99xelnjGY5CKVGhgB0RqJYQ775OSHydtAu3zGHiSoFo5SOxU+o11
         uexZNDsm2L9TeEUXr9LejGlsae4BxgQLzlUISNAaD7zWKtfcP4r6nSiEWJ87bizLWTMe
         Rq0qgIxKM8oaR9/1vm6ixRYOGYIJoWIjmjFdlTkHfIFFv9G0EYOkwK4vgU+41tHjGmoh
         55Rjkchmx4RlW9lAm7nJ/4UmuuSI8k/wjTXip5wzxGB9Zqve/2EEA3A76IPLnlmskcI7
         khEw==
X-Gm-Message-State: ACgBeo22yvtHXybY8RIu9ihGXe884TGoUYLZ/i6BEyL/UFnO2j7/uaCP
        mQzXzOHzov8SxUvx7QRhqbceZQ==
X-Google-Smtp-Source: AA6agR78A1kG72lKgOLZtqfNXpnCKHHJpWE3Jgr2dgcCxfNDljAAt/nhzhWtP+TEOSYZWKQzkzkfLQ==
X-Received: by 2002:a2e:b8d6:0:b0:268:9b1d:5084 with SMTP id s22-20020a2eb8d6000000b002689b1d5084mr1627916ljp.37.1662024847203;
        Thu, 01 Sep 2022 02:34:07 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b0049486c66140sm638830lfr.119.2022.09.01.02.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:34:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT v2 4/4] ARM: dts: qcom: align RPM regulators node name with bindings
Date:   Thu,  1 Sep 2022 12:34:01 +0300
Message-Id: <20220901093401.134473-3-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts               | 2 +-
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts                   | 2 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                | 4 ++--
 arch/arm/boot/dts/qcom-apq8084.dtsi                           | 2 +-
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts      | 4 ++--
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi         | 4 ++--
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts           | 4 ++--
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts            | 2 +-
 .../boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
index ace8cea27949..2908a8a8a3d0 100644
--- a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
@@ -81,7 +81,7 @@ &pm8226_vib {
 };
 
 &rpm_requests {
-	pm8226-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
 
 		pm8226_s3: s3 {
diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 2b7e52fda6a7..e5bdc12123ce 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -102,7 +102,7 @@ bluetooth {
 };
 
 &rpm_requests {
-	pm8226-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
 
 		pm8226_s3: s3 {
diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 3051a861ff0c..86ba9165c2b3 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -57,7 +57,7 @@ phy@b {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -81,7 +81,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index c2e22bf3260d..2f4e4ac686a5 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -479,7 +479,7 @@ rpm-requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
 
-				pma8084-regulators {
+				regulators-0 {
 					compatible = "qcom,rpm-pma8084-regulators";
 
 					pma8084_s1: s1 {};
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ec5d340562b6..8a3761ed9655 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -344,7 +344,7 @@ led@5 {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -368,7 +368,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..320c9bf397f8 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -214,7 +214,7 @@ &pm8941_wled {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -238,7 +238,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index ff6e0066768b..9107bc6f24db 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -190,7 +190,7 @@ &remoteproc_mss {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -209,7 +209,7 @@ pm8841_s3: s3 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 983e10c3d863..156023204c1e 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -470,7 +470,7 @@ &remoteproc_mss {
 };
 
 &rpm_requests {
-	pma8084-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pma8084-regulators";
 
 		pma8084_s1: s1 {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b..e4580ed996e6 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -319,7 +319,7 @@ led@7 {
 };
 
 &rpm_requests {
-	pm8941-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
-- 
2.34.1

