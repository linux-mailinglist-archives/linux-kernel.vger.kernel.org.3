Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6171D57372F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiGMNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiGMNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA52BC6;
        Wed, 13 Jul 2022 06:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD62D61CBF;
        Wed, 13 Jul 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A40C341C6;
        Wed, 13 Jul 2022 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718277;
        bh=IMphhiSYM6JhBFzADUzsR3qJaXb7aQt8roj9nMxUDss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpoZlDPYZZpu1ynUMmTH+S92HXAVhfdIi/djW66irciGyl3p1tnOxLSTzUUVBHSj1
         bRkf8E5Az2+yDU4ver3ocfp2jjqNzumoBG54gWQ3IOlUW2//i6HV0UGrQAVnbrTuWW
         SsjqBKT20j8EwQy+R3IoAKKEdR/xc6bgHk8PYLIW/wtft7PToEzYgMqjHJA5ozI0pv
         aalTQA6VxUNJtTG/4z6FOH7l8v3fqYbTDFT0qrc4r/xeCkezsnrDhJnofgVrHeJQHa
         OiBmbAEl3wCGEsVviZSeD9Qi7DpcaAtstR3PmYVTRSzLqrtsGY3xupPKAQcxkAWb1J
         z57BGNaIS49dQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBcFd-0007gG-2f; Wed, 13 Jul 2022 15:18:01 +0200
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
Subject: [PATCH 1/7] dt-bindings: usb: qcom,dwc3: add SC8280XP binding
Date:   Wed, 13 Jul 2022 15:13:34 +0200
Message-Id: <20220713131340.29401-2-johan+linaro@kernel.org>
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

Add SC8280XP to the DT schema.

Note that the SC8280XP controllers use the common set of five clocks and
an additional set of four interconnect clocks whose purpose is not
entirely clear at this point.

The set of wakeup interrupts is also different for SC8280XP.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 102 +++++++++++++++---
 1 file changed, 88 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 749e1963ddbb..c991d9103f87 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
+          - qcom,sc8280xp-dwc3
           - qcom,sdm660-dwc3
           - qcom,sdm845-dwc3
           - qcom,sdx55-dwc3
@@ -66,11 +67,11 @@ properties:
        - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
                      mode. Its frequency should be 19.2MHz.
     minItems: 1
-    maxItems: 6
+    maxItems: 9
 
   clock-names:
     minItems: 1
-    maxItems: 6
+    maxItems: 9
 
   assigned-clocks:
     items:
@@ -93,20 +94,10 @@ properties:
       - const: apps-usb
 
   interrupts:
-    items:
-      - description: The interrupt that is asserted
-          when a wakeup event is received on USB2 bus.
-      - description: The interrupt that is asserted
-          when a wakeup event is received on USB3 bus.
-      - description: Wakeup event on DM line.
-      - description: Wakeup event on DP line.
+    maxItems: 4
 
   interrupt-names:
-    items:
-      - const: hs_phy_irq
-      - const: ss_phy_irq
-      - const: dm_hs_phy_irq
-      - const: dp_hs_phy_irq
+    maxItems: 4
 
   qcom,select-utmi-as-pipe-clk:
     description:
@@ -249,6 +240,28 @@ allOf:
             - const: sleep
             - const: mock_utmi
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 9
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: noc_aggr
+            - const: noc_aggr_north
+            - const: noc_aggr_south
+            - const: noc_sys
+
   - if:
       properties:
         compatible:
@@ -311,6 +324,67 @@ allOf:
             - const: mock_utmi
             - const: xo
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-dwc3
+              - qcom,ipq6018-dwc3
+              - qcom,ipq8064-dwc3
+              - qcom,ipq8074-dwc3
+              - qcom,msm8953-dwc3
+              - qcom,msm8994-dwc3
+              - qcom,msm8996-dwc3
+              - qcom,msm8998-dwc3
+              - qcom,qcs404-dwc3
+              - qcom,sc7180-dwc3
+              - qcom,sc7280-dwc3
+              - qcom,sdm660-dwc3
+              - qcom,sdm845-dwc3
+              - qcom,sdx55-dwc3
+              - qcom,sdx65-dwc3
+              - qcom,sm4250-dwc3
+              - qcom,sm6115-dwc3
+              - qcom,sm6125-dwc3
+              - qcom,sm6350-dwc3
+              - qcom,sm8150-dwc3
+              - qcom,sm8250-dwc3
+              - qcom,sm8350-dwc3
+              - qcom,sm8450-dwc3
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: The interrupt that is asserted
+                when a wakeup event is received on USB2 bus.
+            - description: The interrupt that is asserted
+                when a wakeup event is received on USB3 bus.
+            - description: Wakeup event on DM line.
+            - description: Wakeup event on DP line.
+        interrupt-names:
+          items:
+            - const: hs_phy_irq
+            - const: ss_phy_irq
+            - const: dm_hs_phy_irq
+            - const: dp_hs_phy_irq
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-dwc3
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: pwr_event
+            - const: dp_hs_phy_irq
+            - const: dm_hs_phy_irq
+            - const: ss_phy_irq
 
 additionalProperties: false
 
-- 
2.35.1

