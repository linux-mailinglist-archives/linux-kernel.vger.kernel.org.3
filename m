Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87226524604
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiELGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350489AbiELGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:39:44 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5248674E4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:39:23 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26385:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 12 May 2022 14:32:12 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021 clock driver
Date:   Thu, 12 May 2022 14:30:59 +0800
Message-Id: <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1652329411.git.qinjian@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 clock driver bindings.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
Remove "Binding" from yaml title
Rename sp-sp7021.h to sunplus,sp7021-clkc.h
---
 .../bindings/clock/sunplus,sp7021-clkc.yaml   | 51 +++++++++++
 MAINTAINERS                                   |  2 +
 .../dt-bindings/clock/sunplus,sp7021-clkc.h   | 88 +++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 create mode 100644 include/dt-bindings/clock/sunplus,sp7021-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
new file mode 100644
index 000000000..119961a17
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 SoC Clock Controller
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+
+    extclk: osc0 {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <27000000>;
+      clock-output-names = "extclk";
+    };
+
+    clkc: clock-controller@9c000000 {
+      compatible = "sunplus,sp7021-clkc";
+      reg = <0x9c000000 0x280>;
+      clocks = <&extclk>;
+      #clock-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4988db270..cd1b2ffc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2744,8 +2744,10 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	drivers/reset/reset-sunplus.c
+F:	include/dt-bindings/clock/sunplus,sp7021-clkc.h
 F:	include/dt-bindings/reset/sunplus,sp7021-reset.h
 
 ARM/Synaptics SoC support
diff --git a/include/dt-bindings/clock/sunplus,sp7021-clkc.h b/include/dt-bindings/clock/sunplus,sp7021-clkc.h
new file mode 100644
index 000000000..cd84321eb
--- /dev/null
+++ b/include/dt-bindings/clock/sunplus,sp7021-clkc.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+
+/* gates */
+#define CLK_RTC         0
+#define CLK_OTPRX       1
+#define CLK_NOC         2
+#define CLK_BR          3
+#define CLK_SPIFL       4
+#define CLK_PERI0       5
+#define CLK_PERI1       6
+#define CLK_STC0        7
+#define CLK_STC_AV0     8
+#define CLK_STC_AV1     9
+#define CLK_STC_AV2     10
+#define CLK_UA0         11
+#define CLK_UA1         12
+#define CLK_UA2         13
+#define CLK_UA3         14
+#define CLK_UA4         15
+#define CLK_HWUA        16
+#define CLK_DDC0        17
+#define CLK_UADMA       18
+#define CLK_CBDMA0      19
+#define CLK_CBDMA1      20
+#define CLK_SPI_COMBO_0 21
+#define CLK_SPI_COMBO_1 22
+#define CLK_SPI_COMBO_2 23
+#define CLK_SPI_COMBO_3 24
+#define CLK_AUD         25
+#define CLK_USBC0       26
+#define CLK_USBC1       27
+#define CLK_UPHY0       28
+#define CLK_UPHY1       29
+#define CLK_I2CM0       30
+#define CLK_I2CM1       31
+#define CLK_I2CM2       32
+#define CLK_I2CM3       33
+#define CLK_PMC         34
+#define CLK_CARD_CTL0   35
+#define CLK_CARD_CTL1   36
+#define CLK_CARD_CTL4   37
+#define CLK_BCH         38
+#define CLK_DDFCH       39
+#define CLK_CSIIW0      40
+#define CLK_CSIIW1      41
+#define CLK_MIPICSI0    42
+#define CLK_MIPICSI1    43
+#define CLK_HDMI_TX     44
+#define CLK_VPOST       45
+#define CLK_TGEN        46
+#define CLK_DMIX        47
+#define CLK_TCON        48
+#define CLK_GPIO        49
+#define CLK_MAILBOX     50
+#define CLK_SPIND       51
+#define CLK_I2C2CBUS    52
+#define CLK_SEC         53
+#define CLK_DVE         54
+#define CLK_GPOST0      55
+#define CLK_OSD0        56
+#define CLK_DISP_PWM    57
+#define CLK_UADBG       58
+#define CLK_FIO_CTL     59
+#define CLK_FPGA        60
+#define CLK_L2SW        61
+#define CLK_ICM         62
+#define CLK_AXI_GLOBAL  63
+
+/* plls */
+#define PLL_A           64
+#define PLL_E           65
+#define PLL_E_2P5       66
+#define PLL_E_25        67
+#define PLL_E_112P5     68
+#define PLL_F           69
+#define PLL_TV          70
+#define PLL_TV_A        71
+#define PLL_SYS         72
+
+#define CLK_MAX         73
+
+#endif
-- 
2.33.1

