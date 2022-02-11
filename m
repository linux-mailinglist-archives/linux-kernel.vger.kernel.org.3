Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1B4B3142
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiBKXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:31:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354119AbiBKXbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:31:48 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7DCF8;
        Fri, 11 Feb 2022 15:31:46 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 2/2] input: ps2-gpio: enforce and document open drain
Date:   Sat, 12 Feb 2022 00:31:37 +0100
Message-Id: <20220211233137.99624-3-danilokrummrich@dk-develop.de>
In-Reply-To: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
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

The PS/2 bus defines the data and clock line be open drain, therefore
document this in the dt-binding and enforce the particular flag in the
driver.

Without enforcing to flag at least the clock gpio as open drain we run
into the following warning:

WARNING: CPU: 1 PID: 40 at drivers/gpio/gpiolib.c:3175 gpiochip_enable_irq+0x54/0x90

gpiochip_enable_irq() warns on a GPIO being configured as output and
using IRQ without being flagged as open drain.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
 drivers/input/serio/ps2-gpio.c                     |  9 +++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
index ec6fa7b40851..5e1951b4f511 100644
--- a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
@@ -16,12 +16,18 @@ properties:
 
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
@@ -46,7 +52,7 @@ examples:
         compatible = "ps2-gpio";
         interrupt-parent = <&gpio>;
         interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        data-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        clk-gpios = <&gpio 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
         write-enable;
     };
diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 460d520ac865..fdaff7a415cd 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -362,14 +362,19 @@ static irqreturn_t ps2_gpio_irq(int irq, void *dev_id)
 static int ps2_gpio_get_props(struct device *dev,
 				 struct ps2_gpio_data *drvdata)
 {
-	drvdata->gpio_data = devm_gpiod_get(dev, "data", GPIOD_IN);
+	enum gpiod_flags gflags;
+
+	/* Enforce open drain, since this is required by the PS/2 bus. */
+	gflags = GPIOD_IN | GPIOD_FLAGS_BIT_OPEN_DRAIN;
+
+	drvdata->gpio_data = devm_gpiod_get(dev, "data", gflags);
 	if (IS_ERR(drvdata->gpio_data)) {
 		dev_err(dev, "failed to request data gpio: %ld",
 			PTR_ERR(drvdata->gpio_data));
 		return PTR_ERR(drvdata->gpio_data);
 	}
 
-	drvdata->gpio_clk = devm_gpiod_get(dev, "clk", GPIOD_IN);
+	drvdata->gpio_clk = devm_gpiod_get(dev, "clk", gflags);
 	if (IS_ERR(drvdata->gpio_clk)) {
 		dev_err(dev, "failed to request clock gpio: %ld",
 			PTR_ERR(drvdata->gpio_clk));
-- 
2.34.1

