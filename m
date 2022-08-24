Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7659F664
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiHXJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiHXJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:34:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C485F82;
        Wed, 24 Aug 2022 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661333666; x=1692869666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOfUOzSJpeIrBATb5lp6GaWkbg8LWjpjsxRSRZHcsx4=;
  b=QNQpyoxPFTS1RTxS2/i7MJrtdtMvN2S8o5cmw5cKyvzm05YCX2LCfput
   4QXmLvS/+XnU1rYq+KxgFsLw9lAqjDD2NvtXDAXdORn13ucgaDdd09Z3l
   WsGft4/QeF+pPac2es3WCIrY916XjoGTRx8bs6khz8X1FWsuyKSLwZ+mD
   n+WgeexKX8koGk8I23Nq+wv7OolxErpm+P+IxSUoW1Z7kxPK7387N+25n
   BKCmJ9Cut72xuC+fC2gaZa3NbMKxnhDbajUtuDF+KqwziI8h3bP3CItFc
   H4y5cTJoSR9fda81GeUgkRuzRRBe8FcXymV8hRZAvlPHqvNkZt7qKQ1Q2
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173887592"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 02:34:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 02:34:22 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 02:34:20 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Hugh Breslin <hugh.breslin@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 2/5] dt-bindings: clk: document PolarFire SoC fabric clocks
Date:   Wed, 24 Aug 2022 10:33:40 +0100
Message-ID: <20220824093342.187844-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824093342.187844-1-conor.dooley@microchip.com>
References: <20220824093342.187844-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PolarFire SoC there are 4 PLL/DLL blocks, located in each of the
ordinal corners of the chip, which our documentation refers to as
"Clock Conditioning Circuitry". PolarFire SoC is an FPGA, these are
highly configurable & many of the input clocks are optional.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs-ccc.yaml    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
new file mode 100644
index 000000000000..f1770360798f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/microchip,mpfs-ccc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC Fabric Clock Conditioning Circuitry
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description: |
+  Microchip PolarFire SoC has 4 Clock Conditioning Circuitry blocks. Each of
+  these blocks contains two PLLs and 2 DLLs & are located in the four corners of
+  the FPGA. For more information see "PolarFire SoC FPGA Clocking Resources" at:
+  https://onlinedocs.microchip.com/pr/GUID-8F0CC4C0-0317-4262-89CA-CE7773ED1931-en-US-1/index.html
+
+properties:
+  compatible:
+    const: microchip,mpfs-ccc
+
+  reg:
+    items:
+      - description: PLL0's control registers
+      - description: PLL1's control registers
+      - description: DLL0's control registers
+      - description: DLL1's control registers
+
+  clocks:
+    description:
+      The CCC PLL's have two input clocks. It is required that even if the input
+      clocks are identical that both are provided.
+    minItems: 2
+    items:
+      - description: PLL0's refclk0
+      - description: PLL0's refclk1
+      - description: PLL1's refclk0
+      - description: PLL1's refclk1
+      - description: DLL0's refclk
+      - description: DLL1's refclk
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: pll0_ref0
+      - const: pll0_ref1
+      - const: pll1_ref0
+      - const: pll1_ref1
+      - const: dll0_ref
+      - const: dll1_ref
+
+  '#clock-cells':
+    const: 1
+    description: |
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
+      PolarFire clock IDs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@38100000 {
+        compatible = "microchip,mpfs-ccc";
+        reg = <0x38010000 0x1000>, <0x38020000 0x1000>,
+              <0x39010000 0x1000>, <0x39020000 0x1000>;
+        #clock-cells = <1>;
+        clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
+                  <&refclk_ccc>, <&refclk_ccc>;
+        clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
+                      "dll0_ref", "dll1_ref";
+    };
-- 
2.36.1

