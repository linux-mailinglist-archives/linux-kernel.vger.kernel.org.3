Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA835666FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGEJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiGEJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C812D26;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD92D61926;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11BC36B16;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=UOvgIt68/j0BXReTfByF9D0uM5TktGkUFQmmNBsctqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1x0H5uW3YjeOMaRVvDxzSB9awWtwLtO0hLCgNcKXaf+GSfvv0b74qzug73eAW9/p
         fmWIakJGJ6CDe7gAnwGfwtoMHEjppVAnkWnZ5GecV3pyt4mF8lCOaWi17JD2wOeIjV
         Bj6W8eSrYMNesKhvG32keynjw2FRhakWbBUTyd0TponsMHJAolFWaBMt+Er52uG53d
         PpLQ6nJv/mnxzddlz3ajzPNdNMwNshJH7cQ1bdky4QUEur1N/uPjmF77Kpm7c8p/nm
         9MHoDz8YtH3zRjudiwo8JRPHr1Kmeu2AIJnAIhtHCVzSRjDB59ovInvN9w23w0/9bi
         Eyd9caIItJB2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Xm-9r; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 20/43] dt-bindings: phy: qcom,qmp: split out UFS PHY binding
Date:   Tue,  5 Jul 2022 11:42:16 +0200
Message-Id: <20220705094239.17174-21-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
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

The QMP PHY DT schema is getting unwieldy. Break out the UFS PHY
binding in a separate file.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  65 --------
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index f416a1a53a3f..04c24f8e4526 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -19,32 +19,21 @@ properties:
     enum:
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
-      - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8996-qmp-usb3-phy
-      - qcom,msm8998-qmp-ufs-phy
       - qcom,msm8998-qmp-usb3-phy
       - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc7180-qmp-usb3-phy
-      - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8180x-qmp-usb3-phy
-      - qcom,sc8280xp-qmp-ufs-phy
-      - qcom,sdm845-qmp-ufs-phy
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sdx55-qmp-usb3-uni-phy
       - qcom,sdx65-qmp-usb3-uni-phy
-      - qcom,sm6115-qmp-ufs-phy
-      - qcom,sm6350-qmp-ufs-phy
-      - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
-      - qcom,sm8250-qmp-ufs-phy
       - qcom,sm8250-qmp-usb3-phy
       - qcom,sm8250-qmp-usb3-uni-phy
-      - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
-      - qcom,sm8450-qmp-ufs-phy
       - qcom,sm8450-qmp-usb3-phy
 
   reg:
@@ -202,60 +191,6 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8996-qmp-ufs-phy
-    then:
-      properties:
-        clocks:
-          items:
-            - description: 19.2 MHz ref clock.
-        clock-names:
-          items:
-            - const: ref
-        resets:
-          items:
-            - description: PHY reset in the UFS controller.
-        reset-names:
-          items:
-            - const: ufsphy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8998-qmp-ufs-phy
-              - qcom,sc8180x-qmp-ufs-phy
-              - qcom,sc8280xp-qmp-ufs-phy
-              - qcom,sdm845-qmp-ufs-phy
-              - qcom,sm6350-qmp-ufs-phy
-              - qcom,sm8150-qmp-ufs-phy
-              - qcom,sm8250-qmp-ufs-phy
-    then:
-      properties:
-        clocks:
-          items:
-            - description: 19.2 MHz ref clock.
-            - description: PHY reference aux clock.
-        clock-names:
-          items:
-            - const: ref
-            - const: ref_aux
-        resets:
-          items:
-            - description: PHY reset in the UFS controller.
-        reset-names:
-          items:
-            - const: ufsphy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
new file mode 100644
index 000000000000..4471f1b4fb7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,qmp-ufs-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm QMP PHY controller (UFS)
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
+      - qcom,msm8996-qmp-ufs-phy
+      - qcom,msm8998-qmp-ufs-phy
+      - qcom,sc8180x-qmp-ufs-phy
+      - qcom,sc8280xp-qmp-ufs-phy
+      - qcom,sdm845-qmp-ufs-phy
+      - qcom,sm6115-qmp-ufs-phy
+      - qcom,sm6350-qmp-ufs-phy
+      - qcom,sm8150-qmp-ufs-phy
+      - qcom,sm8250-qmp-ufs-phy
+      - qcom,sm8350-qmp-ufs-phy
+      - qcom,sm8450-qmp-ufs-phy
+
+  reg:
+    minItems: 1
+    items:
+      - description: Address and length of PHY's common serdes block.
+      - description: Address and length of PHY's DP_COM control block.
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
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
+
+  vdda-phy-supply:
+    description:
+      Phandle to a regulator supply to PHY core block.
+
+  vdda-pll-supply:
+    description:
+      Phandle to 1.8V regulator supply to PHY refclk pll block.
+
+  vddp-ref-clk-supply:
+    description:
+      Phandle to a regulator supply to any specific refclk pll block.
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description:
+      Each device node of QMP PHY is required to have as many child nodes as
+      the number of lanes the PHY has.
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
+              - qcom,msm8996-qmp-ufs-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 19.2 MHz ref clock.
+        clock-names:
+          items:
+            - const: ref
+        resets:
+          items:
+            - description: PHY reset in the UFS controller.
+        reset-names:
+          items:
+            - const: ufsphy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc8180x-qmp-ufs-phy
+              - qcom,sc8280xp-qmp-ufs-phy
+              - qcom,sdm845-qmp-ufs-phy
+              - qcom,sm6350-qmp-ufs-phy
+              - qcom,sm8150-qmp-ufs-phy
+              - qcom,sm8250-qmp-ufs-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 19.2 MHz ref clock.
+            - description: PHY reference aux clock.
+        clock-names:
+          items:
+            - const: ref
+            - const: ref_aux
+        resets:
+          items:
+            - description: PHY reset in the UFS controller.
+        reset-names:
+          items:
+            - const: ufsphy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
-- 
2.35.1

