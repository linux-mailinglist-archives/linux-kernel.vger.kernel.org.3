Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FD548F66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355049AbiFMMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357005AbiFMMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463056352C;
        Mon, 13 Jun 2022 04:13:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i64so5443650pfc.8;
        Mon, 13 Jun 2022 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0uTDh6aYM5COnk2LVf+hv3AKvxMR4j6qZouxZ1ZW08=;
        b=oMtXDMaL+3K41xX3wOjL+4cJPZPdia8pK0tBsbVNhsHMmgvlY2yDecUqMCbiNaC+Hn
         8cE8h6SDOvEYWn/WwmLZ7sMRWZcuF9sdzlzyVE8GzzvRuSA1/RBlFOfELSjinK69NNdo
         0RDq6mLN6SnRWd2YXZ3BS8V15ynLULjLSzLfjj62me3lSsdxEdTxpcK9sLqdtAL18ikn
         10+cvHGXBMsVmzKBDU7JNlm+oBJ2PwkYMBbXwe4ddFKqZ4oTzjFc8C/lw0j/6fCvtch2
         /PH0f1TQoGivWlVyZKddDusoDyGdaC3bO0lueeCM1l2VrOtE2glqpbHGcaZb9gaPcN3s
         3QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0uTDh6aYM5COnk2LVf+hv3AKvxMR4j6qZouxZ1ZW08=;
        b=n+zqPlV+/loHgiVLzFGLKtjV4Y/JH2j1u2lYfJT1GGZD5vY36piSl24QnpyyL91SPK
         i5Q81++x41p4YNOLFyn9GVhDsqLMWqpcIZljwITlaGsXFic4zRODqQi6bU+WDn8CBIzd
         FbbY7YCCIySwPSZnHTdnXNesEMikeLUuSyfjrb2xq4dfJbtQEsVaxiYwjTG5obOWgwvY
         WvyLSd4AdzWbdVmageYo8/f4p/sWM1GJNVO525JTwbcSgjOvWHNde/U7rysRv+kWXHtN
         NFKYTahoea0ITMvxRklokcyiCvy6FMQaMbtMbolYF0y2X9uXtbNzwe+Tjk7XLXvMDCNC
         M5NQ==
X-Gm-Message-State: AOAM530AFg2T0iz1UoR8ii3eDMJlO6tMywZEcaGcCmQ7kPaVUROzizyD
        2zRvGFoTNt/SS6z8t7vC9BM=
X-Google-Smtp-Source: ABdhPJzUET+kWcvRpxcgqFcYe7H7yEtugI2dhw2yXyAzpnbUyW0Jye1NyMKd3NCLfMtc5qXAlEC96g==
X-Received: by 2002:a63:2f84:0:b0:408:9c77:7a7e with SMTP id v126-20020a632f84000000b004089c777a7emr68350pgv.191.1655118778405;
        Mon, 13 Jun 2022 04:12:58 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:12:58 -0700 (PDT)
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
Subject: [PATCH v2 03/15] dt-bindings: leds: mt6370: Add Mediatek mt6370 current sink type LED indicator
Date:   Mon, 13 Jun 2022 19:11:34 +0800
Message-Id: <20220613111146.25221-4-peterwu.pub@gmail.com>
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

Add Mediatek mt6370 current sink type LED indicator binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../leds/mediatek,mt6370-indicator.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 000000000000..42b96c8047a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,48 @@
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

