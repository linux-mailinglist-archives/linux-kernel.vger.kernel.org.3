Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4F516077
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiD3Uyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbiD3Uy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:54:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4C49F1F;
        Sat, 30 Apr 2022 13:51:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d6so12659026ede.8;
        Sat, 30 Apr 2022 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIpg9joXVj37DEw0/X2vPHLdIx/jukzHY2nL90S93uE=;
        b=N6/PWpxc6vUpB/yz2hISssTUs6vjQvVU+0+VYR/P0l3Y0vz0GZ+oE2j4ByKR0nzKbE
         E/0Ct4cVlMRjJrVDXShq5oVykqKkM4zJKqYMIUVSt277X15eVVLsrJh19q4gMt0pXi0D
         2DVXRz8nUQ/TSju93cFK3sBc8YlDpVNxCGk1rvaXQoBz8NwTLtGiTmR7f2HHU79/0xda
         YUXoZQ5IjnOCx06YWEjNReu7/c+86vz/8YN27HnlyjlCPu595USI3kI+bOuyJsf/PpDA
         Bia7teaPzz0DthbmjxXkgA+OVaiGwMwyPDJGQLVRswOWXg3OQvn49koQ4s2TNXDiH3aY
         OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIpg9joXVj37DEw0/X2vPHLdIx/jukzHY2nL90S93uE=;
        b=aaIQ599ILol0dnvwwJDDqF5/Mn5PCCXK+qxD2VLrBmPf1lq1J3X6TXrH5ynwPdWjmf
         zQ+p1L2+TCMEIo6DQIgEHEnrREVNBmDnnwwCDevIBQ0VyLTpA6wovPxwzZbY/waizE89
         M4HgSJcHK00X0YniC3dQcpliuR9WBwNaJrjPWtj9zzXAZRwcHmdnZvJ7lRkLuhO00s7f
         fNkWKPFik2EpT6RMhnR5xz+OWwaGo2OukPI3dsO8kvwMSSHb0fZ2otYpgxDpPJuhAO6Z
         KbxkZnqBN1iatN9Ehl3Wvhyexyk19fIHvFN9cLNxtcppW86ekqocyBS0XJIKdf5HIHU3
         QD/g==
X-Gm-Message-State: AOAM533lbL1wRqosJOQ+QdSKJMCmRMWr6jvqATyjCVJZrmjtnxtzW0Lp
        PIHRMwOuv6bvROdNWurw6bo=
X-Google-Smtp-Source: ABdhPJyGa8eqLLHbw4vtStE6lJud4dA5Kx/KEnnmb74LqK34mjtwtG6LYB2TeFVVmmfImp6PNbrchA==
X-Received: by 2002:a50:ed11:0:b0:425:c3d1:4547 with SMTP id j17-20020a50ed11000000b00425c3d14547mr5959420eds.410.1651351864653;
        Sat, 30 Apr 2022 13:51:04 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-113.zg.cable.xnet.hr. [94.253.165.113])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm4457852edx.50.2022.04.30.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 13:51:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Sat, 30 Apr 2022 22:50:57 +0200
Message-Id: <20220430205101.459782-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/thermal/qcom-tsens.yaml          | 79 ++++++++++++++++---
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bcc683f..44ebdfd4560a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -56,22 +56,19 @@ properties:
               - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
       - description: SROT registers
 
-  interrupts:
-    minItems: 1
-    items:
-      - description: Combined interrupt if upper or lower threshold crossed
-      - description: Interrupt if critical threshold crossed
+  interrupts: true
 
-  interrupt-names:
-    minItems: 1
-    items:
-      - const: uplow
-      - const: critical
+  interrupt-names: true
 
   nvmem-cells:
     minItems: 1
@@ -125,21 +122,66 @@ allOf:
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
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
 
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
@@ -222,4 +264,19 @@ examples:
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

