Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDF598FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbiHRWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHRWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:02:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233CD11FD;
        Thu, 18 Aug 2022 15:02:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i14so5660038ejg.6;
        Thu, 18 Aug 2022 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Qe87Wl0jdR/rbisfvd/66HbPbB+87sIw/zxL0DX/eMA=;
        b=Bha8rcflPbh3XcQUGNlHyg3yurdgx6NJ17VqWwagL5iyYSAIM9m4z9+/ePvElPV9D1
         zYp6OBL2/YbV1wU4Uixf3dQ7V2oIBf0+VRdCepHkJZVMafU/VKr4khEADZs2ubP1v+Tf
         c+A8iy76xNSGtsJC/sjvQDc3/yqJFErEc7QfhgumxWIOixYGqhCBxqZJWIsn4MxZ+Dv/
         fv/mEW8XA2r23KAvTWH2LdEw5kupckzW248FL62k5q2ck+Suqd56xeDihhh3s1QuR/++
         IsoLZymBfFHAWfpiS1dw5O5Ie+/u16TiEwugyxueqomYC27/7EsOW9iGX5a3vcviVIfl
         ZjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Qe87Wl0jdR/rbisfvd/66HbPbB+87sIw/zxL0DX/eMA=;
        b=rBgSJx/pYFHp3Zg3jTeOUXYEgIEJH25cWQ9RF/87LPu1MF+Rg9gs5a0LBzlJKn8C02
         2+RaOZ1xn9hVWfCOBrnV6CJ0uXLJdQJlpqTnQ8I20BzPjHV2lk6cRfo4WZQ3XHCEYl3I
         wJKNiNSP4vWTRYihxaXIsqjKHGV6wQGQ9DDyjHTR2yxfGMdsfjVnF5+d1aUPgm0IzwSh
         ec/AxMrKXaeU20j5kjNP6CJARW0rEt1OGKtesOKNgZXZQ+Ip3wpq6cILyV+CM6yzerfR
         D9BruY+FQiA6kaAG0/XP1ZDCAhW+ntOTC2MQrTdGKiCMk+mRY2lj/0lF5oVWlPHyG2S9
         P7uQ==
X-Gm-Message-State: ACgBeo2CSbrmcYmlers3MmbbkkSluSE/F9ApS3Lf/ZsNiLeCXV8NrBL3
        zWMGm67n+s8UCvrbykqajh+t71vc5QM=
X-Google-Smtp-Source: AA6agR6vhlbo4MujI4u/TcCOIu57608t0NQHe5wHP4KkmyhBndA+3AZpBAtDA1n2g3ytlxj1joz/vQ==
X-Received: by 2002:a17:907:7605:b0:73c:f264:aa7a with SMTP id jx5-20020a170907760500b0073cf264aa7amr173617ejc.766.1660860169449;
        Thu, 18 Aug 2022 15:02:49 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id l7-20020a170906230700b0072fa1571c99sm1379297eja.137.2022.08.18.15.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:02:48 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Fri, 19 Aug 2022 00:02:41 +0200
Message-Id: <20220818220245.338396-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
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
2.37.2

