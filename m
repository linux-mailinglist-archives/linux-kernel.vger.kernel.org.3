Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4558113D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiGZKel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiGZKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:34:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820A32463
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v5so8471066wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRm7T586IVqER+nWuPPvT9TSOI3c0IELRytvLb2fip8=;
        b=yYbOfeWar4cPz1aldKgI/l5Fuqhd97saimvxx5OLwWFhyjQI2SWcLMn9cBRDnipWzC
         xrinAzal1HMa6WGyS9Qcpux+ziThsZiCZSRmIn/Pu/+Sis6kvN7/PkDJ9pTRJHBnPcBS
         kpG/T6nrr3YgX0BFlCXX1OXhf4x+HGgzAIOrbzRnHxLjmmoAx1a9HGfRhnewVZzPK68E
         BzD+0ZPEqRg5vRBwjYgh4UQB7HpFxmNAxM+95Vd+WAM2DhjkbiE3iKmJl75Q3JLPrMSt
         sp6i8vWzeVGvbkz1qL+7ucSsD/X69imOlx5BjLZ8xIm+dPOSsd2MvDpeyDLZSMbu+Txx
         3ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRm7T586IVqER+nWuPPvT9TSOI3c0IELRytvLb2fip8=;
        b=hwzyAdoKXk3gV5BayVKItIMmYUs2nUAD7pPYnLmASX6X/xlImRxAanp9mDkV/tFLKX
         5K3zTeo61LyaHF47USJvCLyQ88csAhfq2Azzszo6bvTHeR2d40G5ze+uyCajUFlZIaJr
         BdtkKbpY1EOy5Be8lAsAtVzO06BGR8zqBoaAwLqU9itMgPeGDm2lT+6YsEDHwKQwI4+/
         tStDJb+a3ZrKUZPJYFzNmyY7J1dznUjNKHbf7zuTTFRTghJiXxbfqlXTw/atjO7F4wpp
         d2Pwy9UA4s2jGr3q1eQfNTNqQ+ztNB3gyzXlnouu+zhTXAAV49oraMQu8u5AD+mx7z7m
         s0FA==
X-Gm-Message-State: AJIora+AAf3eZCnPWarnYQH4zZ8JXyelyN4ZwvNLPsQ1LeNtTcjMthBz
        LdEP+2w2JGNymMcdVaWTyxLLkepnJw6VAw==
X-Google-Smtp-Source: AGRyM1sqivGj8DnM+Fj6hXaxmJwGXtnnK/mSa3hSHfmCVeHHutSIuqZdoraER/IjTl+HeJI0K/53Ng==
X-Received: by 2002:a1c:f317:0:b0:3a2:df38:9877 with SMTP id q23-20020a1cf317000000b003a2df389877mr23958396wmq.124.1658831658864;
        Tue, 26 Jul 2022 03:34:18 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:18 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/11] regulator: dt-bindings: Add TI TPS65219 PMIC bindings
Date:   Tue, 26 Jul 2022 12:33:49 +0200
Message-Id: <20220726103355.17684-6-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726103355.17684-1-jneanne@baylibre.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/regulator/ti,tps65219.yaml       | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
new file mode 100644
index 000000000000..8fca4db6c64c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -0,0 +1,164 @@
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
+  power-button:
+    type: boolean
+    description: Optional property that sets the EN/PB/VSENSE pin to be a
+      power-button.
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
+            interrupt-controller;
+            #interrupt-cells = <1>;
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

