Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E655464E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiFVKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiFVKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:01:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1B3A18D;
        Wed, 22 Jun 2022 03:01:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y6so14978004plg.0;
        Wed, 22 Jun 2022 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GsiUXUJaCRVb1CpguCGFkp9kz9qIiJmBZ7V2O+8BoTg=;
        b=kjcCzEmCqTwawGf24whIXIMax96ApxqTdj77L7XNAQjdFFYxym87fI7tS60LYX9rYA
         pQbnp47pONzEDu0oH8kOuAFifiCxeZS1lf6nQLsBNBwWDY/qwwLB8IUVLErBPko1JtRd
         rDURJ/AVWKVm4p30WjfJjFngvlB+Q8nO6qUgZOFmZq6toR6WRmo1yeG5dkrmFfRyd4SH
         /1BQ2y/HCObGY+UKFN1Lyj6vAgZMBuwab2pCL6Ci1z6W1m2Vv61mUvpZjLIqp27pYs8/
         Sc+B9YpJ5NpI5Vc4dOcFRjQFgR2MeLjjiYtFHGPARp3ERfL7XNx/uIiOusMzoR1Sb4n+
         0coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GsiUXUJaCRVb1CpguCGFkp9kz9qIiJmBZ7V2O+8BoTg=;
        b=cCCg9DdDL3R+l7xO+lPh63z75IEHGtPVdoTsbl/AcRCU0nS/gNe3tshPvSw23bshWw
         GQSGv5eRHXDlhBHmGNJvm+HB45mksh7OIckMy0GEyTCAquCAU7Lkf5bhzkRCiLeIDnNO
         lQSewQLgDsauP6wVeWaNyT5Ie8nq/BJzE0bV12Loz8Z5jRG/uK3Ds7CBlIttnXtjf3Ia
         uYyBm+CpKmOunLrDImTPVoTl8ZThggjp8FFAhey/U71EyB6t/kJGky/nf9OM1agWIxbe
         1PY49jYf/hrQ2ju9+ysri/Pb8Csm4yIRfbdr2fT6rrHmdXm4Dd/zkj/tSQzwz9zQK3tH
         XshA==
X-Gm-Message-State: AJIora8ekF8QYS8rVCmLM3iOHMDCkC6nVtxo15XowhIRu1Pmb7R1x0iz
        8P3CBfXOiTODvjctO1QwTB8=
X-Google-Smtp-Source: AGRyM1upeYWFwuBoV3KjWP56iWHQ0pEHkhEI6IckGEN2TBIxQSGN1SStG2K8QZIp8O+UxfaHXdl/vw==
X-Received: by 2002:a17:90a:748b:b0:1ec:83dd:f876 with SMTP id p11-20020a17090a748b00b001ec83ddf876mr2953877pjk.28.1655892115421;
        Wed, 22 Jun 2022 03:01:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:d40b:4089:31a8:340d:2f29])
        by smtp.gmail.com with ESMTPSA id w9-20020a639349000000b003fc5fd21752sm12790433pgm.50.2022.06.22.03.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:01:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Date:   Wed, 22 Jun 2022 18:01:41 +0800
Message-Id: <1655892104-10874-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Richtek RT5120 PMIC devicetree document.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2:
- Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
- Fix indention and remove status for powerkey.
- Refine powerkey description for more HW details.

---
 .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
new file mode 100644
index 00000000..f73b8b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/richtek,rt5120.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5120 PMIC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5120 provides four high-efficiency buck converters and one LDO voltage
+  regulator. The device is targeted at providingthe processor voltage, memory,
+  I/O, and peripheral rails in home entertainment devices. The I2C interface is
+  used for dynamic voltage scaling of the processor voltage, power rails on/off
+  sequence control, operation mode selection.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5120
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  wakeup-source: true
+
+  richtek,enable-undervolt-hiccup:
+    type: boolean
+    description: |
+      If used, under voltage protection trigger hiccup behavior, else latchup as
+      default
+
+  richtek,enable-overvolt-hiccup:
+    type: boolean
+    description:
+      Like as 'enable-uv-hiccup', it configures over voltage protection to
+      hiccup, else latchup as default
+
+  vin1-supply:
+    description: phandle for buck1 input power source
+
+  vin2-supply:
+    description: phandle for buck2 input power source
+
+  vin3-supply:
+    description: phandle for buck3 input power source
+
+  vin4-supply:
+    description: phandle for buck4 input power source
+
+  vinldo-supply:
+    description: phandle for ldo input power source
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^buck[1-4]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          regulator-allowed-modes:
+            description: |
+              Used to specify the allowed buck converter operating mode
+              mode mapping:
+                0: auto mode
+                1: force pwm mode
+            items:
+              enum: [0, 1]
+
+      "^(ldo|exten)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+  powerkey:
+    type: object
+    description:
+      PON key that connected to RT5120 PMIC.
+
+    properties:
+      compatible:
+        enum:
+          - richtek,rt5120-pwrkey
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-controller
+  - regulators
+  - powerkey
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@62 {
+        compatible = "richtek,rt5120";
+        reg = <0x62>;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        wakeup-source;
+
+        regulators {
+          buck1 {
+            regulator-name = "rt5120-buck1";
+            regulator-min-microvolt = <600000>;
+            regulator-max-microvolt = <1393750>;
+            regulator-allowed-modes = <0 1>;
+            regulator-boot-on;
+          };
+          buck2 {
+            regulator-name = "rt5120-buck2";
+            regulator-min-microvolt = <1100000>;
+            regulator-max-microvolt = <1100000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+          };
+          buck3 {
+            regulator-name = "rt5120-buck3";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+          };
+          buck4 {
+            regulator-name = "rt5120-buck4";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+          };
+          ldo {
+            regulator-name = "rt5120-ldo";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-always-on;
+          };
+          exten {
+            regulator-name = "rt5120-exten";
+            regulator-min-microvolt = <3000000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-always-on;
+          };
+        };
+        powerkey {
+          compatible = "richtek,rt5120-pwrkey";
+        };
+      };
+    };
-- 
2.7.4

