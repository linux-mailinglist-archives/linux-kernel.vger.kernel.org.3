Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE4D509881
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385480AbiDUHAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385539AbiDUHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:00:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E615820;
        Wed, 20 Apr 2022 23:57:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 16E2F320224F;
        Thu, 21 Apr 2022 02:57:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Apr 2022 02:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1650524228; x=1650610628; bh=Zf2B3llxl7G60fYTjQuglARaaSIr/kGBYE8
        scs0PYVI=; b=Jh5rPdjQKX55R5fZF5dNwbKnmiEUbPzmQppXv4ew7pb2Ogwpy34
        Gu8bwQcpM0xnrhzNOBYpism/9UFPorUt6VKUpQFEiKZMyPW3ABuVwEM27tNfqUFT
        AdEL8p+5yp8wmzeGzKPp+AfLrbqsZ5hpyq2n7SMYUHKHEu/GFGxKyrCqtYSRIEhN
        1DDULMu9c5qR2pkbO0vAeQAk2VvFh+PrB5vBAZpddPpgREa1yyF2VaOJ1emuulVk
        F0lcFn3H5TlSnH/vzEnn8bEMMYf016yT55LZhbVOgFRYkIpg0vgiYawq567L/3BC
        8eyt8sgGIL4/xnlk/FD/Ymat6TcQ1LgabaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650524228; x=1650610628; bh=Zf2B3llxl7G60
        fYTjQuglARaaSIr/kGBYE8scs0PYVI=; b=NOi56ZhY/8GCcINCFRZS7QSdef6C5
        +uT9UTS+detk/eMudny/6l264jYWO75l2OYMpXYbkAA1rbu4Vur4tb8JCruXtv8m
        Wc1Csd5I9n4/3gO+S6LaUJCuzH/bSuor2/XcXh2Vuos/5be534+a8g4Qpzl9308P
        L82IlXQY7/FzjUx2XUa2KTyryBqAWJ0ULFgs3PV7FkqJzFrlfjHPzqP7EP4ZO426
        61gzS6Khw/ryutErPA+agnWaNbsD0wYhzQWEJnDMUa++h6YtqwEOHjKcx9YSI3Ok
        p7vWRWb3d1LEi4/4JQAUB3VTFEmnva1EhTS3Th48GC2vkwT07eOnGi5FA==
X-ME-Sender: <xms:RABhYgZ6WfbpzwNO2n-1y0J-0pJzqcrV4SLaqTY7FcPEsbvhcIWeLQ>
    <xme:RABhYrZ0OEFzc6Ky7kerx3CZ9YTWvX7XYAztqOGM4RSCWXW7uRUPd9ZSQEDBM6I8I
    nXI1nTO850DZZuqQL4>
X-ME-Received: <xmr:RABhYq-NDeF1nQKiOejGygm3QGzmSTNmjUd8iy23JVZWfQIWAVaO23n_yVES7PzhLp3ZESaldb5-rUougdVyB2Q0EpE0PqBM4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeffgeelhfejgedtleelvefhvdeggeehgfekudfhueeludfg
    gedvheffteevgfekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhuthht
    vghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:RABhYqr5R6RjwGxTgO7XiiEx_Q-MAzOqrjM59BKuwO6t6W-03m1zcA>
    <xmx:RABhYrrN721VKasq_vHy5TexMhHve834vF21klLnSloGb3RF6yPM0g>
    <xmx:RABhYoRQTrbqgZh2YDEk2dapnXt--E7yz3PmqOb2DfARwn8f2zAWUg>
    <xmx:RABhYi0YXRs3ZahITco38ehX3KQxU4nQzIh50wsKrS9e8q-dGjK6pQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 02:57:06 -0400 (EDT)
Date:   Thu, 21 Apr 2022 16:57:01 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hidraw - add HIDIOCREVOKE ioctl
Message-ID: <YmEAPZKDisM2HAsG@quokka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need for userspace applications to open HID devices directly.
Use-cases include configuration of gaming mice or direct access to
joystick devices. The latter is currently handled by the uaccess tag in
systemd, other devices include more custom/local configurations or just
sudo.

