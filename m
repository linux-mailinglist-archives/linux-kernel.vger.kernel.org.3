Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC64147BE55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhLUKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhLUKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8DC061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcej-0005BQ-7b; Tue, 21 Dec 2021 11:46:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcej-005ngB-6A; Tue, 21 Dec 2021 11:46:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0004CY-1b; Tue, 21 Dec 2021 11:46:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] counter: Remove unused member from struct counter_device
Date:   Tue, 21 Dec 2021 11:45:46 +0100
Message-Id: <20211221104546.214066-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Y0NkBLHZbTPV9AgKvEXqVQXBuc1J1Y5wZlZqUt+q8z8=; m=gRJhxNFIrXvCs2HMMhrXRYXJ62P50jhM9VxuUIFr16M=; p=2zqxcELaKv036XA4cqHni0/9tKYCfObbbaJb80+Waf0=; g=66d467d4dda659dec3678c8363304f55cb46ce85
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsFIACgkQwfwUeK3K7Ak4BQf+Jab Qe3ZLW5+lF0d5ZR9GNedPSuZVa54hNR9n8KeVlE68fdhXjdDB5V+GKDNjN2do9Zh6pvDkqoVgT5cd yLjSIUdDnzshi304AduYuD+kPig8lWozhUwR4IlJ4OG/tvaNh0iW2UUbbRszBC1lsTb08f0bvL+1/ bDAw4xafTThYVlUWQ2x1JTQfBsd9tvbabkYewGmjzSN0G/pTa9Q9P/+5sNpMmEARWF30P6YDLgqT1 zB3FWl3pyLO7qj+bz7f5FlF7rYMre+LN/BH4doMfx5Im39EVXtWvOiz6Z2rLKxGV6xnnskwI+TxVb E65U+vojgrFIiq8EyLeds4XPrE7Il0Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functionality priv was designed for can better be accomplished using
container_of. All drivers have been converted, so drop this now unused
member.

Just one assignment was missed in the conversion of the ti-eqep driver.
This is unused and so can be safely dropped, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 1 -
 include/linux/counter.h   | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 9e0e46bca4c2..8cdc9ab98859 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -402,7 +402,6 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
 	priv->counter.signals = ti_eqep_signals;
 	priv->counter.num_signals = ARRAY_SIZE(ti_eqep_signals);
-	priv->counter.priv = priv;
 
 	platform_set_drvdata(pdev, priv);
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b7d0a00a61cf..fd58f36ea2f7 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -287,7 +287,6 @@ struct counter_ops {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
- * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
  * @events_list:	list of current watching Counter events
@@ -314,8 +313,6 @@ struct counter_device {
 	struct counter_comp *ext;
 	size_t num_ext;
 
-	void *priv;
-
 	struct device dev;
 	struct cdev chrdev;
 	struct list_head events_list;
-- 
2.33.0

