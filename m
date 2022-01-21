Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80364495B66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349304AbiAUH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:58:10 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:55858 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349256AbiAUH6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:58:07 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24938:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 21 Jan 2022 15:53:24 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v8 05/10] dt-bindings: clock: Add bindings for SP7021 clock driver
Date:   Fri, 21 Jan 2022 15:53:13 +0800
Message-Id: <504303c7cf92af8368dcda0cdde3b9c15a833418.1642751015.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642751015.git.qinjian@cqplus1.com>
References: <cover.1642751015.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 clock driver bindings.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
Add clocks & clock-names.
---
 .../bindings/clock/sunplus,sp7021-clkc.yaml   |  52 ++++++++
 MAINTAINERS                                   |   2 +
 include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 create mode 100644 include/dt-bindings/clock/sp-sp7021.h

diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
new file mode 100644
index 000000000..e6d098cf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 SoC Clock Controller Binding
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-clkc
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: External oscillator clock
+      - description: System clock
+
+  clock-names:
+    items:
+      - const: extclk
+      - const: pllsys
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clkc: clock-controller@9c000000 {
+      compatible = "sunplus,sp7021-clkc";
+      #clock-cells = <1>;
+      reg = <0x9c000000 0x280>;
+      clocks = <&extclk>, <&clkc PLL_SYS>;
+      clock-names = "extclk", "pllsys";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6caffd6d0..90ebb823f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2661,8 +2661,10 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	drivers/reset/reset-sunplus.c
+F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
diff --git a/include/dt-bindings/clock/sp-sp7021.h b/include/dt-bindings/clock/sp-sp7021.h
new file mode 100644
index 000000000..45dac6de8
--- /dev/null
+++ b/include/dt-bindings/clock/sp-sp7021.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+
+#define XTAL			27000000
+
+/* plls */
+#define PLL_A			0
+#define PLL_E			1
+#define PLL_E_2P5		2
+#define PLL_E_25		3
+#define PLL_E_112P5		4
+#define PLL_F			5
+#define PLL_TV			6
+#define PLL_TV_A		7
+#define PLL_SYS			8
+
+/* gates: mo_clken0 ~ mo_clken9 */
+#define CLK_SYSTEM		0x10
+#define CLK_RTC			0x12
+#define CLK_IOCTL		0x13
+#define CLK_IOP			0x14
+#define CLK_OTPRX		0x15
+#define CLK_NOC			0x16
+#define CLK_BR			0x17
+#define CLK_RBUS_L00	        0x18
+#define CLK_SPIFL		0x19
+#define CLK_SDCTRL0		0x1a
+#define CLK_PERI0		0x1b
+#define CLK_A926		0x1d
+#define CLK_UMCTL2		0x1e
+#define CLK_PERI1		0x1f
+
+#define CLK_DDR_PHY0	        0x20
+#define CLK_ACHIP		0x22
+#define CLK_STC0		0x24
+#define CLK_STC_AV0		0x25
+#define CLK_STC_AV1		0x26
+#define CLK_STC_AV2		0x27
+#define CLK_UA0			0x28
+#define CLK_UA1			0x29
+#define CLK_UA2			0x2a
+#define CLK_UA3			0x2b
+#define CLK_UA4			0x2c
+#define CLK_HWUA		0x2d
+#define CLK_DDC0		0x2e
+#define CLK_UADMA		0x2f
+
+#define CLK_CBDMA0		0x30
+#define CLK_CBDMA1		0x31
+#define CLK_SPI_COMBO_0	        0x32
+#define CLK_SPI_COMBO_1	        0x33
+#define CLK_SPI_COMBO_2	        0x34
+#define CLK_SPI_COMBO_3	        0x35
+#define CLK_AUD			0x36
+#define CLK_USBC0		0x3a
+#define CLK_USBC1		0x3b
+#define CLK_UPHY0		0x3d
+#define CLK_UPHY1		0x3e
+
+#define CLK_I2CM0		0x40
+#define CLK_I2CM1		0x41
+#define CLK_I2CM2		0x42
+#define CLK_I2CM3		0x43
+#define CLK_PMC			0x4d
+#define CLK_CARD_CTL0	        0x4e
+#define CLK_CARD_CTL1	        0x4f
+
+#define CLK_CARD_CTL4	        0x52
+#define CLK_BCH			0x54
+#define CLK_DDFCH		0x5b
+#define CLK_CSIIW0		0x5c
+#define CLK_CSIIW1		0x5d
+#define CLK_MIPICSI0	        0x5e
+#define CLK_MIPICSI1	        0x5f
+
+#define CLK_HDMI_TX		0x60
+#define CLK_VPOST		0x65
+
+#define CLK_TGEN		0x70
+#define CLK_DMIX		0x71
+#define CLK_TCON		0x7a
+#define CLK_INTERRUPT	        0x7f
+
+#define CLK_RGST		0x80
+#define CLK_GPIO		0x83
+#define CLK_RBUS_TOP	        0x84
+
+#define CLK_MAILBOX		0x96
+#define CLK_SPIND		0x9a
+#define CLK_I2C2CBUS	        0x9b
+#define CLK_SEC			0x9d
+#define CLK_DVE			0x9e
+#define CLK_GPOST0		0x9f
+
+#define CLK_OSD0		0xa0
+#define CLK_DISP_PWM	        0xa2
+#define CLK_UADBG		0xa3
+#define CLK_DUMMY_MASTER	0xa4
+#define CLK_FIO_CTL		0xa5
+#define CLK_FPGA		0xa6
+#define CLK_L2SW		0xa7
+#define CLK_ICM			0xa8
+#define CLK_AXI_GLOBAL	        0xa9
+
+#define CLK_MAX			0xb0
+
+#endif
-- 
2.33.1