A better approach is what we already have for evdev devices: give the
application a file descriptor and revoke it when it may no longer access
that device.

This patch is the hidraw equivalent to the EVIOCREVOKE ioctl, see
commit c7dc65737c9a607d3e6f8478659876074ad129b8 for full details.

A draft MR for systemd-logind has been filed here:
https://github.com/systemd/systemd/pull/23140

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Maybe noteworthy: even with logind support this is only the first step of
many. logind only hands the fd to whoever controls the session and the fd will
then have to be passed forward through portals to the application.

 drivers/hid/hidraw.c        | 34 ++++++++++++++++++++++++++++++----
 include/linux/hidraw.h      |  1 +
 include/uapi/linux/hidraw.h |  1 +
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 681614a8302a..3449fe856090 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -42,6 +42,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
+	if (list->revoked)
+		return -ENODEV;
+
 	mutex_lock(&list->read_mutex);
 
 	while (ret == 0) {
@@ -159,9 +162,13 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
+	struct hidraw_list *list = file->private_data;
 	ssize_t ret;
 	down_read(&minors_rwsem);
-	ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
+	if (list->revoked)
+		ret = -ENODEV;
+	else
+		ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
 	up_read(&minors_rwsem);
 	return ret;
 }
@@ -254,7 +261,7 @@ static __poll_t hidraw_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
 		mask |= EPOLLIN | EPOLLRDNORM;
-	if (!list->hidraw->exist)
+	if (!list->hidraw->exist || list->revoked)
 		mask |= EPOLLERR | EPOLLHUP;
 	return mask;
 }
@@ -313,6 +320,9 @@ static int hidraw_fasync(int fd, struct file *file, int on)
 {
 	struct hidraw_list *list = file->private_data;
 
+	if (list->revoked)
+		return -ENODEV;
+
 	return fasync_helper(fd, file, on, &list->fasync);
 }
 
@@ -360,6 +370,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	return 0;
 }
 
+static int hidraw_revoke(struct hidraw_list *list, struct file *file)
+{
+	list->revoked = true;
+
+	return 0;
+}
+
 static long hidraw_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -367,11 +384,12 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 	unsigned int minor = iminor(inode);
 	long ret = 0;
 	struct hidraw *dev;
+	struct hidraw_list *list = file->private_data;
 	void __user *user_arg = (void __user*) arg;
 
 	down_read(&minors_rwsem);
 	dev = hidraw_table[minor];
-	if (!dev || !dev->exist) {
+	if (!dev || !dev->exist || list->revoked) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -409,6 +427,14 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 					ret = -EFAULT;
 				break;
 			}
+		case HIDIOCREVOKE:
+			{
+				if (user_arg)
+					ret = -EINVAL;
+				else
+					ret = hidraw_revoke(list, file);
+				break;
+			}
 		default:
 			{
 				struct hid_device *hid = dev->hid;
@@ -515,7 +541,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
 
-		if (new_head == list->tail)
+		if (list->revoked || new_head == list->tail)
 			continue;
 
 		if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index cd67f4ca5599..18fd30a288de 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -32,6 +32,7 @@ struct hidraw_list {
 	struct hidraw *hidraw;
 	struct list_head node;
 	struct mutex read_mutex;
+	bool revoked;
 };
 
 #ifdef CONFIG_HIDRAW
diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
index 33ebad81720a..d0563f251da5 100644
--- a/include/uapi/linux/hidraw.h
+++ b/include/uapi/linux/hidraw.h
@@ -46,6 +46,7 @@ struct hidraw_devinfo {
 /* The first byte of SOUTPUT and GOUTPUT is the report number */
 #define HIDIOCSOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0B, len)
 #define HIDIOCGOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0C, len)
+#define HIDIOCREVOKE	_IOW('H', 0x0D, int) /* Revoke device access */
 
 #define HIDRAW_FIRST_MINOR 0
 #define HIDRAW_MAX_DEVICES 64
-- 
2.36.0

