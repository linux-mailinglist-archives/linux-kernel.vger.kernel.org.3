Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE97544ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiFILmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiFILlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95EE1D05BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so46927721ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8orKcQCNGPdlvhZ2/3zKOIbEnP0TxqJp0m/ZByBcxdE=;
        b=UMlk8uPIPaL1cPW+we2w/t+x+U0WPyAS+CHq75BRzU+ztVSth00Yi4ACtTV7chfwEv
         2CX+9cWEwZbcrslaULwbzZ5t2663g8MvvJsm98+VER1zZ0fBnhm6bIIJKkweYFCzXgNG
         vHalFCxDCpLB31S66F1LAp3LfXxpEajNkdWMEIvs3Fr3AMt4FtKoRsAAAseVdG0hfZgn
         LQKyR4XMltrdrSMN1pgDKAruyg6iZg9REbB2tk37qRa+MP4SuUeIBf0DFXVRQ4b8juI3
         1Wpjz+LqL+xyciX7fzIpA0a9Cn5rEx05e+fVZDpk+yJEdyvq2Iskyv7A31wyP7/VR+aR
         S7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8orKcQCNGPdlvhZ2/3zKOIbEnP0TxqJp0m/ZByBcxdE=;
        b=KrTwkPKqd3NquEJGYsmpzBe589Gnutx/s+7TT6kQW4R13pVKR4PpIUuytT27Q9ftM7
         jkVYuI6zfD0zbo2BWHzdUp/SugwW8T4His/h5rOWqnpN+7Y6Gq5HMXVly5/j1yngvb3C
         Cz7ov+mQsPrYQeJwrQlIs/BUFJlbYigP9HX/5bZ7dYhzGrQbWI/ZYLBezL88WDSkpjWB
         5mjWPca/Uc4psxrzp791TAcnV8FgzLJe9AFKjanckN4Wkab17Ga6TTvwEF1FQJxZSBp0
         SGkV1erqc3iOmFj40F/AwNgkzBJ/G53PqvWLtbk/ns2iCJdEQuU5fT7oyQ9grOvQZPqW
         cCEA==
X-Gm-Message-State: AOAM530BV87HJ9OPHgH0Jpt/u+Dj4O0ZwqSqEJieLD4kZDKHLglmgLZM
        L3q/R2AaiVr5VAU6qz0Pk/9eGA==
X-Google-Smtp-Source: ABdhPJxjUiV+hDLzOCCm0KCO6PWsy/LzLmNiVCcX/P2et6zDhQFyEFtTPGRyrKQrmgzzC0927mvH6g==
X-Received: by 2002:a17:906:5959:b0:710:c2e8:79f3 with SMTP id g25-20020a170906595900b00710c2e879f3mr25631359ejr.489.1654774820296;
        Thu, 09 Jun 2022 04:40:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 27/48] arm64: dts: qcom: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:00 +0200
Message-Id: <20220609114002.380563-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  2 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts |  2 +-
 .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts |  4 ++--
 .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts |  2 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts |  2 +-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts |  2 +-
 .../qcom/msm8916-samsung-a2015-common.dtsi    |  6 +++---
 .../boot/dts/qcom/msm8916-samsung-j5.dts      |  4 ++--
 .../dts/qcom/msm8916-samsung-serranove.dts    |  6 +++---
 .../dts/qcom/msm8916-wingtech-wt88047.dts     |  2 +-
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |  2 +-
 .../dts/qcom/msm8994-msft-lumia-octagon.dtsi  | 10 +++++-----
 .../qcom/msm8994-sony-xperia-kitakami.dtsi    |  2 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  6 +++---
 .../boot/dts/qcom/msm8998-fxtec-pro1.dts      | 20 +++++++++----------
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi |  6 +++---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  8 ++++----
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  2 +-
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  4 ++--
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  4 ++--
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  2 +-
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |  2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  2 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  4 ++--
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |  2 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts       |  4 ++--
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |  4 ++--
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts       |  4 ++--
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  2 +-
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |  2 +-
 36 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 49afbb1a066a..1dbfedd5711c 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -82,7 +82,7 @@ div1_mclk: divclk1 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 265e539e7e99..3dc9619fde6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -27,7 +27,7 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index d4d33dd3584a..dd92070a1211 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -28,14 +28,14 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			debounce-interval = <15>;
 		};
 
