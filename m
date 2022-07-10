Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC456CC66
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:24:12 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C1A1BC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:24:11 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26A2OADU088041;
        Sun, 10 Jul 2022 11:24:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sun, 10 Jul 2022 11:24:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26A2O9sl088038
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 11:24:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
Date:   Sun, 10 Jul 2022 11:24:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 2/4] PM: hibernate: call wait_for_device_probe() without
 system_transition_mutex held
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
In-Reply-To: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
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

Even with "char: misc: allow calling open() callback without misc_mtx
held", wait_for_device_probe() (w_f_d_p() afterward) from
snapshot_open() can sleep forever if probe_count cannot become 0.

w_f_d_p() in snapshot_open() was added by commit c751085943362143
("PM/Hibernate: Wait for SCSI devices scan to complete during resume"),

   "In addition, if the resume from hibernation is userland-driven, it's
    better to wait for all device probes in the kernel to complete before
    attempting to open the resume device."

but that commit did not take into account possibility of unresponsive
hardware, for the timeout is supposed to come from the SCSI layer in the
general case. syzbot is reporting that USB storage, which is a very tiny
wrapper around the whole SCSI protocol, is failing to apply timeout.

Fortunately, holding system_transition_mutex is not required when waiting
for device probe. Therefore, as one of steps for making it possible to
recover from such situation, this patch changes snapshot_open() to call
w_f_d_p() before calling lock_system_sleep().

Note that the problem that w_f_d_p() can sleep too long to wait remains.
But how to fix that part deserves different patches.

Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/power/user.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 59912060109f..db98a028dfdd 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -51,6 +51,18 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	switch (filp->f_flags & O_ACCMODE) {
+	case O_RDWR: /* Can't do both at the same time. */
+		return -ENOSYS;
+	case O_RDONLY: /* Hibernating */
+		/* The image device should be already ready. */
+		break;
+	default: /* Resuming */
+		/* We may need to wait for the image device to appear. */
+		wait_for_device_probe();
+		break;
+	}
+
 	lock_system_sleep();
 
 	if (!hibernate_acquire()) {
@@ -58,28 +70,16 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 		goto Unlock;
 	}
 
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
-- 
2.18.4

