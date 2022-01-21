Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78B3495BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379437AbiAUISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48760 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbiAUISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:24 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 187F611FB;
        Fri, 21 Jan 2022 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753100;
        bh=RMkljG2wbh8nG/M8yodXcpvMd1LLCeP1314I6J4+NI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHWMElUJFgY/VOtX7h2AlPLDN1iZ2mMfzN4EP863tPr0xQYaEmioC/a7aklkjQ2yW
         Y/SP1ivguhh+G6MGaugkNtMQca6fT/QaTZetZwDc8+6tJ/N0UYMBwL1wyz/gvPnc7o
         MJPTWl/v6Ea8Us233eIcxNrAWDBs/FF8+cN7rPos=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 3/7] media: dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Fri, 21 Jan 2022 09:18:06 +0100
Message-Id: <20220121081810.155500-4-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
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
- in v2: multiple corrections to pass the bot checking as Rob kindly
  told me.
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
index 33f75892f98e..07f238fd5ff9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3679,6 +3679,12 @@ F:	Documentation/media/v4l-drivers/bcm2835-isp.rst
 F:	drivers/staging/vc04_services/bcm2835-isp
 F:	include/uapi/linux/bcm2835-isp.h
 
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

