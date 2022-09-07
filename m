Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C25B01BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIGKTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiIGKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C5659E6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so9365327lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RR3PjHV9nmH/GbIhDoQ0i32DEOxqy1Cnfemy+zsHX2M=;
        b=SqYGb2SgUnHjteGhc8NyokrY/38tgAr0fl5azwYi3dQL4RVhNvyLC8pdKB6kdq+hTO
         d5RZ6EfJPA9+LkKSmbv1gKKIZeEmpdR1UqoJ6CPDG3wBfgU4MzXXOQMksXsLfLsq2zku
         3RJxa4McHvggTOEWIb/tbjWSgQHLZTXlos3o2+IwtGosQV/xuRDpRUoVzta5Zl4/T3bE
         /sRGCP2tjz91SpHg82OgRzWZZrugB5AxybUo1khCBEqN2rC9xH0U7yhpkM4FA2WQe4Go
         kDYU6s3aHcwY7iNg4Fu8cDpxZz6Sw/iSZ7NTDgfhifBPVP9VEp1gtDMnG21gtiLjiyVA
         W8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RR3PjHV9nmH/GbIhDoQ0i32DEOxqy1Cnfemy+zsHX2M=;
        b=P8wpMe3nCEXHMHT9rHtc8UGI0qGUMsog/kJF9NOTqJnaP8FevOFflSu/HAf9fxTIJy
         vUyehL2KluIlEBTQpPi7yt7BpljocypP19PWJw+AkNjwDYvMCziLhbWPHgIPvpRCBJhn
         o4STrL+evkyOMWlBpTrjOsKdgi7mgo5+35Va8quw1D+G1O/mT+cKUbDC7aWC4gpBJBC1
         wJyTAvwzRJmQ3VvuzaLK4ma1g7cIkuC20O4S+gATR0mILjCaxQEds/0PCFUq4sVRKLPM
         roWUlorF14wyztnD6dcVyxI02mc9ILe0f6drbAlsdIs9xrCcMQw9KCZG6H4j5cetEALw
         BoVg==
X-Gm-Message-State: ACgBeo34zNVUkc0MuI4o1E+fMBGfuuF9hp10zyIfkSvYkIzJJ4fZPlol
        YSebE2/5zX73vyx4tk4kvjwELg==
X-Google-Smtp-Source: AA6agR6DyUOR+dEKXcroet8OSjPW5hDJTdHMyxeQlbulwrF+Cf1t0W2pj2y21Qq1pTGqu8uHmK0r5w==
X-Received: by 2002:ac2:4901:0:b0:494:88dc:7efc with SMTP id n1-20020ac24901000000b0049488dc7efcmr843550lfi.408.1662545783806;
        Wed, 07 Sep 2022 03:16:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 14/14] dt-bindings: soc: qcom: apr: add missing properties
Date:   Wed,  7 Sep 2022 12:15:56 +0200
Message-Id: <20220907101556.37394-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APR bindings were not describing all properties already used in DTS:
1. Add qcom,glink-channels, qcom,smd-channels and qcom,intents (widely
   used).
2. Add power-domains for MSM8996.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 5b9b9c86e61f..02a261ace221 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -20,6 +20,9 @@ properties:
       - qcom,apr-v2
       - qcom,gpr
 
+  power-domains:
+    maxItems: 1
+
   qcom,apr-domain:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3, 4, 5, 6, 7]
@@ -52,6 +55,26 @@ properties:
         2 = Audio DSP Domain
         3 = Application Processor Domain
 
+  qcom,glink-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
+  qcom,intents:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of (size, amount) pairs describing what intents should be
+      preallocated for this virtual channel. This can be used to tweak the
+      default intents available for the channel to meet expectations of the
+      remote.
+
+  qcom,smd-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
   '#address-cells':
     const: 1
 
@@ -171,6 +194,30 @@ required:
   - compatible
   - qcom,domain
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,gpr
+    then:
+      properties:
+        power-domains: false
+
+  - if:
+      required:
+        - qcom,glink-channels
+    then:
+      properties:
+        qcom,smd-channels: false
+
+  - if:
+      required:
+        - qcom,smd-channels
+    then:
+      properties:
+        qcom,glink-channels: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

