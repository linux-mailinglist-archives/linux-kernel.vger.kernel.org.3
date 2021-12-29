Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8F4814BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhL2PqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbhL2PpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:45:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D5C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:45:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8M-0006qa-0x; Wed, 29 Dec 2021 16:44:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-007KHX-Ub; Wed, 29 Dec 2021 16:44:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-00015J-0H; Wed, 29 Dec 2021 16:44:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v3 19/23] counter: microchip-tcb-capture: Convert to new counter registration
Date:   Wed, 29 Dec 2021 16:44:37 +0100
Message-Id: <20211229154441.38045-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719; h=from:subject; bh=ilok6S7IEjL22MS++d5HMtruBUuqxpO8sZvUtAfS3SU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJTXvq6aiieYdSsHVOhmkcvivxdAX/2CRtHBJXr 3MNKaPKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCUwAKCRDB/BR4rcrsCVuXB/ 99b1RfXLQZ290Jqd+ClUlB3jMSHDwYZ+u5kZGNayBj6w2DN8gtYXJSKg4JXTGiPRSLaLKNhg6M2Bg0 JWNK1qfqLY+Dn9AXsbZzwWOW0IWHlblY1Vn4k4/IHnlR+yFcHjQ42lD0zqh0XcgQwDIVqrhNRIU4TL VJoajEPpgL9HoavmXY7P/azae2ABHQtWvLBEQpTiDoOE20X2WX9UQUiinY1AP/bUbvfwIUcKtPkEg+ OyJj7M7Nt3umXmVGL6n7GjLX/KSrTBcDkEGQJELnS36r3jDVjuGhIWBnPK1hydox6bWZwZ2JpsPo5D Cv+UHzifL9f27MpF6W8qD912kHobLs
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

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/microchip-tcb-capture.c | 30 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1b56b7444668..70c1d28546be 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -24,7 +24,6 @@
 
 struct mchp_tc_data {
 	const struct atmel_tcb_config *tc_cfg;
-	struct counter_device counter;
 	struct regmap *regmap;
 	int qdec_mode;
 	int num_channels;
@@ -296,6 +295,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct atmel_tcb_config *tcb_config;
 	const struct of_device_id *match;
+	struct counter_device *counter;
 	struct mchp_tc_data *priv;
 	char clk_name[7];
 	struct regmap *regmap;
@@ -303,9 +303,10 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	int channel;
 	int ret, i;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	match = of_match_node(atmel_tc_of_match, np->parent);
 	tcb_config = match->data;
@@ -360,16 +361,19 @@ static int mchp_tc_probe(struct platform_device *pdev)
 
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
-	priv->counter.name = dev_name(&pdev->dev);
-	priv->counter.parent = &pdev->dev;
-	priv->counter.ops = &mchp_tc_ops;
-	priv->counter.num_counts = ARRAY_SIZE(mchp_tc_counts);
-	priv->counter.counts = mchp_tc_counts;
-	priv->counter.num_signals = ARRAY_SIZE(mchp_tc_count_signals);
-	priv->counter.signals = mchp_tc_count_signals;
-	priv->counter.priv = priv;
-
-	return devm_counter_register(&pdev->dev, &priv->counter);
+	counter->name = dev_name(&pdev->dev);
+	counter->parent = &pdev->dev;
+	counter->ops = &mchp_tc_ops;
+	counter->num_counts = ARRAY_SIZE(mchp_tc_counts);
+	counter->counts = mchp_tc_counts;
+	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
+	counter->signals = mchp_tc_count_signals;
+
+	ret = devm_counter_add(&pdev->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
+
+	return 0;
 }
 
 static const struct of_device_id mchp_tc_dt_ids[] = {
-- 
2.34.1

