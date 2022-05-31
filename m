Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD453914D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbiEaNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbiEaNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:01:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7C78EF9;
        Tue, 31 May 2022 06:01:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a10so13987151ioe.9;
        Tue, 31 May 2022 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLlQWPmyPhz9LkYQh7iizThmB3DZjfxS2yfzbAOphFg=;
        b=c0XNKUscB1zMhi+CiKfzPAgi33gB/WNqZWTgiA6e6T/74Bc+S+2rt3VJ3UsRfE0t0Z
         atH9jyvYzC0EuHULZHe7WGzjQCb5VogDsom7nT+y02vKhMq0PK6qK2zKgULSu7mQCNOt
         3cUrkF/0FasX84M0+5XuHDd6yond+mMNlk5/zXu1Pm6xb/1W8a/7IYavW6Z5dEL/BLAi
         5pIQ9L6xn8925ggiqoLynT5VVlHrpmBo5ejz931C0Tgf9wQpG2sWForIN55zdE/CujQr
         /xY8y+2ZbC2EyFElWyMT8ivNm8PaWwGA2Dg8LLlmNA3TLB6fz9aecy0Tx9vI4rMPT8mO
         4gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLlQWPmyPhz9LkYQh7iizThmB3DZjfxS2yfzbAOphFg=;
        b=2kXGe3Ak+x4KvGrwvDguJ372dF4eKKRwrXBVRbFhnT/KhZyqdQcNJlI8SibgubmQPk
         prH8A3Vl6WjfKThKN0cGp98LgO7WCVLmOq6jlX4qpMr1vtAhbEtpw93nl0+YWJMgU9K1
         fkKdaPuObMKGkW21vYCXgqXTOuDsp24l62d0GGXKrN7Gkf8iiwqN+g4Ww11tS8mAJ5nP
         I+Eq/jZ/nexY7NSfyNKfEVGssqZG3+tV4Q8a2PK7dFDeRHrdSwuBEme3kWtBsQosQt2f
         TGf6D/yvrYO9NOAlKmnQnbi5FQJ3bZKJm6jIAAbJyfGDFQaHMCgMl5HqeRAMZHl22Ghs
         7T3A==
X-Gm-Message-State: AOAM533ByA793vSXMLu7kc37H/OUwExzaavKgnCjG3dtBEwZzXvC8biN
        sUXQ0b3QFktknGP/JJIe4Tf3HXKdlFI=
X-Google-Smtp-Source: ABdhPJy21tg5SBP0FImL71dOB56WQUiWGSqoTOYD2ff2cgdAz5FYkYg+kGU6v5K00Bt1Va+nB4MDaw==
X-Received: by 2002:a63:4:0:b0:3c6:cce2:8457 with SMTP id 4-20020a630004000000b003c6cce28457mr51332560pga.612.1653995967138;
        Tue, 31 May 2022 04:19:27 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id cm24-20020a056a00339800b00518142f8c37sm10751608pfb.171.2022.05.31.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:19:26 -0700 (PDT)
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
Subject: [RESEND 03/14] dt-bindings: leds: mt6370: Add Mediatek mt6370 indicator
Date:   Tue, 31 May 2022 19:18:49 +0800
Message-Id: <20220531111900.19422-4-peterwu.pub@gmail.com>
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

Add Mediatek mt6370 indicator documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../leds/mediatek,mt6370-indicator.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 000000000000..823be3add097
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,57 @@
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
+  see Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
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
+  "^(multi-)?led@[0-3]$":
+    description: |
+      Properties for a single LED.
+    $ref: common.yaml#
+    type: object
+
+    properties:
+      reg:
+        description: |
+          Index of the LED.
+        enum:
+          - 0 # LED output ISINK1
+          - 1 # LED output ISINK2
+          - 2 # LED output ISINK3
+          - 3 # LED output ISINK4
+
+      mediatek,soft-start:
+        description: |
+          soft start step control, support /0.5ms/1ms/1.5ms/2ms.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
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

