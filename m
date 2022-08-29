Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028A5A4143
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiH2DHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiH2DG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:06:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A41371BC;
        Sun, 28 Aug 2022 20:06:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so6566677pfw.4;
        Sun, 28 Aug 2022 20:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=GzuUpNCdWjWbgsN5oUwp8P6h3Hx/C4XYJqXUF2ich7AqramvQrA4F58yfBsjuIW7b9
         c+G/LQE+6/Gmcu4A5wEmEWg4hu/eHQCWblNOqMz0F4e20TIlyhHuSS1I6zUsEPoFM9gw
         gZEWkTAeEV37IgQKPYa7XJDFmC+n9FwA3SxAXXy9EZrLJHEVMMZt6sZuPb9HsPiMttd4
         Q9w/e4Azki7H/v/6X9vcz1iOVZRQB7Qxv8Is5O7Ujk9WgBVprO/kEs7Sq9GuddX25YAW
         wucHwtQx6hAnnaQFCRKqU2WYO/NpXQ+8kOo/rxrP2dY3FKNnj9denxl8Jz3LeqOu5tAO
         bDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=I2mdPXs2O5VVBX1Yqo/ZpLgCq6VWlpRAhGMnBvXfe/foi/nIzDK7WgLw003xrI2Fo1
         oFTtiFdEw1h/At9ZuDsjKJ7kaTlvt7nrCLVHY9Lip0yNehwesu+uktSoRIfpuQbxBUAH
         R1pwzro9KIDO7E5tGLLKo/esB1J47IhOabJm4wNTDRHUgBKcSkmWWUaPG2p4Lr5J7QBj
         2b173zuvdoGAakJt3lMJq9r+CAzfAiWzCyzFbQFyditvZiiWEC9Jf9EDSl+WIR9bvCAZ
         JuGxOEilrXhikTmWHp5BSqwvo7OMmnIThAln+d3qRIdNd03feSDh3IYeFVKiIjsQAYRD
         xq9w==
X-Gm-Message-State: ACgBeo32gj4sW3bI5mL4G7z9xA98ikIqi2MfDV1yvRtndLXqlIb0dSh+
        ycw3Kf0U+AD171V9ZrR3OCxAW4hJ+OA=
X-Google-Smtp-Source: AA6agR4+Bg4RjO8ostEvejphq/W2oGapGa0946d0QZmPhCdACqKQtc5Pm3eh3kVLqKh1yS+NMMno+g==
X-Received: by 2002:a05:6a00:2282:b0:536:72d0:d01 with SMTP id f2-20020a056a00228200b0053672d00d01mr14409720pfe.79.1661742414957;
        Sun, 28 Aug 2022 20:06:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:7020:1d84:ae39:a965:2e45])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001714c36a6e7sm6105839plh.284.2022.08.28.20.06.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:06:54 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Mon, 29 Aug 2022 11:06:29 +0800
Message-Id: <1661742391-11378-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
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

Add bindings for the Richtek RT9471 I2C controlled battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.

---
 .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..fbb54cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9471 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It supports USB BC1.2 port detection, current and
+  voltage regulations in both charging and boost mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9471
+
+  reg:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+
+        usb-otg-vbus-regulator {
+          regulator-name = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <1200000>;
+        };
+      };
+    };
-- 
2.7.4

