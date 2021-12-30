Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64C8481D84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbhL3PD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbhL3PDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F036CC061746
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxT-0000cX-Rm; Thu, 30 Dec 2021 16:03:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxO-007VLE-Q4; Thu, 30 Dec 2021 16:03:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-0007j2-FM; Thu, 30 Dec 2021 16:03:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 15/23] counter: 104-quad-8: Convert to new counter registration
Date:   Thu, 30 Dec 2021 16:02:52 +0100
Message-Id: <20211230150300.72196-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; h=from:subject; bh=UOaI1YD8iECci/j5iUvmrjFrJEbtX/UC+A+GBcZMNq8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmcf/ShOS774GzEiWldOjRAEp35elhympxQL8b1 WcMgkRWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JnAAKCRDB/BR4rcrsCec3B/ 9ptpxHW0sC/QjboVbFcmgqu7JyFZpThHD2eMFrJyq4iP2A9TRn0U/e5/Kl52rsbBHYsXc1gq3tUr9Y iZNAjY407zN2w0wHWMA8KdQP8yWxGELPTsZHI2yy2euYYp4aB4EgYrne90xCIQXGLkaeNuHD6ME4ML zudSzLQ1+oA9wY+WyIbwGINaDwNNTsJ8oNe6CL7XdrF7xoSC/5g3MHsIDfDJprMIfg/mLKToGSDL9U Gum7+NBTmstAY5YTfmzfnhYk4nU2L+E57oy92dXlijUWjB6/ZNffJ8Y7R3JzXF/xV207TuUj4sVsnI A3trFpW4AUvpAngESJmKwx/ytw96P0
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
index 41b4d6f4583c..1fbb3923797c 100644
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
@@ -1083,7 +1082,8 @@ static struct counter_count quad8_counts[] = {
 
 static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
-	struct quad8 *const priv = private;
+	struct counter_device *counter = private;
+	struct quad8 *const priv = counter_priv(counter);
 	const unsigned long base = priv->base;
 	unsigned long irq_status;
 	unsigned long channel;
@@ -1114,7 +1114,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 			continue;
 		}
 
-		counter_push_event(&priv->counter, event, channel);
+		counter_push_event(counter, event, channel);
 	}
 
 	/* Clear pending interrupts on device */
@@ -1125,6 +1125,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 
 static int quad8_probe(struct device *dev, unsigned int id)
 {
+	struct counter_device *counter;
 	struct quad8 *priv;
 	int i, j;
 	unsigned int base_offset;
@@ -1136,19 +1137,19 @@ static int quad8_probe(struct device *dev, unsigned int id)
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
@@ -1188,11 +1189,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
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

