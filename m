Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E4574E39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiGNMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiGNMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1998201BD;
        Thu, 14 Jul 2022 05:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37AE3B824F1;
        Thu, 14 Jul 2022 12:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14516C341CE;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=lSJ9xBkkNJpW7UWc1fqDijAGAp3EYYVJ/ShIuYKYdIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWyNevUAYWvxNhRNAxuNENqp68UbzhN7zGQZSe5hWS/ub6zVP2CegsCE0bNHvk/Rs
         VKn9OL5HoN8UATGsANacS2ea0o3Tnh2FdPI6q0Y6V5hpWABmSeoj0x2kJwFervTmTq
         /dbOvKiBYZ4mS9VmhJ+WJ3yHnQD7c4Qmf0VS08T4UwGjf7vjYOc0yQ2lMkxgFuqbC/
         H89k7pWN+4ruXKvsy8EutYrNhYqGYUGgLI0cUXV7YfvpTEU8S4yuacdjeQPZC0Q6ng
         CD0UQnynowqIwUPbzGzroqvNUO4vvYT3+iBSWnRGl+uRMfr7pfrp+7Cfvd5fI1Z9TR
         92pJPNZMgC1VA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCP-0007DL-Dm; Thu, 14 Jul 2022 14:44:09 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/30] dt-bindings: phy: add qcom,msm8996-qmp-pcie-phy schema
Date:   Thu, 14 Jul 2022 14:43:11 +0200
Message-Id: <20220714124333.27643-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714124333.27643-1-johan+linaro@kernel.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PHY DT schema is getting unwieldy. Break out the odd-bird
msm8996-qmp-pcie-phy which is the only QMP PHY that uses separate
"per-lane" nodes.

Add an example node based on a cleaned up version of msm8996.dtsi.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 146 ++++++++++++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  26 ----
 2 files changed, 146 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
new file mode 100644
index 000000000000..accbcb8b5c6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,msm8996-qmp-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (MSM8996 PCIe)
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  QMP PHY controller supports physical layer functionality for a number of
+  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
+
+properties:
+  compatible:
+    const: qcom,msm8996-qmp-pcie-phy
+
+  reg:
+    items:
+      - description: serdes
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+      - const: ref
+
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: phy
+      - const: common
+      - const: cfg
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  vddp-ref-clk-supply: true
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description: one child node per PHY provided by this block
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    pcie_phy: phy-wrapper@34000 {
+        compatible = "qcom,msm8996-qmp-pcie-phy";
+        reg = <0x34000 0x488>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x34000 0x4000>;
+
+        clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_CLKREF_CLK>;
+        clock-names = "aux", "cfg_ahb", "ref";
+
+        resets = <&gcc GCC_PCIE_PHY_BCR>,
+                 <&gcc GCC_PCIE_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+        reset-names = "phy", "common", "cfg";
+
+        vdda-phy-supply = <&vreg_l28a_0p925>;
+        vdda-pll-supply = <&vreg_l12a_1p8>;
+
+        pciephy_0: phy@1000 {
+            reg = <0x1000 0x130>,
+                  <0x1200 0x200>,
+                  <0x1400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+            clock-names = "pipe0";
+            resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+            reset-names = "lane0";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_0_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+
+        pciephy_1: phy@2000 {
+            reg = <0x2000 0x130>,
+                  <0x2200 0x200>,
+                  <0x2400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+            clock-names = "pipe1";
+            resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+            reset-names = "lane1";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_1_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+
+        pciephy_2: phy@3000 {
+            reg = <0x3000 0x130>,
+                  <0x3200 0x200>,
+                  <0x3400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+            clock-names = "pipe2";
+            resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+            reset-names = "lane2";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_2_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 693cec10d7d6..90d703548913 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -22,7 +22,6 @@ properties:
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
-      - qcom,msm8996-qmp-pcie-phy
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8996-qmp-usb3-phy
       - qcom,msm8998-qmp-pcie-phy
@@ -166,31 +165,6 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-qmp-pcie-phy
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          items:
-            - const: aux
-            - const: cfg_ahb
-            - const: ref
-        resets:
-          maxItems: 3
-        reset-names:
-          items:
-            - const: phy
-            - const: common
-            - const: cfg
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
   - if:
       properties:
         compatible:
-- 
2.35.1

