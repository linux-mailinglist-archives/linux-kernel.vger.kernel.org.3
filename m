Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2CB568580
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGFK0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiGFK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:26:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0B26AD5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:26:30 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 266AQT3u067488;
        Wed, 6 Jul 2022 19:26:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 06 Jul 2022 19:26:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 266AQSCK067485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Jul 2022 19:26:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
Date:   Wed, 6 Jul 2022 19:26:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
 <YsUtBERm94k/iZTy@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YsUtBERm94k/iZTy@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/06 15:34, Greg KH wrote:
> On Wed, Jul 06, 2022 at 03:21:15PM +0900, Tetsuo Handa wrote:
>> How should we fix this problem?
> 
> We can decrease the timeout in usb_stor_msg_common().  I imagine that if
> that timeout is ever hit in this sequence, then all will recover, right?
> Try decreasing it to a sane number and see what happens.

Yes, all recovers with below diff.

------------------------------------------------------------
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1928b3918242..d2a192306e0c 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -164,7 +164,7 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
  
 	/* wait for the completion of the URB */
 	timeleft = wait_for_completion_interruptible_timeout(
-			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
+			&urb_done, timeout ? : 5 * HZ);
  
 	clear_bit(US_FLIDX_URB_ACTIVE, &us->dflags);
 
------------------------------------------------------------

But

>> Anyway,
>>
>>         /*
>>          * Resuming.  We may need to wait for the image device to
>>          * appear.
>>          */
>>         wait_for_device_probe();
>>
>> in snapshot_open() will sleep forever if some device became unresponsive.
>>

wait_for_device_probe() in snapshot_open() was added by commit c751085943362143
("PM/Hibernate: Wait for SCSI devices scan to complete during resume"), and
that commit did not take into account possibility of unresponsive hardware.

   "In addition, if the resume from hibernation is userland-driven, it's
    better to wait for all device probes in the kernel to complete before
    attempting to open the resume device."

It is trivial to make e.g. atomic_read(&probe_count) == 10, which means that
acceptable timeout for usb_stor_msg_common() may be no longer acceptable timeout
for wait_for_device_probe(). Unlike flush_workqueue(), wait_for_device_probe()
can wait forever if new probe requests keep coming in while waiting for existing
probe requests to complete. Therefore, I think we should introduce timeout on
wait_for_device_probe() side as well.

I would like to propose below changes in 3 patches as fixes for this problem.
Since there are 13 wait_for_device_probe() callers, maybe we want both killable
and uninterruptible versions and pass timeout as an argument...

------------------------------------------------------------
 drivers/base/dd.c               |    3 ++-
 drivers/char/misc.c             |    9 ++++++---
 drivers/usb/storage/transport.c |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3fc3b5940bb3..67e08b381ee2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -723,7 +723,8 @@ void wait_for_device_probe(void)
 	flush_work(&deferred_probe_work);
 
 	/* wait for the known devices to complete their probing */
-	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
+	wait_event_killable_timeout(probe_waitqueue,
+				    atomic_read(&probe_count) == 0, 60 * HZ);
 	async_synchronize_full();
 }
 EXPORT_SYMBOL_GPL(wait_for_device_probe);
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141ed5ef3..6430c534a1cb 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -104,7 +104,8 @@ static int misc_open(struct inode *inode, struct file *file)
 	int err = -ENODEV;
 	const struct file_operations *new_fops = NULL;
 
-	mutex_lock(&misc_mtx);
+	if (mutex_lock_killable(&misc_mtx))
+		return -EINTR;
 
 	list_for_each_entry(c, &misc_list, list) {
 		if (c->minor == minor) {
@@ -116,7 +117,8 @@ static int misc_open(struct inode *inode, struct file *file)
 	if (!new_fops) {
 		mutex_unlock(&misc_mtx);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
-		mutex_lock(&misc_mtx);
+		if (mutex_lock_killable(&misc_mtx))
+			return -EINTR;
 
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == minor) {
@@ -178,7 +180,8 @@ int misc_register(struct miscdevice *misc)
 
 	INIT_LIST_HEAD(&misc->list);
 
-	mutex_lock(&misc_mtx);
+	if (mutex_lock_killable(&misc_mtx))
+		return -EINTR;
 
 	if (is_dynamic) {
 		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1928b3918242..d2a192306e0c 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -164,7 +164,7 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
  
 	/* wait for the completion of the URB */
 	timeleft = wait_for_completion_interruptible_timeout(
-			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
+			&urb_done, timeout ? : 60 * HZ);
  
 	clear_bit(US_FLIDX_URB_ACTIVE, &us->dflags);
 
------------------------------------------------------------

