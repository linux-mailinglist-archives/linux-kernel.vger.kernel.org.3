Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC56CC6B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGJCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiGJCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:25:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916EA1BC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:25:52 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26A2Pp8d088449;
        Sun, 10 Jul 2022 11:25:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 10 Jul 2022 11:25:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26A2PpbT088446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 11:25:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <273ec8c8-8b70-0a0e-4688-5b943ac8e648@I-love.SAKURA.ne.jp>
Date:   Sun, 10 Jul 2022 11:25:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 4/4] PM: hibernate: don't set PF_FREEZER_SKIP flag when
 manipulating /dev/snapshot
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
 <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
In-Reply-To: <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since khungtaskd skips threads with PF_FREEZER_SKIP flag set, currently
we can't report unbounded uninterruptible sleep when something went wrong
while manipulating /dev/snapshot interface.

Let's change snapshot_{open,read,write}() to use mutex_lock_killable()
and change snapshot_release() to use mutex_lock(), so that khungtaskd can
report unbounded uninterruptible sleep, by not setting PF_FREEZER_SKIP
flag.

Since /dev/snapshot is exclusive due to hibernate_acquire(), we could
choose mutex_trylock() for snapshot_{open,read,write}() as with
snapshot_ioctl(). But until we confirm that this patch does not
break something, let's stay mutex_lock_killable().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
This patch is only compile tested. Need to review if somewhere depends
on PF_FREEZER_SKIP flag being set.

 kernel/power/user.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 32dd5a855e8c..9936efa07022 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -68,7 +68,8 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 		break;
 	}
 
-	lock_system_sleep();
+	if (mutex_lock_killable(&system_transition_mutex))
+		return -EINTR;
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -102,7 +103,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->dev = 0;
 
  Unlock:
-	unlock_system_sleep();
+	mutex_unlock(&system_transition_mutex);
 
 	return error;
 }
@@ -111,7 +112,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
 
-	lock_system_sleep();
+	mutex_lock(&system_transition_mutex);
 
 	swsusp_free();
 	data = filp->private_data;
@@ -128,7 +129,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
 
-	unlock_system_sleep();
+	mutex_unlock(&system_transition_mutex);
 
 	return 0;
 }
@@ -140,7 +141,8 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 	ssize_t res;
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	if (mutex_lock_killable(&system_transition_mutex))
+		return -EINTR;
 
 	data = filp->private_data;
 	if (!data->ready) {
@@ -161,7 +163,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		*offp += res;
 
  Unlock:
-	unlock_system_sleep();
+	mutex_unlock(&system_transition_mutex);
 
 	return res;
 }
@@ -173,7 +175,8 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	ssize_t res;
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	if (mutex_lock_killable(&system_transition_mutex))
+		return -EINTR;
 
 	data = filp->private_data;
 
@@ -195,7 +198,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	if (res > 0)
 		*offp += res;
 unlock:
-	unlock_system_sleep();
+	mutex_unlock(&system_transition_mutex);
 
 	return res;
 }
-- 
2.18.4

