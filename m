Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3791D5A9281
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiIAI4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiIAI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:56:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821501348B5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:56:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k22so17152610ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Jy+Nx5e1wupR0KzXVzggqv8qHhtxj0ywC7sePqykO6s=;
        b=cpJLrjHLKTid6qkNL+p/FQKdSQ6xfVk28iz7axyGk8I9DbR7rqm4XUBl4sGWTK36mG
         v1LlB6E6BcMDdmrIypMdIZ9vxbcPq0whVOSG+519HQRRjeHI/VLMivWQ1l6PPGyS9WH9
         TFQpLsAkhUwN2P58dCXeUjh9yxMeXyYdNMB7/cDHqtLgMFsvOUNMtWhzZoEumHlqAo7k
         PiiWag83yNGYIE07Xr/eEplE94+KAFcLPn2fGFDXA86KzgVH9+T+Yc8SFzzYMxGwBRJL
         LydO4IPTkWn4wHMc0dGbc9gyKZ9mH1E6ugqusW2r85MVxn6bZBF2OZwqaTaGWVLhgFsg
         E8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Jy+Nx5e1wupR0KzXVzggqv8qHhtxj0ywC7sePqykO6s=;
        b=7kcI5cVmk9a29XV1+yMFPU0HRyRjOuPp6Yy5ckRwg85f9nwnExENqyXjZ1QJp+Tn/W
         uPnQKYcPiy5VFow3/UoAQxjNhVIXweUN+eHU5t7IhD9jJLFco1GvBu/+50JfbWbedAG8
         w0amfi4pJs+/v0ZXScTksXtMEA9/aOJCrYa5v7BQEG4gOZWyhKDbAK5nyu69276vZ5OD
         8R6J18wou5GNHiG6jcZ0+60/svb2IRSqL9rbSpNtbC/pYa7AO79RBsMJNaDJkh8xUCQw
         vWzrNnEAj5o5F3ln1n2mG8tKQmYEF5CvLzBVWDgl+O4FKgta7/P9tswrqAfdAjbEkysZ
         J1mg==
X-Gm-Message-State: ACgBeo0T3GSYzELNWMX5DN+zY9bgqPhGQmCv2zrg17fsjoxodreJnPLE
        UpQSr7C889EgBlDJpdmCYwbU4Q==
X-Google-Smtp-Source: AA6agR4SzbwimpRvnEDcVRpNXMzxY+xQNigfkYzUlA95yqrR9gR/a2LSxZyVtcanXaMR5LdXdpioMw==
X-Received: by 2002:a2e:9d8b:0:b0:265:b87d:b43b with SMTP id c11-20020a2e9d8b000000b00265b87db43bmr5196954ljj.531.1662022574317;
        Thu, 01 Sep 2022 01:56:14 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b004947984bc78sm883856lfs.188.2022.09.01.01.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 01:56:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 3/3] ARM: dts: qcom: align RPM regulators node name with bindings
Date:   Thu,  1 Sep 2022 11:56:09 +0300
Message-Id: <20220901085609.95624-3-krzysztof.kozlowski@linaro.org>
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
node to be just "regulators".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware, but I do not expect functional impact.
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

