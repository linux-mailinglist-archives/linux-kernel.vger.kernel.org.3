Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01225ABB9C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiICAVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiICAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:21:15 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD1F61BC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:21:14 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l15-20020a0566022dcf00b00688e70a26deso2232346iow.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R4kxorsb0UegzTakN74D8817HQJ9eZIA49uSeHxOMJc=;
        b=TttfmpOJSx1NIwqpyPuabH+5o3/74pbZkh6UCDdUUf7yqqWPY2JmOjlFhbMGNoc/4V
         m7wXYqFzgRJnq8hbXQMDtq4C8ecFFNT/EJQsLCXjV+p2C5IRvICeipgFWUOe6bZxC2Ao
         EOPtw0/tZ/31SM4xoBls/8iflPqXH0WCeSx4yDdlPMkQR8F9x6QvqAhPSpi1pvihaxw2
         g6lnIM0LcaXHyoQHkSEj8qAGQbz/O8q31RzOXwAp44HFhNIOauppCBQUvnrcPzIjpxSV
         ibUTEA3PRkYr0IzlMiwq2LBr4nGvRzKT+QMQfHdxB4HQaEVwGOKeFI9r4DfGPIbTX5/7
         usng==
X-Gm-Message-State: ACgBeo3s8aVMSZZqe7Zk7XYebKaXRiUDcoaT5g8XUj1rQoRsRFlTJ9wG
        PqrH0Zgf9Zg5lbINRdsQVyWYNxGZvEfZkUtlQfG1Kdp/UVWZ
X-Google-Smtp-Source: AA6agR7Tn3BK7/RRBjnqX4a9aJMK/gdGLgOr40uzBdemnwAn/RuJeUw5JUTD7TWImJF4YgP8qIBcuRChOIvOMp7ITg2GYF9IG6Rh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410f:b0:34a:811:c64b with SMTP id
 ay15-20020a056638410f00b0034a0811c64bmr21911989jab.189.1662164473814; Fri, 02
 Sep 2022 17:21:13 -0700 (PDT)
Date:   Fri, 02 Sep 2022 17:21:13 -0700
In-Reply-To: <20220902235427.2189-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000524af05e7bad379@google.com>
Subject: Re: [syzbot] INFO: task hung in blk_freeze_queue (3)
From:   syzbot <syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blkdev_put

INFO: task syz-executor.0:3518 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc3-syzkaller-00299-gd895ec7938c4-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:    0 pid: 3518 ppid:  3499 flags:0x0000000d
Call trace:
 __switch_to+0x180/0x28c arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x570 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6629
 __mutex_lock_common+0x74c/0xc28 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 blkdev_put+0x78/0x270 block/bdev.c:910
 blkdev_close+0x24/0x38 block/fops.c:499
 __fput+0x198/0x3bc fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:353
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 get_signal+0xac8/0xb30 kernel/signal.c:2634
 do_signal+0x128/0x424 arch/arm64/kernel/signal.c:1071
 do_notify_resume+0xc0/0x1d0 arch/arm64/kernel/signal.c:1124
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/10:
 #0: ffff80000d4a3568 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/11:
 #0: ffff80000d4a3bb8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/26:
 #0: ffff80000d4a3440 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:279
2 locks held by getty/2709:
 #0: ffff0000c6c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f67e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x88c drivers/tty/n_tty.c:2177
1 lock held by udevd/3495:
 #0: ffff0000c4b1e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:812
1 lock held by syz-executor.0/3518:
 #0: ffff0000c4b1e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x78/0x270 block/bdev.c:910
1 lock held by syz-executor.0/3553:
 #0: ffff0000c4b1e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:812
1 lock held by syz-executor.0/3579:
 #0: ffff0000c4b1e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:812

=============================================



Tested on:

commit:         d895ec79 Merge tag 'block-6.0-2022-09-02' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=134b2be7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=38e6c55d4969a14c1534
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ca9c55080000

