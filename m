Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1650CCDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiDWSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiDWSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:25:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665421F7D66
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:22:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d6so8942887ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoODso8L6sa7HFQHYsZaXkKgSxN03O5HRSF7TAtJ05I=;
        b=IIhMyQGUP+qAMNy+t66Mti0gcd+eMv5Ml05OVND1KL9MNVic87rOjSitgplxY2FPA9
         Uk6hUB8Wwnfva6dvYHwXOnoAUADXD2he6CjRO2lXusuJEoHA7daXLEG9Q7uafEJqw8dX
         v4UvpL+uVFNBfe+wdI+Ni/mNbq73+o0M1gKLqe1h8MYklc6ho1mYsjyHkc7Su7pOsv5r
         OzW5aI1YWvVHHgSgZIo0L2Q6HdyrbFR97Ejm0mahgkEk1JoXgTo33Pi5UN2p49YrH20X
         cCVpxmGKylBeKmq96xcy9jkLfyrJov8GD/xCNZFk9PGaQzePtXmOsB4QLSdqLeW6l8T9
         MzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoODso8L6sa7HFQHYsZaXkKgSxN03O5HRSF7TAtJ05I=;
        b=pjhugrcxYGV8NvryYajDvhkZkp3sXs1DPu6yxONWw/LWkxJFXSZmyqOsUTzXn1L1cT
         ZjlICItpbyPB6/nRxPMCbxnpAQ9Jo5HQIXUpzOH6aG1XXdAec5aZ7FuSYs3xy8JqltT2
         FxNrd/97gs0DPNWPiadtUrLppbp8JU62r939uf7uD4bntdYcNpjuHRJ9xvBT7LKbb/6R
         9TIg8tK2/n1sqBdv6VbmUr54mwwaRVHN0pnRnBnK7PC9O1m4r6H/kJzfm6+T81nDwlyC
         m/3JL5ft1IxXun/nWscMt82pL6y+/Y5ZX5/J9kmtNuVQOvYZ2gRXlCeayDbeBXAtosdb
         Qp5Q==
X-Gm-Message-State: AOAM532I1BQzjdkfVV1Px0rs5QYVIZN9f5QhNbo1zSEr+keXWhZP8qOx
        7WbvtOEkHrNctjO4oZ5VQPMYvA==
X-Google-Smtp-Source: ABdhPJx3YsAVMJBhIghLwOcLGYcr7mGbOJK7z8REh6VI3AXumSRWMKZZHZ6EDcCH5zYiE1Qulb+oFw==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr11372703edz.114.1650738147009;
        Sat, 23 Apr 2022 11:22:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g24-20020a056402321800b00423e43ebb60sm2399227eda.61.2022.04.23.11.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:22:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
Date:   Sat, 23 Apr 2022 20:14:18 +0200
Message-Id: <20220423181419.19397-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220423181419.19397-1-krzysztof.kozlowski@linaro.org>
References: <20220423181419.19397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding and driver duplicated regulator core feature of controlling
regulators with GPIOs (of_parse_cb + ena_gpiod) and created its own
enable-gpios property with multiple GPIOs.

This is a less preferred way, because enable-gpios should enable only one
element, not multiple. It also duplicates existing solution.

Deprecate the original 'enable-gpios' and add per-regulator property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../regulator/richtek,rt4801-regulator.yaml        | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
index 4a4dfa7d9d09..091150c4e579 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -32,8 +32,11 @@ properties:
       If only one gpio is specified, only one gpio used to control ENP/ENM.
       Else if both are specified, DSVP/DSVN could be controlled individually.
       If this property not specified, treat both as always-on regulators.
+
+      Property is deprecated. Use enable-gpios in each regulator.
     minItems: 1
     maxItems: 2
+    deprecated: true
 
 patternProperties:
   "^DSV(P|N)$":
@@ -42,6 +45,14 @@ patternProperties:
     description:
       Properties for single display bias regulator.
 
+    properties:
+      enable-gpios:
+        description:
+          GPIO to use to enable DSVP/DSVN regulator. One GPIO can be configured
+          for controlling both regulators.  If this property not specified for
+          any regulator, treat both as always-on regulators.
+        maxItems: 1
+
 required:
   - compatible
   - reg
@@ -57,19 +68,20 @@ examples:
         rt4801@73 {
             compatible = "richtek,rt4801";
             reg = <0x73>;
-            enable-gpios = <&gpio26 2 0>, <&gpio26 3 0>;
 
             dsvp: DSVP {
                 regulator-name = "rt4801,dsvp";
                 regulator-min-microvolt = <4000000>;
                 regulator-max-microvolt = <6000000>;
                 regulator-boot-on;
+                enable-gpios = <&gpio26 2 0>;
             };
             dsvn: DSVN {
                 regulator-name = "rt4801,dsvn";
                 regulator-min-microvolt = <4000000>;
                 regulator-max-microvolt = <6000000>;
                 regulator-boot-on;
+                enable-gpios = <&gpio26 3 0>;
             };
 
         };
-- 
2.32.0

