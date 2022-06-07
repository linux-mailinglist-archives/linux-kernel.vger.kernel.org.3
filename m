Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADA53F5B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiFGFxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiFGFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:52:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23DD63A1;
        Mon,  6 Jun 2022 22:52:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u18so13961275plb.3;
        Mon, 06 Jun 2022 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naeNUv4uowbrS5usby8qrXeOXsbGFG/yn2erw0WpZ/g=;
        b=KC27qsxSENy78e6fxvs0Hgo7F7cAZaU1KutGo5/vc2SSyrXcn7bo4tvfqRQLgARKRA
         eIPY8LbkV/i5py30CB+PpIieJGqUwBm3CnXx6FhSlVlVyDT1YMf3aghqWtYLX1yIifY3
         F7uFdG/1kRRbGEjuwBZeYTzA2bRfsoXCGDCgbSF0WfdNfx8mlGnJxc+jYoGRPWaupOjQ
         R+I77udKlmh6ja7iuVbOxmhpqHvpKHsf4HWqyKATcKplhq7f5wi2AKEV8+6FOIKZfGuc
         UqADOkU6VyDf48N7oqIrqCT9qzUjGWaUEoqV9RYMdaBn6XJqQTaqt4Ceu5L09W+j6qBP
         6T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naeNUv4uowbrS5usby8qrXeOXsbGFG/yn2erw0WpZ/g=;
        b=aeOTsNV2FPQyiTQUjfvsiUEA1zcAoqRBlsQOuZgC/EwLe2YhVpmeGd8nP8KPo3uDpt
         HIVNl+UXODMwtEnPsjrz6EaZTb2LOmDlhoKXIwNzEdxonBTJJjqWtZicIP0VEQZ8ALB2
         rx8KhwisNRiqgQKYR7amjtV7uoGdnIH3MDOiO5EME1XaPdFOMaT1bj3ODSooWHoUgc2j
         zmqGjcdYUPlClS2JCPEXEAYlo8iA59x2oVDni1s43gvRcb/uDrd6UDGZpPs2wR5yiDxd
         3ZTyf4226MlYzVwrYvTXlVehmcPRlNFEYmuBsCj3pFfZcZF3wI02s5Mmj+MhrdmNnna/
         eV2Q==
X-Gm-Message-State: AOAM532uiOVfnmGG3mH6y6rLmlSiV+RQ62G+TQkUHlCH4jl4OSF6+12G
        asj+FlBYX4NSqMK6fcuUeaY=
X-Google-Smtp-Source: ABdhPJySPAb0CtuZhXy0z2bXS6VnaOu6E+TDLfHm7LY7wPVqr9x3R8txli35gBdm0IzL1P5Xet9NFA==
X-Received: by 2002:a17:902:bf48:b0:167:7bc4:5020 with SMTP id u8-20020a170902bf4800b001677bc45020mr9146833pls.105.1654581173720;
        Mon, 06 Jun 2022 22:52:53 -0700 (PDT)
Received: from localhost.localdomain ([49.216.54.77])
        by smtp.gmail.com with ESMTPSA id z41-20020a056a001da900b0051b62689ec2sm9203520pfw.129.2022.06.06.22.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 22:52:53 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Date:   Tue,  7 Jun 2022 13:52:38 +0800
Message-Id: <1654581161-12349-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
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
 .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
new file mode 100644
index 00000000..376bf73
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
@@ -0,0 +1,180 @@
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
+        unevaluatedProperties: false
+
+      "^(ldo|exten)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+    additionalProperties: false
+
+  powerkey:
+    type: object
+    description:
+      The power key driver may be optional. If not used, change node status to
+      'disabled'
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
+                status = "okay";
+                compatible = "richtek,rt5120-pwrkey";
+        };
+      };
+    };
-- 
2.7.4

