Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1A4B3B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiBMMaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBMMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:30:20 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB85AEF2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:30:14 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JE16nPuMsHZHJJE16nOrpB; Sun, 13 Feb 2022 13:30:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 13:30:12 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: as3935: Use devm_delayed_work_autocancel()
Date:   Sun, 13 Feb 2022 13:30:11 +0100
Message-Id: <8d5c50f191bd8f751849d72127f83b14a7636d64.1644755396.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_delayed_work_autocancel() instead of hand writing it.
It saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/proximity/as3935.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index bd7595db31d4..00e06491b188 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/irq.h>
@@ -344,14 +345,6 @@ static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
 #define AS3935_PM_OPS NULL
 #endif
 
-static void as3935_stop_work(void *data)
-{
-	struct iio_dev *indio_dev = data;
-	struct as3935_state *st = iio_priv(indio_dev);
-
-	cancel_delayed_work_sync(&st->work);
-}
-
 static int as3935_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -432,8 +425,7 @@ static int as3935_probe(struct spi_device *spi)
 
 	calibrate_as3935(st);
 
-	INIT_DELAYED_WORK(&st->work, as3935_event_work);
-	ret = devm_add_action(dev, as3935_stop_work, indio_dev);
+	ret = devm_delayed_work_autocancel(dev, &st->work, as3935_event_work);
 	if (ret)
 		return ret;
 
-- 
2.32.0

