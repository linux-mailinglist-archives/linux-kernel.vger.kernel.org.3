Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE872592C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiHOJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiHOJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:01:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC620F76;
        Mon, 15 Aug 2022 02:01:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so6044037pga.1;
        Mon, 15 Aug 2022 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/AE193goh4VtzXK5TNjfSKGI7YjyV9LcV+9UPyLd22g=;
        b=m5nWpIjJy7EJXW2a3685SfBViFzjpPmuFNoLVZeuBhLckuAxfYC3KLiH/IS/xFsspm
         G6MhQQdWKvBrU16JNQm8cXdWldKneUEX1W1SvjZkeH671KqURCk2tL+c3M95GU7Vt8fJ
         0XSTxwMZPL95TfH9xk+U9VWpiQDhC1pu8/hnAURWjhzQSnfTY4D0NQI1AYZVHH/3WgUA
         wnCZDZcsaDYDm4SbjregxrzvXuFCPZ2cneemdylqwDhjhXtp9N+kq1Hg46CjX5JsS+mN
         E7QHCHQLLcJ7CV8ke6e/VXuVT3nZMj/Y6f7qoE9Oz9hUdxo/BNMwb1ZqlhSl2x3BZqrT
         KdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/AE193goh4VtzXK5TNjfSKGI7YjyV9LcV+9UPyLd22g=;
        b=CK1R49Qw4Lo3NhuOKmcNVHezlLiqzbvVEhOO19cZotlH7BNrBDCCv4AtEIpp0d3YHR
         X0gmL5bqqW1AXv7/IRlzNiva5mm/0+kZbgrvmmn5tXkMcJv8RM/d2DPOGPWAJQ3UPSCf
         swJJQY+9sIYqYH5n6UxMqxc0ZT7tUS7e0PFmK7L+DQpuTtZVJdym3bvQVF3jn5P9xuH4
         ngo2N38Q5CC8Mv24kldru9aTDwjxSatoaL+6Xzgpd6JEfjwNFFexUjnGuiQBoNUP/s9N
         3HSmvbU60UrpWVfjKooUnMmVtbxC5O8BjFGuuLrkJBWzF9TddBgK8awQyeL2FZZBoiUy
         GaRQ==
X-Gm-Message-State: ACgBeo1pKOWsn4p7Kb0+JQ4h+D7ndNx/+7zxhr812mcSH62ZzKUDZaAs
        Hoz0JUvA6H9FVx+6QsGWnsA=
X-Google-Smtp-Source: AA6agR43tHlpMRGGkUjVoW0kAMt7dFn9LThfuhRLB9MLhSatBpqsbe/zBNS6osCLbVogDPmJ1T7tNg==
X-Received: by 2002:a62:ab01:0:b0:52d:ca30:f362 with SMTP id p1-20020a62ab01000000b0052dca30f362mr15297462pff.85.1660554116171;
        Mon, 15 Aug 2022 02:01:56 -0700 (PDT)
Received: from DESKTOP-IBN2BAQ.localdomain ([123.110.155.185])
        by smtp.gmail.com with ESMTPSA id a17-20020a656411000000b00412a708f38asm5491612pgv.35.2022.08.15.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:01:55 -0700 (PDT)
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
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v8 01/12] dt-bindings: usb: Add MediaTek MT6370 TCPC
Date:   Mon, 15 Aug 2022 17:01:14 +0800
Message-Id: <20220815090125.27705-2-peterwu.pub@gmail.com>
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

Add MediaTek MT6370 TCPC binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 000000000000..72f56cc88457
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediatTek MT6370 Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  MediaTek MT6370 is a multi-functional device.
+  It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and
+  Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.34.1

