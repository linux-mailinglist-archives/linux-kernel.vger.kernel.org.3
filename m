Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493E5481D70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhL3PDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbhL3PDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cW-0V; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxO-007VL6-34; Thu, 30 Dec 2021 16:03:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-0007iP-3l; Thu, 30 Dec 2021 16:03:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 13/23] counter: Provide alternative counter registration functions
Date:   Thu, 30 Dec 2021 16:02:50 +0100
Message-Id: <20211230150300.72196-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8502; h=from:subject; bh=d9g2++kV0+/OGAwQOU1ysXUYhLQtCAC8Q+3ueNORjnU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmUETtRjb7JXD7MH0u8ErRYfWIY7xxgSw7o5hva qYYBfH+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JlAAKCRDB/BR4rcrsCb7HB/ 0Q/Z//nafOYG9/LVEdexNVSRwwlGDl/W26BahClsW9yxY4t7OM7F8qbqqc2u/JYMMwuxgYLEPefGq2 n09b+7TOX/rc2qIMc5mO9SOnGnBO53Zi1s6yzJGdjJr5oW2aqq3aQBWdr+idVbFlEbLXLJziUE6OQB z/JfO+ZnvotDBntG0dYiRbix6avMlyISsxJT68S+QP7yIm+Vv/FZJAKX70NWEuaswEmc03Mbc9QzNV FKlUwG7yPCQ7RoZgjVCsnznqR/sxy4c2iQnWNcYOcJQz3K0bSJOXQjzD7dSyxiDosKgx5s0So6cwMk qT/RVhbnWdNbKqATLsBJh/bp+pZP6G
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation gets device lifetime tracking wrong. The
problem is that allocation of struct counter_device is controlled by the
individual drivers but this structure contains a struct device that
might have to live longer than a driver is bound. As a result a command
sequence like:

	{ sleep 5; echo bang; } > /dev/counter0 &
	sleep 1;
	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-counter/unbind

can keep a reference to the struct device and unbinding results in
freeing the memory occupied by this device resulting in an oops.

This commit provides two new functions (plus some helpers):
 - counter_alloc() to allocate a struct counter_device that is
   automatically freed once the embedded struct device is released
 - counter_add() to register such a device.

Note that this commit doesn't fix any issues, all drivers have to be
converted to these new functions to correct the lifetime problems.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 168 ++++++++++++++++++++++++++++++++-
 include/linux/counter.h        |  15 +++
 2 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 00c41f28c101..b3fa15bbcbdb 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -15,6 +15,7 @@
 #include <linux/kdev_t.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -24,6 +25,16 @@
 /* Provides a unique ID for each counter device */
 static DEFINE_IDA(counter_ida);
 
+struct counter_device_allochelper {
+	struct counter_device counter;
+
+	/*
+	 * This is cache line aligned to ensure private data behaves like if it
+	 * were kmalloced separately.
+	 */
+	unsigned long privdata[] ____cacheline_aligned;
+};
+
 static void counter_device_release(struct device *dev)
 {
 	struct counter_device *const counter =
@@ -31,6 +42,9 @@ static void counter_device_release(struct device *dev)
 
 	counter_chrdev_remove(counter);
 	ida_free(&counter_ida, dev->id);
+
+	if (!counter->legacy_device)
+		kfree(container_of(counter, struct counter_device_allochelper, counter));
 }
 
 static struct device_type counter_device_type = {
@@ -53,7 +67,14 @@ static dev_t counter_devt;
  */
 void *counter_priv(const struct counter_device *const counter)
 {
-	return counter->priv;
+	if (counter->legacy_device) {
+		return counter->priv;
+	} else {
+		struct counter_device_allochelper *ch =
+			container_of(counter, struct counter_device_allochelper, counter);
+
+		return &ch->privdata;
+	}
 }
 EXPORT_SYMBOL_GPL(counter_priv);
 
@@ -74,6 +95,8 @@ int counter_register(struct counter_device *const counter)
 	int id;
 	int err;
 
+	counter->legacy_device = true;
+
 	/* Acquire unique ID */
 	id = ida_alloc(&counter_ida, GFP_KERNEL);
 	if (id < 0)
@@ -114,6 +137,95 @@ int counter_register(struct counter_device *const counter)
 }
 EXPORT_SYMBOL_GPL(counter_register);
 
