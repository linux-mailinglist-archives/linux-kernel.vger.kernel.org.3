Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7657600F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGOL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiGOL0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:26:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF33B87C1F;
        Fri, 15 Jul 2022 04:26:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so11366199pjn.0;
        Fri, 15 Jul 2022 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtO+yg7Wi4JSj3ZmHONhdPt1sUn6ZtFJMnIAL1+O4g0=;
        b=MxhXhpk7Ks0RWEvd9kFA9v3SZ8AzSin2yjmbK6C1k369LpIP0hKZupdIq0qEl0dte5
         i9TBORRgmpb/z/CAyA8YHTgT91PSqkfn6wTbXD2mezNTndRRe79UQowzeMFniVFItM+d
         chN7ZH9k41k9o22X3/RxGomlrOdokzIkSq2INwkk4u4RFHm4XYZg4x3Ykj3f7h+njCMI
         hRfAdAvEZ1bAcCSf/NcKMoj6lE62CBTRW1sVW5vX3HUmztLYV8+cpI8QfkG1i/If0sSf
         h6gjbnkwrWsUGpaJvyfXFastJKJdEnkJG86eFBgFxOzpXYuxj7l5kp/MF4vwSlWGZGhk
         lP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtO+yg7Wi4JSj3ZmHONhdPt1sUn6ZtFJMnIAL1+O4g0=;
        b=nBtktmYv+6d/6HOSMbVcnLeDJ16vKhYnX/ahA5anhM5j8kmQdCanx5vmg8rEPzEC18
         QQSojALjpi553Kdf0uLyxfoo7Fqe/oGyJT7rBTDXIeXtypVh7zOK+XO1jgRp5iZVOeEk
         Ikj4c8q5VICHJT8Tu2nHVef9olcFgOvf3CrCn+0oAWSpuQpVzpE0sGpMc+S3BdQvWb5J
         6M2BkwhUD4OMphQ9z/sv4lMislz5kK0SI2wb5pZZvWoL31zBdR5WDU0mmBU7nfyJ2+Ni
         L1oaIbYIvDlZmxZh5pi5mKLufEv9bP93DVwwAIFLGFlcYWBHNkynCGqMORK1pIA4SRFV
         06VA==
X-Gm-Message-State: AJIora8CYC5TzHO6sk8lIOAh/52NK89I3jSoh1Rhf7OUT1cKuce+y4HP
        syPzwXN0Ec3ytha+UYB7gA4=
X-Google-Smtp-Source: AGRyM1sFeRtrbGN2hqRqxJUOt5WA81Ct6iRVr9pZJ5dkJiTPbuxUedwsmxzgqDnxutg/Gx+lwHQrUQ==
X-Received: by 2002:a17:903:1109:b0:16c:b5e7:652f with SMTP id n9-20020a170903110900b0016cb5e7652fmr6278114plh.142.1657884394006;
        Fri, 15 Jul 2022 04:26:34 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-159-86.emome-ip.hinet.net. [42.72.159.86])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b00525b61f4792sm3550604pfr.109.2022.07.15.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:26:33 -0700 (PDT)
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
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 02/13] dt-bindings: power: supply: Add MediaTek MT6370 Charger
Date:   Fri, 15 Jul 2022 19:25:56 +0800
Message-Id: <20220715112607.591-3-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715112607.591-1-peterwu.pub@gmail.com>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add MediaTek MT6370 Charger binding documentation.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

