Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920D4F83EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbiDGPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345000AbiDGPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0477C1C82
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:13 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIp-0007bF-Mx; Thu, 07 Apr 2022 17:44:07 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 10/14] dt-bindings: reset: snps,hsdk-reset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:34 +0200
Message-Id: <20220407154338.4190674-10-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Synopsys HSDK reset controller
to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../bindings/reset/snps,hsdk-reset.txt        | 28 -----------
 .../bindings/reset/snps,hsdk-reset.yaml       | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
deleted file mode 100644
index 830069b1c37c..000000000000
--- a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Binding for the Synopsys HSDK reset controller
-
-This binding uses the common reset binding[1].
-
-[1] Documentation/devicetree/bindings/reset/reset.txt
-
-Required properties:
-- compatible: should be "snps,hsdk-reset".
-- reg: should always contain 2 pairs address - length: first for reset
-  configuration register and second for corresponding SW reset and status bits
-  register.
-- #reset-cells: from common reset binding; Should always be set to 1.
-
-Example:
-	reset: reset@880 {
-		compatible = "snps,hsdk-reset";
-		#reset-cells = <1>;
-		reg = <0x8A0 0x4>, <0xFF0 0x4>;
-	};
-
-Specifying reset lines connected to IP modules:
-	ethernet@.... {
-		....
-		resets = <&reset HSDK_V1_ETH_RESET>;
-		....
-	};
-
-The index could be found in <dt-bindings/reset/snps,hsdk-reset.h>
diff --git a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml
new file mode 100644
index 000000000000..a7cb5580c070
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/snps,hsdk-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys HSDK reset controller
+
+maintainers:
+  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+properties:
+  compatible:
+    const: snps,hsdk-reset
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Should always contain 2 pairs address - length: first for reset
+      configuration register and second for corresponding SW reset and status
+      bits register.
+
+  '#reset-cells':
+    const: 1
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
+    #include <dt-bindings/reset/snps,hsdk-reset.h>
+
+    reset: reset@880 {
+        compatible = "snps,hsdk-reset";
+        #reset-cells = <1>;
+        reg = <0x8A0 0x4>, <0xFF0 0x4>;
+    };
+
+    // Specifying reset lines connected to IP modules:
+    ethernet {
+        resets = <&reset HSDK_ETH_RESET>;
+    };
-- 
2.30.2

