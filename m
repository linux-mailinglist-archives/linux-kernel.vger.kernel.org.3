Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D684A4AF211
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiBIMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:47:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC3C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:47:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k1so3839155wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KKYJ6eDy6KSnsSKdeEJDtLtm3smSqg5GzRuwnz+AbE=;
        b=RS6jPHtzTIJDhkk3PdljqHoRS37P6K6YLpDOj8DRjIol0d5IU22yJ5omh4BClCAY9d
         8rj4iecxAZASniAHLurbjkx8FR6SCkc/tGj9gx/yrSyLlZWd3oSA3IkFSf+ZeyrDOYGX
         KS6ZBnauyFzSVGx83yorjIBc/7qN0vtan67xMzLXWd/s2CpYCLpvgqXN45YBBEP2Ss12
         3KxhZM7iaTS9OoAorjP8/rmH2N2chrNYepuCrz7Tfm7OJS1Lupfx9Qj2GF65QiKk7CW1
         4EIsdXJxevbr6zkb/1dXtonKvKeLlols1WCO+Jku/A1OLyDveOB81Mlg/xtfpIq7Tntl
         T2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KKYJ6eDy6KSnsSKdeEJDtLtm3smSqg5GzRuwnz+AbE=;
        b=aTnM/dr6QG021LrSQq1GLNIsxn5ZyaULZYhlUTgtxbPBktX/RQaZzo2MaQI+BZbgAj
         8kNeqpr4fhJDVTd01kRX+78S2/UX9oqc4QdVTZHRntGQNNjv5bTmI1RzO6E6CuHrcbNd
         Q7WdrP6Sr1tlmNjXxI/fwCJhdRaXqEL4MGkCSI8Ptg4MTIseaUMKqsrhG8rTNgCSpbaZ
         /siIJNjAFgb8XmlopBMahR+kpdj8i/hrV2YdrNcJsAmlHKuoJYX8aLkTZqo9XWd5OWom
         QWCwnwJQ6wy/d3/orGSntAOYbggxWU80vVxZeB9Vixl7x7XOTqLLmqdwuGoJqkC+t6Wm
         AsuA==
X-Gm-Message-State: AOAM533WNX5CprCw7FuM9CMKAwWRQZJyBuMhBhZohJm4OesvcYsNWlGu
        mP7EuzZpvKMp24nT+gm59AQ1FA==
X-Google-Smtp-Source: ABdhPJwSsJ8mWCJ3s7wNHrs1Ze3j6HvXeNSDhG9u3iAU2F4IW/6g3LKiNDG5Xk9tl6gLMze4VGEXjA==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr2006142wro.252.1644410852767;
        Wed, 09 Feb 2022 04:47:32 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o20sm5137834wmq.35.2022.02.09.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 04:47:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: crypto: convert rockchip-crypto to yaml
Date:   Wed,  9 Feb 2022 12:47:25 +0000
Message-Id: <20220209124725.2080986-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rockchip-crypto to yaml.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/crypto/rockchip-crypto.txt       | 28 --------
 .../bindings/crypto/rockchip-crypto.yaml      | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
deleted file mode 100644
index 5e2ba385b8c9..000000000000
--- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Rockchip Electronics And Security Accelerator
-
-Required properties:
-- compatible: Should be "rockchip,rk3288-crypto"
-- reg: Base physical address of the engine and length of memory mapped
-       region
-- interrupts: Interrupt number
-- clocks: Reference to the clocks about crypto
-- clock-names: "aclk" used to clock data
-	       "hclk" used to clock data
-	       "sclk" used to clock crypto accelerator
-	       "apb_pclk" used to clock dma
-- resets: Must contain an entry for each entry in reset-names.
-	  See ../reset/reset.txt for details.
-- reset-names: Must include the name "crypto-rst".
-
-Examples:
-
-	crypto: cypto-controller@ff8a0000 {
-		compatible = "rockchip,rk3288-crypto";
-		reg = <0xff8a0000 0x4000>;
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
-			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
-		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
-		resets = <&cru SRST_CRYPTO>;
-		reset-names = "crypto-rst";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
new file mode 100644
index 000000000000..392d89055398
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/rockchip-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Electronics And Security Accelerator
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: rockchip,rk3288-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock data
+      - description: clock data
+      - description: clock crypto accelerator
+      - description: clock dma
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: sclk
+      - const: apb_pclk
+
+  resets:
+    minItems: 1
+
+  reset-names:
+    const: crypto-rst
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto: crypto@ff8a0000 {
+      compatible = "rockchip,rk3288-crypto";
+      reg = <0xff8a0000 0x4000>;
+      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
+               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
+      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
+      resets = <&cru SRST_CRYPTO>;
+      reset-names = "crypto-rst";
+    };
-- 
2.34.1

