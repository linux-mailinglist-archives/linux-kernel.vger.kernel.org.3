Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9635A6200
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiH3Lbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiH3LaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3E24954;
        Tue, 30 Aug 2022 04:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C15A1B81A5B;
        Tue, 30 Aug 2022 11:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B70C4FF79;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859000;
        bh=dxZsJuh3PG3/c3VEzfzAsjGBppC43LgJYwjJvp4caR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOGecBe3N5OMjqcFonIenfmCCQu2wsfYGc7zI6bk/rhxmNN2PBXZJvfriJzM6xJsF
         pF2q47ayc29w0hf3g6uAzcVglUw/R+00zLtTuLlphFjjP/enRVu7tFCCyIcZQD5O7J
         6o2UAGGWWyedO7Vkg6g/giu6ZOK/NnpiCaTS4Qllh1izMbFS+Jcqo/elXk/c2lNIv1
         SN2uVBJXQhULwv3SoVeH3BXqQcDzcVlLGz6b9ZRQcStKSBBo9RmYdSRlfHL32VCBZM
         v6jeVNi1QcvqS1fFGOaY86vYm3KHjabc9JOXMEJIlqPPK9Z7nL38Aed+AK3zYM9uXl
         1ic2abPyIhgwQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010j-Gp; Tue, 30 Aug 2022 13:29:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 19/30] dt-bindings: phy: add QMP USB PHY schema
Date:   Tue, 30 Aug 2022 13:29:12 +0200
Message-Id: <20220830112923.3725-20-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PHY DT schema is getting unwieldy. Break out the USB PHY
binding in a separate file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...com,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} | 67 +++++--------------
 1 file changed, 16 insertions(+), 51 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} (83%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 602c07357a13..55104c0a0d4b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,qmp-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QMP PHY controller
+title: Qualcomm QMP PHY controller (USB)
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
@@ -52,20 +51,18 @@ properties:
   ranges: true
 
   clocks:
-    minItems: 1
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    minItems: 1
+    minItems: 3
     maxItems: 4
 
   resets:
-    minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   reset-names:
-    minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   vdda-phy-supply: true
 
@@ -76,7 +73,7 @@ properties:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-    description: one child node per PHY provided by this block
+    description: single PHY-provider child node
 
 required:
   - compatible
@@ -88,6 +85,8 @@ required:
   - clock-names
   - resets
   - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -114,34 +113,7 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdx55-qmp-usb3-uni-phy
-              - qcom,sdx65-qmp-usb3-uni-phy
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
-          maxItems: 2
-        reset-names:
-          items:
-            - const: phy
-            - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -150,6 +122,8 @@ allOf:
               - qcom,ipq8074-qmp-usb3-phy
               - qcom,msm8996-qmp-usb3-phy
               - qcom,msm8998-qmp-usb3-phy
+              - qcom,sdx55-qmp-usb3-uni-phy
+              - qcom,sdx65-qmp-usb3-uni-phy
     then:
       properties:
         clocks:
@@ -165,9 +139,7 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -194,9 +166,7 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -219,9 +189,7 @@ allOf:
           items:
             - const: phy
             - const: common
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -243,9 +211,6 @@ allOf:
           items:
             - const: phy_phy
             - const: phy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
 examples:
   - |
-- 
2.35.1

