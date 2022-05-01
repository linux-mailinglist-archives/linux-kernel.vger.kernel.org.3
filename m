Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CDB5166F3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiEASZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbiEASZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:25:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE351E47;
        Sun,  1 May 2022 11:22:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id be20so14434721edb.12;
        Sun, 01 May 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHTFvMXpHoZFvzZdNmQTbEi+DbIq4dTNCJkhsSirED0=;
        b=lA2yTdugPwgtl1Ca30TXw5qhfaC1gYzNrWc/7jT+tZ1vApMJjgusMCsPpC33BeymBe
         r3wNs4bs00E04uJ0Hj9XDnSSkX5tb2gnuZQSZn/tXGsTFScE1kFlMwrGdElOvPa4whpJ
         XLpdi839qF4LLMkDc8BT2FM9F+qLSKhbnZ2+6pYoACJRY48dT7qULs9YI0HNBupTJZ1a
         GIa70TLBl8tXzqtJJgJq+y0VP1XMR0WwHL4ttuqemB0N757QgeH7FhHY5g4jVOjpsqPL
         YjggHOjcxnBqLp5zpnapT2aB6MNEKBSJCNsBrBe+4HokcipUE14ATMn/EXUn0o4v6Ecl
         HhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHTFvMXpHoZFvzZdNmQTbEi+DbIq4dTNCJkhsSirED0=;
        b=WBBtXQtp1GazAqvFKLxQEJx/Cd9Ckh5H98+xI/cq4n7ZYJcovdG6wHQ5Wl06k0ymoq
         VSX+iQ69GpaA+lXKyBPdVJJXW11kjzJDbnItLB2XmXIfan8OZfS2FW3br0W83eIFqS3c
         5wnKMSq0FU0fP43uATmgcfDWc2832iGJ2AMCgMiKKjs9n9sqIy44mEd26Dz5pPW/mTel
         op+Ei7U+x06drKX7VP4zVSGPg1wgvURkHyVSC87F5ZHjsn/iFvw4qSeP7HyHvSOh3JYk
         KCuVkG8x5MAwFOFF+4TFwwLBnY2iI7t7v3Dn9rfWF4k59sb12B6bq0/UrUuaUJH/mTAH
         gNnQ==
X-Gm-Message-State: AOAM530NNDkwGANsT2IcxEl/fJKalJJ1pdHd5UIj5oCmuLg9uNQP8rge
        a9nsg/+5tVS+osDy4CoYpFSe4M/bcQvZUA==
X-Google-Smtp-Source: ABdhPJxGeY3g27Ogk6Vq4xMMjYuSK3Mu+xOwkZHK1vIWZwMOqDC5IJzKUnlNWYXpbTYCAFOXVWujIw==
X-Received: by 2002:a05:6402:1a34:b0:425:ca01:58ec with SMTP id be20-20020a0564021a3400b00425ca0158ecmr9974952edb.373.1651429323566;
        Sun, 01 May 2022 11:22:03 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-225-cbl.xnet.hr. [94.253.144.225])
        by smtp.googlemail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2769811ejc.155.2022.05.01.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 11:22:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Sun,  1 May 2022 20:21:56 +0200
Message-Id: <20220501182200.47328-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.

We also have to make sure that correct interrupts are set according to
compatibles, so populate interrupt information per compatibles.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* No need for a list in compatible check
* Specify minItems and maxItems for interrupt and interrupt-names
---
 .../bindings/thermal/qcom-tsens.yaml          | 74 +++++++++++++++++--
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bcc683f..e9b85c99bb60 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -56,6 +56,10 @@ properties:
               - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
+      - description: v2 of TSENS with combined interrupt
+        enum:
+          - qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
@@ -63,15 +67,11 @@ properties:
 
   interrupts:
     minItems: 1
-    items:
-      - description: Combined interrupt if upper or lower threshold crossed
-      - description: Interrupt if critical threshold crossed
+    maxItems: 2
 
   interrupt-names:
     minItems: 1
-    items:
-      - const: uplow
-      - const: critical
+    maxItems: 2
 
   nvmem-cells:
     minItems: 1
@@ -125,21 +125,66 @@ allOf:
       properties:
         interrupts:
           maxItems: 1
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
         interrupt-names:
           maxItems: 1
+          items:
+            - const: uplow
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-tsens
+              - qcom,msm8996-tsens
+              - qcom,msm8998-tsens
+              - qcom,sc7180-tsens
+              - qcom,sc7280-tsens
+              - qcom,sc8180x-tsens
+              - qcom,sdm630-tsens
+              - qcom,sdm845-tsens
+              - qcom,sm8150-tsens
+              - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
+              - qcom,tsens-v2
+    then:
       properties:
         interrupts:
           minItems: 2
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
         interrupt-names:
           minItems: 2
+          items:
+            - const: uplow
+            - const: critical
 
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8074-tsens
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+          items:
+            - description: Combined interrupt if upper, lower or critical thresholds crossed
+        interrupt-names:
+          maxItems: 1
+          items:
+            - const: combined
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
@@ -222,4 +267,19 @@ examples:
            #qcom,sensors = <13>;
            #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 4 (for any IPQ8074 based SoC-s):
+    tsens4: thermal-sensor@4a9000 {
+           compatible = "qcom,ipq8074-tsens";
+           reg = <0x4a9000 0x1000>,
+                 <0x4a8000 0x1000>;
+
+           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "combined";
+
+           #qcom,sensors = <16>;
+           #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.35.1

