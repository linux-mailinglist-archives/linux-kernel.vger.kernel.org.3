Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB514F83E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiDGPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345035AbiDGPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840BC1C98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:06 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIj-0007bF-9K; Thu, 07 Apr 2022 17:44:01 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 05/14] dt-bindings: reset: lantiq,reset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:29 +0200
Message-Id: <20220407154338.4190674-5-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Lantiq XWAY SoC RCU reset
controller to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/reset/lantiq,reset.txt           | 30 ------------
 .../bindings/reset/lantiq,reset.yaml          | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.txt b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
deleted file mode 100644
index c6aef36b7d15..000000000000
--- a/Documentation/devicetree/bindings/reset/lantiq,reset.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Lantiq XWAY SoC RCU reset controller binding
-============================================
-
-This binding describes a reset-controller found on the RCU module on Lantiq
-XWAY SoCs.
-
-This node has to be a sub node of the Lantiq RCU block.
-
--------------------------------------------------------------------------------
-Required properties:
-- compatible		: Should be one of
-				"lantiq,danube-reset"
-				"lantiq,xrx200-reset"
-- reg			: Defines the following sets of registers in the parent
-			  syscon device
-			- Offset of the reset set register
-			- Offset of the reset status register
-- #reset-cells		: Specifies the number of cells needed to encode the
-			  reset line, should be 2.
-			  The first cell takes the reset set bit and the
-			  second cell takes the status bit.
-
--------------------------------------------------------------------------------
-Example for the reset-controllers on the xRX200 SoCs:
-	reset0: reset-controller@10 {
-		compatible = "lantiq,xrx200-reset";
-		reg <0x10 0x04>, <0x14 0x04>;
-
-		#reset-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.yaml b/Documentation/devicetree/bindings/reset/lantiq,reset.yaml
new file mode 100644
index 000000000000..15d65a5dd631
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lantiq,reset.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/lantiq,reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq XWAY SoC RCU reset controller
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |
+  This binding describes a reset-controller found on the RCU module on Lantiq
+  XWAY SoCs. This node has to be a sub node of the Lantiq RCU block.
+
+properties:
+  compatible:
+    enum:
+      - lantiq,danube-reset
+      - lantiq,xrx200-reset
+
+  reg:
+    description: |
+      Defines the following sets of registers in the parent syscon device
+      Offset of the reset set register
+      Offset of the reset status register
+    maxItems: 2
+
+  '#reset-cells':
+    description: |
+      The first cell takes the reset set bit and the second cell takes the
+      status bit.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    // On the xRX200 SoCs:
+    reset0: reset-controller@10 {
+        compatible = "lantiq,xrx200-reset";
+        reg = <0x10 0x04>, <0x14 0x04>;
+        #reset-cells = <2>;
+    };
-- 
2.30.2

