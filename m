Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD974EF79A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiDAQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353012AbiDAQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:18:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DEA20A3A2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:42:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so6647876ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvLYetfC0M8ee2ZpgnCvvT8BGE0UJGsuIlJ++425c5Q=;
        b=PJLevIDANrLODu8fBXwyylwK97oTmcegFajjWWGAZOm7niuglbhgOpzthyJV4IGp01
         aN9FM2b/uD2BS4esIiMsfm1CDjdsxhppDuCcAoJiv+jcRWMSt3Yim5gpcx9sAoTOpsr4
         3jU4aKR965lWuxySpybk6bQjcsLq0orOa9I2KhhwMy8WC1Wt1IMmumuocBuAbuIFPrEQ
         KFXwtaS5EbO81nVg4AOEb09BpAaEMBYwlxBLE1DmGhFagM839RjR/7c3dAJU4QEwJ2cW
         ToJ3JOkX5w5b4fGpxixqtINo7nMiZcgf2XK6PIsWHmwujtQqciUrbKlnwehnyVTsaTTi
         aUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvLYetfC0M8ee2ZpgnCvvT8BGE0UJGsuIlJ++425c5Q=;
        b=ikrAABB8Q+E7446UijyBV3X5wdi/oTNaph15leox/ZdxqyoUMq1KVgNNxloBh7DFzD
         D3LzySVkCKb7NI4HAJulzUDYH4f+bVDtuQOyDU2dTdAdNEroMiJK7sbZ3VqPzsz09Fp+
         ZV0LeeY9uKIQab3ANb8dZyGYB98bKYrIoCl0CnYUO92hDHfSg/juW9/qQSlbHSG/ukud
         H7SWbIwjyVARfU3Hu86cr/zKjQeiAM4nxh8xZJ0zK/RTuK/W3WxHsZoPBtlfFvfhNfjB
         +xli/5hfotM9LJs/YYtNuZPcj5vLkl65y/lUHpqH6Sd4NaUY1WUZsYN0iibPkt2p+PP/
         /rvQ==
X-Gm-Message-State: AOAM532DXDyaT9c/kF1r1pGC8lYS4KdUs49S69DEf0KQFQEhSpHEk9u3
        7PLpcyaUc5OppiyoBJqKkFH3cA==
X-Google-Smtp-Source: ABdhPJx4V0qZLEwhvDCy4+cT0n9AkXUO/yzATDyh4tBTtpxZS5WH0DrunhCmOHIu7kIIBGw3uJgdug==
X-Received: by 2002:a17:907:270a:b0:6e4:86a4:9b09 with SMTP id w10-20020a170907270a00b006e486a49b09mr354177ejk.23.1648827763561;
        Fri, 01 Apr 2022 08:42:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm1300389edq.81.2022.04.01.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:42:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 1/2] regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
Date:   Fri,  1 Apr 2022 17:42:36 +0200
Message-Id: <20220401154237.1061331-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
References: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
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

The binding and driver duplicated regulator core feature of controlling
regulators with GPIOs (of_parse_cb + ena_gpiod) and created its own
enable-gpios property with multiple GPIOs.

This is a less preferred way, because enable-gpios should enable only one
element, not multiple. It also duplicates existing solution.

Deprecate the original 'enable-gpios' and add per-regulator property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

