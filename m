Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932B50DA09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiDYH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiDYH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:28:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7C65AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l18so1223269ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoODso8L6sa7HFQHYsZaXkKgSxN03O5HRSF7TAtJ05I=;
        b=AmFJus8NbOetI0QrnOux4GaQiTNEofANqLpB7A6WRugvw+OiMut0H+jUTEvwyA1mp5
         anYXLqISWTmYpVLdwOY8UCmXf7mq3ey/Koa/LqhF+d/+x5fUTZ7LpYP1icCHSPTrIXLo
         lKqFRc5yf05azrnqzYn23KQ1uy1SChcRflCmL6UGtZ7qQAume+Yvkm3+D/AtVaDufuUj
         v1XsKaV4lNwI6MzK/Y0sQT0HveaNT6G3VvcEYQn4V1ZjvWNr4irj1LwCemc6FnKx/fKd
         WbhiGR/OQwbW0pdJC8F6sOuclj/WGeFCj9nmG8cHT9xtNeJfQFAaOtoksFwu6XbBGK2G
         xSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoODso8L6sa7HFQHYsZaXkKgSxN03O5HRSF7TAtJ05I=;
        b=vetCfaQoiE9xMcxpuVPPSOmyyBcQkQZtUEMeSLiYmZ6GJiDhhXegPcDLiwPsbs065W
         oOZ9hXZWBYP2RAYK2vG9nEa1APafHJhdIXitU/BONacMMxYHUqu1WfMuf6gRztrkSvf6
         bCq2IUardFrNh8zCwIeLk3Nj7cH6qsTcJ5F97Tfedyyjib50MCwTANa0gZyYtLSUUlKR
         86u7fBD4izjKKHXo6wSQ63S7xo3kT9vNQJfFe8fia+vIQVJO3202GfNZcWjd2423A7LW
         3GVQx33A4axSHZI8fw8U8h26hv3mVLvUgFk2aTTSOGCIHNRUY7kiJ4/VaMNmvpJHg59B
         1s6Q==
X-Gm-Message-State: AOAM531PA8Zf1TkmbsCjv1VmKfRGoPcrFhwFom7Jf/7r+1rG1oA7ufKb
        lwQb4+ZDftrepyxlNOzoBb/ijg==
X-Google-Smtp-Source: ABdhPJzKnpdptt08dU79kDGzwycj/X+olIfJ/74b/VfkbElhCem+dohAecEIbqRw08tw5aKsrtzVOQ==
X-Received: by 2002:a17:907:2cc4:b0:6ef:8108:ad11 with SMTP id hg4-20020a1709072cc400b006ef8108ad11mr14851775ejc.20.1650871502729;
        Mon, 25 Apr 2022 00:25:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ew15-20020a170907950f00b006f3a3d60b9csm44328ejc.63.2022.04.25.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:25:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
Date:   Mon, 25 Apr 2022 09:24:54 +0200
Message-Id: <20220425072455.27356-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

