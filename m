Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30048C95A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355625AbiALR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:27:59 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47014 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348497AbiALR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:27:43 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:662a:d95e:24d7:7832])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 820F7D88;
        Wed, 12 Jan 2022 18:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642008460;
        bh=xySexMy+FThkkjSsUSlMiT47Fe8ImvunotezqPmdgSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kL2JjzfFBrOfm/+6BRiTu5qIWeuDapiNQwPUcNORMTBuGP/TKdaZicUT4ZzgjcZRQ
         aKFH2I9r646MFBzzGZuoT5HR/cUE9OOb2SU2/Tf1qixnqAt2F5vDJvj6I2pWv3mA4N
         JRIfPDyof98nrZVIimMZwVHJewncXpwqRIVO7zXw=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, mchehab@kernel.org,
        dave.stevenson@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, naush@raspberrypi.com,
        lukasz@jany.st, devicetree@vger.kernel.org,
        jeanmichel.hautbois@ideasonboard.com
Subject: [RFC PATCH 1/3] media: dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Wed, 12 Jan 2022 18:27:18 +0100
Message-Id: <20220112172719.1178446-2-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112172719.1178446-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220112172719.1178446-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the dt-bindinds documentation for bcm2835 CCP2/CSI2 camera
interface. Also add a MAINTAINERS entry for it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
Dave: I assumed you were the maintainer for this file, as I based it on the
bcm2835-unicam.txt file. Are  you happy to be added directly as the
maintainer, or should this be specified as "Raspberry Pi Kernel
Maintenance <kernel-list@raspberrypi.com>"
---
 .../bindings/media/brcm,bcm2835-unicam.yaml   | 103 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml

diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
new file mode 100644
index 000000000000..1427514142cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM283x Camera Interface (Unicam)
+
+maintainers:
+  - Dave Stevenson <dave.stevenson@raspberrypi.com>
+
+description: |-
+  The Unicam block on BCM283x SoCs is the receiver for either
+  CSI-2 or CCP2 data from image sensors or similar devices.
+
+  The main platform using this SoC is the Raspberry Pi family of boards.
+  On the Pi the VideoCore firmware can also control this hardware block,
+  and driving it from two different processors will cause issues.
+  To avoid this, the firmware checks the device tree configuration
+  during boot. If it finds device tree nodes called csi0 or csi1 then
+  it will stop the firmware accessing the block, and it can then
+  safely be used via the device tree binding.
+
+properties:
+  compatible:
+    const: brcm,bcm2835-unicam
+
+  reg:
+    description:
+      physical base address and length of the register sets for the device.
+    maxItems: 1
+
+  interrupts:
+    description: the IRQ line for this Unicam instance.
+    maxItems: 1
+
+  clocks:
+    description: |-
+      list of clock specifiers, corresponding to entries in clock-names
+      property.
+
+  clock-names:
+    items:
+      - const: lp
+      - const: vpu
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: False
+
+examples:
+  - |
+    csi1: csi1@7e801000 {
+        compatible = "brcm,bcm2835-unicam";
+        reg = <0x7e801000 0x800>,
+              <0x7e802004 0x4>;
+        interrupts = <2 7>;
+        clocks = <&clocks BCM2835_CLOCK_CAM1>,
+                 <&firmware_clocks 4>;
+        clock-names = "lp", "vpu";
+        port {
+                csi1_ep: endpoint {
+                        remote-endpoint = <&tc358743_0>;
+                        data-lanes = <1 2>;
+                };
+        };
+    };
+
+    i2c0: i2c@7e205000 {
+        tc358743: csi-hdmi-bridge@0f {
+            compatible = "toshiba,tc358743";
+            reg = <0x0f>;
+            clocks = <&tc358743_clk>;
+            clock-names = "refclk";
+
+            tc358743_clk: bridge-clk {
+                    compatible = "fixed-clock";
+                    #clock-cells = <0>;
+                    clock-frequency = <27000000>;
+            };
+
+            port {
+                    tc358743_0: endpoint {
+                            remote-endpoint = <&csi1_ep>;
+                            clock-lanes = <0>;
+                            data-lanes = <1 2>;
+                            clock-noncontinuous;
+                            link-frequencies =
+                                /bits/ 64 <297000000>;
+                    };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 269aa4d6b94a..7484255cad31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3653,6 +3653,12 @@ N:	bcm113*
 N:	bcm216*
 N:	kona
 
+BROADCOM BCM2835 CAMERA DRIVER
+M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
+
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-- 
2.32.0

