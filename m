Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7354F83F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiDGPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbiDGPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A34C1C8C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:14 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIs-0007bF-17; Thu, 07 Apr 2022 17:44:10 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 12/14] dt-bindings: reset: st,sti-picophyreset: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:36 +0200
Message-Id: <20220407154338.4190674-12-p.zabel@pengutronix.de>
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

Convert the device tree bindings for the STMicroelectronics STi
SoftReset controller to YAML schema to allow participating in DT
validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/reset/st,sti-picophyreset.txt    | 42 -----------------
 .../reset/st,stih407-picophyreset.yaml        | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/st,stih407-picophyreset.yaml

diff --git a/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt b/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
deleted file mode 100644
index 9ca27761f811..000000000000
--- a/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-STMicroelectronics STi family Sysconfig Picophy SoftReset Controller
-=============================================================================
-
-This binding describes a reset controller device that is used to enable and
-disable on-chip PicoPHY USB2 phy(s) using "softreset" control bits found in
-the STi family SoC system configuration registers.
-
-The actual action taken when softreset is asserted is hardware dependent.
-However, when asserted it may not be possible to access the hardware's
-registers and after an assert/deassert sequence the hardware's previous state
-may no longer be valid.
-
-Please refer to Documentation/devicetree/bindings/reset/reset.txt
-for common reset controller binding usage.
-
-Required properties:
-- compatible: Should be "st,stih407-picophyreset"
-- #reset-cells: 1, see below
-
-Example:
-
-	picophyreset: picophyreset-controller {
-		compatible = "st,stih407-picophyreset";
-		#reset-cells = <1>;
-	};
-
-Specifying picophyreset control of devices
-=======================================
-
-Device nodes should specify the reset channel required in their "resets"
-property, containing a phandle to the picophyreset device node and an
-index specifying which channel to use, as described in
-Documentation/devicetree/bindings/reset/reset.txt.
-
-Example:
-
-	usb2_picophy0: usbpicophy@0 {
-		resets = <&picophyreset STIH407_PICOPHY0_RESET>;
-	};
-
-Macro definitions for the supported reset channels can be found in:
-include/dt-bindings/reset/stih407-resets.h
diff --git a/Documentation/devicetree/bindings/reset/st,stih407-picophyreset.yaml b/Documentation/devicetree/bindings/reset/st,stih407-picophyreset.yaml
new file mode 100644
index 000000000000..329ae4ae1a10
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stih407-picophyreset.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/st,stih407-picophyreset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi family Sysconfig Picophy SoftReset Controller
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+description: |
+  This binding describes a reset controller device that is used to enable and
+  disable on-chip PicoPHY USB2 phy(s) using "softreset" control bits found in
+  the STi family SoC system configuration registers.
+
+  The actual action taken when softreset is asserted is hardware dependent.
+  However, when asserted it may not be possible to access the hardware's
+  registers and after an assert/deassert sequence the hardware's previous state
+  may no longer be valid.
+
+properties:
+  compatible:
+    const: st,stih407-picophyreset
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/stih407-resets.h>
+
+    picophyreset: picophyreset-controller {
+        compatible = "st,stih407-picophyreset";
+        #reset-cells = <1>;
+    };
+
+    // Specifying picophyreset control of devices
+    usb2_picophy0: usbpicophy {
+        resets = <&picophyreset STIH407_PICOPHY0_RESET>;
+    };
-- 
2.30.2

