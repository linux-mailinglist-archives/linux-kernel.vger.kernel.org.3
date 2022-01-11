Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA77148B459
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiAKRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:48:57 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32910
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344483AbiAKRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:48:51 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A71B3F31F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923330;
        bh=ZnuinRIJ3lwFEAR4y2+anLAVZYP6shQkyVJQl1fjr+Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WoDS9RsVjBJTajEhMN7VVCAUmxXK8S679XXdDQyLRfTyrQgHMnWDm02EwaVmft1P+
         PGuc1od+VdnfZlrZsTuec5xMunm2g84JHRbGnrXoh7iYyAdarrilLJcDb2VcKV5dAs
         QEU+3TX21dvsZY1rybLsPCMD9jX0/eKuZ0GMSOmxF8WC+SHkCmmvoeayt2Zs3coihL
         p0fYQ0n9P0E8J3sIj0LN5eIrjG9Kd5qTIaW/jn9T1uheMokC96/PJJEBmmcu7bt92g
         /Ay+LVW8noqX33Um9oSJG2i02auDVACPzC6/fLe4kZYL8j4Wpb6Ine7hi/D4pZnw4J
         YthtNvpU7J18Q==
Received: by mail-ed1-f72.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so14003331edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnuinRIJ3lwFEAR4y2+anLAVZYP6shQkyVJQl1fjr+Y=;
        b=yOat5zwzFIU1oTtRDohKPyei7nyXnRg7k6q6HSaEtgWFtpp+c57UKw767AAGmhOaeu
         38enPdkCLTgOdMplRygzsGHnW6WdcNtkLqg05h2m6HIBBgmotoaYFm3Sxv61Sqc8RrL0
         3EfLfoqtN91if4k8LnvBfU98nAfk9fdwhMPI89lUQFWU7i01WvcGN/8vVZ7d+8lK5GCt
         SoeudLrxToP46yPEqRdColimiwu51lIFnqsO76UbSMCl9jZkB29dCO2hh+vPBN4qrAgn
         ulSLOA4R2qANJl8xMTfI/QLlyGQDdEie1E8u9PicmxT8qnmI0OKWvEp+a6TYjeqtTfE2
         eBjg==
X-Gm-Message-State: AOAM532PeuSdlxbAjOxrmJWWiZeKG82eceYOy25vdrW2VQnk+2L1k95+
        /1dcMqMvIBizvwPLuVPzyWiOv8BCiKmdu55eogs2nuRjyEYgigEIs6mOLI/agFUK9Uv4KocCwCP
        YILcLrsU9L7K1kvk6cPMM3gx/JgLGCLwB3JQsIWHaPg==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr4841112ejc.591.1641923329546;
        Tue, 11 Jan 2022 09:48:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOJF1zICLEmpK0IleOo2vl9NWSe0ASojjhQJ61G5WSvc3ti1P6uZ55rmKdhqD41LQqLvUr+g==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr4841098ejc.591.1641923329335;
        Tue, 11 Jan 2022 09:48:49 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i23sm5224489edt.93.2022.01.11.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:48:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: mfd: maxim,max77843: add MAX77843 bindings
Date:   Tue, 11 Jan 2022 18:48:04 +0100
Message-Id: <20220111174805.223732-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for MAX77843 MFD driver, based on Exynos5433 TM2
devicetree.  These are neither accurate nor finished bindings but at
least allow parsing existing DTS files.

The example DTS was copied from existing DTS
(exynos5433-tm2-common.dtsi), so keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/maxim,max77843.yaml          | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
new file mode 100644
index 000000000000..61a0f9dcb983
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77843.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77843 MicroUSB and Companion Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
+  Integrated Circuit (MUIC).
+
+  The Maxim MAX77843 is a MicroUSB and Companion Power Management IC which
+  includes voltage current regulators, charger, fuel-gauge, haptic motor driver
+  and MicroUSB management IC.
+
+properties:
+  compatible:
+    const: maxim,max77843
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  extcon:
+    $ref: /schemas/extcon/maxim,max77843.yaml
+
+  motor-driver:
+    type: object
+    properties:
+      compatible:
+        const: maxim,max77843-haptic
+
+      haptic-supply:
+        description: Power supply to the haptic motor
+
+      pwms:
+        maxItems: 1
+
+    required:
+      - compatible
+      - haptic-supply
+      - pwms
+
+  regulators:
+    $ref: /schemas/regulator/maxim,max77843.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77843";
+            interrupt-parent = <&gpa1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            reg = <0x66>;
+
+            extcon {
+                compatible = "maxim,max77843-muic";
+
+                connector {
+                    compatible = "samsung,usb-connector-11pin",
+                                 "usb-b-connector";
+                    label = "micro-USB";
+                    type = "micro";
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            /*
+                             * TODO: The DTS this is based on does not have
+                             * port@0 which is a required property. The ports
+                             * look incomplete and need fixing.
+                             * Add a disabled port just to satisfy dtschema.
+                             */
+                            reg = <0>;
+                            status = "disabled";
+                        };
+
+                        port@3 {
+                            reg = <3>;
+                            endpoint {
+                                remote-endpoint = <&mhl_to_musb_con>;
+                            };
+                        };
+                    };
+                };
+
+                ports {
+                    port {
+                        endpoint {
+                            remote-endpoint = <&usb_to_muic>;
+                        };
+                    };
+                };
+            };
+
+            regulators {
+                compatible = "maxim,max77843-regulator";
+
+                SAFEOUT1 {
+                    regulator-name = "SAFEOUT1";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <4950000>;
+                };
+
+                SAFEOUT2 {
+                    regulator-name = "SAFEOUT2";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <4950000>;
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <100000>;
+                    regulator-max-microamp = <3150000>;
+                };
+            };
+
+            motor-driver {
+                compatible = "maxim,max77843-haptic";
+                haptic-supply = <&ldo38_reg>;
+                pwms = <&pwm 0 33670 0>;
+            };
+        };
+    };
-- 
2.32.0

