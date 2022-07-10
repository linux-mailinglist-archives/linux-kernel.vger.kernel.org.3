Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF956CC67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:25:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6AA1B7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:25:13 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26A2PB5m088316;
        Sun, 10 Jul 2022 11:25:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sun, 10 Jul 2022 11:25:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26A2PBf0088313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 11:25:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
Date:   Sun, 10 Jul 2022 11:25:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 3/4] PM: hibernate: allow wait_for_device_probe() to
 timeout when resuming from hibernation
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
In-Reply-To: <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
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
held" and "PM: hibernate: call wait_for_device_probe() without
system_transition_mutex held", wait_for_device_probe() from snapshot_open()
can sleep forever if probe_count cannot become 0.

Since snapshot_open() is a userland-driven hibernation/resume request,
it should be acceptable to fail if something is wrong. Users would not
want to wait for hours if device stopped responding. Therefore, introduce
killable version of wait_for_device_probe() with timeout.

According to Oliver Neukum, there are SCSI commands that can run for more
than 60 seconds. Therefore, this patch choose 5 minutes for timeout.

Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/base/dd.c             | 14 ++++++++++++++
 include/linux/device/driver.h |  1 +
 kernel/power/user.c           |  9 +++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 70f79fc71539..3136b8403bb0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -724,6 +724,20 @@ void wait_for_device_probe(void)
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
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7acaabde5396..4ee909144470 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -129,6 +129,7 @@ extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
 extern void wait_for_device_probe(void);
+extern void wait_for_device_probe_killable_timeout(unsigned long timeout);
 void __init wait_for_init_devices_probe(void);
 
 /* sysfs interface for exporting driver attributes */
diff --git a/kernel/power/user.c b/kernel/power/user.c
index db98a028dfdd..32dd5a855e8c 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -58,8 +58,13 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 		/* The image device should be already ready. */
 		break;
 	default: /* Resuming */
-		/* We may need to wait for the image device to appear. */
-		wait_for_device_probe();
+		/*
+		 * Since the image device might not be ready, try to wait up to
+		 * 5 minutes. We should not wait forever, for we might get stuck
+		 * due to unresponsive devices and/or new probe events which
+		 * are irrelevant to the image device keep coming in.
+		 */
+		wait_for_device_probe_killable_timeout(300 * HZ);
 		break;
 	}
 
-- 
2.18.4

