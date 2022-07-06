Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE956958B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGFWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiGFWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6C2B1BB;
        Wed,  6 Jul 2022 15:54:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so15282290eda.3;
        Wed, 06 Jul 2022 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c76lu8aPE1RwcHogIfDRm0DW3ySrG+yVI8AYXR7nWWM=;
        b=L81iNCGhtwD0TrrbQ5e0nxACbAwChG2h7JlpA4psJU7Ix1vOcD3VlSfuLexHq2m5yU
         TXZk3ml/Qbzq9ZCO4F4GnX18uBFmCt9KfPzEsg6rIBGiJO97eq7SBUKgzioOBuHSXEa4
         hNXxBO5L1U1ZxFRHZ5aEiYTe7sTFryf2Og6pAPXIhv1+QHigVQes1pMZ6v+fHIqSaJ8Q
         04VWK/wiNf4tURg6OnjGR9Y8FiE5A4ID4vDx3pA3Z9lIm0sweLtGJeeHA88Dv34U1zdb
         XQE/qH67gJa5KoIM5FMux1UCWmbxyAGe59+8033HI8Gjypbu8A1FBbMV8YOqUhNWkDDr
         REsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c76lu8aPE1RwcHogIfDRm0DW3ySrG+yVI8AYXR7nWWM=;
        b=il0M+Og/uaZtoHNzixE7E0w66a4lnJYjqmcJijqOgPAkYk3uU9w08+pWuR6TZX0YSj
         b/G9xIc5CvZj97Q6Mj8Rf3oMio724IMglBS3dWlptHkhvkQ94bK6uyDDxNPugjaW5eSE
         KwshL7rCAmMwcjj5TQXipD6GlMo+hPPY/+ajUU0TNYfx0/0cFCmdedjb61mmR9P/9xRb
         qcezGlgv1PuWzw/Q68a314WS0HSWppTA1ADw9ODzQQ2hVDgvPnIq2rYO5Y+fTtMya5bQ
         um9uoMn8Dcw28H5XA6IVqaamgZZKEeh7S1Mh+r2gXc7lIT8I/o35p1tAtiYmNdlv6DCk
         xC0Q==
X-Gm-Message-State: AJIora85h75L3Hy4ewHh5Dd5sAlsgZdng8xfSh2TFI5mla4Si5jJwjNc
        1YZKtE5kMziAWd0h3ruj9zs=
X-Google-Smtp-Source: AGRyM1ujj4U/Gk0zM7iYxO5qjIjqRe5ZxWywX1JxGHT7sDegURC/HpC9MdKY+YUj7EEm8DLYj2KZkQ==
X-Received: by 2002:a05:6402:448c:b0:435:9dcc:b8a5 with SMTP id er12-20020a056402448c00b004359dccb8a5mr57198450edb.287.1657148065550;
        Wed, 06 Jul 2022 15:54:25 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170906304700b006fe921fcb2dsm1767637ejd.49.2022.07.06.15.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:54:25 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: clock: fix wrong clock documentation for qcom,rpmcc
Date:   Thu,  7 Jul 2022 00:53:18 +0200
Message-Id: <20220706225321.26215-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706225321.26215-1-ansuelsmth@gmail.com>
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
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

qcom,rpmcc describe 2 different kind of device.
Currently we have definition for rpm-smd based device but we lack
Documentation for simple rpm based device.

Add the missing clk for ipq806x, apq8060, msm8660 and apq8064 and
provide additional example to describe these new simple rpm based
devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/clock/qcom,rpmcc.yaml | 85 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index 9d296b89a8d0..d63b45ad06e8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -49,15 +49,86 @@ properties:
     const: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    const: xo
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
   - '#clock-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,rpmcc-apq8060
+              - qcom,rpmcc-ipq806x
+              - qcom,rpmcc-msm8660
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pxo clock
+
+        clock-names:
+          items:
+            - const: pxo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,rpmcc-apq8064
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pxo clock
+            - description: cxo clock
+
+        clock-names:
+          items:
+            - const: pxo
+            - const: cxo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,rpmcc-mdm9607
+              - qcom,rpmcc-msm8226
+              - qcom,rpmcc-msm8916
+              - qcom,rpmcc-msm8936
+              - qcom,rpmcc-msm8953
+              - qcom,rpmcc-msm8974
+              - qcom,rpmcc-msm8976
+              - qcom,rpmcc-msm8992
+              - qcom,rpmcc-msm8994
+              - qcom,rpmcc-msm8996
+              - qcom,rpmcc-msm8998
+              - qcom,rpmcc-qcm2290
+              - qcom,rpmcc-qcs404
+              - qcom,rpmcc-sdm660
+              - qcom,rpmcc-sm6115
+              - qcom,rpmcc-sm6125
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: xo clock
+
+        clock-names:
+          items:
+            - const: xo
+
 additionalProperties: false
 
 examples:
@@ -73,3 +144,13 @@ examples:
             };
         };
     };
+
+  - |
+    rpm {
+        clock-controller {
+            compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
+            #clock-cells = <1>;
+            clocks = <&pxo_board>;
+            clock-names = "pxo";
+        };
+    };
-- 
2.36.1

