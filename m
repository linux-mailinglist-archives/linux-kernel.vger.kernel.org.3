Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21D59E941
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiHWRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiHWRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:12 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE96EF007;
        Tue, 23 Aug 2022 07:57:23 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r10so10512001oie.1;
        Tue, 23 Aug 2022 07:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HGZycrPUJ9tZL1J+2Q0/5E3o17nVGa6AdQi0WZbnIKs=;
        b=19BqUrZ9LpzM1hlcrZEdm3JQWDvGXkgmMk6y/NabIS7DL4ha9ZIsIvJBMWTwfPjjhO
         v7U1clGrzjpHZCuPJil9RbBDXrThDi+Yf2hMq5d3wxfvnxrNtvDV6QmBSfzE+qTJDGG5
         RTX+udIHrLlYYt7e6bgfmBOipNJCfkGmcZjShuDIpWEB2ISkGqtsMbCLlsi9cy1pneeX
         UEw8E0soHTNs8ys35/1jjJZj7eJKiHRQ1n420utQEmR8yYjikqzoFnm7CJKt30ze0Nd4
         xZfXkd62mNXvOPlw9e1NTK1B7lZrHVCNBVildGCAQCr9SdGV0nUd7CgiyJXFr/CtcqdM
         mkTg==
X-Gm-Message-State: ACgBeo2j76zwvXZpQ6Qh1lmOrHA9q6vahX9bQB/rtAIZC24X0dHGQVN7
        hkYbYYn77DHsBdSLZhaBdg==
X-Google-Smtp-Source: AA6agR4QTEbRPz/oyZMlkPXRpRj5KOhcjVDz0Qv5pdtbi6Z5AhJie2GGjEV4aAHhi68H4rUZcb4+BQ==
X-Received: by 2002:a05:6808:f8f:b0:344:c3d4:775e with SMTP id o15-20020a0568080f8f00b00344c3d4775emr1441641oiw.266.1661266643134;
        Tue, 23 Aug 2022 07:57:23 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Robert Marko <robimarko@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:38 -0500
Message-Id: <20220823145649.3118479-7-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/dlg,da9121.yaml           |  1 +
 .../bindings/regulator/maxim,max77802.yaml       |  1 +
 .../bindings/regulator/maxim,max8997.yaml        |  1 +
 .../bindings/regulator/mt6315-regulator.yaml     |  1 +
 .../bindings/regulator/qcom,spmi-regulator.yaml  |  1 +
 .../regulator/qcom-labibb-regulator.yaml         | 16 ++++++++++++++++
 .../regulator/richtek,rt4801-regulator.yaml      |  1 +
 .../regulator/rohm,bd71815-regulator.yaml        |  1 +
 8 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 24ace6e1e5ec..63e1161a87de 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -83,6 +83,7 @@ properties:
 
   regulators:
     type: object
+    additionalProperties: false
     description: |
       List of regulators provided by the device
 
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
index 236348c4710c..71138c611b6c 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
@@ -79,6 +79,7 @@ patternProperties:
     patternProperties:
       regulator-state-(standby|mem|disk):
         type: object
+        additionalProperties: true
         properties:
           regulator-mode: false
 
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
index 4321f061a7f6..2b266ea43716 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
@@ -111,6 +111,7 @@ properties:
 
   regulators:
     type: object
+    additionalProperties: false
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index 37402c370fbb..364b58730be2 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -29,6 +29,7 @@ properties:
       "^vbuck[1-4]$":
         type: object
         $ref: "regulator.yaml#"
+        unevaluatedProperties: false
 
         properties:
           regulator-compatible:
diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 8b7c4af4b551..3266cd0c580f 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -35,6 +35,7 @@ patternProperties:
     description: List of regulators and its properties
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
     properties:
       qcom,ocp-max-retries:
diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
index 1ddc1efd19e2..f97b8083678f 100644
--- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
@@ -20,6 +20,7 @@ properties:
 
   lab:
     type: object
+    additionalProperties: false
 
     properties:
       qcom,soft-start-us:
@@ -33,11 +34,19 @@ properties:
         description:
           Short-circuit and over-current interrupts for lab.
 
+      interrupt-names:
+        minItems: 1
+        items:
+          - const: sc-err
+          - const: ocp
+
     required:
       - interrupts
+      - interrupt-names
 
   ibb:
     type: object
+    additionalProperties: false
 
     properties:
       qcom,discharge-resistor-kohms:
@@ -52,8 +61,15 @@ properties:
         description:
           Short-circuit and over-current interrupts for ibb.
 
+      interrupt-names:
+        minItems: 1
+        items:
+          - const: sc-err
+          - const: ocp
+
     required:
       - interrupts
+      - interrupt-names
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
index 091150c4e579..4a8a221bc902 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -42,6 +42,7 @@ patternProperties:
   "^DSV(P|N)$":
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description:
       Properties for single display bias regulator.
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
index 7d0adb74a396..d61e8675f067 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
@@ -27,6 +27,7 @@ properties:
     description:
       properties for wled regulator
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
     properties:
       regulator-name:
-- 
2.34.1

