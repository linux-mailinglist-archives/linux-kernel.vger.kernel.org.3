Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3555883E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiHBWLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiHBWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A92F038;
        Tue,  2 Aug 2022 15:11:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so3055736ejx.9;
        Tue, 02 Aug 2022 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8F1zVGH36J0JkdBUBvKRRUtEuBe9FAKq0qw9mWpiyHI=;
        b=eK1MdAMZ8tMmA4PIq0UT3eU1SqyjQ1Ih0nzCRxWsKy5gM2KWUVNruzoRd0MbU+63SF
         q3Unkuncwd2xyKCK9fjusdGZNBaFLsLM7cRpluuWZY6XqiozxxWKWyUqVHsWiye6TyQ0
         +bkt0anPppIQBYRce1BrPvAd8SPRNakB/GspVk3NJrtCFRJAeVc9647Lb2E3aTNjgd6Q
         B3kanCmqq9OJ16bFutCAkbsfDNc0xEHRDUZJLRYdtPDkbXSd75hYgPjDPhuLDuBr3uP8
         wbRPrFAI3HDKAWMRSGbqTvZIEZKynXirTNUusd9QC40kH9UKxAXjfIkpV4SY7Lx7SpFH
         iIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8F1zVGH36J0JkdBUBvKRRUtEuBe9FAKq0qw9mWpiyHI=;
        b=zYF7SSmN1wUmv98WzVb6vAlEWtv49TOSw3GU9Xs3ICTIUXB4NGhQzSyZEkWwn6VPDc
         pYevDGr0MNTPcUkaDBgyNYv09FVuYi4PiIAKcsWiJg6K5banH0rPJPzKxKRc55OFUldr
         0R+kgIc/rAFfawMj97GzcRqUfe04gXEc11phAOBh1VpJAb800hXb61ig6ZUFfAhULElF
         oCjZ355+9atlDExHxVZqCoJd5Wynr7WN3I87b4gyvr/fa0qWw9zcC1jyxRhIhys3OfZY
         Z13DzAj8hE3iSHAF4M9Xa2ZRoqCXRx3P5Z33wqHU7GmcuQzHav0Mw8sKscRWW/0TFhpX
         g23g==
X-Gm-Message-State: AJIora9elndikuCcpPrdQSTmEg+nXvK3DEOuvmJwn3nACMrLlGyyQN7z
        p7h/u+hgMdGv5jmdmsl5WAo=
X-Google-Smtp-Source: AGRyM1sE27EvWFS3GlkGtuBmJo4IkxXetpDJJ8DezcQnRLWu3Nx1KMQ5kG/xujmdP3PCQB1nUufnyw==
X-Received: by 2002:a17:907:87b0:b0:72f:8d3d:2010 with SMTP id qv48-20020a17090787b000b0072f8d3d2010mr17947870ejc.743.1659478294501;
        Tue, 02 Aug 2022 15:11:34 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id wc7-20020a170907124700b0072b55713daesm2885560ejb.56.2022.08.02.15.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:34 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/13] dt-bindings: regulator: qcom_spmi: Document PM6125 PMIC
Date:   Wed,  3 Aug 2022 01:11:01 +0300
Message-Id: <20220802221112.2280686-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
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

Add support for pm6125 compatible string and add relevant supplies in QCom
SPMI regulator documentation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/qcom,spmi-regulator.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index da644c161e99..24108d0e4c4e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - qcom,pm6125-regulators
       - qcom,pm660-regulators
       - qcom,pm660l-regulators
       - qcom,pm8004-regulators
@@ -106,6 +107,25 @@ required:
   - compatible
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm6125-regulators
+    then:
+      properties:
+        vdd_l1_l7_l17_l18-supply: true
+        vdd_l2_l3_l4-supply: true
+        vdd_l5_l15_l19_l20_l21_l22-supply: true
+        vdd_l6_l8-supply: true
+        vdd_l9_l11-supply: true
+        vdd_l10_l13_l14-supply: true
+        vdd_l12_l16-supply: true
+        vdd_l23_l24-supply: true
+      patternProperties:
+        "^vdd_s[1-8]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.37.1

