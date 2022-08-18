Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F6597AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiHRBV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbiHRBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:21:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D19D64B;
        Wed, 17 Aug 2022 18:21:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 24so119089pgr.7;
        Wed, 17 Aug 2022 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=CkYSDkBBJYxGWz3G0h1YEt/KwAYDNYKXngBwfOVl52pr+5WSBQqCOti77yYdKdCvlp
         WhL0tdVXxZe4RDz3EJTiMbnzZKHqLOhTIv4KgC8iZODXmEzpPwzFvhh5Mrkrrhzat9ML
         rTrS3jNiF+vINWkw2+Yh7ufriRGbnJyClkvLMdr6VDg83DfHvCIewTGW880tb2vbTqAw
         pmb0R+LdCdwtjLNZtRH3PuNEY6Qo4WyObUyowuonqqGfTC716SfkoCjWL7YpHTt4zRh3
         VfoyJ/RcRyX4/jTea3+g7aZPDnYrLEWpXhjY0kTLDYPr03Nb3HG6WSzIsoGeoc4K7eYU
         7x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=cJmlOkqpVb0UEd56meEJSQIx5C/vYNn1NaxdqFi4c9qBPVrRGRGpPFQaPioiZG+4WN
         K/0KPj7iMvb8/swyYPEWUJ+yMKXk9qiehhsFKG/n23Qsaip5dVR3TouLU+9lfIiggTZw
         UVPvxfVXI3AbDiRjgdToQd8r4um+v7i+9QppzEs3mqu+o7uYXLcoQjspUJOty2oyrktg
         WL0hjZ0Lh4SGlHZe7zmBVnh1ruPOaecshGyEK8676izjZveP2WRhatcb/rR3SwuC36v3
         YozYnuWuJEdbptd2B2RVoWcuiBIm2v1i5J+8+L2GZfQezGCYJof6Z4WHbHA1PYJt9Eb2
         G0ig==
X-Gm-Message-State: ACgBeo3iuaMZs3DStjwnLG5vdqj8Fm5YQDiSZBTzcM6dw0gRnCqOAdQ6
        qjCvhO2fgbEs+IKxTD/7Ldy/Pe0l/sk=
X-Google-Smtp-Source: AA6agR7cyJK+JuUJ0woz60kbQMlSzf/+PfyOjrpF3LU4bo5Paeudmn1MO5jRma4x8pmBYPKGscwssg==
X-Received: by 2002:a63:86c7:0:b0:429:a424:62d6 with SMTP id x190-20020a6386c7000000b00429a42462d6mr731097pgd.16.1660785707940;
        Wed, 17 Aug 2022 18:21:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57a:2602:4c40:2a8:e5c1:f4fa])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b0016bb24f5d19sm51691plh.209.2022.08.17.18.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2022 18:21:47 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Thu, 18 Aug 2022 09:21:35 +0800
Message-Id: <1660785696-9010-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
References: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

