Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE19463578
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbhK3Ndk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhK3Ndh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:33:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C8C061574;
        Tue, 30 Nov 2021 05:30:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 291F51F450B0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638279017; bh=Vsyp7uxyLZ4yARfIoRsyLlOjj62nVul7yVRZ95AsIZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6mX5fqrAXZW5sWhzu+GIWzu+Xfelv/bAVOUXtMQbJJN+DxX+pkAG33DEiHuO2Mxw
         qHru2RrtXADsnR0JzVvBaiHqu4gtSB+ty0VdaRjc99fRVtUWrq2EqbyRJgF26vG+FT
         fFasu/Z1ItRlhggJG7hAn2U9yzbiEYeGN3z3Uk5CfJWGaqO/1mdW4qNFf/ScGZaiiR
         Aerds/+LzPBnAE+eQ/KL3nqe/Z5swTgLgLpXcFva550pvp7CzoZ3rpX9cxSNdckncG
         dFCri6Z1Eqqe6wqjoMdkntJWUUcDZeRRM4nsNsJItEtwvQ58TIJ+OFSrvOTQvMuEdx
         VH74sQ+jkOIyg==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/1] HID: hidraw: Replace hidraw device table mutex with a rwsem
Date:   Tue, 30 Nov 2021 10:29:57 -0300
Message-Id: <20211130132957.8480-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211130132957.8480-1-andrealmeid@collabora.com>
References: <20211130132957.8480-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the table that stores information about the connected hidraw
devices has a mutex to prevent concurrent hidraw users to manipulate the
hidraw table (e.g. delete an entry) while someone is trying to use
the table (e.g. issuing an ioctl to the device), preventing the kernel
to referencing a NULL pointer. However, since that every user that wants
to access the table for both manipulating it and reading it content,
this prevents concurrent access to the table for read-only operations
for different or the same device (e.g. two hidraw ioctls can't happen at
the same time, even if they are completely unrelated).

This proves to be a bottleneck and gives performance issues when using
multiple HID devices at same time, like VR kits where one can have two
controllers, the headset and some tracking sensors.

To improve the performance, replace the table mutex with a read-write
semaphore, enabling multiple threads to issue parallel syscalls to
multiple devices at the same time while protecting the table for
concurrent modifications.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/hid/hidraw.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 79faac87a06f..681614a8302a 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -34,7 +34,7 @@ static int hidraw_major;
 static struct cdev hidraw_cdev;
 static struct class *hidraw_class;
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
-static DEFINE_MUTEX(minors_lock);
+static DECLARE_RWSEM(minors_rwsem);
 
 static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
@@ -107,7 +107,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	__u8 *buf;
 	int ret = 0;
 
-	lockdep_assert_held(&minors_lock);
+	lockdep_assert_held(&minors_rwsem);
 
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		ret = -ENODEV;
@@ -160,9 +160,9 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
 	ssize_t ret;
-	mutex_lock(&minors_lock);
+	down_read(&minors_rwsem);
 	ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
-	mutex_unlock(&minors_lock);
+	up_read(&minors_rwsem);
 	return ret;
 }
 
@@ -182,7 +182,7 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	int ret = 0, len;
 	unsigned char report_number;
 
-	lockdep_assert_held(&minors_lock);
+	lockdep_assert_held(&minors_rwsem);
 
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		ret = -ENODEV;
@@ -272,7 +272,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	mutex_lock(&minors_lock);
+	down_read(&minors_rwsem);
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		err = -ENODEV;
 		goto out_unlock;
@@ -301,7 +301,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	file->private_data = list;
 out_unlock:
-	mutex_unlock(&minors_lock);
+	up_read(&minors_rwsem);
 out:
 	if (err < 0)
 		kfree(list);
@@ -347,7 +347,7 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	struct hidraw_list *list = file->private_data;
 	unsigned long flags;
 
-	mutex_lock(&minors_lock);
+	down_write(&minors_rwsem);
 
 	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
 	list_del(&list->node);
@@ -356,7 +356,7 @@ static int hidraw_release(struct inode * inode, struct file * file)
 
 	drop_ref(hidraw_table[minor], 0);
 
-	mutex_unlock(&minors_lock);
+	up_write(&minors_rwsem);
 	return 0;
 }
 
@@ -369,7 +369,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 	struct hidraw *dev;
 	void __user *user_arg = (void __user*) arg;
 
-	mutex_lock(&minors_lock);
+	down_read(&minors_rwsem);
 	dev = hidraw_table[minor];
 	if (!dev || !dev->exist) {
 		ret = -ENODEV;
@@ -487,7 +487,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 		ret = -ENOTTY;
 	}
 out:
-	mutex_unlock(&minors_lock);
+	up_read(&minors_rwsem);
 	return ret;
 }
 
@@ -546,7 +546,7 @@ int hidraw_connect(struct hid_device *hid)
 
 	result = -EINVAL;
 
-	mutex_lock(&minors_lock);
+	down_write(&minors_rwsem);
 
 	for (minor = 0; minor < HIDRAW_MAX_DEVICES; minor++) {
 		if (hidraw_table[minor])
@@ -557,7 +557,7 @@ int hidraw_connect(struct hid_device *hid)
 	}
 
 	if (result) {
-		mutex_unlock(&minors_lock);
+		up_write(&minors_rwsem);
 		kfree(dev);
 		goto out;
 	}
@@ -567,7 +567,7 @@ int hidraw_connect(struct hid_device *hid)
 
 	if (IS_ERR(dev->dev)) {
 		hidraw_table[minor] = NULL;
-		mutex_unlock(&minors_lock);
+		up_write(&minors_rwsem);
 		result = PTR_ERR(dev->dev);
 		kfree(dev);
 		goto out;
@@ -583,7 +583,7 @@ int hidraw_connect(struct hid_device *hid)
 	dev->exist = 1;
 	hid->hidraw = dev;
 
-	mutex_unlock(&minors_lock);
+	up_write(&minors_rwsem);
 out:
 	return result;
 
@@ -594,11 +594,11 @@ void hidraw_disconnect(struct hid_device *hid)
 {
 	struct hidraw *hidraw = hid->hidraw;
 
-	mutex_lock(&minors_lock);
+	down_write(&minors_rwsem);
 
 	drop_ref(hidraw, 1);
 
-	mutex_unlock(&minors_lock);
+	up_write(&minors_rwsem);
 }
 EXPORT_SYMBOL_GPL(hidraw_disconnect);
 
-- 
2.34.1

