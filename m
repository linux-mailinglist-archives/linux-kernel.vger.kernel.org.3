Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361AE59B403
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiHUNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHUNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 09:42:33 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA21922BEC
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 06:42:31 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso4485929ioe.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 06:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=m3K62cQyZ7sXNfXSMd/WMSCaclYwRBArDO/QBjrIWyk=;
        b=1zTnbnzw0fcAkgkMPLg+IWHcB3fnd3jTIg/wHYVxxSd+UpaCjhYXo1LFDfWl+Pb/Vy
         35j5iDzhgK4XnN0AFDM71dNhOMPp6SNiNEAcLMej6FKiUYYgaL2yfDvZxTYBZ+a/puyS
         u6AM4yXyQXU3RVhkWSLR3PU4kvFWsQ+xPKvCwWIGVAaJe6UNjScm4Yry1aYlnTethqGr
         QoQsclEwnXlt6pW9bVsNzpTxctxbuVz0A5NnpfME5xXThPCwjee0JQNoMWN5HhO4E4U0
         4r0Tg7r7stPUAyKfu1S/lB2nxH39/qn103HBLCB59HRtnMhy+EiRWvGM3fmzoHCl0/db
         wqkQ==
X-Gm-Message-State: ACgBeo31+bx4TmzNfD6nvoDkpmmrG1jhnOVnK4lZChDT8SuRNBf/r0eJ
        qcgUwkHM5bf1f6BDtrWQiiZAe0/CjKRRDzprctdm71hT6tH2
X-Google-Smtp-Source: AA6agR4I1Fmni6h7lRUitCyutuKn29uUlU7ByVVJ6oXxN2a0tNGpV1BL7S9sZwkkiXQQwS8KXcb5gNpw5tIB0uYh8t8N3purt0iv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180c:b0:2e9:59fe:23b9 with SMTP id
 a12-20020a056e02180c00b002e959fe23b9mr4139613ilv.10.1661089351010; Sun, 21
 Aug 2022 06:42:31 -0700 (PDT)
Date:   Sun, 21 Aug 2022 06:42:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5187d05e6c08086@google.com>
Subject: [syzbot] INFO: task hung in scsi_remove_host
From:   syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>
To:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
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

syzbot found the following issue on:

HEAD commit:    15b3f48a4339 Merge tag 'kbuild-fixes-v6.0' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f72c47080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1503c1f3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11559fc3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com

INFO: task kworker/1:3:3625 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:24520 pid: 3625 ppid:     2 flags:0x00004000
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
2 locks held by getty/3285:
 #0: ffff8880271c8098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef0/0x13e0 drivers/tty/n_tty.c:2177
3 locks held by udevd/3620:
 #0: ffff8880247cd488 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:253 [inline]
 #0: ffff8880247cd488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x710 fs/kernfs/file.c:300
 #1: ffff888025a62008 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:254 [inline]
 #1: ffff888025a62008 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x710 fs/kernfs/file.c:300
 #2: ffff888145fa8190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
 #2: ffff888145fa8190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
5 locks held by kworker/1:3/3625:
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880178f4d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000391fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888021892190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888021892190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1bc/0x4610 drivers/usb/core/hub.c:5681
 #3: ffff888145fa8190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888145fa8190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ed drivers/usb/core/hub.c:2226
 #4: ffff888145e08118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888145e08118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1038 [inline]
 #4: ffff888145e08118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1232

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339 #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3612 Comm: syz-executor262 Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:226 [inline]
RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:227 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4752 [inline]
RIP: 0010:__lock_acquire+0x6f0/0x56d0 kernel/locking/lockdep.c:5003
Code: 8e af 27 00 00 0f b7 53 20 66 81 e2 ff 1f 0f b7 da be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 40 d9 8d 90 e8 50 49 69 00 <48> 0f a3 1d 18 bd 2e 0f 0f 82 3f ff ff ff 48 c7 c0 c0 d8 1a 91 48
RSP: 0018:ffffc9000383f9d8 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 00000000000000a1 RCX: ffffffff815f1c20
RDX: fffffbfff211bb2b RSI: 0000000000000008 RDI: ffffffff908dd950
RBP: 0000000000000004 R08: 0000000000000000 R09: ffffffff908dd957
R10: fffffbfff211bb2a R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801f27bb00 R14: ffff88801f27c578 R15: dffffc0000000000
FS:  0000555555da6300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f926af390f1 CR3: 000000001d660000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 rcu_lock_acquire include/linux/rcupdate.h:280 [inline]
 rcu_read_lock include/linux/rcupdate.h:706 [inline]
 __task_pid_nr_ns+0x3d/0x4b0 kernel/pid.c:497
 task_pid_nr_ns include/linux/sched.h:1557 [inline]
 send_signal_locked+0x398/0x700 kernel/signal.c:1247
 do_notify_parent_cldstop+0x9a5/0xa40 kernel/signal.c:2185
 ptrace_stop.part.0+0x834/0xa80 kernel/signal.c:2293
 ptrace_stop kernel/signal.c:2232 [inline]
 ptrace_do_notify+0x215/0x2b0 kernel/signal.c:2344
 ptrace_notify+0xc4/0x140 kernel/signal.c:2356
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f926af2cb8a
Code: 83 ff 03 74 3b 48 83 ec 28 b8 fa ff ff ff 83 ff 02 49 89 ca 0f 44 f8 64 8b 04 25 18 00 00 00 85 c0 75 2d b8 e6 00 00 00 0f 05 <89> c2 f7 da 3d 00 f0 ff ff b8 00 00 00 00 0f 47 c2 48 83 c4 28 c3
RSP: 002b:00007ffefe88cd30 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: 0000000000000000 RBX: 000000000003da83 RCX: 00007f926af2cb8a
RDX: 00007ffefe88cd70 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000eb7 R08: 00000000000000fe R09: 00007ffefe981080
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffefe88cdac
R13: 431bde82d7b634db R14: 00007ffefe88cdd0 R15: 00007ffefe88cdb0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
