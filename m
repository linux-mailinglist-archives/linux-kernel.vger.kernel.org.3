Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1453656D7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGKI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiGKI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:29:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE9BC8F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a10so3505387ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECmDrApCWmsy6bTxbWAJtF1tb5Jnxl9Hmbc7aLUQ7zs=;
        b=oc6SX5BfT6fMqrx+BbEtw0q8Ed8qK5l+j90ZAz+9xdJ25Woju5BEhRm4dCPVua7FVY
         zWs6IgK8XBHs8im6KsI5Vyqx19oKQT09IBwEsEl6PRSIr55fVrCeCLxynNoAoeYozPcI
         Jx5tCjylNt8VH3Aau7SZX48ZhaZuaAkh/4m/7mDSi8ECJTdDtV6ZyEYBWNOJ58zLl9it
         TB/IkamP0veGlXRApjAHP7walbdH6sIXa7P+SMwLqal3+PG28PbmFnEgWcfT9wQ/yMfx
         dNVudd7OMTXTHnZIl8Kqhhz+uFHC6UjFLUkaa401EjeDp7ptx1LD4YAFdhIdDfIJ6yxC
         lkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECmDrApCWmsy6bTxbWAJtF1tb5Jnxl9Hmbc7aLUQ7zs=;
        b=dzW6T4nj6Mhbn5bUqMxyyq6ueEho83eu4HXR+hlZrJDUFsP9AbTiuhnaBIqdwWxtAV
         qP3BEx7Gavpiv0t41ooZWE2yneSSsgl7vF2+gMsjrQi1TVoCn83lJTDcyXgRR1/XGkQ8
         FmZ8SVvZKygQZmbe9jLXaVt3JQTJTWRalOZQG8sUi6i8UZ7muSbBT4o9zvgM8PRV8knr
         SnSp+bzLeF7w7UDe4IBU6SC+88vS26t/gWsZmvQ9qrMEfsR5kmXnqsIHQsrP+WAKcWmj
         M+ywSk4nhnWd5SsYr6d4HoSa87LBsvBonnS+HKXiXRTb2V7h5w17w6h+mhwVHkObvTdB
         HLag==
X-Gm-Message-State: AJIora/uj5kH1prYggo9uqyC5nfOguSZ8zvMCQEFiEZ6VIcodOBrvmq+
        0xT59GDdqNSNM1XlAwrH8YDlRg==
X-Google-Smtp-Source: AGRyM1uQLnnh/Pu9iJAGaTHhyYJeXAp8YyKuN7dPfR9tj5ox+SHwzeeUfcNoeW4io7jwBOYyPmtzVQ==
X-Received: by 2002:a05:651c:50f:b0:25d:64a7:d358 with SMTP id o15-20020a05651c050f00b0025d64a7d358mr4895586ljp.523.1657528190568;
        Mon, 11 Jul 2022 01:29:50 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u2-20020a05651206c200b00488ab8914b5sm1401504lff.213.2022.07.11.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:50 -0700 (PDT)
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
Subject: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names perp variants
Date:   Mon, 11 Jul 2022 10:29:37 +0200
Message-Id: <20220711082940.39539-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
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

The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
v2 or v3, so it is not entirely accurate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework the patch based on Doug's feedback.
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc6e5221985a..2f0fdd65e908 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,33 +49,11 @@ properties:
 
   reg:
     minItems: 1
-    items:
-      - description: Host controller register map
-      - description: SD Core register map
-      - description: CQE register map
-      - description: Inline Crypto Engine register map
+    maxItems: 4
 
   reg-names:
     minItems: 1
     maxItems: 4
-    oneOf:
-      - items:
-          - const: hc
-      - items:
-          - const: hc
-          - const: core
-      - items:
-          - const: hc
-          - const: cqhci
-      - items:
-          - const: hc
-          - const: cqhci
-          - const: ice
-      - items:
-          - const: hc
-          - const: core
-          - const: cqhci
-          - const: ice
 
   clocks:
     minItems: 3
@@ -177,6 +155,43 @@ required:
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
+          items:
+            - description: Host controller register map
+            - description: SD Core register map
+            - description: CQE register map
+            - description: Inline Crypto Engine register map
+        reg-names:
+          minItems: 2
+          items:
+            - const: hc
+            - const: core
+            - const: cqhci
+            - const: ice
+    else:
+      properties:
+        reg:
+          minItems: 1
+          items:
+            - description: Host controller register map
+            - description: CQE register map
+            - description: Inline Crypto Engine register map
+        reg-names:
+          minItems: 1
+          items:
+            - const: hc
+            - const: cqhci
+            - const: ice
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

