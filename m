Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051F574E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiGNMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiGNMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9871A43E74;
        Thu, 14 Jul 2022 05:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6809C61F72;
        Thu, 14 Jul 2022 12:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15AFC341FB;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802645;
        bh=tzNpftOmst6GU4IazMokTsUpgzdTm/ZJtIMAExt/haY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEalZaQ/FGb67GDScedbjZtpkAKmemM8ZaJvbebPJ1STPjDhzW4/1wollTOhfbueT
         Lexe2/aJmeQBIMWbN7KzZRCsSZm44pJA0grTZ3vz8fvvGNCHVP9DrDbJkGmLJ4sEM0
         MA9CUnjv4gKKlXZKFXW69GuvFefSkI3cybGi9MJSn3Z4j4YUQJZ+O9F8Z31hyrSSAn
         5VRInNU4WJSpgbDUeQJXBdGeW+AeMOZMZ1j2fPdyT90lsLFtJVmYGymx2N+245vnRW
         tQKBxiO8u68L5tPJgzTanUejqgGP0R/dHPqcFkmvHjY4hAezOeSqH1k8zEMUVBYTt+
         vBdBCn7ntJ+ew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCQ-0007Dx-E9; Thu, 14 Jul 2022 14:44:10 +0200
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
Subject: [PATCH v3 19/30] dt-bindings: phy: add QMP USB PHY schema
Date:   Thu, 14 Jul 2022 14:43:22 +0200
Message-Id: <20220714124333.27643-20-johan+linaro@kernel.org>
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

The QMP PHY DT schema is getting unwieldy. Break out the USB PHY
binding in a separate file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...com,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} | 67 +++++--------------
 1 file changed, 16 insertions(+), 51 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} (82%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
similarity index 82%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 21d6ec875529..430b34eae7bd 100644
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
@@ -51,20 +50,18 @@ properties:
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
 
@@ -75,7 +72,7 @@ properties:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-    description: one child node per PHY provided by this block
+    description: single PHY-provider child node
 
 required:
   - compatible
@@ -87,6 +84,8 @@ required:
   - clock-names
   - resets
   - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -113,34 +112,7 @@ allOf:
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
@@ -149,6 +121,8 @@ allOf:
               - qcom,ipq8074-qmp-usb3-phy
               - qcom,msm8996-qmp-usb3-phy
               - qcom,msm8998-qmp-usb3-phy
+              - qcom,sdx55-qmp-usb3-uni-phy
+              - qcom,sdx65-qmp-usb3-uni-phy
     then:
       properties:
         clocks:
@@ -164,9 +138,7 @@ allOf:
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
@@ -192,9 +164,7 @@ allOf:
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
@@ -217,9 +187,7 @@ allOf:
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
@@ -241,9 +209,6 @@ allOf:
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

