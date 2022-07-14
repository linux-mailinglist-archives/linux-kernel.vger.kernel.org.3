Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106E2574A48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiGNKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiGNKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:14:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F4EAC;
        Thu, 14 Jul 2022 03:14:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so2529211ejc.7;
        Thu, 14 Jul 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yNT274X8JVIXWHK9IfpidEsdTyKnF8Wkvv4Lr1xrM=;
        b=qmVMmCYWMChsAdG5X2Y6Q/71MVwf6RLbEeeaW/ZqgWPv2eKibulRjrYxHgTXo0KA0A
         bzTsMcZDe7yY1TDRfQxWKl71icobxi6GmFc8yL9kAxvQdzLJ1GgEZ6us8/nqVmIVLnxZ
         mWtnNOmmQC2TNzfGiVIzO5bpLXpe58zrruchtLRHwrbwdfJBxS52XVuch8LpAdRquONi
         MIYxhvxUkivGN257E3Fp6AdDtspBA+pYCfJmLI/KYeUkdO+mKNt2oNvt91+6qTYI7L5l
         o/EnrRh/HkXq73Wywd+SdK1tRHBCiLo6yFUC1khIVKN5JDzxQ2qzP8D2/hLe8XS7fkdP
         vrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5yNT274X8JVIXWHK9IfpidEsdTyKnF8Wkvv4Lr1xrM=;
        b=FvV4/CyddB8nWbuoR0k9L1yWHHzz8SUmPqW+PSqs4EL2HxKSGG9NFxacmtq0uqJfJl
         n+As0Rmaw/Rtn9CY0NsVPmoKA+YurKIAd9JUoAnHDEouTkJz6lDziNUzjiJEao9VTceR
         4VXWffPAdSVQBuZ3xtGihLCHmnOvbeHI3mEnFRTqQ8/ufsvoVJpl+bX8ldsypvnV8rxJ
         gwxqZm7WLPljCi/mX1F3FqjjIvmpg+Z4ZgmBpp7AJh9MlkWmJ5Dpq0GYO7Rqml0VgHXA
         sdI0oqcKbXOsM67tBiufuYlrJWS1bxE3bQ2k+gUDLOg+Byn+b+XkcHrO0tEMBysu15bR
         0qCw==
X-Gm-Message-State: AJIora+VoHvnZ8J6vntPIfXNfrKapx4kcn+tIy1woUL69yzeR4ISy+QT
        es22zwU4zxYMOTXNHstWayg=
X-Google-Smtp-Source: AGRyM1syFCF0F+Fqp287n/A30gl78Y4QaTt0zI7KL/3Wiff6be/4hPBEXNKZmiYryEXzPDttSmTUfQ==
X-Received: by 2002:a17:907:7628:b0:72b:4d6f:ce8a with SMTP id jy8-20020a170907762800b0072b4d6fce8amr8207487ejc.59.1657793695494;
        Thu, 14 Jul 2022 03:14:55 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-197.xnet.hr. [88.207.98.197])
        by smtp.googlemail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm535313ejb.147.2022.07.14.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:14:54 -0700 (PDT)
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
Subject: [PATCH v6 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Thu, 14 Jul 2022 12:14:47 +0200
Message-Id: <20220714101451.198211-1-robimarko@gmail.com>
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

