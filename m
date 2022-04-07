Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384874F83DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiDGPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbiDGPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8580AC1C82
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:03 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncUIe-0007bF-Dk; Thu, 07 Apr 2022 17:43:56 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 01/14] dt-bindings: reset: amlogic,meson-axg-audio-arb: Convert to yaml
Date:   Thu,  7 Apr 2022 17:43:25 +0200
Message-Id: <20220407154338.4190674-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

Convert the device tree bindings for the Amlogic audio memory arbiter
controller to YAML schema to allow participating in DT validation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../reset/amlogic,meson-axg-audio-arb.txt     | 22 --------
 .../reset/amlogic,meson-axg-audio-arb.yaml    | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
deleted file mode 100644
index 43e580ef64ba..000000000000
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic audio memory arbiter controller
-
-The Amlogic Audio ARB is a simple device which enables or
-disables the access of Audio FIFOs to DDR on AXG based SoC.
-
-Required properties:
-- compatible: 'amlogic,meson-axg-audio-arb' or
-	      'amlogic,meson-sm1-audio-arb'
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- clocks: phandle to the fifo peripheral clock provided by the audio
-	  clock controller.
-- #reset-cells: must be 1.
-
-Example on the A113 SoC:
-
-arb: reset-controller@280 {
-	compatible = "amlogic,meson-axg-audio-arb";
-	reg = <0x0 0x280 0x0 0x4>;
-	#reset-cells = <1>;
-	clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
-};
diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
new file mode 100644
index 000000000000..704a502adc5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/amlogic,meson-axg-audio-arb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic audio memory arbiter controller
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+description: The Amlogic Audio ARB is a simple device which enables or disables
+  the access of Audio FIFOs to DDR on AXG based SoC.
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-axg-audio-arb
+      - amlogic,meson-sm1-audio-arb
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: |
+      phandle to the fifo peripheral clock provided by the audio clock
+      controller.
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    // on the A113 SoC:
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        arb: reset-controller@280 {
+            compatible = "amlogic,meson-axg-audio-arb";
+            reg = <0x0 0x280 0x0 0x4>;
+            #reset-cells = <1>;
+            clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+        };
+    };
-- 
2.30.2

