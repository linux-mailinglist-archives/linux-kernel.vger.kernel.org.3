Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333A56A46B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiGGNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiGGNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13A2CC9E;
        Thu,  7 Jul 2022 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F067C621E7;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ED0C341E6;
        Thu,  7 Jul 2022 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=Ia6jI+DqMUDPnccmhs0eEJMa39QRSyf+JZr/s8EUAjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/OUqa3065cf3exLLy6Esk9E0+dhYkbR8uhnlBsHKSlBOdNwajYr74BBE/ziEB74F
         mRiUu+qDAAUeN6DBUXe3Ad+Jo3FK13FPZhdBidoZ7uKeMlcpYk6kF5Gs6G/1frS6um
         fbT4h1cl8GTZQPJhdV3aMmkaxPxZ2ebFwKfvirD4WyuQo2wONIrtgG3DPyK1hJf1fx
         /OpcMUG4mnGKJOx+RbYh4Lgg8OsQS3eat1xcvUMqFjmEkBgkf7FQcV0K9zYxAlkd8d
         U71b7XXBVKmvzvQ7GInUKLW6TIgKcrKrjtiCJ0vQMVuFX92SEMAah5edbiGQcWybsB
         kabWrIllKbaAw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr4-0000wT-Kc; Thu, 07 Jul 2022 15:47:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 12/30] dt-bindings: phy: add QMP PCIe PHY schema
Date:   Thu,  7 Jul 2022 15:47:07 +0200
Message-Id: <20220707134725.3512-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134725.3512-1-johan+linaro@kernel.org>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PHY DT schema is getting unwieldy. Break out the PCIe PHY
binding in a separate file.

Add an example node based on a cleaned up version of sm8250.dtsi.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 203 ++++++++++++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  66 ------
 2 files changed, 203 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
new file mode 100644
index 000000000000..ec5f83878a2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,qmp-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (PCIe)
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
+    enum:
+      - qcom,ipq6018-qmp-pcie-phy
+      - qcom,ipq8074-qmp-pcie-phy
+      - qcom,msm8998-qmp-pcie-phy
+      - qcom,sc8180x-qmp-pcie-phy
+      - qcom,sdm845-qhp-pcie-phy
+      - qcom,sdm845-qmp-pcie-phy
+      - qcom,sdx55-qmp-pcie-phy
+      - qcom,sm8250-qmp-gen3x1-pcie-phy
+      - qcom,sm8250-qmp-gen3x2-pcie-phy
+      - qcom,sm8250-qmp-modem-pcie-phy
+      - qcom,sm8450-qmp-gen3x1-pcie-phy
+      - qcom,sm8450-qmp-gen4x2-pcie-phy
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
+    minItems: 2
+    maxItems: 4
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
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
+    description: single PHY-provider child node
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
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: ref
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8180x-qmp-pcie-phy
+              - qcom,sdm845-qhp-pcie-phy
+              - qcom,sdm845-qmp-pcie-phy
+              - qcom,sdx55-qmp-pcie-phy
+              - qcom,sm8250-qmp-gen3x1-pcie-phy
+              - qcom,sm8250-qmp-gen3x2-pcie-phy
+              - qcom,sm8250-qmp-modem-pcie-phy
+              - qcom,sm8450-qmp-gen3x1-pcie-phy
+              - qcom,sm8450-qmp-gen4x2-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: ref
+            - const: refgen
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: phy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
+    phy-wrapper@1c0e000 {
+        compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy";
+        reg = <0x01c0e000 0x1c0>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x01c0e000 0x1000>;
+
+        clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_WIGIG_CLKREF_EN>,
+                 <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
+        clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+        resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+        reset-names = "phy";
+
+        vdda-phy-supply = <&vreg_l10c_0p88>;
+        vdda-pll-supply = <&vreg_l6b_1p2>;
+
+        phy@200 {
+            reg = <0x200 0x170>,
+                  <0x400 0x200>,
+                  <0xa00 0x1f0>,
+                  <0x600 0x170>,
+                  <0x800 0x200>,
+                  <0xe00 0xf4>;
+
+            clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+            clock-names = "pipe0";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_1_pipe_clk";
+
+            #phy-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 5fd716c6412f..897dcd4f7dc9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -17,27 +17,20 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq6018-qmp-usb3-phy
-      - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8996-qmp-usb3-phy
-      - qcom,msm8998-qmp-pcie-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,msm8998-qmp-usb3-phy
       - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc7180-qmp-usb3-phy
-      - qcom,sc8180x-qmp-pcie-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8180x-qmp-usb3-phy
       - qcom,sc8280xp-qmp-ufs-phy
-      - qcom,sdm845-qhp-pcie-phy
-      - qcom,sdm845-qmp-pcie-phy
       - qcom,sdm845-qmp-ufs-phy
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
-      - qcom,sdx55-qmp-pcie-phy
       - qcom,sdx55-qmp-usb3-uni-phy
       - qcom,sdx65-qmp-usb3-uni-phy
       - qcom,sm6115-qmp-ufs-phy
@@ -45,17 +38,12 @@ properties:
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
-      - qcom,sm8250-qmp-gen3x1-pcie-phy
-      - qcom,sm8250-qmp-gen3x2-pcie-phy
-      - qcom,sm8250-qmp-modem-pcie-phy
       - qcom,sm8250-qmp-ufs-phy
       - qcom,sm8250-qmp-usb3-phy
       - qcom,sm8250-qmp-usb3-uni-phy
       - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
-      - qcom,sm8450-qmp-gen3x1-pcie-phy
-      - qcom,sm8450-qmp-gen4x2-pcie-phy
       - qcom,sm8450-qmp-ufs-phy
       - qcom,sm8450-qmp-usb3-phy
 
@@ -171,7 +159,6 @@ allOf:
             enum:
               - qcom,ipq8074-qmp-usb3-phy
               - qcom,msm8996-qmp-usb3-phy
-              - qcom,msm8998-qmp-pcie-phy
               - qcom,msm8998-qmp-usb3-phy
     then:
       properties:
@@ -240,59 +227,6 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,ipq6018-qmp-pcie-phy
-              - qcom,ipq8074-qmp-pcie-phy
-    then:
-      properties:
-        clocks:
-          maxItems: 2
-        clock-names:
-          items:
-            - const: aux
-            - const: cfg_ahb
-        resets:
-          maxItems: 2
-        reset-names:
-          items:
-            - const: phy
-            - const: common
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8180x-qmp-pcie-phy
-              - qcom,sdm845-qhp-pcie-phy
-              - qcom,sdm845-qmp-pcie-phy
-              - qcom,sdx55-qmp-pcie-phy
-              - qcom,sm8250-qmp-gen3x1-pcie-phy
-              - qcom,sm8250-qmp-gen3x2-pcie-phy
-              - qcom,sm8250-qmp-modem-pcie-phy
-              - qcom,sm8450-qmp-gen3x1-pcie-phy
-              - qcom,sm8450-qmp-gen4x2-pcie-phy
-    then:
-      properties:
-        clocks:
-          maxItems: 4
-        clock-names:
-          items:
-            - const: aux
-            - const: cfg_ahb
-            - const: ref
-            - const: refgen
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: phy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
   - if:
       properties:
         compatible:
-- 
2.35.1

