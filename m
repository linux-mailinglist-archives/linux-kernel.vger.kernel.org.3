Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E570B557947
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiFWL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiFWL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EA04D60A;
        Thu, 23 Jun 2022 04:57:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u37so18887341pfg.3;
        Thu, 23 Jun 2022 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5oBLDeH2TFPPE1qW+095x6ar1U98gaW60A2FSoyamQ=;
        b=PcxhtUBnyPDnzbGcjPOH22wXUg64coBDrbIKm55BA3uBCZt/v0IKz/meTcap2SGjfB
         OAcyzRkqDFgj4gT5v9h8X67lB1yjdI9ZAyixj1KSxpOIjrnSZ1e1c9ZzXQxo9DrgvgLa
         EPp1YijsJXMTxKlaJO2mkfyWZfyydkymswth5pdzC1bR2GVbnonCWv5RlGypNuNly0pT
         9dZotbzBxyhN/3Q81oUMzbBRJ+w2n8GyXCz4SQJRfnCREQ8qXmvhiTCOt4UzrPhNIqtT
         hjCEfw3BwBKpMvGZGDhfyXBpK6vYDap9fFAbWjHb1Kq1q2Pl5jVEGRtxPnCy5gwo61/O
         BxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5oBLDeH2TFPPE1qW+095x6ar1U98gaW60A2FSoyamQ=;
        b=pkevutdugc9s9hL7bMdnLoWsnQMQxklAZq+bSdiAE3IYYkE2KL86/eP696Dz3PeoJn
         +ApE0bufp32rKvdnF387hJ+qyb6G3MFV7Rwm073AvvMEQ2urxAPojthhOzjliKo6FhGM
         k5Ym+fju0B+qGfKJrR740erBWBDXgPWo0ETxkhtK8BvcB4dGDBWHtZUpYQ1ZMFlKLyBZ
         R7HLLGFgorwbRFWaivvIbF6k41YAOJmm4UvRHaIg7xd4KIo+OgeH8hNuY2tmHssDei+J
         RdFhEksYZ63iLteY0fbKACVooYViMmTC1IjmtmsfIuVmE2t7SaVAohnWRGc9YDux0EQf
         7P2A==
X-Gm-Message-State: AJIora+STg/mMRih2+NPnXmBzHMxxM5WyfyH1XmuH3h/+av+BLyCt14v
        +DOCGemLTrCtsNgttL4eFxk=
X-Google-Smtp-Source: AGRyM1v2dS8GCsHCr6bAYJn0dJ8H5c9Q7wS9pSlJJ8PZKZKq3RJ5NeGGUM/SZNXaholm+I9PvXwMjw==
X-Received: by 2002:a05:6a00:22ce:b0:51c:15ac:3977 with SMTP id f14-20020a056a0022ce00b0051c15ac3977mr40443294pfj.3.1655985443535;
        Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
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
        szunichen@gmail.com
Subject: [PATCH v3 03/14] dt-bindings: leds: mt6370: Add Mediatek mt6370 current sink type LED indicator
Date:   Thu, 23 Jun 2022 19:56:20 +0800
Message-Id: <20220623115631.22209-4-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
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

v3
- Use leds-class-multicolor.yaml instead of common.yaml.
- Split multi-led and led node.
- Add subdevice "led" in "multi-led".
---
 .../bindings/leds/mediatek,mt6370-indicator.yaml   | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
new file mode 100644
index 0000000..45030f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -0,0 +1,77 @@
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

