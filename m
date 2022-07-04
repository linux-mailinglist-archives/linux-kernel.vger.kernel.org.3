Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553C565584
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiGDMeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiGDMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:34:39 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81BC11C35;
        Mon,  4 Jul 2022 05:34:31 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 264CY90J025967;
        Mon, 4 Jul 2022 21:34:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 04 Jul 2022 21:34:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 264CY8x7025959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jul 2022 21:34:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
Date:   Mon, 4 Jul 2022 21:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YsLIepAXeBKT0AF/@kroah.com>
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

On 2022/07/04 20:01, Greg KH wrote:
> On Mon, Jul 04, 2022 at 07:25:44PM +0900, Tetsuo Handa wrote:
>> On 2022/07/04 16:29, Greg KH wrote:
>>> On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
>>>> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
>>>> misc_open() might sleep for long with misc_mtx held whereas userspace can
>>>> flood with concurrent misc_open() requests. Mitigate this problem by making
>>>> misc_open() and misc_register() killable.
>>>
>>> I do not understand, why not just fix snapshot_open()?  Why add this
>>> complexity to the misc core for a foolish individual misc device?  Why
>>> not add the fix there where it is spinning instead?
>>
>> Quoting an example from [1]. Multiple processes are calling misc_open() and
>> all but one processes are blocked at mutex_lock(&misc_mtx). The one which is
>> not blocked at mutex_lock(&misc_mtx) is also holding system_transition_mutex.
> 
> And that is because of that one misc device, right?  Why not fix that
> instead of papering over the issue in the misc core?

Since "struct file_operations"->open() is allowed to sleep, calling
"struct file_operations"->open() via reassignment by "struct miscdevice"->fops
with locks held can cause problems.

Assuming that this is not a deadlock hidden by device_initialize(), current
mutex_lock(&misc_mtx) is as problematic as major_names_lock mentioned at
https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp .

>> If you don't like mutex_lock_killable(&misc_mtx), we will need to consider moving
>> file->f_op->open() from misc_open() to after mutex_unlock(&misc_mtx).

Below is minimal changes for avoid calling "struct file_operations"->open() with
misc_mtx held. This would be nothing but moving hung task warning from misc_open()
to snapshot_open() (and therefore we would need to introduce killable version of
lock_system_sleep()), but we can avoid making misc_mtx like major_names_lock above.

Greg, can you accept this minimal change?

 drivers/char/misc.c        | 4 ++++
 include/linux/miscdevice.h | 1 +
 kernel/power/user.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..292c86c090b9 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
 
 	err = 0;
 	replace_fops(file, new_fops);
+	if (iter->unlocked_open && file->f_op->open) {
+		mutex_unlock(&misc_mtx);
+		return file->f_op->open(inode, file);
+	}
 	if (file->f_op->open)
 		err = file->f_op->open(inode, file);
 fail:
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
index ad241b4ff64c..69a269c4fb46 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -441,6 +441,7 @@ static struct miscdevice snapshot_device = {
 	.minor = SNAPSHOT_MINOR,
 	.name = "snapshot",
 	.fops = &snapshot_fops,
+	.unlocked_open = true,
 };
 
 static int __init snapshot_device_init(void)
-- 
2.34.1

