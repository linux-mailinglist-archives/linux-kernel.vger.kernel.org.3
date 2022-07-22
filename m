Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EF57E478
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiGVQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiGVQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:32:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F193696
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:32:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q5so4967789plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHkzVngUg8JraIw7WAXXxeWawYCL64dfVzj3JndI8ec=;
        b=DE2j5M49eA0g6LUo3qmfRgAkAVCAZ25hPgegh6+UVPoOmTzpn8rAXFkIP0oOfwXvha
         UztqAnN2YyS9d8hnn7uqvYA3yyl1F1VywFKiMoYWa+giIVfo/vo1+HQzt+DEkym5RUDO
         WhiCT49Jgu0Rreh3e8zCKN1zUEw+zKQUtTHgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHkzVngUg8JraIw7WAXXxeWawYCL64dfVzj3JndI8ec=;
        b=cV+k26WmvTeybf/x+cROAJfeQ/0HA149NJE21IpcJSOwzlUc/jl08JwDOPsYv404S8
         mUqNStkpoT/27jARrHbe5LZ89bgkXf2kThKKUns9v/vDh+enKq6YRHrVgZEZbH0001um
         N1h0azsZCgRK8cWhYyLqBQbFBG7F8oSqph1WtYTUMGhOC6wCfV+KUdgLgXn8cQTt4eVu
         2DrKI7UZSV/6104TV79cKltp9VlOBFbZ4J/buqEc1angOocNmKJlWtNQnnzuqjVxXH75
         ScKHNt2pH1+0KVcXeXINMsOsYk+8ShQ/1Nx1BTie38TDuYM2fiWSa7YdSssPr9c2kpJn
         lLDg==
X-Gm-Message-State: AJIora8GTVsQUsYidRftCYZmURDjNp1zdS4M36cox0mUWH9fqXa6YpGS
        oILBpetYTcQc5tuvy0Xo9BUVMw==
X-Google-Smtp-Source: AGRyM1uRxtJn7DjJ7STDDPVY6rF/tZpRTUckHUDOghrPwyx+1x6dBFGv2TK/4Y/5TjP2KcWVjgY+gg==
X-Received: by 2002:a17:902:bb91:b0:16c:3f7f:6df0 with SMTP id m17-20020a170902bb9100b0016c3f7f6df0mr672035pls.99.1658507569276;
        Fri, 22 Jul 2022 09:32:49 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:42b0:2897:3725:985a])
        by smtp.gmail.com with UTF8SMTPSA id u8-20020a1709026e0800b001640aad2f71sm3943818plk.180.2022.07.22.09.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:32:48 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v24 1/2] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Fri, 22 Jul 2022 09:32:44 -0700
Message-Id: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on trogdor devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

For anyone using trogdor-based devices on Linux, it should be
noted that this requires "CONFIG_USB_ONBOARD_HUB=y".

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
This series depends on 3a6bf4a08142 ("usb: core: hub: Create platform
devices for onboard hubs in hub_probe()") which landed in -next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=3a6bf4a08142826698121bef16b244dcf50a6431

Changes in v24:
- renamed 'companion-hub' to 'peer-hub' according to the change
  in the binding

Changes in v23:
- added note about enabling CONFIG_USB_ONBOARD_HUB to the commit
  message

Changes in v22:
- none

Changes in v21:
- patch dropped from onboard_usb_hub series

Changes in v20:
- renamed hub labels to 'usb_hub_2/3_x'
- added comment for 'regulator-boot-on' of 'pp3300_hub'
- added 'Reviewed-by' tags from Stephen and Doug

Changes in v19:
- none

Changes in v18:
- also adjust config for pompom rev1

Changes in v17:
- none

Changes in v16:
- none

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- none

Changes in v12:
- none

Changes in v11:
- rebased on qcom/arm64-for-5.14 (with the rest of the series)

Changes in v10:
- keep 'regulator-boot-on' property
- updated commit message

Changes in v9:
- none

Changes in v8:
- none

Changes in v7:
- rebased on qcom/arm64-for-5.13 (with the rest of the series)

Changes in v6:
- added 'companion-hub' entry to both USB devices
- added 'vdd-supply' also to hub@2

Changes in v5:
- patch added to the series

 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++----------
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++------
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 11 ++++------
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++----------
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 20 ++++++++++++++++++-
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index bfbf26fd2cd4..d49de65aa960 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -16,17 +16,6 @@ / {
 	compatible = "google,lazor-rev0", "qcom,sc7180";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
-};
-
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
-};
-
 &sn65dsi86_out {
 	/*
 	 * Lane 0 was incorrectly mapped on the cable, but we've now decided
@@ -35,3 +24,11 @@ &sn65dsi86_out {
 	 */
 	lane-polarities = <1 0>;
 };
+
+&usb_hub_2_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index d45a59afd7fc..80c7108bc51b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -16,13 +16,11 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
+
+&usb_hub_2_x {
+	 vdd-supply = <&pp3300_l7c>;
 };
 
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
+&usb_hub_3_x {
+	 vdd-supply = <&pp3300_l7c>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index 76a130bad60a..8467ff41e6d5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -34,13 +34,10 @@ &pm6150_adc_tm {
 	/delete-node/ charger-thermistor@0;
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
+&usb_hub_2_x {
+	 vdd-supply = <&pp3300_l7c>;
 };
 
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
+&usb_hub_3_x {
+	 vdd-supply = <&pp3300_l7c>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 59a23d0e9651..bc097d1b1b23 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -44,17 +44,6 @@ &panel {
 	compatible = "auo,b116xa01";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
-};
-
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
-};
-
 &sdhc_2 {
 	status = "okay";
 };
@@ -63,6 +52,14 @@ &trackpad {
 	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 };
 
+&usb_hub_2_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index b5f534db135a..eae22e6e97c1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -299,7 +299,7 @@ pp3300_hub: pp3300-hub-regulator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&en_pp3300_hub>;
 
-		regulator-always-on;
+		/* The BIOS leaves this regulator on */
 		regulator-boot-on;
 
 		vin-supply = <&pp3300_a>;
@@ -936,6 +936,24 @@ &usb_1 {
 
 &usb_1_dwc3 {
 	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.x hub on port 1 */
+	usb_hub_2_x: hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		vdd-supply = <&pp3300_hub>;
+		peer-hub = <&usb_hub_3_x>;
+	};
+
+	/* 3.x hub on port 2 */
+	usb_hub_3_x: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		peer-hub = <&usb_hub_2_x>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.37.1.359.gd136c6c3e2-goog

