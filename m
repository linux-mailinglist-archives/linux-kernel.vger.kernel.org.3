Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71A85482C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiFMJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiFMJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:06:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A8DE0CA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o8so6260567wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Focgo4OECw93XghPSNcG4N3N7df19LOqw//cxPjkU48=;
        b=wbpXo0pA2Vvfie476fY5KP79xaAybk9AjdzeNEkhM/+eJCQ2/2RfO7VOMQWvjoCm0+
         LpadOPOE3si0Dj4wLty8UgoESgrcAWD6H3O82q0B+JVYnbaUJqn0WgO91Uc/VzKc2AsH
         E4Acf7id5FZ78dbSr2VOsW7R+a2zxOC7WNASVqMYsFKnjI/rFZsTYmk1VOdyIVGv1L2O
         rpD2IxtsRWQ6Y05IAYUMif4MezQTPuZjqcZcWt7i+TmvVg/8oTlBPL5PMCvI1auYwWKx
         OaO3XGKlHf2CNgEX1qYvpEL+H9QydqYdW+xO/J5PUc9Qaou4Niy8mCDiMIkSCKsHcC3c
         ReXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Focgo4OECw93XghPSNcG4N3N7df19LOqw//cxPjkU48=;
        b=wx8Bi0GXcWmArQZ1qGgFGW3CUBYmNefmA1DgnDZPaxrxUhe4/HlJwILwhgHa5yswSc
         tiSgf3RMoxzzfIssNlp72Djqiwz4IncYz1pXApruj44k+cm6QhJX9/5j6WEc6eIWmQHh
         hn32Vj9O9Ey8A+w5v94YIY1fSZffGZ78o8poyyk6K7lALyjxhSiKPZCVlZNLGmIYD87x
         xPmRwIeVoZyQprtMJqtg3egegt0p/hhXEE2OrJySl3vJMc6P+POayi0FJlBh0gE7LYhD
         i9MVrZYpyZmQ0bMfz1XeHxszZ4kcjRTyT5U+f9DEU5z6ymHuTakXpqHH7hnSmT9M54iQ
         In0g==
X-Gm-Message-State: AOAM532fJfkI7YEQyzugQ/k7MxeyxeM/H6F14AJwhN7duKeVLZnz/5RL
        BO7XXpyWtJrmk18oQlk3dJhNM9dKYV/CP5Vm
X-Google-Smtp-Source: ABdhPJxCW4GruMDY2H/VoJSb8Wlbr1iyUSTJaRUcqJVDNmXzaSLGhAqkdnn2CbwkDbLNPc9gK6hMhw==
X-Received: by 2002:a05:6000:2a4:b0:218:77ba:988e with SMTP id l4-20020a05600002a400b0021877ba988emr24777381wry.459.1655111169763;
        Mon, 13 Jun 2022 02:06:09 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm7806465wrr.39.2022.06.13.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:06:09 -0700 (PDT)
From:   Jerome NEANNE <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, will@kernel.org,
        lee.jones@linaro.org, jneanne@baylibre.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/5] regulator: dt-bindings: Add TI TPS65219 PMIC bindings
Date:   Mon, 13 Jun 2022 11:06:00 +0200
Message-Id: <20220613090604.9975-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613090604.9975-1-jneanne@baylibre.com>
References: <20220613090604.9975-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TPS65219 PMIC bindings using json-schema.

Describe required properties and regname-supply.
regname-supply is required when bypass mode is used for a regulator.
Describes regulator topology.

Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
---
 .../bindings/regulator/ti,tps65219.yaml       | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
new file mode 100644
index 000000000000..a4717ff4e95b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -0,0 +1,146 @@
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
+        properties:
+          regulator-name:
+            pattern: "^VDD[A-Z0-9_]+$"
+            description:
+              should be "VDDNAME_LDO1", ..., "VDDNAMELDO4"
+
+        unevaluatedProperties: false
+
+      "^buck[1-3]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^VDD|VCC[A-Z0-9_]+$"
+            description:
+              should be like "VDD_BUCK1NAME", ..., "VCCBUCK_3NAME"
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
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

