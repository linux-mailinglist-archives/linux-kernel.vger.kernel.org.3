Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D74B75A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiBOSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:08:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbiBOSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:08:50 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C831DD97B;
        Tue, 15 Feb 2022 10:08:38 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v3 3/3] input: ps2-gpio: enforce GPIOs flag open drain
Date:   Tue, 15 Feb 2022 19:08:29 +0100
Message-Id: <20220215180829.63543-4-danilokrummrich@dk-develop.de>
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

The PS/2 bus defines the data and clock line be open drain, therefore
for both enforce the particular GPIO flags in the driver.

Without enforcing to flag at least the clock gpio as open drain we run
into the following warning:

WARNING: CPU: 1 PID: 40 at drivers/gpio/gpiolib.c:3175 gpiochip_enable_irq+0x54/0x90

gpiochip_enable_irq() warns on a GPIO being configured as output while
serving as IRQ source without being flagged as open drain.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/input/serio/ps2-gpio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 8970b49ea09a..f562f396ba05 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -322,14 +322,19 @@ static irqreturn_t ps2_gpio_irq(int irq, void *dev_id)
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
2.35.1

