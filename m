Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A757DFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiGVKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiGVKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:24:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B69D53E;
        Fri, 22 Jul 2022 03:24:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso6140453pjb.1;
        Fri, 22 Jul 2022 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxGKLw/sS7fdJZuE8bLGBTMKV4RyLr0/hVQFdtvG6hY=;
        b=qIjXERqyCxulsL7qrxC5ZZDDBbrioHFknIfqWTpItY9DnBOYdTrKjjHxJHVKgCGl/b
         qI1Bo3uVYHhVsETc34PIx5Bt5sRoC2tiuGaxCHy/jAJM0eDPTQXZeSPQFinIe+I8aq3k
         b4sxp+LsavCZEhpdo/xTXeoek2UqXswoT83RvGn19svgCZFMQWpoDvYyiXUknkV3mWGc
         j0uEqKCYVhxP+mKB9jyzIsWR4TAUOava99C6Tc8tfKqlztes7s1/XY6RtnvubtGfeZpn
         xjRuSRo549Wuo6S2lnKGNBn8iJB+KM+O2KEuPv2JYYPohP2Sw8x4qlz0WakW9LdwI4/U
         Et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxGKLw/sS7fdJZuE8bLGBTMKV4RyLr0/hVQFdtvG6hY=;
        b=jVoxC8Q9V8WVj9Lgszus3p8gLZFfWvfW7SGFGttvWMljH+ObO6SpYi0kAXxZ9rFJ2N
         MrhsTIYqCBOhgFK4iR04e6IfF6znQenDydbCvL2HlNxolnTlL0rW/doVyoDBtRUrYRmG
         v2tIW1sPgbZdJF3YABAMWTTn843bPMQsI7h+m04MDArkb7+1g2AQqPO0rSbxOfOYA/bM
         2GrIDh7YRRvfVWZI3JljPLi06sgI0Ys+c9llutGpZuzXZk7srep+2GPNHMkw/mfGaLas
         Yz2P2ZipWowxQ25y5tiokhlEn+FFNikZnUpPbcLaX7bZRuv/BkFt62z+e69iDQ4C+Aby
         qICA==
X-Gm-Message-State: AJIora8xwBpqzUXS2njcvtwOVkI7Q6y9Qm1wXSY5LwZqoAew7Jy3sNDt
        ORkFjJqWpFFpMWl4KeqTDc0=
X-Google-Smtp-Source: AGRyM1suCduVs2OcapdKOFquLFxR9PV6851tgTGd/xvEl5/lz4vxWAHevo2+JXiFLf4k/XyyV+aWjQ==
X-Received: by 2002:a17:90b:3c49:b0:1f1:9213:e747 with SMTP id pm9-20020a17090b3c4900b001f19213e747mr3386233pjb.15.1658485486574;
        Fri, 22 Jul 2022 03:24:46 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-82-239.emome-ip.hinet.net. [42.73.82.239])
        by smtp.gmail.com with ESMTPSA id h189-20020a6283c6000000b00528d620eb58sm3614551pfe.17.2022.07.22.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:24:46 -0700 (PDT)
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
Subject: [PATCH v6 04/13] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Fri, 22 Jul 2022 18:23:58 +0800
Message-Id: <20220722102407.2205-5-peterwu.pub@gmail.com>
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

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Signed-off-by: Alice Chen <alice_chen@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

