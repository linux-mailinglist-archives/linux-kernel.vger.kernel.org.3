Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B652B548D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356466AbiFMM4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357434AbiFMMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15166543E;
        Mon, 13 Jun 2022 04:13:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so7796201pjb.1;
        Mon, 13 Jun 2022 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNKL5EoQe9yNQuWSwGWw4HpwNtWpyytf5bVWi/2uSYA=;
        b=irUn2d6BF9k7/P7W7MnusQ2y6EAb7Yx6AVX6GzE3wbyM8y6CUrUTih/qiJ1axCO4AN
         B2t588m6wRAAs2572apEbLnl8l7NhOGqetTjQevrbCL2OI1fwdz3qLC3pbGxUC7Wzj+z
         hXx4vu06puhWg8Fepra01DMfBkXJvctaTbfCj6uJzYnX81nUXuhrzz8L9SG0plqiJUjx
         CbyZovfivyzHblzLa+MKTC5klfKuLd9PmZNbujf2eJRhcNzpnIWKJuVjJ0H8YhcRqFNi
         ufGgVrB5qORousrYENy/DpjK4bGU7S7YySVXIlNac2qOkBMPtz1ZI3xQ34OlX66VkMLE
         qhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNKL5EoQe9yNQuWSwGWw4HpwNtWpyytf5bVWi/2uSYA=;
        b=UoVFXqKKA+QCh1HWVDovgyVzh4xNL3lFpJkObJs/6c+kg/TodqdzQ1i0uMVyQ69OMf
         YHG56FXc/ZXQ17daKMik1EpKXuZfax4yz4ziL8H4KCk1SuIOBZ31j4voi4PQxkJIi4dS
         ss1l5Ee5Fu1iP/hjWlBDyAgyQUKBg+eF5CnR5qP+jg9EcbaxvHCgH1Hc+zxbkrhLtLez
         maXmiafrLSFtxEJ6azPgTO/6TVdGEqOIXhWPxyjblZdV9YxeH7W5xkfbkW1cYrNDyHHQ
         ZO/7PLcQXhrR5vGK8Ln8ux7bT3zuFkZLWjVswE8C7EaNrtVi+OhY3TXQ4i2WVyd3GmH7
         Jc5A==
X-Gm-Message-State: AOAM533bJZlTAzLkRoER6CGDq/toq8lAt22rkJISo1tATpUl6072ZnB1
        xZqZr1SyHutl5Lo7K86OShQ=
X-Google-Smtp-Source: ABdhPJwA0uTKm6Harp/uy6rve75bJedJD8dBySejgYRVOmkwylT9noUd8UmThrqE7/9jk0JuIyuc6A==
X-Received: by 2002:a17:902:8d98:b0:168:a310:3ea6 with SMTP id v24-20020a1709028d9800b00168a3103ea6mr23326338plo.9.1655118787075;
        Mon, 13 Jun 2022 04:13:07 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:13:06 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v2 05/15] dt-bindings: backlight: Add Mediatek MT6370 backlight
Date:   Mon, 13 Jun 2022 19:11:36 +0800
Message-Id: <20220613111146.25221-6-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613111146.25221-1-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
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
 .../backlight/mediatek,mt6370-backlight.yaml  | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
new file mode 100644
index 000000000000..25a05e607e83
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
@@ -0,0 +1,107 @@
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
+  This module is part of the MT6370 MFD device.
+  The MT6370 Backlight WLED driver supports up to a 29V output voltage for
+  4 channels of 8 series WLEDs. Each channel supports up to 30mA of current
+  capability with 2048 current steps (11 bits) in exponential or linear
+  mapping curves.
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
+  mediatek,bled-pwm-hys-input-bit:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    description: |
+      The selection of the upper and lower bounds threshold of backlight
+      PWM resolution. If we choose selection 3 (6 bits), the variation of PWM
+      resolution needs over than 64 steps (2^6).
+      value mapping:
+        - 0: 1
+        - 1: 2
+        - 2: 4
+        - 3: 6
+
+  mediatek,bled-ovp-shutdown:
+    description: |
+      Enable the backlight shutdown when OVP level triggered
+    type: boolean
+
+  mediatek,bled-ovp-microvolt:
+    enum: [0, 1, 2, 3]
+    description: |
+      Backlight OVP level selection.
+      value mapping:
+        - 0: 17000000
+        - 1: 21000000
+        - 2: 25000000
+        - 3: 29000000
+
+  mediatek,bled-ocp-shutdown:
+    description: |
+      Enable the backlight shutdown when OCP level triggerred.
+    type: boolean
+
+  mediatek,bled-ocp-microamp:
+    enum: [0, 1, 2, 3]
+    description: |
+      Backlight OC level selection.
+      value mapping:
+        - 0: 900000
+        - 1: 1200000
+        - 2: 1500000
+        - 3: 1800000
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

