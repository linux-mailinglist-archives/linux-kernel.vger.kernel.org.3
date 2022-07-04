Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9996564D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiGDFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiGDFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:39:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C864FB;
        Sun,  3 Jul 2022 22:39:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so8480542pji.4;
        Sun, 03 Jul 2022 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2096TrnLrOi6TQb9sd3IJckHfJM0dfj6pjilL2XtYM=;
        b=pjM3xzgFjRLnvs0GNNP7U7Ho1tjYTsycSoDgKS+B8pXnIAlALkP94GE39gDetj0q3s
         NTdLpK4M5lo/Sw1JSPl6flBHrQpzwzPuTUO/oFUoxkwrdcqFGMjOM5JVz3VDzgxGHbZX
         j/YUkTWidr9mv27vyO2xCaoeyp29+CwrnHrOINV9dyWRWaNAsCrwotcp5abLEdUyzhpW
         rHxVpdqjUzBAo0jSILyNfqWgGjwXkDZY7tZPwB+XqgH+b6vw5n5ytQUHfwIrIPsBVlNs
         xJRlgMNzPZjsJqMU2/cO8lexo9LRf8L+Jhp2WT5G0ZRUS+rQBTm0FwBlEiGWve+uP9Zs
         eGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2096TrnLrOi6TQb9sd3IJckHfJM0dfj6pjilL2XtYM=;
        b=r6mPAEImRT1JnQ90mUws8QOqB73gEa2t4RbzBaZz/NHzdBuUXxUVkM4x9wGXYLNz5u
         9UzL9lYw1kzwgNgXy66jw+LVJPL0UMoWKUZmpVKNwb4b7oRRCwnZTeOoB9r5lyLCSjyl
         upE+OAqko38Vtxkb8xhNHPUZYAnSWXR7YXUESQieDTrZo7DJQpJ2dxUUOuzODkEpkmVy
         WP4lUUYZ+3Gd5dPd8airuiPWwue35MWASdZ0ZgCz23KRiXdaaxv/anrnIEg+RqKSJwvE
         O1BWTqntx0QCL96Maf2/BqCGr/ohzYENso4gv/3JDiAJb8MFG+oEXOMif0ryXu3BXC2C
         Ayrw==
X-Gm-Message-State: AJIora/rAGHkSumMawaM9dNh/5qbAekacsFuNjw+0mTFEmX2GLzFAT20
        hWWvFcBELFrgXoLqulI3Gag=
X-Google-Smtp-Source: AGRyM1sH6S0WrfyDcm8NZMoUo/7mjXv+ixMV1mBqBrskO5QOtg8rGX9FFCrdxOCNJMaAXwW18XTOfg==
X-Received: by 2002:a17:90a:af98:b0:1ef:1d10:c052 with SMTP id w24-20020a17090aaf9800b001ef1d10c052mr33374468pjq.111.1656913180400;
        Sun, 03 Jul 2022 22:39:40 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-4-255.emome-ip.hinet.net. [42.72.4.255])
        by smtp.gmail.com with ESMTPSA id h24-20020a635318000000b0040dffa7e3d7sm13904507pgb.16.2022.07.03.22.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 22:39:40 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v4 02/13] dt-bindings: power: supply: Add Mediatek MT6370 Charger
Date:   Mon,  4 Jul 2022 13:38:50 +0800
Message-Id: <20220704053901.728-3-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704053901.728-1-peterwu.pub@gmail.com>
References: <20220704053901.728-1-peterwu.pub@gmail.com>
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

v4:
- Add minItems of "io-channel-names"
- Replace text "Mediatek" with "MediaTek"
---
 .../power/supply/mediatek,mt6370-charger.yaml      | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
new file mode 100644
index 0000000..bd09a0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6370 Battery Charger
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
+      - description: BC1.2 done irq
+      - description: usb plug in irq
+      - description: mivr irq
+
+  interrupt-names:
+    items:
+      - const: attach_i
+      - const: uvp_d_evt
+      - const: mivr
+
+  io-channels:
+    description: |
+      Use ADC channel to read VBUS, IBUS, IBAT, etc., info.
+    minItems: 1
+    items:
+      - description: |
+          VBUS voltage with lower accuracy (+-75mV) but higher measure
+          range (1~22V)
+      - description: |
+          VBUS voltage with higher accuracy (+-30mV) but lower measure
+          range (1~9.76V)
+      - description: the main system input voltage
+      - description: battery voltage
+      - description: battery temperature-sense input voltage
+      - description: IBUS current (required)
+      - description: battery current
+      - description: |
+          regulated output voltage to supply for the PWM low-side gate driver
+          and the bootstrap capacitor
+      - description: IC junction temperature
+
+  io-channel-names:
+    minItems: 1
+    items:
+      - const: vbusdiv5
+      - const: vbusdiv2
+      - const: vsys
+      - const: vbat
+      - const: ts_bat
+      - const: ibus
+      - const: ibat
+      - const: chg_vddp
+      - const: temp_jc
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpios:
+        maxItems: 1
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
2.7.4

