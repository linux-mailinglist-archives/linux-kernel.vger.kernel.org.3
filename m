Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A5533C64
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiEYMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbiEYMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:13:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D8313A9;
        Wed, 25 May 2022 05:12:59 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A727C24000A;
        Wed, 25 May 2022 12:12:55 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] media: dt-bindings: ov5675: document YAML binding
Date:   Wed, 25 May 2022 14:12:37 +0200
Message-Id: <20220525121240.1094792-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This patch adds documentation of device tree in YAML schema for the
OV5675 CMOS image sensor from Omnivision.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

v4:
 - added Reviewed-by,

v3:
 - removed clock-names,
 - removed clock-frequency,
 - added all-of of video-interface-devices schema,
 - added clock frequency range in description,
 - rephrased definition of supplies,
 - fixed name of reset gpio,
 - used schema ref for port and port->endpoint,
 - removed mentions to driver,
 - added HW data transfer speed limitation in comment for
 link-frequencies,
 - changed root additionalProperties to unevaluatedProperties to not
 have to list all properties from video-interface-devices schema, such as
 orientation or rotation,
 - added maxItems to reset-gpios,
 - updated example to use assigned-clocks and assigned-clock-rates
 instead of clock-frequency and clock-names,

v2:
 - fixed incorrect id,
 - fixed device tree example by adding missing dt-bindings headers,
 - fixed device tree example by using vcc_1v2 for dvdd supply, as requested
 in datasheet,

 .../bindings/media/i2c/ovti,ov5675.yaml       | 123 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
new file mode 100644
index 0000000000000..f0a48707bed77
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov5675.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV5675 CMOS Sensor
+
+maintainers:
+  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+description: |
+  The Omnivision OV5675 is a high performance, 1/5-inch, 5 megapixel, CMOS
+  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
+  sub-sampled, and windowed 10-bit MIPI images in various formats via the
+  Serial Camera Control Bus (SCCB) interface.
+
+  This chip is programmable through I2C and two-wire SCCB. The sensor output
+  is available via CSI-2 serial data output (up to 2-lane).
+
+properties:
+  compatible:
+    const: ovti,ov5675
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      System input clock (aka XVCLK). From 6 to 27 MHz.
+    maxItems: 1
+
+  dovdd-supply:
+    description:
+      Digital I/O voltage supply, 1.8 volts.
+
+  avdd-supply:
+    description:
+      Analog voltage supply, 2.8 volts.
+
+  dvdd-supply:
+    description:
+      Digital core voltage supply, 1.2 volts.
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+      This corresponds to the hardware pin XSHUTDN which is physically
+      active low.
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            minItems: 1
+            maxItems: 2
+
+          # Supports max data transfer of 900 Mbps per lane
+          link-frequencies: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov5675: camera@36 {
+            compatible = "ovti,ov5675";
+            reg = <0x36>;
+
+            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cif_clkout_m0>;
+
+            clocks = <&cru SCLK_CIF_OUT>;
+            assigned-clocks = <&cru SCLK_CIF_OUT>;
+            assigned-clock-rates = <19200000>;
+
+            avdd-supply = <&vcc_1v8>;
+            dvdd-supply = <&vcc_1v2>;
+            dovdd-supply = <&vcc_2v8>;
+
+            rotation = <90>;
+            orientation = <0>;
+
+            port {
+                ucam_out: endpoint {
+                    remote-endpoint = <&mipi_in_ucam>;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <450000000>;
+                };
+            };
+        };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index f468864fd268c..549cdec4faaf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14551,6 +14551,7 @@ M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
 F:	drivers/media/i2c/ov5675.c
 
 OMNIVISION OV5693 SENSOR DRIVER
-- 
2.36.1

