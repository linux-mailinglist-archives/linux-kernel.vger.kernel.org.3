Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70A05A3CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiH1Ior (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiH1IoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:44:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F102F386
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:44:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so7374454lfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=75ciJJEb0fjQQAUZH+zRMedVcWRRAgKZoJmNIvnx7Ts=;
        b=mNpdriymM/xZ3/9ht8WqMck8iiOidkaMGTIesyWAq/ZRL7SwUvb6gzV+63k8OZyY+M
         Q+FiXtYQHfGfAXECwObeYBRZpZ21u9PJI9UYEK4FwYCGOqMq990dtNYbWbkNwBaMStl7
         DI3kqBAc1Gb1gE/1F0kZFfIv3UKBxHmgA7KOA2kOmiMteORvV+/2Uv3o5qTOaZRZ0vXv
         r0ecyGNVqOE5IycipcrQLjYY1therN4v+a84IYi6zqAqVO2RcVcckVEyHDSl2wE8/2y3
         cAcHvextSpHLQ3yBLbMwqGYT4QvvF/mW0gNnXeBgpxMDxrWudC0VE6hS0LlH9qtMXhBK
         R1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=75ciJJEb0fjQQAUZH+zRMedVcWRRAgKZoJmNIvnx7Ts=;
        b=GId59Eaq1VL8SX13L337Wvah5RNMaJTO65DW9ZZvm1oEXHntRiPWwP5vL4Yf9p0XXO
         YsB0f9mWNGlx6BcEqCOvmG4MVORkmuEt3a/ydijyZoMkz502gAbtGUG0z4szMPnTetlB
         /kjEqntMagWJkjfRKGSWlENCTJWwHkzigoMgWLsarXLJwbntce5reuSdGqKAaLj2jSFx
         nI7gwnXE98qxkJ40tiwCSTM9GKF12Oedr81NzyNO+vBPPuo/zHrBonSEvpSz6k3f3uN5
         kh5N74ya72uTtUIfBoWPP1H9jtjuxGHXxatE4q5+w4EekOUyPxywVzC6JrpYC0VQYcgJ
         IYNQ==
X-Gm-Message-State: ACgBeo1ph7nuQlh/4nw4u3sE3jFsVGIELf8zKJTDuQug7G8qhTOLKGrE
        +vIhJGEfLnEYK+vfg/EaVRQiWQ==
X-Google-Smtp-Source: AA6agR6n0d1QebXhA3AzIiNNgXJnLXpvhckfJa56xot7iJnpPWbZAh6mB7caWu2ENnjnNRs7tAWgjQ==
X-Received: by 2002:a05:6512:23a5:b0:492:f76b:dfea with SMTP id c37-20020a05651223a500b00492f76bdfeamr4704421lfv.5.1661676241413;
        Sun, 28 Aug 2022 01:44:01 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:44:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 14/14] dt-bindings: mfd: qcom,spmi-pmic: fix TM ADC node schema on PM8998
Date:   Sun, 28 Aug 2022 11:43:41 +0300
Message-Id: <20220828084341.112146-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
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

There are two bindings for Qualcomm SPMI PMIC Thermal Monitoring ADC:
one for ADC HC and one for ADC TM5 and TM7.  PM8998 uses the former one,
so fix matching of child schema:

  qcom/msm8998-asus-novago-tp370ql.dtb: pmic@0: adc-tm@3400:compatible:0: 'qcom,spmi-adc-tm-hc' is not one of ['qcom,spmi-adc-tm5', 'qcom,spmi-adc-tm5-gen2', 'qcom,adc-tm7']

Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mfd/qcom,spmi-pmic.yaml           | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index e062de7510ca..2946d08dd42f 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -107,7 +107,7 @@ patternProperties:
 
   "^adc-tm@[0-9a-f]+$":
     type: object
-    $ref: /schemas/thermal/qcom-spmi-adc-tm5.yaml#
+    # ref depends on compatible, see allOf below
 
   "^audio-codec@[0-9a-f]+$":
     type: object
@@ -150,6 +150,22 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8998
+    then:
+      patternProperties:
+        "^adc-tm@[0-9a-f]+$":
+          $ref: /schemas/thermal/qcom-spmi-adc-tm-hc.yaml#
+    else:
+      patternProperties:
+        "^adc-tm@[0-9a-f]+$":
+          $ref: /schemas/thermal/qcom-spmi-adc-tm5.yaml#
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

