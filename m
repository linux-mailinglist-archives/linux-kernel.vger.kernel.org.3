Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989925390A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbiEaMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiEaMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:23:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F188FD4A;
        Tue, 31 May 2022 05:23:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s12so303593plp.0;
        Tue, 31 May 2022 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sCP0jkvIeE07R1+RmlM9MygA92ez6zp1dtKYb5AvDE=;
        b=a9be3peBUoFVZqZ50OCR7WCQoA0wgtbUgT/V/GaXiuqSAAZwShGNehkdmtF5IgcnLo
         jos3yCaQ+rs2+jVEUM6NGd1bpsXdyfVaoP4C3RyV1nA225rnVpOny5wc4TVI3jptz0mE
         +sgwKJ+DFBy9R74Flg0uhc+pjh/5Tv/g7aTTUaDeYptE/YR7biUq6nb8nux92xPZQR9X
         2/Zsydv1BO94RBnNsZg4bMGjUzZcuMe8+mwXgJv9ZLXVBFhtafQDa8Wq9e2B6JZOQmTq
         l2LzCSoS8Sh3j1FQzAjfrHIlqOnqrWmVDmh2CA9+3bAVKobrIEr1gHEf7XJLdobrcTTh
         g6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sCP0jkvIeE07R1+RmlM9MygA92ez6zp1dtKYb5AvDE=;
        b=0JgncHBVAYJAENy42o1wLGooHh2zYDKdxSMuMGpSKX1+GaNVL0z9QawXRAbctPxIke
         2mqLfKEz2yPPRarRcXQ4wN6/BEi4LnSKkKrgpVEwMDRmZ9NCKlyqp6uGOXqFzgq2wNVS
         Bu3dpbfx0J3JWfZ5+riCRJXDxTrjhj1w7Pc1MJACFw8N1M9f7YPx58kZlTaeuMGus/yZ
         AgrPGangEAapWnXMs9ttNjWUQhmp4rrI3HKifqZVHlmrxN8zK+16sdjcxPzy6fbjUFxK
         Tl0KxjgLkRiK4IykzuTbImjHWDT8ri92iaz5RwLDzeISHAxKhsuXXKoUFSX5vjSzM7Go
         3zOQ==
X-Gm-Message-State: AOAM533MRq4B2JQrjjfokt49jdFRIdhMCN1dYcSb7jngUpcNJfnC3mkl
        6KebSE+mXAMKDe2XfoA0YnjdDkCthKY=
X-Google-Smtp-Source: ABdhPJxjB9hNHIBZP+TwpIDn3+WjAr/DqSbaH953TORf436cYOrtjkr7OObAuQDCpGlL2O/dNLlIWg==
X-Received: by 2002:a17:902:f34c:b0:163:fa4f:2ff5 with SMTP id q12-20020a170902f34c00b00163fa4f2ff5mr4895286ple.174.1653993745016;
        Tue, 31 May 2022 03:42:25 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ac25300b001cd4989feebsm1525829pjx.55.2022.05.31.03.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:42:24 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 10/14] dt-bindings: power: supply: Add Mediatek MT6370 Charger binding documentation
Date:   Tue, 31 May 2022 18:42:07 +0800
Message-Id: <20220531104211.17106-2-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531104211.17106-1-peterwu.pub@gmail.com>
References: <20220531104211.17106-1-peterwu.pub@gmail.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add Mediatek MT6370 Charger binding documentation.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../power/supply/mediatek,mt6370-charger.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
new file mode 100644
index 000000000000..9d5c4487ca9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6370 Battery Charger
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-charger
+
+  interrupts:
+    description: |
+      Specify what irqs are needed to be handled by MT6370 Charger driver. IRQ
+      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCTRL_UVP_D"
+      are required.
+    items:
+      - description: BC1.2 done irq for mt6370 charger
+      - description: usb plug in irq for mt6370 charger
+      - description: mivr irq for mt6370 charger
+
+  interrupt-names:
+    items:
+      - const: attach_i
+      - const: uvp_d_evt
+      - const: mivr
+
+  io-channels:
+    description: |
+      Use ADC channel to read vbus, ibus, ibat, etc., info. Ibus ADC channel
+      is required.
+
+  usb-otg-vbus:
+    type: object
+    description: OTG boost regulator.
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpio:
+        maxItems: 1
+        description: |
+          Specify a valid 'enable' gpio for the regulator and it's optional
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - io-channels
+
+additionalProperties: false
+
+...
-- 
2.25.1

