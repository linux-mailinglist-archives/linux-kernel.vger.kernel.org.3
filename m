Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA64F83E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiDGPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiDGPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E14C1C88
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:13 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIq-0007bF-TA; Thu, 07 Apr 2022 17:44:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>
Subject: [PATCH 11/14] dt-bindings: reset: socfpga: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:35 +0200
Message-Id: <20220407154338.4190674-11-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Altera SOCFPGA reset manager to
YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@altera.com>
---
 .../bindings/reset/altr,rst-mgr.yaml          | 47 +++++++++++++++++++
 .../bindings/reset/socfpga-reset.txt          | 16 -------
 2 files changed, 47 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/socfpga-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml b/Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml
new file mode 100644
index 000000000000..4379cec6b35a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/altr,rst-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Reset Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@altera.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: Cyclone5/Arria5/Arria10
+        const: altr,rst-mgr
+      - description: Stratix10 ARM64 SoC
+        items:
+          - const: altr,stratix10-rst-mgr
+          - const: altr,rst-mgr
+
+  reg:
+    maxItems: 1
+
+  altr,modrst-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset of the first modrst register
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - altr,modrst-offset
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    rstmgr@ffd05000 {
+        compatible = "altr,rst-mgr";
+        reg = <0xffd05000 0x1000>;
+        altr,modrst-offset = <0x10>;
+        #reset-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/reset/socfpga-reset.txt b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
deleted file mode 100644
index 38fe34fd8b8a..000000000000
--- a/Documentation/devicetree/bindings/reset/socfpga-reset.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Altera SOCFPGA Reset Manager
-
-Required properties:
-- compatible : "altr,rst-mgr" for (Cyclone5/Arria5/Arria10)
-	       "altr,stratix10-rst-mgr","altr,rst-mgr" for Stratix10 ARM64 SoC
-- reg : Should contain 1 register ranges(address and length)
-- altr,modrst-offset : Should contain the offset of the first modrst register.
-- #reset-cells: 1
-
-Example:
-	 rstmgr@ffd05000 {
-		#reset-cells = <1>;
-		compatible = "altr,rst-mgr";
-		reg = <0xffd05000 0x1000>;
-		altr,modrst-offset = <0x10>;
-	};
-- 
2.30.2

