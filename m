Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEAB47E7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244819AbhLWS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:57:27 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45645 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLWS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:57:26 -0500
Received: by mail-il1-f200.google.com with SMTP id k14-20020a056e021a8e00b002b4b2388c48so3033880ilv.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4QfJdHTPBSmSFWlluA7AKWA414cNwCLvd7xkMEz+IyU=;
        b=CtIiz1IuI8eqv0aY4vwOYN2M/bgdxqEHEA9jmMz4XPPLH83Nj7bnY5etr2KK4Ojv+u
         GT99p9W7dj4rxuGHFxCtzXTySMk47KnLzbqvKq8PY9r3NLhxe+1b93Uhjdit4H1Xajyc
         5SFnLt6oefuG4o5P4a286EBHzKQewlApqE9T0UPYo+gH5Yg+v+ernb3qNff7Pb4Ej/Dr
         mNCLDdp9Q6pT13x42iiyOHHk3sSvymgC2e2gpI2Lj5xFyTYMj5UaaJ8zMRqpu521pWCN
         wn0oXY+lZXGYTaBmPbArCqsqW/4uo3EHN+40gvJF8dr7NjoGBqd+fP9jgMAzwgBIlws8
         3OLg==
X-Gm-Message-State: AOAM532tfAOiYm90krW4q3TRsbBLEZwH/gCUp3MUETSJj+K+zdO8jEGW
        fubjrlWKo4BsCMf06P96EDfdfYA8LjsYWfxWeLePjthmnX37
X-Google-Smtp-Source: ABdhPJz5s9mJUxF6Ygypl6l5xkRHXmnnj/tGV6owoAeqOz0dCTxZ54a4gtiXBpvPSkczOYCrgXxjxAuqqazhUodpyh3xXN+r0V50
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3815:: with SMTP id i21mr2098283jav.192.1640285845998;
 Thu, 23 Dec 2021 10:57:25 -0800 (PST)
Date:   Thu, 23 Dec 2021 10:57:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e501d05d3d4cfec@google.com>
Subject: [syzbot] INFO: task hung in do_user_addr_fault (2)
From:   syzbot <syzbot+92259878b2d73775f719@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        jnewsome@torproject.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f667b5d4053 Merge tag 'tty-5.16-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a791cdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f3f669b8093e95
dashboard link: https://syzkaller.appspot.com/bug?extid=92259878b2d73775f719
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13713193b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16726993b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92259878b2d73775f719@syzkaller.appspotmail.com

INFO: task syz-executor001:4712 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:26864 pid: 4712 ppid:  3656 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 handle_page_fault arch/x86/mm/fault.c:1485 [inline] arch/x86/mm/fault.c:1541
 exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1541 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7fcd16c65d98
RSP: 002b:00007ffe6651f758 EFLAGS: 00010206
RAX: 00007fcd16c97bd0 RBX: 00007fcd16c96198 RCX: 0000000000000001
RDX: 00007fcd16bd3b90 RSI: 0000000000000000 RDI: 00007fcd16c97bd0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fcd16c9d040 R15: 0000000000000001
 </TASK>
INFO: task syz-executor001:4715 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:25328 pid: 4715 ppid:  3656 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
 do_exit+0x688/0x24f0 kernel/exit.c:819 kernel/exit.c:819
 do_group_exit+0x168/0x2d0 kernel/exit.c:929 kernel/exit.c:929
 get_signal+0x1740/0x2120 kernel/signal.c:2852 kernel/signal.c:2852
 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:868 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 handle_signal_work kernel/entry/common.c:148 [inline] kernel/entry/common.c:207
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline] kernel/entry/common.c:207
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline] kernel/entry/common.c:300
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcd16c10bb9
RSP: 002b:00007fcd16bc2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fcd16c98408 RCX: 00007fcd16c10bb9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcd16c98408
RBP: 00007fcd16c98400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcd16c66074
R13: 00007ffe6651f72f R14: 00007fcd16bc2400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor001:6748 blocked for more than 145 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:26064 pid: 6748 ppid:  3652 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 handle_page_fault arch/x86/mm/fault.c:1485 [inline] arch/x86/mm/fault.c:1541
 exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1541 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7fcd16c65d98
RSP: 002b:00007ffe6651f758 EFLAGS: 00010206
RAX: 00007fcd16c97bd0 RBX: 00007fcd16c96198 RCX: 0000000000000001
RDX: 00007fcd16bd3b90 RSI: 0000000000000000 RDI: 00007fcd16c97bd0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fcd16c9d040 R15: 0000000000000001
 </TASK>
