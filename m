Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79A56CC64
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGJCXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:23:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AE2654E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:23:39 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26A2NboS087954;
        Sun, 10 Jul 2022 11:23:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 10 Jul 2022 11:23:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26A2Nb0f087949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 11:23:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
Date:   Sun, 10 Jul 2022 11:23:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 1/4] char: misc: allow calling open() callback without
 misc_mtx held
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

syzbot is reporting hung task at misc_open() [1], for there is a race
window of AB-BA deadlock which involves probe_count variable.

Currently, wait_for_device_probe() from snapshot_open() from misc_open()
can sleep forever with misc_mtx held if probe_count cannot become 0. When
a device is probed, probe_count is incremented before the probe function
starts, and probe_count is decremented after the probe function completed.

When USB storage device "sddr09" is probed by hub_event() work in
usb_hub_wq workqueue, sddr09_probe() is called with elevated probe_count.

Inside sddr09_probe(), usb_stor_msg_common() from usb_stor_ctrl_transfer()
calls wait_for_completion_interruptible_timeout() (w_f_c_i_t() afterward)
with no timeout.

If sddr09 device does not respond (when using real hardware, or cannot
respond when using emulated hardware), w_f_c_i_t() cannot return, which
means that probe_count cannot be decremented.

According to Oliver Neukum, we can't pass some timeout when calling
usb_stor_msg_common() from usb_stor_ctrl_transfer(), for the timeout is
supposed to come from the SCSI layer in the general case.

The reason why syzkaller processes cannot make w_f_c_i_t() return is that,
w_f_c_i_t() can return when a syzkaller process which is emulating a USB
device calls fput() on /dev/raw-gadget due to process termination.

When we run the reproducer, the syzkaller process which is emulating a USB
device cannot call fput() on /dev/raw-gadget because that process is
blocked at mutex_lock(&misc_mtx) in misc_open().

The process which is holding misc_mtx is waiting for probe_count to become
0, but the probe function which is called from hub_event() is waiting for
the processes which are blocked at mutex_lock(&misc_mtx) to call close()
on /dev/raw-gadget. This is the phenomenon syzbot is reporting.

Therefore, as one of steps for making it possible to recover from such
situation, this patch allows miscdev to call its open() callback without
misc_mtx held.

Wedson Almeida Filho worried that this change breaks the invariants of
miscdev that driver's open() callback will not be made after once
misc_deregister() is called. But since /dev/snapshot driver does not call
misc_deregister(), I consider that this change is safe for allowing
snapshot_open() to be called from misc_open() without misc_mtx held.

Note that lock_system_sleep() from snapshot_open() has the same problem
with mutex_lock(&misc_mtx) from misc_open(). This patch alone makes more
hard to debug, for khungtaskd no longer complains about lock_system_sleep()
because lock_system_sleep() sets PF_FREEZER_SKIP flag before calling
mutex_lock(&system_transition_mutex). How to avoid unbounded
uninterruptible sleeping on system_transition_mutex with PF_FREEZER_SKIP
flag set deserves different patches.

Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
Changes in v2:
  Call open() without misc_mtx, instread of making misc_mtx killable.
  Split into 3 (+ 1 optional) patches.

v1 is at at https://lkml.kernel.org/r/72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp .

 drivers/char/misc.c        | 4 ++++
 include/linux/miscdevice.h | 1 +
 kernel/power/user.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..709a902e401b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
 
 	err = 0;
 	replace_fops(file, new_fops);
+	if (c->unlocked_open && file->f_op->open) {
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
index ad241b4ff64c..59912060109f 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -441,6 +441,7 @@ static struct miscdevice snapshot_device = {
 	.minor = SNAPSHOT_MINOR,
 	.name = "snapshot",
 	.fops = &snapshot_fops,
+	.unlocked_open = true, /* Call snapshot_open() with no locks held. */
 };
 
 static int __init snapshot_device_init(void)
-- 
2.18.4

