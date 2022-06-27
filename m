Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783E55E05E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiF0V2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiF0V2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:28:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92EB6D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:28:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso10990942pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IC7TunaQ/xxlxC2LBpizkSNCL0cDYUe5ayoNlSMPh6E=;
        b=H6XDobC1AiHh5J73dkLHzYIrrrCEJPdnn+FCW18IWWlGQmJmPx3b2yljz1ZTQLuE59
         iOCr1l4OfOr3x+yacL6AB7ZO5mSOAilV/DoaFy1QU/Yk6KWtckZ4Z+BCBW0O0GEx1y78
         Xd2GPzmjtzlHIO+Jy7ukvbsz/ugWG5Vv3wXnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IC7TunaQ/xxlxC2LBpizkSNCL0cDYUe5ayoNlSMPh6E=;
        b=c1WdJhKbo4L8GFja9F3AuOBPTcQkqhwAcr2GhIGOkY3FDgYwlxUOYHNmP2y3diXJIe
         2qCkesgnjkZxMLGD2aWw46q4kmYtwgaouJSoKr0ACcJvsm5fuzZmfDSKrYnzxE+1qvOy
         XxMknRxfUzHrtUkp4UyePkthTgyW9aUV8vF9dXsZ6DFuSBKr+XbBgHBrlPnZKpqS7anE
         OBqGaAY4Jq0mWvUVlBhWlNzc6whgAtAUCh3HCjhwOIIpiiFr2JAKviJDqQx2lS1g7FYL
         g+2aKRsz1s9xdovLPCJ3mpDq5YAm1pnb5sxOsyTWyS8PfA4mmDm77GgOFgsUoENEySK4
         GXUQ==
X-Gm-Message-State: AJIora95IWz+Ys/8JDs0uFcIKojxAl9f8gjp2TJT23wk8yWXzpLaWOHX
        nHgNVTotcGY8vW8IJiarhLUbsA==
X-Google-Smtp-Source: AGRyM1sUMT65y3/uEMYvOOKKzBXu6sJiMW2ElwpPPzeIBzgnozkorDsAtlO3/aPoKTYb1MkHVnasRg==
X-Received: by 2002:a17:903:291:b0:168:c6b3:1976 with SMTP id j17-20020a170903029100b00168c6b31976mr148767plr.9.1656365284800;
        Mon, 27 Jun 2022 14:28:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:102:e83c:44ae:47db])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709029a9400b0015e8d4eb231sm7697115plp.123.2022.06.27.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:28:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Split out keyboard node and describe detachables
Date:   Mon, 27 Jun 2022 14:28:02 -0700
Message-Id: <20220627212802.3593012-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor devices that have a detachable keyboard still have a
non-detachable keyboard input device present because we include the
cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
that every variant board includes. We do this because the
keyboard-controller node also provides some buttons like the power
button and volume buttons. Unfortunately, this means we register a
keyboard input device that doesn't do anything on boards with a
detachable keyboard.

Change the node's compatible on detachables to the newly introduced
"google,cros-ec-keyb-switches" compatible to indicate that there are
only switches and no keyboard to register. Similarly, move the keyboard
include that defines the keyboard-controller node out of
sc7180-trogdor.dtsi to boards that actually have a keyboard so that the
matrix properties are not defined on boards with the switches
compatible. Future boards can either use the include approach or the
node definition approach to describe a keyboard with possible switches
or just some switches.

Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org):
 * Rebased onto Joe's series applied on top of qcom's arm64-fixes-for-4.19
 * Updated more dtsi files

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi        | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi      | 6 ++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi    | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi         | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi       | 6 ++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi       | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi        | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts             | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi               | 1 -
 11 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 8ac1f1e61006..7ee407f7b6bb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -81,6 +81,10 @@ &camcc {
 };
 
 &cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+
 	cros_ec_proximity: proximity {
 		compatible = "google,cros-ec-mkbp-proximity";
 		label = "proximity-wifi";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index d1e2df5164ea..1bd6c7dcd9e9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -114,6 +114,12 @@ &camcc {
 	status = "okay";
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &panel {
 	compatible = "samsung,atna33xc20";
 	enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
index a19406cd29a5..74f0e07ea5cf 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -6,7 +6,7 @@
  */
 
 /* This file must be included after sc7180-trogdor.dtsi */
-
+#include <arm/cros-ec-keyboard.dtsi>
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 &alc5682 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 88f6a7d4d020..2cf7d5212c61 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -6,6 +6,7 @@
  */
 
 /* This file must be included after sc7180-trogdor.dtsi */
+#include <arm/cros-ec-keyboard.dtsi>
 
 &ap_sar_sensor {
 	semtech,cs0-ground;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
index 33d1d8a29038..97cba7f8064f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
@@ -58,6 +58,12 @@ &camcc {
 	status = "okay";
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &dsi0 {
 
 	panel: panel@0 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index 2d13b94e9313..56d787785fd5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -6,6 +6,7 @@
  */
 
 /* This file must be included after sc7180-trogdor.dtsi */
+#include <arm/cros-ec-keyboard.dtsi>
 
 &ap_sar_sensor {
 	compatible = "semtech,sx9324";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 3df4920295ad..a7582fb547ee 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -6,6 +6,8 @@
  */
 
 #include "sc7180-trogdor.dtsi"
+/* Must come after sc7180-trogdor.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 574b78eb4f28..695b04fe7221 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -46,6 +46,12 @@ &camcc {
 	status = "okay";
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &dsi0 {
 	panel: panel@0 {
 		/* Compatible will be filled in per-board */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 352827e5740a..59a23d0e9651 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -8,6 +8,8 @@
 /dts-v1/;
 
 #include "sc7180-trogdor.dtsi"
+/* Must come after sc7180-trogdor.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 701dd11a12cf..6312108e8b3e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -104,6 +104,10 @@ &cros_ec {
 	base_detection: cbas {
 		compatible = "google,cros-cbas";
 	};
+
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
 };
 
 &dsi0 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index e55dbaa6dc12..1a4f2e8cc3dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -903,7 +903,6 @@ cros_ec_fp: ec@0 {
 	};
 };
 
-#include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
 
 &uart3 {

base-commit: d640974d1c4ee510fcc8f05f0ddaaf9d17b47643
prerequisite-patch-id: e4e5e59ecf0e67976cbf6e54a85e5ba2018dc0ff
prerequisite-patch-id: dc0ebbff0f2ed6c8674bdebef127d7f10b7dacbf
prerequisite-patch-id: 41a558fdc22515e78b2caeb3630ecd075072eb74
prerequisite-patch-id: 90167e33f0cd4d8aa92cb6221964779de53d8cf4
prerequisite-patch-id: b7cfa974f20a01ba2121cbe61dc1c9ac70ec8442
-- 
https://chromeos.dev

