Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD15795FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiGSJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiGSJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:17:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475922B1F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso1182317wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqCQqbntKXpX+1pifR7RMIoTfr+fS3UlaxC6glFkmdQ=;
        b=lv31lnwCIh231JuIwCyht8yuCf2YnlU3NThs1WD+CdO7coBp22+ZnDWg+gocAGVSLk
         1QWm82mL+aSw1Itr10bSvKeDG7ihBfG0g8SpSdCBajls8BdcaudM3f2KdkfUwCgGnx2Q
         QbhnrdSibAio5crlMAkkwGW4juYbgieePSezySoh0gQINpPYGrbR85Yle6YZ5BpU/7va
         Cf+FK3Q6Kaj2uIY7jrC5ipze5v2ee1PsJ0JRe81GQ72l7Q0SFBs3S63bBgCpbw8sGF5n
         51BwcW4245rYV+LIr4hensGeqFAN/NBWcydxT8yQ2u5bAI3ybxtgK/SwPOvUvEyR4vmv
         gRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqCQqbntKXpX+1pifR7RMIoTfr+fS3UlaxC6glFkmdQ=;
        b=ZHdfboo0LaO0V1YnzY+VlocvbAXwoRBsZcotI2kt5eQBzevVGEvqeEr/DAv5+sXeOJ
         lDm/MlzTQh+z+kd0dXLQNpuyQCINJtZHk8ATLbZcIL+CG88AVEdwt0f9W03PE+q1KUQx
         Bxz2YyrFSxDzzU7nOC2pYlmDyLSseSXmP4eFtT7imHLq4jvtm+koAtxDKC0nLbCol8R3
         qr1JeAonUfHvlNQhn96ZMZgKoI87zmLMlQ95Y+Y20bQm4Sv8j7xIh74L8PXWnKRERBR5
         h+BZ0mnWE51oG6T2B79X9gLBO+TPpWfhnco9Kd2EPX/0ItZNS0nJsYzQSQCTwqusfLxW
         X6Iw==
X-Gm-Message-State: AJIora8jXMCkQ2gW86v6lfYFCqdfVG4GWxQ/HSJdJIZKRZr9wQWKB/wo
        udzk421cyI3k6dr6kHTWy/3sdA==
X-Google-Smtp-Source: AGRyM1v+pq++YwR85lTsJyAS7h0am4kz3uPeFNgfdpRIUilxRvLKSgwTQooHtIaqWESzoAcBBHHkMA==
X-Received: by 2002:a05:600c:1c26:b0:3a3:2251:c3cb with SMTP id j38-20020a05600c1c2600b003a32251c3cbmr2507110wms.126.1658222272414;
        Tue, 19 Jul 2022 02:17:52 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:51 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 02/14] regulator: dt-bindings: Add TI TPS65219 PMIC bindings
Date:   Tue, 19 Jul 2022 11:17:30 +0200
Message-Id: <20220719091742.3221-3-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
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

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 .../bindings/regulator/ti,tps65219.yaml       | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
new file mode 100644
index 000000000000..2c655432b889
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -0,0 +1,151 @@
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

