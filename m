Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431FE4F83F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiDGPrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbiDGPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3027C12D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:10 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIo-0007bF-JP; Thu, 07 Apr 2022 17:44:06 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH 09/14] dt-bindings: reset: snps,dw-reset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:33 +0200
Message-Id: <20220407154338.4190674-9-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Synopsys DesignWare reset
controller to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>
---
 .../bindings/reset/snps,dw-reset.txt          | 30 -------------
 .../bindings/reset/snps,dw-reset.yaml         | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
deleted file mode 100644
index 0c241d4aae76..000000000000
--- a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Synopsys DesignWare Reset controller
-=======================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-
-- compatible: should be one of the following.
-	"snps,dw-high-reset" - for active high configuration
-	"snps,dw-low-reset" - for active low configuration
-
-- reg: physical base address of the controller and length of memory mapped
-	region.
-
-- #reset-cells: must be 1.
-
-example:
-
-	dw_rst_1: reset-controller@0000 {
-		compatible = "snps,dw-high-reset";
-		reg = <0x0000 0x4>;
-		#reset-cells = <1>;
-	};
-
-	dw_rst_2: reset-controller@1000 {
-		compatible = "snps,dw-low-reset";
-		reg = <0x1000 0x8>;
-		#reset-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
new file mode 100644
index 000000000000..f9b36ddc0ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/snps,dw-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Reset controller
+
+maintainers:
+  - Luis Oliveira <Luis.Oliveira@synopsys.com>
+
+properties:
+  compatible:
+    enum:
+      - snps,dw-high-reset # for active high configuration
+      - snps,dw-low-reset  # for active low configuration
+
+  reg:
+    maxItems: 1
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
+    dw_rst_1: reset-controller@0000 {
+        compatible = "snps,dw-high-reset";
+        reg = <0x0000 0x4>;
+        #reset-cells = <1>;
+    };
+
+    dw_rst_2: reset-controller@1000 {
+        compatible = "snps,dw-low-reset";
+        reg = <0x1000 0x8>;
+        #reset-cells = <1>;
+    };
+
-- 
2.30.2

