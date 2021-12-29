Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C644814B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbhL2Ppt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbhL2PpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:45:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6420C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:45:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8N-0006qb-4w; Wed, 29 Dec 2021 16:44:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-007KHc-FP; Wed, 29 Dec 2021 16:44:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-00015Z-5y; Wed, 29 Dec 2021 16:44:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 20/23] counter: stm32-timer-cnt: Convert to new counter registration
Date:   Wed, 29 Dec 2021 16:44:38 +0100
Message-Id: <20211229154441.38045-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; h=from:subject; bh=yamPh52MWvtBuq1kwhHgzE8DC1LccrX53waJcMLV5Ao=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJX2YDALYtMQDBjFVY7z1y0vh4yin3H9exKf8He MpsunwCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCVwAKCRDB/BR4rcrsCX2TB/ 4l6dwzOcg3gaNLauntF56BmjfxPhW8LKusPK96eCoKKVv1XVpK2d0OHMrSDwvCnfTE2sCns1muZr/A V8BkrwPtLWadBPofuKRCAZl5T2f9Jme3vQJy3E/SHrE5bg1u+8KcdBpbc/KfkAsc9MabSNiiW+kVPZ 3bnCQ8SA+Mf2kdBNIwos2dwUO1kolUsMp5vbZcWqhgl357yZQ6tTP3aiRCFw5lWYXkYUaGclBmnZEG Su6sxkO+OS4JysLsVNUdXtrUHIPHNgZrcIozmmk7dU7zAqAKHdzyrJf334yRTn50ynntq7xPIRiSiG z9qmwgaHSlUh1JPXodXOFngvE+DU0Z
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

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-timer-cnt.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 4b05b198a8d8..5779ae7c73cf 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -29,7 +29,6 @@ struct stm32_timer_regs {
 };
 
 struct stm32_timer_cnt {
-	struct counter_device counter;
 	struct regmap *regmap;
 	struct clk *clk;
 	u32 max_arr;
@@ -317,31 +316,38 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
 	struct stm32_timer_cnt *priv;
+	struct counter_device *counter;
+	int ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
 
+	priv = counter_priv(counter);
+
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &stm32_timer_cnt_ops;
-	priv->counter.counts = &stm32_counts;
-	priv->counter.num_counts = 1;
-	priv->counter.signals = stm32_signals;
-	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
-	priv->counter.priv = priv;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &stm32_timer_cnt_ops;
+	counter->counts = &stm32_counts;
+	counter->num_counts = 1;
+	counter->signals = stm32_signals;
+	counter->num_signals = ARRAY_SIZE(stm32_signals);
 
 	platform_set_drvdata(pdev, priv);
 
 	/* Register Counter device */
-	return devm_counter_register(dev, &priv->counter);
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		dev_err_probe(dev, ret, "Failed to add counter\n");
+
+	return ret;
 }
 
 static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
-- 
2.34.1

