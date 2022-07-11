Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640956D4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiGKGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGKGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:41:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39760167CD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:41:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id a23-20020a5d9597000000b00678d2dbf957so2229149ioo.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jEtPsZ71e8la7mMUwAKneUEqUuftnUjt58BQdp8JnXE=;
        b=qnoJ6UKALgq8J9+Ix8gOD97uIUCjyUdYjY816Md84mdhlSoht+scs+5swod+fHaiNr
         rt3x+z7WgI5k3eQFFYabVHfErN3e8aGAW/aizLN+IHIirDbI3eGIeIYq1qgwcj+LryyR
         ygJM/6szeH27NwbUdrMEVx4XkRH4cY9HYIynp7ggUXCs6kmIKXYUC1pTpjApEefzu3TQ
         qX0nzH0cYT/R3dJYGmP0w1dkFYe4YnEVD55VMcf3x5kfAcCgL454NB9sQKK4fNAPE5pL
         vWaM0caYDv9JHL0OMDXAT0bMN64rRhwzDJqsMwnBI6nKWfUAmrGWgctheHDWlUcH769z
         zYog==
X-Gm-Message-State: AJIora+EugaPuRYJmn1n57V2ybi2EXaDjut0+YMXVBmf7mET+c1jPWC6
        z/S5+QHp7KklGhclKSbyglu5QXGqHMWuD6ioP5z8qKAwJca4
X-Google-Smtp-Source: AGRyM1tldaAG/vst03t3098xtY+DG1LLb3O69uQkFr1PGrnvv1+HluXD9pi0qVxdbbbNN2xf8E4zF5P14zMamhDMukg4eMl+Ioge
MIME-Version: 1.0
X-Received: by 2002:a02:9995:0:b0:33f:1def:a856 with SMTP id
 a21-20020a029995000000b0033f1defa856mr9712173jal.140.1657521682552; Sun, 10
 Jul 2022 23:41:22 -0700 (PDT)
Date:   Sun, 10 Jul 2022 23:41:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000189d0f05e381d702@google.com>
Subject: [syzbot] KASAN: use-after-free Read in mprotect_fixup
From:   syzbot <syzbot+b707736a1ad47fda6500@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
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

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111640c8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=b707736a1ad47fda6500
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148349a2080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1266d768080000

The issue was bisected to:

commit 2ee236fe53a8e2ab54679c74e8a1fb77e55b29bb
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Tue Jun 21 20:46:53 2022 +0000

    mm: start tracking VMAs with maple tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170fe714080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148fe714080000
console output: https://syzkaller.appspot.com/x/log.txt?x=108fe714080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b707736a1ad47fda6500@syzkaller.appspotmail.com
Fixes: 2ee236fe53a8 ("mm: start tracking VMAs with maple tree")

==================================================================
BUG: KASAN: use-after-free in mprotect_fixup+0x8fc/0x960 mm/mprotect.c:606
Read of size 8 at addr ffff88801f89ed80 by task syz-executor107/3608

CPU: 0 PID: 3608 Comm: syz-executor107 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 mprotect_fixup+0x8fc/0x960 mm/mprotect.c:606
 do_mprotect_pkey+0x70f/0xa80 mm/mprotect.c:781
 __do_sys_pkey_mprotect mm/mprotect.c:816 [inline]
 __se_sys_pkey_mprotect mm/mprotect.c:813 [inline]
 __x64_sys_pkey_mprotect+0x93/0xf0 mm/mprotect.c:813
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fb254db5389
Code: 28 c3 e8 1a 17 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd8258c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000149
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb254db5389
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000038303633
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcd8258da0
R13: 00007ffcd8258cc0 R14: 00007fb254df10a1 R15: 0000000000000000
 </TASK>

Allocated by task 3608:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:736 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x2d6/0x4c0 mm/slub.c:3268
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 __split_vma+0x9f/0x530 mm/mmap.c:2276
 split_vma+0x9f/0xe0 mm/mmap.c:2335
 mprotect_fixup+0x6c7/0x960 mm/mprotect.c:607
 do_mprotect_pkey+0x70f/0xa80 mm/mprotect.c:781
 __do_sys_pkey_mprotect mm/mprotect.c:816 [inline]
 __se_sys_pkey_mprotect mm/mprotect.c:813 [inline]
 __x64_sys_pkey_mprotect+0x93/0xf0 mm/mprotect.c:813
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3608:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kmem_cache_free+0xeb/0x5b0 mm/slub.c:3551
 __vma_adjust+0x9ab/0x1900 mm/mmap.c:889
 vma_merge+0x590/0x870 mm/mmap.c:1122
 mprotect_fixup+0x338/0x960 mm/mprotect.c:595
 do_mprotect_pkey+0x70f/0xa80 mm/mprotect.c:781
 __do_sys_pkey_mprotect mm/mprotect.c:816 [inline]
 __se_sys_pkey_mprotect mm/mprotect.c:813 [inline]
 __x64_sys_pkey_mprotect+0x93/0xf0 mm/mprotect.c:813
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88801f89ed80
 which belongs to the cache vm_area_struct of size 152
The buggy address is located 0 bytes inside of
 152-byte region [ffff88801f89ed80, ffff88801f89ee18)

The buggy address belongs to the physical page:
page:ffffea00007e2780 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f89e
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888140006b40
raw: 0000000000000000 0000000080120012 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3603, tgid 3603 (sshd), ts 50397360264, free_ts 45063905366
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x3fb/0x4c0 mm/slub.c:3268
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 dup_mmap+0x642/0x1070 kernel/fork.c:640
 dup_mm+0x91/0x370 kernel/fork.c:1520
 copy_mm kernel/fork.c:1569 [inline]
 copy_process+0x3ca8/0x7080 kernel/fork.c:2237
 kernel_clone+0xe7/0xab0 kernel/fork.c:2652
 __do_sys_clone+0xba/0x100 kernel/fork.c:2786
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3383 [inline]
 free_unref_page_list+0x16f/0xb90 mm/page_alloc.c:3525
 release_pages+0xbe8/0x1810 mm/swap.c:1017
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:58
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu mm/mmu_gather.c:262 [inline]
 tlb_finish_mmu+0x147/0x7e0 mm/mmu_gather.c:353
 exit_mmap+0x1fe/0x720 mm/mmap.c:3212
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa09/0x29f0 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88801f89ec80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
 ffff88801f89ed00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88801f89ed80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801f89ee00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f89ee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