INFO: task syz-executor001:6752 blocked for more than 145 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:25584 pid: 6752 ppid:  3652 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
 do_exit+0x688/0x24f0 kernel/exit.c:819 kernel/exit.c:819
 do_group_exit+0x168/0x2d0 kernel/exit.c:929 kernel/exit.c:929
 get_signal+0x1740/0x2120 kernel/signal.c:2852 kernel/signal.c:2852
 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:868 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 handle_signal_work kernel/entry/common.c:148 [inline] kernel/entry/common.c:207
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline] kernel/entry/common.c:207
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline] kernel/entry/common.c:300
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcd16c10bb9
RSP: 002b:00007fcd16bc2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fcd16c98408 RCX: 00007fcd16c10bb9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcd16c98408
RBP: 00007fcd16c98400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcd16c66074
R13: 00007ffe6651f72f R14: 00007fcd16bc2400 R15: 0000000000022000
 </TASK>
INFO: task syz-executor001:6753 blocked for more than 146 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:25904 pid: 6753 ppid:  3655 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 handle_page_fault arch/x86/mm/fault.c:1485 [inline] arch/x86/mm/fault.c:1541
 exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1541 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7fcd16c65d98
RSP: 002b:00007ffe6651f758 EFLAGS: 00010206
RAX: 00007fcd16c97bd0 RBX: 00007fcd16c96198 RCX: 0000000000000001
RDX: 00007fcd16bd3b90 RSI: 0000000000000000 RDI: 00007fcd16c97bd0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fcd16c9d040 R15: 0000000000000001
 </TASK>
INFO: task syz-executor001:6754 blocked for more than 147 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor001 state:D stack:24880 pid: 6754 ppid:  3655 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_read_slowpath+0x5e2/0xb00 kernel/locking/rwsem.c:1041 kernel/locking/rwsem.c:1041
 __down_read_common+0xaa/0x450 kernel/locking/rwsem.c:1223 kernel/locking/rwsem.c:1223
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
 do_exit+0x688/0x24f0 kernel/exit.c:819 kernel/exit.c:819
 do_group_exit+0x168/0x2d0 kernel/exit.c:929 kernel/exit.c:929
 get_signal+0x1740/0x2120 kernel/signal.c:2852 kernel/signal.c:2852
 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:868 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 handle_signal_work kernel/entry/common.c:148 [inline] kernel/entry/common.c:207
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline] kernel/entry/common.c:207
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline] kernel/entry/common.c:300
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcd16c10bb9
RSP: 002b:00007fcd16bc2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fcd16c98408 RCX: 00007fcd16c10bb9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcd16c98408
RBP: 00007fcd16c98400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcd16c66074
R13: 00007ffe6651f72f R14: 00007fcd16bc2400 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8cb1de40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/3291:
 #0: ffff88814aa90098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113 drivers/tty/n_tty.c:2113
1 lock held by syz-executor001/4712:
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/4715:
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff88807ea6f828 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
2 locks held by syz-executor001/4717:
1 lock held by syz-executor001/6748:
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/6752:
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff888075ebab28 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
2 locks held by syz-executor001/6757:
1 lock held by syz-executor001/6753:
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/6754:
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff888079d00828 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
5 locks held by syz-executor001/6758:
1 lock held by syz-executor001/8306:
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/8307:
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff8880198f4028 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
1 lock held by syz-executor001/8308:
1 lock held by syz-executor001/8311:
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/8312:
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff888019f72428 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
2 locks held by syz-executor001/8313:
2 locks held by kworker/u4:1/8855:
 #0: ffff8880b9a395d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:478 kernel/sched/core.c:478
 #1: ffff8880b9a27888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x4c1/0x780 kernel/sched/psi.c:880 kernel/sched/psi.c:880
1 lock held by syz-executor001/9652:
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] arch/x86/mm/fault.c:1348
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x6cf/0x10c0 arch/x86/mm/fault.c:1348 arch/x86/mm/fault.c:1348
1 lock held by syz-executor001/9653:
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline] kernel/exit.c:483
 #0: ffff88801def0f28 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mm+0xd4/0x2f0 kernel/exit.c:483 kernel/exit.c:483
2 locks held by syz-executor001/9654:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 26 Comm: khungtaskd Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:111 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline] kernel/hung_task.c:295
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline] kernel/hung_task.c:295
 watchdog+0xc82/0xcd0 kernel/hung_task.c:295 kernel/hung_task.c:295
 kthread+0x468/0x490 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8308 Comm: syz-executor001 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kasan_check_range+0x221/0x2f0 mm/kasan/generic.c:189 mm/kasan/generic.c:189
