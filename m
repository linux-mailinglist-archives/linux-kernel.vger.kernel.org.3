Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D05B2BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIIBhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIIBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:37:49 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205D1153B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:37:30 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y10-20020a5d914a000000b00688fa7b2252so380891ioq.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 18:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZtHKZi9er1ZjEMUmn/+LwojDtY9MogZdu8h8D7swnmI=;
        b=N6QTeMCVYPRfAadfrwUJkp7jp0TgGXUhZcNr39dQb3W0YRMAv6cVYjQU1ktwUgP0F3
         rKCvYC/fycJx/C9mY2FEQY4pG6m4BG8O7IFjVW6/MUGBDRQpxia/rlGV92jto0asciHo
         Nyaf2jtpTL89vC5S7b3FMz7IHEQNF3Hoa8db2I9AhtmCbjpDOBzmw1UBm58BFrsTGAJF
         0VOb5Fr+61Utj1qvQ2PXut0L87fM4QBxZFvgNRSjDBYAMaQwiCNR8f021E6Gw49Hs0wL
         M+cSNqFUxTHopS7W9GjyXhBTO5UeGR3ZtTL4rIZg85GWTdK2kQZ+i0Ou01FfNFYYSXGk
         tc6w==
X-Gm-Message-State: ACgBeo0iRyFElnO4dIJ//LjHYt9ZC7RJvlLoehmVb8KnWYAeW+l/fJWH
        2gI79p1eF2pNpBna1iIb/cmN07QnueYddU3N/lh3IoSNsCzS
X-Google-Smtp-Source: AA6agR7VqVqXT1uyKMf1Wg9Yx7cyTmPcI9kF+5ONziqWQcOIIKnQuWXhOCjGIgFuz88A8Jhm7aQPXN11KsY30JOzYiQIKOv7YZ6Y
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:67d:ae1:1c23 with SMTP id
 b2-20020a05660214c200b0067d0ae11c23mr5468038iow.212.1662687450094; Thu, 08
 Sep 2022 18:37:30 -0700 (PDT)
Date:   Thu, 08 Sep 2022 18:37:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5e00a05e834962e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hugetlb_handle_userfault
From:   syzbot <syzbot+193f9cee8638750b23cf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7726d4c3e60b Merge tag 'gpio-fixes-for-v6.0-rc4' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1106f78b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=892a57667b7af6cf
dashboard link: https://syzkaller.appspot.com/bug?extid=193f9cee8638750b23cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16de5bc5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120307e5080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+193f9cee8638750b23cf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
Read of size 8 at addr ffff888017a60eb0 by task syz-executor225/3606

CPU: 0 PID: 3606 Comm: syz-executor225 Not tainted 6.0.0-rc3-syzkaller-00363-g7726d4c3e60b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_read+0x98/0x450 kernel/locking/rwsem.c:1499
 i_mmap_lock_read include/linux/fs.h:486 [inline]
 hugetlb_handle_userfault+0xf5/0x150 mm/hugetlb.c:5505
 hugetlb_no_page mm/hugetlb.c:5554 [inline]
 hugetlb_fault+0x14cd/0x1aa0 mm/hugetlb.c:5778
 handle_mm_fault+0x640/0x780 mm/memory.c:5149
 do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1488 [inline]
 exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f2ff2164c3b
Code: 00 48 89 94 24 ca 03 00 00 f3 0f 6f 9c 24 c0 03 00 00 f3 0f 6f a4 24 d0 03 00 00 48 89 84 24 e2 03 00 00 48 8d 86 00 20 7a 20 <0f> 11 9e 00 20 7a 20 0f 11 a6 10 20 7a 20 48 8b b4 24 e0 03 00 00
RSP: 002b:00007f2ff2157820 EFLAGS: 00010246
RAX: 00000000207a5e00 RBX: 0000000000000000 RCX: 00180f8000180f80
RDX: 0002912000180f80 RSI: 0000000000003e00 RDI: 0000000000000008
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00007f2ff2157c80 R12: 00000000207a2000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007f2ff2157d80
 </TASK>

Allocated by task 3606:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc_lru+0x255/0x720 mm/slub.c:3275
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 hugetlbfs_alloc_inode+0x88/0x1e0 fs/hugetlbfs/inode.c:1121
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x27/0x270 fs/inode.c:1047
 hugetlbfs_get_inode+0x353/0x5f0 fs/hugetlbfs/inode.c:844
 hugetlb_file_setup+0x13a/0x590 fs/hugetlbfs/inode.c:1486
 ksys_mmap_pgoff+0x184/0x5a0 mm/mmap.c:1578
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 0:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kmem_cache_free+0xeb/0x5b0 mm/slub.c:3551
 i_callback+0x3f/0x70 fs/inode.c:249
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x806/0xdb0 fs/dcache.c:913
 __fput+0x39c/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888017a60ac0
 which belongs to the cache hugetlbfs_inode_cache of size 1248
The buggy address is located 1008 bytes inside of
 1248-byte region [ffff888017a60ac0, ffff888017a60fa0)

The buggy address belongs to the physical page:
page:ffffea00005e9800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17a60
head:ffffea00005e9800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888145a66640
raw: 0000000000000000 0000000080170017 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2981386393, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2103
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc_lru+0x528/0x720 mm/slub.c:3275
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 hugetlbfs_alloc_inode+0x88/0x1e0 fs/hugetlbfs/inode.c:1121
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x27/0x270 fs/inode.c:1047
 hugetlbfs_get_root fs/hugetlbfs/inode.c:803 [inline]
 hugetlbfs_fill_super+0x589/0xad0 fs/hugetlbfs/inode.c:1377
 vfs_get_super fs/super.c:1168 [inline]
 get_tree_nodev+0xcd/0x1d0 fs/super.c:1198
 hugetlbfs_get_tree fs/hugetlbfs/inode.c:1392 [inline]
 hugetlbfs_get_tree+0x1e3/0x2b0 fs/hugetlbfs/inode.c:1387
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 fc_mount+0x13/0xc0 fs/namespace.c:1043
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888017a60d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017a60e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888017a60e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888017a60f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017a60f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
