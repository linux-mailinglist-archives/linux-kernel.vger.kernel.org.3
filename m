Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91050CEF2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiDXDaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbiDXD3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:29:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F538FFEC6;
        Sat, 23 Apr 2022 20:26:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 15so2234085pgf.4;
        Sat, 23 Apr 2022 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=515OXkaaLsXBOTXwN+W2kLxRXcgyH7f1wIj3RDCO+iM=;
        b=GgklGDM6qZ3gecj3Y4PMhHIKiY52vuaTClV6/xRXB7+VYkSg12LeK8yXgdPpGUBqbs
         W7u7gV0TezjWnnrE/2yIyIqS3marQDgFypZmHS1fuZoXFeygJjjzAcoXHC2vAPvx3LVF
         M8mGeYSYSoVTJJcJorPuDFl3gGffkUAjfdgwp59PAtUR4AFmPEkyuUXnlhW2aaQfz1MX
         3nuyS+YK9VTI6GRaJ5kOO+6ze5fiei427xP3DQ4qV0WMrpFDuoXTk5ahhLOGP6m8t328
         mWfzBWkiwH/rDRRGOuCQLpbLTlW9bkDiXMkZn2WvVzCDtBUApNeeFQiBD+7TzEEVfMhN
         aZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=515OXkaaLsXBOTXwN+W2kLxRXcgyH7f1wIj3RDCO+iM=;
        b=l0WfJQpogybg+ZeN6xifM8T8Xk2otFMgT40z6oEsVlNyjS3tQ7lkjykjr0nJSXsLsb
         yd3PesTTHv8hsz56NetwzdM4fpbD1MIERgbRoZ+NhLeY2b/HbSU3J4tEve3NoT26pCY9
         Nj3mZFS+TGk+D4irH0oggHAjTbhPldD3xNkDTTezyj0RUiezDiilqGlCRRgREwnyoo5X
         lK8B1Y4xxNhvjIpI1txlUCW7HKtsXCzg68uOYPvjzjuxhjKRq3xBOXP9N1fz2F7Lc82d
         ZGjej8h0wdCUVWyCvz7AUEjQiO3FNENaPMuMZWxtSicNYDlEjzu69TUF23l+34MImh1e
         AUIQ==
X-Gm-Message-State: AOAM531lf7rEXebjXwwRku7tBe1ZBoOavmbr75ikY2oGSr70WlZj3JgH
        kLqvJ29HUZnhVoNrGE5CqD9pHqbS+7wWe/ld
X-Google-Smtp-Source: ABdhPJxnUi/hi4CZA6156zTJSdh8sfTwaRohBb39mkA9j+vd6Pg/vHrI8ib1eX88yWsXuxsZu+0yXg==
X-Received: by 2002:a05:6a00:134b:b0:50c:f10e:8eff with SMTP id k11-20020a056a00134b00b0050cf10e8effmr9674817pfu.79.1650770789721;
        Sat, 23 Apr 2022 20:26:29 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id r76-20020a632b4f000000b003820643e1c2sm5790724pgr.59.2022.04.23.20.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:26:29 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v6 4/5] spi: dt-bindings: add binding doc for spi-mtk-snfi
Date:   Sun, 24 Apr 2022 11:25:26 +0800
Message-Id: <20220424032527.673605-5-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424032527.673605-1-gch981213@gmail.com>
References: <20220424032527.673605-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for Mediatek SPI-NAND Flash
Interface.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
  1. add a blank line between properties in dt binding doc
  2. rename ecc-engine to nand-ecc-engine for the generic properties

Change since v2: none
Change since v3: fix a missing rename in v1
Change since v4: fix typo: piplined -> pipelined
Change since v5: none

 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
new file mode 100644
index 000000000000..6e6e02c91780
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
@@ -0,0 +1,88 @@
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
+  in single, dual or quad IO mode with pipelined ECC encoding/decoding
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
+
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
+  nand-ecc-engine:
+    description: device-tree node of the accompanying ECC engine.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - nand-ecc-engine
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
+        nand-ecc-engine = <&bch>;
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