Code: eb 03 4d 89 cf 49 8d 5e 07 4d 85 f6 49 0f 49 de 48 83 e3 f8 49 29 de 74 11 45 0f b6 1f 45 84 db 75 64 49 ff c7 49 ff ce 75 ef <5b> 41 5c 41 5d 41 5e 41 5f c3 45 84 db 75 50 45 8a 59 01 45 84 db
RSP: 0018:ffffc9000bbc78b0 EFLAGS: 00000256
RAX: 1ffff92001778f01 RBX: 0000000000000000 RCX: ffffffff8a147309
RDX: 0000000000000001 RSI: 0000000000000028 RDI: ffffc9000bbc79c0
RBP: ffffc9000bbc79c0 R08: dffffc0000000000 R09: fffff52001778f3d
R10: fffff52001778f3d R11: 0000000000000000 R12: 1ffff92001778f38
R13: dffffc0000000001 R14: 0000000000000005 R15: 0000000000000000
FS:  00007fcd16ba1700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd16c65d98 CR3: 0000000019c3f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 memset+0x1f/0x40 mm/kasan/shadow.c:44 mm/kasan/shadow.c:44
 __mutex_lock_common+0xb9/0x2590 kernel/locking/mutex.c:577 kernel/locking/mutex.c:577
 __mutex_lock kernel/locking/mutex.c:740 [inline]
 __mutex_lock kernel/locking/mutex.c:740 [inline] kernel/locking/mutex.c:792
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792 kernel/locking/mutex.c:792
 perf_mmap+0x5c1/0x1ae0 kernel/events/core.c:6271 kernel/events/core.c:6271
 call_mmap include/linux/fs.h:2167 [inline]
 call_mmap include/linux/fs.h:2167 [inline] mm/mmap.c:1786
 mmap_region+0x104e/0x17e0 mm/mmap.c:1786 mm/mmap.c:1786
 do_mmap+0x88b/0xf30 mm/mmap.c:1575 mm/mmap.c:1575
 vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:519 mm/util.c:519
 ksys_mmap_pgoff+0x499/0x6f0 mm/mmap.c:1623 mm/mmap.c:1623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcd16c10bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd16ba1308 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fcd16c98418 RCX: 00007fcd16c10bb9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007fcd16c98410 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000080011 R11: 0000000000000246 R12: 00007fcd16c66074
R13: 00007ffe6651f72f R14: 00007fcd16ba1400 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	eb 03                	jmp    0x5
   2:	4d 89 cf             	mov    %r9,%r15
   5:	49 8d 5e 07          	lea    0x7(%r14),%rbx
   9:	4d 85 f6             	test   %r14,%r14
   c:	49 0f 49 de          	cmovns %r14,%rbx
  10:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
  14:	49 29 de             	sub    %rbx,%r14
  17:	74 11                	je     0x2a
  19:	45 0f b6 1f          	movzbl (%r15),%r11d
  1d:	45 84 db             	test   %r11b,%r11b
  20:	75 64                	jne    0x86
  22:	49 ff c7             	inc    %r15
  25:	49 ff ce             	dec    %r14
  28:	75 ef                	jne    0x19
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5d                	pop    %r13
  2f:	41 5e                	pop    %r14
  31:	41 5f                	pop    %r15
  33:	c3                   	retq
  34:	45 84 db             	test   %r11b,%r11b
  37:	75 50                	jne    0x89
  39:	45 8a 59 01          	mov    0x1(%r9),%r11b
  3d:	45 84 db             	test   %r11b,%r11b
----------------
Code disassembly (best guess):
   0:	eb 03                	jmp    0x5
   2:	4d 89 cf             	mov    %r9,%r15
   5:	49 8d 5e 07          	lea    0x7(%r14),%rbx
   9:	4d 85 f6             	test   %r14,%r14
   c:	49 0f 49 de          	cmovns %r14,%rbx
  10:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
  14:	49 29 de             	sub    %rbx,%r14
  17:	74 11                	je     0x2a
  19:	45 0f b6 1f          	movzbl (%r15),%r11d
  1d:	45 84 db             	test   %r11b,%r11b
  20:	75 64                	jne    0x86
  22:	49 ff c7             	inc    %r15
  25:	49 ff ce             	dec    %r14
  28:	75 ef                	jne    0x19
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5d                	pop    %r13
  2f:	41 5e                	pop    %r14
  31:	41 5f                	pop    %r15
  33:	c3                   	retq
  34:	45 84 db             	test   %r11b,%r11b
  37:	75 50                	jne    0x89
  39:	45 8a 59 01          	mov    0x1(%r9),%r11b
  3d:	45 84 db             	test   %r11b,%r11b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
