Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02F5699AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGGFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGGFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:06:43 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABB93121B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:06:41 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26756dcn022539;
        Thu, 7 Jul 2022 14:06:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 07 Jul 2022 14:06:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26756cXP022531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jul 2022 14:06:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <22c61a75-8140-c62d-ffe0-efd6e9fa38ee@I-love.SAKURA.ne.jp>
Date:   Thu, 7 Jul 2022 14:06:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
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
 <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
 <815866b5-842e-4829-5ed8-26a5f1e856a4@suse.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <815866b5-842e-4829-5ed8-26a5f1e856a4@suse.com>
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

On 2022/07/06 20:04, Oliver Neukum wrote:
> 
> 
> On 06.07.22 12:26, Tetsuo Handa wrote:
>> On 2022/07/06 15:34, Greg KH wrote:
>>> On Wed, Jul 06, 2022 at 03:21:15PM +0900, Tetsuo Handa wrote:
>>>> How should we fix this problem?
>>>
>>> We can decrease the timeout in usb_stor_msg_common().  I imagine that if
>>> that timeout is ever hit in this sequence, then all will recover, right?
> 
> Not really. The timeout there is supposed to come from the SCSI layer
> in the general case.

I couldn't catch. usb_stor_msg_common() belongs to USB subsystem, doesn't it?

How does SCSI layer matter here?
Does USB storage device shows up as if SCSI disk (e.g. /dev/sdb) relevant?

>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 3fc3b5940bb3..67e08b381ee2 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -723,7 +723,8 @@ void wait_for_device_probe(void)
>>  	flush_work(&deferred_probe_work);
>>  
>>  	/* wait for the known devices to complete their probing */
>> -	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
>> +	wait_event_killable_timeout(probe_waitqueue,
>> +				    atomic_read(&probe_count) == 0, 60 * HZ);
> 
> You cannot just let a timeout go unreported.

I think regarding snapshot_open() case, being best-effort is acceptable, for
the reason of timeout might be new probe requests kept coming in, even after
the device which snapshot_open() needed to wait already became ready.

