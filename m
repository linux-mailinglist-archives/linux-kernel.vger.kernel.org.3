Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113F3495B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379247AbiAUH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:58:22 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:55874 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344158AbiAUH6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:58:08 -0500
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
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 03/10] dt-bindings: reset: Add bindings for SP7021 reset driver
Date:   Fri, 21 Jan 2022 15:53:11 +0800
Message-Id: <6444261d9d4179839ce8f828a9814a057821082a.1642751015.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642751015.git.qinjian@cqplus1.com>
References: <cover.1642751015.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 reset driver bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 .../bindings/reset/sunplus,reset.yaml         | 38 ++++++++
 MAINTAINERS                                   |  2 +
 include/dt-bindings/reset/sp-sp7021.h         | 97 +++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 create mode 100644 include/dt-bindings/reset/sp-sp7021.h

diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
new file mode 100644
index 000000000..c083c821f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/sunplus,reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC Reset Controller
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-reset
+
+  "#reset-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#reset-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rstc: reset@9c000054 {
+      compatible = "sunplus,sp7021-reset";
+      #reset-cells = <1>;
+      reg = <0x9c000054 0x28>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a5422f10..652f42cab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2661,6 +2661,8 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
diff --git a/include/dt-bindings/reset/sp-sp7021.h b/include/dt-bindings/reset/sp-sp7021.h
new file mode 100644
index 000000000..fd2a50327
--- /dev/null
+++ b/include/dt-bindings/reset/sp-sp7021.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+
+/* mo_reset0 ~ mo_reset9 */
+#define RST_SYSTEM		0x00
+#define RST_RTC			0x02
+#define RST_IOCTL		0x03
+#define RST_IOP			0x04
+#define RST_OTPRX		0x05
+#define RST_NOC			0x06
+#define RST_BR			0x07
+#define RST_RBUS_L00	        0x08
+#define RST_SPIFL		0x09
+#define RST_SDCTRL0		0x0a
+#define RST_PERI0		0x0b
+#define RST_A926		0x0d
+#define RST_UMCTL2		0x0e
+#define RST_PERI1		0x0f
+
+#define RST_DDR_PHY0	        0x10
+#define RST_ACHIP		0x12
+#define RST_STC0		0x14
+#define RST_STC_AV0		0x15
+#define RST_STC_AV1		0x16
+#define RST_STC_AV2		0x17
+#define RST_UA0			0x18
+#define RST_UA1			0x19
+#define RST_UA2			0x1a
+#define RST_UA3			0x1b
+#define RST_UA4			0x1c
+#define RST_HWUA		0x1d
+#define RST_DDC0		0x1e
+#define RST_UADMA		0x1f
+
+#define RST_CBDMA0		0x20
+#define RST_CBDMA1		0x21
+#define RST_SPI_COMBO_0	        0x22
+#define RST_SPI_COMBO_1	        0x23
+#define RST_SPI_COMBO_2	        0x24
+#define RST_SPI_COMBO_3	        0x25
+#define RST_AUD			0x26
+#define RST_USBC0		0x2a
+#define RST_USBC1		0x2b
+#define RST_UPHY0		0x2d
+#define RST_UPHY1		0x2e
+
+#define RST_I2CM0		0x30
+#define RST_I2CM1		0x31
+#define RST_I2CM2		0x32
+#define RST_I2CM3		0x33
+#define RST_PMC			0x3d
+#define RST_CARD_CTL0	        0x3e
+#define RST_CARD_CTL1	        0x3f
+
+#define RST_CARD_CTL4	        0x42
+#define RST_BCH			0x44
+#define RST_DDFCH		0x4b
+#define RST_CSIIW0		0x4c
+#define RST_CSIIW1		0x4d
+#define RST_MIPICSI0	        0x4e
+#define RST_MIPICSI1	        0x4f
+
+#define RST_HDMI_TX		0x50
+#define RST_VPOST		0x55
+
+#define RST_TGEN		0x60
+#define RST_DMIX		0x61
+#define RST_TCON		0x6a
+#define RST_INTERRUPT	        0x6f
+
+#define RST_RGST		0x70
+#define RST_GPIO		0x73
+#define RST_RBUS_TOP	        0x74
+
+#define RST_MAILBOX		0x86
+#define RST_SPIND		0x8a
+#define RST_I2C2CBUS	        0x8b
+#define RST_SEC			0x8d
+#define RST_DVE			0x8e
+#define RST_GPOST0		0x8f
+
+#define RST_OSD0		0x90
+#define RST_DISP_PWM	        0x92
+#define RST_UADBG		0x93
+#define RST_DUMMY_MASTER	0x94
+#define RST_FIO_CTL		0x95
+#define RST_FPGA		0x96
+#define RST_L2SW		0x97
+#define RST_ICM			0x98
+#define RST_AXI_GLOBAL	        0x99
+
+#endif
-- 
2.33.1

