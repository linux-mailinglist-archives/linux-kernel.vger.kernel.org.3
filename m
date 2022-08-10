Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADA58E4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiHJC4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiHJCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:55:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA26E882;
        Tue,  9 Aug 2022 19:55:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p125so8954404pfp.2;
        Tue, 09 Aug 2022 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=00QwFsSsx0p4Rq/+WMPcisGqh3vRjG4L7mdiYaZeS5o=;
        b=b2CKaPfUUr5XuzciawhCzLDr/7dtG6hitUf9A3g0nmGE2Fqqa7Nn5OS2Fsi7o0gB9L
         RmIWeo9EfCXqPVpvrPxXSytNpS/jpjQWJbw9zZYHeRfAwOXKIVwqpRkuSQCd5QVGdOYB
         /URI01UtrbGNNPdafL2LmwmRYXisyow2AlWG2zxdFsmzRIHlvMnZL03kzR5/ivRGlnKC
         B7B7YotnuP3QPsopOET0ixiP7+koA6hP+q8ODHdfDy2TD7pi0yPT21YqcxXXiytwdXZ5
         fK6ng+GzOBkg8gfpbxS6eU8cVeIp7q94ySEPugFR7ywnJ+3HLvrjG9PBD6V9/Ixxb+Xh
         iP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=00QwFsSsx0p4Rq/+WMPcisGqh3vRjG4L7mdiYaZeS5o=;
        b=yGUnhoqBqGxs6oOvfAVhqtXKP1aUYrjXOVz+2k6mh9K0GoSderoP2sAhW0vjW3zefI
         FdRsafuq8hKnlUwl9rb9BwoWk9W+MemCyCpXBuENt/V5/PI76RO9FHyztQ1Cf00CN3i7
         TlNGKu7G8sp+G+gb/ZIFoCw2QSYuVsFeIHHLQzEdU0FbQIRhRca/r5xHLbruTZZCUdpX
         NUjSDlQS7TYdgjC1MpP/kcLP5v4mHnfF0ksmWZs0FIKOwVSAYnoTjXJWqQLSpeU6gNpo
         Fs8/WGoyHlcpIE6yaNlk0yWqjRB2mY+RY4dtw6bpI02Y7sTjXX1PeDyVP55KzLmxHLZ5
         fmOw==
X-Gm-Message-State: ACgBeo37fQwhAHuac6hKqSa5m+arPW+rykrJKJfmt94AEG6QVCDqrmmO
        KdY7jFgzVhM7xD/0BI+ZlsYqEdBEv5U=
X-Google-Smtp-Source: AA6agR6qQwug6jAlirzb/ycLYKIODOblE7f//4JHqkaT3iffw/WuWJyRIQ/8GwE01kUf8CYXXzTzfw==
X-Received: by 2002:a05:6a00:b4e:b0:52f:59dc:70 with SMTP id p14-20020a056a000b4e00b0052f59dc0070mr11505661pfo.2.1660100152594;
        Tue, 09 Aug 2022 19:55:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:d15f:416a:c0:aecd:5d6e])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b0016d1f474653sm11785654pla.52.2022.08.09.19.55.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 19:55:52 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, dmitry.torokhov@gmail.com
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 1/3] dt-binding: mfd: Add Richtek RT5120 PMIC support
Date:   Wed, 10 Aug 2022 10:55:40 +0800
Message-Id: <1660100142-32493-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

