Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1674B7526
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiBOQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:51:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiBOQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:51:32 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED5106CB3;
        Tue, 15 Feb 2022 08:51:21 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 2/2] dt-bindings: ps2-gpio: document bus signals open drain
Date:   Tue, 15 Feb 2022 17:51:13 +0100
Message-Id: <20220215165113.52659-3-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
References: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PS/2 bus defines data and clock line to be open drain, this should
be reflected in the gpio flags set in the binding.

Especially, this is important since the clock line sometimes is driven
by the host while being used as interrupt source.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
index 41e43d797651..42dbfe5523fd 100644
--- a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
@@ -15,12 +15,18 @@ properties:
 
   data-gpios:
     description:
-      the gpio used for the data signal
+      the gpio used for the data signal - this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is open drain by
+      definition
     maxItems: 1
 
   clk-gpios:
     description:
-      the gpio used for the clock signal
+      the gpio used for the clock signal - this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is open drain by
+      definition
     maxItems: 1
 
   interrupts:
@@ -52,7 +58,7 @@ examples:
         compatible = "ps2-gpio";
         interrupt-parent = <&gpio>;
         interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        data-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        clk-gpios = <&gpio 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
         write-enable;
     };
-- 
2.35.1

