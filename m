Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6233480B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhL1QnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:43:21 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39672
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhL1QnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:43:17 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C793402FB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709796;
        bh=LWpKLoE0BQYAlN39yeK9QxixT3GtLXrh/TOWUi443sk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UD10wK1l3fra7k2cRA4axQyRx3re7NECH5jbylFxBuwi2GPChUwJ8JArKF/S3/DAz
         20iJK42Qfx5KzKRN1HoLspdqGipqnrE9j2Tv5zk/D70gXjE+8DHETcjWFzeHHGQHzF
         aoSCQbJc94wGtKlg0oHlEKUh+lqmMPA9pS/9UkSP4vI4xkGHo5Oj0MxvFL9CBLF/lG
         /VcO463VK3Au+LITw7RUQeX5tgxxh86hzd9VnPT9gGr5F+lLo4UNxLJ2/S9H2/u/fS
         UOmXq2yGgstIjT29Z6oLeKnF8wVnXv4tZp91njUYNbiRaOECXodynEapW3fyJJOtk2
         nY6KUSkKMJXCQ==
Received: by mail-lj1-f200.google.com with SMTP id bd7-20020a05651c168700b0022d71e1839bso6214966ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWpKLoE0BQYAlN39yeK9QxixT3GtLXrh/TOWUi443sk=;
        b=IR9Y+VfhZWvdw811Jk5Hn3KZgj4HOyd31oHEdUHvakm7ZNTyfQ8zdy5onk8uoFLyBT
         Bf6EjzFdp4iLQHxu096KdPlRq8Fs275v7qIoXLdoGLicTpMifHrsTp3IgU1T0bFnBs5q
         v47+h7ZV/xD4Pt1BH26SDTnJF/3IbukiAyEx1mm8aSNoHP5Npqyml0Z4p2o4LCQ9tJre
         HvW0ox4B104D81fX8W5J4QCgdcXmYebi+ViWs8aQuFQOSVheSwBoh2cOHDwf3Cz83vPR
         CMsHWMf0tcU/NagfeS9cLDUqVnhlc9jqHx2BjT6WZE7EvqvthKs+8aRSEPbIsiIbDwG9
         z0VA==
X-Gm-Message-State: AOAM531M1NHEP2p48wBXegrcA86y746Qh195km+FxN6U+JbJ/grUWdKZ
        BohyCTKOtkEg/BVPpLXyqzKKjn0zpQFT0OS01dKNQ0wDbTF/Ds/CTLJZg5ssoEFNuefAVg2exon
        SiV1rAC7Ejwu+5zBMqQ6HAOFWa0iphVQQVU6aHvq/VA==
X-Received: by 2002:a19:dc57:: with SMTP id f23mr19029408lfj.245.1640709795545;
        Tue, 28 Dec 2021 08:43:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqseq4Sp84ozRpaHHxcVhWgWfB1NTN6A3uTXObXh7HWRmTjja6ZjpvU7bvJhugOhfxG2UJVg==
X-Received: by 2002:a19:dc57:: with SMTP id f23mr19029393lfj.245.1640709795305;
        Tue, 28 Dec 2021 08:43:15 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u5sm968701lja.36.2021.12.28.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:43:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: mfd: maxim,max77802: Convert to dtschema
Date:   Tue, 28 Dec 2021 17:43:05 +0100
Message-Id: <20211228164305.35877-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
References: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Maxim MAX77802 PMIC to DT schema format.  The
example DTS was copied from existing DTS (exynos5800-peach-pi.dts), so
keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/mfd/max77802.txt      |  25 ---
 .../bindings/mfd/maxim,max77802.yaml          | 194 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 195 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max77802.txt b/Documentation/devicetree/bindings/mfd/max77802.txt
