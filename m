Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1418592C88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiHOJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHOJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:02:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18E20F7B;
        Mon, 15 Aug 2022 02:02:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ha11so6449404pjb.2;
        Mon, 15 Aug 2022 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jAsfJ+1Mj231OgXM143U7NPHPGk8lg/9nj5rbtDQosU=;
        b=WZ7JCEDfOCy3EQc5zn+wa2S43ThV6A5Z+pXUm6y6i/JVlAKwcpmswgci9bKG6Tto0s
         R1ATcrJysD9d/BYkcsdmTjMU5H9nBlu9VxBkly86fZF+5sJpeCDliZcdf+4+iWYDlXkM
         aUCwf7twuGPYRbkgqG0cHysxXNgC1ytMhfnlCGVzgcNgClELvHpR1w6ZBchctvbmu+jS
         6g+SuWzKgvUyNZ/klrYsx6R+BYTuSnvKMuIeQYRs+h2aIU1KA3unKUNEBJ/v5fRDIJ5s
         O8qXrbCZ9RiEUqx485ArryjaPy7bDd+4mQOQDsDQRAicC5W9Tljyw/aKLA6v9wkpTH12
         s9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jAsfJ+1Mj231OgXM143U7NPHPGk8lg/9nj5rbtDQosU=;
        b=bK1tDtVZq5ASRW74OiGwVnpVwPN4FWBx1tH/Yl7FtniDHBpd0GP2TgMYfbOOOR/T4a
         QAeidCeNto0L91/I9NSuT9ycAC7ZrLZ5AdDdN/9UlvzLElDSzPgWOq1HJhX6ewzqI8Sm
         FnSDJPXiy9RoyCRGkkKWNNJvnEqnnE5G2E+rs0Wtv0iLvFZILIZm+Hk56VCVlTxg2oYm
         lmMGIbX4aAjs1wm6Q20vVr4R1GcGtXFg5YPBxaT4XAr+SNhvFWGSMa7ERdDTRrwDbWlR
         amQlylkm6ePiSkFWXw65ODeYlfaqi8vyFSzQ4KgmxivAIQbf1DK1grK5iLxBVMcJNWVE
         G4kw==
X-Gm-Message-State: ACgBeo3ZmHwOzJbC9Lk6Ym9B5jTfA23AofBtI+02JC6UtmDWPaliaxDK
        1jgjt/JrZn4mgbd9dy22rrY=
X-Google-Smtp-Source: AA6agR5dIpLJZek/MOUWkP2ReJX+eAO+AT8j8pByvCyU/tbsfvLHdxFvGlojO+1yfFH1nCHoON9fTQ==
X-Received: by 2002:a17:903:264f:b0:16f:8435:d9a8 with SMTP id je15-20020a170903264f00b0016f8435d9a8mr16300638plb.112.1660554138279;
        Mon, 15 Aug 2022 02:02:18 -0700 (PDT)
Received: from DESKTOP-IBN2BAQ.localdomain ([123.110.155.185])
        by smtp.gmail.com with ESMTPSA id a17-20020a656411000000b00412a708f38asm5491612pgv.35.2022.08.15.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:02:18 -0700 (PDT)
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
Subject: [RESEND v8 04/12] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Mon, 15 Aug 2022 17:01:17 +0800
Message-Id: <20220815090125.27705-5-peterwu.pub@gmail.com>
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

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../leds/mediatek,mt6370-flashlight.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 000000000000..e9d02ed6a590
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
2.34.1

