Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD8530420
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349155AbiEVP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349205AbiEVP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:58:27 -0400
Received: from herzl.nuvoton.co.il (unknown [212.199.177.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF23B2B4;
        Sun, 22 May 2022 08:58:20 -0700 (PDT)
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 24MFp3dS031630;
        Sun, 22 May 2022 18:51:03 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AAAB063A4A; Sun, 22 May 2022 18:51:03 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 07/19] dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
Date:   Sun, 22 May 2022 18:50:34 +0300
Message-Id: <20220522155046.260146-8-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220522155046.260146-1-tmaimon77@gmail.com>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton Arbel BMC NPCM7XX contains an integrated clock controller, which
generates and supplies clocks to all modules within the BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml   | 68 +++++++++++++++++++
 .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 ++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
new file mode 100644
index 000000000000..f305c7c7eaf0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM8XX Clock Controller Binding
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description: |
+  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
+  generates and supplies clocks to all modules within the BMC.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm845-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      specify the external clocks used by the NPCM8XX clock module.
+    items:
+      - description: 25M reference clock
+      - description: CPU reference clock
+      - description: MC reference clock
+
+  clock-names:
+    description:
+      specify the external clocks names used by the NPCM8XX clock module.
+    items:
+      - const: refclk
+      - const: sysbypck
+      - const: mcbypck
+
+  '#clock-cells':
+    const: 1
+    description:
+      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
+      list of NPCM8XX clock IDs.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+
+    ahb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clk: clock-controller@f0801000 {
+            compatible = "nuvoton,npcm845-clk";
+            reg = <0x0 0xf0801000 0x0 0x1000>;
+            #clock-cells = <1>;
+        };
+    };
+
+...
diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
new file mode 100644
index 000000000000..d76f606bf88b
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Nuvoton NPCM8xx Clock Generator binding
+ * clock binding number for all clocks supportted by nuvoton,npcm8xx-clk
+ *
+ * Copyright (C) 2021 Nuvoton Technologies tomer.maimon@nuvoton.com
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_NPCM8XX_H
+#define __DT_BINDINGS_CLOCK_NPCM8XX_H
+
+#define NPCM8XX_CLK_CPU		0
+#define NPCM8XX_CLK_GFX_PIXEL	1
+#define NPCM8XX_CLK_MC		2
+#define NPCM8XX_CLK_ADC		3
+#define NPCM8XX_CLK_AHB		4
+#define NPCM8XX_CLK_TIMER	5
+#define NPCM8XX_CLK_UART	6
+#define NPCM8XX_CLK_UART2	7
+#define NPCM8XX_CLK_MMC		8
+#define NPCM8XX_CLK_SPI3	9
+#define NPCM8XX_CLK_PCI		10
+#define NPCM8XX_CLK_AXI		11
+#define NPCM8XX_CLK_APB4	12
+#define NPCM8XX_CLK_APB3	13
+#define NPCM8XX_CLK_APB2	14
+#define NPCM8XX_CLK_APB1	15
+#define NPCM8XX_CLK_APB5	16
+#define NPCM8XX_CLK_CLKOUT	17
+#define NPCM8XX_CLK_GFX		18
+#define NPCM8XX_CLK_SU		19
+#define NPCM8XX_CLK_SU48	20
+#define NPCM8XX_CLK_SDHC	21
+#define NPCM8XX_CLK_SPI0	22
+#define NPCM8XX_CLK_SPI1	23
+#define NPCM8XX_CLK_SPIX	24
+#define NPCM8XX_CLK_RG		25
+#define NPCM8XX_CLK_RCP		26
+#define NPCM8XX_CLK_PRE_ADC	27
+#define NPCM8XX_CLK_ATB		28
+#define NPCM8XX_CLK_PRE_CLK	29
+#define NPCM8XX_CLK_TH		30
+#define NPCM8XX_CLK_REFCLK	31
+#define NPCM8XX_CLK_SYSBYPCK	32
+#define NPCM8XX_CLK_MCBYPCK	33
+
+#define NPCM8XX_NUM_CLOCKS	(NPCM8XX_CLK_MCBYPCK + 1)
+
+#endif
-- 
2.33.0

