Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB116582766
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiG0NM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:12:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FAA22BFC;
        Wed, 27 Jul 2022 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658927544; x=1690463544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2K+VWj/VVwFKNZXxoXRjQ6QamXRt3ccAfYaRmtxAmTs=;
  b=Ey9nrgDk+6vI9EKZlYaDiruI3QNnTlIeiY2dh5p7YQU68BIbnmG8jAYv
   G5sRF6l5zDJaS9vTvQIHA7vJcVJaztsMxJVJr8CqyKI5n1pnjsrQTqqvn
   iNxkdCd6h2bETwac4CQuJ+0Ei8yVEgb4cFMVlBq3+gHmsMoFD1SxAm778
   eP59eevUcSNvFob+P0tQ6Cr4d9o5aWebRCSLPxy/3x1V0JsznNFURPh2b
   Is/ynfXQv8UnpLVyNkzep9HlOMHBCnSai0x/Uk34m6XYR9WNymPAOYqZn
   qJzrt3zybFXtHURO30pwvSelRls++6f15+EYCih7RdUDFnlQgV9tvG1Ym
   A==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="106361582"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 06:12:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 06:12:23 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 27 Jul 2022 06:12:21 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jyri Sarha <jsarha@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: clock: gpio-gate-clock: Convert to json-schema
Date:   Wed, 27 Jul 2022 14:10:16 +0100
Message-ID: <20220727131015.2073100-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the simple GPIO clock gate Device Tree binding to json-schema
and fix-up references to this file in other text format bindings.
Jyri Sarha is the file's only editor/author so they have been added as
maintainer of the new yaml binding.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
The original file does not specifiy dual licensing, but when Geert did
the gpio-mux-clock conversion the yaml binding was created with dual,
so I have done the same thing here.
---
 .../bindings/clock/gpio-gate-clock.txt        | 21 ----------
 .../bindings/clock/gpio-gate-clock.yaml       | 42 +++++++++++++++++++
 .../devicetree/bindings/clock/ti/gate.txt     |  2 +-
 .../bindings/clock/ti/interface.txt           |  2 +-
 4 files changed, 44 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/gpio-gate-clock.txt b/Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
deleted file mode 100644
index d3379ff9b84b..000000000000
--- a/Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Binding for simple gpio gated clock.
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "gpio-gate-clock".
-- #clock-cells : from common clock binding; shall be set to 0.
-- enable-gpios : GPIO reference for enabling and disabling the clock.
-
-Optional properties:
-- clocks: Maximum of one parent clock is supported.
-
-Example:
-	clock {
-		compatible = "gpio-gate-clock";
-		clocks = <&parentclk>;
-		#clock-cells = <0>;
-		enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml b/Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml
new file mode 100644
index 000000000000..d09d0e3f0c6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/gpio-gate-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple GPIO clock gate
+
+maintainers:
+  - Jyri Sarha <jsarha@ti.com>
+
+properties:
+  compatible:
+    const: gpio-gate-clock
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  enable-gpios:
+    description: GPIO reference for enabling and disabling the clock.
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    clock {
+        compatible = "gpio-gate-clock";
+        clocks = <&parentclk>;
+        #clock-cells = <0>;
+        enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
index b4820b1de4f0..4982615c01b9 100644
--- a/Documentation/devicetree/bindings/clock/ti/gate.txt
+++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
@@ -10,7 +10,7 @@ will be controlled instead and the corresponding hw-ops for
 that is used.
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
+[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml
 [3] Documentation/devicetree/bindings/clock/ti/clockdomain.txt
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
index 94ec77dc3c59..d3eb5ca92a7f 100644
--- a/Documentation/devicetree/bindings/clock/ti/interface.txt
+++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
@@ -9,7 +9,7 @@ companion clock finding (match corresponding functional gate
 clock) and hardware autoidle enable / disable.
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.txt
+[2] Documentation/devicetree/bindings/clock/gpio-gate-clock.yaml
 
 Required properties:
 - compatible : shall be one of:
-- 
2.36.1

