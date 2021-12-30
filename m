Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5639481D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhL3PDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbhL3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03385C061746
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cJ-0W; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxL-007VKW-9E; Thu, 30 Dec 2021 16:03:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxK-0007g2-9a; Thu, 30 Dec 2021 16:03:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 01/23] counter: Use container_of instead of drvdata to track counter_device
Date:   Thu, 30 Dec 2021 16:02:38 +0100
Message-Id: <20211230150300.72196-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; h=from:subject; bh=g5AkavRPc9KasQPrhOwNqTslienH33kFzd0pJErlhlU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzclKSLFOJ/a/KGmVNCh/amQvSqREydHIQgQrU5Zf 7izYy/SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JSgAKCRDB/BR4rcrsCSNDB/ 9Zf8nwUY+hiNakm2EMkPQT0DaqvUfGeup3HIPingW7WfJkfI5nWgs2mrrZIVMggWnPczFBpMz0z8YP m8DMfzgRA84Jp/MxnlbLeRnbbFAij03iA7TTpvwZLw8r66Y0Id8CdKt3yhiNSZiiAhasQ6D05u3fDe C64A6ne6Z8yp0r6H18MW8Ur4TKy8OcAuCwdFT6Kds8MVzdlVgw+975I3S7Ji8x93Xc5zWqXCs453UP 4ymD0D0BBVLBB5oAzga4Aibvv4ut9O44fjEfSuTLZCN6RuehshHUJiSlrbimvmpaSa0kt9SyHWItj9 GHefx+Dxsz1qO3W3FDtmz9W7ZGjVFQ
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

