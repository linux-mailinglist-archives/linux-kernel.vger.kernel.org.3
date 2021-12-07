Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD846AFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354980AbhLGB1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:27:37 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37620 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1354920AbhLGB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:27:36 -0500
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="102606246"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2021 10:24:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 17F4C4172F32;
        Tue,  7 Dec 2021 10:24:02 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 1/3] media: dt-bindings: media: Document RZ/G2L CRU block
Date:   Tue,  7 Dec 2021 01:23:49 +0000
Message-Id: <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the CRU block found on Renesas RZ/G2L SoC's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
new file mode 100644
index 000000000000..7b2835810516
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -0,0 +1,227 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2021 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
+  capabilities for the Renesas RZ/G2L family of devices.
+
+  Depending on the instance the Image Processing input is connected to
+  external SoC pins or to a CSI-2 receiver.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
+          - const: renesas,rzg2l-cru
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: csi2_link_int
+      - const: image_conv_int
+      - const: image_conv_err_int
+      - const: axi_mst_err_int
+
+  clocks:
+    items:
+      - description: Internal clock for connecting CRU and MIPI
+      - description: CRU Main clock
+      - description: CPU Register access clock
+      - description: CRU image transfer clock
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: vclk
+      - const: pclk
+      - const: aclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_CMN_RSTB reset terminal
+      - description: CRU_PRESETN reset terminal
+      - description: CRU_ARESETN reset terminal
+
+  reset-names:
+    items:
+      - const: cmn-rstb
+      - const: presetn
+      - const: aresetn
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing a parallel input source.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              hsync-active: true
+
+              vsync-active: true
+
+              bus-width: true
+
+              data-shift: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing the CSI-2 transmitter.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+
+              data-lanes:
+                maxItems: 1
+
+            required:
+              - clock-lanes
+              - data-lanes
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Output port node, describing the RZ/G2L Image Processing module
+          connected the CSI-2 receiver
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Endpoint connected to CSI2.
+
+        anyOf:
+          - required:
+              - endpoint@0
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input port node, describing the RZ/G2L CSI-2 module connected the
+          Image Processing block.
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Endpoint connected to CSI2.
+
+        anyOf:
+          - required:
+              - endpoint@0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  # Device node example with CSI-2
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cru: video@10830000 {
+            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+            reg = <0x10830000 0x10000>;
+            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "csi2_link_int", "image_conv_int",
+                              "image_conv_err_int", "axi_mst_err_int";
+            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+            clock-names = "sysclk", "vclk", "pclk", "aclk";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
+                     <&cpg R9A07G044_CRU_PRESETN>,
+                     <&cpg R9A07G044_CRU_ARESETN>;
+            reset-names = "cmn-rstb", "presetn", "aresetn";
+
+            ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@1 {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            reg = <1>;
+
+                            csi2_in: endpoint@0 {
+                                    reg = <0>;
+                                    clock-lanes = <0>;
+                                    data-lanes = <1 2>;
+                                    remote-endpoint = <&ov5645_ep>;
+                            };
+                    };
+
+                    port@2 {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            reg = <2>;
+
+                            csi2cru: endpoint@0 {
+                                    reg = <0>;
+                                    remote-endpoint= <&crucsi2>;
+                            };
+                    };
+
+                    port@3 {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            reg = <3>;
+
+                            crucsi2: endpoint@0 {
+                                    reg = <0>;
+                                    remote-endpoint= <&csi2cru>;
+                            };
+                    };
+            };
+    };
-- 
2.17.1

