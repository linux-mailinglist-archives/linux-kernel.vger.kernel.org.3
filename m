Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F04E278F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbiCUNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346338AbiCUNe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:34:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBFA3B000;
        Mon, 21 Mar 2022 06:33:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id CDA811F40304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647869611;
        bh=dH0RLBWn3NK47hETImf/AePjeedjJRK8mtT2Iun+qgU=;
        h=From:To:Cc:Subject:Date:From;
        b=dilyddvWWPQzJQjlGjmovA7iZmhen4czAOXJsksp/4iuxf//Xen467DTrrZSstgTV
         xfniQ3xw3Hx50nu6OdidlggvBm4T2Mjqq9DN7IbWFspqhEFpnnP1nS9UYV0mL/V9Fa
         Dbv3GENyHeV578gAILsjuBCPJRN78Z8I2y4diam2fS8QibszVOWKDJi76Re/xozCp1
         wCxDpv4hA6u84FXE5S1YHE7G3Pzpfo2yVf9pjcWXPNzqagQWFtxNz4IavzIcA8VkKm
         kRsLPhaJ3orWHjUbMPWKGSrB2FQLWIwDiWV2/pSWAPBmyGsCY3SRZW/LO8DFLLJMUS
         WC4ESQfvfRBTg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, krisman@collabora.com,
        andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3] gpio: Restrict usage of GPIO chip irq members before initialization
Date:   Mon, 21 Mar 2022 19:02:41 +0530
Message-Id: <20220321133241.121367-1-shreeya.patel@collabora.com>
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

GPIO chip irq members are exposed before they could be completely
initialized and this leads to race conditions.

One such issue was observed for the gc->irq.domain variable which
was accessed through the I2C interface in gpiochip_to_irq() before
it could be initialized by gpiochip_add_irqchip(). This resulted in
Kernel NULL pointer dereference.

Following are the logs for reference :-

kernel: Call Trace:
kernel:  gpiod_to_irq+0x53/0x70
kernel:  acpi_dev_gpio_irq_get_by+0x113/0x1f0
kernel:  i2c_acpi_get_irq+0xc0/0xd0
kernel:  i2c_device_probe+0x28a/0x2a0
kernel:  really_probe+0xf2/0x460
kernel: RIP: 0010:gpiochip_to_irq+0x47/0xc0

To avoid such scenarios, restrict usage of GPIO chip irq members before
they are completely initialized.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v3
  - Move the gc->irq.initialized check inside gpiochip_to_irq().
  - Rename gc to GPIO chip.
  - Add barrier() to avoid compiler reordering.

Changes in v2
  - Make gc_irq_initialized flag a member of gpio_irq_chip structure.
  - Make use of barrier() to avoid reordering of flag initialization
before other gc irq members are initialized.


 drivers/gpio/gpiolib.c      | 19 +++++++++++++++++++
 include/linux/gpio/driver.h |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index defb7c464b87..4ff68f48b87f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1404,6 +1404,16 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct irq_domain *domain = gc->irq.domain;
 
+#ifdef CONFIG_GPIOLIB_IRQCHIP
+	/*
+	 * Avoid race condition with other code, which tries to lookup
+	 * an IRQ before the irqchip has been properly registered,
+	 * i.e. while gpiochip is still being brought up.
+	 */
+	if (!gc->irq.initialized)
+		return -EPROBE_DEFER;
+#endif
+
 	if (!gpiochip_irqchip_irq_valid(gc, offset))
 		return -ENXIO;
 
@@ -1593,6 +1603,15 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 	acpi_gpiochip_request_interrupts(gc);
 
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before initialization of above
+	 * GPIO chip irq members.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
+
 	return 0;
 }
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b0728c8ad90c..f8996b46f430 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -218,6 +218,15 @@ struct gpio_irq_chip {
 	 */
 	bool per_parent_data;
 
+	/**
+	 * @initialized:
+	 *
+	 * Flag to track GPIO chip irq member's initialization.
+	 * This flag will make sure GPIO chip irq members are not used
+	 * before they are initialized.
+	 */
+	bool initialized;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when
-- 
2.30.2

