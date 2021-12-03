Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4A467915
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381333AbhLCOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381220AbhLCOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:10:17 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D18C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:06:53 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by albert.telenet-ops.be with bizsmtp
        id Rq6p2600X3eLghq06q6pGr; Fri, 03 Dec 2021 15:06:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9D6-002LpO-U9; Fri, 03 Dec 2021 15:06:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9D6-000lfI-H9; Fri, 03 Dec 2021 15:06:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enrico Weigelt metux IT consult <info@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        stratos-dev@op-lists.linaro.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] gpio: aggregator: Add interrupt support
Date:   Fri,  3 Dec 2021 15:06:44 +0100
Message-Id: <ba7f82f348d77b6a65498dd13a92550949e69cc3.1638540167.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the GPIO Aggregator does not support interrupts.  This means
that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
and userspace applications using line events do not work.

Add interrupt support by providing a gpio_chip.to_irq() callback, which
just calls into the parent GPIO controller.

Note that this does not implement full interrupt controller (irq_chip)
support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
still does not work.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I would prefer to avoid implementing irq_chip support, until there is a
real use case for this.

This has been tested with gpio-keys and gpiomon on the Koelsch
development board:

  - gpio-keys, using a DT overlay[1]:

	$ overlay add r8a7791-koelsch-keyboard-controlled-led
	$ echo gpio-aggregator > /sys/devices/platform/frobnicator/driver_override
	$ echo frobnicator > /sys/bus/platform/drivers/gpio-aggregator/bind

	$ gpioinfo frobnicator
	gpiochip12 - 3 lines:
		line   0:      "light"      "light"  output  active-high [used]
		line   1:         "on"         "On"   input   active-low [used]
		line   2:        "off"        "Off"   input   active-low [used]

	$ echo 255 > /sys/class/leds/light/brightness
	$ echo 0 > /sys/class/leds/light/brightness

	$ evtest /dev/input/event0

  - gpiomon, using the GPIO sysfs API:

	$ echo keyboard > /sys/bus/platform/drivers/gpio-keys/unbind
	$ echo e6055800.gpio 2,6 > /sys/bus/platform/drivers/gpio-aggregator/new_device
	$ gpiomon gpiochip12 0 1

[1] "ARM: dts: koelsch: Add overlay for keyboard-controlled LED"
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=c78d817869e63a3485bb4ab98aeea6ce368a396e
---
 drivers/gpio/gpio-aggregator.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index e9671d1660ef4b40..869dc952cf45218b 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -371,6 +371,13 @@ static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
 	return gpiod_set_config(fwd->descs[offset], config);
 }
 
+static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_to_irq(fwd->descs[offset]);
+}
+
 /**
  * gpiochip_fwd_create() - Create a new GPIO forwarder
  * @dev: Parent device pointer
@@ -411,7 +418,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	for (i = 0; i < ngpios; i++) {
 		struct gpio_chip *parent = gpiod_to_chip(descs[i]);
 
-		dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
+		dev_dbg(dev, "%u => gpio %d irq %d\n", i,
+			desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
 
 		if (gpiod_cansleep(descs[i]))
 			chip->can_sleep = true;
@@ -429,6 +437,7 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	chip->get_multiple = gpio_fwd_get_multiple_locked;
 	chip->set = gpio_fwd_set;
 	chip->set_multiple = gpio_fwd_set_multiple_locked;
+	chip->to_irq = gpio_fwd_to_irq;
 	chip->base = -1;
 	chip->ngpio = ngpios;
 	fwd->descs = descs;
-- 
2.25.1

