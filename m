Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5855B23D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiFZNZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiFZNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:25:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F09BC3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 06:25:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q6so13727830eji.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiKv1lNjdaFLZKF/eedD2M8JeMTr8x3pdCy5XsNoJso=;
        b=sE81NNX62DnaLHq0w5kjxuCsUeyc6GdfrT/xOXSu/chg7E4A65AzDGvddl10TAhh3I
         wJp/WMKlWYprCvJDGB4hKolFV1uX8CwcYEZewLwOUWEDvAI2Zb30zizSSmJbWjtZn3ij
         AWgEfyJdAP3s+1gEyVk2cZbHTlM08mEBdn3bEgFdehTbc49GA0HznSkDuws0BxnJ664M
         uMm1yvwcj26jM5anLtSILwY3GTZ0Rh2qdRc7t9lNVv2534XQXl+iLxvO5SQK6LU4HjxA
         xlLAtvefISbBbS5Du/4icfWR5KTXyKF22AemWlSChj/jT9uNz2OEla0z+1rsiF6/X+70
         syeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiKv1lNjdaFLZKF/eedD2M8JeMTr8x3pdCy5XsNoJso=;
        b=SWKMjtHxM2csUwKqjWNiXOnPDC/wVjilLa0TiSxg0yGYd+MTKA+ULcveLut44Y5ja0
         OrxRHEIhg4clbjwXcJ/80Tvh+51xA4BorEKsENcrJ35NEyZxRZrWBs0pDpZmdr+EmTAc
         Y66oXE8Emt6IEarPw3mHc1CLaYrq+uM3JEsrJbmmByO0d8kgzCzwsCT4NCyj6bPjm+pb
         HbG7fX3HN7PNvoqrA8ibAXmY/YsnF/DcYF2cxpDkF5btuqFiYW7DD7WMfEcdXDKYQHcG
         zZi83WFQf7882mdCR2RqhHmZYd8UHCFpSNKcCis5NBavCcb6wARgFVoXEbm7m6g+fiAt
         OepQ==
X-Gm-Message-State: AJIora/ZeDD14ONBOnjDDJRWUW5vRA3lWmMHil911UAPCcWKxqhBFk+o
        c2tS0JFsSpWUmgjl+8sfMv49mFHobP3BAw==
X-Google-Smtp-Source: AGRyM1upixfxPfZKkPJqH/LO/z2QB9qeLPoWbsHiFCIaKTXf9/kbO7Il4k5nivWL/uxDsENz36Iw0w==
X-Received: by 2002:a17:907:6e28:b0:722:e601:a0c0 with SMTP id sd40-20020a1709076e2800b00722e601a0c0mr8256634ejc.347.1656249926188;
        Sun, 26 Jun 2022 06:25:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b00435728cd12fsm5924635edr.18.2022.06.26.06.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:25:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: media: samsung,exynos5250-gsc: convert to dtschema
Date:   Sun, 26 Jun 2022 15:25:22 +0200
Message-Id: <20220626132522.86716-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Samsung Exynos SoC G-Scaler bindings to DT schema.

Changes done during conversion:
1. A typical (already used) properties like clocks, iommus and
   power-domains.
2. Require clocks, because they are essential for the block to operate.
3. Describe the differences in clocks between the Exynos5250/5420 and
   the Exynos5433 G-Scalers.  This includes the fifth Exynos5433 clock
   "gsd" (GSCL Smart Deck) which was added to the DTS, but not to the
   bindings and Linux driver.  Similarly to Exynos5433 DECON change [1],
   the clock should be used.

[1] https://lore.kernel.org/all/6270db2d-667d-8d6f-9289-be92da486c25@samsung.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/exynos5-gsc.txt |  38 ------
 .../media/samsung,exynos5250-gsc.yaml         | 110 ++++++++++++++++++
 2 files changed, 110 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml

diff --git a/Documentation/devicetree/bindings/media/exynos5-gsc.txt b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
deleted file mode 100644
index 1872688fa408..000000000000
--- a/Documentation/devicetree/bindings/media/exynos5-gsc.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Samsung Exynos5 G-Scaler device
-
-G-Scaler is used for scaling and color space conversion on Exynos5 SoCs.
-
-Required properties:
-- compatible: should be one of
-	      "samsung,exynos5250-gsc"
-	      "samsung,exynos5420-gsc"
-	      "samsung,exynos5433-gsc"
-	      "samsung,exynos5-gsc" (deprecated)
-- reg: should contain G-Scaler physical address location and length.
-- interrupts: should contain G-Scaler interrupt number
-
-Optional properties:
-- samsung,sysreg: handle to syscon used to control the system registers to
-  set writeback input and destination
-
-Example:
-
-gsc_0:  gsc@13e00000 {
-	compatible = "samsung,exynos5250-gsc";
-	reg = <0x13e00000 0x1000>;
-	interrupts = <0 85 0>;
-};
-
-Aliases:
-Each G-Scaler node should have a numbered alias in the aliases node,
-in the form of gscN, N = 0...3. G-Scaler driver uses these aliases
-to retrieve the device IDs using "of_alias_get_id()" call.
-
-Example:
-
-aliases {
-	gsc0 =&gsc_0;
-	gsc1 =&gsc_1;
-	gsc2 =&gsc_2;
-	gsc3 =&gsc_3;
-};
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
new file mode 100644
index 000000000000..d12796c2e8a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos5250-gsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC G-Scaler
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+  - Joonyoung Shim <jy0922.shim@samsung.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Seung-Woo Kim <sw0312.kim@samsung.com
+
+description:
+  G-Scaler is used for scaling and color space conversion on Samsung Exynos
+  SoCs.
+
+  Each G-Scaler node should have a numbered alias in the aliases node, in the
+  form of gscN, N = 0...3.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,exynos5250-gsc
+              - samsung,exynos5420-gsc
+          - const: samsung,exynos5-gsc
+      - enum:
+          - samsung,exynos5433-gsc
+      - const: samsung,exynos5-gsc
+        deprecated: True
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Syscon used to control the system registers to set writeback input and destination.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5-gsc
+              - samsung,exynos5250-gsc
+              - samsung,exynos5420-gsc
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: gscl
+    else:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          items:
+            - const: pclk
+            - const: aclk
+            - const: aclk_xiu
+            - const: aclk_gsclbend
+            - const: gsd
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5250.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    video-scaler@13e00000 {
+        compatible = "samsung,exynos5250-gsc", "samsung,exynos5-gsc";
+        reg = <0x13e00000 0x1000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd_gsc>;
+        clocks = <&clock CLK_GSCL0>;
+        clock-names = "gscl";
+        iommus = <&sysmmu_gsc0>;
+    };
-- 
2.34.1

