Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B782574532
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiGNGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGNGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3081F2F8;
        Wed, 13 Jul 2022 23:42:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y9so1002439pff.12;
        Wed, 13 Jul 2022 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yfeCfELJlQY4ToU/lK3sTt4rcOO4PwA/EJ+PxIGvA4A=;
        b=WdWjMGTgcbq5FL3OfGv8bBTDXi56iL+whCQkn7FdUWY0Ad9+gF2HePY54Fr5L9DEUv
         pwrZfcJnVVoJgJIsga/UKIfd/xaeFPPikFZ/j5aLusO+8ADDjmfiJDdqhBKOEou7sWMD
         iOMvPdM+vz2xAnPWf3OyMes6/zinJ0XMx2uwCrof4k+MIMq4m7yczYcmpUYKhZvkf7ul
         +jJ6pkzQxN3EnlvWaNeaHHw56TPRTNxftr87GMthwH2siusp99ZVqBSkh0/8e7KTaLNU
         cLdE1hFUdfSDstPChDBOoN88ivtU9a8hLE+EqKvEdqyeC/E+U6l8qzMrkPyCjz2afKKX
         YXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yfeCfELJlQY4ToU/lK3sTt4rcOO4PwA/EJ+PxIGvA4A=;
        b=J3p5bUbtC2i3MzmCHD6yzrfcq0vdMAV5o99iA66NiAJxEULpka/yKx/OfZWhLtaUiA
         NkCCMiaQ0eeOtRB8/Bk0Eohbvi7FIQp8VWfREjGJldF69Cc8UuHsBBZVOYUFxKE56GUs
         1F1qYwG2UMzZyr9BCalKmG91fw3+ikQUUK+5czrL2IyT6sv73eikC/4HP9rwPq8IQO0a
         pA7OXMUYHFcItnrEg6HZPje3E6DLgOoDlcKmZNTJB7EAiznoyGqUnABEDpUlozoqEFEn
         tyFBjLz/osFaXIyNZEEdsp9iZtiMEIxPD/sj10YdeRwQpLkmsB6vEZsTspE95o513euU
         wNqw==
X-Gm-Message-State: AJIora/Qy/XNKYWYGJ+iA+q7sEmRL11+a9FjXk8BsH8C56fa0aTms4ZL
        qicpf5dRe8JX3wet4yQ0OIo=
X-Google-Smtp-Source: AGRyM1uh1/E/yf+og3WuseOqiZKViLi4k3Nq9DLWtLh/VcL2WDdJL3iObGNO/Ppdruf4V0CNbeXXjg==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP id b12-20020a056a00114c00b005282c7a630emr7004160pfm.86.1657780961624;
        Wed, 13 Jul 2022 23:42:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:199:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b001ef82e5f5aesm616291pjb.47.2022.07.13.23.42.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:42:40 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 1/3] dt-binding: mfd: Add Richtek RT5120 PMIC support
Date:   Thu, 14 Jul 2022 14:42:15 +0800
Message-Id: <1657780937-20891-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

