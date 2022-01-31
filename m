Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3764A4570
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376655AbiAaLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379405AbiAaLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:30:17 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C2C0617AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:20:07 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by baptiste.telenet-ops.be with bizsmtp
        id pPL3260072lsq0X01PL3R0; Mon, 31 Jan 2022 12:20:03 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEUj4-00CZlM-Sc; Mon, 31 Jan 2022 12:20:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEU2M-00GXJ8-EI; Mon, 31 Jan 2022 11:35:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?q?Mikko=20Salom=C3=A4ki?= <ms@datarespons.se>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpio: aggregator: Fix calling into sleeping GPIO controllers
Date:   Mon, 31 Jan 2022 11:35:53 +0100
Message-Id: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent GPIO controller is a sleeping controller (e.g. a GPIO
controller connected to I2C), getting or setting a GPIO triggers a
might_sleep() warning.  This happens because the GPIO Aggregator takes
the can_sleep flag into account only for its internal locking, not for
calling into the parent GPIO controller.

Fix this by using the gpiod_[gs]et*_cansleep() APIs when calling into a
sleeping GPIO controller.

Reported-by: Mikko Salomäki <ms@datarespons.se>
Fixes: 828546e24280f721 ("gpio: Add GPIO Aggregator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I considered splitting the .[gs]et{_multiple}() callbacks for the
sleeping vs. nonsleeping cases, but the code size increase (measured on
ARM) would be substantial:
  +64 bytes for gpio_fwd_[gs]et_cansleep(),
  +296 bytes for gpio_fwd_[gs]et_multiple_cansleep().
---
 drivers/gpio/gpio-aggregator.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 869dc952cf45218b..0cb2664085cf8314 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -278,7 +278,8 @@ static int gpio_fwd_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
 
-	return gpiod_get_value(fwd->descs[offset]);
+	return chip->can_sleep ? gpiod_get_value_cansleep(fwd->descs[offset])
+			       : gpiod_get_value(fwd->descs[offset]);
 }
 
 static int gpio_fwd_get_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
@@ -293,7 +294,10 @@ static int gpio_fwd_get_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
 	for_each_set_bit(i, mask, fwd->chip.ngpio)
 		descs[j++] = fwd->descs[i];
 
-	error = gpiod_get_array_value(j, descs, NULL, values);
+	if (fwd->chip.can_sleep)
+		error = gpiod_get_array_value_cansleep(j, descs, NULL, values);
+	else
+		error = gpiod_get_array_value(j, descs, NULL, values);
 	if (error)
 		return error;
 
@@ -328,7 +332,10 @@ static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
 
-	gpiod_set_value(fwd->descs[offset], value);
+	if (chip->can_sleep)
+		gpiod_set_value_cansleep(fwd->descs[offset], value);
+	else
+		gpiod_set_value(fwd->descs[offset], value);
 }
 
 static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
@@ -343,7 +350,10 @@ static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
 		descs[j++] = fwd->descs[i];
 	}
 
-	gpiod_set_array_value(j, descs, NULL, values);
+	if (fwd->chip.can_sleep)
+		gpiod_set_array_value_cansleep(j, descs, NULL, values);
+	else
+		gpiod_set_array_value(j, descs, NULL, values);
 }
 
 static void gpio_fwd_set_multiple_locked(struct gpio_chip *chip,
-- 
2.25.1

