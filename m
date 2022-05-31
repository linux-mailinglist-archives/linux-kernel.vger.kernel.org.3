Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFE539145
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiEaNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbiEaNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:01:25 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE177F22;
        Tue, 31 May 2022 06:01:24 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-e93bbb54f9so18172128fac.12;
        Tue, 31 May 2022 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSIsAVF9fVkTehhsFum2qIaOiKUkDyLxbABQD3He3l0=;
        b=hKih9lAOW8MRbbBGfOx7kiRTjz9QfEd3eSIsmozQoYetBrC+t6l22jSihqFRc12+Xm
         vm7gh7oP1PcUjMLC+CnfQsZGCRDHQzpDYCVe4SM1p5AKYCAg5+kuYV4IfOv3NmsBxCss
         7YG0ROpBieoxvaS2AVVkWoMEgzSjP8Q4MHJtD90Su22yuchHnMBHN2kYeHQjcAKUqPh+
         fcX1MaYIdZzOtul5ziWofq+/Kiip9n3rw51FxR1QAqdrDC5veq6VVK/6j9X92G9Hm8mp
         0N4LfQ2aWVG+WFVKCJfp1DpxXQSHB4/w8Ri2BU+4MT7fum/8hgvDqYI07FZLkP9abiy8
         yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSIsAVF9fVkTehhsFum2qIaOiKUkDyLxbABQD3He3l0=;
        b=mvIJ+jRWWdgr2Mn4qQVDXHZE1bs0gckn+xFMBOYGeT2TmZb59UKr4nMzNOBUykVMHA
         reM+NiyONU5XaQk05W7s3Kx0WQPLphYfuJDhcohdPVSGt7EEby85wE+pfG42uMmQBci1
         Tnkx+DB1nsaP27V/o5f0CoQtO+vTv7tktMelueupCg/afkfABg/zJNYs0ukkMUS/W1lz
         mfzTogyYK+Q3d0S8IIyMd7QDNXw2TbSQkffHmuEdVFQxz1JFS8GcNPToL23r1pEj3TYN
         wrCJHKzx8OuyXOxvDqxvDdJdhho0/f2RyD1sOy2CS6h4Abmse2aEACGjHjfh13JS6shc
         GAgw==
X-Gm-Message-State: AOAM533ClDQVUtgOfTvdUQ/cf+NuAeySIrPwNh1Px7TBvCzC4A+zRTxr
        T84eidrftFGf4C75+uNhGiLbR4Zh4Xc=
X-Google-Smtp-Source: ABdhPJzuEbDwbQWGn3CV/zE1vb9aceaeVtHBN5Ja0Ci/sA7YgIw7LlW8QzYq/gP7Sxq9ui9vU3D1gg==
X-Received: by 2002:a17:90b:17c6:b0:1e2:ab17:a8f9 with SMTP id me6-20020a17090b17c600b001e2ab17a8f9mr17018922pjb.68.1653995978760;
        Tue, 31 May 2022 04:19:38 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id cm24-20020a056a00339800b00518142f8c37sm10751608pfb.171.2022.05.31.04.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:19:38 -0700 (PDT)
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
Subject: [RESEND 05/14] dt-bindings: backlight: Add Mediatek MT6370 backlight binding
Date:   Tue, 31 May 2022 19:18:51 +0800
Message-Id: <20220531111900.19422-6-peterwu.pub@gmail.com>
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

