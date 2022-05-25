Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625D533EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiEYOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiEYOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:20:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7FCA30A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:20:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ntrsV-0007o9-N1; Wed, 25 May 2022 16:20:47 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1ntrsW-004U3i-9t; Wed, 25 May 2022 16:20:46 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1ntrsU-00FAwM-5x; Wed, 25 May 2022 16:20:46 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 1/2] dt-bindings: reset: Add TPS380x documentation
Date:   Wed, 25 May 2022 16:20:19 +0200
Message-Id: <20220525142019.3615253-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for the tps380x reset driver. The
binding uses enum to make it easy to add more devices from that family.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../bindings/reset/ti,tps380x-reset.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml b/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml
new file mode 100644
index 000000000000..afc835eda0ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/ti,tps380x-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS380x reset controller node bindings
+
+maintainers:
+  - Marco Felsch <kernel@pengutronix.de>
+
+description: |
+  The TPS380x family [1] of supervisory circuits monitor supply voltages to
+  provide circuit initialization and timing supervision. The devices assert a
+  RESET signal if the voltage drops below a preset threshold or upon a manual
+  reset input (MR). The RESET output remains asserted for the factory
+  programmed delay after the voltage return above its threshold or after the
+  manual reset input is released.
+
+  [1] https://www.ti.com/product/TPS3801
+
+properties:
+  compatible:
+    enum:
+      - ti,tps3801
+
+  reset-gpios:
+    maxItems: 1
+    description: Reference to the GPIO connected to the MR pin.
+
+  "#reset-cells":
+    const: 0
+
+required:
+  - compatible
+  - reset-gpios
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    reset: reset-controller {
+        compatible = "ti,tps3801";
+        #reset-cells = <0>;
+        reset-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+    };
+...
-- 
2.30.2

