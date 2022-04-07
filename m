Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECE4F83E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiDGPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345058AbiDGPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75396C31C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:17 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIt-0007bF-Ok; Thu, 07 Apr 2022 17:44:11 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>
Subject: [PATCH 13/14] dt-bindings: reset: st,sti-powerdown: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:37 +0200
Message-Id: <20220407154338.4190674-13-p.zabel@pengutronix.de>
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
Peripheral Powerdown reset controller to YAML schema to allow
participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 .../bindings/reset/st,sti-powerdown.txt       | 45 -----------------
 .../bindings/reset/st,stih407-powerdown.yaml  | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
 create mode 100644 Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml

diff --git a/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt b/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
deleted file mode 100644
index 92527138bc93..000000000000
--- a/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-STMicroelectronics STi family Sysconfig Peripheral Powerdown Reset Controller
-=============================================================================
-
-This binding describes a reset controller device that is used to enable and
-disable on-chip peripheral controllers such as USB and SATA, using
-"powerdown" control bits found in the STi family SoC system configuration
-registers. These have been grouped together into a single reset controller
-device for convenience.
-
-The actual action taken when powerdown is asserted is hardware dependent.
-However, when asserted it may not be possible to access the hardware's
-registers and after an assert/deassert sequence the hardware's previous state
-may no longer be valid.
-
-Please refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible: Should be "st,stih407-powerdown"
-- #reset-cells: 1, see below
-
-example:
-
-	powerdown: powerdown-controller {
-		compatible = "st,stih407-powerdown";
-		#reset-cells = <1>;
-	};
-
-
-Specifying powerdown control of devices
-=======================================
-
-Device nodes should specify the reset channel required in their "resets"
-property, containing a phandle to the powerdown device node and an
-index specifying which channel to use, as described in reset.txt
-
-example:
-
-	st_dwc3: dwc3@8f94000 {
-		resets          = <&powerdown STIH407_USB3_POWERDOWN>,
-	};
-
-Macro definitions for the supported reset channels can be found in:
-
-include/dt-bindings/reset/stih407-resets.h
diff --git a/Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml b/Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
new file mode 100644
index 000000000000..d3790e602659
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/st,stih407-powerdown.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi family Sysconfig Peripheral Powerdown Reset Controller
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@st.com>
+
+description: |
+  This binding describes a reset controller device that is used to enable and
+  disable on-chip peripheral controllers such as USB and SATA, using
+  "powerdown" control bits found in the STi family SoC system configuration
+  registers. These have been grouped together into a single reset controller
+  device for convenience.
+
+  The actual action taken when powerdown is asserted is hardware dependent.
+  However, when asserted it may not be possible to access the hardware's
+  registers and after an assert/deassert sequence the hardware's previous state
+  may no longer be valid.
+
+properties:
+  compatible:
+    const: st,stih407-powerdown
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
+    powerdown: powerdown-controller {
+        compatible = "st,stih407-powerdown";
+        #reset-cells = <1>;
+    };
+
+    // Specifying powerdown control of devices:
+    st_dwc3: dwc3 {
+        resets = <&powerdown STIH407_USB3_POWERDOWN>;
+    };
-- 
2.30.2

