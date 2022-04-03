Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525BC4F09BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358773AbiDCNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358776AbiDCNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:15:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34E17AAB;
        Sun,  3 Apr 2022 06:13:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f3so6584201pfe.2;
        Sun, 03 Apr 2022 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KKxa3qfvCVRnTRZ4freu2hqQtZPY0z6h6IaQVcQg/k=;
        b=dugHyQtseLH9JljgoEtCYnigEgJBPF1GzRq77Blwr5VwydDlIgm7zgdfv5mhL8QBQW
         ErRlsVna50fxWxVAuT6fQ2oOoPzBymTcbRjit0dPvjwPM47NxwNikGe3qaZ2oBrR2q7W
         llftZ1RmN33+8o2OqaGjaO4S6DbXKiT0rSIXxO3RL2fcIvD71cYUtvc9gT5IzpVHs+Mh
         W1sYPEKQt4T6OW0oLKDsqs2H2gjOnByViZ2+IT/7xymv0uy5v2bFheahUIVDUfvPmRks
         GGqQ93oWuLkmj4N7yOKWsqFEg7XA1NOvRf2ytvKFgXS+wxsvt4HI4xhxDyp2oiEiyVxl
         p9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KKxa3qfvCVRnTRZ4freu2hqQtZPY0z6h6IaQVcQg/k=;
        b=OfXjxqcky47mjFb8CzYCPKilVjkRY5BOq+deMOqALwQXz/ZBUZspTEvWB23TOOzM4u
         Em9Xda2xmvTabwbGpWXCv59aNygeEzigL90XhHa8H81kPQ1LtfE38nn17eph5qzSR33C
         M5hMRFQyPwvLPudbWEr2GXCGDkiX5wSCpxbq+iF/dqdsAijMkacDDqA6SVg289rRBgG2
         AV5wypcJUQu5Usc7e/+y62I697km4yPQn2DHTXMJodab9dZEQXVP5ewJvYhDwPGYdhZ2
         yRd6EWLNpKaYoiQCQZbgzT3+AdiyDrBkddfZFxJmmu61pwjD8TTOjMWMdoyIX3qSeVGi
         29UQ==
X-Gm-Message-State: AOAM532VAgTGacEWXyhNBoU1kdZ/Lea5/JwK65nzreBKqBAMsTxs3n0I
        YJcL0bUsGZFG3PIeZ9aGZqc=
X-Google-Smtp-Source: ABdhPJwhx9fr9yzvmrdeEe1YToKKzbD6LhENwF6p9LuKBg7aFviHBI1YFdOHrSc6eBYZBZwDH1K5sA==
X-Received: by 2002:a63:c45:0:b0:399:2629:7743 with SMTP id 5-20020a630c45000000b0039926297743mr645219pgm.24.1648991581722;
        Sun, 03 Apr 2022 06:13:01 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm1554857pfx.80.2022.04.03.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:13:01 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH 3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
Date:   Sun,  3 Apr 2022 21:11:53 +0800
Message-Id: <20220403131154.1267887-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403131154.1267887-1-gch981213@gmail.com>
References: <20220403131154.1267887-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for Mediatek SPI-NAND Flash
Interface.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
new file mode 100644
index 000000000000..166c6b50b9d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-mtk-snfi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND flash controller for MediaTek ARM SoCs
+
+maintainers:
+  - Chuanhong Guo <gch981213@gmail.com>
+
+description: |
+  The Mediatek SPI-NAND flash controller is an extended version of
+  the Mediatek NAND flash controller. It can perform standard SPI
+  instructions with one continuous write and one read for up-to 0xa0
+  bytes. It also supports typical SPI-NAND page cache operations
+  in single, dual or quad IO mode with piplined ECC encoding/decoding
+  using the accompanying ECC engine. There should be only one spi
+  slave device following generic spi bindings.
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-snand
+      - mediatek,mt7629-snand
+  reg:
+    items:
+      - description: core registers
+
+  interrupts:
+    items:
+      - description: NFI interrupt
+
+  clocks:
+    items:
+      - description: clock used for the controller
+      - description: clock used for the SPI bus
+
+  clock-names:
+    items:
+      - const: nfi_clk
+      - const: pad_clk
+
+  ecc-engine:
+    description: device-tree node of the accompanying ECC engine.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ecc-engine
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt7622-clk.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      snfi: spi@1100d000 {
+        compatible = "mediatek,mt7622-snand";
+        reg = <0 0x1100d000 0 0x1000>;
+        interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&pericfg CLK_PERI_NFI_PD>, <&pericfg CLK_PERI_SNFI_PD>;
+        clock-names = "nfi_clk", "pad_clk";
+        ecc-engine = <&bch>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "spi-nand";
+          reg = <0>;
+          spi-tx-bus-width = <4>;
+          spi-rx-bus-width = <4>;
+          nand-ecc-engine = <&snfi>;
+        };
+      };
+    };
-- 
2.35.1

