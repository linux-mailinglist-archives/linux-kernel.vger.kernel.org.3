Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDE47FB85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhL0Jp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhL0Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69780C0613B3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZZ-0006Ye-8J; Mon, 27 Dec 2021 10:45:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-006u9N-6C; Mon, 27 Dec 2021 10:45:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-0005WH-95; Mon, 27 Dec 2021 10:45:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v2 15/23] counter: 104-quad-8: Convert to new counter registration
Date:   Mon, 27 Dec 2021 10:45:18 +0100
Message-Id: <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ZtADFGaT3pReUDCp6p4U90YjwbLIDXlnIOr6HRnmtLY=; m=pbo3Y1HF6couiwYuFg94n5YrXFI5OfbngAy8wR499l8=; p=9T2VgKJ2eje47rywTJ6/saJnMhmjCuNjIyTkzfOfSWI=; g=3a91f95ee9cf0c45d6c66af744f555e14211bea6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiq0ACgkQwfwUeK3K7AkYpgf+NgH eaHP1vSgEHqbsFwhmCjMc/xsk94plXdoAEEzML9Ajgdcd0CbZh9hkhtf1joyHzQzRfcYoAVPp8YQo bmx9zJ79zfTDaDK9loRHdM9hKq1qYcr+gx7eXX3mXCfQ7+BH6of/xJ2AF5uBHO4CPvnkQcmpf2CT9 v8C8y75b51UjNOFGYUNLnbmkdztZnGq0srN6oabUVI+T8+zkypK2QHrneVh64ICXcfPi8Gtij88TM Udvx29Ka8sEbnRTCnGiGZYBmInvcPcHqb0qvO5FvX5RwXy4f1TV0m2BGFLCTp03WI8RnLC9mwf2l8 cA0ZZK22Q8iBMfctNOgJzOuKSeSrqeA==
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

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/104-quad-8.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 6e5286cd1d4e..4315b14f239e 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -52,7 +52,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
  */
 struct quad8 {
 	spinlock_t lock;
-	struct counter_device counter;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
@@ -1127,6 +1126,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 
 static int quad8_probe(struct device *dev, unsigned int id)
 {
+	struct counter_device *counter;
 	struct quad8 *priv;
 	int i, j;
 	unsigned int base_offset;
@@ -1138,19 +1138,19 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	/* Initialize Counter device and driver data */
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &quad8_ops;
-	priv->counter.counts = quad8_counts;
-	priv->counter.num_counts = ARRAY_SIZE(quad8_counts);
-	priv->counter.signals = quad8_signals;
-	priv->counter.num_signals = ARRAY_SIZE(quad8_signals);
-	priv->counter.priv = priv;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &quad8_ops;
+	counter->counts = quad8_counts;
+	counter->num_counts = ARRAY_SIZE(quad8_counts);
+	counter->signals = quad8_signals;
+	counter->num_signals = ARRAY_SIZE(quad8_signals);
 	priv->base = base[id];
 
 	spin_lock_init(&priv->lock);
@@ -1192,11 +1192,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
 
 	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
-			       priv->counter.name, priv);
+			       counter->name, priv);
 	if (err)
 		return err;
 
-	return devm_counter_register(dev, &priv->counter);
+	err = devm_counter_add(dev, counter);
+	if (err < 0)
+		return dev_err_probe(dev, err, "Failed to add counter\n");
+
+	return 0;
 }
 
 static struct isa_driver quad8_driver = {
-- 
2.33.0

