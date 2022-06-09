Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAA544ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiFILmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiFILlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92411D0581
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg6so27095960ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AlVYTGpdyD/4RoZufqMfUAtnxIkgzdNZQq9JlVcPm2M=;
        b=wxAnFTfE1Q7Zm30aGELUytykVCqN/6lym2KHsshodGZw3e48MttI3JYTH7ksP24w8w
         gcoL7/WWYNmHaEvCxhL3dAmr7RIZx+isUKVQi6gPSIgNPGC0CbhfUleJ6cXnmU7Ds+tn
         DQCVs6sPeMmv45MX0KDbWaUmWY7F/9f/7kDDT+rgcTkrYYYVvYjBMssDIH2oUfEzVhcx
         gIHHZQOtgCaRQ0tNwyKRlEzV59IgotSL7Qk7p/XPauflIGqpZz0/YgAjP3YtWy0MGGOQ
         ZyMlSNochSnGZ9zMqzXnSwQu+wKdzUe0IMi1/1P1GU8EDmiVndIClthhcWN1WimzuU1V
         gTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AlVYTGpdyD/4RoZufqMfUAtnxIkgzdNZQq9JlVcPm2M=;
        b=mtWzfun0NVmFyhNg+BKB0kB6GZlQiuqPARpsi97a507FIdHzbT8Nvkokif/klghNFl
         VhIeP1/NcAuOA6n/JCXaT2lPKEEIPUSMOdxF61883zzMigv+zTMEjC1BbSAT2JsAGPTt
         ETkU/gkNmTBbVgc0PgAjGv0UJO7g6rY0nA6KTM+oM/EkpFDJRrBjjOKKR+kvAMirzvcN
         qG7AMVBbYGemdG702sBixUNv4nzyxAh3jyzcKKfqBlbXvRmXsAGXNj+dtfjZTBUg9ULf
         hgLsokvrhKBgALwOXRaJLmj0EnAc9IX522BCmMWasog1aCsPbPT+pN46jmq3+icR/hhn
         HDtA==
X-Gm-Message-State: AOAM5334fKFEGV9+OC/3V1UQhDf804IaSQs4Immgg0HT2WzStHslIRu0
        y7im47ltQfPFTNJK4VLAneBpjg==
X-Google-Smtp-Source: ABdhPJxXw+ZR2TDeopukgwrEhWfDrwekxalrADX8jDFEbvAO1nHqPBv7LyBnA7aVusYcHtGEg6A/Qg==
X-Received: by 2002:a17:907:86ac:b0:708:9c4a:c6e9 with SMTP id qa44-20020a17090786ac00b007089c4ac6e9mr36074394ejc.297.1654774821875;
        Thu, 09 Jun 2022 04:40:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 28/48] arm64: dts: qcom: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:01 +0200
Message-Id: <20220609114002.380563-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts               |  4 +---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts            |  4 +---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts      |  4 +---
 .../boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi    | 10 ++++------
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts        |  2 --
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi  |  2 --
 .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts  |  2 --
 7 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7c1eab605c15..21242919fe18 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -92,14 +92,12 @@ hdmi_con: endpoint {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&msm_key_volp_n_default>;
 
-		button@0 {
+		button {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 1dbfedd5711c..ba76d4620224 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -84,14 +84,12 @@ div1_mclk: divclk1 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&volume_up_gpio>;
 
-		button@0 {
+		button {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index cdb2dfe02e56..04887182bca3 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -53,11 +53,9 @@ framebuffer0: framebuffer@3400000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
-		button@0 {
+		button {
 			label = "Volume Up";
 			gpios = <&pm8994_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index 0fb12db47d6e..f430d797196f 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -29,11 +29,9 @@ / {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
-		button@0 {
+		button-0 {
 			label = "Volume Down";
 			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -42,7 +40,7 @@ button@0 {
 			debounce-interval = <15>;
 		};
 
-		button@1 {
+		button-1 {
 			label = "Volume Up";
 			gpios = <&pm8994_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -51,7 +49,7 @@ button@1 {
 			debounce-interval = <15>;
 		};
 
-		button@2 {
+		button-2 {
 			label = "Camera Snapshot";
 			gpios = <&pm8994_gpios 4 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -60,7 +58,7 @@ button@2 {
 			debounce-interval = <15>;
 		};
 
-		button@3 {
+		button-3 {
 			label = "Camera Focus";
 			gpios = <&pm8994_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 1ffe72b47f67..6a200f37c035 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -101,8 +101,6 @@ key-alt {
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Side buttons";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vol_up_pin_a>, <&cam_focus_pin_a>,
 			    <&cam_snapshot_pin_a>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index bc06b485897c..42e89f41eb7d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -90,8 +90,6 @@ cam_vana_rear_vreg: cam_vana_rear_vreg {
 	gpio-keys {
 		status = "okay";
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		key-camera-focus {
 			label = "Camera Focus";
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index f933b6c4f763..c9f195649954 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -42,8 +42,6 @@ extcon_usb: extcon-usb {
 	gpio-keys {
 		status = "okay";
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		key-vol-dn {
-- 
2.34.1

