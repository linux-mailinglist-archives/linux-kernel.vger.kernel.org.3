Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752354FCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383478AbiFQSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383210AbiFQSMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:12:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B031DD5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:12:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m14so4520531plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fai5+SrDv8K91PMU2NEm06Sjrm/fhwQHbj0YNEiaVYQ=;
        b=hCna7bgzcv4fbNXHMcqfQrvXCWIhrqAOgcDq+K+UUKNxK4iLl8JzZfTfV6qTOMU4Cb
         BxvJAcofOG5MaQwMTgSpbhAtSyncLVo6UGsy+2EOAuP3SeYxOHA0Whg6Ir1XEq5ymSaZ
         WDfUmmLJ/MzucgIfa8dzg6se0SVLy9lU551Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fai5+SrDv8K91PMU2NEm06Sjrm/fhwQHbj0YNEiaVYQ=;
        b=wZuEL3yhN7D3PqtJcVeTvY3GDYKXBzxrJJ0V8Nosfh2/m42WwJmMhJ4KP0hRo7IODF
         ybyJ3Bu0EE+ZLETjqMN90/fezKB+mFifjoUtZVYdAVnvq0VsgSjH3QBAhklfP5AK7020
         acL2K665eI9QnLa5Jft3uzBrZm4831BcWRxlLVOKR5g3PqH//k37EmtunTqQSlUueQVn
         bQKuj8cuEVDDjlayA/mPNcPGBrcUu43rDn2EZ3nhgt3QM/rlddwkheEvVINNURy9eXL8
         kk4EH2/6JF6qiVFRU6aM/nOrmJ48ajFSgRIzqGeIptd2A5OvcUi78Rhy3fUXYC5TtbVt
         eCXQ==
X-Gm-Message-State: AJIora9lHg0yYW+0vP60QHgZzMk/l8CRfRFVl53eACj2DBwrrpuMGV0T
        57dcN7u4HCUAsrk84QT5rmrcWhDsTU1VxA==
X-Google-Smtp-Source: AGRyM1s0q12/vUtyutTPiMf/K6XDCQF+wn5/uhEPgl9PGs2o9xobRY8V1AOXdG/DaG73S2WsmnjFAA==
X-Received: by 2002:a17:90b:4d11:b0:1e8:436b:a9cc with SMTP id mw17-20020a17090b4d1100b001e8436ba9ccmr23042365pjb.40.1655489522568;
        Fri, 17 Jun 2022 11:12:02 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id o1-20020a62f901000000b0052285857864sm4121930pfh.97.2022.06.17.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 11:12:02 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/6] FROMLIST: arm64: dts: qcom: sc7180-trogdor: Split out keyboard node and describe detachables
Date:   Fri, 17 Jun 2022 11:10:36 -0700
Message-Id: <20220617111021.v6.1.I9e299d3fa6fbf50df6fc7207050bf5c3a7bf4c61@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

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
(am from https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org)

     evtest shows no more cros_ec device

Cq-Depend: chromium:3609017
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

Changes in v6:
 - First inclusion of this patch.

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi   | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts        | 2 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 1 -
 6 files changed, 16 insertions(+), 1 deletion(-)

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
index 9b3e3d13c165..5074014d5269 100644
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index fe2369c29aad..d8839ccdcf09 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -6,6 +6,8 @@
  */
 
 #include "sc7180-trogdor.dtsi"
+/* Must come after sc7180-trogdor.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
 
 &ap_sar_sensor {
 	semtech,cs0-ground;
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
-- 
2.31.0

