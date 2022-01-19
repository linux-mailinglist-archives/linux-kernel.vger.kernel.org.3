Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60E49419A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiASUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:16:28 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37876 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbiASUQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:16:26 -0500
Received: by mail-io1-f71.google.com with SMTP id a10-20020a6b6d0a000000b0060a6d881105so2388292iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d6MjefhtE8rfEyQNPbOEVTICIs+vGPTcysjpTMH9hrE=;
        b=yi+RI46rDMCDTUg/Z1HFHdPu2QZTrMcQr7kiFIUQM4KtRseGrv5LENhtLvCm2q7qKZ
         sFxX2D2vpjJe9xjWcz6OeoHh39gG2duEHfOnhJ7mXsqcru0gY9mzZS+Hjmjd32znDU25
         2DKAX7lMwn33U4+rF0yI/5vNIIOq6H1hizDYXkEIhCgemM2mH6jSzHjpv7RXVB082GxD
         laskKUL/MIfGKMImy8d+3c+DyqvP1O4tEgEBVdLwqYx7ihDtsAkrssOwBeCUPp3xkQOw
         5z5IW9tYMkeWfJORVqwPEAFUX6y4ON+z57fGPUxYP7Qht6MMJpXoTctnxqaIeySiPwiG
         EOkQ==
X-Gm-Message-State: AOAM533FYAXlzOXgGkUBM3nDLUT5DF5sInyCCfiCMqIoN6gxSG51XAVR
        QEWuAx2dPYEqn2TxyznsH6TiYLmboe8Omfdpeqz51ks4bziy
X-Google-Smtp-Source: ABdhPJyQIFRKHOgV0blWJ9ISIhHh+DDByUaEPpkwFx5uuG0krkVpd7eHzBkpyWj10nT22jwsGH8Au133GCjnny4hz/WGt+eZDQHR
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e0a:: with SMTP id o10mr7009384iow.165.1642623385815;
 Wed, 19 Jan 2022 12:16:25 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:16:25 -0800
In-Reply-To: <000000000000d893d805d0def1a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006950ea05d5f50fc9@google.com>
Subject: Re: [syzbot] INFO: task hung in hub_port_init (2)
From:   syzbot <syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6f59bc242877 Add linux-next specific files for 20220118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=173526ffb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13070f40700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com

INFO: task kworker/1:6:3709 blocked for more than 143 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:26416 pid: 3709 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:720
 usb_kill_urb+0x7f/0xa0 drivers/usb/core/urb.c:715
 usb_start_wait_urb+0x24a/0x4c0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 hub_port_init+0x7bd/0x2e80 drivers/usb/core/hub.c:4832
 hub_port_connect drivers/usb/core/hub.c:5287 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 port_event drivers/usb/core/hub.c:5660 [inline]
 hub_event+0x238a/0x44d0 drivers/usb/core/hub.c:5742
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task syz-executor.0:3767 can't die for more than 143 seconds.
task:syz-executor.0  state:D stack:28000 pid: 3767 ppid:  3655 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_release+0x83/0x4b0 drivers/usb/core/devio.c:1075
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff21c603c2b
RSP: 002b:00007ffe6d368d40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007ff21c603c2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007ff21c765960 R08: 0000000000000000 R09: 00007ff21c7680d0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000079a2e
R13: 00007ffe6d368e40 R14: 00007ffe6d368e60 R15: 0000000000000032
 </TASK>
INFO: task syz-executor.0:3767 blocked for more than 143 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28000 pid: 3767 ppid:  3655 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_release+0x83/0x4b0 drivers/usb/core/devio.c:1075
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff21c603c2b
RSP: 002b:00007ffe6d368d40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007ff21c603c2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007ff21c765960 R08: 0000000000000000 R09: 00007ff21c7680d0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000079a2e
R13: 00007ffe6d368e40 R14: 00007ffe6d368e60 R15: 0000000000000032
 </TASK>
