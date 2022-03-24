Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B233B4E5D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiCXDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245227AbiCXDVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:21:05 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF2971D339
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:19:22 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7839:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Thu, 24 Mar 2022 11:18:06 +0800 (CST)
From:   Xiantao Hu <xt.hu@cqplus1.com>
To:     krzk@kernel.org, wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Xiantao Hu <xt.hu@cqplus1.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: watchdog: Add watchdog yaml file for Sunplus SP7021
Date:   Thu, 24 Mar 2022 11:18:04 +0800
Message-Id: <20220324031805.61316-2-xt.hu@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220324031805.61316-1-xt.hu@cqplus1.com>
References: <20220324031805.61316-1-xt.hu@cqplus1.com>
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

This adds the documentation for the devicetree bindings of the Sunplus
SP7021 watchdog driver, found from SP7021 SoCs and newer.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
---
Changes in v8:
 - Addressed all comments from Krzysztof Kozlowski.
   1.fix the title.
   2.fix the lowercase hex in examples.

 .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
new file mode 100644
index 000000000..d90271013
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
+title: Sunplus SoCs Watchdog
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
+        reg = <0x9c000630 0x08>, <0x9c000274 0x04>;
+        clocks = <&clkc 0x24>;
+        resets = <&rstc 0x14>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a..efdc618a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18544,6 +18544,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 F:	drivers/rtc/rtc-sunplus.c
 
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

