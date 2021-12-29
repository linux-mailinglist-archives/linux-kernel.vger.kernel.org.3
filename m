Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69E481494
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhL2Po7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F119C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qW-8c; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-007KHN-5x; Wed, 29 Dec 2021 16:44:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8F-00014e-9l; Wed, 29 Dec 2021 16:44:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v3 15/23] counter: 104-quad-8: Convert to new counter registration
Date:   Wed, 29 Dec 2021 16:44:33 +0100
Message-Id: <20211229154441.38045-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; h=from:subject; bh=fCwyTDvkVPq0a+mwmGBMlzNOFeaz0oQeWCpaw+ebsCk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJEgyRnLmtOQ2bWK6PbcaKTiAwfXUzswJ1eUg0F iebCyaeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCRAAKCRDB/BR4rcrsCf7NB/ 9vCyyh9i9tGeTGUx6UzwbkJZQRIHn5/KeaRnYmzLPtNXFgFtfhIa1XzsmfjrZ58tjTViTc28bVVndG jZoCOsmcBQro8SHLesJN5GOuMeYrUyhwla05Z81Jv3hPEZduh+2eAQDM6dmfwVLc9hA21uzSN1c6w1 YIG/mtfCl6DrGuZd/pjNo7zVDZ7kXs4h2vZOrt3GMEh+63oF+NeP8Fwv2b8Y7E2E0ovLp/gZesdCX4 Z6vjPK+csL169LDE3jMY54iyDDYWxIa6uXIRVjBj1bNtOwICUT7WfzGTcSlAOg/zgmq8HCTLJzb8eA kmLMJ2ou6L/655zSGEbfPGplJZpY/t
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

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/104-quad-8.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 6e5286cd1d4e..680c7ba943a4 100644
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
@@ -1085,7 +1084,8 @@ static struct counter_count quad8_counts[] = {
 
 static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
-	struct quad8 *const priv = private;
+	struct counter_device *counter = private;
+	struct quad8 *const priv = counter_priv(counter);
 	const unsigned long base = priv->base;
 	unsigned long irq_status;
 	unsigned long channel;
@@ -1116,7 +1116,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 			continue;
 		}
 
-		counter_push_event(&priv->counter, event, channel);
+		counter_push_event(counter, event, channel);
 	}
 
 	/* Clear pending interrupts on device */
@@ -1127,6 +1127,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 
 static int quad8_probe(struct device *dev, unsigned int id)
 {
+	struct counter_device *counter;
 	struct quad8 *priv;
 	int i, j;
 	unsigned int base_offset;
@@ -1138,19 +1139,19 @@ static int quad8_probe(struct device *dev, unsigned int id)
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
@@ -1192,11 +1193,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
 
 	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
-			       priv->counter.name, priv);
+			       counter->name, counter);
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
2.34.1

