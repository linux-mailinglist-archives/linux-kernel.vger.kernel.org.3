Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010A5390DC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiEaMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiEaMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:36:18 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59135E0C2;
        Tue, 31 May 2022 05:36:17 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j3so11944561qvn.0;
        Tue, 31 May 2022 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSIsAVF9fVkTehhsFum2qIaOiKUkDyLxbABQD3He3l0=;
        b=QOw2p/64lt1uyPgPboyC9mT/+C3rW8Th64HO+2HEr/m2pfBsLIZFygjqBVlnWcK/f/
         295ieFEYrWCrLOeZvqu8d2JfHddcyERHzeUbx5V5rn01j0A0w8MRfpv/a4egXv82VEKh
         /hQTcNBUIC5D3SPodoP2DkE+XzCDssU2d/LYgkN2RBMNZGerC9pRZ/WI8DeURBpSrSt2
         t4Ctr+7wzBLVGJjSy2FA4PyXO83pH1sT5qRrYEEknWe/UZvt1xegxcaIX5bwtNlPOePO
         i95qwTvo47S5gTY4oiplWMe8FhOyLGfoEwXwcyw3wEXbCXmpiBIECQ4axEaFkuk80QSL
         tVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSIsAVF9fVkTehhsFum2qIaOiKUkDyLxbABQD3He3l0=;
        b=CM3MrkkTzD5Kdj7+MArE7k+0nvttUyQNQkpIC6RyGpWB/VaNlXb3V9ecjCOF+b/8ey
         vrH0W5WWLt5Uv1KfDSxsSApSXwFDJ/ZqwlpBoD8Xcie4y8ginIwAViv5/jxV5n8R2oOA
         J5JnB3bhNOBJTdpa1gsAyYEsPOhc920l/ioxlax2QM3WDb5D21ouH8xIJTgk8dzXROEE
         zgZdzhzuqf+Iu61MeUg7tJqRbFTcdGfSBioqJo0vXkfJHPeLjbvRVIzDlReli+FN6XJY
         uhhH4tv4pd+Zksu80X6Nk45+0Unbz9PJdxD90bYlIwCqx29psOvIJQooB7Uf3yYb3dg6
         216w==
X-Gm-Message-State: AOAM533K5UZu211WRV8vn8ykGiQqUQHPkEP8et2cbuKrs39Z9n0noTRc
        jJ9CAyASgDyZmt2R43uWef0kdtQYpLU=
X-Google-Smtp-Source: ABdhPJwCrUlKM3qqly5WwFKGwXNRMJkyXyR/16bsBowQ6jMQD3krB9sdYW2acmdj8ZMZ2x0Ma/6Xuw==
X-Received: by 2002:a17:902:bd05:b0:15f:19a0:95ed with SMTP id p5-20020a170902bd0500b0015f19a095edmr60603252pls.31.1653993761824;
        Tue, 31 May 2022 03:42:41 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ac25300b001cd4989feebsm1525829pjx.55.2022.05.31.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:42:41 -0700 (PDT)
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
Subject: [PATCH 13/14] dt-bindings: backlight: Add Mediatek MT6370 backlight binding documentation
Date:   Tue, 31 May 2022 18:42:10 +0800
Message-Id: <20220531104211.17106-5-peterwu.pub@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add mt6370 backlight binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../backlight/mediatek,mt6370-backlight.yaml  | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
new file mode 100644
index 000000000000..81d72ed44be4
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6370 Backlight
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  MT6370 is a highly-integrated smart power management IC, which includes a
+  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-C &
+  Power Delivery (PD) controller, dual flash LED current sources, a RGB LED
+  driver, a backlight WLED driver, a display bias driver and a general LDO for
+  portable devices.
+
+  For the LCD backlight, it can provide 4 channel WLED driving capability.
+  Each channel driving current is up to 30mA
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt6370-backlight
+
+  default-brightness:
+    minimum: 0
+    maximum: 2048
+
+  max-brightness:
+    minimum: 0
+    maximum: 2048
+
+  enable-gpios:
+    description: External backlight 'enable' pin
+    maxItems: 1
+
+  mediatek,bled-pwm-enable:
+    description: |
+      Enable external PWM input for backlight dimming
+    type: boolean
+
+  mediatek,bled-pwm-hys-enable:
+    description: |
+      Enable the backlight input-hysteresis for PWM mode
+    type: boolean
+
+  mediatek,bled-pwm-hys-sel:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    description: |
+      Backlight PWM hysteresis input level selection.
+      value mapping:
+        - 0: 1bit
+        - 1: 2bit
+        - 2: 4bit
+        - 3: 6bit
+
+  mediatek,bled-ovp-shutdown:
+    description: |
+      Enable the backlight shutdown when OVP level triggered
+    type: boolean
+
+  mediatek,bled-ovp-level-sel:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    description: |
+      Backlight OVP level selection.
+      value mapping:
+        - 0: 17V
+        - 1: 21V
+        - 2: 25V
+        - 3: 29V
+
+  mediatek,bled-ocp-shutdown:
+    description: |
+      Enable the backlight shutdown when OCP level triggerred.
+    type: boolean
+
+  mediatek,bled-ocp-level-sel:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    description: |
+      Backlight OC level selection.
+      value mapping:
+        - 0: 900mA
+        - 1: 1200mA
+        - 2: 1500mA
+        - 3: 1800mA
+
+  mediatek,bled-channel-use:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Backlight LED channel to be used.
+      Each bit mapping to:
+        - 0: CH4
+        - 1: CH3
+        - 2: CH2
+        - 3: CH1
+    minimum: 1
+    maximum: 15
+
+required:
+  - compatible
+  - mediatek,bled-channel-use
+
+additionalProperties: false
-- 
2.25.1

