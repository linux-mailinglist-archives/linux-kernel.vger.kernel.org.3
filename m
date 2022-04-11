Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B274FB444
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiDKHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbiDKG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:59:54 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B50B3DDC1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:57:12 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1173:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 11 Apr 2022 14:49:04 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v13 2/9] dt-bindings: reset: Add bindings for SP7021 reset driver
Date:   Mon, 11 Apr 2022 14:49:52 +0800
Message-Id: <11b8f60a7f19f25d2fdaa7a2ed770e9383cec3ba.1649659095.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649659095.git.qinjian@cqplus1.com>
References: <cover.1649659095.git.qinjian@cqplus1.com>
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

Add documentation to describe Sunplus SP7021 reset driver bindings.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
Move HW mapping from dt-binding header to driver.
---
 .../bindings/reset/sunplus,reset.yaml         | 38 ++++++++
 MAINTAINERS                                   |  2 +
 include/dt-bindings/reset/sp-sp7021.h         | 87 +++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 create mode 100644 include/dt-bindings/reset/sp-sp7021.h

diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
new file mode 100644
index 000000000..f24646ba9
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
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rstc: reset@9c000054 {
+      compatible = "sunplus,sp7021-reset";
+      reg = <0x9c000054 0x28>;
+      #reset-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b5e2e639..a8be86b25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2744,6 +2744,8 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
 M:	Jisheng Zhang <jszhang@kernel.org>
diff --git a/include/dt-bindings/reset/sp-sp7021.h b/include/dt-bindings/reset/sp-sp7021.h
new file mode 100644
index 000000000..ab4867073
--- /dev/null
+++ b/include/dt-bindings/reset/sp-sp7021.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+
+#define RST_SYSTEM              0
+#define RST_RTC                 1
+#define RST_IOCTL               2
+#define RST_IOP                 3
+#define RST_OTPRX               4
+#define RST_NOC                 5
+#define RST_BR                  6
+#define RST_RBUS_L00            7
+#define RST_SPIFL               8
+#define RST_SDCTRL0             9
+#define RST_PERI0               10
+#define RST_A926                11
+#define RST_UMCTL2              12
+#define RST_PERI1               13
+#define RST_DDR_PHY0            14
+#define RST_ACHIP               15
+#define RST_STC0                16
+#define RST_STC_AV0             17
+#define RST_STC_AV1             18
+#define RST_STC_AV2             19
+#define RST_UA0                 20
+#define RST_UA1                 21
+#define RST_UA2                 22
+#define RST_UA3                 23
+#define RST_UA4                 24
+#define RST_HWUA                25
+#define RST_DDC0                26
+#define RST_UADMA               27
+#define RST_CBDMA0              28
+#define RST_CBDMA1              29
+#define RST_SPI_COMBO_0         30
+#define RST_SPI_COMBO_1         31
+#define RST_SPI_COMBO_2         32
+#define RST_SPI_COMBO_3         33
+#define RST_AUD                 34
+#define RST_USBC0               35
+#define RST_USBC1               36
+#define RST_UPHY0               37
+#define RST_UPHY1               38
+#define RST_I2CM0               39
+#define RST_I2CM1               40
+#define RST_I2CM2               41
+#define RST_I2CM3               42
+#define RST_PMC                 43
+#define RST_CARD_CTL0           44
+#define RST_CARD_CTL1           45
+#define RST_CARD_CTL4           46
+#define RST_BCH                 47
+#define RST_DDFCH               48
+#define RST_CSIIW0              49
+#define RST_CSIIW1              50
+#define RST_MIPICSI0            51
+#define RST_MIPICSI1            52
+#define RST_HDMI_TX             53
+#define RST_VPOST               54
+#define RST_TGEN                55
+#define RST_DMIX                56
+#define RST_TCON                57
+#define RST_INTERRUPT           58
+#define RST_RGST                59
+#define RST_GPIO                60
+#define RST_RBUS_TOP            61
+#define RST_MAILBOX             62
+#define RST_SPIND               63
+#define RST_I2C2CBUS            64
+#define RST_SEC                 65
+#define RST_DVE                 66
+#define RST_GPOST0              67
+#define RST_OSD0                68
+#define RST_DISP_PWM            69
+#define RST_UADBG               70
+#define RST_DUMMY_MASTER        71
+#define RST_FIO_CTL             72
+#define RST_FPGA                73
+#define RST_L2SW                74
+#define RST_ICM                 75
+#define RST_AXI_GLOBAL          76
+
+#endif
-- 
2.33.1

