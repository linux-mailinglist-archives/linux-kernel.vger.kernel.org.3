Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAF48D586
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiAMKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiAMKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:14:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:14:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x83-0007tL-Gn; Thu, 13 Jan 2022 11:14:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x82-00A3Df-22; Thu, 13 Jan 2022 11:14:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x80-0002tL-SO; Thu, 13 Jan 2022 11:14:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] mfd: twl4030: Make twl4030_exit_irq() return void
Date:   Thu, 13 Jan 2022 11:14:30 +0100
Message-Id: <20220113101430.12869-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; h=from:subject; bh=T8kvoiTKt/KIujb5WDORoPmMzCsB+pcECDI2CzU5KN8=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSTe/10bcutsBUNhUYrciR9LjEM/OP5flGYXq6B9KPefa+X0 FBemTkZjFgZGLgZZMUWWuiItsQkSa/7blSzhhhnEygQyhYGLUwAmIqbN/psl/u/5yYKctZ4PE9e2Fm 6/cNXn7cPQDQnPHy8S+SOuY9Ccv9muQnr1lrnNkk7hT67KHbXaqh7FrBdVddlmUbOIkmHkPqVuvbhu o9wJrSdnbpu9TjLA4DKvurpqHWPYrI3ZxjJrORoWBrKcrm731nmQsFGtI/9gdOU/x6RuVuYTT7J1tq 1gy8w51mX7Q6h958EzH3vtEv8Y72TaqLv6yMt1itGyS8ObYvYYXmpgs+bzeqt1o2Ldn53nMtKZNJJK b7KJcZzL6V3y1GZh0slvuTUuvV8FFco7AxfeaGCXWNnzxW6r+ksdJu/Wu+ntESI3fLIe6rgkbVq8t6 Omsmbn7D9MZXccfn3/syZa+5Q0AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If twl4030_exit_irq() returns an error, the effect is that the caller
(twl_remove()) forwards the error to the i2c core without unregistering
its dummy slave devices. This only makes the i2c core emit another
error message and then it still removes the device.

In this situation it doesn't make sense to abort the remove cleanup and not
unregister the slave devices. So do that. Then return value is actually
unused and twl4030_exit_irq() can better be changed to return no value at
all.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/twl-core.c    | 6 +-----
 drivers/mfd/twl-core.h    | 2 +-
 drivers/mfd/twl4030-irq.c | 7 ++-----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d4194faf1cc3..bd6659cf3bc0 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1036,16 +1036,12 @@ static void clocks_init(struct device *dev,
 static int twl_remove(struct i2c_client *client)
 {
 	unsigned i, num_slaves;
-	int status = 0;
 
 	if (twl_class_is_4030())
-		status = twl4030_exit_irq();
+		twl4030_exit_irq();
 	else
 		twl6030_exit_irq();
 
-	if (status < 0)
-		return status;
-
 	num_slaves = twl_get_num_slaves();
 	for (i = 0; i < num_slaves; i++) {
 		struct twl_client	*twl = &twl_priv->twl_modules[i];
diff --git a/drivers/mfd/twl-core.h b/drivers/mfd/twl-core.h
index 1b916d2e8752..b4bf6a233bd0 100644
--- a/drivers/mfd/twl-core.h
+++ b/drivers/mfd/twl-core.h
@@ -5,7 +5,7 @@
 extern int twl6030_init_irq(struct device *dev, int irq_num);
 extern void twl6030_exit_irq(void);
 extern int twl4030_init_irq(struct device *dev, int irq_num);
-extern int twl4030_exit_irq(void);
+extern void twl4030_exit_irq(void);
 extern int twl4030_init_chip_irq(const char *chip);
 
 #endif /*  __TWL_CORE_H__ */
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index ab417438d1fa..4f576f0160a9 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -753,14 +753,11 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 	return status;
 }
 
-int twl4030_exit_irq(void)
+void twl4030_exit_irq(void)
 {
 	/* FIXME undo twl_init_irq() */
-	if (twl4030_irq_base) {
+	if (twl4030_irq_base)
 		pr_err("twl4030: can't yet clean up IRQs?\n");
-		return -ENOSYS;
-	}
-	return 0;
 }
 
 int twl4030_init_chip_irq(const char *chip)
-- 
2.34.1

