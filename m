Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C244495790
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiAUBGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:06:10 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:18363 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229499AbiAUBGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:06:09 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107143417"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jan 2022 10:06:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E528417762A;
        Fri, 21 Jan 2022 10:06:01 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
Date:   Fri, 21 Jan 2022 01:05:40 +0000
Message-Id: <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the CSI-2 block which is part of CRU found in Renesas
RZ/G2L SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Geert/All,

vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
pm_runtime. pclk clock is necessary for register access where as vclk clock
is only used for calculations. So would you suggest passing vclk as part of
clocks (as currently implemented) or pass the vclk clock rate as a dt property.

Cheers,
Prabhakar

v1->v2
* New patch
---
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
new file mode 100644
index 000000000000..bf907768a157
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L MIPI CSI-2 receiver
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The RZ/G2L CSI-2 receiver device provides MIPI CSI-2 capabilities for the
+  Renesas RZ/G2L family of devices. MIPI CSI-2 is part of the CRU block which
+  is used in conjunction with the Image Processing module, which provides the
+  video capture capabilities.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-csi2     # RZ/G2{L,LC}
+          - const: renesas,rzg2l-csi2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: csi2_link
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
+    items:
+      - const: cmn-rstb
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
2.17.1

