Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65147503D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhLOBE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:04:29 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37448 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhLOBD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:03:27 -0500
Received: by mail-il1-f199.google.com with SMTP id i11-20020a056e0212cb00b002ae39e26bb0so5458016ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n+XTzyE1exgxW+bnlRhpc6/ZDERHoD7mBMA59OHwK14=;
        b=wPBGOF+NxZaTsYdyeYCLP8DSk2A0/9M3Jsr7DUn6Lus8hy/0nuNrFdljn/7t3nZlxS
         UHoQGaikWrgOVa5KS9JTfoMzPZpLebaWqdCqb0xdmupEF6v66fA5BJO8A56kcGkkEcSX
         4jSzLBRYcPTvw67SeqF+++4O6Wew/vi7Sr3jHXD3z7zSce11r6Ng1WE5d8DYexq93tPj
         pdfKxpsPhVqzx1CtMo6Z7mSkJzDQu0gy/LI1iHU5NgLcENzmmoYFx+RFPZAhLemg9/8X
         O/p8cP3b/tHiQz2622uR7i3TuPhOWvyyTUUp7kIHbJ6FBtnlFSBYohhJ8BX/MjaaSnlb
         UVKw==
X-Gm-Message-State: AOAM5306DOnmQ8yEi56fucSszF2AtSqv72TcMg5DlbvZhj8txWtu0DhS
        0cQfJMxTv3haaqScdxTAb9HKVuawin+mQJUkzPrNh/Q8o8IW
X-Google-Smtp-Source: ABdhPJwVQPOGIMu4JXAv0eAo/WZzOu38mkzMoIoraJ4c8VB3Q/TASVE5oMC2eTfRIW5S4kCO7dvOBTl9NX+vpz6IqrGS0QR047SB
MIME-Version: 1.0
X-Received: by 2002:a02:70cf:: with SMTP id f198mr5069777jac.124.1639530206698;
 Tue, 14 Dec 2021 17:03:26 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:03:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091a18b05d324df40@google.com>
Subject: [syzbot] possible deadlock in split_huge_page_to_list
From:   syzbot <syzbot+c915885f05d8e432e7b4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea922272cbe5 Add linux-next specific files for 20211210
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14620bb9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1359a19d2230002
dashboard link: https://syzkaller.appspot.com/bug?extid=c915885f05d8e432e7b4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e100bab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123964db00000

The issue was bisected to:

commit 3ebffc96befbaf9de9297b00d67091bb702fad8e
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sun Jun 28 02:19:08 2020 +0000

    mm: Use multi-index entries in the page cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1276e4bab00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1176e4bab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1676e4bab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c915885f05d8e432e7b4@syzkaller.appspotmail.com
Fixes: 3ebffc96befb ("mm: Use multi-index entries in the page cache")

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc4-next-20211210-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor832/3602 is trying to acquire lock:
ffffffff8bca9b40 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:253 [inline]
ffffffff8bca9b40 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:739 [inline]
ffffffff8bca9b40 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3145 [inline]
ffffffff8bca9b40 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc mm/slub.c:3239 [inline]
ffffffff8bca9b40 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x3e/0x3a0 mm/slub.c:3244

but task is already holding lock:
ffff888011b43cc8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:507 [inline]
ffff888011b43cc8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: split_huge_page_to_list+0x533/0x5440 mm/huge_memory.c:2657

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mapping->i_mmap_rwsem){++++}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1514
       i_mmap_lock_write include/linux/fs.h:492 [inline]
       dma_resv_lockdep+0x362/0x55a drivers/dma-buf/dma-resv.c:713
       do_one_initcall+0x103/0x650 init/main.c:1303
       do_initcall_level init/main.c:1378 [inline]
       do_initcalls init/main.c:1394 [inline]
       do_basic_setup init/main.c:1413 [inline]
       kernel_init_freeable+0x6b1/0x73a init/main.c:1618
       kernel_init+0x1a/0x1d0 init/main.c:1507
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5639 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
       __fs_reclaim_acquire mm/page_alloc.c:4550 [inline]
       fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4564
       might_alloc include/linux/sched/mm.h:253 [inline]
       slab_pre_alloc_hook mm/slab.h:739 [inline]
       slab_alloc_node mm/slub.c:3145 [inline]
       slab_alloc mm/slub.c:3239 [inline]
       kmem_cache_alloc+0x3e/0x3a0 mm/slub.c:3244
       xas_split_alloc+0x142/0x480 lib/xarray.c:1017
       split_huge_page_to_list+0xd35/0x5440 mm/huge_memory.c:2683
       split_huge_page include/linux/huge_mm.h:192 [inline]
       truncate_inode_partial_folio+0xaed/0xe00 mm/truncate.c:275
       shmem_undo_range+0xc43/0x19b0 mm/shmem.c:959
       shmem_truncate_range mm/shmem.c:1037 [inline]
       shmem_fallocate+0xb11/0xe80 mm/shmem.c:2675
       vfs_fallocate+0x48d/0xe10 fs/open.c:308
       ksys_fallocate fs/open.c:331 [inline]
       __do_sys_fallocate fs/open.c:339 [inline]
       __se_sys_fallocate fs/open.c:337 [inline]
       __x64_sys_fallocate+0xcf/0x140 fs/open.c:337
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mapping->i_mmap_rwsem);
                               lock(fs_reclaim);
                               lock(&mapping->i_mmap_rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor832/3602:
 #0: ffff888073d6a460 (sb_writers#3){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:331 [inline]
 #0: ffff888073d6a460 (sb_writers#3){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:339 [inline]
 #0: ffff888073d6a460 (sb_writers#3){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:337 [inline]
 #0: ffff888073d6a460 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_fallocate+0xcf/0x140 fs/open.c:337
 #1: ffff888011b43a70 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:777 [inline]
 #1: ffff888011b43a70 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: shmem_fallocate+0x154/0xe80 mm/shmem.c:2651
 #2: ffff888011b43cc8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:507 [inline]
 #2: ffff888011b43cc8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: split_huge_page_to_list+0x533/0x5440 mm/huge_memory.c:2657

stack backtrace:
CPU: 0 PID: 3602 Comm: syz-executor832 Not tainted 5.16.0-rc4-next-20211210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __fs_reclaim_acquire mm/page_alloc.c:4550 [inline]
 fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4564
 might_alloc include/linux/sched/mm.h:253 [inline]
 slab_pre_alloc_hook mm/slab.h:739 [inline]
 slab_alloc_node mm/slub.c:3145 [inline]
 slab_alloc mm/slub.c:3239 [inline]
 kmem_cache_alloc+0x3e/0x3a0 mm/slub.c:3244
 xas_split_alloc+0x142/0x480 lib/xarray.c:1017
 split_huge_page_to_list+0xd35/0x5440 mm/huge_memory.c:2683
 split_huge_page include/linux/huge_mm.h:192 [inline]
 truncate_inode_partial_folio+0xaed/0xe00 mm/truncate.c:275
 shmem_undo_range+0xc43/0x19b0 mm/shmem.c:959
 shmem_truncate_range mm/shmem.c:1037 [inline]
 shmem_fallocate+0xb11/0xe80 mm/shmem.c:2675
 vfs_fallocate+0x48d/0xe10 fs/open.c:308
 ksys_fallocate fs/open.c:331 [inline]
 __do_sys_fallocate fs/open.c:339 [inline]
 __se_sys_fallocate fs/open.c:337 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6a5c9e8819
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf59ddff8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6a5c9e8819
RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f6a5c9a8390 R08: 0000000000000000 R09: 000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
