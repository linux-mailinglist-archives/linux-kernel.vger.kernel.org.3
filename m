Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17C481D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhL3PEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbhL3PDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC88C061748
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxR-0000ea-1U; Thu, 30 Dec 2021 16:03:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-007VLl-BJ; Thu, 30 Dec 2021 16:03:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0007kN-Dm; Thu, 30 Dec 2021 16:03:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 22/23] counter: ti-eqep: Convert to new counter registration
Date:   Thu, 30 Dec 2021 16:02:59 +0100
Message-Id: <20211230150300.72196-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; h=from:subject; bh=UWq0wAUfaJW40jFlBlDFNHj7y5zbvxwYi4nbIdVfTb0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcm3bsNQHNHkEIl8bXD+EwtbVCkxPLaSgU1/UU4s ZyyPryOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JtwAKCRDB/BR4rcrsCcDnB/ 0WlqWKEZJXpatGfBhYdjXViqHmVVWopAusSk0BEJinf8umtGVO43eo90fa3THZ4loJaY8wgjsj968i 9lCclDJxiCwkj6ngGV3/QhD+qD3iOFKP7sjxLykOFyegJsWeAPeGgKVucH4Y5QO/FbITCFpbMW51hY 3I91atY1GYSOPnLQTR5PpZ5ga4EIr6cR00FmNpj3oDit95oyYLcEXpviaAJ+f/Dam4ReZb8pQw83AS F/BZUu8EudSt5dUoLoRKGr9hfJFsyj8zEp4yaHYIRbJBF9fFlnOhruCeR7jKsZt8ofongpxsy0lTwW hey1O3mhaPS6wVzZyiZ3v6peTjTbfh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: David Lechner <david@lechnology.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 2c70b900a6cf..0489d26eb47c 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -373,13 +373,15 @@ static const struct regmap_config ti_eqep_regmap16_config = {
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
@@ -395,16 +397,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
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
@@ -414,7 +415,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	err = counter_register(&priv->counter);
+	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
@@ -426,10 +427,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 
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
2.34.1

