Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFB5804A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiGYTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiGYToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:44:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575E205D5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:44:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG401-0004xW-Dt; Mon, 25 Jul 2022 21:44:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG3zz-003Ayb-RY; Mon, 25 Jul 2022 21:44:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG3zz-007Tts-5o; Mon, 25 Jul 2022 21:44:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] hwmon: sht15: Fix wrong assumptions in device remove callback
Date:   Mon, 25 Jul 2022 21:43:44 +0200
Message-Id: <20220725194344.150098-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541; h=from:subject; bh=03In0uPqCNWfcwxxoZFMnMxqu/a77O3w3D+UFn5GWVY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi3vJnd05J5PSmrIgIMEHncs2fOep+tDiVPPxmUcDo duzXRNmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYt7yZwAKCRDB/BR4rcrsCYAXB/ 9YcVEOSqTOjKAG8JIc/nT01muBVxJ/knc1znnCtd8vxrzmMl/8IFx42A2ISV/lPPb8qi7rc9u1ibMh EgP5b0iGTiM+JSiM0QwnMNtuCOIHr9X+JRkz8DINWRkNUkpfDeXYADWTzIjop2thu9xaVyin9I5SQ4 qGOud3dA+r/rCEw5NgZdhdZImxW/hKh+YcRgeCf6xbMMpzZmfC9HPz9qg4XGMjr8dfmnpPVnBWhz1m 0j1V+prIVCCqjdeIYN/pI1WYxSn3RPis8c35/e/rxAWHddNv1qXoxIVSTUHf8fqTpwQOJ4lZP0Y+3D SIq0LU0kr6vehbQBfZ8emVFHsG75yQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking a lock at the beginning of .remove() doesn't prevent new readers.
With the existing approach it can happen, that a read occurs just when
the lock was taken blocking the reader until the lock is released at the
end of the remove callback which then accessed *data that is already
freed then.

To actually fix this problem the hwmon core needs some adaption. Until
this is implemented take the optimistic approach of assuming that all
readers are gone after hwmon_device_unregister() and
sysfs_remove_group() as most other drivers do. (And once the core
implements that, taking the lock would deadlock.)

So drop the lock, move the reset to after device unregistration to keep
the device in a workable state until it's deregistered. Also add a error
message in case the reset fails and return 0 anyhow. (Returning an error
code, doesn't stop the platform device unregistration and only results
in a little helpful error message before the devm cleanup handlers are
called.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the motivation for this patch is to fix the driver to not return an
error code in .remove(). The long term goal is to make remove callbacks
return void as returning an error is nearly always wrong and doesn't
have the effect that driver authors think it has. This patch is a
preparation for this conversion.

Best regards
Uwe

 drivers/hwmon/sht15.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 7f4a63959730..ae4d14257a11 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -1020,25 +1020,20 @@ static int sht15_probe(struct platform_device *pdev)
 static int sht15_remove(struct platform_device *pdev)
 {
 	struct sht15_data *data = platform_get_drvdata(pdev);
+	int ret;
 
-	/*
-	 * Make sure any reads from the device are done and
-	 * prevent new ones beginning
-	 */
-	mutex_lock(&data->read_lock);
-	if (sht15_soft_reset(data)) {
-		mutex_unlock(&data->read_lock);
-		return -EFAULT;
-	}
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
+
+	ret = sht15_soft_reset(data);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to reset device (%pe)\n", ERR_PTR(ret));
+
 	if (!IS_ERR(data->reg)) {
 		regulator_unregister_notifier(data->reg, &data->nb);
 		regulator_disable(data->reg);
 	}
 
-	mutex_unlock(&data->read_lock);
-
 	return 0;
 }
 
-- 
2.36.1

