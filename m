Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB79C4C5654
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiBZNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiBZNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B54617B;
        Sat, 26 Feb 2022 05:52:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so16112505ejc.8;
        Sat, 26 Feb 2022 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9jUsMvSJyjDnNMHHbljdznqa7LR3R0B/qy7w2RSz/mk=;
        b=H05gK+0bMaGiC/w+JcWsGUCsibkT2s84QxftVLKCH4UdvtFoQ/XmxT2Pq2gQZoF9WZ
         2tTGDeehuVGajUxyvlqaSJRAT0ERSZ1EwmujdsefxxHPJ0zxGTac35NDq0oCXsvrr3xI
         TpR6/Z7VJpPvXEXMvxynoIo3iBKJKESJT1C7mtGUECcxE0vS1Lf7ZWBd+CemDpRqJ5pC
         ipxzZm0snZQC3rEEoMY0pF589ItKFGFb36gEmsim4XVS2mqQWKNcmU55GZsqlyYt4KUU
         pP6RJILZpfpUCdYWZ5tYQg6F+9aDrlxOKVzO0LHS7gcVdTdGvdkdkYA2t+4bVraC3jkW
         O0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jUsMvSJyjDnNMHHbljdznqa7LR3R0B/qy7w2RSz/mk=;
        b=sLOp06cm6mVa/D+Hp55+E9N4TKdQ6P3jGT87wlkgwso/n00YO4XkQPc2ePCCsploAB
         DO32ZZrsCBqVUOlyntiiwG+rf+j+Ddd6LYABMeNJSTngLhOMSLmJtGjnHcUBjWCPYksF
         xkuMUkLbiXuleKHfBXKlt4/pVL4rAPBRbZ8Nwj+Uhg5xgyFWSdich19FAUlp/7ywYEWD
         lE2D+ZGrZBRQrJ4mTC8xn5FJY9NwmnvluYWW88IeTSesECWUUzR8E/weGU5AUjTPUFb4
         oPgY4uAHZuz/Z+QuxbXqX8npf4WUm0CNyXQ3h1jThhvMc6JrXAnESr0ysoDyShMcorGM
         21LA==
X-Gm-Message-State: AOAM530ar19FXMSyIq2OUvJk5GABd3r1ysbVDXa8cCUFr8f2eYHRx5vI
        slfCZufDuSrK3y7Fja3tlYc=
X-Google-Smtp-Source: ABdhPJymW/Jvc3QnFLQP/cL/hA4HLASEqWkD3Y88WkeQ/xKVwIex1krb25Jh50cKegbqNlFcnLDJPA==
X-Received: by 2002:a17:907:35cc:b0:6d0:9f3b:a6b1 with SMTP id ap12-20020a17090735cc00b006d09f3ba6b1mr9771189ejc.586.1645883559495;
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Sat, 26 Feb 2022 14:52:22 +0100
Message-Id: <20220226135235.10051-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
template and remove the compatible from qcom,gcc.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
 .../bindings/clock/qcom,gcc-other.yaml        |  3 --
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 8e2eac6cbfb9..97936411b6b4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
@@ -17,22 +20,12 @@ description: |
   See also:
   - dt-bindings/clock/qcom,gcc-msm8960.h
   - dt-bindings/reset/qcom,gcc-msm8960.h
+  - dt-bindings/clock/qcom,gcc-apq8084.h
+  - dt-bindings/reset/qcom,gcc-apq8084.h
 
 properties:
   compatible:
-    const: qcom,gcc-apq8064
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
+    const: qcom,gcc-apq8084
 
   nvmem-cells:
     minItems: 1
@@ -53,21 +46,13 @@ properties:
   '#thermal-sensor-cells':
     const: 1
 
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
   - compatible
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
   - nvmem-cells
   - nvmem-cell-names
   - '#thermal-sensor-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 4e5903bcd70d..47e1c5332d76 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -15,8 +15,6 @@ description:
   power domains.
 
   See also:
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
@@ -40,7 +38,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - qcom,gcc-apq8084
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
       - qcom,gcc-ipq8064
-- 
2.34.1

