Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138759B68A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiHUVxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiHUVxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:53:14 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF01DF
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:53:12 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so4595363ioh.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=I9cvlF3dAH21QeNBiSWjTiJJH7zu8EofrAcjoli0A/s=;
        b=QpFEDxxuhbpHv+v8AZHfhtCwZ7nnf8PkkLDz03wRGxCEC8l6lyIuj9R22tTCfwaOlK
         gy9NeOtl5iafQ5K3nbk4lDKW+gABsu6vx6yw7BCEGog03/WPC2p6o1MRdFUQ0GwOeNP6
         Ijt/hqEycDlmc71KN/b4jVpbAplzNyX9V0pEO5xJ+L1d5I23nFeC5YF6o97euy9MdRFS
         5VHS6k8xI9F+ysJv8Af1yk49+GJt71PmHWEB8ka+Y7FKXne/Xk1sq/Q8h1YKsC/IvBrW
         Ucp+o+57RvRzG3iBlLOf2Zab9Gh7SlL6jm4cHsAELx8RF0fq0C57kc4LCwt3gHoPQ3rH
         0kjg==
X-Gm-Message-State: ACgBeo3cIwKCgfpHxw8/xUwxST7bnCikMoC9SA0s1efr0qCdLXjfvybt
        lRvIdONoQPJgDGPfmqpHUoI7NORhxrv9aQn1N0tb0Mtcw7JH
X-Google-Smtp-Source: AA6agR7N+E+wqs8CJETu7AxWQnPCn0S5atqP/txwAdeTfd/RkS45N6q0t88Rv8avEqwk+fwlXv+unwElxUGnaZDs1D+Vd0nS/QhV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:2de:c3b:91d with SMTP id
 n12-20020a056e02148c00b002de0c3b091dmr8589106ilk.95.1661118791913; Sun, 21
 Aug 2022 14:53:11 -0700 (PDT)
Date:   Sun, 21 Aug 2022 14:53:11 -0700
In-Reply-To: <20220821143621.2201-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008597c605e6c75bc9@google.com>
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
From:   syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>
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
INFO: task hung in scsi_remove_host

INFO: task kworker/0:3:3618 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:24680 pid: 3618 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 scsi_remove_host+0x348/0x440 drivers/scsi/hosts.c:199
 quiesce_and_remove_host drivers/usb/storage/usb.c:867 [inline]
 usb_stor_disconnect+0x115/0x260 drivers/usb/storage/usb.c:1087
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:520 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:512
 __device_release_driver drivers/base/dd.c:1209 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1235
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bf88770 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bf88470 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8bf892c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
2 locks held by getty/3283:
 #0: ffff88814ad9e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef0/0x13e0 drivers/tty/n_tty.c:2177
5 locks held by kworker/0:3/3618:
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880174dc138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90003e7fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88802091f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff88802091f190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1bc/0x4610 drivers/usb/core/hub.c:5681
 #3: ffff88814586a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff88814586a190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ed drivers/usb/core/hub.c:2226
 #4: ffff88814586f118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff88814586f118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1038 [inline]
 #4: ffff88814586f118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1232
3 locks held by udevd/4059:
 #0: ffff888026a7fc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:253 [inline]
 #0: ffff888026a7fc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x710 fs/kernfs/file.c:300
 #1: ffff88807f64b578 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:254 [inline]
 #1: ffff88807f64b578 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x710 fs/kernfs/file.c:300
 #2: ffff88814586a190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
 #2: ffff88814586a190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
1 lock held by syz-executor.0/4062:
 #0: ffff8880b9a39f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x46/0x14f lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x206/0x250 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc18/0xf50 kernel/hung_task.c:369
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4062 Comm: syz-executor.0 Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:lockdep_hardirqs_on_prepare+0x47/0x400 kernel/locking/lockdep.c:4279
Code: 83 c0 03 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 7e 02 00 00 44 8b 0d 25 b5 7f 0c 45 85 c9 0f 84 51 01 00 00 65 8b 05 c9 5d a3 7e <a9> 00 00 f0 00 0f 85 3f 01 00 00 65 8b 05 7f 67 a3 7e 85 c0 0f 85
RSP: 0018:ffffc90004bffee8 EFLAGS: 00000002
RAX: 0000000080000000 RBX: 0000000000000002 RCX: 1ffffffff1bbd8d1
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004bfff58 R08: 0000000000000000 R09: 0000000000000001
R10: fffffbfff1bbd25a R11: 0000000000000001 R12: ffffffff897f52f2
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555567fd400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb17f06110 CR3: 000000006e6b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_hardirqs_on+0x2d/0x120 kernel/trace/trace_preemptirq.c:49
 syscall_enter_from_user_mode+0x22/0xb0 kernel/entry/common.c:109
 do_syscall_64+0x16/0xb0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcb16eadfa1
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007ffebaeea3f0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000071 RCX: 00007fcb16eadfa1
RDX: 00007ffebaeea430 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffebaeea4bc R08: 0000000000000000 R09: 00007ffebafb3080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 0000000000039617 R14: 0000000000000000 R15: 00007ffebaeea520
 </TASK>


Tested on:

commit:         15b3f48a Merge tag 'kbuild-fixes-v6.0' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b0fdc3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13779b85080000

