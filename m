Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5425D53906F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbiEaMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbiEaMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:15:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED6994C0;
        Tue, 31 May 2022 05:15:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so12652643pgk.11;
        Tue, 31 May 2022 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLlQWPmyPhz9LkYQh7iizThmB3DZjfxS2yfzbAOphFg=;
        b=I4w6+q3mrUIL109pwzpTze5IvWiG+1Sm6Q/7ihB35G4+4nU2YnPrXRziLx+TjwQPKJ
         27v96U4XlLTj4qvRe1P7BgC7TeHdudGmcMfT8xhVbtoceFoPSsDrFiSspzWjKMLuZBJW
         NNPufZ9HklQcqk+CRGhV5CV3j//Lsh2GOI3ZrSJSChpHw4LFbutgxJNqUqN6lh3qf+xQ
         3FMeYyOYJBXw4mgAWgYyBsEGP+9QcO74DD7r3ElXM/gBg5lFBlDhaRkqIxCfG86r2kGS
         qTg9vzWnm3t4x6/LXNTmuPN2mNUySP8cPOORTBWUclVtUSbi0DxWMAHxDg2PiIXQwtc3
         IH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLlQWPmyPhz9LkYQh7iizThmB3DZjfxS2yfzbAOphFg=;
        b=Gcp6iF55zQAHt+OpeUOq4xwKnxD/IUZUe426fpOuFVp1aT1G/UZMPOyN/eTD17smnk
         7gnP8MR0fUlON8NpEd+Icu0QLAEjgm22t2e1l4OBNRgne0PlIw8wZd6CpLnwNgxr2NoA
         vtHRKb+gRkucuC0U5oHleB+TgNtMwUUM/OMkTjGBXcVmZ6kXf1BwXx2mooo7D8+Susi6
         nGLq1B0c+kbnFee12g3LJT8aW4ByU8nMsSSGgzjlUoqo4BBfM/Puh3hp83O1VtbOF9y6
         yrPz8JAY6YJ0dqy06nYOAAy6phbtw++mQQ8TSyYkhjtCPzmvlqPJvFHsxGAMaxf2uD1Z
         K8vg==
X-Gm-Message-State: AOAM530gQrbGWNk8injCAMOlB462s8jVhhVaavH1iGMWjk1cBu9bsFPu
        snQDhYgOmysThqOrctNFVcoeZGKhQm8=
X-Google-Smtp-Source: ABdhPJyD1Fx7LBxTURdowjLzD5c7Yqcp9ob1xo5BIIaa0fHPSwQ8ngkBhpXhhcH/7b+MIEJs3XVqjw==
X-Received: by 2002:a63:1009:0:b0:3fa:9996:386b with SMTP id f9-20020a631009000000b003fa9996386bmr31594847pgl.441.1653993061902;
        Tue, 31 May 2022 03:31:01 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:31:01 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 11/14] dt-bindings: leds: mt6370: Add Mediatek mt6370 indicator documentation
Date:   Tue, 31 May 2022 18:28:06 +0800
Message-Id: <20220531102809.11976-12-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531102809.11976-1-peterwu.pub@gmail.com>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
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

