Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D636500473
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiDNCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiDNCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:55:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9802229B;
        Wed, 13 Apr 2022 19:53:07 -0700 (PDT)
X-UUID: 67c29a9b4f0b4390a3e9127464c07b58-20220414
X-UUID: 67c29a9b4f0b4390a3e9127464c07b58-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1246117363; Thu, 14 Apr 2022 10:53:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Apr 2022 10:53:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 10:53:00 +0800
From:   Nick Fan <Nick.Fan@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <fshao@chromium.org>,
        <wenst@chromium.org>, <alyssa.rosenzweig@collabora.com>,
        <nick.fan@mediatek.com>, Nick Fan <Nick.Fan@mediatek.com>
Subject: [PATCH v6 1/2] dt-bindings: Add DT schema for Arm Mali Valhall GPU
Date:   Thu, 14 Apr 2022 10:50:22 +0800
Message-ID: <20220414025023.11516-1-Nick.Fan@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree schema for Arm Mali Valhall GPU

Define a compatible string for the Mali Valhall GPU
for MediaTek's SoC platform.

Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
---
 .../bindings/gpu/arm,mali-valhall.yaml        | 201 ++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
new file mode 100644
index 000000000000..526384d1e3ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-valhall.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali Valhall GPU
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-mali
+      - const: arm,mali-valhall
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Job interrupt
+      - description: MMU interrupt
+      - description: GPU interrupt
+
+  interrupt-names:
+    items:
+      - const: job
+      - const: mmu
+      - const: gpu
+
+  clocks:
+    minItems: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 5
+
+  mali-supply: true
+  sram-supply: true
+
+  operating-points-v2: true
+  opp-table: true
+
+  "#cooling-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8192-mali
+    then:
+      properties:
+        power-domains:
+          minItems: 5
+          maxItems: 5
+
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+            - const: core3
+            - const: core4
+
+      required:
+        - sram-supply
+        - power-domains
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@13000000 {
+        compatible = "mediatek,mt8192-mali", "arm,mali-valhall";
+        reg = <0x13000000 0x4000>;
+        interrupts =
+            <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+            <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+            <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names =
+            "gpu",
+            "mmu",
+            "job";
+
+        clocks = <&mfgcfg 0>;
+
+        power-domains =
+            <&spm 4>,
+            <&spm 5>,
+            <&spm 6>,
+            <&spm 7>,
+            <&spm 8>;
+
+        operating-points-v2 = <&gpu_opp_table>;
+        mali-supply = <&mt6315_7_vbuck1>;
+        sram-supply = <&mt6359_vsram_others_ldo_reg>;
+        gpu_opp_table: opp_table {
+            compatible = "operating-points-v2";
+            opp-shared;
+
+            opp-358000000 {
+                opp-hz = /bits/ 64 <358000000>;
+                opp-microvolt = <606250>, <750000>;
+            };
+
+            opp-399000000 {
+                opp-hz = /bits/ 64 <399000000>;
+                opp-microvolt = <618750>, <750000>;
+            };
+
+            opp-440000000 {
+                opp-hz = /bits/ 64 <440000000>;
+                opp-microvolt = <631250>, <750000>;
+            };
+
+            opp-482000000 {
+                opp-hz = /bits/ 64 <482000000>;
+                opp-microvolt = <643750>, <750000>;
+            };
+
+            opp-523000000 {
+                opp-hz = /bits/ 64 <523000000>;
+                opp-microvolt = <656250>, <750000>;
+            };
+
+            opp-564000000 {
+                opp-hz = /bits/ 64 <564000000>;
+                opp-microvolt = <668750>, <750000>;
+            };
+
+            opp-605000000 {
+                opp-hz = /bits/ 64 <605000000>;
+                opp-microvolt = <681250>, <750000>;
+            };
+
+            opp-647000000 {
+                opp-hz = /bits/ 64 <647000000>;
+                opp-microvolt = <693750>, <750000>;
+            };
+
+            opp-688000000 {
+                opp-hz = /bits/ 64 <688000000>;
+                opp-microvolt = <706250>, <750000>;
+            };
+
+            opp-724000000 {
+                opp-hz = /bits/ 64 <724000000>;
+                opp-microvolt = <725000>, <750000>;
+            };
+
+            opp-748000000 {
+                opp-hz = /bits/ 64 <748000000>;
+                opp-microvolt = <737500>, <750000>;
+            };
+
+            opp-772000000 {
+                opp-hz = /bits/ 64 <772000000>;
+                opp-microvolt = <750000>, <750000>;
+            };
+
+            opp-795000000 {
+                opp-hz = /bits/ 64 <795000000>;
+                opp-microvolt = <762500>, <762500>;
+            };
+
+            opp-819000000 {
+                opp-hz = /bits/ 64 <819000000>;
+                opp-microvolt = <775000>, <775000>;
+            };
+
+            opp-843000000 {
+                opp-hz = /bits/ 64 <843000000>;
+                opp-microvolt = <787500>, <787500>;
+            };
+
+            opp-866000000 {
+                opp-hz = /bits/ 64 <866000000>;
+                opp-microvolt = <800000>, <800000>;
+            };
+        };
+    };
+...
-- 
2.18.0

