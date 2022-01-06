Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417E486D54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbiAFWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245223AbiAFWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:44:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397BC061245;
        Thu,  6 Jan 2022 14:44:09 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E6E711414;
        Thu,  6 Jan 2022 23:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641509047;
        bh=TTqB7Ua6ydtiTPPtx5b//2HRwPIaNssqss7QoV49ehg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb2LdJbrzo4f85KRRUqC4P182lwxDfD5PbRtmUvB9g9eYvnILIwZwEoRZzHX9ax15
         gPtqwh8Sc5HndqYqdkZdYUR2YV2fJvudNJS1tGXEwN1jZfsktczlNGPys4dIHny393
         ptYFgvIxyXtax66PJ06DjBl+U50Fc1LNcWCoD5TM=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089
Date:   Fri,  7 Jan 2022 00:43:49 +0200
Message-Id: <20220106224350.16957-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106224350.16957-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20220106224350.16957-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The MAX20086-MAX20089 are dual/quad power protectors for cameras. Add
corresponding DT bindings.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:

- Make OUT nodes optional
---
 .../bindings/regulator/maxim,max20086.yaml    | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20086.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml b/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
new file mode 100644
index 000000000000..05f72391185e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max20086.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX20086-MAX20089 Camera Power Protector
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description: |
+  The MAX20086-MAX20089 are dual/quad camera power protectors, designed to
+  deliver power over coax for radar and camera modules. They support
+  software-configurable output switching and monitoring. The output voltage and
+  current limit are fixed by the hardware design.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max20086
+      - maxim,max20087
+      - maxim,max20088
+      - maxim,max20089
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to the EN pin, active high
+
+  in-supply:
+    description: Input supply for the camera outputs (IN pin, 3.0V to 15.0V)
+
+  vdd-supply:
+    description: Input supply for the device (VDD pin, 3.0V to 5.5V)
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^OUT[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - in-supply
+  - vdd-supply
+  - regulators
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max20088
+              - maxim,max20089
+    then:
+      properties:
+        regulators:
+          properties:
+            OUT3: false
+            OUT4: false
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
+        regulator@28 {
+            compatible = "maxim,max20087";
+            reg = <0x28>;
+
+            in-supply = <&reg_12v0>;
+            vdd-supply = <&reg_3v3>;
+
+            enable-gpios = <&gpio 108 GPIO_ACTIVE_HIGH>;
+
+            regulators {
+                OUT1 {
+                    regulator-name = "VOUT1";
+                };
+                OUT2 {
+                    regulator-name = "VOUT2";
+                };
+                OUT3 {
+                    regulator-name = "VOUT3";
+                };
+                OUT4 {
+                    regulator-name = "VOUT4";
+                };
+            };
+        };
+    };
+...
-- 
Regards,

Laurent Pinchart

