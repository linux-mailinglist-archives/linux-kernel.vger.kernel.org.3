Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37ED4B9247
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiBPU14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:27:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBPU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:27:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7C4DF42;
        Wed, 16 Feb 2022 12:27:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id F065F1F453B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645043260;
        bh=TcGzEzWhEGA7ZhG+nrdWLrKb2z0r4SS8tB5fiOXVUHg=;
        h=From:To:Cc:Subject:Date:From;
        b=Kw/y/Fdm06VoVfhWPkwb0xWxGzPUC4v6MXGP+uVaVoEGUhKWaXWM3YO54oQa6MP81
         DgrrmCZMM5V/hcwyE5u1RmywR27r4GgAgDgbCE3FNlhYyCsO1lgc4YHYFcUze1egBa
         QD47TmmBlkMLRuE2XVnZP4tTfL7lOg8tkU2PCFjf8FGk/Igzo4YOQU7+PQhg9dkl69
         bVsRX6M/aUb1Tw9CkpvtNal5E+fCBRdxOt5DZv9yILX7VjLsl4twz8e8UZOuNzTNia
         hktLVFh0pcc0vOdIDzJy0Vz7R28C9GkLS8loJrQiq6VCOB7rCKETSx5d60wa2aaGn9
         t4QpytcPu5VfA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, bgolaszewski@baylibre.com
Cc:     krisman@collabora.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5] gpio: Return EPROBE_DEFER if gc->to_irq is NULL
Date:   Thu, 17 Feb 2022 01:56:55 +0530
Message-Id: <20220216202655.194795-1-shreeya.patel@collabora.com>
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

We are racing the registering of .to_irq when probing the
i2c driver. This results in random failure of touchscreen
devices.

Following explains the race condition better.

[gpio driver] gpio driver registers gpio chip
[gpio consumer] gpio is acquired
[gpio consumer] gpiod_to_irq() fails with -ENXIO
[gpio driver] gpio driver registers irqchip
gpiod_to_irq works at this point, but -ENXIO is fatal

We could see the following errors in dmesg logs when gc->to_irq is NULL

[2.101857] i2c_hid i2c-FTS3528:00: HID over i2c has not been provided an Int IRQ
[2.101953] i2c_hid: probe of i2c-FTS3528:00 failed with error -22

To avoid this situation, defer probing until to_irq is registered.
Returning -EPROBE_DEFER would be the first step towards avoiding
the failure of devices due to the race in registration of .to_irq.
Final solution to this issue would be to avoid using gc irq members
until they are fully initialized.

This issue has been reported many times in past and people have been
using workarounds like changing the pinctrl_amd to built-in instead
of loading it as a module or by adding a softdep for pinctrl_amd into
the config file.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209413
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

---
Changes in v5
  - Improve explanation in commit message and sending it to the correct
email address.

Changes in v4
  - Remove blank line and make the first letter of the sentence
capital.

Changes in v3
  - Fix the error reported by kernel test robot.

Changes in v2
  - Add a condition to check for irq chip to avoid bogus error.
---
 drivers/gpio/gpiolib.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3859911b61e9..a3d14277f17c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3147,6 +3147,16 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 
 		return retirq;
 	}
+#ifdef CONFIG_GPIOLIB_IRQCHIP
+	if (gc->irq.chip) {
+		/*
+		 * Avoid race condition with other code, which tries to lookup
+		 * an IRQ before the irqchip has been properly registered,
+		 * i.e. while gpiochip is still being brought up.
+		 */
+		return -EPROBE_DEFER;
+	}
+#endif
 	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(gpiod_to_irq);
-- 
2.30.2