INFO: task syz-executor.2:3773 can't die for more than 144 seconds.
task:syz-executor.2  state:D stack:28504 pid: 3773 ppid:  3657 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3be7549f04
RSP: 002b:00007f3be6d0bca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f3be7549f04
RDX: 0000000000028101 RSI: 00007f3be6d0bd40 RDI: 00000000ffffff9c
RBP: 00007f3be6d0bd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffcf9aa18df R14: 00007f3be6d0c300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:3773 blocked for more than 144 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28504 pid: 3773 ppid:  3657 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3be7549f04
RSP: 002b:00007f3be6d0bca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f3be7549f04
RDX: 0000000000028101 RSI: 00007f3be6d0bd40 RDI: 00000000ffffff9c
RBP: 00007f3be6d0bd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffcf9aa18df R14: 00007f3be6d0c300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.3:3778 can't die for more than 144 seconds.
task:syz-executor.3  state:D stack:28504 pid: 3778 ppid:  3654 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1ccb53ef04
RSP: 002b:00007f1ccad00ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f1ccb53ef04
RDX: 0000000000028101 RSI: 00007f1ccad00d40 RDI: 00000000ffffff9c
RBP: 00007f1ccad00d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffee90aa8cf R14: 00007f1ccad01300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.3:3778 blocked for more than 145 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28504 pid: 3778 ppid:  3654 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1ccb53ef04
RSP: 002b:00007f1ccad00ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f1ccb53ef04
RDX: 0000000000028101 RSI: 00007f1ccad00d40 RDI: 00000000ffffff9c
RBP: 00007f1ccad00d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffee90aa8cf R14: 00007f1ccad01300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:3783 can't die for more than 145 seconds.
task:syz-executor.5  state:D stack:28152 pid: 3783 ppid:  3656 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ffbef1d2f04
RSP: 002b:00007ffbee994ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007ffbef1d2f04
RDX: 0000000000028101 RSI: 00007ffbee994d40 RDI: 00000000ffffff9c
RBP: 00007ffbee994d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffedefc73bf R14: 00007ffbee995300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:3783 blocked for more than 145 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:28152 pid: 3783 ppid:  3656 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ffbef1d2f04
RSP: 002b:00007ffbee994ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007ffbef1d2f04
RDX: 0000000000028101 RSI: 00007ffbee994d40 RDI: 00000000ffffff9c
RBP: 00007ffbee994d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffedefc73bf R14: 00007ffbee995300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.1:3790 can't die for more than 145 seconds.
task:syz-executor.1  state:D stack:28504 pid: 3790 ppid:  3659 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb7dbbeaf04
RSP: 002b:00007fb7db3acca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fb7dbbeaf04
RDX: 0000000000028101 RSI: 00007fb7db3acd40 RDI: 00000000ffffff9c
RBP: 00007fb7db3acd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffdd38c69ef R14: 00007fb7db3ad300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.1:3790 blocked for more than 146 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:28504 pid: 3790 ppid:  3659 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb7dbbeaf04
RSP: 002b:00007fb7db3acca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fb7dbbeaf04
RDX: 0000000000028101 RSI: 00007fb7db3acd40 RDI: 00000000ffffff9c
RBP: 00007fb7db3acd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffdd38c69ef R14: 00007fb7db3ad300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:3792 can't die for more than 146 seconds.
task:syz-executor.4  state:D stack:28504 pid: 3792 ppid:  3658 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2ad26daf04
RSP: 002b:00007f2ad1e9cca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f2ad26daf04
RDX: 0000000000028101 RSI: 00007f2ad1e9cd40 RDI: 00000000ffffff9c
RBP: 00007f2ad1e9cd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffd4db79f0f R14: 00007f2ad1e9d300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:3792 blocked for more than 146 seconds.
      Not tainted 5.16.0-next-20220118-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28504 pid: 3792 ppid:  3658 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4e90 kernel/sched/core.c:6296
 schedule+0xd2/0x260 kernel/sched/core.c:6369
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6428
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 device_lock include/linux/device.h:767 [inline]
 usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2ad26daf04
RSP: 002b:00007f2ad1e9cca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f2ad26daf04
RDX: 0000000000028101 RSI: 00007f2ad1e9cd40 RDI: 00000000ffffff9c
RBP: 00007f2ad1e9cd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000028101
R13: 00007ffd4db79f0f R14: 00007f2ad1e9d300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83520 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
2 locks held by getty/3291:
 #0: ffff88814aeb3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b632e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077
