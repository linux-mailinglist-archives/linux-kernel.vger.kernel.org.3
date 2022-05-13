Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B914525D66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378274AbiEMIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378254AbiEMIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:30:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5FC2A8041
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:30:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q9-20020a056e02106900b002cbc8d479eeso4820953ilj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VNTL71WwmOPc2ABvJSFl/xQv2y36KEOXLR6nSUKjhzA=;
        b=5iiyniJntLiDvDu0nHxbKiSA/dHOyVJqtM7wqnLAL6C6M+aUcpoDzjCpnZHGYx4UW4
         1V8fwCNZlJFajmmLSq68lxWgIv21ojgVJS4gQqeVvq6GABKGlByknpM/fwYf2icvfhyy
         49PCfqOc7kbhEvZ/hOG3iTEP8f4wdbxdH3KlMKx3JzMCSC0SXAiRD6FMBMhcnExzmdvk
         fTsHFAkdhdGDn3y1Yd97WEEqP/eoOK4yr7ZOy8rWGbmbSd25vvy06bEEuvC2BfiUxb8J
         JqKCcgFBI3wLLhTjwXMFVT+NppqHcVLFnncItwmSMjHbxZb3Juz6JpZftrlqjfuCTgb7
         bFfw==
X-Gm-Message-State: AOAM530NMdQgKxnjeI61MGU8WGvtKqoO+DeO41ynnjsqtRhPmWYrxoVC
        0KjwVdz5dYHPNNUfzgmovq1TqtHemLjAqkm4IRImw//jyQ0E
X-Google-Smtp-Source: ABdhPJw7J6RYH8cZ6DDSK5lTGVITSZyzkLkbp7uDuZCyBDZsmApAKd0fZy95ARpG6s8b3mYL88C9tZB/ybdwKgARZUMM3P4gzJGH
MIME-Version: 1.0
X-Received: by 2002:a02:6f56:0:b0:32a:ff25:1fe3 with SMTP id
 b22-20020a026f56000000b0032aff251fe3mr1988094jae.21.1652430622380; Fri, 13
 May 2022 01:30:22 -0700 (PDT)
Date:   Fri, 13 May 2022 01:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043596e05dee07c64@google.com>
Subject: [syzbot] KASAN: use-after-free Read in anon_vma_interval_tree_insert
From:   syzbot <syzbot+089e1a7629f6b380b80d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    187b9ac8c348 Add linux-next specific files for 20220512
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1425f34ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dcd4f4a77ca98a9
dashboard link: https://syzkaller.appspot.com/bug?extid=089e1a7629f6b380b80d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+089e1a7629f6b380b80d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vma_start_pgoff mm/interval_tree.c:15 [inline]
BUG: KASAN: use-after-free in avc_start_pgoff mm/interval_tree.c:63 [inline]
BUG: KASAN: use-after-free in __anon_vma_interval_tree_insert mm/interval_tree.c:71 [inline]
BUG: KASAN: use-after-free in anon_vma_interval_tree_insert+0x3e8/0x4b0 mm/interval_tree.c:82
Read of size 8 at addr ffff88801eb13578 by task syz-executor.3/17560

CPU: 1 PID: 17560 Comm: syz-executor.3 Not tainted 5.18.0-rc6-next-20220512-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 vma_start_pgoff mm/interval_tree.c:15 [inline]
 avc_start_pgoff mm/interval_tree.c:63 [inline]
 __anon_vma_interval_tree_insert mm/interval_tree.c:71 [inline]
 anon_vma_interval_tree_insert+0x3e8/0x4b0 mm/interval_tree.c:82
 anon_vma_interval_tree_post_update_vma mm/mmap.c:437 [inline]
 __vma_adjust+0x80d/0x1900 mm/mmap.c:862
 vma_merge+0x822/0x950 mm/mmap.c:1117
 userfaultfd_release+0x4c5/0x670 fs/userfaultfd.c:888
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc51283bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd3d7d1c60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007fc51283bd2b
RDX: 00007fc5129a02e8 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 00007fc51299d960 R08: 0000000000000000 R09: 00007fc5129a02f0
R10: 00007ffd3d7d1d60 R11: 0000000000000293 R12: 000000000005cc76
R13: 00007ffd3d7d1d60 R14: 00007fc51299bf60 R15: 0000000000000032
 </TASK>

Allocated by task 17573:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 copy_vma+0x36f/0x890 mm/mmap.c:3332
 move_vma+0x449/0xf60 mm/mremap.c:624
 mremap_to mm/mremap.c:859 [inline]
 __do_sys_mremap+0xe68/0x1540 mm/mremap.c:970
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 17573:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3524
 copy_vma+0x6ac/0x890 mm/mmap.c:3359
 move_vma+0x449/0xf60 mm/mremap.c:624
 mremap_to mm/mremap.c:859 [inline]
 __do_sys_mremap+0xe68/0x1540 mm/mremap.c:970
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88801eb13510
 which belongs to the cache vm_area_struct of size 152
The buggy address is located 104 bytes inside of
 152-byte region [ffff88801eb13510, ffff88801eb135a8)

The buggy address belongs to the physical page:
page:ffffea00007ac4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eb13
memcg:ffff888073936601
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000001 ffff888140006b40
raw: 0000000000000000 0000000080120012 00000001ffffffff ffff888073936601
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3792, tgid 3792 (modprobe), ts 159983100356, free_ts 159936448468
 prep_new_page mm/page_alloc.c:2431 [inline]
 get_page_from_freelist+0x129e/0x3dd0 mm/page_alloc.c:4176
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5396
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3239
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 __split_vma+0x9f/0x530 mm/mmap.c:2283
 do_mas_align_munmap+0x553/0xed0 mm/mmap.c:2430
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2564
 mmap_region+0x219/0x1bf0 mm/mmap.c:2612
 do_mmap+0x825/0xf60 mm/mmap.c:1493
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:488
 ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1539
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1396
 free_unref_page_prepare mm/page_alloc.c:3318 [inline]
 free_unref_page_list+0x16f/0xf80 mm/page_alloc.c:3450
 release_pages+0xff1/0x2290 mm/swap.c:980
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:58
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu mm/mmu_gather.c:262 [inline]
 tlb_finish_mmu+0x147/0x7e0 mm/mmu_gather.c:353
 exit_mmap+0x211/0x740 mm/mmap.c:3218
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88801eb13400: fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb fb
 ffff88801eb13480: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
>ffff88801eb13500: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88801eb13580: fb fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00
 ffff88801eb13600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