-		volume-down {
+		button-volume-down {
 			label = "Volume Down";
 			gpios = <&msmgpio 117 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 00488afb413d..9e470c67274e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -39,7 +39,7 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index b3836dde8a54..d85e7f7c0835 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -39,7 +39,7 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index f9ce123471d4..b4812f093b17 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -28,7 +28,7 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 9b4b7de7cec2..72c829bf0b2e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -31,13 +31,13 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		home {
+		button-home {
 			label = "Home";
 			gpios = <&msmgpio 109 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;
@@ -52,7 +52,7 @@ gpio-hall-sensor {
 
 		label = "GPIO Hall Effect Sensor";
 
-		hall-sensor {
+		event-hall-sensor {
 			label = "Hall Effect Sensor";
 			gpios = <&msmgpio 52 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index 6c408d61de75..eabeed18cfaa 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -34,13 +34,13 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		home-key {
+		button-home {
 			label = "Home Key";
 			gpios = <&msmgpio 109 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 58dfbfff4c7d..439e89cf7878 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -49,13 +49,13 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		home {
+		button-home {
 			label = "Home";
 			gpios = <&msmgpio 109 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;
@@ -70,7 +70,7 @@ gpio-hall-sensor {
 
 		label = "GPIO Hall Effect Sensor";
 
-		hall-sensor {
+		event-hall-sensor {
 			label = "Hall Effect Sensor";
 			gpios = <&msmgpio 52 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 69a44c6f57fc..84a352dcf9a2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -29,7 +29,7 @@ gpio-keys {
 
 		label = "GPIO Buttons";
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index 7748b745a5df..cdb2dfe02e56 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -51,7 +51,7 @@ framebuffer0: framebuffer@3400000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index cc038f9b641f..a84a36edc4fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -64,7 +64,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		volupkey {
+		volup-key {
 			label = "Volume Up";
 			gpios = <&pm8994_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -73,7 +73,7 @@ volupkey {
 			debounce-interval = <15>;
 		};
 
-		camsnapkey {
+		camsnap-key {
 			label = "Camera Snapshot";
 			gpios = <&pm8994_gpios 4 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -82,7 +82,7 @@ camsnapkey {
 			debounce-interval = <15>;
 		};
 
-		camfocuskey {
+		camfocus-key {
 			label = "Camera Focus";
 			gpios = <&pm8994_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -100,7 +100,7 @@ gpio-hall-sensor {
 
 		label = "GPIO Hall Effect Sensor";
 
-		hall-front-sensor {
+		event-hall-front-sensor {
 			label = "Hall Effect Front Sensor";
 			gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
 			linux,input-type = <EV_SW>;
@@ -108,7 +108,7 @@ hall-front-sensor {
 			linux,can-disable;
 		};
 
-		hall-back-sensor {
+		event-hall-back-sensor {
 			label = "Hall Effect Back Sensor";
 			gpios = <&tlmm 75 GPIO_ACTIVE_HIGH>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index e5a45af0bd12..0fb12db47d6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -27,7 +27,7 @@ / {
 	/* Kitakami firmware doesn't support PSCI */
 	/delete-node/ psci;
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index a7090befc16f..2077d9f45a55 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -38,10 +38,10 @@ divclk4: divclk4 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		vol_up {
+		key-vol-up {
 			label = "Volume Up";
 			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -49,7 +49,7 @@ vol_up {
 			debounce-interval = <15>;
 		};
 
-		dome {
+		key-dome {
 			label = "Home";
 			gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index dc5b9b274df3..1ffe72b47f67 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -33,7 +33,7 @@ gpio-hall-sensors {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hall_sensor1_default>;
 
-		hall-sensor1 {
+		event-hall-sensor1 {
 			label = "Keyboard Hall Sensor";
 			gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
 			debounce-interval = <15>;
@@ -49,7 +49,7 @@ gpio-kb-extra-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_kb_pins_extra>;
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&tlmm 21 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;
@@ -57,7 +57,7 @@ home {
 			linux,can-disable;
 		};
 
-		super-l {
+		key-super-l {
 			label = "Super Left";
 			gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_FN>;
@@ -65,7 +65,7 @@ super-l {
 			linux,can-disable;
 		};
 
-		super-r {
+		key-super-r {
 			label = "Super Right";
 			gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_FN>;
@@ -73,7 +73,7 @@ super-r {
 			linux,can-disable;
 		};
 
-		shift {
+		key-shift {
 			label = "Shift";
 			gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RIGHTSHIFT>;
@@ -81,7 +81,7 @@ shift {
 			linux,can-disable;
 		};
 
-		ctrl {
+		key-ctrl {
 			label = "Ctrl";
 			gpios = <&tlmm 128 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_LEFTCTRL>;
@@ -89,7 +89,7 @@ ctrl {
 			linux,can-disable;
 		};
 
-		alt {
+		key-alt {
 			label = "Alt";
 			gpios = <&tlmm 129 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_LEFTALT>;
@@ -106,7 +106,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_up_pin_a>, <&cam_focus_pin_a>,
 			    <&cam_snapshot_pin_a>;
-		vol-up {
+		button-vol-up {
 			label = "Volume Up";
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -115,7 +115,7 @@ vol-up {
 			debounce-interval = <15>;
 		};
 
-		camera-snapshot {
+		button-camera-snapshot {
 			label = "Camera Snapshot";
 			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -123,7 +123,7 @@ camera-snapshot {
 			debounce-interval = <15>;
 		};
 
-		camera-focus {
+		button-camera-focus {
 			label = "Camera Focus";
 			gpios = <&pm8998_gpio 8 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index dbaea360bffc..cca5c9dfa96d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -77,7 +77,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_keys_default>;
 
-		vol-down {
+		button-vol-down {
 			label = "Volume down";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
@@ -85,7 +85,7 @@ vol-down {
 			wakeup-source;
 		};
 
-		vol-up {
+		button-vol-up {
 			label = "Volume up";
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -101,7 +101,7 @@ gpio-hall-sensor {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hall_sensor_default>;
 
-		hall-sensor {
+		event-hall-sensor {
 			label = "Hall Effect Sensor";
 			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 47488a1aecae..9ad875c4a6ca 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -97,7 +97,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_down_pin_a>, <&cam_focus_pin_a>,
 			    <&cam_snapshot_pin_a>;
-		vol-down {
+		button-vol-down {
 			label = "Volume Down";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -106,7 +106,7 @@ vol-down {
 			debounce-interval = <15>;
 		};
 
-		camera-snapshot {
+		button-camera-snapshot {
 			label = "Camera Snapshot";
 			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -114,7 +114,7 @@ camera-snapshot {
 			debounce-interval = <15>;
 		};
 
-		camera-focus {
+		button-camera-focus {
 			label = "Camera Focus";
 			gpios = <&pm8998_gpio 8 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -129,7 +129,7 @@ gpio-hall-sensor {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hall_sensor0_default>;
 
-		hall-sensor0 {
+		event-hall-sensor0 {
 			label = "Cover Hall Sensor";
 			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index e55dbaa6dc12..53d76406ed25 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -330,7 +330,7 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pen_pdct_l>;
 
-		pen_insert: pen-insert {
+		pen_insert: switch-pen-insert {
 			label = "Pen Insert";
 
 			/* Insert = low, eject = high */
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 5eb668991e24..5b294e81dbbc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -27,7 +27,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&key_vol_up_default>;
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 42af1fade461..bc06b485897c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -87,13 +87,13 @@ cam_vana_rear_vreg: cam_vana_rear_vreg {
 		pinctrl-0 = <&imx300_vana_default>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		status = "okay";
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		camera_focus {
+		key-camera-focus {
 			label = "Camera Focus";
 			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -101,7 +101,7 @@ camera_focus {
 			debounce-interval = <15>;
 		};
 
-		camera_snapshot {
+		key-camera-snapshot {
 			label = "Camera Snapshot";
 			gpios = <&tlmm 113 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -109,7 +109,7 @@ camera_snapshot {
 			debounce-interval = <15>;
 		};
 
-		vol_down {
+		key-vol-down {
 			label = "Volume Down";
 			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 8b815b2a60a7..891e314bc782 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -27,7 +27,7 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index dcbaacf18f66..5a1df51a2da7 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -51,7 +51,7 @@ vph_pwr: vph-pwr-regulator {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		volup {
+		key-volup {
 			label = "Volume Up";
 			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e7e4cc5936aa..14ffa0f96850 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -119,7 +119,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pen_eject_odl>;
 
-		pen-insert {
+		switch-pen-insert {
 			label = "Pen Insert";
 			/* Insert = low, eject = high */
 			gpios = <&tlmm 119 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..a6986f95a80a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -43,14 +43,14 @@ dc12v: dc12v-regulator {
 		regulator-always-on;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_up_pin_a>;
 
-		vol-up {
+		key-vol-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 07b729f9fec5..750c609c9258 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -34,14 +34,14 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&volume_down_gpio &volume_up_gpio>;
 
-		vol-down {
+		key-vol-down {
 			label = "Volume down";
 			linux,code = <KEY_VOLUMEDOWN>;
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
 			debounce-interval = <15>;
 		};
 
-		vol-up {
+		key-vol-up {
 			label = "Volume up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 103cc40816fd..07e8ab9e455d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -48,7 +48,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&volume_up_gpio>;
 
-		vol-up {
+		key-vol-up {
 			label = "volume_up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 281fe6dea62a..51ee42e3c995 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -19,7 +19,7 @@ gpio-keys {
 
 		/* Neither Camera Focus, nor Camera Shutter seem to work... */
 
-		vol-down {
+		key-vol-down {
 			label = "volume_down";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index d88dc07205f7..c396f30db050 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -45,7 +45,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_up_pin_a>;
 
-		vol-up {
+		key-vol-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index f1619b3f97ef..48fe2de28635 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -41,7 +41,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&lid_pin_active>, <&mode_pin_active>;
 
-		lid {
+		switch-lid {
 			gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
@@ -49,7 +49,7 @@ lid {
 			wakeup-event-action = <EV_ACT_DEASSERTED>;
 		};
 
-		mode {
+		switch-mode {
 			gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_TABLET_MODE>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 871ccbba445b..f933b6c4f763 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -46,7 +46,7 @@ gpio-keys {
 		#size-cells = <0>;
 		autorepeat;
 
-		vol-dn {
+		key-vol-dn {
 			label = "Volume Down";
 			gpios = <&tlmm 47 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 61925216f5e3..0301f600e206 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -48,7 +48,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin>;
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm6350_gpios 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 37ddca0f0223..3331ee957d64 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -44,10 +44,10 @@ vreg_s4a_1p8: pm8150-s4 {
 		vin-supply = <&vph_pwr>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		vol-up {
+		key-vol-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index a73317e1a824..bb278ecac3fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -49,10 +49,10 @@ vreg_s4a_1p8: pm8150-s4 {
 		vin-supply = <&vph_pwr>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		vol_up {
+		key-vol-up {
 			label = "Volume Up";
 			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
index 3b082472062b..632e98193d27 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
@@ -53,10 +53,10 @@ vreg_s6c_0p88: smpc6-regulator {
 		vin-supply = <&vph_pwr>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		vol-up {
+		key-vol-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index e819b5b77363..549e0a2aa9fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -57,7 +57,7 @@ gpio_keys: gpio-keys {
 		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
 		 */
 
-		vol-down {
+		key-vol-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
 			gpios = <&pm8150_gpios 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 90b13cbe2fa6..cb9bbd234b7b 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -49,7 +49,7 @@ gpio-keys {
 
 		/* For reasons still unknown, GAssist key and Camera Focus/Shutter don't work.. */
 
-		vol-down {
+		key-vol-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
 			gpios = <&pmk8350_gpios 3 GPIO_ACTIVE_LOW>;
-- 
2.34.1

