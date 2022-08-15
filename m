Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF30592D59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiHOJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiHOJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:02:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F920F57;
        Mon, 15 Aug 2022 02:02:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm17so6434939pjb.3;
        Mon, 15 Aug 2022 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GRGvr3sID7jAVOYfYb4nMCNV/0WVh6yEnvH7X6kj6k4=;
        b=lTOZnjIn7uMQrL//vg+5luzcrgAQWppu42fNuZW8DjaRxKD7G4kNBAImq5NuI6nNnp
         rhIRmDkvAwMDL1Ysz/XUZvh1OWJ57UzBJb3hgJAZzidIoLZp2ar6XN5W9/CHufZDlNJb
         ljf8wIK1uiDUBqXp6RXkyuUYdJOL+giZBAqLvYXlDfkECBZOeDnkwQYZnm9MRgD1noDo
         P0ndnDwiRbmaabENRp3SPU40neHtVaPWY7FYSZU4cZ2C088uf6hyixX7j+PSqwMOzWGw
         6XMtGzOwJ3bK4ZOYUF1+yvVnHg5rmfKSWY2P9zUT7SmTz6ACQtU/rGfdpDj0ugXzhatl
         Ggqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GRGvr3sID7jAVOYfYb4nMCNV/0WVh6yEnvH7X6kj6k4=;
        b=1GAuWRw80djw8AV49XVte3eVZX7eYk/cmh5mkQBseV/yjIA/0I5yE43am511a2aT4M
         6VbUm2dSDYy18076M+mp+SZYeCpSfVTAOZo+8DcI/3g3iJrhPYwD2y2p0Ky+GoukVaUA
         A/srpmLgVTX/mwt16JLBpP5lrPuMv5RmHVTljq2tdkOVFJ4d9XR1A3YXhz8xnLbBhPQ8
         rX7urZrevZnVO1XABD+n2phZik/k/uDF7uEtEV3OBkminG/AR103T8HbfFfzck6ZJSML
         HZPiNRvg9whPHCBlLnnKfxcOszZN/1OVPR3BXZi1ODXu4x74tozI2zfEvbMBCj0sZXMQ
         ZtkQ==
X-Gm-Message-State: ACgBeo0yzlhIoe9EuyEjeDCjCvIuw0Y/Q75avNbhre5/+8vl8Ne3TTDD
        V1IsmcQJexZ5MOGrIxnAwpQ=
X-Google-Smtp-Source: AA6agR6MPlDDHdSQAJFO8PlCGiKeWpjJjDSBHxplA64miH+YccEYhOHnwJND6n3qEIoU1woUtW8Mmw==
X-Received: by 2002:a17:90b:4c8c:b0:1f4:f6e8:2de0 with SMTP id my12-20020a17090b4c8c00b001f4f6e82de0mr16839442pjb.36.1660554147373;
        Mon, 15 Aug 2022 02:02:27 -0700 (PDT)
Received: from DESKTOP-IBN2BAQ.localdomain ([123.110.155.185])
        by smtp.gmail.com with ESMTPSA id a17-20020a656411000000b00412a708f38asm5491612pgv.35.2022.08.15.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:02:27 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com, lgirdwood@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v8 05/12] dt-bindings: backlight: Add MediaTek MT6370 backlight
Date:   Mon, 15 Aug 2022 17:01:18 +0800
Message-Id: <20220815090125.27705-6-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815090125.27705-1-peterwu.pub@gmail.com>
References: <20220815090125.27705-1-peterwu.pub@gmail.com>
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

Add MT6370 backlight binding documentation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../backlight/mediatek,mt6370-backlight.yaml  | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
new file mode 100644
index 000000000000..5533b6562d92
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6370 Backlight
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  The MT6370 Backlight WLED driver supports up to a 29V output voltage for
+  4 channels of 8 series WLEDs. Each channel supports up to 30mA of current
+  capability with 2048 current steps (11 bits, only for MT6370/MT6371) or
+  16384 current steps (14 bits, only for MT6372) in exponential or linear
+  mapping curves.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-backlight
+      - mediatek,mt6372-backlight
+
+  default-brightness:
+    minimum: 0
+
+  max-brightness:
+    minimum: 0
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
+  mediatek,bled-pwm-hys-input-th-steps:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [1, 4, 16, 64]
+    description: |
+      The selection of the upper and lower bounds threshold of backlight
+      PWM resolution. If we choose selection 64, the variation of PWM
+      resolution needs more than 64 steps.
+
+  mediatek,bled-ovp-shutdown:
+    description: |
+      Enable the backlight shutdown when OVP level triggered
+    type: boolean
+
+  mediatek,bled-ovp-microvolt:
+    enum: [17000000, 21000000, 25000000, 29000000]
+    description: |
+      Backlight OVP level selection.
+
+  mediatek,bled-ocp-shutdown:
+    description: |
+      Enable the backlight shutdown when OCP level triggerred.
+    type: boolean
+
+  mediatek,bled-ocp-microamp:
+    enum: [900000, 1200000, 1500000, 1800000]
+    description: |
+      Backlight OC level selection.
+
+  mediatek,bled-exponential-mode-enable:
+    description: |
+      Enable the exponential mode of backlight brightness. If this property
+      is not enabled, the default is to use linear mode.
+    type: boolean
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
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt6372-backlight
+
+then:
+  properties:
+    default-brightness:
+      maximum: 16384
+
+    max-brightness:
+      maximum: 16384
+
+else:
+  properties:
+    default-brightness:
+      maximum: 2048
+
+    max-brightness:
+      maximum: 2048
+
+required:
+  - compatible
+  - mediatek,bled-channel-use
+
+additionalProperties: false
-- 
2.34.1

