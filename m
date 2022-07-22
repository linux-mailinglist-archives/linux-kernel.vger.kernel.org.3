Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419D57DFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiGVKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiGVKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:24:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0F9B9D2;
        Fri, 22 Jul 2022 03:24:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h132so4061354pgc.10;
        Fri, 22 Jul 2022 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekeWjhe/vPlnrj6pxUuMZnIHCtjnr0IEqSQkbPzm4zM=;
        b=RH7X2NIbX5C5sI3T8aekKbPZ0/NIAzMUdJdSJRLokbHjPB0oviakIsJpWXt1wJdedt
         ePMqrqSsYipgX7yTBRz9wfWhCOeC4cES/ZNO5j7CiHLg+7LGpJaPkLLjs2TvvE8Aatmj
         xuJ6qkIZC0FIttjNritzdnY9ZpAXgKtL/P6+GUeiaqh/oK1Qa5RI4npwHZlC8QMrd9s3
         ouF2FQyimpkIgT40neCOIHwrG9IIHLxLLEw3oha+qUQ6pX/ECwcQw9ybzLcT2MZX9/6h
         pr/vJqYQbMOPwMsmJypD9RYFFoXuxeh3dbT8Nt49y/s7HnBmnJlIhGIlPSxGu7i3nKzY
         9iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekeWjhe/vPlnrj6pxUuMZnIHCtjnr0IEqSQkbPzm4zM=;
        b=7YSZ9TSQ7piSysk8K7W7OEYlO4bcWLM6Am5Pz5sdBRijxsJeR6JODz96ndlMliDj83
         PNcvqMiQqbXrEXmjPT6ySUL4WryVGxB0kNaTBcFiZAp9GxFjwrXrpLU7pd+2dGm8pWKJ
         HSQ4Vxg8iMm1AGlP3Oc7SUzE5xRxCkdlKco1kVYAK7yW8MpQyGEza9sjqic3/S8xHsU3
         8b9vjKlrgbJtlzVApFAK9wXlYvsYa93XvHX8NXr5ZFsEifrl4x3uvuxBKv2nR0NZWPLv
         H7HkPPbQi+GbqaX4Uqtgul8bvppLfujkxnbaBtomEWUvHDXO94QWgMMZbUji7JTSBNM7
         DJzg==
X-Gm-Message-State: AJIora/y0w6lN8qbLQpz+vKQNjNS2MaBhcc4MzIeOpAiN/2sl2JsQ9bz
        90QOnzuLJIbzaTX11suQQn8=
X-Google-Smtp-Source: AGRyM1uemeXZnT3uHoO82fOsUMvcRsClMKdWf1rGpgn2xGzw/Mm4P6q511HqEiot5ye8kMmcfxP3/Q==
X-Received: by 2002:a05:6a00:1d18:b0:52a:c350:6538 with SMTP id a24-20020a056a001d1800b0052ac3506538mr2831187pfx.7.1658485480028;
        Fri, 22 Jul 2022 03:24:40 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-82-239.emome-ip.hinet.net. [42.73.82.239])
        by smtp.gmail.com with ESMTPSA id h189-20020a6283c6000000b00528d620eb58sm3614551pfe.17.2022.07.22.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:24:39 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 03/13] dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator
Date:   Fri, 22 Jul 2022 18:23:57 +0800
Message-Id: <20220722102407.2205-4-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722102407.2205-1-peterwu.pub@gmail.com>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add MediaTek MT6370 current sink type LED indicator binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v6
- Add 'reg' property of led of multi-led to prevent checking error.
---
 .../bindings/leds/mediatek,mt6370-indicator.yaml   | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 0000000..204b103
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
+
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt6370-indicator
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-3]$":
+    type: object
+
+    properties:
+      reg:
+        enum: [0, 1, 2, 3]
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-2]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            enum: [0, 1, 2]
+
+        required:
+          - reg
+          - color
+
+    required:
+      - reg
+      - color
+      - "#address-cells"
+      - "#size-cells"
+
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1, 2, 3]
+
+    required:
+      - reg
+      - color
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

