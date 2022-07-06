Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28CF5682D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGFJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiGFJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:06:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3C20F7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so8623089wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7cJlxa5ip0o5lrSA1Cq27Abc5a+ZcugcbcpPEkeHA0=;
        b=BfBzAqSa8w4fzWQfTTC5FNOLO2uFMVd7IYdWjSD1AGYBlpM8m5TE1ecjewFy4BzQdm
         FplphJsHz3EMKXLnuHO0YKsCoQMx9RNS6XtxNkdrGzCO6zQdxMATQaL8JL/UnQKwIv5c
         r/dKRE5+NOm78+DireDdXfXz7kYN9M2FmHCjQJNAlJkuAE5oh6lL6xe5FEcOBLKr5DYL
         cAAMmtZtdp+qJ+In3wyGnuARZcJJDnCvMzxpqfqdiomMHErTKlnxg2tQyzjSZRmh+EJU
         bAqN98KmOGhaUC5nWrNl1UZjuXvogwdsAedOnXZEBJcsl9x4KytoIM8gc4N7HlsFQAef
         hR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7cJlxa5ip0o5lrSA1Cq27Abc5a+ZcugcbcpPEkeHA0=;
        b=NtBOBeip7XVXJYjsH71OIaoC1uaOX1kCG8rkgaQX4W8axZP6mc3Y6LctcjDHmbNOGF
         aA2Gav3f5I+V4mb/8v2LdrH8tEbKhCbvdVpn2pyS9nyM7RMWsXw8uh11s7X62WaplEmu
         HcgLlYceTE0zcT+aej5OsHXe7aG8koRveRA1UWVF8agjoDscKLqNI8R8ySEWrzg4VC5z
         9X8p0Vm+51QQ7n19HEJOXrfl5/mF0EoMgV6YPyNqCpZoR+6pmTGNy6mgfjBjaQrW9vrv
         nLWr7FkZCOXANFa0jIOtFeiAxtPy/uhiXp1hBu1PrS3eAY76qZPBvMHNjiVcxzPyVqUc
         S/4A==
X-Gm-Message-State: AJIora83dM7HLvD6mCdg3d537o2lgSEl7jB/Im+6q9DAqvk8EJmxc0WI
        TEI+0SqpTHux0fdLsRz2589n0g==
X-Google-Smtp-Source: AGRyM1utZG4kGVK/bdSC11gh5qhrQPpgTsu7xN4H/jrdTP0t32LTuyn3YGK5ZUhfv+JR9psfGdVT3Q==
X-Received: by 2002:a05:600c:1f11:b0:3a1:967c:5f0d with SMTP id bd17-20020a05600c1f1100b003a1967c5f0dmr22483370wmb.26.1657098299074;
        Wed, 06 Jul 2022 02:04:59 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:58 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Wed,  6 Jul 2022 09:04:04 +0000
Message-Id: <20220706090412.806101-26-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest addition to the rockchip crypto driver need to update the
driver bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index 8a219d439d02..5bb6bf4699ff 100644
--- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -13,6 +13,8 @@ properties:
   compatible:
     enum:
       - rockchip,rk3288-crypto
+      - rockchip,rk3328-crypto
+      - rockchip,rk3399-crypto
 
   reg:
     maxItems: 1
@@ -21,21 +23,88 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aclk
-      - const: hclk
-      - const: sclk
-      - const: apb_pclk
+    minItems: 3
+    maxItems: 4
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: crypto-rst
+    minItems: 1
+    maxItems: 3
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-crypto
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          items:
+            - const: aclk
+            - const: hclk
+            - const: sclk
+            - const: apb_pclk
+          minItems: 4
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+          maxItems: 3
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+          maxItems: 3
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: rst_master
+            - const: rst_slave
+            - const: crypto-rst
+          minItems: 3
 
 required:
   - compatible
-- 
2.35.1

