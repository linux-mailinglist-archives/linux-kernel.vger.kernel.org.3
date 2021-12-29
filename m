Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903394814AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbhL2PpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E08C061756
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qK-8e; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-007KGh-Tm; Wed, 29 Dec 2021 16:44:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8C-00011q-8L; Wed, 29 Dec 2021 16:44:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/23] counter: Use container_of instead of drvdata to track counter_device
Date:   Wed, 29 Dec 2021 16:44:19 +0100
Message-Id: <20211229154441.38045-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; h=from:subject; bh=g5AkavRPc9KasQPrhOwNqTslienH33kFzd0pJErlhlU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIQSLFOJ/a/KGmVNCh/amQvSqREydHIQgQrU5Zf 7izYy/SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCEAAKCRDB/BR4rcrsCcmCB/ 9Ul1LyNCJzuJh1N891ue1F1mKn/GbQ7g1z9/4Ntnf6SJ9nE16vS2ZdsKef4pcueM5CIf9WbnM6ht/R Q/AmYb5mhYdjWSa0e0sHWSYC6hpiveHaj3bkthaAeYy4U8Fiut/wJaRaauuo9RlPITQOqDUwVcGMgt zmjqrXYWlKmbemowvWu4+aQeH153fRsF04iyI8VWkiqqMGKaFr1IkbyDt2uhQABzbgzVknBoIqdGHR tPw9uljdAklBwp53ektD3xDl2jL/iAKuzx/bABZBKdPdzP8/LZkEg4QlHnf0DcJGtrJ6lHIpZI816y DobbHiascSdouKjqeMFPzITYEXZP7M
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter core uses drvdata to find a struct counter_device from a
struct device. However as the device is a member of struct counter_device,
the lookup can be done faster (and a bit type safe) using container_of.

There are no other users of drvdata, so the call to dev_set_drvdata can
go away, too.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 5acc54539623..f053a43c6c04 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -26,7 +26,8 @@ static DEFINE_IDA(counter_ida);
 
 static void counter_device_release(struct device *dev)
 {
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter =
+		container_of(dev, struct counter_device, dev);
 
 	counter_chrdev_remove(counter);
 	ida_free(&counter_ida, dev->id);
@@ -78,7 +79,6 @@ int counter_register(struct counter_device *const counter)
 		dev->of_node = counter->parent->of_node;
 	}
 	device_initialize(dev);
-	dev_set_drvdata(dev, counter);
 
 	err = counter_sysfs_add(counter);
 	if (err < 0)
-- 
2.34.1

