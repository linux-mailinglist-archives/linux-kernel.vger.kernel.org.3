Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB457601D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGOL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGOL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:26:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9288768;
        Fri, 15 Jul 2022 04:26:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b8so5371546pjo.5;
        Fri, 15 Jul 2022 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxGKLw/sS7fdJZuE8bLGBTMKV4RyLr0/hVQFdtvG6hY=;
        b=WboNAeOE8zUIByDWEwnyde87CtzBmrbdti4AKCsZfCWV2qiSc8kOZu41SxPIZj8GET
         c13f4iEKQtbYsCgkl25EFNQeJqBoxRhrmcEORQKISJjJXA1C4SG8M7mgZJdk9JLAk1Nx
         gS4IDfySupoxdTro7OH0R34aAROWLE2Wg4Ll6D3MUVmEFM4H9miJcsDxTPL5+SEFmdFO
         GYz3l37CyNfTwziEu3yBr+JiwWx5NR06sGtTakqH682gRLtstaxj7jN/lk06dNqf6Da+
         wMMp90zBsAGb7CgnJG6GcxBnh2dnmWDpzR2ycGXP2eh1lUZ3pbQ7oPmAFk9azTRatLzm
         Gtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxGKLw/sS7fdJZuE8bLGBTMKV4RyLr0/hVQFdtvG6hY=;
        b=OLCoWt16ut2sZlb+rWwBFEQ3ylwgbQDZ1QXH9rXThxgGudm2p5bVskKlET5R7NQlTU
         5+p0hJY1vyrQYNDly79wWk2F6QhAjaAEiJSu8JWnD8yweYISHsrOjtsxpDs+Q64nkATA
         iCWyUQzm1oqp/GZQg+EEdK1CvWsZhNeiZIBHq3nk92MaNoyEazncGq224NkFqkJRojmI
         esIMCJVe3BmG2fuykAVWWl/NdqOVmuHph1/+ASZzx9CZcBiqMTrJl8dfgsaPquQFwmGG
         5d3glO1Nd1m1v+2udgC85UDgQVMTJO+jA9NAr1Kb7G1KL/HQJNLff/oa1+X7UhTYUZwn
         vmGA==
X-Gm-Message-State: AJIora+7TjjNoY7V668h0s6B4U+38Ukcea4HOvVkMnmrXlbZPZPgOWt5
        4QAdaD9I9twRQ0nv5Y3h+Ks=
X-Google-Smtp-Source: AGRyM1sZltUw/1JpGkrrx6xlT+Z5GjpcQ3KIeIf35T9nrHUA2Cz4hQ1u/67IaF4MBUiOqAfgRZNPTA==
X-Received: by 2002:a17:90b:1bc7:b0:1f0:34e2:5c86 with SMTP id oa7-20020a17090b1bc700b001f034e25c86mr14843981pjb.136.1657884406842;
        Fri, 15 Jul 2022 04:26:46 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-159-86.emome-ip.hinet.net. [42.72.159.86])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b00525b61f4792sm3550604pfr.109.2022.07.15.04.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:26:46 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 04/13] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Fri, 15 Jul 2022 19:25:58 +0800
Message-Id: <20220715112607.591-5-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715112607.591-1-peterwu.pub@gmail.com>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
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

