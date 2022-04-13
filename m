Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4644FFEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiDMTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiDMTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:11:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC7716C7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i20so3952056wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vI7RROwI7xo5mL2BvS6OkIwLXT1/HRd+BPTtZP9sXU=;
        b=OaWHv/NXyUm+/cwpqYuDB/9MTsYe7jZWyUjS5CgwmwNAbL/ncdbakOhkXkqlV89mvB
         9TVDRFgzvTEmIVeKRp5KzRk2wm+PYPdkiIG7fH+TMgRbDNw2MRlw2rIGzIODF8uK0BHc
         4CiXK6w6BLVXu7Rov6HPE7+mdPGI6ONzoTK7NaWB6ny5fH0vdFmzylFqxE9uFTJed7U5
         FNVXp+G80cKPcVeTD0gRN2Ss9JCeXXnNwtnSFqYXtUQ1CgFsjmJaSFBbpINLQ7pNMmUo
         2kQ2hMw5thX4n6k+iEiHfhJ/ceyjp/Whsa1ZmjKjfXpE5GbbaxXKIwYM4Dl+m0ODlkNT
         0OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vI7RROwI7xo5mL2BvS6OkIwLXT1/HRd+BPTtZP9sXU=;
        b=qBrvgZJywDrcF+J6+6yIMz6cHEO8zIIAr64hTnbJ8ti1QG9W7SivW12xQGMKqyfPY2
         cOK/b4o0S6LBYtRyRP/gjwYacD74kUNLGk5B/bB4/po74fOvBU88prKo7zpuYgnbxUQ0
         IW1dOJAOFlYDpXroFaSwfO9rq7en4+T4IrnArman0OEQ5t96EJKrNUy1sNW0RJCZxOsS
         vyG6ie/rQ/pdDIBMrqcS6auGt6W+6CuYDtsRFbJlEvi+zq8qJ0CKjbHPkME6icLo/brd
         OH/iMDDuYD8Lxs0/zPaj2MO5mZyPNzgjWP95NUUsDuff339tdyCbnYngW74YCEmFHziA
         IJuw==
X-Gm-Message-State: AOAM530YBAPZSD/xG77ojkyY7ffs4ZLNUiCA8/aoJk8FOuX/LaFF+wpJ
        DRDHkaeUYHYgDjsbL/TAM68AS5QNR6cHiw==
X-Google-Smtp-Source: ABdhPJzvnagHn8g1Peu3j6RE8tctMSMOd0u8FzmpEzyFaVtLUytmgSH+2Je+PL0pyzLE8N3M0RvUnQ==
X-Received: by 2002:a5d:6a47:0:b0:207:ab24:b1f6 with SMTP id t7-20020a5d6a47000000b00207ab24b1f6mr244110wrw.488.1649876867735;
        Wed, 13 Apr 2022 12:07:47 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 24/33] dt-bindings: crypto: convert rockchip-crypto to YAML
Date:   Wed, 13 Apr 2022 19:07:04 +0000
Message-Id: <20220413190713.1427956-25-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
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

Convert rockchip-crypto to YAML.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
 .../bindings/crypto/rockchip-crypto.txt       | 28 --------
 2 files changed, 66 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
new file mode 100644
index 000000000000..b4e87e9894f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Electronics Security Accelerator
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3288-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    maxItems: 4
+    items:
+      const: aclk
+      const: hclk
+      const: sclk
+      const: apb_pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+    items:
+      const: crypto-rst
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3288-cru.h>
+    crypto@ff8a0000 {
+      compatible = "rockchip,rk3288-crypto";
+      reg = <0xff8a0000 0x4000>;
+      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
+               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
+      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
+      resets = <&cru SRST_CRYPTO>;
+      reset-names = "crypto-rst";
+    };
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
-- 
2.35.1

