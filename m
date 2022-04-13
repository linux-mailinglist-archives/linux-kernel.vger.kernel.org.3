Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391BE4FF3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiDMJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiDMJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:04 -0400
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012055BE8;
        Wed, 13 Apr 2022 02:43:43 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 23D9hSY5001550; Wed, 13 Apr 2022 18:43:28 +0900
X-Iguazu-Qid: 34trQigfs8YEx5u9D9
X-Iguazu-QSIG: v=2; s=0; t=1649843008; q=34trQigfs8YEx5u9D9; m=1OveN9GVe/qWVmHsjdWgkGCN9AjcJcafsCG3VZfEI68=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 23D9hR5T026553
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 18:43:28 +0900
X-SA-MID: 2335259
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 1/5] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
Date:   Wed, 13 Apr 2022 18:41:59 +0900
X-TSB-HOP2: ON
Message-Id: <20220413094203.25714-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the Device Tree binding documentation that allows to describe
the Video Input Interface found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/media/toshiba,visconti-viif.yaml | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml

diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
new file mode 100644
index 000000000..848ea5019
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |
+  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI CSI2 video stream,
+  processes the stream with embedded image signal processor (L1ISP, L2ISP), then stores pictures to main memory.
+
+properties:
+  compatible:
+    const: toshiba,visconti-viif
+
+  reg:
+    items:
+      - description: registers for capture control
+      - description: registers for CSI2 receiver control
+
+  interrupts:
+    items:
+      - description: Sync Interrupt
+      - description: Status (Error) Interrupt
+      - description: CSI2 Receiver Interrupt
+      - description: L1ISP Interrupt
+
+  index:
+    enum: [0, 1]
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: Input port node, single endpoint describing the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            description: VIIF supports 2 or 4 data lines
+            items:
+              minItems: 1
+              maxItems: 4
+              items:
+                - const: 1
+                - const: 2
+                - const: 3
+                - const: 4
+          clock-lanes:
+            description: VIIF supports 1 clock line
+            const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        viif0: viif@1c000000 {
+            compatible = "toshiba,visconti-viif";
+            reg = <0 0x1c000000 0 0x6000>,
+                  <0 0x1c008000 0 0x400>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+            index = <0>;
+            status = "disabled";
+
+            port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi_in0: endpoint {
+                    remote-endpoint = <&imx219_out0>;
+                    bus-type = <4>;
+                    data-lanes = <1 2>;
+                    clock-lanes = <0>;
+                    clock-noncontinuous;
+                    link-frequencies = /bits/ 64 <456000000>;
+                };
+            };
+        };
+    };
+
-- 
2.17.1


