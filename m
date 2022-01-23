Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48F14973D6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiAWRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiAWRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:52:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E614C061749
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:52:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh29-0007aI-Vf; Sun, 23 Jan 2022 18:52:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh29-00BycQ-Bm; Sun, 23 Jan 2022 18:52:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh27-000tzg-AA; Sun, 23 Jan 2022 18:52:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 4/5] platform/chrome: cros_ec: Make cros_ec_unregister() return void
Date:   Sun, 23 Jan 2022 18:52:00 +0100
Message-Id: <20220123175201.34839-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; h=from:subject; bh=NT5DujkUJtGdlIvvxcgZ/h7VwhKvX6h6JwjU5AB17eY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh7ZW2eJ8WV60Yt4XzJYCYc8Pxt1mweCyNSza6TYSM h19cRPCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYe2VtgAKCRDB/BR4rcrsCUWTCA CIsACbhgvBD4H0nw8oBv8rUmwIu0JUt0cPf2K/3zcKhGRwn2mgq75vd2yf/iXiHvUfu0twByZhZBX8 nfEcJx2/V92JIfb/ONBSSRvlgWR/9BpA0haQR0Sz16Y9YvBxnkcExxaq0DX59LwbcE2G0AhaNe8/pW B+BLUvjQa8r8//KfHowlKKPBbPyGFLgpbWbuJGzsVNtg9jNQ+F6v+2b6uWWVT/qwTk7qqNox3MLbN5 3zjQmhnggDJqiXeObLfxFDi7uW7fEB8B99iJcYgLSTtRCOcqIOtcHSyWOkw+adT0LWyqSSy0nHiVt1 kDDkW4x09BdsKvHRBrH/78qCQxghhV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up to now cros_ec_unregister() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of i2c, platform and spi remove callbacks is
ignored anyway.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20211020071753.wltjslmimb6wtlp5@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/chrome/cros_ec.c     | 4 +---
 drivers/platform/chrome/cros_ec.h     | 2 +-
 drivers/platform/chrome/cros_ec_i2c.c | 4 +++-
 drivers/platform/chrome/cros_ec_lpc.c | 4 +++-
 drivers/platform/chrome/cros_ec_spi.c | 4 +++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fc5aa1525d13..d49a4efe46c8 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -302,13 +302,11 @@ EXPORT_SYMBOL(cros_ec_register);
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_unregister(struct cros_ec_device *ec_dev)
+void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
-
-	return 0;
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index 78363dcfdf23..bbca0096868a 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 
 int cros_ec_register(struct cros_ec_device *ec_dev);
-int cros_ec_unregister(struct cros_ec_device *ec_dev);
+void cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 30c8938c27d5..22feb0fd4ce7 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -313,7 +313,9 @@ static int cros_ec_i2c_remove(struct i2c_client *client)
 {
 	struct cros_ec_device *ec_dev = i2c_get_clientdata(client);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f..7651417b4a25 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -439,7 +439,9 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d..713c58687721 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -790,7 +790,9 @@ static int cros_ec_spi_remove(struct spi_device *spi)
 {
 	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

