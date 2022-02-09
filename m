Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA604AEE35
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiBIJlG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 04:41:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbiBIJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:37:50 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D8EC1DC707
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:37:44 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-d3iAWbqQN9uLhVUqtqnBTQ-1; Wed, 09 Feb 2022 04:09:06 -0500
X-MC-Unique: d3iAWbqQN9uLhVUqtqnBTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDDC584DA47;
        Wed,  9 Feb 2022 09:09:04 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477DA4F879;
        Wed,  9 Feb 2022 09:09:02 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: Improve watchdog_dev function documentation
Date:   Wed,  9 Feb 2022 10:08:52 +0100
Message-Id: <274cc9a2b34c7ffd042170fe2f8a5e55e22766b8.1644396833.git.bristot@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust function comments to the kernel doc format. It
also adjusts some variable names and adds return values.

No functional change.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 244 ++++++++++++++++----------------
 1 file changed, 125 insertions(+), 119 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3a3d8b5c7ad5..ccf6f4cb8eec 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -171,17 +171,17 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 }
 
 /*
- *	watchdog_ping: ping the watchdog.
- *	@wdd: the watchdog device to ping
+ * watchdog_ping - ping the watchdog
+ * @wdd: The watchdog device to ping
  *
- *	The caller must hold wd_data->lock.
+ * If the watchdog has no own ping operation then it needs to be
+ * restarted via the start operation. This wrapper function does
+ * exactly that.
+ * We only ping when the watchdog device is running.
+ * The caller must hold wd_data->lock.
  *
- *	If the watchdog has no own ping operation then it needs to be
- *	restarted via the start operation. This wrapper function does
- *	exactly that.
- *	We only ping when the watchdog device is running.
+ * Returns 0 on success, error otherwise.
  */
-
 static int watchdog_ping(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
@@ -231,16 +231,14 @@ static enum hrtimer_restart watchdog_timer_expired(struct hrtimer *timer)
 }
 
 /*
- *	watchdog_start: wrapper to start the watchdog.
- *	@wdd: the watchdog device to start
+ * watchdog_start - wrapper to start the watchdog
+ * @wdd: The watchdog device to start
  *
- *	The caller must hold wd_data->lock.
+ * Start the watchdog if it is not active and mark it active.
+ * The caller must hold wd_data->lock.
  *
- *	Start the watchdog if it is not active and mark it active.
- *	This function returns zero on success or a negative errno code for
- *	failure.
+ * Returns zero on success or a negative errno code for failure.
  */
-
 static int watchdog_start(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
@@ -274,17 +272,15 @@ static int watchdog_start(struct watchdog_device *wdd)
 }
 
 /*
- *	watchdog_stop: wrapper to stop the watchdog.
- *	@wdd: the watchdog device to stop
+ * watchdog_stop - wrapper to stop the watchdog
+ * @wdd: The watchdog device to stop
  *
- *	The caller must hold wd_data->lock.
+ * Stop the watchdog if it is still active and unmark it active.
+ * If the 'nowayout' feature was set, the watchdog cannot be stopped.
+ * The caller must hold wd_data->lock.
  *
- *	Stop the watchdog if it is still active and unmark it active.
- *	This function returns zero on success or a negative errno code for
- *	failure.
- *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
+ * Returns zero on success or a negative errno code for failure.
  */
-
 static int watchdog_stop(struct watchdog_device *wdd)
 {
 	int err = 0;
@@ -315,14 +311,14 @@ static int watchdog_stop(struct watchdog_device *wdd)
 }
 
 /*
- *	watchdog_get_status: wrapper to get the watchdog status
- *	@wdd: the watchdog device to get the status from
+ * watchdog_get_status - wrapper to get the watchdog status
+ * @wdd: The watchdog device to get the status from
  *
- *	The caller must hold wd_data->lock.
+ * Get the watchdog's status flags.
+ * The caller must hold wd_data->lock.
  *
- *	Get the watchdog's status flags.
+ * Returns watchdog's status flags.
  */
-
 static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
