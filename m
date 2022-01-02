Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780B9482CC7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiABVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:11:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47664 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiABVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:11:34 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 905DEE57;
        Sun,  2 Jan 2022 22:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641157893;
        bh=RdhKtj0DZlGRuOKkUhOrRlRtjRj9hnOmBr2VeDTpwvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tes2SxRQNM9LF9IJqZDwZoE6tAnauO982zDPJu9DmXomfnhCkXGhv0mxATYwXulog
         EyMK3wkguG535Z2Jb3NloiYaIBn76DCqaykQFkT9lWN304eXR1M8OjVjJS1TNVP79r
         wwsbkDSE4+ekEcERIVoW/fmcMrfexR/Bk196EBlc=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089
Date:   Sun,  2 Jan 2022 23:11:23 +0200
Message-Id: <20220102211124.18435-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
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
 .../bindings/regulator/maxim,max20086.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20086.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml b/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
new file mode 100644
index 000000000000..4663716e47a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
@@ -0,0 +1,116 @@
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
+    required:
+      - OUT1
+      - OUT2
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
+              - maxim,max20086
+              - maxim,max20087
+    then:
+      properties:
+        regulators:
+          required:
+            - OUT3
+            - OUT4
+    else:
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

