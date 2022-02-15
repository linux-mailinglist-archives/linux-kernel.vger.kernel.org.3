Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A924B77AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbiBOSIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:08:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbiBOSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:08:45 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A0F1199;
        Tue, 15 Feb 2022 10:08:35 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v3 1/3] dt-bindings: ps2-gpio: convert binding to json-schema
Date:   Tue, 15 Feb 2022 19:08:27 +0100
Message-Id: <20220215180829.63543-2-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
References: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ps2-gpio dt-binding documentation to DT schema format using
the json-schema.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
 .../devicetree/bindings/serio/ps2-gpio.yaml   | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
deleted file mode 100644
index 7b7bc9cdf986..000000000000
--- a/Documentation/devicetree/bindings/serio/ps2-gpio.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Device-Tree binding for ps/2 gpio device
-
-Required properties:
-	- compatible = "ps2-gpio"
-	- data-gpios: the data pin
-	- clk-gpios: the clock pin
-	- interrupts: Should trigger on the falling edge of the clock line.
-
-Optional properties:
-	- write-enable: Indicates whether write function is provided
-	to serio device. Possibly providing the write fn will not work, because
-	of the tough timing requirements.
-
-Example nodes:
-
-ps2@0 {
-	compatible = "ps2-gpio";
-	interrupt-parent = <&gpio>;
-	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
-	write-enable;
-};
diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
new file mode 100644
index 000000000000..304132fd30c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serio/ps2-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for GPIO based PS/2
+
+maintainers:
+  - Danilo Krummrich <danilokrummrich@dk-develop.de>
+
+properties:
+  compatible:
+    const: ps2-gpio
+
+  data-gpios:
+    description:
+      the gpio used for the data signal
+    maxItems: 1
+
+  clk-gpios:
+    description:
+      the gpio used for the clock signal
+    maxItems: 1
+
+  interrupts:
+    description:
+      The given interrupt should trigger on the falling edge of the clock line.
+    maxItems: 1
+
+  write-enable:
+    type: boolean
+    description:
+      Indicates whether write function is provided to serio device. Possibly
+      providing the write function will not work, because of the tough timing
+      requirements.
+
+required:
+  - compatible
+  - data-gpios
+  - clk-gpios
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ps2 {
+        compatible = "ps2-gpio";
+        interrupt-parent = <&gpio>;
+        interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        write-enable;
+    };
-- 
2.35.1