@@ -352,13 +348,14 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 }
 
 /*
- *	watchdog_set_timeout: set the watchdog timer timeout
- *	@wdd: the watchdog device to set the timeout for
- *	@timeout: timeout to set in seconds
+ * watchdog_set_timeout - set the watchdog timer timeout
+ * @wdd:	The watchdog device to set the timeout for
+ * @timeout:	Timeout to set in seconds
+ *
+ * The caller must hold wd_data->lock.
  *
- *	The caller must hold wd_data->lock.
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
@@ -385,11 +382,12 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 }
 
 /*
- *	watchdog_set_pretimeout: set the watchdog timer pretimeout
- *	@wdd: the watchdog device to set the timeout for
- *	@timeout: pretimeout to set in seconds
+ * watchdog_set_pretimeout - set the watchdog timer pretimeout
+ * @wdd:	The watchdog device to set the timeout for
+ * @timeout:	pretimeout to set in seconds
+ *
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_set_pretimeout(struct watchdog_device *wdd,
 				   unsigned int timeout)
 {
@@ -410,15 +408,15 @@ static int watchdog_set_pretimeout(struct watchdog_device *wdd,
 }
 
 /*
- *	watchdog_get_timeleft: wrapper to get the time left before a reboot
- *	@wdd: the watchdog device to get the remaining time from
- *	@timeleft: the time that's left
+ * watchdog_get_timeleft - wrapper to get the time left before a reboot
+ * @wdd:	The watchdog device to get the remaining time from
+ * @timeleft:	The time that's left
  *
- *	The caller must hold wd_data->lock.
+ * Get the time before a watchdog will reboot (if not pinged).
+ * The caller must hold wd_data->lock.
  *
- *	Get the time before a watchdog will reboot (if not pinged).
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_get_timeleft(struct watchdog_device *wdd,
 							unsigned int *timeleft)
 {
@@ -635,14 +633,15 @@ __ATTRIBUTE_GROUPS(wdt);
 #endif
 
 /*
- *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
- *	@wdd: the watchdog device to do the ioctl on
- *	@cmd: watchdog command
- *	@arg: argument pointer
+ * watchdog_ioctl_op - call the watchdog drivers ioctl op if defined
+ * @wdd: The watchdog device to do the ioctl on
+ * @cmd: Watchdog command
+ * @arg: Argument pointer
  *
- *	The caller must hold wd_data->lock.
+ * The caller must hold wd_data->lock.
+ *
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 							unsigned long arg)
 {
@@ -653,17 +652,18 @@ static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 }
 
 /*
- *	watchdog_write: writes to the watchdog.
- *	@file: file from VFS
- *	@data: user address of data
- *	@len: length of data
- *	@ppos: pointer to the file offset
+ * watchdog_write - writes to the watchdog
+ * @file:	File from VFS
+ * @data:	User address of data
+ * @len:	Length of data
+ * @ppos:	Pointer to the file offset
  *
- *	A write to a watchdog device is defined as a keepalive ping.
- *	Writing the magic 'V' sequence allows the next close to turn
- *	off the watchdog (if 'nowayout' is not set).
+ * A write to a watchdog device is defined as a keepalive ping.
+ * Writing the magic 'V' sequence allows the next close to turn
+ * off the watchdog (if 'nowayout' is not set).
+ *
+ * Returns @len if successful, error otherwise.
  */
-
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
@@ -706,13 +706,15 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 }
 
 /*
- *	watchdog_ioctl: handle the different ioctl's for the watchdog device.
- *	@file: file handle to the device
- *	@cmd: watchdog command
- *	@arg: argument pointer
+ * watchdog_ioctl - handle the different ioctl's for the watchdog device
+ * @file:	File handle to the device
+ * @cmd:	Watchdog command
+ * @arg:	Argument pointer
  *
- *	The watchdog API defines a common set of functions for all watchdogs
- *	according to their available features.
+ * The watchdog API defines a common set of functions for all watchdogs
+ * according to their available features.
+ *
+ * Returns 0 if successful, error otherwise.
  */
 
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
@@ -819,15 +821,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 }
 
 /*
- *	watchdog_open: open the /dev/watchdog* devices.
- *	@inode: inode of device
- *	@file: file handle to device
+ * watchdog_open - open the /dev/watchdog* devices
+ * @inode:	Inode of device
+ * @file:	File handle to device
+ *
+ * When the /dev/watchdog* device gets opened, we start the watchdog.
+ * Watch out: the /dev/watchdog device is single open, so we make sure
+ * it can only be opened once.
  *
- *	When the /dev/watchdog* device gets opened, we start the watchdog.
- *	Watch out: the /dev/watchdog device is single open, so we make sure
- *	it can only be opened once.
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_open(struct inode *inode, struct file *file)
 {
 	struct watchdog_core_data *wd_data;
@@ -896,15 +899,16 @@ static void watchdog_core_data_release(struct device *dev)
 }
 
 /*
- *	watchdog_release: release the watchdog device.
- *	@inode: inode of device
- *	@file: file handle to device
+ * watchdog_release - release the watchdog device
+ * @inode:	Inode of device
+ * @file:	File handle to device
+ *
+ * This is the code for when /dev/watchdog gets closed. We will only
+ * stop the watchdog when we have received the magic char (and nowayout
+ * was not set), else the watchdog will keep running.
  *
- *	This is the code for when /dev/watchdog gets closed. We will only
- *	stop the watchdog when we have received the magic char (and nowayout
- *	was not set), else the watchdog will keep running.
+ * Always returns 0.
  */
