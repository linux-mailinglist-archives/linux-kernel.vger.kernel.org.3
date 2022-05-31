Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29C453915E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiEaNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:07:44 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9AE4CD50;
        Tue, 31 May 2022 06:07:41 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j2so4624241qvp.9;
        Tue, 31 May 2022 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=gY4IDX6Of6Gq9PA3f1jZGTS5g7DSpVEowE1SjgpLLb07Ek5O3bUa1AT3+cfdS6UCd8
         8Xt+NMoxOJuIk1S99ITLMNeJSVAIWnxd9ngnf4E663cBpINBrMmGDXNRpdw8PQO9ESN0
         731JEaDVv5f30evjoU7f4yAGsARRqv7GDBqzFnJF0rzOI9cPUCcO5ApJXoM2duaDE0f5
         fj8i3/Kpt7FIQOYfCSd45IYis8XPGGX3uAMe2IUBvzNCFMPsb0Au7CuvCnnQPXwZzS+b
         0RWSns/CRrkU8x5/UqEZiAzlBoLt3ZRjybQHALkf6vqASoClAAn6hcUxRm+1zZAddYJi
         ZVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=2ZAK9a+raAjavZxrHmrLUYWZGigCXyjKWJhiodqMOeOkh94VjwPa1IJWxhZhr5gzge
         JRv6cUDEi4HA8ChwOH7rr2C50QfNinHUM0eVlMVaT66klc1VUKuE6ZSgIYCVhjwRMu92
         07UjULDyV4D095m/76hQzrFNJm7xdt3cvBM3qZUT8IBtVfte1ycDQFa+dIJ1N+7zOGh0
         k1Jt20YkFWP+XfXr2xUUflJ+L1Yv3GTLPN+PolNJ62wngJV3rlrdsFM7Fyvydq8gd98d
         FUAE3lyjSj6TsQo1IjElh5w3OHJiltdOjK8A6pSMIUAlRWoXS+/J9TldmSspXZUN+x+3
         kTtw==
X-Gm-Message-State: AOAM531YfAHysroXncsAtVOkrLuz60u+5udtyddEYnUjgHQ8oAG8Cc1O
        lRr8P2V801jUI7iNg99f+PrMobKWL2c=
X-Google-Smtp-Source: ABdhPJwXXdpvzfH0OHWambVU4ULlh4L9pgITiSW26L4OAZncDI72140qTyXM7wFe+JzlcNO/h+5R7w==
X-Received: by 2002:a05:6a00:a04:b0:51b:6ea0:43ca with SMTP id p4-20020a056a000a0400b0051b6ea043camr3778065pfh.78.1653995972975;
        Tue, 31 May 2022 04:19:32 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id cm24-20020a056a00339800b00518142f8c37sm10751608pfb.171.2022.05.31.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:19:32 -0700 (PDT)
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
Subject: [RESEND 04/14] dt-bindings: leds: Add Mediatek MT6370 flashlight binding
Date:   Tue, 31 May 2022 19:18:50 +0800
Message-Id: <20220531111900.19422-5-peterwu.pub@gmail.com>
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

From: Alice Chen <alice_chen@richtek.com>

Add Mediatek MT6370 flashlight binding documentation

Signed-off-by: Alice Chen <alice_chen@richtek.com>
---
 .../leds/mediatek,mt6370-flashlight.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 000000000000..b1b11bd3d410
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  see Documentation/devicetree/bindings/mfd/mt6370.yaml
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
+    description:
+      Properties for a single flash LED.
+
+    properties:
+      reg:
+        description: Index of the flash LED.
+        enum:
+          - 0 #Address of LED1
+          - 1 #Address of LED2
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.25.1

