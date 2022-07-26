Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1A581971
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiGZSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiGZSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A5240A2;
        Tue, 26 Jul 2022 11:11:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b11so27544327eju.10;
        Tue, 26 Jul 2022 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gbThQEF2wWr8opiCHafpxpAiPkAsf/SSIPbn3tmtm4w=;
        b=Vpshm8dpPRXgqugZ7pM7pKW+QDI8Lt+HD7ifkrtRmrSPI1klVUKWcbp6RjVBgFyeAq
         21456ymHFKDFbrzPg5LZ0b3R2UGq8IW4cu6FByTzZ+OtSHZvfuMPI6pOSrEuiwFEFt62
         FPTkocV99aHsZvEzgzBaM7S0LOd1pXB0tijFVdwQWNlVjPmtlcdQS5B6D9HrantXobqw
         aYpTecgFfiRYK9GCHtU9UBAIqwU3UdBmjuiSkBJ/WvaaTlxDpBDBgMTBN/eYkbKNv+d7
         YL4UeUIoWH4rHKyY+DU/jQ8NaYheShYqddLZCHlnBUV9fUV0stz9sHUQAjqJjv4siuah
         KYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gbThQEF2wWr8opiCHafpxpAiPkAsf/SSIPbn3tmtm4w=;
        b=FEOzV4/slIm7WZkdRXcUk2BH7d8W3IYBb8Jk72ig49AbPELPT9alJSTgUPk0hDTQvB
         g6A+hZnHFCP476ktBPeEhGcxZIIuQHplfNdjMiacypCjq7MF4nxaG5Ao5pauKw/7nGq6
         OUUIEDAuIA5G1qPqztJEjaNiNdwXJvTBG+xBBrgImm9qUtOVBA+o7142WTbnVSgOmYrP
         GCpbVA5awijQskCNzq/jjQZ8vHsRVRo1+Lc7o8dC6iE5jdszNTX0BlJFkv1/9+SZ7QmK
         OXi8K3dBrZTFdGziezNRwQZzHz3Qu1ON06TN1SydT3n2j8toqQTDY9pv6qyqKcXXZAM3
         ebVg==
X-Gm-Message-State: AJIora/Yxbfl4BKu4qT6N3HEkVuCGV+WsrK6iM5uFOEH8IhASsOccZLb
        tbqKepEUcYwEla0hInR7Fhw=
X-Google-Smtp-Source: AGRyM1vPsM5OJ6LCNrOf0G1fog3cPswvR9AX31RbFCUu2VGUcwP9h6n+AXCQCUC0cka33nnIdgKvyw==
X-Received: by 2002:a17:907:7d89:b0:72b:9eb4:a8c7 with SMTP id oz9-20020a1709077d8900b0072b9eb4a8c7mr14879904ejc.167.1658859098965;
        Tue, 26 Jul 2022 11:11:38 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id o15-20020a056402438f00b0043b986751a7sm9005325edc.41.2022.07.26.11.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:38 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: regulator: Document the PM6125 SPMI PMIC
Date:   Tue, 26 Jul 2022 21:11:29 +0300
Message-Id: <20220726181133.3262695-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726181133.3262695-1-iskren.chernev@gmail.com>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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

Add support for pm6125 compatible string and add relevant supplies in QCom SPMI
regulator documentation.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../regulator/qcom,spmi-regulator.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 8b7c4af4b551..d8f18b441484 100644
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
@@ -106,6 +107,24 @@ required:
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
   - if:
       properties:
         compatible:
--
2.37.1

