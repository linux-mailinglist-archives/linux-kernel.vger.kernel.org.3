Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEF5A7B95
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiHaKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiHaKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:43:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5698FC990C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:43:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c2so13754699plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=rpg8qFuHMz9trXb2l6JJc6TcfgnEOiyqRxW6isBGGfo=;
        b=qnI132CjIp9ycTs28mvrwj3Bvqv1tYeaXCXnlTKwnUCwM5ux+dj0dL8VlohJNHCmGD
         4nNYy5tA60bBSVtQfxaGMwPcNwYZ6RLzsQoSEcfQnIijdg+N3Qnpv+NDHNFkfU75Qed3
         IKZYfiZrkCnOgvFUv+1+k2CeMGc3An9vV4P4jGBIb6RtcL482Liex2dPnSNU9TFvEegR
         ZL8LPKxaKnG26irfJLx8pT38QTkEdrz00j5a1ksGmhT2l+HZ98uE2RsjyJvT0AS6RVfd
         88qN6CX0TEKwIYpEyyWs//qFHBfXo7QT8tVVvluzBWkT+SjI073ClbUOBNOOQeWXNfcj
         rE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=rpg8qFuHMz9trXb2l6JJc6TcfgnEOiyqRxW6isBGGfo=;
        b=C6/CFFYjCQq/krSCiiKQFEfM3cmAXdOVlgGXzaU2SZ5RxcBlCfJczBYcTvdhh/0RJ9
         ZamrX6qPLxAB+LpHt6CvX3MQV5astTkh6K8i+znH443tpzqYpeJ3kPt6dk0+nIs9P/5V
         LtdJMwGWics1iSsJ4+V2VrR5AvpgkMwQsfxfXNwlHFbX1cB9eiYBtnYa9/z5sBITKnHh
         G5R8zjsJEw/mOZoE1zC84lrG8n/lXfJ1M0/Cna9XnOa4AC6Gs8VxnShh3NSj4uMNnnHT
         DQYDNWQn+GlMzOUEJF2OpnM9hOEGm6cVTncOGcCB0C5nbtTwwsBUc5SReYdISPGIEOLJ
         dROQ==
X-Gm-Message-State: ACgBeo2KNqmjFhQWw4A2mNsvPWH2HKYpJClC9NwIelNxj3DR6yuV9fmD
        2Oo5YGBCLDXei/hFR/duhV/HWWE2P00okQTl
X-Google-Smtp-Source: AA6agR59Jajv3otVproOhXY/tkq6dAl7VX9bjryV+m6GY9tKTE7SU5v1jUrNotEfFdXtGfj+F3lrFg==
X-Received: by 2002:a17:902:d50b:b0:172:d4f4:91aa with SMTP id b11-20020a170902d50b00b00172d4f491aamr26108605plg.53.1661942612348;
        Wed, 31 Aug 2022 03:43:32 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b0016be596c8afsm11266905plk.282.2022.08.31.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:43:31 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add sc7180-pazquel360
Date:   Wed, 31 Aug 2022 10:43:18 +0000
Message-Id: <20220831104220.v2.2.I9d00dd1cd4fd33948829a618c04403a6352c1fc0@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220831104220.v2.1.I11899dbd0476ffc83aaca07f8ca9b204ecd9a84c@changeid>
References: <20220831104220.v2.1.I11899dbd0476ffc83aaca07f8ca9b204ecd9a84c@changeid>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v2:
1. Remove the touchscreen setting, as a follow-up patch

---
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

