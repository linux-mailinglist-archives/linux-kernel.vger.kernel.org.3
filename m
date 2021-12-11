Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC047153A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhLKSBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:01:05 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34012 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhLKSAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:00:44 -0500
Received: from [77.244.183.192] (port=64660 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw6fq-0009HU-Q9; Sat, 11 Dec 2021 19:00:42 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/9] dt-bindings: mfd: add Maxim MAX77714 PMIC
Date:   Sat, 11 Dec 2021 18:59:46 +0100
Message-Id: <20211211175951.30763-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the MAX77714 PMIC with GPIO, RTC and watchdog.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes in v5: none

Changes in v4: none

Changes in v3:
 - add 'regulators' node (Krzysztof Kozlowski, Rob Herring)

Changes in v2: none
---
 .../bindings/mfd/maxim,max77714.yaml          | 68 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77714.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
new file mode 100644
index 000000000000..74a6867d3c82
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77714.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77714 PMIC with GPIO, RTC and watchdog from Maxim Integrated.
+
+maintainers:
+  - Luca Ceresoli <luca@lucaceresoli.net>
+
+description: |
+  MAX77714 is a Power Management IC with 4 buck regulators, 9
+  low-dropout regulators, 8 GPIOs, RTC and watchdog.
+
+properties:
+  compatible:
+    const: maxim,max77714
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '^(buck[0-3]|ldo[0-8])$':
+        type: object
+        unevaluatedProperties: false
+        $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@1c {
+            compatible = "maxim,max77714";
+            reg = <0x1c>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8691c531e297..a08f5167dfe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11582,6 +11582,11 @@ F:	drivers/power/supply/max77650-charger.c
 F:	drivers/regulator/max77650-regulator.c
 F:	include/linux/mfd/max77650.h
 
+MAXIM MAX77714 PMIC MFD DRIVER
+M:	Luca Ceresoli <luca@lucaceresoli.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1

