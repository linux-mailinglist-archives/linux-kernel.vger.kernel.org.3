Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5703C5B166B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIHIKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiIHIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:09:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C924BEF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:09:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a8so4846506lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wy2QzsFfek5v84gPa6xvx08ZUFBkUuWpiHNRxUvUCgI=;
        b=Fv1NjPH+LCJf0qeZvpbIbIimXXSzCByk8Tl7k8fZvxsQdMUi09LZDLWFWlltwj0TtW
         TdG/HTH2WeApT4VFdoKB2hR9jcKhvGitR2U16jNayh1HumxyA0C8KxwfcCp3/13HWU1O
         NfpvHgrb/xVI86R2rLNTtz8PmXNk3B3uR3JR4GoCkvXmX5cHvQomrpuqynugCEMufQXA
         a0gtGk6+U/wv+oUIYXdriDyug/ux2tof/NV3ha/jzqi6KL0qtqeR98HO/QrEQ4+fP5TI
         jhClAQmjZ/6++TSofgMWWQxrn1Ff+muWWGm3zqkMGaZ6OXC/PLKiVG1MR2GObUe7gTjD
         ARuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wy2QzsFfek5v84gPa6xvx08ZUFBkUuWpiHNRxUvUCgI=;
        b=bV+vJXQo2fmIZHsmhOvKceVKDsXEqbgMJI8ULo1agDmjRFV6w0OBEK0L1Y8kCqFOzV
         wjbr4DH/nzsika8OLSY77j+83t928PTr77xFpsJtuasgfATXT8LsiO6nq0aFOxMduRVA
         xzJneFw7xggR4t9U6DCDyGWi88eDQBjufiXtM/A4LHDhy4oV/9uGLmc1JNnJQ3EDHJ+P
         viwEnjkCKfYktG740FLgSoC/MYdDele0LrPeUDa185LSrO6mib1WmPj8LHGgcRLRw9A5
         p9ewS3WwQ1VN7sMCC8LPtimhw5A+3+56jrdQ2Vt9pt64LhqpbdDJvFyAxZsPSWG4dcHJ
         zT3A==
X-Gm-Message-State: ACgBeo3as+nScw+G0fSRkrgH1vVeJQNOccShkEPErc8jwCTnMRnyXTPD
        joZJbkCAQ+z88m3XinVPIeE4tA==
X-Google-Smtp-Source: AA6agR511vMOPjaiTEode2TSJfN4y9rFDIv70sMPsxO5CKukWQermFCIAMJhkhzZRVmxu56PHJ+xkw==
X-Received: by 2002:a05:6512:2344:b0:497:a136:c5ea with SMTP id p4-20020a056512234400b00497a136c5eamr2211469lfu.563.1662624584572;
        Thu, 08 Sep 2022 01:09:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b004946b7593fesm2930173lfn.198.2022.09.08.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:09:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: use generic node name "gpio" in SPMI PMIC
Date:   Thu,  8 Sep 2022 10:09:37 +0200
Message-Id: <20220908080938.29199-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
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

GPIO controller nodes are named by convention just "gpio", not "gpios".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pm6350.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm7325.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8005.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 8a4972e6a24c..3cfd3eadccbf 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -86,7 +86,7 @@ pm6150_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
-		pm6150_gpio: gpios@c000 {
+		pm6150_gpio: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index f02c223ef448..8a7c18b134c7 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -55,7 +55,7 @@ pm6150l_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
-		pm6150l_gpio: gpios@c000 {
+		pm6150l_gpio: gpio@c000 {
 			compatible = "qcom,pm6150l-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm6350.dtsi b/arch/arm64/boot/dts/qcom/pm6350.dtsi
index ecf9b9919182..18c14257e2c1 100644
--- a/arch/arm64/boot/dts/qcom/pm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6350.dtsi
@@ -35,7 +35,7 @@ pm6350_resin: resin {
 			};
 		};
 
-		pm6350_gpios: gpios@c000 {
+		pm6350_gpios: gpio@c000 {
 			compatible = "qcom,pm6350-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index e1622b16c08b..ab934ff51f6d 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -170,7 +170,7 @@ vcoin: vcoin@83 {
 			};
 		};
 
-		pm660_gpios: gpios@c000 {
+		pm660_gpios: gpio@c000 {
 			compatible = "qcom,pm660-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 8aa0a5078772..f9b3864bd3b9 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -48,7 +48,7 @@ pm660l_temp: temp-alarm@2400 {
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm660l_gpios: gpios@c000 {
+		pm660l_gpios: gpio@c000 {
 			compatible = "qcom,pm660l-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
index e7f64a9ddc9c..cfd4b80c6e35 100644
--- a/arch/arm64/boot/dts/qcom/pm7325.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
@@ -18,7 +18,7 @@ pm7325_temp_alarm: temp-alarm@a00 {
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm7325_gpios: gpios@8800 {
+		pm7325_gpios: gpio@8800 {
 			compatible = "qcom,pm7325-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
index 50fb6c753bf8..8d4b081b4e9d 100644
--- a/arch/arm64/boot/dts/qcom/pm8005.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
@@ -11,7 +11,7 @@ pm8005_lsid0: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8005_gpio: gpios@c000 {
+		pm8005_gpio: gpio@c000 {
 			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 606c2a6d1f0f..08f9ca006e72 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -107,7 +107,7 @@ pm8916_mpps: mpps@a000 {
 			#interrupt-cells = <2>;
 		};
 
-		pm8916_gpios: gpios@c000 {
+		pm8916_gpios: gpio@c000 {
 			compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index e92e5ac414d3..672094c8ca58 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -108,7 +108,7 @@ adc-chan@f {
 			};
 		};
 
-		pm8994_gpios: gpios@c000 {
+		pm8994_gpios: gpio@c000 {
 			compatible = "qcom,pm8994-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index d09f2954b6f9..0d5163c720b7 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -101,7 +101,7 @@ rtc@6000 {
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		pm8998_gpio: gpios@c000 {
+		pm8998_gpio: gpio@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index 2e8b58f944e9..92a139ca4482 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -10,7 +10,7 @@ pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pmi8994_gpios: gpios@c000 {
+		pmi8994_gpios: gpio@c000 {
 			compatible = "qcom,pmi8994-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 3852a012bb0f..485bebb685f0 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -9,7 +9,7 @@ pmi8998_lsid0: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pmi8998_gpio: gpios@c000 {
+		pmi8998_gpio: gpio@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-- 
2.34.1

