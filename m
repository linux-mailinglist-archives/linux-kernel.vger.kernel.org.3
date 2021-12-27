Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A493F47FB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhL0JqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbhL0Jpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF22C0613A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZW-0006at-KS; Mon, 27 Dec 2021 10:45:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZW-006u9r-47; Mon, 27 Dec 2021 10:45:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0005Y1-SG; Mon, 27 Dec 2021 10:45:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/23] counter: remove old and now unused registration API
Date:   Mon, 27 Dec 2021 10:45:26 +0100
Message-Id: <20211227094526.698714-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=v1mp6rCzIVBpbYSrlhxQ5kWmzXQJcXt8ddmzIs5vMu0=; m=mBWXU7BZZXM1Z7XyqYl2vUCKa8aqBlhUhH6bjf/FbzM=; p=kWoI65AN29QewkDhoJ7XefM+GJ/FVW3fTTHZzJ/KLwI=; g=47a3e6aee4dcc447b2a74a8f574c7775a6939540
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJisoACgkQwfwUeK3K7AktKAf/XmV 1lc9lOQB3h++7uK+DrW6DbtfI2EdbLwd94XjgZILo9QbZ3+QALeKfq37LXoAUBBEWQwqx5CO5aqXe ik6g5mY7lLnK5+UtF8bRh7PnU5KPnJQ7qtTIs4VeD5UXSupbTOQSBr/fIX/qZ1A/IxNfvKoEVHZJS IFhZe7idoIXNjcghRBJnEVw6XZlGd7S1LBw/jPpDB7P2WaseXnws0yBE355Tx/Gfd7PhCIWSjcL2D OAYs2tyUinfgi6R51uW0YAzC0rVbFQfly6lnaLnbYCm1J5aXB+YACrjs0nwpJ46eWV0pMpnfZ574/ N2FZwfEwYvrr8o8P4Pk+rI8hsdksm9A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of counter_register() yields issues in device lifetime tracking. All
drivers were converted to the new API, so the old one can go away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 97 ++--------------------------------
 include/linux/counter.h        | 12 -----
 2 files changed, 4 insertions(+), 105 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 8261567b6272..3f7dc5718423 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -38,8 +38,7 @@ static void counter_device_release(struct device *dev)
 	counter_chrdev_remove(counter);
 	ida_free(&counter_ida, dev->id);
 
-	if (!counter->legacy_device)
-		kfree(container_of(counter, struct counter_device_allochelper, counter));
+	kfree(container_of(counter, struct counter_device_allochelper, counter));
 }
 
 static struct device_type counter_device_type = {
@@ -62,76 +61,13 @@ static dev_t counter_devt;
  */
 void *counter_priv(const struct counter_device *const counter)
 {
-	if (counter->legacy_device) {
-		return counter->priv;
-	} else {
-		struct counter_device_allochelper *ch =
-			container_of(counter, struct counter_device_allochelper, counter);
+	struct counter_device_allochelper *ch =
+		container_of(counter, struct counter_device_allochelper, counter);
 
-		return &ch->privdata;
-	}
+	return &ch->privdata;
 }
 EXPORT_SYMBOL_GPL(counter_priv);
 
-/**
- * counter_register - register Counter to the system
- * @counter:	pointer to Counter to register
- *
- * This function registers a Counter to the system. A sysfs "counter" directory
- * will be created and populated with sysfs attributes correlating with the
- * Counter Signals, Synapses, and Counts respectively.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int counter_register(struct counter_device *const counter)
-{
-	struct device *const dev = &counter->dev;
-	int id;
-	int err;
-
-	counter->legacy_device = true;
-
-	/* Acquire unique ID */
-	id = ida_alloc(&counter_ida, GFP_KERNEL);
-	if (id < 0)
-		return id;
-
-	mutex_init(&counter->ops_exist_lock);
-
-	/* Configure device structure for Counter */
-	dev->id = id;
-	dev->type = &counter_device_type;
-	dev->bus = &counter_bus_type;
-	dev->devt = MKDEV(MAJOR(counter_devt), id);
-	if (counter->parent) {
-		dev->parent = counter->parent;
-		dev->of_node = counter->parent->of_node;
-	}
-	device_initialize(dev);
-
-	err = counter_sysfs_add(counter);
-	if (err < 0)
-		goto err_free_id;
-
-	err = counter_chrdev_add(counter);
-	if (err < 0)
-		goto err_free_id;
-
-	err = cdev_device_add(&counter->chrdev, dev);
-	if (err < 0)
-		goto err_remove_chrdev;
-
-	return 0;
-
-err_remove_chrdev:
-	counter_chrdev_remove(counter);
-err_free_id:
-	put_device(dev);
-	return err;
-}
-EXPORT_SYMBOL_GPL(counter_register);
-
 /**
  * counter_alloc - allocate a counter_device
  * @sizeof_priv: size of the driver private data
@@ -255,31 +191,6 @@ static void devm_counter_release(void *counter)
 	counter_unregister(counter);
 }
 
-/**
- * devm_counter_register - Resource-managed counter_register
- * @dev:	device to allocate counter_device for
- * @counter:	pointer to Counter to register
- *
- * Managed counter_register. The Counter registered with this function is
- * automatically unregistered on driver detach. This function calls
- * counter_register internally. Refer to that function for more information.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int devm_counter_register(struct device *dev,
-			  struct counter_device *const counter)
-{
-	int err;
-
-	err = counter_register(counter);
-	if (err < 0)
-		return err;
-
-	return devm_add_action_or_reset(dev, devm_counter_release, counter);
-}
-EXPORT_SYMBOL_GPL(devm_counter_register);
-
 static void devm_counter_put(void *counter)
 {
 	counter_put(counter);
diff --git a/include/linux/counter.h b/include/linux/counter.h
index f1350a43cd48..9afa0f1e9cea 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -314,8 +314,6 @@ struct counter_device {
 	struct counter_comp *ext;
 	size_t num_ext;
 
-	void *priv;
-
 	struct device dev;
 	struct cdev chrdev;
 	struct list_head events_list;
@@ -327,25 +325,15 @@ struct counter_device {
 	spinlock_t events_in_lock;
 	struct mutex events_out_lock;
 	struct mutex ops_exist_lock;
-
-	/*
-	 * This can go away once all drivers are converted to
-	 * counter_alloc()/counter_add().
-	 */
-	bool legacy_device;
 };
 
 void *counter_priv(const struct counter_device *const counter);
 
-int counter_register(struct counter_device *const counter);
-
 struct counter_device *counter_alloc(size_t sizeof_priv);
 void counter_put(struct counter_device *const counter);
 int counter_add(struct counter_device *const counter);
 
 void counter_unregister(struct counter_device *const counter);
-int devm_counter_register(struct device *dev,
-			  struct counter_device *const counter);
 struct counter_device *devm_counter_alloc(struct device *dev,
 					  size_t sizeof_priv);
 int devm_counter_add(struct device *dev,
-- 
2.33.0

