Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388D587386
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiHAVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHAVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:47:36 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F18043DF01;
        Mon,  1 Aug 2022 14:47:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,209,1654527600"; 
   d="scan'208";a="129950932"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 06:47:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D56C34108B8D;
        Tue,  2 Aug 2022 06:47:28 +0900 (JST)
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
Subject: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
Date:   Mon,  1 Aug 2022 22:47:15 +0100
Message-Id: <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document the CSI-2 block which is part of CRU found in Renesas
RZ/G2L SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC v2 -> v1
* Fixed review comments pointed by Rob and Jacopo.

RFC v1 -> RFC v2
* New patch
---
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
new file mode 100644
index 000000000000..f82f88c096df
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
+  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
+  with the Image Processing module, which provides the video capture capabilities.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
+              - renesas,r9a07g054-csi2       # RZ/V2L
+          - const: renesas,rzg2l-csi2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: csi2_link
+
+  clocks:
+    items:
+      - description: Internal clock for connecting CRU and MIPI
+      - description: CRU Main clock
+      - description: CPU Register access clock
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: vclk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_CMN_RSTB reset terminal
+
+  reset-names:
+    const: cmn-rstb
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
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
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
+
+            required:
+              - clock-lanes
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Output port node, Image Processing block connected to the CSI-2 receiver.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    csi20: csi2@10830400 {
+            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
+            reg = <0x10830400 0xfc00>;
+            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
+            clock-names = "sysclk", "vclk", "pclk";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_CRU_CMN_RSTB>;
+            reset-names = "cmn-rstb";
+
+            ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                            reg = <0>;
+
+                            csi2_in: endpoint {
+                                    clock-lanes = <0>;
+                                    data-lanes = <1 2>;
+                                    remote-endpoint = <&ov5645_ep>;
+                            };
+                    };
+
+                    port@1 {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            reg = <1>;
+
+                            csi2cru: endpoint@0 {
+                                    reg = <0>;
+                                    remote-endpoint = <&crucsi2>;
+                            };
+                    };
+            };
+    };
-- 
2.25.1

