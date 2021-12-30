Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2085481D75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhL3PDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbhL3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9BC061747
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000ca-PQ; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-007VLN-D2; Thu, 30 Dec 2021 16:03:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxO-0007jM-Hm; Thu, 30 Dec 2021 16:03:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 18/23] counter: ftm-quaddec: Convert to new counter registration
Date:   Thu, 30 Dec 2021 16:02:55 +0100
Message-Id: <20211230150300.72196-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; h=from:subject; bh=dEjv5+WDibUQXP80AqPnPObQXmoq70SGZBTr6K5rpzQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmnVcEOLoF6nRh7AcGLwuW1Sbhc0blFhQMHBrzK WdyQ1OaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JpwAKCRDB/BR4rcrsCZEtCA CTjOVOzRVQaxPtUhM3r1KFG2mf9U++sreDdAvio2jg+dKxLQu3xcg2urxUp6405QNpnuosV8/GXXoU 2ruGQwvuFx2qP4p5pNpwEo0Ypm9OLkP+8ozbWOVUO7am2EfSWY5bY/1V4zkL/nWBpkXpZoZqQWsimI W4wdspNMEzkqn/5AdluBOHzP4Tx4gW2ilFl2SMujOcaAdOFBIF4L6Vfj8Csmk2YWTclxvdQ6oRgG6D OAPEg609KxbYmc//L7gQ3ghbx9jHHjoY8Rs4ht0DqOfNeK98BQpCQ7VWrIM4oyQeaD/95nJVNGcyxI CmKoaicTf+JTjo9TCxYsjzNHSqqrrb
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

Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index f5d92df6a611..2a58582a9df4 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -26,7 +26,6 @@
 	})
 
 struct ftm_quaddec {
-	struct counter_device counter;
 	struct platform_device *pdev;
 	void __iomem *ftm_base;
 	bool big_endian;
@@ -259,15 +258,17 @@ static struct counter_count ftm_quaddec_counts = {
 
 static int ftm_quaddec_probe(struct platform_device *pdev)
 {
+	struct counter_device *counter;
 	struct ftm_quaddec *ftm;
 
 	struct device_node *node = pdev->dev.of_node;
 	struct resource *io;
 	int ret;
 
-	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
-	if (!ftm)
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*ftm));
+	if (!counter)
 		return -ENOMEM;
+	ftm = counter_priv(counter);
 
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
@@ -283,14 +284,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to map memory region\n");
 		return -EINVAL;
 	}
-	ftm->counter.name = dev_name(&pdev->dev);
-	ftm->counter.parent = &pdev->dev;
-	ftm->counter.ops = &ftm_quaddec_cnt_ops;
-	ftm->counter.counts = &ftm_quaddec_counts;
-	ftm->counter.num_counts = 1;
-	ftm->counter.signals = ftm_quaddec_signals;
-	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
-	ftm->counter.priv = ftm;
+	counter->name = dev_name(&pdev->dev);
+	counter->parent = &pdev->dev;
+	counter->ops = &ftm_quaddec_cnt_ops;
+	counter->counts = &ftm_quaddec_counts;
+	counter->num_counts = 1;
+	counter->signals = ftm_quaddec_signals;
+	counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
 
 	mutex_init(&ftm->ftm_quaddec_mutex);
 
@@ -300,9 +300,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_counter_register(&pdev->dev, &ftm->counter);
+	ret = devm_counter_add(&pdev->dev, counter);
 	if (ret)
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
 
 	return 0;
 }
-- 
2.34.1

