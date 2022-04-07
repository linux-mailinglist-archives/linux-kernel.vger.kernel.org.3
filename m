Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039A4F83DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbiDGPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbiDGPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31963C1C88
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:04 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIf-0007bF-VV; Thu, 07 Apr 2022 17:43:58 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 02/14] dt-bindings: reset: ath79: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:26 +0200
Message-Id: <20220407154338.4190674-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154338.4190674-1-p.zabel@pengutronix.de>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the Qualcomm Atheros AR7xxx/AR9XXX
reset controller to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alban Bedel <albeu@free.fr>
---
 .../devicetree/bindings/reset/ath79-reset.txt | 20 ----------
 .../bindings/reset/qca,ar7100-reset.yaml      | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/ath79-reset.txt b/Documentation/devicetree/bindings/reset/ath79-reset.txt
deleted file mode 100644
index 4c56330bf398..000000000000
--- a/Documentation/devicetree/bindings/reset/ath79-reset.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Binding for Qualcomm Atheros AR7xxx/AR9XXX reset controller
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required Properties:
-- compatible: has to be "qca,<soctype>-reset", "qca,ar7100-reset"
-              as fallback
-- reg: Base address and size of the controllers memory area
-- #reset-cells : Specifies the number of cells needed to encode reset
-                 line, should be 1
-
-Example:
-
-	reset-controller@1806001c {
-		compatible = "qca,ar9132-reset", "qca,ar7100-reset";
-		reg = <0x1806001c 0x4>;
-
-		#reset-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml b/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
new file mode 100644
index 000000000000..9be60e55cd71
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2015 Alban Bedel <albeu@free.fr>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/qca,ar7100-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Atheros AR7xxx/AR9XXX reset controller
+
+maintainers:
+  - Alban Bedel <albeu@free.fr>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qca,ar9132-reset
+          - qca,ar9331-reset
+      - const: qca,ar7100-reset
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
+    reset-controller@1806001c {
+          compatible = "qca,ar9132-reset", "qca,ar7100-reset";
+          reg = <0x1806001c 0x4>;
+          #reset-cells = <1>;
+    };
-- 
2.30.2

