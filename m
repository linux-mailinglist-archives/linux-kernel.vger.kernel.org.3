Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C5529AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiEQHWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:22:21 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963942A3A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:22:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l13-20020a056e0212ed00b002d07cd1db63so7361209iln.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EW5Q6QKsJ+9pJ/H1EnmsJZVigDkNagilqi9r8wZQf8c=;
        b=44ul8s6HuEg/b63HJtGecFiQMzOWmxk3VtQe5rmvvvtmLNVDP7lHdErNf2QVwUN5Q/
         kHABgZ3C9Z/MTVeOfAZzFrwfFQNvO5//KZPLrSw+A7eAF1qpZw9yQqzoOIoaU1gBTenE
         UvjzfSOoo3wgvMIiEmpHSmA7AyXTMukJDho00seQFuBYrdagtohB/wZVewqL+v2hFfxS
         sKY4h9A8+Ec1HuyyVn4lRzf3YpMA4FDb61qmScn6Be3Dpvkp7ZzIna8Eh5GW07CNvfgu
         JD9t2rd0SAVXYy+GoChnZjyoNQnywHOrQKvf8f0BSSeg2uJJnnHz/NtkRp8wFHp3ACkD
         Z13w==
X-Gm-Message-State: AOAM533DDwHONePU2D6vO77qL+zCYJbU6Ib+I5c8U68J9cmzpzqW9+2T
        4HDKaXIo49ctKSmGhAW3VULmjIQyiaKk7ZtRAHHNiKafNB+2
X-Google-Smtp-Source: ABdhPJxNBlC94Li+OwfrMSHh7d5d52CQJhBaXh1yO6XqCJcp9M+IG5Up61bUzX4DRglaLc6Jnho1gM11b9bgUP+UMNHF+trXWBUg
MIME-Version: 1.0
X-Received: by 2002:a92:c262:0:b0:2d1:3722:a3eb with SMTP id
 h2-20020a92c262000000b002d13722a3ebmr1365360ild.270.1652772139941; Tue, 17
 May 2022 00:22:19 -0700 (PDT)
Date:   Tue, 17 May 2022 00:22:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bc82405df30009e@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in binder_ioctl
From:   syzbot <syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com>
To:     arve@android.com, brauner@kernel.org, cmllamas@google.com,
        gregkh@linuxfoundation.org, hridya@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f7bdc402fb0 Add linux-next specific files for 20220516
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105218c6f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=46fff6434a7f968ecb39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11105599f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c7b2b1f00000

The issue was bisected to:

commit bd32889e841c12533d09a1bd02bba932baa9ed8f
Author: Carlos Llamas <cmllamas@google.com>
Date:   Fri Apr 29 23:56:41 2022 +0000

    binder: add BINDER_GET_EXTENDED_ERROR ioctl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1422c845f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1622c845f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1222c845f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")

BUG: sleeping function called from invalid context at lib/usercopy.c:28
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3613, name: syz-executor152
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz-executor152/3613:
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:360 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: _binder_inner_proc_lock drivers/android/binder.c:283 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: binder_ioctl_get_extended_error drivers/android/binder.c:5167 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: binder_ioctl+0x798/0x6d80 drivers/android/binder.c:5390
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3613 Comm: syz-executor152 Not tainted 5.18.0-rc6-next-20220516-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9791
 __might_fault+0x6c/0x170 mm/memory.c:5567
 _copy_to_user+0x25/0x140 lib/usercopy.c:28
 copy_to_user include/linux/uaccess.h:160 [inline]
 binder_ioctl_get_extended_error drivers/android/binder.c:5168 [inline]
 binder_ioctl+0x7aa/0x6d80 drivers/android/binder.c:5390
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f3ae108e059
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff28fbd878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3ae108e059
RDX: 0000000000000000 RSI: 00000000c00c6211 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f3ae10fbe40 R09: 00007f3ae10fbe40
R10: 00007fff28fbd2f0 R11: 0000000000000246 R12: 00007fff28fbd8b0
R13: 00007fff28fbd8a0 R14: 00007fff28fbd890 R15: 0000000000000000
 </TASK>

=============================
[ BUG: Invalid wait context ]
5.18.0-rc6-next-20220516-syzkaller #0 Tainted: G        W        
-----------------------------
syz-executor152/3613 is trying to lock:
ffff888073415f98 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5569
other info that might help us debug this:
context-{4:4}
1 lock held by syz-executor152/3613:
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:360 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: _binder_inner_proc_lock drivers/android/binder.c:283 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: binder_ioctl_get_extended_error drivers/android/binder.c:5167 [inline]
 #0: ffff8880777572f8 (&proc->inner_lock){+.+.}-{2:2}, at: binder_ioctl+0x798/0x6d80 drivers/android/binder.c:5390
stack backtrace:
CPU: 0 PID: 3613 Comm: syz-executor152 Tainted: G        W         5.18.0-rc6-next-20220516-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4705 [inline]
 check_wait_context kernel/locking/lockdep.c:4766 [inline]
 __lock_acquire.cold+0xdb/0x3b4 kernel/locking/lockdep.c:5003
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __might_fault mm/memory.c:5570 [inline]
 __might_fault+0x104/0x170 mm/memory.c:5563
 _copy_to_user+0x25/0x140 lib/usercopy.c:28
 copy_to_user include/linux/uaccess.h:160 [inline]
 binder_ioctl_get_extended_error drivers/android/binder.c:5168 [inline]
 binder_ioctl+0x7aa/0x6d80 drivers/android/binder.c:5390
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f3ae108e059
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff28fbd878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3ae108e059
RDX: 0000000000000000 RSI: 00000000c00c6211 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f3ae10fbe40 R09: 00007f3ae10fbe40
R10: 00007fff28fbd2f0 R11: 0000000000000246 R12: 00007fff28fbd8b0
R13: 00007fff28fbd8a0 R14: 00007fff28fbd890 R15: 0000000000000000
 </TASK>
binder: 3613:3613 ioctl c00c6211 0 returned -14


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