deleted file mode 100644
index 09decac20d91..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77802.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Maxim MAX77802 multi-function device
-
-The Maxim MAX77802 is a Power Management IC (PMIC) that contains 10 high
-efficiency Buck regulators, 32 Low-DropOut (LDO) regulators used to power
-up application processors and peripherals, a 2-channel 32kHz clock outputs,
-a Real-Time-Clock (RTC) and a I2C interface to program the individual
-regulators, clocks outputs and the RTC.
-
-Bindings for the built-in 32k clock generator block and
-regulators are defined in ../clk/maxim,max77802.txt and
-../regulator/max77802.txt respectively.
-
-Required properties:
-- compatible		: Must be "maxim,max77802"
-- reg			: Specifies the I2C slave address of PMIC block.
-- interrupts		: I2C device IRQ line connected to the main SoC.
-
-Example:
-
-	max77802: pmic@9 {
-		compatible = "maxim,max77802";
-		interrupt-parent = <&intc>;
-		interrupts = <26 IRQ_TYPE_NONE>;
-		reg = <0x09>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
new file mode 100644
index 000000000000..26f49fbace18
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
@@ -0,0 +1,194 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77802 Power Management IC
+
+maintainers:
+  - Javier Martinez Canillas <javier@dowhile0.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77802 Power Management
+  Integrated Circuit (PMIC).
+
+  The Maxim MAX77802 is a Power Management IC which includes voltage and
+  current regulators (10 high efficiency Buck regulators and 32 Low-DropOut
+  (LDO)), RTC and clock outputs.
+
+  The MAX77802 provides two 32.768khz clock outputs that can be controlled
+  (gated/ungated) over I2C.  The clock IDs are defined as preprocessor macros
+  in dt-bindings/clock/maxim,max77802.h.
+
+properties:
+  compatible:
+    const: maxim,max77802
+
+  '#clock-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/maxim,max77802.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  inb1-supply:
+    description: Power supply for buck1
+  inb2-supply:
+    description: Power supply for buck2
+  inb3-supply:
+    description: Power supply for buck3
+  inb4-supply:
+    description: Power supply for buck4
+  inb5-supply:
+    description: Power supply for buck5
+  inb6-supply:
+    description: Power supply for buck6
+  inb7-supply:
+    description: Power supply for buck7
+  inb8-supply:
+    description: Power supply for buck8
+  inb9-supply:
+    description: Power supply for buck9
+  inb10-supply:
+    description: Power supply for buck10
+
+  inl1-supply:
+    description: Power supply for LDO8, LDO15
+  inl2-supply:
+    description: Power supply for LDO17, LDO27, LDO30, LDO35
+  inl3-supply:
+    description: Power supply for LDO3, LDO5, LDO7, LDO7
+  inl4-supply:
+    description: Power supply for LDO10, LDO11, LDO13, LDO14
+  inl5-supply:
+    description: Power supply for LDO9, LDO19
+  inl6-supply:
+    description: Power supply for LDO4, LDO21, LDO24, LDO33
+  inl7-supply:
+    description: Power supply for LDO18, LDO20, LDO28, LDO29
+  inl9-supply:
+    description: Power supply for LDO12, LDO23, LDO25, LDO26, LDO32, LDO34
+  inl10-supply:
+    description: Power supply for LDO1, LDO2
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/maxim,max77802.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@9 {
+            compatible = "maxim,max77802";
+            interrupt-parent = <&gpx3>;
+            interrupts = <1 IRQ_TYPE_NONE>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&max77802_irq>, <&pmic_selb>,
+                        <&pmic_dvs_1>, <&pmic_dvs_2>, <&pmic_dvs_3>;
+            wakeup-source;
+            reg = <0x9>;
+            #clock-cells = <1>;
+
+            inb1-supply = <&tps65090_dcdc2>;
+            inb2-supply = <&tps65090_dcdc1>;
+            inb3-supply = <&tps65090_dcdc2>;
+            inb4-supply = <&tps65090_dcdc2>;
+            inb5-supply = <&tps65090_dcdc1>;
+            inb6-supply = <&tps65090_dcdc2>;
+            inb7-supply = <&tps65090_dcdc1>;
+            inb8-supply = <&tps65090_dcdc1>;
+            inb9-supply = <&tps65090_dcdc1>;
+            inb10-supply = <&tps65090_dcdc1>;
+
+            inl1-supply = <&buck5_reg>;
+            inl2-supply = <&buck7_reg>;
+            inl3-supply = <&buck9_reg>;
+            inl4-supply = <&buck9_reg>;
+            inl5-supply = <&buck9_reg>;
+            inl6-supply = <&tps65090_dcdc2>;
+            inl7-supply = <&buck9_reg>;
+            inl9-supply = <&tps65090_dcdc2>;
+            inl10-supply = <&buck7_reg>;
+
+            regulators {
+                BUCK1 {
+                    regulator-name = "vdd_mif";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-ramp-delay = <12500>;
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                BUCK2 {
+                    regulator-name = "vdd_arm";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1500000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-ramp-delay = <12500>;
+                    regulator-coupled-with = <&buck3_reg>;
+                    regulator-coupled-max-spread = <300000>;
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                // ...
+
+                BUCK10 {
+                    regulator-name = "vdd_1v8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                LDO1 {
+                    regulator-name = "vdd_1v0";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+                    regulator-initial-mode = <MAX77802_OPMODE_NORMAL>;
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-mode = <MAX77802_OPMODE_LP>;
+                    };
+                };
+
+                // ...
+
+                LDO35 {
+                    regulator-name = "ldo_35";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea5655a29c3..b5e4f14f6768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11666,7 +11666,7 @@ MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/*/*max77802.txt
+F:	Documentation/devicetree/bindings/*/*max77802.yaml
 F:	drivers/regulator/max77802-regulator.c
 F:	include/dt-bindings/*/*max77802.h
 
-- 
2.32.0

