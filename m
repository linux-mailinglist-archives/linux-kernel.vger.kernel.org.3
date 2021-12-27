Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C861747FB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhL0Jqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71330C06179B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006YE-G5; Mon, 27 Dec 2021 10:45:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-006u8j-9f; Mon, 27 Dec 2021 10:45:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZQ-0005TG-TE; Mon, 27 Dec 2021 10:45:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/23] counter: Use container_of instead of drvdata to track counter_device
Date:   Mon, 27 Dec 2021 10:45:04 +0100
Message-Id: <20211227094526.698714-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=WhZLdLliam1HUvYgAAdyYZqU7b1Ox6SZw+AoFf3AYfo=; m=9wq0CKsz7Zt+5kbGc6ZP9L3j/ut+4WtFH3D3A21gjvg=; p=TR5ghLNVD5w+ejoxev7uMl+j4ICbXKPQUuSfB2Fckww=; g=fd9c9e8d0472fe9e05d9e8e3943c38b880e5b1dd
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiyQACgkQwfwUeK3K7Am1zgf9GRD 1wdALgesfcSpIs4MCCWlLzdcADUXSgfXnABh0p9ogTTJSHdu8jxPI/M2E9csrNItmfo5SxQpx7kuV RXZYB13Szovy0vCyaZy4UxLMbKw2Hith5RqBtVdoMruH1SGM9TFFhZR4LxYlFv+L1pWKC3ktMEHmX d48sGCNsnlSNp1Qj+j6eOtL/6DDpo5dU6tQDsztPE3u8Pm4WB6TcCli0H2iwiguXbWv/hsGTWC5FX BfheSRkLQbk+xoBRyFIrTNxhlycGtg01S+BGKANLPjec6qsg4FAs1fMtr23r43t3UljvYjH/snRPT WVPCslfXTKFb/qPANnc7vpcj6QeY1QA==
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
2.33.0

