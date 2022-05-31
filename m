Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88953916F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbiEaNIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:08:41 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4757158;
        Tue, 31 May 2022 06:08:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 67so13525104vsh.2;
        Tue, 31 May 2022 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sCP0jkvIeE07R1+RmlM9MygA92ez6zp1dtKYb5AvDE=;
        b=nXmORH65SpUjbhTvE2/X4vleVvzj6HP+vuXT2wdUKKV3uYzPcGvjjNbaiQXbwG8qzK
         uPv/BkQ+TkqS/c/pTyH3MEcmQTjImLnIAQwYIywCz9eE2DXVRcjWE2BFU0DaPWbtLi/6
         JIvwS/TtGLCo09S6g+UL6qkaUK2oeoCMkdiukx7QIlym1KreWmFGviLxAhPsUcZHmlSM
         OSkgJCSvXdBwmw4Gici4yb0fk/qD+ZeAOnsOxdBN99m27wOxY2bmru3yqNJ3C7pNDS41
         mUuOOYgxXC4RL+LYjsYCmgj2KzDBSJcjDqVJDm+H+8YT3Rf9D+evD4SgQIcZFSpWOpWa
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sCP0jkvIeE07R1+RmlM9MygA92ez6zp1dtKYb5AvDE=;
        b=gIE8T/4cc/fzHJr84j0g+Vp91Jia1A4vhVIoG66D7tqU+yLt58Y+aCy1vlyZ4eRUMb
         3uKMKG0NutKwIlwBjZVonRoKgzBpk4Pyl3Gf8iRpl6HRpRw5fqzQsKpuymtQQ/7LfPJ7
         CUvvtBmkarqVkhCA30VXCu18WbJxFtJ+UoVevayrjWxiGHq3fos9eKdSOlAQ5pouwas1
         eDlhIDPwvX6RxqbGzRBC08dfLjjU7wWQ1YdvnfaTVpvILz2wMyMFYUhNBLcFnw99ofby
         mA2lI35Igge6bQCeDuWTNxXwrlbTHRXoftG+kDUlFr7NUEm5+6vvDGXR419YffhHUFU9
         UzeQ==
X-Gm-Message-State: AOAM532QGd37gNDIVzvVpXC4wFt8O524l7Slk9GxNC1Qt/qg7+rANg/r
        IhDlOrxOEFyfcIof1Ulyy6/LikhW8LQ=
X-Google-Smtp-Source: ABdhPJxJCbqOi6bcKGG2j8vTrhwclOHUg/eFfbPHJw6XvHla1B8QXbEiVn8d3/yztpo6Xy5/cUsecA==
X-Received: by 2002:a17:902:e5c4:b0:163:4c5e:5b39 with SMTP id u4-20020a170902e5c400b001634c5e5b39mr33395049plf.69.1653995961377;
        Tue, 31 May 2022 04:19:21 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id cm24-20020a056a00339800b00518142f8c37sm10751608pfb.171.2022.05.31.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:19:21 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, peterwu.pub@gmail.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [RESEND 02/14] dt-bindings: power: supply: Add Mediatek MT6370 Charger binding
Date:   Tue, 31 May 2022 19:18:48 +0800
Message-Id: <20220531111900.19422-3-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531111900.19422-1-peterwu.pub@gmail.com>
References: <20220531111900.19422-1-peterwu.pub@gmail.com>
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

