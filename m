Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA058284B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiG0OLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiG0OL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:11:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163B1ADA6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:11:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id a26-20020a6b661a000000b0067be5b57f45so6160546ioc.16
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hZtd4Izi2z080yCo5sMjWoDMgDbQK9/2DLyH2BKw3Eg=;
        b=0VSAt+GdUjMKN+BiAfBVHcykpVXCnkl9EBk8/8GVZ37qCUqdP7xth6ItY6RiBalwlC
         /RVQW5MYWgX4Nagijfvbsz0N8+UdKdCnZs7J7xDtKklQSKpYgDLoUeA6WY+J2SlwubOk
         ODDi+b/HavR9ROeO1ee5UPz+O99pYoy6tVcTP+VcQ6xWB6X03X/IWVGEs37DSh5KP28M
         d8VlqOwndQTiZysc3wN3NFZIrFXCgwxBMNkn8i+L/kbcEB27cMHMCnHJ85STyR5ulIte
         vZjx+o0m9PStBG7xFN7Nmg4RXpj2FHEdRhZRWMVwWGOVa7BJSHOlsuvz8B6+bX9zAtFf
         9MuA==
X-Gm-Message-State: AJIora+m/AyVKL5aSyQr8mIU+C0NvbtnJJ1QP32Senox3iX7V8GPbvnr
        6KpdnE2KUWLKt3kE2Zu1WEg4IMpS1SGZ/s3Ds076fFRVOPe1
X-Google-Smtp-Source: AGRyM1uwbU8NMSa5gTYB6VWi8lhth8sP6ANPTBk0CJHSQR/jjzNwWyJ1B6qoWsRQ6/HbEaiERFa/gbjmusFs2SEY2JvZpPADKC/W
MIME-Version: 1.0
X-Received: by 2002:a05:6638:ac1:b0:341:830e:d439 with SMTP id
 m1-20020a0566380ac100b00341830ed439mr9078503jab.132.1658931087023; Wed, 27
 Jul 2022 07:11:27 -0700 (PDT)
Date:   Wed, 27 Jul 2022 07:11:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026269d05e4c9fe23@google.com>
Subject: [syzbot] KASAN: use-after-free Read in exit_mmap
From:   syzbot <syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c0a5ba080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=99551d8b4d180f6cb1c0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117dc816080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12695b26080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in exit_mmap+0x6b1/0x720 mm/mmap.c:3220
Read of size 8 at addr ffff88801fa79cc8 by task syz-executor422/3601

CPU: 0 PID: 3601 Comm: syz-executor422 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 exit_mmap+0x6b1/0x720 mm/mmap.c:3220
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
RIP: 0033:0x7f39b4e776a9
Code: Unable to access opcode bytes at RIP 0x7f39b4e7767f.
RSP: 002b:00007ffe5f9ced98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f39b4eeb270 RCX: 00007f39b4e776a9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f39b4eeb270
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3601:
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
 vm_area_alloc+0x1c/0xf0 kernel/fork.c:458
 mmap_region+0x448/0x1bf0 mm/mmap.c:2667
 do_mmap+0x825/0xf50 mm/mmap.c:1483
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
 ksys_mmap_pgoff+0x79/0x5a0 mm/mmap.c:1529
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3601:
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
 exit_mmap+0x288/0x720 mm/mmap.c:3222
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

The buggy address belongs to the object at ffff88801fa79ca8
 which belongs to the cache vm_area_struct of size 152
The buggy address is located 32 bytes inside of
 152-byte region [ffff88801fa79ca8, ffff88801fa79d40)

The buggy address belongs to the physical page:
page:ffffea00007e9e40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fa79
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888140006b40
raw: 0000000000000000 0000000080120012 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3596, tgid 3596 (sshd), ts 49436343226, free_ts 44111523441
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
 ffff88801fa79b80: 00 00 fc fc fc fc fc fc fc fc fa fb fb fb fb fb
 ffff88801fa79c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>ffff88801fa79c80: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88801fa79d00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801fa79d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