> 
>>  	async_synchronize_full();
>>  }
>>  EXPORT_SYMBOL_GPL(wait_for_device_probe);
>> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
>> index ca5141ed5ef3..6430c534a1cb 100644
>> --- a/drivers/char/misc.c
>> +++ b/drivers/char/misc.c
>> @@ -104,7 +104,8 @@ static int misc_open(struct inode *inode, struct file *file)
>>  	int err = -ENODEV;
>>  	const struct file_operations *new_fops = NULL;
>>  
>> -	mutex_lock(&misc_mtx);
>> +	if (mutex_lock_killable(&misc_mtx))
>> +		return -EINTR;
>>  
>>  	list_for_each_entry(c, &misc_list, list) {
>>  		if (c->minor == minor) {
>> @@ -116,7 +117,8 @@ static int misc_open(struct inode *inode, struct file *file)
>>  	if (!new_fops) {
>>  		mutex_unlock(&misc_mtx);
>>  		request_module("char-major-%d-%d", MISC_MAJOR, minor);
>> -		mutex_lock(&misc_mtx);
>> +		if (mutex_lock_killable(&misc_mtx))
>> +			return -EINTR;
>>  
>>  		list_for_each_entry(c, &misc_list, list) {
>>  			if (c->minor == minor) {
>> @@ -178,7 +180,8 @@ int misc_register(struct miscdevice *misc)
>>  
>>  	INIT_LIST_HEAD(&misc->list);
>>  
>> -	mutex_lock(&misc_mtx);
>> +	if (mutex_lock_killable(&misc_mtx))
>> +		return -EINTR;
> 
> This usually runs in the context of a kernel thread, does it not?
> What could kill that?

I think that misc_register() is usually called from module's __init function
which runs in the user context. Though, it would be much better if we can avoid
sleeping operations with misc_mtx held.

> 
>>  
>>  	if (is_dynamic) {
>>  		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
>> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
>> index 1928b3918242..d2a192306e0c 100644
>> --- a/drivers/usb/storage/transport.c
>> +++ b/drivers/usb/storage/transport.c
>> @@ -164,7 +164,7 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
>>   
>>  	/* wait for the completion of the URB */
>>  	timeleft = wait_for_completion_interruptible_timeout(
>> -			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
>> +			&urb_done, timeout ? : 60 * HZ);
> 
> No, I am sorry, but there are SCSI commands that can run for more than
> 60 seconds. Formats, rewinding tapes, ...It seems to me you need to look
> at the SCSI scanning code.

I wonder how SCSI layer matters here.

usb_stor_ctrl_transfer() is not using timeout for unknown reason

  /*
   * Transfer one control message, without timeouts, but allowing early
   * termination.  Return codes are USB_STOR_XFER_xxx.
   */

but I think we should supply timeout in order to handle unresponsive hardware.
Although usb_stor_ctrl_transfer() is called from kernel threads (which usually
do not receive signals), use of wait_for_completion_interruptible_timeout() in
usb_stor_msg_common() suggests that aborting upon timeout is also tolerable.





Let's summarize current location:

(1) Greg wants me to fix snapshot_open() not to sleep for too long, instead of
    making misc_open() killable.

(2) I found snapshot_open() calls wait_for_device_probe() which might sleep
    long enough to consider as hung up due to:

      (a) One of existing probe request got stuck due to unresponsive hardware.

      (b) New probe requests come in before existing probe requests complete.

(3) Because of (2), it is difficult to guarantee snapshot_open() not to sleep for
    too long.

(4) Because of (3), calling file->f_op->open(inode, file) with misc_mtx held can
    block mutex_lock(&misc_mtx) too long. This is the phenomenon syzbot is reporting.

Initial mitigation was to replace mutex_lock(&misc_mtx) with mutex_lock_killable(&misc_mtx)
so that /dev/raw-gadget users can terminate upon SIGKILL and khungtaskd will not complain
about misc_mtx.

Next mitigation was not to call file->f_op->open() with misc_mtx held.
Wedson worried that this approach breaks modules which call misc_deregister(), but
I think we can use this approach for modules which do not need to call misc_deregister()
given that this approach is opt-in basis.

I also think that we can bring wait_for_device_probe() in snapshot_open() to before
lock_system_sleep(), for system_transition_mutex will not be required for waiting for
the image device to appear. If we can accept the "not to call file->f_op->open() with
misc_mtx held" mitigation, wait_for_device_probe() in snapshot_open() can be called
without locks.

Finding universally safe timeout value is beyond what I can do for this report.
Regarding this report, I think we can lower the risk of regression if we apply
timeout for atomic_read(&probe_count) == 0 from only snapshot_open().
Can we make below changes?

------------------------------------------------------------

 drivers/base/dd.c             |   14 ++++++++++++++
 drivers/char/misc.c           |    4 ++++
 include/linux/device/driver.h |    1 +
 include/linux/miscdevice.h    |    1 +
 kernel/power/user.c           |   31 ++++++++++++++++++-------------
 5 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3fc3b5940bb3..60fb22a50a4e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -728,6 +728,20 @@ void wait_for_device_probe(void)
 }
 EXPORT_SYMBOL_GPL(wait_for_device_probe);
 
+void wait_for_device_probe_killable_timeout(unsigned long timeout)
+{
+	/* wait for probe timeout */
+	wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
+
+	/* wait for the deferred probe workqueue to finish */
+	flush_work(&deferred_probe_work);
+
+	/* wait for the known devices to complete their probing */
+	wait_event_killable_timeout(probe_waitqueue,
+				    atomic_read(&probe_count) == 0, timeout);
+	async_synchronize_full();
+}
+
 static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 {
 	int ret = 0;
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141ed5ef3..16601c78fecb 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -137,6 +137,10 @@ static int misc_open(struct inode *inode, struct file *file)
 
 	err = 0;
 	replace_fops(file, new_fops);
+	if (c->unlocked_open && file->f_op->open) {
+		mutex_unlock(&misc_mtx);
+		return file->f_op->open(inode, file);
+	}
 	if (file->f_op->open)
 		err = file->f_op->open(inode, file);
 fail:
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 15e7c5e15d62..324b2866d0f2 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -129,6 +129,7 @@ extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
 extern void wait_for_device_probe(void);
+extern void wait_for_device_probe_killable_timeout(unsigned long timeout);
 
 /* sysfs interface for exporting driver attributes */
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 0676f18093f9..e112ef9e3b7b 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -86,6 +86,7 @@ struct miscdevice  {
 	const struct attribute_group **groups;
 	const char *nodename;
 	umode_t mode;
+	bool unlocked_open;
 };
 
 extern int misc_register(struct miscdevice *misc);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index ad241b4ff64c..1960d05ee439 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -51,35 +51,39 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	switch (filp->f_flags & O_ACCMODE) {
+	case O_RDWR: /* Can't do both at the same time. */
+		return -ENOSYS;
+	case O_RDONLY: /* Hibernating */
+		/* The image device should be already ready. */
+		break;
+	default: /* Resuming */
+		/*
+		 * Since the image device might not be ready, try to wait up to
+		 * 5 minutes. We should not wait forever, for we might get stuck
+		 * due to unresponsive devices and/or new probe events which
+		 * are irrelevant to the image device keep coming in.
+		 */
+		wait_for_device_probe_killable_timeout(300 * HZ);
+		break;
+	}
+
 	lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
 		goto Unlock;
 	}
-
-	if ((filp->f_flags & O_ACCMODE) == O_RDWR) {
-		hibernate_release();
-		error = -ENOSYS;
-		goto Unlock;
-	}
 	nonseekable_open(inode, filp);
 	data = &snapshot_state;
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
-		/* Hibernating.  The image device should be accessible. */
 		data->swap = swap_type_of(swsusp_resume_device, 0);
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
 		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	} else {
-		/*
-		 * Resuming.  We may need to wait for the image device to
-		 * appear.
-		 */
-		wait_for_device_probe();
-
 		data->swap = -1;
 		data->mode = O_WRONLY;
 		error = pm_notifier_call_chain_robust(PM_RESTORE_PREPARE, PM_POST_RESTORE);
@@ -441,6 +445,7 @@ static struct miscdevice snapshot_device = {
 	.minor = SNAPSHOT_MINOR,
 	.name = "snapshot",
 	.fops = &snapshot_fops,
+	.unlocked_open = true, /* Call snapshot_open() with no locks held. */
 };
 
 static int __init snapshot_device_init(void)
------------------------------------------------------------

