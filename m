Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21B4CD434
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiCDMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiCDMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:25:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14B1B01B4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:25:04 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AFEAE3F623
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646396702;
        bh=kgcW8NoeEKgqEQpiOeMGrdb/y3sIE8kBcUfOjO129hk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Uz7AWpXdNx4Yn35whPB6Z1abHFQh4mC18Q6whzBi1mN+hcSoGhJJ8oc3XI6TJg5E0
         bm3lYF4llEAb7FVgJgPpXUuHBPrjFWXSXktZLam5He59JH+UXRsHwht4zwL6ciRSNO
         11sWe5ahjLl+LR44A49UKjD08ddsItCgrw5wUhPt/i1d+m2NMV5wV099WnuZZ7soJ8
         hmPYF4hUICafvD69gK0dyWaIewNW9NE1QALyNVSkcWMj0Vl+ZNHlbecPvWFd8+WYAr
         ZHMf+E4V7/sDv66A8n5aUaWYwnXUumvq/rjayYPccqZsYDsWEAg3NUYU//fTg+YM3w
         9Qrtnyuovz+9Q==
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso4313615ejk.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgcW8NoeEKgqEQpiOeMGrdb/y3sIE8kBcUfOjO129hk=;
        b=fxiYqE1joC2DIs5hjzogXmuzBbSeFEHFc8zagz5LDjgNN/LugGS04UbQy4AZoegbd9
         GlkGw5NX4akOi/2zqkP2naXjWK4RUnmF4rG2yy9suAEXQd/TAt34gQHmT0YIKXPBZZ0v
         wcUbXeYFMtr/oJo9kBBkoNHt0UvQPSsbwefxARTDvSa4CbRAIPgHCZEm2P8lmyvLwz+v
         p8uX+d+bR28HACjvfeE0hMPzTfrM4In2Ufn/3TJgnFjYRFz1PSvdyKfn4OtuAl5DnL8q
         qr7x/Fagvg9h3nNJ8oFbXbzlokF7+nXzp3fSy5QDMfBkNAJcKcm3FULg20XMBXG64sKg
         gEpw==
X-Gm-Message-State: AOAM530oxRg878fm3WfNFVQzdYPXrvsIiiRkRE6gTjswpAmEovXLXCtH
        MS4AWytfTNNlkfdYl/z0okEOZ5ZS5wP2QSYxtZLWoEr3GGYwwtLUrkTuMRAal4wQYG5qIXku1TX
        KVtKLIM9uWMNurcZf9Ng1xTWP51DTgQ9c6SGqtwYlUQ==
X-Received: by 2002:a17:907:70c1:b0:6ce:78ff:bad4 with SMTP id yk1-20020a17090770c100b006ce78ffbad4mr31164820ejb.68.1646396701950;
        Fri, 04 Mar 2022 04:25:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6Wvt1ALjXyOY5O7427bhp34XMAl6I3Ap8zIOpaKncvQpm4/ZUjYymTNh6SzZvWw89ZXr/bw==
X-Received: by 2002:a17:907:70c1:b0:6ce:78ff:bad4 with SMTP id yk1-20020a17090770c100b006ce78ffbad4mr31164791ejb.68.1646396701612;
        Fri, 04 Mar 2022 04:25:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm2047368eds.4.2022.03.04.04.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 04:25:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: describe known hardware and its interrupts
Date:   Fri,  4 Mar 2022 13:24:21 +0100
Message-Id: <20220304122424.307885-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer
block, so only two compatibles were used so far (for Exynos4210 and
Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
However the Exynos4210 flavor actually differs by number of interrupts.

Add new compatibles, maintaining backward compatibility with Exynos4210,
and constraints for number of interrupts.  This allows to exactly match
the Exynos MCT hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../timer/samsung,exynos4210-mct.yaml         | 67 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index f11cbc7ccc14..1584944c7ac4 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -19,9 +19,20 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - samsung,exynos4210-mct
-      - samsung,exynos4412-mct
+    oneOf:
+      - enum:
+          - samsung,exynos4210-mct
+          - samsung,exynos4412-mct
+      - items:
+          - enum:
+              - samsung,exynos3250-mct
+              - samsung,exynos5250-mct
+              - samsung,exynos5260-mct
+              - samsung,exynos5420-mct
+              - samsung,exynos5433-mct
+              - samsung,exynos850-mct
+              - tesla,fsd-mct
+          - const: samsung,exynos4210-mct
 
   clocks:
     minItems: 2
@@ -63,6 +74,56 @@ required:
   - interrupts
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos3250-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 8
+          maxItems: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5260-mct
+              - samsung,exynos5420-mct
+              - samsung,exynos5433-mct
+              - samsung,exynos850-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 12
+          maxItems: 12
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 16
+          maxItems: 16
+
 additionalProperties: false
 
 examples:
-- 
2.32.0

