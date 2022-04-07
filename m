Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5044F83F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbiDGPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbiDGPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE84C1CBD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:07 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIk-0007bF-LO; Thu, 07 Apr 2022 17:44:02 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: [PATCH 06/14] dt-bindings: reset: nuvoton,npcm-reset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:30 +0200
Message-Id: <20220407154338.4190674-6-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the Nuvoton NPCM reset controller
to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Benjamin Fair <benjaminfair@google.com>
---
 .../bindings/reset/nuvoton,npcm-reset.txt     | 32 ------------
 .../bindings/reset/nuvoton,npcm750-reset.yaml | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
deleted file mode 100644
index 17b7a6a43a29..000000000000
--- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Nuvoton NPCM Reset controller
-
-Required properties:
-- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
-- reg : specifies physical base address and size of the register.
-- #reset-cells: must be set to 2
-
-Optional property:
-- nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
-  NPCM7xx contain four software reset that represent numbers 1 to 4.
-
-  If 'nuvoton,sw-reset-number' is not specified software reset is disabled.
-
-Example:
-	rstc: rstc@f0801000 {
-		compatible = "nuvoton,npcm750-reset";
-		reg = <0xf0801000 0x70>;
-		#reset-cells = <2>;
-		nuvoton,sw-reset-number = <2>;
-	};
-
-Specifying reset lines connected to IP NPCM7XX modules
-======================================================
-example:
-
-        spi0: spi@..... {
-                ...
-                resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
-                ...
-        };
-
-The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
new file mode 100644
index 000000000000..fa5e4ea6400e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Reset controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+properties:
+  compatible:
+    const: nuvoton,npcm750-reset
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 2
+
+  nuvoton,sw-reset-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+    description: |
+      Contains the software reset number to restart the SoC.
+      If not specified, software reset is disabled.
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
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+    rstc: rstc@f0801000 {
+        compatible = "nuvoton,npcm750-reset";
+        reg = <0xf0801000 0x70>;
+        #reset-cells = <2>;
+        nuvoton,sw-reset-number = <2>;
+    };
+
+    // Specifying reset lines connected to IP NPCM7XX modules
+    spi0: spi {
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
+    };
-- 
2.30.2

