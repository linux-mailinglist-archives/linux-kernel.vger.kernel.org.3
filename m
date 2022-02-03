Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77C74A8AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbiBCRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:51:34 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59048 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353089AbiBCRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:30 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 91859D88;
        Thu,  3 Feb 2022 18:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910625;
        bh=pOuthGxGMpzOZMVoj+0IAETXXuv85t6W6FbwTwO/s1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvoBHIOrb/XbhdH4kXqJrsQ4wD1Df0hSyANBC/gh0eA7o1oenwUYnTX0j1eEf90Kl
         FCRB8eH79XReML2mk35ugUdb+j1DU2xN72tNHP3MwT8mTWTaI5TobeyX2aMY4X21TK
         FMpCJpOxs3VziHfyw3pqa9EFKYwW6I3DWmU/I6Z4=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 03/12] dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Thu,  3 Feb 2022 18:50:00 +0100
Message-Id: <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
camera interface. Also add a MAINTAINERS entry for it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

---
v4:
- make MAINTAINERS its own patch
- describe the reg and clocks correctly
- use a vendor entry for the number of data lanes
---
 .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml

diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
new file mode 100644
index 000000000000..0725a0267c60
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM283x Camera Interface (Unicam)
+
+maintainers:
+  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+
+description: |-
+  The Unicam block on BCM283x SoCs is the receiver for either
+  CSI-2 or CCP2 data from image sensors or similar devices.
+
+  The main platform using this SoC is the Raspberry Pi family of boards.
+  On the Pi the VideoCore firmware can also control this hardware block,
+  and driving it from two different processors will cause issues.
+  To avoid this, the firmware checks the device tree configuration
+  during boot. If it finds device tree nodes starting by csi then
+  it will stop the firmware accessing the block, and it can then
+  safely be used via the device tree binding.
+
+properties:
+  compatible:
+    const: brcm,bcm2835-unicam
+
+  reg:
+    items:
+      - description: Unicam block.
+      - description: Clock Manager Image (CMI) block.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Clock to drive the LP state machine of Unicam.
+      - description: Clock for the vpu (core clock).
+
+  clock-names:
+    items:
+      - const: lp
+      - const: vpu
+
+  power-domains:
+    items:
+      - description: Unicam power domain
+
+  brcm,num-data-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 2, 4 ]
+    description: Number of data lanes on the csi bus
+
+  port:
+    additionalProperties: false
+    $ref: /schemas/graph.yaml#/$defs/port-base
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes: true
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - brcm,num-data-lanes
+  - port
+
+additionalProperties: False
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/raspberrypi-power.h>
+    csi1: csi@7e801000 {
+        compatible = "brcm,bcm2835-unicam";
+        reg = <0x7e801000 0x800>,
+              <0x7e802004 0x4>;
+        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clocks BCM2835_CLOCK_CAM1>,
+                 <&firmware_clocks 4>;
+        clock-names = "lp", "vpu";
+        power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
+        brcm,num-data-lanes = <2>;
+        port {
+                csi1_ep: endpoint {
+                        remote-endpoint = <&imx219_0>;
+                        data-lanes = <1 2>;
+                        link-frequencies = /bits/ 64 <456000000>;
+                };
+        };
+    };
+...
-- 
2.32.0

