Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED35B185A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIHJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiIHJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:20:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B882867
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:20:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b19so19115109ljf.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/9JIT1QugDrGf1OxGIQaaREkYREoMbYTQ7fht5bGWRo=;
        b=YH94jeZaGjiAt7N+BveeNhCjiyHS8gGpaC7ynzdJIJSi79FbinYrvwnS9chRBNsRKy
         e4hVRcwqpMWL6j3YXLpHBVA2IUVoo8onXqFgZfpN/v3E4JLZPb+TV/0+zd/vDyoBCPzt
         cO3c1Y7GUSJCq5Eb6jD23btbrl9YzLOoRnuMlPLwI6A4aHAvY0/1oyWTQjxtQXBry4+2
         xQb3kb9/quVSx8WaMQ7Nrp125M6wCbc5hV9UkxJRsCx/phtRVMlXD9LqmIT0ka+XQUyg
         qKqJVsjeYHT/N6adkR5Cmxq1swbUHq62aYTmN1T4MSzk6sQu4UbquUvAOK/vUfIGJ9gO
         Ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/9JIT1QugDrGf1OxGIQaaREkYREoMbYTQ7fht5bGWRo=;
        b=UkZYsgpEBNgTNokG0N8DIqnRuo/3wxOsZ9fEIFnYXWYfhDMmF3nP77tXv8ZedxfxWW
         0RBh0gPbT5LmCQjoEs3ymjkChYn8wYXXTCgW6Ip29Sn7fo4qyZ6d6YWmF9Zc/6aYipXa
         eWCroqmXhgKHTa9dzc+51vw1IPV+VABrZGyRDZ/QqNTQPnSCK/dkSv8/63vpzDf7bJ6Z
         oC+rkgb30mWlDtQ4yQG6bqC0pKLX5L8N1ooObLv9hiLf+h7e3PLWjEH9Sx586CUisRCb
         GOI+ppBWxGNsSbx1zlZs63se6G/Wp2Zl2c1LDKcHboNDZ+wG+h2X/+sKSJGXAaf9gqlC
         NwMw==
X-Gm-Message-State: ACgBeo0WjgHHTBXhSS++EvfflWVNMqU3m43ZzsOtY5BgBiS4wh9E/YuW
        6uosZEGBj12u9+KSjlK5Eop7lA==
X-Google-Smtp-Source: AA6agR5ZHgdochYVCe6yWvNjdCbg2QV60T6mhPC8fkxAHTK0UGiiIg6GTAhAHUqM+DMyuMBanE3Oug==
X-Received: by 2002:a2e:b6d3:0:b0:26b:ddd7:919 with SMTP id m19-20020a2eb6d3000000b0026bddd70919mr26695ljo.491.1662628808264;
        Thu, 08 Sep 2022 02:20:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:20:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 14/14] dt-bindings: soc: qcom: apr: add missing properties
Date:   Thu,  8 Sep 2022 11:19:46 +0200
Message-Id: <20220908091946.44800-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
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
index a1a8f77beef7..4060bac759e1 100644
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

