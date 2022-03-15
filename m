Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D744D98ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiCOKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiCOKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:40:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899040E65;
        Tue, 15 Mar 2022 03:38:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id C63431F41BCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647340732;
        bh=0Ayx2ck3KklerDtSR4xP/Yhxts6NZBaufUlBtW0oRvU=;
        h=From:To:Cc:Subject:Date:From;
        b=YFtQr2t9RxvdrDk6j5Dk4gPKK0fkc9d1H4DaHAl7U931gjBv+F/sZRPwpfJA6PTnP
         vYb80IkieuQo7s+DsNr4a3A9V44Xf2S2Ksigkthe4geF4A2y8ncxcRuA8xvCz7CzkR
         VKXwwAqD9tnxgE4b5pYrUlGv4adqaNQFwziH9smQ3ZEOxlrytSBEaK6y/kXk4Sww8O
         eT1zps2TlL+lfvc3aelsG2M3464T5EWu/wkqXVueEljxq+us34muafVNVQjkN2wrLu
         erxAAIk8URm3cTW8HVGOzP1tSpvBIlrUYuKrwiklyqlNJRtpnKHLKtF2Z5e/xYHxjt
         IWtCkTb6lCVdg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, krisman@collabora.com,
        andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2] gpio: Restrict usage of gc irq members before initialization
Date:   Tue, 15 Mar 2022 16:08:13 +0530
Message-Id: <20220315103813.84407-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gc irq members are exposed before they could be completely
initialized and this leads to race conditions.

One such issue was observed for the gc->irq.domain variable which
was accessed through the I2C interface in gpiochip_to_irq() before
it could be initialized by gpiochip_add_irqchip(). This resulted in
Kernel NULL pointer dereference.

To avoid such scenarios, restrict usage of gc irq members before
they are completely initialized.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2 :-
  - Make gc_irq_initialized flag a member of gpio_irq_chip structure.
  - Make use of barrier() to avoid reordering of flag initialization before
other gc irq members are initialized.


 drivers/gpio/gpiolib.c      | 11 ++++++++++-
 include/linux/gpio/driver.h |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index defb7c464b87..3973146736a1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1593,6 +1593,15 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 	acpi_gpiochip_request_interrupts(gc);
 
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.gc_irq_initialized before initialization of above
+	 * gc irq members.
+	 */
+	barrier();
+
+	gc->irq.gc_irq_initialized = true;
+
 	return 0;
 }
 
@@ -3138,7 +3147,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 
 	gc = desc->gdev->chip;
 	offset = gpio_chip_hwgpio(desc);
-	if (gc->to_irq) {
+	if (gc->to_irq && gc->irq.gc_irq_initialized) {
 		int retirq = gc->to_irq(gc, offset);
 
 		/* Zero means NO_IRQ */
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b0728c8ad90c..e93de63feece 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -203,6 +203,15 @@ struct gpio_irq_chip {
 	 */
 	unsigned int *map;
 
+	/**
+	 * @gc_irq_initialized:
+	 *
+	 * Flag to track gc irq member's initialization.
+	 * This flag will make sure gc irq members are not used before
+	 * they are initialized.
+	 */
+	bool gc_irq_initialized;
+
 	/**
 	 * @threaded:
 	 *
-- 
2.30.2

