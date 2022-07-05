Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421605666B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGEJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGEJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DADFB9;
        Tue,  5 Jul 2022 02:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBB56191C;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D140C341E1;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=5IEFwvykKWpluWYXuOvfZ01fDmcJ5NrUbb4Qf56H6+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvKR8YLNh6OgoPX2GLks3m2adddWQtdVdc/rNcRL0ZkIEzfSO0DHlLGw/fGPEM4AC
         Qc7Thw9QZhHLpEAVo7pCxBFHAb70VESP6/F+vDykawvtTudUwOVIDIRrNaZJsWGvhS
         7ml2Ug1lQzFexSGVHeZTfGeR+8DO7twQm57/Z6Ic+f1Qx3n5DXwWuFEXsMUmaQ8kLK
         YD1RI/Bl8MYxgzwrwFmAPD0bLa2ZR+OyeU5kCuzdZ8Evbk6GMV5/vLdqUvFhfhF+9N
         iw+7RI9FpJNDocQYt4twpUoYbWrvPBdLItla/zVqosHlX3tEJqLwk+HZD3V6no1iSs
         7/tMu+eL9tQaA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004X9-46; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: clean up constraints
Date:   Tue,  5 Jul 2022 11:42:03 +0200
Message-Id: <20220705094239.17174-8-johan+linaro@kernel.org>
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

Drop the compatible conditional and tighten the property constraints.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 65 +++++--------------
 1 file changed, 18 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index 14fd86fd91ec..b73bf5c06358 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -19,10 +19,8 @@ properties:
     const: qcom,msm8996-qmp-pcie-phy
 
   reg:
-    minItems: 1
     items:
       - description: Address and length of PHY's common serdes block.
-      - description: Address and length of PHY's DP_COM control block.
 
   "#address-cells":
     enum: [ 1, 2 ]
@@ -33,20 +31,28 @@ properties:
   ranges: true
 
   clocks:
-    minItems: 1
-    maxItems: 4
+    items:
+      - description: PHY aux clock.
+      - description: PHY config clock.
+      - description: 19.2 MHz ref clock.
 
   clock-names:
-    minItems: 1
-    maxItems: 4
+    items:
+      - const: aux
+      - const: cfg_ahb
+      - const: ref
 
   resets:
-    minItems: 1
-    maxItems: 3
+    items:
+      - description: Reset of PHY block.
+      - description: PHY common block reset.
+      - description: PHY's ahb cfg block reset.
 
   reset-names:
-    minItems: 1
-    maxItems: 3
+    items:
+      - const: phy
+      - const: common
+      - const: cfg
 
   vdda-phy-supply:
     description:
@@ -56,10 +62,6 @@ properties:
     description:
       Phandle to 1.8V regulator supply to PHY refclk pll block.
 
-  vddp-ref-clk-supply:
-    description:
-      Phandle to a regulator supply to any specific refclk pll block.
-
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
@@ -77,38 +79,7 @@ required:
   - clock-names
   - resets
   - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
 
 additionalProperties: false
-
-allOf:
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
-- 
2.35.1

