Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B256BAB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiGHN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiGHN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:29:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7182CC8E;
        Fri,  8 Jul 2022 06:29:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v12so14250741edc.10;
        Fri, 08 Jul 2022 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yNT274X8JVIXWHK9IfpidEsdTyKnF8Wkvv4Lr1xrM=;
        b=T49Dpozw8GmXePIozCQt/BaE/hs09JQQS4VxY2XNYeGltK2ufde6tdkHJ+qV49MBb/
         cgwtD6o1chIsu+K45lOGnt78rWTmMo8vN1vybAtnydtU+Pk1wXJGbUa4BvPHJvUl6F46
         0IO+W3gYuGyE74EWOFwblBeMc6VAEVL4ujHWVs5RZIoKT1DyIQXJLnTME3n15/m/I9x1
         juYtvJDLa9gOAoN8tv9ma5PzIfq8zYzwwPY4SLiPTiCzL4SZ3ZTkIJC6d8T5xif4FN/D
         40VPwo8Jo2XzQoMVmeWzQDUNSieBneVh12KQgzHI+MWJUjixLMEPHUQ/5wUu8JJsKjaC
         fv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yNT274X8JVIXWHK9IfpidEsdTyKnF8Wkvv4Lr1xrM=;
        b=gWXmQuF0onXbp4/7jHrv/6f0D4Xz4UT4Be5dwk3b6M9oC7Pe4uQ3QvZfb6BSDs9h4F
         NkFbnoKKUAeC9L/rqKpzMuWwokKxpk4ekrhFcXH3IIuJVooBXp37tsyZczTTxFbInfv7
         wooBsAMp5PBqVzA5v0gkQGrb7VoQf9mpd70w7j0egtQA4gER8Lk5dgDY8JUhpZY2ZoHK
         s2dZivHef4VwfalEC4NsVY8vuGd/KWJpMt1pBHjT8cGojmSaTRKeAZPs4mJf1v7mccGY
         1Pm8IomLl09+hz+xGzE2doEvS7BJcgsnV5az0864LorgV3AanJsDS8jyrC8LBFNyXJvV
         9U/g==
X-Gm-Message-State: AJIora+7s1mS89rBTPw+4nCFqeN438ho1cgcuspWvzLm+sbVGRfPEBli
        L7xpw/ega9CZ6pPLWudVjbo=
X-Google-Smtp-Source: AGRyM1vrAKpKJdOECJLFrVkdBIXOKfAQt31+tD63iuif8bqLLfCeZhXJEam7m9XwSLL0XuoHuXbtQQ==
X-Received: by 2002:a05:6402:2687:b0:43a:6025:1658 with SMTP id w7-20020a056402268700b0043a60251658mr4658569edd.271.1657286972649;
        Fri, 08 Jul 2022 06:29:32 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm20170398ejt.189.2022.07.08.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:29:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Fri,  8 Jul 2022 15:29:26 +0200
Message-Id: <20220708132930.595897-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Add the forgotten Reviewed-by tag from Krzysztof

Changes in v3:
* Remove implied min/maxItem properties as pointed by Rob

Changes in v2:
* No need for a list in compatible check
* Specify minItems and maxItems for interrupt and interrupt-names
---
 .../bindings/thermal/qcom-tsens.yaml          | 76 ++++++++++++++++---
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..fee2b6281417 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -59,6 +59,10 @@ properties:
               - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
+      - description: v2 of TSENS with combined interrupt
+        enum:
+          - qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
@@ -66,15 +70,11 @@ properties:
 
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
@@ -128,22 +128,61 @@ allOf:
     then:
       properties:
         interrupts:
-          maxItems: 1
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
         interrupt-names:
-          maxItems: 1
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
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+            - const: critical
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-tsens
+    then:
       properties:
         interrupts:
-          minItems: 2
+          items:
+            - description: Combined interrupt if upper, lower or critical thresholds crossed
         interrupt-names:
-          minItems: 2
+          items:
+            - const: combined
 
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
@@ -226,4 +265,19 @@ examples:
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
2.36.1

