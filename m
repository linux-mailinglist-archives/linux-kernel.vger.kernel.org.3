Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645D4B7839
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbiBOSIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:08:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbiBOSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:08:46 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9628F1199;
        Tue, 15 Feb 2022 10:08:36 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v3 2/3] dt-bindings: ps2-gpio: document bus signals open drain
Date:   Tue, 15 Feb 2022 19:08:28 +0100
Message-Id: <20220215180829.63543-3-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
References: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
index 304132fd30c5..a63d9172346f 100644
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

