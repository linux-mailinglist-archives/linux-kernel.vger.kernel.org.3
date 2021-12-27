Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF547FB87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhL0Jp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D85EC06139A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-0006aW-UT; Mon, 27 Dec 2021 10:45:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-006u9p-NW; Mon, 27 Dec 2021 10:45:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0005Xy-LL; Mon, 27 Dec 2021 10:45:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: [PATCH v2 22/23] counter: ti-eqep: Convert to new counter registration
Date:   Mon, 27 Dec 2021 10:45:25 +0100
Message-Id: <20211227094526.698714-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=GmxK8UwCXaWtt50/KLdEtDwbtlCliwQiHnCQoruLRn0=; m=7e6USNn1wpqWAd9V4lBOEi/21Vzmyhs+ECn2Z/KBah0=; p=98X7zTLS7wTFeVlzVCE+MddH8du4Z8u170KsDRrFkyo=; g=633544383990f45a36bcdd6305008c879ade25d0
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJisYACgkQwfwUeK3K7Anpywf/QKT fqrtp0lWUHIrVcxALgKhLPJAb7vs9ze+vAZGs2SKpAfXzKUl4eucOeH2WGXM03CHuVIAT1UCp2VOj 70soJHKMHDtYjfRN4PYHu4KsBNriaDFv8VVQ3yQKGnuB4MI6XI3lpggW09d7CtgE9BmNtIvVno3Fn QmYc5CnCfKdT8OVe7T10ntAqdpgb2XLgRMSy74LVu3BQvyFydlxVxjNwS/80IgLSXJSVen6XNdQwl ONnV4DkiSFVfmP/XdrHBGcvNo6zbZmR1YfAM8B/0NB6CcJMeqf5/xMhMWwdfWyDgfkazIsWYBtka/ fh039zob3dxCT5ujzb9xco4VClFqKRA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes device lifetime issues where it was possible to free a live
struct device.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index abeda966e7be..3b49b492d182 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -368,13 +368,15 @@ static const struct regmap_config ti_eqep_regmap16_config = {
 static int ti_eqep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
 	int err;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -390,16 +392,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap16))
 		return PTR_ERR(priv->regmap16);
 
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &ti_eqep_counter_ops;
-	priv->counter.counts = ti_eqep_counts;
-	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
-	priv->counter.signals = ti_eqep_signals;
-	priv->counter.num_signals = ARRAY_SIZE(ti_eqep_signals);
-	priv->counter.priv = priv;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &ti_eqep_counter_ops;
+	counter->counts = ti_eqep_counts;
+	counter->num_counts = ARRAY_SIZE(ti_eqep_counts);
+	counter->signals = ti_eqep_signals;
+	counter->num_signals = ARRAY_SIZE(ti_eqep_signals);
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, counter);
 
 	/*
 	 * Need to make sure power is turned on. On AM33xx, this comes from the
@@ -409,7 +410,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	err = counter_register(&priv->counter);
+	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
@@ -421,10 +422,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 
 static int ti_eqep_remove(struct platform_device *pdev)
 {
-	struct ti_eqep_cnt *priv = platform_get_drvdata(pdev);
+	struct counter_device *counter = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
-	counter_unregister(&priv->counter);
+	counter_unregister(counter);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-- 
2.33.0

