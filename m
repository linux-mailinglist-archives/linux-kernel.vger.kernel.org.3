Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC4513A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350201AbiD1QoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348434AbiD1QoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:44:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE786A03C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:40:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z21so4436495pgj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXJKR00wvkycdvT6TPr1fYF0dlKSYComfBgslJPcqUg=;
        b=Hfg37qUBoxT/tJA4PlaWnFD8Wl+VbzMwHUjbWmaMMWlsEKPNVEtP7l76W2gCu7+Le8
         Oup0O8NwtKzNSoBod+1AY8DLacrkCvUUbKd20bSP2BjouPoU32F716V6YbrsISgwUMGp
         jxwixxMYOx5WYtZNh7aB5HOp6OB8os5DMGwog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXJKR00wvkycdvT6TPr1fYF0dlKSYComfBgslJPcqUg=;
        b=8J4ZzKy2LmFNb0aYXP5wL3wTDd3NzKyUnIquMcNdcu0ROdlLeuLqnBAq4fze30wbVS
         c94fsBQKHjlVx7dbUR19uzobL6MT8P5Muobur3zA9IRns7cYNq078uuVm+rgsIOsr4/E
         1sBQ+Pj9crHW52eOLGPrJvfUr7t12WEWdVZSxNsrcJukxatKdrrHosWe4QxlFdv1nEvb
         2+tccQIfGhf/47Uz2kPcYgeUj80OxR+zZbEmEgRxpOfQIJcmAX5JTkjgpXmq6nZwADVH
         b8krikuX7sAMoABEjN5KbFHkvNaElcX0fQcaPejl2zlIbXTHrwnw4CYpWQdmkFFjCkjy
         R1Mw==
X-Gm-Message-State: AOAM5326qXMxDE88182dUYuFN6Ji6J1cpg88S8EK1glX6SWvQt2ohwbc
        UxYBjj7nhVNIeBpnQgHJsgCo8A==
X-Google-Smtp-Source: ABdhPJxpf9y/5E7y7cZwrxOq+jsEgSw9EneiSRhkeaWmH1ueGxU06UYmI49wfMgvtBexQectLgslZA==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr35535042pfj.83.1651164059069;
        Thu, 28 Apr 2022 09:40:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7a56:fc44:2682:8a2e])
        by smtp.gmail.com with UTF8SMTPSA id n25-20020a056a00213900b0050d299f086asm329564pfj.155.2022.04.28.09.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 09:40:58 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v23 1/2] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Thu, 28 Apr 2022 09:40:53 -0700
Message-Id: <20220428094043.v23.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Depends on "usb: misc: Add onboard_usb_hub driver" [1] which landed in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing

This patch was split off the above series.

[1] https://patchwork.kernel.org/project/linux-usb/list/?series=615531&state=%2A&archive=both

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
index b142006478ea..caa2d3db4bc4 100644
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
index 59740799fa3a..0dc50ed62c46 100644
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
index 457c25499863..0cbb7a68d58b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -43,17 +43,6 @@ &panel {
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
@@ -62,6 +51,14 @@ &trackpad {
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
index b0efb354458c..39e1121c5d77 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -296,7 +296,7 @@ pp3300_hub: pp3300-hub-regulator {
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
+		companion-hub = <&usb_hub_3_x>;
+	};
+
+	/* 3.x hub on port 2 */
+	usb_hub_3_x: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_2_x>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.36.0.464.gb9c8b46e94-goog

