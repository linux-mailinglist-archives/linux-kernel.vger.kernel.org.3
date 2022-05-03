Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5C5188E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiECPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiECPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:47:04 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115102D1C6;
        Tue,  3 May 2022 08:43:30 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D5FC324000C;
        Tue,  3 May 2022 15:43:25 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 1/3] media: dt-bindings: ov5675: document YAML binding
Date:   Tue,  3 May 2022 17:42:57 +0200
Message-Id: <20220503154259.1166203-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This patch adds documentation of device tree in YAML schema for the
OV5675 CMOS image sensor from Omnivision.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../bindings/media/i2c/ovti,ov5675.yaml       | 137 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
new file mode 100644
index 000000000000..d009cba539a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ov5675.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV5675 CMOS Sensor Device Tree Bindings
+
+maintainers:
+  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
+
+description: |-
+  The Omnivision OV5675 is a high performance, 1/5-inch, 5 megapixel, CMOS
+  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
+  sub-sampled, and windowed 10-bit MIPI images in various formats via the
+  Serial Camera Control Bus (SCCB) interface. This chip is programmable
+  through I2C and two-wire SCCB. The sensor output is available via CSI-2
+  serial data output (up to 2-lane).
+
+properties:
+  compatible:
+    const: ovti,ov5675
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      Input clock for the sensor.
+    items:
+      - const: xvclk
+
+  clock-frequency:
+    description:
+      Frequency of the xvclk clock in Hertz.
+
+  dovdd-supply:
+    description:
+      Definition of the regulator used as interface power supply.
+
+  avdd-supply:
+    description:
+      Definition of the regulator used as analog power supply.
+
+  dvdd-supply:
+    description:
+      Definition of the regulator used as digital power supply.
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+      This corresponds to the hardware pin XSHUTDOWN which is physically
+      active low.
+
+  port:
+    type: object
+    additionalProperties: false
+    description:
+      A node containing an output port node with an endpoint definition
+      as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+
+    properties:
+      endpoint:
+        type: object
+
+        properties:
+          data-lanes:
+            description: |-
+              The driver only supports 2-lane operation.
+            items:
+              - const: 1
+              - const: 2
+
+          link-frequencies:
+            $ref: /schemas/types.yaml#/definitions/uint64-array
+            description:
+              Allowed data bus frequencies. 450000000Hz is supported by the driver.
+
+        required:
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
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
+            clock-names = "xvclk";
+            clock-frequency = <19200000>;
+
+            avdd-supply = <&vcc_1v8>;
+            dvdd-supply = <&vcc_1v8>;
+            dovdd-supply = <&vcc_2v8>;
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
index edc96cdb85e8..94ff31268c3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14550,6 +14550,7 @@ M:	Shawn Tu <shawnx.tu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
 F:	drivers/media/i2c/ov5675.c
 
 OMNIVISION OV5693 SENSOR DRIVER
-- 
2.35.1