5 locks held by kworker/1:6/3709:
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888013392938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90002c7fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #2: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x44d0 drivers/usb/core/hub.c:5688
 #3: ffff88801dc55580 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3091 [inline]
 #3: ffff88801dc55580 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5254 [inline]
 #3: ffff88801dc55580 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 #3: ffff88801dc55580 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5660 [inline]
 #3: ffff88801dc55580 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x1fba/0x44d0 drivers/usb/core/hub.c:5742
 #4: ffff88801d301868 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5255 [inline]
 #4: ffff88801d301868 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 #4: ffff88801d301868 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5660 [inline]
 #4: ffff88801d301868 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x1fe3/0x44d0 drivers/usb/core/hub.c:5742
1 lock held by syz-executor.0/3767:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_release+0x83/0x4b0 drivers/usb/core/devio.c:1075
1 lock held by syz-executor.2/3773:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
1 lock held by syz-executor.3/3778:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
1 lock held by syz-executor.5/3783:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
1 lock held by syz-executor.1/3790:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030
1 lock held by syz-executor.4/3792:
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:767 [inline]
 #0: ffff88801dc51220 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x19d/0x920 drivers/usb/core/devio.c:1030

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.16.0-next-20220118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:256 [inline]
 watchdog+0xcb7/0xed0 kernel/hung_task.c:413
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3269 Comm: kworker/0:3 Not tainted 5.16.0-next-20220118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:mark_lock+0x30/0x17b0 kernel/locking/lockdep.c:4566
Code: 41 54 41 89 d4 48 ba 00 00 00 00 00 fc ff df 55 53 48 81 ec 18 01 00 00 48 8d 5c 24 38 48 89 3c 24 48 c7 44 24 38 b3 8a b5 41 <48> c1 eb 03 48 c7 44 24 40 28 3c 3a 8b 48 8d 04 13 48 c7 44 24 48
RSP: 0018:ffffc90002c9f938 EFLAGS: 00000092
RAX: 0000000000000004 RBX: ffffc90002c9f970 RCX: 1ffffffff1ffb5ee
RDX: dffffc0000000000 RSI: ffff8880206c8a90 RDI: ffff8880206c8000
RBP: 0000000000000006 R08: 0000000000000000 R09: ffffffff8ffd2957
R10: 0000000000000001 R11: 0000000000088078 R12: 0000000000000006
R13: dffffc0000000000 R14: ffff8880206c8a68 R15: ffff888077ad2000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fac04558600 CR3: 000000000b88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:4206
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4232 [inline]
 lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4292 [inline]
 lockdep_hardirqs_on_prepare+0x28b/0x400 kernel/locking/lockdep.c:4244
 trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
 kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:231
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xce/0x380 mm/slub.c:4562
 skb_free_head net/core/skbuff.c:655 [inline]
 skb_release_data+0x718/0x870 net/core/skbuff.c:677
 skb_release_all net/core/skbuff.c:742 [inline]
 __kfree_skb net/core/skbuff.c:756 [inline]
 consume_skb net/core/skbuff.c:914 [inline]
 consume_skb+0xc2/0x160 net/core/skbuff.c:908
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:818 [inline]
 nsim_dev_trap_report_work+0x85d/0xbc0 drivers/net/netdevsim/dev.c:843
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	41 54                	push   %r12
   2:	41 89 d4             	mov    %edx,%r12d
   5:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
   c:	fc ff df
   f:	55                   	push   %rbp
  10:	53                   	push   %rbx
  11:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
  18:	48 8d 5c 24 38       	lea    0x38(%rsp),%rbx
  1d:	48 89 3c 24          	mov    %rdi,(%rsp)
  21:	48 c7 44 24 38 b3 8a 	movq   $0x41b58ab3,0x38(%rsp)
  28:	b5 41
* 2a:	48 c1 eb 03          	shr    $0x3,%rbx <-- trapping instruction
  2e:	48 c7 44 24 40 28 3c 	movq   $0xffffffff8b3a3c28,0x40(%rsp)
  35:	3a 8b
  37:	48 8d 04 13          	lea    (%rbx,%rdx,1),%rax
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	44 24 48             	rex.R and $0x48,%al

