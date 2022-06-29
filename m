Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59955FF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiF2MIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiF2MIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:08:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6DDF9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:08:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so32137100ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQvrq36Ub//nJeMH+4IujCfCMUXPGt0nmKpTahRoY0Y=;
        b=R3rXrWGRkIFrpTNQIko+IMi3mb57TfabMBpZ3vfI0KcKtdCIaAP/zkFKBJO3O4SFJ5
         CjsFghNlc7mUxsI9Z5kmL5awoJ8aACxIVgtvQAby5YMqlFl1hOKpzaDFW1YLNsG3fqVR
         h/PVY/yrS7/pcJbVa5nF+k7uGEAWSEwP3uV9QHUF8KaY7hLbvZIinC8xixeB6vwjJvFY
         FISfCbbsgD0xTzAk3OIhi8VEl3PQZ05V/3e4tSWYEMrVoneC6RtctvSbKad645jUzDU8
         SRxo0I+OREUDOEHU8iz/sStZ9tWYhC8aSQudQx6h1TtrOJuPmHrJxK+46KeMdAn2Cmgf
         pCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQvrq36Ub//nJeMH+4IujCfCMUXPGt0nmKpTahRoY0Y=;
        b=Ymf+Po61qTCJmjygEawELEZbXTq06SYp5VvQpZ2gX1zBMc7mA8Q9t9ydP6+OJ55gnn
         0oG6J0knT35CvQCm8onboTeWkpk5yKHxQGFMHD5JdaEPnqpqldhlUPGqbpRvq9oDGnhl
         AwYeKmCbqTvW/kHaFQWd/ZT0b9unYgJwowXeJS/j+aWaAyfmPWCGYqd3Rxdpak9ZMP2O
         7lbDWE32/Xj2TMesiJEhBZC7+bTAr8CExRb7S4RGeSdmVK6n3vlgPYp3aT/Adhx/aAcL
         Zg5RCswlloZuhelMVyTRXvnahNMSINIXJyl+eGd6jOT7gdk0CKcfyGARGgOf3aBtmy7v
         mN9A==
X-Gm-Message-State: AJIora/E6pzMzA+BX4Is1HqgsIhtfpRCnuqHlxKIN1CttkmhY975jPwK
        7oetAKXhaVu/2JmcP99xmKD1vQ==
X-Google-Smtp-Source: AGRyM1u8EhSLSXoIchWFFE8Kf94rq07ZLyyCvbo6ssbRKd3BYrEFlqS2MOqasNkDpfSA2G5eHDgXAA==
X-Received: by 2002:a17:907:1314:b0:722:fc80:3b34 with SMTP id vj20-20020a170907131400b00722fc803b34mr2949437ejb.583.1656504486124;
        Wed, 29 Jun 2022 05:08:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709064d4700b0070f6855b90bsm7692878ejv.170.2022.06.29.05.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:08:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: media: samsung,s5pv210-jpeg: convert to dtschema
Date:   Wed, 29 Jun 2022 14:08:03 +0200
Message-Id: <20220629120803.61965-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung SoC JPEG codec bindings to DT schema.

The original bindings were quite old and incomplete, so change during
conversion:
1. Add typical (already used) properties like iommus and power domains.
2. Document samsung,exynos4212-jpeg compatible (already used in DTS and
   driver).
3. List clocks per each variant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/exynos-jpeg-codec.txt      |  16 ---
 .../bindings/media/samsung,s5pv210-jpeg.yaml  | 123 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 124 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml

diff --git a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
deleted file mode 100644
index ce9a22689e53..000000000000
--- a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Samsung S5P/Exynos SoC series JPEG codec
-
-Required properties:
-
-- compatible	: should be one of:
-		  "samsung,s5pv210-jpeg", "samsung,exynos4210-jpeg",
-		  "samsung,exynos3250-jpeg", "samsung,exynos5420-jpeg",
-		  "samsung,exynos5433-jpeg";
-- reg		: address and length of the JPEG codec IP register set;
-- interrupts	: specifies the JPEG codec IP interrupt;
-- clock-names   : should contain:
-		   - "jpeg" for the core gate clock,
-		   - "sclk" for the special clock (optional).
-- clocks	: should contain the clock specifier and clock ID list
-		  matching entries in the clock-names property; from
-		  the common clock bindings.
diff --git a/Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml b/Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml
new file mode 100644
index 000000000000..e28d6ec56c0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,s5pv210-jpeg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5PV210 and Exynos SoC JPEG codec
+
+maintainers:
+  - Jacek Anaszewski <jacek.anaszewski@gmail.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s5pv210-jpeg
+      - samsung,exynos3250-jpeg
+      - samsung,exynos4210-jpeg
+      - samsung,exynos4212-jpeg
+      - samsung,exynos5420-jpeg
+      - samsung,exynos5433-jpeg
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
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
+              - samsung,s5pv210-jpeg
+              - samsung,exynos4210-jpeg
+              - samsung,exynos4212-jpeg
+              - samsung,exynos5420-jpeg
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: jpeg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos3250-jpeg
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: jpeg
+            - const: sclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5433-jpeg
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: pclk
+            - const: aclk
+            - const: aclk_xiu
+            - const: sclk
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    codec@15020000 {
+        compatible = "samsung,exynos5433-jpeg";
+        reg = <0x15020000 0x10000>;
+        interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "pclk", "aclk", "aclk_xiu", "sclk";
+        clocks = <&cmu_mscl CLK_PCLK_JPEG>,
+                 <&cmu_mscl CLK_ACLK_JPEG>,
+                 <&cmu_mscl CLK_ACLK_XIU_MSCLX>,
+                 <&cmu_mscl CLK_SCLK_JPEG>;
+        iommus = <&sysmmu_jpeg>;
+        power-domains = <&pd_mscl>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d208bf3b6f11..7669bb12deea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2728,6 +2728,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml
 F:	drivers/media/platform/samsung/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
-- 
2.34.1

