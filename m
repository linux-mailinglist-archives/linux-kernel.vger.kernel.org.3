Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B328847FB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhL0JqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhL0Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E766C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-0006ZD-Kd; Mon, 27 Dec 2021 10:45:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-006u9W-2t; Mon, 27 Dec 2021 10:45:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-0005X5-Si; Mon, 27 Dec 2021 10:45:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 18/23] counter: ftm-quaddec: Convert to new counter registration
Date:   Mon, 27 Dec 2021 10:45:21 +0100
Message-Id: <20211227094526.698714-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=T9Exz3wKL9LBHOoGq1qDfP1qZAK927KAHy9K6Esz8lk=; m=ZZb0WZj9AWrp3lat8A5ZAyjFwLerq6gaSWzN2AryO3E=; p=U1R/fDU5JZactEOvNpJJG8CxM7TwsyPeNRNDZk3R2Es=; g=c6c3f53e9d55102ae135c93040b25acca47de566
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJirgACgkQwfwUeK3K7AmMbgf9HjH 8c2xrk8rnUQCxfDZZ0QsnrupwObWG97KB+sRr8EBvXMaopw1ExI+NdQqAPeJ1E4SzJlc1r3zyGuWF /9uB7DECelUCYHbkjMIqLNY/Zn3DhWPpcvvegm3xHB71XHMtwpm15ov4zGna3CqC6b2qSpBaTWlOa D8Awm+ns3YKWC4nxC1YYRoz2g4EPRtsI9sOGbVSHZhl456CAX1RTcKQ2E6i5XzWbDurjBXzaVCywA UMwTRwRHLwj4iwXYo/vYAhF8OYmkSib/D4D9cN/50mLX9wdL26cTxtgGm5r7naZVEzVeFKsfmWTSg jwVIG6L8+SNp8Txk/aW1gMxkz0rOMKg==
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
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/104-quad-8.c  |  7 ++++---
 drivers/counter/ftm-quaddec.c | 27 +++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 4315b14f239e..680c7ba943a4 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1084,7 +1084,8 @@ static struct counter_count quad8_counts[] = {
 
 static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
-	struct quad8 *const priv = private;
+	struct counter_device *counter = private;
+	struct quad8 *const priv = counter_priv(counter);
 	const unsigned long base = priv->base;
 	unsigned long irq_status;
 	unsigned long channel;
@@ -1115,7 +1116,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 			continue;
 		}
 
-		counter_push_event(&priv->counter, event, channel);
+		counter_push_event(counter, event, channel);
 	}
 
 	/* Clear pending interrupts on device */
@@ -1192,7 +1193,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
 
 	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
-			       counter->name, priv);
+			       counter->name, counter);
 	if (err)
 		return err;
 
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index f5d92df6a611..c636183b1337 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -26,7 +26,6 @@
 	})
 
 struct ftm_quaddec {
-	struct counter_device counter;
 	struct platform_device *pdev;
 	void __iomem *ftm_base;
 	bool big_endian;
@@ -259,15 +258,16 @@ static struct counter_count ftm_quaddec_counts = {
 
 static int ftm_quaddec_probe(struct platform_device *pdev)
 {
+	struct counter_device *counter;
 	struct ftm_quaddec *ftm;
-
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
@@ -283,14 +283,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
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
 
@@ -300,9 +299,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
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
2.33.0

