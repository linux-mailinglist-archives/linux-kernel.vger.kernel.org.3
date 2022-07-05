Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40485666EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiGEJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4147266B;
        Tue,  5 Jul 2022 02:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A498B816CA;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27361C341D2;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=FQcNecU5EN3xvEBaRrDBNhVj2QdH74mRC4IAq8Yjrog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGlfmyCGrxx0Bsgsr3Vho2ChSD5Ptb1KUzM+seaZ+hyhCC/2EZ/T1ykQyQx2lGqQy
         3+VwfNHui4wJoqPynUjzjuyv6Qws0EG3vGkYctg9KVrbO3ht/8tySaiNRNSSx0aDQh
         d5CMvjj8T6917jYpmSKK9e2T/ypakDQFE44xto4T2gl/o8OHqx6Gv3cvClz/FoPnLv
         waWOnyVUbT1yYENexm2zEudDB3+/tjwStpfthXV9yCQMXWwZxCjdX4s8GV1En0Cntb
         0HblG+PpCdFzxiLXeqO0bCMdPnmaiXnrAg81m0sqJMjzF85ExIxUZATqK8z3s0W16T
         9L3kJLu/pOPUg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004X6-1Z; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/43] dt-bindings: phy: qcom,qmp: split out msm8996-qmp-pcie-phy
Date:   Tue,  5 Jul 2022 11:42:02 +0200
Message-Id: <20220705094239.17174-7-johan+linaro@kernel.org>
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

The QMP PHY DT schema is getting unwieldy. Break out the odd-bird
msm8996-qmp-pcie-phy which is the only QMP PHY that uses separate
"per-lane" nodes.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 114 ++++++++++++++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  32 -----
 2 files changed, 114 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
new file mode 100644
index 000000000000..14fd86fd91ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,msm8996-qmp-pcie-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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
+              - qcom,msm8996-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: ref
+        resets:
+          items:
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
+            - description: PHY's ahb cfg block reset.
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+            - const: cfg
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index bca006e41821..7a76fd286cee 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -21,7 +21,6 @@ properties:
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
-      - qcom,msm8996-qmp-pcie-phy
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8996-qmp-usb3-phy
       - qcom,msm8998-qmp-pcie-phy
@@ -184,37 +183,6 @@ allOf:
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
-          items:
-            - description: PHY aux clock.
-            - description: PHY config clock.
-            - description: 19.2 MHz ref clock.
-        clock-names:
-          items:
-            - const: aux
-            - const: cfg_ahb
-            - const: ref
-        resets:
-          items:
-            - description: Reset of PHY block.
-            - description: PHY common block reset.
-            - description: PHY's ahb cfg block reset.
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