+/**
+ * counter_alloc - allocate a counter_device
+ * @sizeof_priv: size of the driver private data
+ *
+ * This is part one of counter registration. The structure is allocated
+ * dynamically to ensure the right lifetime for the embedded struct device.
+ *
+ * If this succeeds, call counter_put() to get rid of the counter_device again.
+ */
+struct counter_device *counter_alloc(size_t sizeof_priv)
+{
+	struct counter_device_allochelper *ch;
+	struct counter_device *counter;
+	struct device *dev;
+	int err;
+
+	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
+	if (!ch) {
+		err = -ENOMEM;
+		goto err_alloc_ch;
+	}
+
+	counter = &ch->counter;
+	dev = &counter->dev;
+
+	/* Acquire unique ID */
+	err = ida_alloc(&counter_ida, GFP_KERNEL);
+	if (err < 0)
+		goto err_ida_alloc;
+	dev->id = err;
+
+	mutex_init(&counter->ops_exist_lock);
+	dev->type = &counter_device_type;
+	dev->bus = &counter_bus_type;
+	dev->devt = MKDEV(MAJOR(counter_devt), dev->id);
+
+	err = counter_chrdev_add(counter);
+	if (err < 0)
+		goto err_chrdev_add;
+
+	device_initialize(dev);
+
+	return counter;
+
+err_chrdev_add:
+
+	ida_free(&counter_ida, dev->id);
+err_ida_alloc:
+
+	kfree(ch);
+err_alloc_ch:
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(counter_alloc);
+
+void counter_put(struct counter_device *counter)
+{
+	put_device(&counter->dev);
+}
+EXPORT_SYMBOL_GPL(counter_put);
+
+/**
+ * counter_add - complete registration of a counter
+ * @counter: the counter to add
+ *
+ * This is part two of counter registration.
+ *
+ * If this succeeds, call counter_unregister() to get rid of the counter_device again.
+ */
+int counter_add(struct counter_device *counter)
+{
+	int err;
+	struct device *dev = &counter->dev;
+
+	if (counter->parent) {
+		dev->parent = counter->parent;
+		dev->of_node = counter->parent->of_node;
+	}
+
+	err = counter_sysfs_add(counter);
+	if (err < 0)
+		return err;
+
+	/* implies device_add(dev) */
+	return cdev_device_add(&counter->chrdev, dev);
+}
+EXPORT_SYMBOL_GPL(counter_add);
+
 /**
  * counter_unregister - unregister Counter from the system
  * @counter:	pointer to Counter to unregister
@@ -134,7 +246,8 @@ void counter_unregister(struct counter_device *const counter)
 
 	mutex_unlock(&counter->ops_exist_lock);
 
-	put_device(&counter->dev);
+	if (counter->legacy_device)
+		put_device(&counter->dev);
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
 
@@ -168,6 +281,57 @@ int devm_counter_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_counter_register);
 
+static void devm_counter_put(void *counter)
+{
+	counter_put(counter);
+}
+
+/**
+ * devm_counter_alloc - allocate a counter_device
+ * @dev: the device to register the release callback for
+ * @sizeof_priv: size of the driver private data
+ *
+ * This is the device managed version of counter_add(). It registers a cleanup
+ * callback to care for calling counter_put().
+ */
+struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv)
+{
+	struct counter_device *counter;
+	int err;
+
+	counter = counter_alloc(sizeof_priv);
+	if (IS_ERR(counter))
+		return counter;
+
+	err = devm_add_action_or_reset(dev, devm_counter_put, counter);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return counter;
+}
+EXPORT_SYMBOL_GPL(devm_counter_alloc);
+
+/**
+ * devm_counter_add - complete registration of a counter
+ * @dev: the device to register the release callback for
+ * @counter: the counter to add
+ *
+ * This is the device managed version of counter_add(). It registers a cleanup
+ * callback to care for calling counter_unregister().
+ */
+int devm_counter_add(struct device *dev,
+		     struct counter_device *const counter)
+{
+	int err;
+
+	err = counter_add(counter);
+	if (err < 0)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_counter_release, counter);
+}
+EXPORT_SYMBOL_GPL(devm_counter_add);
+
 #define COUNTER_DEV_MAX 256
 
 static int __init counter_init(void)
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 627f1757f6bb..ed8d5820f0d1 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -327,14 +327,29 @@ struct counter_device {
 	spinlock_t events_in_lock;
 	struct mutex events_out_lock;
 	struct mutex ops_exist_lock;
+
+	/*
+	 * This can go away once all drivers are converted to
+	 * counter_alloc()/counter_add().
+	 */
+	bool legacy_device;
 };
 
 void *counter_priv(const struct counter_device *const counter);
 
 int counter_register(struct counter_device *const counter);
+
+struct counter_device *counter_alloc(size_t sizeof_priv);
+void counter_put(struct counter_device *const counter);
+int counter_add(struct counter_device *const counter);
+
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
+struct counter_device *devm_counter_alloc(struct device *dev,
+					  size_t sizeof_priv);
+int devm_counter_add(struct device *dev,
+		     struct counter_device *const counter);
 void counter_push_event(struct counter_device *const counter, const u8 event,
 			const u8 channel);
 
-- 
2.34.1

