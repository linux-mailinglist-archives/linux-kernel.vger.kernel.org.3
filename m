Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3344F83ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiDGPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiDGPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6BC1C8E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:05 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIi-0007bF-9K; Thu, 07 Apr 2022 17:44:00 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 04/14] dt-bindings: reset: bitmain,bm1880-reset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:28 +0200
Message-Id: <20220407154338.4190674-4-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Bitmain BM1880 reset controller
to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
---
 .../bindings/reset/bitmain,bm1880-reset.txt   | 18 ----------
 .../bindings/reset/bitmain,bm1880-reset.yaml  | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
deleted file mode 100644
index a6f8455ae6c4..000000000000
--- a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Bitmain BM1880 SoC Reset Controller
-===================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible:   Should be "bitmain,bm1880-reset"
-- reg:          Offset and length of reset controller space in SCTRL.
-- #reset-cells: Must be 1.
-
-Example:
-
-        rst: reset-controller@c00 {
-                compatible = "bitmain,bm1880-reset";
-                reg = <0xc00 0x8>;
-                #reset-cells = <1>;
-        };
diff --git a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
new file mode 100644
index 000000000000..f0aca744388c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Manivannan Sadhasivam <mani@kernel.org>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/bitmain,bm1880-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bitmain BM1880 SoC Reset Controller
+
+maintainers:
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    const: bitmain,bm1880-reset
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
+    rst: reset-controller@c00 {
+        compatible = "bitmain,bm1880-reset";
+        reg = <0xc00 0x8>;
+        #reset-cells = <1>;
+    };
-- 
2.30.2

