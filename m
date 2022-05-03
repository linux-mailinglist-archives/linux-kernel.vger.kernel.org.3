Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2843518E0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiECUM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiECUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:12:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BB40924;
        Tue,  3 May 2022 13:08:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq17so35482039ejb.4;
        Tue, 03 May 2022 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TqgrTONdYchEwgr6zN1k5TY6YG09ErgwU27PFjZsGs=;
        b=Jn8aoiI2ikVrlZIYq9rqh8SoHYiW/1m6s1JrW0hTdhmr19BSJjk+lPEN8x23p7EK+w
         XYGCNkJfmeXCuOf4H+O4RT2INXSqtQObntwZjKoU5hJfOTU8lEaVgiY0YqqaLBbqXMZx
         vbMBYku1R5bdWWKlr4/2wg0LI8cK1atNl3MGb4myEYlmtQ6L+aC/eOdXRoPd+usvGOEo
         h4HaLotLMsFU6uF8u2y6mPxi4/eMyKsUa5+uAt6t8vhr2+QUD11Ge1ElBh+KA+8QMRsG
         +2Cpl8Ucyj6RZYutcBUA6A4GB8hE8MfsDKuH26DLHNSr8mflUKEkLCKJiBbLUhVFNHLO
         qZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TqgrTONdYchEwgr6zN1k5TY6YG09ErgwU27PFjZsGs=;
        b=vNRNC3MaiX7eWwUzE5550y93uSldDmt2SDydIK38F6HGYIw5UvwnCILjUz8/7YFQmC
         XwXN/eS2c74iYuXP4sXd34LD31q5i7okAl6pw7I9wlHwdDQU1KXclZsKplYH3WTTNq8+
         VU9Y5fq5uO+sOb09hep79UyFExnzuqugx1580vCM54e+3lxpmbY2CcqnhtC9/W5X24rO
         vzeP+YW8RNxevwCx5M0gtBIPGLBTHyqjcujOAB9/LM05MxRQj3D95RNevplgornprNY9
         jCrhMgLc+pWR42EcHfYPWMV8dZJQxdsJxd4b1Lts2XVyUVS7XrY34Q1RGyYyEoF4f8cT
         SrEg==
X-Gm-Message-State: AOAM532IraHsPRTJl4ZGPWiXsfqokZbSdRyU7NIEL+xBleiKMZiBexkU
        SOZxVu+/gRY9REBJ2+SwROY=
X-Google-Smtp-Source: ABdhPJyhMc1NyL4B9pTCp0N118EakOxTWFSloDpilfKE1xgUQVkuCjz0Eud6mUmK07n/EFMd185Qlw==
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id o14-20020a170906974e00b006bb4f90a6aemr17628682ejy.452.1651608496367;
        Tue, 03 May 2022 13:08:16 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ml11-20020a170906cc0b00b006f3ef214e59sm4967466ejb.191.2022.05.03.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:08:15 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Tue,  3 May 2022 22:08:09 +0200
Message-Id: <20220503200813.4020698-1-robimarko@gmail.com>
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
index b6406bcc683f..23f69eead67e 100644
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
@@ -124,22 +124,61 @@ allOf:
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
@@ -222,4 +261,19 @@ examples:
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

