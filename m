Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5185A6193
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiH3LVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiH3LVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:21:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A56ADCC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:21:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so8866708pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=ceOSXODTV0UEQ0old0AVSNd3nMc530Sckae9kNqwPFs=;
        b=vjyh43erqz87yzTjjYh7mACkPwH/re2HPP/kHyvqDh0plrqVDqvEw7ZxyBDuC1M0Jq
         h/x0ZZu9KfFtUE8AVDlnPMx66NWxVwsDh/O0AX2nORRW687pD069DHAP94Ga8FdgW3zn
         658GdygENnIKFeQWPKFCkExenGhk/IielfWo++ALW71wJdyky0eeaYryhJmMid2DEe4H
         HJasWo0KZMujw5tiqnYK+P1qVNnee5CClPDQkoJQlXyMHEn0MUskFlQWZyh7DZ4a2f+K
         bkznlipC6WD0pKTT4SzkSgX+uz20Q974ZTWbfitAHZ8T9p573Olsp36uR6WOyPgjKUVz
         fumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ceOSXODTV0UEQ0old0AVSNd3nMc530Sckae9kNqwPFs=;
        b=sQ/dApm/bi4OVSE+eG9CliDeBgL4QkfKhMQMMh2WJGvJv+C6PZ4Zd10hFj6zZxC4oo
         HbOTfSeIbd3caxHsC7yw+ovkz861Jg9U7LzyZBrB/Ub/j4xEPeYKNHLS/FlU+VlEONSL
         VFUKl+8RXWO9k7xLyqFHrnRiLQ7Q7yViKR9tvIeESo+r0g+9R1w8yNXvzuWNix2TUmF3
         4eccjl20tVZzNhI6RGAfdvAXm+t0d0sV1Mu88ZEUPV76dkG1zGE/Ng+kYDSzchiSI7m+
         /U59XFGBRrK6AbPgBX+0hSYg2G3phZycBZHnlp6awWqbI8B5JnnsgfWD98zkfcBw6WKr
         Br+A==
X-Gm-Message-State: ACgBeo2cCbOnwQU91R8YNeshw/ebdlTgpojQgRlGxNDYdPoNyG/8YB2t
        XdMRMkD5QX+kEokyYVr9176zbjdGk+BL7YRM
X-Google-Smtp-Source: AA6agR7CSBq7DSblhR/GS+uVwHPi0ho8zoo4FMm//2vK27lQQ4evjq4rfedgPqMktVyj85dcfYr2Aw==
X-Received: by 2002:a17:90b:1d0b:b0:1f5:6554:d556 with SMTP id on11-20020a17090b1d0b00b001f56554d556mr23420217pjb.168.1661858498158;
        Tue, 30 Aug 2022 04:21:38 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id q41-20020a17090a17ac00b001f54fa41242sm8310957pja.42.2022.08.30.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:21:37 -0700 (PDT)
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
Date:   Tue, 30 Aug 2022 11:21:08 +0000
Message-Id: <20220830112013.v2.2.I5bd646de8fac81eb23c8bcf1cbe21125bf9638f3@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
References: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
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

