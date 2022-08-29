Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2F5A415E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiH2DLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH2DKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:10:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD62DCD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:09:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f24so3952159plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=35Qd9VRWXPPxUBrhblQ8KKqpUK/ZHYxJcwsXA+qA9m0=;
        b=Uj87TtnC5MVILg/aKquGIhNzuBnStYJleWx4noJnuMtzNA0dUX4cJ+UERpWn+wlZlP
         kCluYnpeC5i6NllJHP64thB0y0wYr4C3eHuqeSjA7azvslCRSakhHXcZ8ox3KhEfuo49
         1UNSeP0fV9Lm9YFRxiiMy7g93zBlrZ1Xme4AdYXuj1diBxZzMhq03e46oWjucxVLIrgc
         uhWhN0aufCWgKOU2iYLajPRORriUjBodz74G2ed/MGP2f3b2mXsDUMOOMcL98bZ6QYhk
         8qpsJwFq2p9FoVrnNJD8E9eGzaA/IvzOUsLCO4s4W+V+0Brq7yqpJIcli+mAd5Xxvoyl
         vj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=35Qd9VRWXPPxUBrhblQ8KKqpUK/ZHYxJcwsXA+qA9m0=;
        b=1z5M7vetC6splDiS2tP+X3PSskOqcDRH2m8EUm30TFOpXt3SSnuV1VR41/C/O+2X9e
         hnAQg4CTELLgppuqqHVlBct1eGwrw8WqLEu9j+lwOCHHcR6Q600rN2FTHodzeI2fxxuk
         bxxC/C9U1RFkzR6z/NtfPuAz03WJiwhRVtG4BHTqK0WCENXdyrJBM1lTwvaZU/xRdMwo
         GSx9lI5dM9dBZg/M40pfOODDxpq5ciEQSi2yIJ+QBo6CZQFy/vGYHV9emnV+JWjWFueS
         lgXowwdiYj2xXdO8Q5aBeugtFZF1NCugisIlOmuUYF+myf0H7oR2VSICriys+HWMQ11A
         reow==
X-Gm-Message-State: ACgBeo0tDNvWodNuAWA/hQUOknhA5mKNfurQFeQTHZiminpPXWj5R+P9
        ZlHmXeaqRG75Fe23d55XZlrNBH+bPcKd5yLW
X-Google-Smtp-Source: AA6agR6PCCwDsvidM+JjIbP9ty7M1HY13yvCy9z8yXVghFKWX0scnuke/jyWRmzba43LQPrGJpwWQg==
X-Received: by 2002:a17:903:2349:b0:174:cef1:69ad with SMTP id c9-20020a170903234900b00174cef169admr2371757plh.138.1661742593953;
        Sun, 28 Aug 2022 20:09:53 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id 18-20020a621412000000b0053725e331a1sm5934991pfu.82.2022.08.28.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:09:53 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add sc7180-pazquel360
Date:   Mon, 29 Aug 2022 03:09:30 +0000
Message-Id: <20220829030823.v2.2.I99d43de4a80223dee58ea1bc5b4fd3aaadc5e3c1@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829030823.v2.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
References: <20220829030823.v2.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create first version device tree for pazquel360
pazquel360 is convertible and the pazquel it is based on is clamshell.
sku 20 for lte & wifi
sku 21 for wifi only
sku 22 for lte w/o esim & wifi

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
---

Changes in v2:
- Remove the touchscreen setting, as a follow-up patch

 arch/arm64/boot/dts/qcom/Makefile             |  2 +
 .../qcom/sc7180-trogdor-pazquel360-lte.dts    | 22 ++++++++
 .../qcom/sc7180-trogdor-pazquel360-wifi.dts   | 17 +++++++
 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 50 +++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528..9f736702e06f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -84,6 +84,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-wifi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
new file mode 100644
index 000000000000..021bcafcf815
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel360.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,LTE)";
+	compatible = "google,pazquel-sku22", "google,pazquel-sku20", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
new file mode 100644
index 000000000000..defd84c5354a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel360.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,WIFI-only)";
+	compatible = "google,pazquel-sku21", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
new file mode 100644
index 000000000000..5702325d0c7b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/* This file must be included after sc7180-trogdor.dtsi */
+#include "sc7180-trogdor-pazquel.dtsi"
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+		MATRIX_KEY(0x03, 0x09, 0)       /* T11 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		MATRIX_KEY(0x03, 0x09, KEY_SLEEP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
-- 
2.17.1

