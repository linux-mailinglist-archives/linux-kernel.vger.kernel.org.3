Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4195666F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGEJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiGEJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5212D08;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE5461943;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD55C341DC;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=jIYm/pfJJnHX7kIpyfA/95SToflZxqcjCruxOMG9gVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWxxWM/k1TSzpaNgqhuFMK6+XczPU+25wK9G52gPhW9vEhtgyomnXrByImBOL0U+B
         uyfy8mYYt1tOFt01lsYwPqnPnblF9mGcopwDofvyrn8CfnJb4KeuW+oCfn8CkM+DZI
         OcR2iXbLwDVY0NChXXHPJqg+5N3/zruUwBU1JMXJoibOPQXDUd69ZR8ixzGDhNF07L
         FRWoBnF1nnMN5f40LOwD64QQ4zzQ0FWJqA2643iFSHU5pMaFjoEIB59cJLVRXEiYd/
         7x+uDQaa+8irLWyOJ2sQ/K7gV1J2DU2sMYn1kD+MMjAaAZ/zDYbO2/XoH9XGT0niHj
         dMfNPQw3zZBdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YT-He; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 34/43] dt-bindings: phy: qcom,qmp-usb: add missing child node schema
Date:   Tue,  5 Jul 2022 11:42:30 +0200
Message-Id: <20220705094239.17174-35-johan+linaro@kernel.org>
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

Add the missing the description of the PHY-provider child node which was
ignored when converting to DT schema.

Also fix up the incorrect description that claimed that one child node
per lane was required.

Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-usb-phy.yaml        | 109 +++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 21744bbe1764..c9a6765708cc 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -77,9 +77,37 @@ properties:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-    description:
-      Each device node of QMP PHY is required to have as many child nodes as
-      the number of lanes the PHY has.
+    description: Single PHY-provider child node.
+    properties:
+      reg:
+        minItems: 3
+        maxItems: 6
+
+      clocks:
+        items:
+          - description: PIPE clock
+
+      clock-names:
+        items:
+          - const: pipe0
+
+      "#clock-cells":
+        const: 0
+
+      clock-output-names: true
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+      - "#clock-cells"
+      - clock-output-names
+      - "#phy-cells"
+
+    additionalProperties: false
 
 required:
   - compatible
@@ -270,6 +298,81 @@ allOf:
             - const: phy_phy
             - const: phy
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-qmp-usb3-phy
+              - qcom,sdm845-qmp-usb3-phy
+              - qcom,sm8150-qmp-usb3-phy
+              - qcom,sm8350-qmp-usb3-phy
+              - qcom,sm8450-qmp-usb3-phy
+    then:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              minItems: 5
+              maxItems: 6
+              items:
+                - description: TX lane 1
+                - description: RX lane 1
+                - description: PCS
+                - description: TX lane 2
+                - description: RX lane 2
+                - description: PCS_MISC
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,msm8998-qmp-usb3-phy
+      then:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                maxItems: 5
+      else:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                minItems: 6
+    else:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              minItems: 3
+              maxItems: 4
+              items:
+                - description: TX
+                - description: RX
+                - description: PCS
+                - description: PCS_MISC
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,msm8996-qmp-usb3-phy
+                - qcom,sm8250-qmp-usb3-uni-phy
+                - qcom,sm8350-qmp-usb3-uni-phy
+      then:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                maxItems: 3
+      else:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                minItems: 4
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-- 
2.35.1

