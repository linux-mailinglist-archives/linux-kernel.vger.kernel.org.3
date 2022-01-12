Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F6148CB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356650AbiALTLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356671AbiALTLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:11:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BA0C02983E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:11:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id oa15so7033911pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+bvR63I7KR8sEFELGUNVYeIRATxm3eSr33Bl5gS1To=;
        b=EVWvBXjRy2Ry33Tx++6Y0hAcx7n28QD/RB9sLVZywtVrmEIMbCOzGVpBPQr3/bJJWo
         MV12P84YmLpW5dGpgelspP15QWyo1JVLbaoAyfjFQSxKB/21o6qP3weO2js7F9ewh4FG
         T5bgmtR8NuMdN51SKck9RqlA6WmZGBWZhFC9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+bvR63I7KR8sEFELGUNVYeIRATxm3eSr33Bl5gS1To=;
        b=NjlwcvvRh573U+1dtYvC6fceniBZgLQ+YobaGl6hKkXCddzqSF4w4t+aDaCiv3CeH1
         o1ebiiCFEwZ9MRs5Y/gByM9i2xwrXg0y5wVCAIPP2YP06JN8Dq9fEm8/Gp1hJNDU/D0V
         aic6d8oyRYlCb0JsVygg2mB01/uaqAD1Ck0zAYbsps6J28M31JtBHnLH9vdh7A/Bjsi9
         kvn9PfMYRf5Ep/vTEnnwJ54otRNnD5nw8WKuQRLL/7Vcx0/2gpEiRLC+NDT11EJurSnt
         WEcEsS1RgnIQO3aI9udrxTZqCgRupfC3IbiUoypJ7JZu9hRI78FbnXKcvG187n8jxacr
         4etQ==
X-Gm-Message-State: AOAM533BxUw05hHJg8NAn+oMfybftFmhr7hAiAkyePYIbGjPrS1Q5ZYq
        2/BOmN6bXBQfEwrkIhA+vy8tEw==
X-Google-Smtp-Source: ABdhPJwcgGe7fK+/F3zBdr7heZHFA4sXA1EN48Rg3VtNYOcxsstsz76aHYSt4unv2pfINRTH1fEKJA==
X-Received: by 2002:a63:9b0a:: with SMTP id r10mr900079pgd.405.1642014662199;
        Wed, 12 Jan 2022 11:11:02 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f6eb:5b26:28c:1ca5])
        by smtp.gmail.com with UTF8SMTPSA id s8sm325254pfu.190.2022.01.12.11.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:11:01 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v19 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Wed, 12 Jan 2022 11:10:48 -0800
Message-Id: <20220112111028.v19.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220112191048.837236-1-mka@chromium.org>
References: <20220112191048.837236-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on trogdor devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

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

 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++-----------
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++-------
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 11 ++++-------
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++-----------
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 19 ++++++++++++++++++-
 5 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 30e3e769d2b4..5fb8e12af1a0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -14,17 +14,6 @@ / {
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
@@ -33,3 +22,11 @@ &sn65dsi86_out {
 	 */
 	lane-polarities = <1 0>;
 };
+
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..1dae714250f5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -14,13 +14,11 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
+
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
 
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index 76a130bad60a..c913bb5677e5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -34,13 +34,10 @@ &pm6150_adc_tm {
 	/delete-node/ charger-thermistor@0;
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
 
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 457c25499863..8477c82c410a 100644
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
 
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d4f4441179fc..cd31460b3bd6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -202,7 +202,6 @@ pp3300_hub: pp3300-hub {
 		pinctrl-names = "default";
 		pinctrl-0 = <&en_pp3300_hub>;
 
-		regulator-always-on;
 		regulator-boot-on;
 
 		vin-supply = <&pp3300_a>;
@@ -839,6 +838,24 @@ &usb_1 {
 
 &usb_1_dwc3 {
 	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	usb_hub_2_0: hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_3_0>;
+	};
+
+	/* 3.0 hub on port 2 */
+	usb_hub_3_0: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_2_0>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.34.1.575.g55b058a8bb-goog

