Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494945A66EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiH3PKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiH3PJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:09:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6451A64F7;
        Tue, 30 Aug 2022 08:09:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 145so11271438pfw.4;
        Tue, 30 Aug 2022 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=bhFPbBH1HWG+CvWDsxibGSv/KPEHci/JQzJBudsEayE=;
        b=QGg80NnGeBhVPnHboz7i1txHnXiJDru0SsdoFYy5VFP3kIP+JI1pUvlKwAG9PSUvSq
         QCzabiZFYg3USdQx9/BV9kxpxNNx9Ft2eOlgWvZdSwOYTZZDOymXwmLfoMvYgYGR07WE
         ffA+C/2GU2fiLfX+tlPM3PQVIgwE/cNBuCmq2RlhHfkW9SQGWlvDhnuZIIK47zvJOiVn
         3hhNkvA7krBVw2bF0NuJg5FBRl39DDywgSVVfmplpYIwG1/EIJgjseBD/HNnc8gzDJEE
         tB7dLNAZuYrWS48/2bx3EyxizaJYMzLyp2ByasWMpOkEGoFYRdZ6oWyGwj+TvGe7z+n1
         EACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bhFPbBH1HWG+CvWDsxibGSv/KPEHci/JQzJBudsEayE=;
        b=ur1w8eKC77W7rVRvpnj4k/9HQpJw3qNzu3XscFDv23UK8e0alfV1weN3q015bah+Ny
         T8+8caTkaWa8oREthO5JG7ZMZ+1/zkE7tiZngexpSuXEOmibR2W38DLPTGv/d1RvgTf7
         Is28Pj1x8Tv8S4B/aay34Ieq94JkOK18qCvPdqEH9jk2UzU/RmWqbFt9UHV8H6qSycKa
         f5xTZoIg3glRDnWhn2JLtMpAzMlHvgUJXsIn/Y1P5m64JMdHI93tpWmsMVGZgsZ44Hls
         r0l5l7xBk7010ZUX8CVqh08N7WYYZAm+JCZKl+keEGw3SogazrUlAjRZOEqvLrqnPAjx
         o7OQ==
X-Gm-Message-State: ACgBeo1WlpvyNkazgWyGAi+3t7DTOO606Dvczs1XOi65Tdu8QFfxxqQq
        t32BhfBZRbC9T8TSwiDr3g==
X-Google-Smtp-Source: AA6agR6G5wrT02zhPRWkd66J1541yZke46MrQ+RAEnYcSITk+77l1M0g+9mUTUo4Sx1SgXD/zhcg0Q==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr22063954pfh.15.1661872193784;
        Tue, 30 Aug 2022 08:09:53 -0700 (PDT)
Received: from localhost.localdomain ([116.30.109.180])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00172c7d6badcsm9717778plb.251.2022.08.30.08.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:09:53 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Tue, 30 Aug 2022 08:07:19 -0700
Message-Id: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
v1->v2:
1.Fix some build errors.

v2->v3:
1.Fix some build errors.

v3->v4:
1.None.

v4->v5:
1.Add interrupt.
2.Keep clock and reset index.

v5->v6:
1.None.

v6->v7:
1.None.

v7->v8:
1.Fix some build errors.

v8->v9:
1.None.
---
 .../bindings/sound/allwinner,sun50i-h6-dmic.yaml   | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 0000000..0cfc07f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 DMIC Device Tree Bindings
+
+maintainers:
+  - Ban Tao <fengzheng923@gmail.com>
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: allwinner,sun50i-h6-dmic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    dmic: dmic@5095000 {
+      #sound-dai-cells = <0>;
+      compatible = "allwinner,sun50i-h6-dmic";
+      reg = <0x05095000 0x400>;
+      interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
+      clock-names = "bus", "mod";
+      dmas = <&dma 7>;
+      dma-names = "rx";
+      resets = <&ccu RST_BUS_DMIC>;
+    };
+
+...
-- 
2.7.4

