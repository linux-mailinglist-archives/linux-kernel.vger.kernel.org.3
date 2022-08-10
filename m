Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3760D58EDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiHJOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHJOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:04:39 -0400
X-Greylist: delayed 1825 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 07:04:36 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1516.securemx.jp [210.130.202.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D76D559;
        Wed, 10 Aug 2022 07:04:36 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 27ADYBNI014344; Wed, 10 Aug 2022 22:34:11 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 27ADXV2E006012; Wed, 10 Aug 2022 22:33:31 +0900
X-Iguazu-Qid: 34trhqSYHUnS2xZcVE
X-Iguazu-QSIG: v=2; s=0; t=1660138411; q=34trhqSYHUnS2xZcVE; m=T9zyOExsCPfTIf8vq2yxd455Rouk8lF1K/aw6XrNs7I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1512) id 27ADXUhw000538
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Aug 2022 22:33:30 +0900
X-SA-MID: 40425322
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
Date:   Wed, 10 Aug 2022 22:28:19 +0900
X-TSB-HOP2: ON
Message-Id: <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Chengelog v2:
- no change

Changelog v3:
- no change
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


