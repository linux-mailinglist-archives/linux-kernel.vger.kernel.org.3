Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A40587389
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiHAVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiHAVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:47:41 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69B453FA0E;
        Mon,  1 Aug 2022 14:47:39 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,209,1654527600"; 
   d="scan'208";a="129950943"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 06:47:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 44D304108B83;
        Tue,  2 Aug 2022 06:47:34 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] media: dt-bindings: media: Document RZ/G2L CRU
Date:   Mon,  1 Aug 2022 22:47:16 +0100
Message-Id: <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the CRU block found on Renesas RZ/G2L SoC's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC v2 -> v1
* Dropped endpoint stuff from port1 as suggested by Rob
* Updated description for endpoint

RFC v1 -> RFC v2
* Dropped CSI
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
new file mode 100644
index 000000000000..d7389693dae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The CRU image processing module is a data conversion module equipped with pixel
+  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
+  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
+              - renesas,r9a07g054-cru     # RZ/V2L
+          - const: renesas,rzg2l-cru
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: image_conv
+      - const: image_conv_err
+      - const: axi_mst_err
+
+  clocks:
+    items:
+      - description: CRU Main clock
+      - description: CPU Register access clock
+      - description: CRU image transfer clock
+
+  clock-names:
+    items:
+      - const: vclk
+      - const: pclk
+      - const: aclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_PRESETN reset terminal
+      - description: CRU_ARESETN reset terminal
+
+  reset-names:
+    items:
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
+              vsync-active: true
+              bus-width: true
+              data-shift: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input port node, describing the Image Processing module connected to the
+          CSI-2 receiver.
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
+            reg = <0x10830000 0x400>;
+            interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+            clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+            clock-names = "vclk", "pclk", "aclk";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_CRU_PRESETN>,
+                     <&cpg R9A07G044_CRU_ARESETN>;
+            reset-names = "presetn", "aresetn";
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
+                            crucsi2: endpoint@0 {
+                                    reg = <0>;
+                                    remote-endpoint= <&csi2cru>;
+                            };
+                    };
+            };
+    };
-- 
2.25.1

