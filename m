Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF41E48D587
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiAMKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiAMKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:14:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EBAC061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:14:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x83-0007tJ-Gn; Thu, 13 Jan 2022 11:14:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x81-00A3De-MJ; Thu, 13 Jan 2022 11:14:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7x80-0002tI-Ln; Thu, 13 Jan 2022 11:14:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] mfd: twl6030: Make twl6030_exit_irq() return void
Date:   Thu, 13 Jan 2022 11:14:29 +0100
Message-Id: <20220113101430.12869-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; h=from:subject; bh=+ytPBVLN7uoIS1ccRkg+DFvnVgQFEczTlexHIu9U4YQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh3/t60NAFVc1Nls34yJvBhQ4oSEY82UD9YD8YFJw5 4plAni+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYd/7egAKCRDB/BR4rcrsCRavB/ 0cqdbZHCp/NNG3qOmFTUs+NupMyK5ZoPganqNtu0BRJIq4la7mKrY9dm6t8wUXuCiejSqmU3HwF7IO fwdCdkXMckBwJTe/C7k0rAbcB1B6GAn3OrB6+fVjpFbT3+PwgSs35pT0gdjPt1M/qMqRlidK9KNTXB THRqCQZRGQPIM0qkg8wRw/86yyupAWztMEJCKWn97SbpHLdcwIXAQpSm+K8Xn9aDDAgDP6xwJC/V4Y 6yMIwYbQe4DJ77NPypEEk1NskJFLC1DcHKCGiOqAJHDBt3k3ojT4nT1MX16nIRZJx4FL04d6fpmfr/ elHi6gDqvbliP7mwjDAVbMz82kVJa5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns 0 unconditionally, so there is no benefit in
returning a value at all and make the caller do error checking.

Also the caller (twl_remove()) cannot do anything sensible with an error
code. Passing it up the call stack isn't a good option because the i2c core
ignores error codes (apart from emitting an error message).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/twl-core.c    | 4 ++--
 drivers/mfd/twl-core.h    | 2 +-
 drivers/mfd/twl6030-irq.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 289b556dede2..d4194faf1cc3 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1036,12 +1036,12 @@ static void clocks_init(struct device *dev,
 static int twl_remove(struct i2c_client *client)
 {
 	unsigned i, num_slaves;
-	int status;
+	int status = 0;
 
 	if (twl_class_is_4030())
 		status = twl4030_exit_irq();
 	else
-		status = twl6030_exit_irq();
+		twl6030_exit_irq();
 
 	if (status < 0)
 		return status;
diff --git a/drivers/mfd/twl-core.h b/drivers/mfd/twl-core.h
index 6f96c2009a9f..1b916d2e8752 100644
--- a/drivers/mfd/twl-core.h
+++ b/drivers/mfd/twl-core.h
@@ -3,7 +3,7 @@
 #define __TWL_CORE_H__
 
 extern int twl6030_init_irq(struct device *dev, int irq_num);
-extern int twl6030_exit_irq(void);
+extern void twl6030_exit_irq(void);
 extern int twl4030_init_irq(struct device *dev, int irq_num);
 extern int twl4030_exit_irq(void);
 extern int twl4030_init_chip_irq(const char *chip);
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 97af6c2a6007..3c03681c124c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -438,7 +438,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	return status;
 }
 
-int twl6030_exit_irq(void)
+void twl6030_exit_irq(void)
 {
 	if (twl6030_irq && twl6030_irq->twl_irq) {
 		unregister_pm_notifier(&twl6030_irq->pm_nb);
@@ -453,6 +453,5 @@ int twl6030_exit_irq(void)
 		 * in this module.
 		 */
 	}
-	return 0;
 }
 
-- 
2.34.1

