Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A75AE2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiIFIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiIFIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:38:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5679628;
        Tue,  6 Sep 2022 01:36:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x1so6246702plv.5;
        Tue, 06 Sep 2022 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=jmsIl8Ok40mS0SBKL0wE1rjGntjq6OgvfEjRCRIduxXBXKXXW7onrfKPDzdBLMtqht
         LLJXufRoIq+Gp/mJ6ExPpzBKSiQkDCL7PjG2ou+a6SXgyXEh/uxMnNZ4T0HBjyGVJGWp
         cWVFnnVrAmNZ5VB1OP3e/zVaF225LNBFv1YRFEyMkS0VuqXoX+XjnzEBe3jYnQcZ3MbV
         xf/9WM+MC6fVQqOpcUswQlObDKfVHJddBTEZ9JmQxlo4uV5HowtdzSOB+9YutvfVpLr8
         4JC6Ye01m4ZDNqFLoZh+mvwh1PZtVMp1x4gm7Y7Blgp8TBG/mWepJDVFCLa9GKW95bRS
         8Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XZRFVxasDVXXPTfv/lGT5hPcHgNLG3wH8AQQYSGVOn0=;
        b=YBrKKrqt0XgLPp6ZmuhrZBK6WdTOuvp9U7Qd4e5ytl/bBBVeLIHqORd9CxIv3pSDaA
         +Z3+Mdb0qHezLQDOWsCoSbROejgqqUWijmEXjS1xZHwmQv7i+2q5FKTu97OX1nZST+kl
         1oUMPS0L7EThMj1jY4ht/SOSmxChG3vokw099a+KvqEpLuZOM6EGWA0tXDZHg4XiNJXN
         5H7+NOnzZTH4RWRCkTNR1he5v5L/XsniwT1cIxiGEEUzkrJUKovffpmzWZuLKrukQCK3
         JWtjWHdqA2ajicNgSbMhztvwm30vWOe5QRxrGNaM8bYp7q653HKnGMlGhnGpW8c7qP7g
         c2TQ==
X-Gm-Message-State: ACgBeo1DR/ngnRz/ptIaBhVoSYP09zrCTMqc8c8DRrOIYz5CPhRt3/Bj
        sEGFofifIv1r6Uc/7qeiFhw=
X-Google-Smtp-Source: AA6agR47cJ+WKK2hQU5pd9MSXs2XnpV6BcgHwm3VK/FZ7lc5KFZrxlJaEA3eimgrUCM2ObUIEEZY0Q==
X-Received: by 2002:a17:90b:3810:b0:1fd:d001:ed41 with SMTP id mq16-20020a17090b381000b001fdd001ed41mr23271322pjb.209.1662453386749;
        Tue, 06 Sep 2022 01:36:26 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-80-193.emome-ip.hinet.net. [42.73.80.193])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm9474506pfj.57.2022.09.06.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 01:36:26 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 2/8] dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator
Date:   Tue,  6 Sep 2022 16:33:58 +0800
Message-Id: <4a1c995e94af808ec460e924edc7ac39b58985cc.1662476695.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662476695.git.chiaen_wu@richtek.com>
References: <cover.1662476695.git.chiaen_wu@richtek.com>
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

Add MediaTek MT6370 current sink type LED indicator binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
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