-
 static int watchdog_release(struct inode *inode, struct file *file)
 {
 	struct watchdog_core_data *wd_data = file->private_data;
@@ -977,14 +981,15 @@ static struct class watchdog_class = {
 };
 
 /*
- *	watchdog_cdev_register: register watchdog character device
- *	@wdd: watchdog device
+ * watchdog_cdev_register - register watchdog character device
+ * @wdd: Watchdog device
+ *
+ * Register a watchdog character device including handling the legacy
+ * /dev/watchdog node. /dev/watchdog is actually a miscdevice and
+ * thus we set it up like that.
  *
- *	Register a watchdog character device including handling the legacy
- *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
- *	thus we set it up like that.
+ * Returns 0 if successful, error otherwise.
  */
-
 static int watchdog_cdev_register(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data;
@@ -1074,13 +1079,12 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 }
 
 /*
- *	watchdog_cdev_unregister: unregister watchdog character device
- *	@watchdog: watchdog device
+ * watchdog_cdev_unregister - unregister watchdog character device
+ * @wdd: Watchdog device
  *
- *	Unregister watchdog character device and if needed the legacy
- *	/dev/watchdog device.
+ * Unregister watchdog character device and if needed the legacy
+ * /dev/watchdog device.
  */
-
 static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
@@ -1109,15 +1113,16 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 	put_device(&wd_data->dev);
 }
 
-/*
- *	watchdog_dev_register: register a watchdog device
- *	@wdd: watchdog device
+/**
+ * watchdog_dev_register - register a watchdog device
+ * @wdd: Watchdog device
+ *
+ * Register a watchdog device including handling the legacy
+ * /dev/watchdog node. /dev/watchdog is actually a miscdevice and
+ * thus we set it up like that.
  *
- *	Register a watchdog device including handling the legacy
- *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
- *	thus we set it up like that.
+ * Returns 0 if successful, error otherwise.
  */
-
 int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int ret;
@@ -1133,30 +1138,31 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	return ret;
 }
 
-/*
- *	watchdog_dev_unregister: unregister a watchdog device
- *	@watchdog: watchdog device
+/**
+ * watchdog_dev_unregister - unregister a watchdog device
+ * @wdd: watchdog device
  *
- *	Unregister watchdog device and if needed the legacy
- *	/dev/watchdog device.
+ * Unregister watchdog device and if needed the legacy
+ * /dev/watchdog device.
  */
-
 void watchdog_dev_unregister(struct watchdog_device *wdd)
 {
 	watchdog_unregister_pretimeout(wdd);
 	watchdog_cdev_unregister(wdd);
 }
 
-/*
- *	watchdog_set_last_hw_keepalive: set last HW keepalive time for watchdog
- *	@wdd: watchdog device
- *	@last_ping_ms: time since last HW heartbeat
+/**
+ * watchdog_set_last_hw_keepalive - set last HW keepalive time for watchdog
+ * @wdd:		Watchdog device
+ * @last_ping_ms:	Time since last HW heartbeat
  *
- *	Adjusts the last known HW keepalive time for a watchdog timer.
- *	This is needed if the watchdog is already running when the probe
- *	function is called, and it can't be pinged immediately. This
- *	function must be called immediately after watchdog registration,
- *	and min_hw_heartbeat_ms must be set for this to be useful.
+ * Adjusts the last known HW keepalive time for a watchdog timer.
+ * This is needed if the watchdog is already running when the probe
+ * function is called, and it can't be pinged immediately. This
+ * function must be called immediately after watchdog registration,
+ * and min_hw_heartbeat_ms must be set for this to be useful.
+ *
+ * Returns 0 if successful, error otherwise.
  */
 int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
 				   unsigned int last_ping_ms)
@@ -1180,12 +1186,13 @@ int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_set_last_hw_keepalive);
 
-/*
- *	watchdog_dev_init: init dev part of watchdog core
+/**
+ * watchdog_dev_init - init dev part of watchdog core
  *
- *	Allocate a range of chardev nodes to use for watchdog devices
+ * Allocate a range of chardev nodes to use for watchdog devices.
+ *
+ * Returns 0 if successful, error otherwise.
  */
-
 int __init watchdog_dev_init(void)
 {
 	int err;
@@ -1218,12 +1225,11 @@ int __init watchdog_dev_init(void)
 	return err;
 }
 
-/*
- *	watchdog_dev_exit: exit dev part of watchdog core
+/**
+ * watchdog_dev_exit - exit dev part of watchdog core
  *
- *	Release the range of chardev nodes used for watchdog devices
+ * Release the range of chardev nodes used for watchdog devices.
  */
-
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
-- 
2.33.1

