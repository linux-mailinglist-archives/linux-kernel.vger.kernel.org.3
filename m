Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0B58A67D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiHEHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiHEHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:07:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252B74DE4;
        Fri,  5 Aug 2022 00:06:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d7so1916887pgc.13;
        Fri, 05 Aug 2022 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=GbRQHYJWpxNJ5WAA2fCLZDXWImpw8oQErL6RHuLr1qgR3c7cz14qFaq1/bgXHrJcjG
         aKu4qpdD0z0YDXpWslStuuvY1rLpo8AEnM3CeLgueSF+WIXvcTIhywulOxwF1jM7h0io
         6m80d+VHmLR9b3erIIgQlII6EX7Itibg98z4kGEJCQpfyOIfYsSa/dnOm5FjWjSzvFie
         XgKcW98VZGYkul0QX52UnIfS0LTAwyLZHmgP+jTlF/9dikRHy/3ouBR2tPOay0Lhx6oG
         isBNJnKmY9kSjYt6sCaunANsLS/R3XdAt7W/7euizUoulhqLNRBXOcRMGFdcLnWieIIW
         pO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=C3KLH33JzSl5iLjda3RIs5lGQg0k1+RudMp3COeQowLpXJE3o3z6l3juhEH/R2n48w
         I2i7aQaEHAoP3gfp/p7ghEsmE3o4YyVGEoC1wXjRhJwZaUAmEPW795Mgb4Q50cvigZAc
         CJ0N/ehj6ybgjnhEoEDfwy0zx3AiCWdlsjze0EklnAPFqRsyDdZDdeOY2CfyZucTO+Nw
         ou8/kK7mJFOM/95eJviwIy4idSGCccbNhQVem9gcJsT79GEAdmhoMuFXf0uzu4BD/PPD
         A7Jx3ejflXXWQz7CXJtEXQpxMXyhTzjJMfiFh58FXXlxe7qX6cYmOIz8B850/QyIQ4P2
         MCPQ==
X-Gm-Message-State: ACgBeo0EnIuP0gsBqOfH7luouuaUsRw6E5wStMsShue8qriaCr3jeTW1
        aTm86XHp7s053TweUtIouAI=
X-Google-Smtp-Source: AA6agR6DJ/xGXIEp9/SiYGj8B5E5YJ/4TnNDD77+rwk4vvfdS9F22unZx+OW4+D1bIl8u5r1XbFyuw==
X-Received: by 2002:a05:6a00:24c7:b0:52e:7181:a8a9 with SMTP id d7-20020a056a0024c700b0052e7181a8a9mr5495612pfv.78.1659683215955;
        Fri, 05 Aug 2022 00:06:55 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-229-62.emome-ip.hinet.net. [42.72.229.62])
        by smtp.gmail.com with ESMTPSA id i5-20020a056a00224500b00525343b5047sm2191616pfu.76.2022.08.05.00.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:06:55 -0700 (PDT)
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
Subject: [PATCH v7 04/13] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Fri,  5 Aug 2022 15:06:01 +0800
Message-Id: <20220805070610.3516-5-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805070610.3516-1-peterwu.pub@gmail.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
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

