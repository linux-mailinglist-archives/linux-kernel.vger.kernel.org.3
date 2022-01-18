Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1249234B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiARJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:54:44 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:46610 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234178AbiARJyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:54:39 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24948:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Tue, 18 Jan 2022 17:53:41 +0800 (CST)
From:   Xiantao Hu <xt.hu@cqplus1.com>
To:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Xiantao Hu <xt.hu@cqplus1.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] watchdog: Add Sunplus SP7021 WDT devicetree bindings documentation
Date:   Tue, 18 Jan 2022 17:53:41 +0800
Message-Id: <20220118095342.186612-2-xt.hu@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118095342.186612-1-xt.hu@cqplus1.com>
References: <20220118095342.186612-1-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Sunplus
SP7021 watchdog driver, found from SP7021 SoCs and newer.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
---
 .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
new file mode 100644
index 000000000..9a9bfe150
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/sunplus,sp7021-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SoCs Watchdog Device Tree Bindings
+
+maintainers:
+  - XianTao Hu <xt.hu@cqplus1.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-wdt
+
+  reg:
+    items:
+      - description: watchdog registers regions
+      - description: miscellaneous control registers regions
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog: watchdog@9c000630 {
+        compatible = "sunplus,sp7021-wdt";
+        reg = <0x9c000630 0x08>, <0x9C000274 0x04>;
+        clocks = <&clkc 0x24>;
+        resets = <&rstc 0x14>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce716..fe6cc971c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS WATCHDOG DRIVER
+M:	Xiantao Hu <xt.hu@cqplus1.com>
+L:	linux-watchdog@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.33.1

