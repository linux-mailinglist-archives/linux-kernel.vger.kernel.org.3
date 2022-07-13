Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C557373A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiGMNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiGMNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472AC219A;
        Wed, 13 Jul 2022 06:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AE361CB7;
        Wed, 13 Jul 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96693C341C8;
        Wed, 13 Jul 2022 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718277;
        bh=sfOPeQLpvb50JpTI/njvrEwkjhOXPUdfT53axlc0qnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttijnUf2VtD/q7DFIXUCRX9qRFhTvG8F+9a05gi0jyCm77vuBQhHjm+2lfQxIPjrA
         DQ0EGXSEwLCXAS/e+L2bdcbqD6vsw7sqPqdqYkGk8SofssDux4OOhb74pFPXRUjNi/
         P/pKVNRC5/4aMGLlRM6+3WOEI3OOme66vzIz8O19kj1xIIDHEZzockmSXoiYcbmeul
         /uz7zD45oCR+H/ciXWBhmViy3Wb510sxyvDnS6/xy57kDw5lXogdArL+4ADAxBuoKh
         VioBFK5BcZHURVNQ8SaqFjxlsbrVVrfs4IaMHt2TE/9OvzejPsSzC/ZuNdLay0M06i
         xI5Bg4o/qCS7g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBcFd-0007gI-5g; Wed, 13 Jul 2022 15:18:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/7] dt-bindings: usb: qcom,dwc3: refine interrupt requirements
Date:   Wed, 13 Jul 2022 15:13:35 +0200
Message-Id: <20220713131340.29401-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713131340.29401-1-johan+linaro@kernel.org>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
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

Not all platforms have all of the four wakeup interrupts currently
described by the bindings.

Specifically, MSM8953/6/8 and SDM660 do not use the DP/DM interrupts,
while the SS PHY interrupt is optional on SDM660 and SC7280.

Note that no devicetree in mainline specify any wakeup interrupts for

  - qcom,ipq4019-dwc3
  - qcom,ipq6018-dwc3
  - qcom,ipq8064-dwc3
  - qcom,ipq8074-dwc3
  - qcom,msm8994-dwc3
  - qcom,qcs404-dwc3

but let's keep the schema warnings about that for now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 60 +++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index c991d9103f87..fea3e7092ace 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -94,9 +94,11 @@ properties:
       - const: apps-usb
 
   interrupts:
+    minItems: 1
     maxItems: 4
 
   interrupt-names:
+    minItems: 1
     maxItems: 4
 
   qcom,select-utmi-as-pipe-clk:
@@ -333,14 +335,9 @@ allOf:
               - qcom,ipq6018-dwc3
               - qcom,ipq8064-dwc3
               - qcom,ipq8074-dwc3
-              - qcom,msm8953-dwc3
               - qcom,msm8994-dwc3
-              - qcom,msm8996-dwc3
-              - qcom,msm8998-dwc3
               - qcom,qcs404-dwc3
               - qcom,sc7180-dwc3
-              - qcom,sc7280-dwc3
-              - qcom,sdm660-dwc3
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
@@ -369,6 +366,59 @@ allOf:
             - const: dm_hs_phy_irq
             - const: dp_hs_phy_irq
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-dwc3
+              - qcom,msm8996-dwc3
+              - qcom,msm8998-dwc3
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 2
+        interrupt-names:
+          minItems: 1
+          items:
+            - const: hs_phy_irq
+            - const: ss_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-dwc3
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 4
+        interrupt-names:
+          minItems: 3
+          items:
+            - const: hs_phy_irq
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+            - const: ss_phy_irq
+
   - if:
       properties:
         compatible:
-- 
2.35.1

