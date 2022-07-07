Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27579569C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiGGIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiGGIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67431373
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 19so407271ljz.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1Cekmq7TYnVG5tqYEZsZt/zviIxcNS3D+dEpzhRHwU=;
        b=Omcc45hH1GiKX1/GhXujp0AuDRhFvjJOHcXwPAIlBBU+iqACbHOSYHLKyk9AnZBz0j
         eiQlKFTlcUgUdMxuwMF/HVE2eXUdv4gg8jKdEU3iG1dx8kVgRLhcFXMl+945YxLFx03+
         7iqkr1nOpNyfUUy7HSaIuy/CCMV+QGlQ8j9WbCLA2W5fMrLKOwd8A6TykeNqmk25IIyi
         DXa7Wlxw9cXsl/93/2Q7JvPghbMyyP6Czt+GtTwMom4UKfH0mC6No5LNP7Kx7dr6fVHc
         uDS/kfc0K8OmbHzEBygb+Y/YgPJ2+rgzwl1a/mYs03hqVOTh1U3dSRgRJ3WVQSq1yHW2
         cJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1Cekmq7TYnVG5tqYEZsZt/zviIxcNS3D+dEpzhRHwU=;
        b=d5owLf653KdSORwwRK4DtR7yv0ktSc/HA9tSaA+naucUU6b7Wu6VRDNjfoAoRzQ1HR
         Bysst/LkFEZfj7nZ+ew/VyjagWPEqF58ZEg84+6igMBVSs7HPo2yrKySW83ZbkaA+PsR
         Mot+1KCwPcVM2G9E8kXddaYy+EcdP3olyU973Remu0CLU8HbEa9/YKHhfoiOBrburnvA
         itnBuLoNkQZugs6NFzagaWB7lFjqKbVNRk5RcKa8//596VuF/oWq4pv1NaxCNeF3O71I
         zKrTg9qgl7pdSbw+H+CJ+Xsdx5XwSwuueDrin5qZgpk7Gky8adzOh5J/5UNbsuO7Eos5
         U27A==
X-Gm-Message-State: AJIora8YnPI/YPjvbMQhRJ7cw0yqdzgYlLzEhZwVs66cs4dlzblEO9iI
        PcZwiZjeCqgRtn5WnvzmoAOnsg==
X-Google-Smtp-Source: AGRyM1sVYGg01zQzr/CMPKBYHIrqCPfa7RVWy+4aECW25nqKJ/ylq/PwKJZR0WNGP3962VS82yBRAw==
X-Received: by 2002:a05:651c:4d1:b0:25b:b6ab:5b56 with SMTP id e17-20020a05651c04d100b0025bb6ab5b56mr27248114lji.84.1657181080560;
        Thu, 07 Jul 2022 01:04:40 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names at least for one variant
Date:   Thu,  7 Jul 2022 09:51:48 +0200
Message-Id: <20220707075151.67335-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
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

The entries in arrays must have fixed order, so the bindings and Linux
driver expecting various combinations of 'reg' addresses was never
actually conforming to guidelines.

Specifically Linux driver always expects 'core' reg entry as second
item, but some DTSes are having there 'cqhci'.

Bring at least some sanity here by enforcing one known (used in DTS)
configuration of 'reg': 'hc' followed by 'core' for older variants.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 10707c4f7184..ac48e36a6949 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -176,6 +176,22 @@ required:
 allOf:
   - $ref: mmc-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdhci-msm-v4
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          items:
+            - const: hc
+            - const: core
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

