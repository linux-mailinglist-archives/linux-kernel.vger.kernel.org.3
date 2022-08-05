Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13B58AAB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiHEMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiHEMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751379692
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so3109912edj.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=ZBrNwp1gHFl2Xae1KzJGBgqN04yJKsQPmkG6lAXyXkY=;
        b=7DatlSWT+HmPu8MMLiYslByU/UARQySrMTQMYq440e9VxeucyNDW+kWVXbUBWotSoD
         HgQng3XVWyf3yI2E8Ks+lnep8ra6P3P3xDCjR24m/ogrN9fv+0ywIcy7pcLf8prD7xEK
         r7L3MyeUw0k1CsbqI3rui93VMVocVbz4MN9oOybZ/gGK4ivAc6BCwVR6cZ5IViiAfomr
         Flg8htISrnwlWjX5u8MwYpGmdKz2Y1rJ+J8RjWighMXLKpTqlnOZM6tXaKsfZbIM3vPt
         o6L6NH9e0KhwCO2IzF2lS8V8Tfa7sYCWSpny7S32hpoJGLxFf2G4hq/J4Jj8WNDBej6R
         J3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ZBrNwp1gHFl2Xae1KzJGBgqN04yJKsQPmkG6lAXyXkY=;
        b=AQW8/e8p81tqX8UgbiU7wn9j2+c7FrQRT8nfVtFG3kDewIkMSzojTc957iryBSm5fU
         pb7sn6gDVc/GLSa68Qac6Xk8ITN1FJ3NTTGTzh2uukEXvJ8i0rmsCwqDaYFVri67tdQB
         zudFIm0ZRoRvBwyMF8XGsoyExwGoC27uDYa+hAQJu9obnUkzJu34yxB7jGxz0ZnWJ/Vb
         W+/yigbsFq8vf86XW57keFGGacA7hpj83q0Cj8vmNuLE8Qgnk9J5x370IMO3uaB2TASu
         Z5D2lMbctOx0H+Vt+Lc/Us71sqds2+Oy9N/TK1/y/VTFHAZQUGK53/x27LrQfhwnm7Fn
         XhZw==
X-Gm-Message-State: ACgBeo1JCnBw+2gT6SOuZhdXVNrsHONfRsNmNo5QpJu/HdEo+vRTiI+/
        ppkY+40hdhD3Rsjaq0nquxI5OQ==
X-Google-Smtp-Source: AA6agR7Sb1gOaYyoNGw0c+ZBGHTMvLfFZfSSPLavuwmyGPimjQmVaWCcBi0sWNaqTcOwTNlJSnyc5A==
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id t10-20020a056402240a00b00437d2b63ddemr6371256eda.62.1659701954806;
        Fri, 05 Aug 2022 05:19:14 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:14 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 04/10] regulator: dt-bindings: Add TI TPS65219 PMIC bindings
Date:   Fri,  5 Aug 2022 14:18:46 +0200
Message-Id: <20220805121852.21254-5-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TPS65219 PMIC bindings using json-schema.

Describe required properties and regname-supply.
regname-supply is required when bypass mode is used for a regulator.
Describes regulator topology.
Interrupts support.
Add a power-button property to configure the EN/PB/VSENSE pin as a
powerbutton:

TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either:
- EN in which case it functions as an enable pin.
- VSENSE which compares the voltages and triggers an automatic
on/off request.
- PB in which case it can be configured to trigger an interrupt
to the SoC.
ti,power-button reflects the last one of those options
where the board has a button wired to the pin and triggers
an interrupt on pressing it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 .../bindings/regulator/ti,tps65219.yaml       | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
new file mode 100644
index 000000000000..78be79930fda
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps65219.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI tps65219 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Jerome Neanne <jerome.neanne@baylibre.com>
+
+description: |
+  Regulator nodes should be named to buck<number> and ldo<number>.
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65219
+
+  reg:
+    maxItems: 1
+
+  system-power-controller:
+    type: boolean
+    description: Optional property that indicates that this device is
+      controlling system power.
+
+  interrupts:
+    description: Short-circuit, over-current, under-voltage for regulators, PB interrupts.
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description: Specifies the PIN numbers and Flags, as defined in
+      include/dt-bindings/interrupt-controller/irq.h
+    const: 1
+
+  ti,power-button:
+    type: boolean
+    description: |
+      Optional property that sets the EN/PB/VSENSE pin to be a
+      power-button.
+      TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either
+      1. EN in which case it functions as an enable pin.
+      2. VSENSE which compares the voltages and triggers an automatic
+      on/off request.
+      3. PB in which case it can be configured to trigger an interrupt
+      to the SoC.
+      ti,power-button reflects the last one of those options
+      where the board has a button wired to the pin and triggers
+      an interrupt on pressing it.
+
+patternProperties:
+  "^buck[1-3]-supply$":
+    description: Input supply phandle of one regulator.
+
+  "^ldo[1-4]-supply$":
+    description: Input supply phandle of one regulator.
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+
+        unevaluatedProperties: false
+
+      "^buck[1-3]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tps65219: pmic@30 {
+            compatible = "ti,tps65219";
+            reg = <0x30>;
+            buck1-supply = <&vcc_3v3_sys>;
+            buck2-supply = <&vcc_3v3_sys>;
+            buck3-supply = <&vcc_3v3_sys>;
+            ldo1-supply = <&vcc_3v3_sys>;
+            ldo2-supply = <&buck2_reg>;
+            ldo3-supply = <&vcc_3v3_sys>;
+            ldo4-supply = <&vcc_3v3_sys>;
+
+            pinctrl-0 = <&pmic_irq_pins_default>;
+
+            interrupt-parent = <&gic500>;
+            interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+            ti,power-button;
+
+            regulators {
+                buck1_reg: buck1 {
+                    regulator-name = "VDD_CORE";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <750000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                buck2_reg: buck2 {
+                    regulator-name = "VCC1V8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                buck3_reg: buck3 {
+                    regulator-name = "VDD_LPDDR4";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo1_reg: ldo1 {
+                    regulator-name = "VDDSHV_SD_IO_PMIC";
+                    regulator-min-microvolt = <33000000>;
+                    regulator-max-microvolt = <33000000>;
+                };
+
+                ldo2_reg: ldo2 {
+                    regulator-name = "VDDAR_CORE";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <850000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo3_reg: ldo3 {
+                    regulator-name = "VDDA_1V8";
+                    regulator-min-microvolt = <18000000>;
+                    regulator-max-microvolt = <18000000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo4_reg: ldo4 {
+                    regulator-name = "VDD_PHY_2V5";
+                    regulator-min-microvolt = <25000000>;
+                    regulator-max-microvolt = <25000000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.17.1

