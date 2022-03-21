Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384234E2773
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiCUN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347814AbiCUN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:26:48 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3320488B8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:25:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so7368857ilt.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QMr3nEyvbG3K5J289IqeMGPpB3eaTvGJdsuLO/upv7E=;
        b=6PBvWBrNOpeOXTgxnRH2/7vhmIiHSem+lZ9jvGliMrO/CQkmwD4+zXZFOb3PyowYue
         Djqz6kBEekBgF6HDIiBsp7pPF6bUIWc967260g2CPHnJPbO8ROpFUqlqVYl3M14TvDbB
         VvRXsDGnFRNTwnHhj9Shg0hNVvLKA68qiy0YQ1BVnO/0204ID0Q0QhBC7WGt+kLKDcgb
         FdhTPfrO2xXjJxLqHEfx4iwh2tiFCjUQmrE5R7MicjGUhHtWHHxfhvw3id8L2M/xgJzQ
         YhLnlmXOH1AgFL+URSU0vMQQ1ungepb7DU3ZrZ9Pi+j995ZWS8rZIK5Y/gpQZ6yBTZ9A
         ubng==
X-Gm-Message-State: AOAM530LxB81jICj53qtSXNdp0tPmnliNGpz+1NbWIDNXo4s9sEKofKY
        GTuIKUbq4NeQ26wtA6MZBsfnlVc18XgGzm4O23iP1CHDfuyz
X-Google-Smtp-Source: ABdhPJwT7sKbosWnL88cfyX+/GHlWucYKFPOLWzpqvPsOGNtUoa6CaDxnwEGJvo8uoXPg+xgZwqdCYqvUGXqIo/Z3Bo15FB88zB+
MIME-Version: 1.0
X-Received: by 2002:a02:c053:0:b0:321:422d:af71 with SMTP id
 u19-20020a02c053000000b00321422daf71mr2165176jam.238.1647869122183; Mon, 21
 Mar 2022 06:25:22 -0700 (PDT)
Date:   Mon, 21 Mar 2022 06:25:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa07b205daba6d49@google.com>
Subject: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    551acdc3c3d2 Merge tag 'net-5.17-final' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131b279d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dbf961700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f5b119700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163699d700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1363699d700000
console output: https://syzkaller.appspot.com/x/log.txt?x=1563699d700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3f2f/0x56c0 kernel/locking/lockdep.c:4897
Read of size 8 at addr ffff88807bc048a8 by task syz-executor399/3618

CPU: 1 PID: 3618 Comm: syz-executor399 Not tainted 5.17.0-rc8-syzkaller-00045-g551acdc3c3d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __lock_acquire+0x3f2f/0x56c0 kernel/locking/lockdep.c:4897
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:374 [inline]
 post_one_notification.isra.0+0x59/0x830 kernel/watch_queue.c:86
 __post_watch_notification kernel/watch_queue.c:206 [inline]
 __post_watch_notification+0x561/0x840 kernel/watch_queue.c:176
 post_watch_notification include/linux/watch_queue.h:109 [inline]
 notify_key security/keys/internal.h:199 [inline]
 __key_update security/keys/key.c:775 [inline]
 key_create_or_update+0xdbf/0xde0 security/keys/key.c:979
 __do_sys_add_key+0x215/0x430 security/keys/keyctl.c:134
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f53132c8a89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f531327a2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007f5313350428 RCX: 00007f53132c8a89
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 0000000000000000 R08: 00000000fffffffc R09: 0000000000000000
R10: 0000000000000048 R11: 0000000000000246 R12: 00007f5313350420
R13: 00007f531335042c R14: 00007f531331e074 R15: 3a74707972637366
 </TASK>

Allocated by task 3615:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 alloc_pipe_info+0x105/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 3616:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x126/0x160 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xd0/0x390 mm/slub.c:4562
 put_pipe_info fs/pipe.c:711 [inline]
 pipe_release+0x2bf/0x320 fs/pipe.c:734
 __fput+0x286/0x9f0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807bc04800
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 168 bytes inside of
 512-byte region [ffff88807bc04800, ffff88807bc04a00)
The buggy address belongs to the page:
page:ffffea0001ef0100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bc04
head:ffffea0001ef0100 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888010c42dc0
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3609, ts 50514720858, free_ts 25116018184
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x27f/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0xbe1/0x12b0 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc_trace+0x2f8/0x3d0 mm/slub.c:3255
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 alloc_pipe_info+0x105/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 __unfreeze_partials+0x320/0x340 mm/slub.c:2536
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x6d/0x160 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc_trace+0x258/0x3d0 mm/slub.c:3255
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0xc6a/0x1ee0 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x34d/0xf00 security/tomoyo/common.c:2097
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x17f/0x1f0 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x13ce/0x1f80 security/tomoyo/domain.c:879
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
 tomoyo_bprm_check_security+0x121/0x1a0 security/tomoyo/tomoyo.c:91
 security_bprm_check+0x45/0xa0 security/security.c:866
 search_binary_handler fs/exec.c:1715 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve fs/exec.c:1837 [inline]
 bprm_execve+0x732/0x19b0 fs/exec.c:1799
 do_execveat_common+0x5e3/0x780 fs/exec.c:1926
 do_execve fs/exec.c:1994 [inline]
 __do_sys_execve fs/exec.c:2070 [inline]
 __se_sys_execve fs/exec.c:2065 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2065

Memory state around the buggy address:
 ffff88807bc04780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807bc04800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807bc04880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807bc04900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bc04980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
