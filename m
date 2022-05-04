Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D051A0A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbiEDNXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350392AbiEDNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729543BA5C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so2838034ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geJ1oCMfHvrwrPUcn2CBZQZQvkPEsJJFNL12XqUDXCM=;
        b=eXCGt2ajshLobHOIJRX+d5yT3wL9OfZmJInYcSe/ETxQ72pQJIFe62eQYgmFP1pPPJ
         kw8FYnmaF3rxOURKKA5S6VccS8E75IY1RlhJFP2oNZdXW1wP4RBFEHs6XilEinPW6vrj
         Isc5hh11tqC1fdg1dc0MFa+ynH1gH0R//ndqg72N390E1LRiLtRwgk/EeW3psHNxc7du
         SkwoD4sQ6Fgwv2wkNc6Xqd5moC3kSbCRMVEDmZWulqR+nCAAeae8kel9LtInwG32vPDE
         /TIRLmnOfb7bc9M1ARp0XWGsPNH7DB20OxcANoK8jqJVhvVM/a6UYme2PxNOZRjwWP0+
         K3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geJ1oCMfHvrwrPUcn2CBZQZQvkPEsJJFNL12XqUDXCM=;
        b=V+xVNknTD6bPZPatJPsnnrmxhzNO51AP6s7oqszrieofllubXbklKA+ny5v6RVzUrY
         rFwG/SISeRw1h1wLVS4+FDX2t94I1YaWUNvkJW73IPydJFaQ8aCA588upAbmiEe6Cj/V
         DVvtx/41dOfVSnwnXMse83ADvNXPAp6oKdW5M72SwVkOMb3XFHjaRKeAkfMGXHc2ECf2
         avdW/ztgkWR9X8zHaKohX3Ud+m8FSN3/pH2/ajjAfQCT3ZA1EDoow9TFrLX1oAeie5Sh
         VLgGOlrY8d64TYpJ7FhgUrnNgkrQEnzfJOX9SH7wyREXR8uSWnUKOLQPjtRqp53Ev3xw
         2rYg==
X-Gm-Message-State: AOAM531DEzTCHDjXzLTmNZBMoG3aSPB8eVe1oODXTwHaObjDNsprYCcj
        P6twBrHRHhnSgavuHazkFcK6wg==
X-Google-Smtp-Source: ABdhPJyfY9xuMVGc8LsmWl5zLun+0BP87d5iqcnXk5tyahzJRG6mgYGf6XihuoXxleN8KGqlPLo2LA==
X-Received: by 2002:a17:907:8a06:b0:6f4:922b:4b91 with SMTP id sc6-20020a1709078a0600b006f4922b4b91mr7152726ejc.670.1651670372039;
        Wed, 04 May 2022 06:19:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/13] dt-bindings: usb: qcom,dwc3: fix clock matching
Date:   Wed,  4 May 2022 15:19:14 +0200
Message-Id: <20220504131923.214367-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings defined strict clocks but several variants do not use them
in such order.  Split the clocks and clock-names per variants to match
current DTS usage.  In few cases this might not be complete match, due
to incomplete DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 222 ++++++++++++++++--
 1 file changed, 200 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 03f93f25cba4..5047ca31657c 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -54,26 +54,22 @@ properties:
     maxItems: 1
 
   clocks:
-    description:
-      A list of phandle and clock-specifier pairs for the clocks
-      listed in clock-names.
-    items:
-      - description: System Config NOC clock.
-      - description: Master/Core clock, has to be >= 125 MHz
-          for SS operation and >= 60MHz for HS operation.
-      - description: System bus AXI clock.
-      - description: Mock utmi clock needed for ITP/SOF generation
-          in host mode. Its frequency should be 19.2MHz.
-      - description: Sleep clock, used for wakeup when
-          USB3 core goes into low power mode (U3).
+    description: |
+      Several clocks are used, depending on the variant. Typical ones are::
+       - cfg_noc:: System Config NOC clock.
+       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
+                60MHz for HS operation.
+       - iface:: System bus AXI clock.
+       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
+                 power mode (U3).
+       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
+                     mode. Its frequency should be 19.2MHz.
+    minItems: 1
+    maxItems: 6
 
   clock-names:
-    items:
-      - const: cfg_noc
-      - const: core
-      - const: iface
-      - const: mock_utmi
-      - const: sleep
+    minItems: 1
+    maxItems: 6
 
   assigned-clocks:
     items:
@@ -136,6 +132,185 @@ required:
   - interrupts
   - interrupt-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq4019-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: core
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8064-dwc3
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Master/Core clock, has to be >= 125 MHz
+                for SS operation and >= 60MHz for HS operation.
+        clock-names:
+          items:
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-dwc3
+              - qcom,msm8996-dwc3
+              - qcom,msm8998-dwc3
+              - qcom,sc7180-dwc3
+              - qcom,sc7280-dwc3
+              - qcom,sdm845-dwc3
+              - qcom,sdx55-dwc3
+              - qcom,sm6350-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 4
+        clock-names:
+          oneOf:
+            - items:
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8994-dwc3
+              - qcom,qcs404-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: bus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6125-dwc3
+              - qcom,sm8150-dwc3
+              - qcom,sm8250-dwc3
+              - qcom,sm8450-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8350-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 6
+        clock-names:
+          minItems: 5
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: xo
+
+
 additionalProperties: false
 
 examples:
@@ -157,10 +332,13 @@ examples:
             clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
                      <&gcc GCC_USB30_PRIM_MASTER_CLK>,
                      <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-                     <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-                     <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-            clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-                      "sleep";
+                     <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+                     <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+            clock-names = "cfg_noc",
+                          "core",
+                          "iface",
+                          "sleep",
+                          "mock_utmi";
 
             assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
                           <&gcc GCC_USB30_PRIM_MASTER_CLK>;
-- 
2.32.0

