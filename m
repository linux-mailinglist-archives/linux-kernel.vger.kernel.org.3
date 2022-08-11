Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05E58FD91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiHKNmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiHKNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:42:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149515A22;
        Thu, 11 Aug 2022 06:42:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso5142460pjl.4;
        Thu, 11 Aug 2022 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=C9JOnmvFZ7+tSs4+U0VVYxRsrqWxPNaYC2qEG4pJcA8=;
        b=p6T+0EOy8CtfR2AAvycMEZdj7x5+Ssfzyj2Pllpb1QkaoVD8nFI0wjtDS3k4xkKuAY
         Br/GYZgj4YADEeI0eqCjUXYgG4AhHwVeeNxManTGt6vbARAiXjgjvxtWpNKwTp6LFpDK
         A2Y4ABGIHWZHUrhTQZZNTerVdmmAo7Xn8DjciUCsRbDjoftZCJv8Xr4FAO5xjn02mR6Q
         ZK1jPCLKi9Uelx+YZuF0UB9o2PjofUV7SYni99s0F/sR0PG/H25TDVwkMMc6s5FLHrPT
         syQWAbHMSjDGfS3tbf6qOzoe2avlc8m1nduWulLEAcSlLgtnGxvO31/AEIR/3BSYNWjE
         hjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=C9JOnmvFZ7+tSs4+U0VVYxRsrqWxPNaYC2qEG4pJcA8=;
        b=dMawydPSBRL/+H3nCwYRLPvJZpY4vHgMXkMRfvBg4llGRpYduukl6ZGeyXcZYpo/8A
         DiaDweXgLVjx2lXvbRPxqGhRIdzEBFy10aC3RpgyzhF7wLyJT2Kx3o5Sjp1RVArBfH1u
         CFic7nztSE4sXNm3UU/UIylves5pl6D6UuYxbawaS7ZgAP/YfW3IU50RNqZd/v32dOok
         u3IGARNQfOK5ziqKgCYi3kraplMUuCDQlu7JqP5NGhymHZHizm55k8cQB/B/GsNm7pem
         EE/8kUGDPwtF8vLxgos2MQ5SYHITLYsqRmre2JakO86GOIzBfbMF2J9I61LkqIMobewa
         t9Dw==
X-Gm-Message-State: ACgBeo2GyS+b7KetCJWJhF4fdrt+RV8kllMXVAaTYtAoh9l16H9qM/RK
        Xx62u74LrpVYKm7NPZbRlqjKs9HcOAQ=
X-Google-Smtp-Source: AA6agR5wmNc0PKac+9ijwjA2EJfA6LRoH2+eDYeHx31WVKWqHGvUp1ofpzHnXp9GATIZiOF9+kuDyw==
X-Received: by 2002:a17:903:264b:b0:16d:b891:593 with SMTP id je11-20020a170903264b00b0016db8910593mr33465166plb.133.1660225328432;
        Thu, 11 Aug 2022 06:42:08 -0700 (PDT)
Received: from localhost.localdomain (1-171-1-124.dynamic-ip.hinet.net. [1.171.1.124])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b0016edff78844sm14887753plh.277.2022.08.11.06.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:42:08 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Thu, 11 Aug 2022 21:41:57 +0800
Message-Id: <1660225318-4063-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
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

Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/power/supply/richtek,rt9471.yaml      | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..6fef1bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,78 @@
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
+  ceb-gpios:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        ceb-gpios = <&gpio26 1 0>;
+        wakeup-source;
+        interrupts-extended = <&gpio1 32 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        usb-otg-vbus-regulator {
+          regulator-compatible = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+        };
+      };
+    };
-- 
2.7.4

