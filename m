Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED8515EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiD3QTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiD3QTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:19:05 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A5932EC7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:15:43 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 918503F720;
        Sat, 30 Apr 2022 18:15:39 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: display: msm: Add binding for MSM8996 DPU
Date:   Sat, 30 Apr 2022 18:15:25 +0200
Message-Id: <20220430161529.605843-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yaml binding for MSM8996 DPU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/display/msm/dpu-msm8996.yaml     | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-msm8996.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-msm8996.yaml b/Documentation/devicetree/bindings/display/msm/dpu-msm8996.yaml
new file mode 100644
index 000000000000..10b02423224d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/dpu-msm8996.yaml
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/dpu-msm8996.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display DPU dt properties for MSM8996 target
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that
+  encapsulates sub-blocks like DPU display controller, DSI interfaces, etc.
+  Device tree bindings of MDSS and DPU are mentioned for MSM8996 target.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,msm8996-mdss
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: mdss
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Display AHB clock
+      - description: Display core clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  "#interrupt-cells":
+    const: 1
+
+  iommus:
+    items:
+      - description: Phandle to mdp_smmu node with SID mask for Hard-Fail port0
+
+  ranges: true
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    description: Node containing the properties of DPU.
+
+    properties:
+      compatible:
+        items:
+          - const: qcom,msm8996-dpu
+
+      reg:
+        items:
+          - description: Address offset and size for mdp register set
+          - description: Address offset and size for vbif register set
+          - description: Address offset and size for non-realtime vbif register set
+
+      reg-names:
+        items:
+          - const: mdp
+          - const: vbif
+          - const: vbif_nrt
+
+      clocks:
+        items:
+          - description: Display ahb clock
+          - description: Display axi clock
+          - description: Display core clock
+          - description: Display iommu clock
+          - description: Display vsync clock
+
+      clock-names:
+        items:
+          - const: iface
+          - const: bus
+          - const: core
+          - const: iommu
+          - const: vsync
+
+      interrupts:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+      operating-points-v2: true
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+        description: |
+          Contains the list of output ports from DPU device. These ports
+          connect to interfaces that are external to the DPU hardware,
+          such as DSI, DP etc. Each output port contains an endpoint that
+          describes how it is connected to an external interface.
+
+        properties:
+          port@0:
+            $ref: /schemas/graph.yaml#/properties/port
+            description: DPU_INTF3 (HDMI)
+
+          port@1:
+            $ref: /schemas/graph.yaml#/properties/port
+            description: DPU_INTF1 (DSI0)
+
+        required:
+          - port@0
+          - port@1
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - clocks
+      - interrupts
+      - power-domains
+      - operating-points-v2
+      - ports
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - power-domains
+  - clocks
+  - interrupts
+  - interrupt-controller
+  - iommus
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    mdss: display-subsystem@900000 {
+        compatible = "qcom,msm8996-mdss";
+        reg = <0x00900000 0x1000>;
+        reg-names = "mdss";
+
+        power-domains = <&mmcc MDSS_GDSC>;
+
+        clocks = <&mmcc MDSS_AHB_CLK>, <&mmcc MDSS_MDP_CLK>;
+        clock-names = "iface", "core";
+
+        assigned-clocks = <&mmcc MDSS_MDP_CLK>;
+        assigned-clock-rates = <300000000>;
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&mdp_smmu 0>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@901000 {
+            compatible = "qcom,msm8996-dpu";
+            reg = <0x00901000 0x90000>,
+                  <0x009b0000 0x1040>,
+                  <0x009b8000 0x1040>;
+            reg-names = "mdp", "vbif", "vbif_nrt";
+
+            clocks = <&mmcc MDSS_AHB_CLK>,
+              <&mmcc MDSS_AXI_CLK>,
+              <&mmcc MDSS_MDP_CLK>,
+              <&mmcc SMMU_MDP_AXI_CLK>,
+              <&mmcc MDSS_VSYNC_CLK>;
+            clock-names = "iface", "bus", "core", "iommu", "vsync";
+
+            assigned-clocks = <&mmcc MDSS_MDP_CLK>,
+                  <&mmcc MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <412500000>, <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmpd MSM8996_VDDMX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                dpu_intf3_out: endpoint {
+                  remote-endpoint = <&hdmi_in>;
+                };
+              };
+
+              port@1 {
+                reg = <1>;
+                dpu_intf1_out: endpoint {
+                  remote-endpoint = <&dsi0_in>;
+                };
+              };
+            };
+        };
+    };
+...
-- 
2.35.2

