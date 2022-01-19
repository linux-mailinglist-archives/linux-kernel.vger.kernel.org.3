Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13DC49420D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357420AbiASUor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357406AbiASUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:44:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D97C061748
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:44:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n16-20020a17090a091000b001b46196d572so3727821pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ5lLLdSCeNvt2ZI1+v6LXdLP5izzC+/ppZtPbMuaA4=;
        b=KJsVAkJVn8mblr6TPMU3BOXA4T+7aZr39DS6lCyx8RF3S+HhylJtXcMcid2oGCfJ5K
         xM9xaUr9ZWW2Hs8a6ypHfBYZuiWoHTa1SZbEKijYdafaWkgrc4N04+SGGvUR6bNNhbBO
         ng0wD4dKX2tEm0t8QEcL7yUnETpDCGqiaQj/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ5lLLdSCeNvt2ZI1+v6LXdLP5izzC+/ppZtPbMuaA4=;
        b=JvnaZMSEh1F1EegGuhcoSngqQPq4rXWRkgyVE0dc3FUAWfveykWPTcfoFUoEQg9Ii8
         Jho8KZ9I6mUV4vhfqQGu/aZIZeovRakAG+BQCdoMlUJAfY41b2a6JXXj7xKkZMe0K5q7
         VwdxCYkAwrSYjAXN9wUvznYLuS3CIAJquiTOdv3pwuqclYnDosJ7jitW7KYgZUxFs/nV
         zB0bd+ZGFfOJLuwRDYxbMoGuFSNdEoZuEG+porbqfdhuY0eksw42WRP2/S5c+QS2BiRA
         niUnzIIa8x3M6B7SE+zYxAObuD/9UWM3kGYNf2jvm9aZLTRVSW5ZfJgsnZhB60aOAoJk
         dcsA==
X-Gm-Message-State: AOAM531OIH0EyEuJokiteVJnycXXCgNlASFIyLo/HRXTfhUBs2nCMHw7
        r9MogTSnVFl5mAlfZdGrnfoZhQ==
X-Google-Smtp-Source: ABdhPJwWK14isWM3EDWa4Tamw/urSWdvnGdT3e9EN1ZzbjaY8+j0Gom4jp2zN/ek+vUhhmoPCBs69A==
X-Received: by 2002:a17:902:f54a:b0:14a:6827:8d01 with SMTP id h10-20020a170902f54a00b0014a68278d01mr34880338plf.127.1642625046836;
        Wed, 19 Jan 2022 12:44:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:618e:efc:c014:d89c])
        by smtp.gmail.com with UTF8SMTPSA id k17sm566753pff.25.2022.01.19.12.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:44:06 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v20 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Wed, 19 Jan 2022 12:43:45 -0800
Message-Id: <20220119124327.v20.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220119204345.3769662-1-mka@chromium.org>
References: <20220119204345.3769662-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on trogdor devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

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
index 30e3e769d2b4..b69590a17cab 100644
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
+&usb_hub_2_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_x {
+	 vdd-supply = <&pp3300_l7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..25f178c3c6eb 100644
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
index d4f4441179fc..be06938872ca 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -202,7 +202,7 @@ pp3300_hub: pp3300-hub {
 		pinctrl-names = "default";
 		pinctrl-0 = <&en_pp3300_hub>;
 
-		regulator-always-on;
+		/* The BIOS leaves this regulator on */
 		regulator-boot-on;
 
 		vin-supply = <&pp3300_a>;
@@ -839,6 +839,24 @@ &usb_1 {
 
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
2.34.1.703.g22d0c6ccf7-goog

