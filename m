Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7158A589
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiHEEzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 00:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHEEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 00:55:34 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A3063F6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 21:55:33 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n5-20020a056e021ba500b002df602f3626so1023246ili.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 21:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=dAMOX+xvwwQEQiAZtbvptI7uFn5qof0JwCgHgikDMB8=;
        b=x0RW40z4DxhZt00BDSsM1OAmOkDpjlf9/lke0aN1Xxj9vi7gcIlLsdLJoxw8X0rAlt
         LjUjX8E4apN9TMNR3hEKNVDBGkCmlRxs/P3cGSRraPubASAQAnAC0zgofPl8zVNcnjE8
         c9bUZfwLivNAMqLDvOAANfH28N+4F5emp2bflAwP56F+87w0gkQPJYhR0kvYCdmIYGCT
         ZN4oYCpVgNKObLxaX11WzWXBI61cry+XkRXD7yFbvfk111UVyqGLe9Nqcy17W13SHJeH
         LGKpSUL8J99MZEA7FO/37M6OBIX2f1H+WRgmSvPsqEg+VOZUN3XZxEx5kklqnNaqn//P
         zNaw==
X-Gm-Message-State: ACgBeo2rLn7gDSufW22LsKfHbzs1qGBZ4FObPXUhTHdhbFdhavrgJ/hT
        2aehBOJ6eiAAEQMPiMkEGdK9OXQjIvms7LPsMQr7IFqZg8u4
X-Google-Smtp-Source: AA6agR74Lea3BXNZmKRe0fcjETRsL/rsRtM5Un4kxSWIpIHWYz9VzIcL5u+QGbQpmGtuZq3hBkgdU1SVWRtmnaIU1/f+CWJyRo00
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cb:b0:33f:336c:34ae with SMTP id
 i11-20020a05663813cb00b0033f336c34aemr2300453jaj.317.1659675332575; Thu, 04
 Aug 2022 21:55:32 -0700 (PDT)
Date:   Thu, 04 Aug 2022 21:55:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4062705e5774643@google.com>
Subject: [syzbot] KASAN: use-after-free Read in mas_leaf_max_gap
From:   syzbot <syzbot+57cc1902120e58fc1c3b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12a1ffa6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=57cc1902120e58fc1c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57cc1902120e58fc1c3b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in mas_leaf_max_gap+0x608/0x6a0 lib/maple_tree.c:1474
Read of size 8 at addr ffff88803fdea280 by task syz-executor.0/19758

CPU: 1 PID: 19758 Comm: syz-executor.0 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 mas_leaf_max_gap+0x608/0x6a0 lib/maple_tree.c:1474
 mas_max_gap lib/maple_tree.c:1543 [inline]
 mab_set_b_end lib/maple_tree.c:2623 [inline]
 mas_spanning_rebalance.isra.0+0x3f15/0x6400 lib/maple_tree.c:3013
 mas_wr_spanning_store.isra.0+0x56e/0xea0 lib/maple_tree.c:4016
 mas_wr_store_entry.isra.0+0xb13/0xf90 lib/maple_tree.c:4338
 mas_store_prealloc+0xaf/0x150 lib/maple_tree.c:5644
 do_mas_align_munmap+0x761/0xee0 mm/mmap.c:2490
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2564
 __vm_munmap+0x14f/0x290 mm/mmap.c:2835
 __do_sys_munmap mm/mmap.c:2860 [inline]
 __se_sys_munmap mm/mmap.c:2857 [inline]
 __x64_sys_munmap+0x55/0x80 mm/mmap.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f57ba689209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57bb70c168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 00007f57ba79bf60 RCX: 00007f57ba689209
RDX: 0000000000000000 RSI: 00007fffdfc01000 RDI: 00000000203fe000
RBP: 00007f57ba6e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdb7bc610f R14: 00007f57bb70c300 R15: 0000000000022000
 </TASK>

Allocated by task 19514:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:736 [inline]
 kmem_cache_alloc_bulk+0x383/0x730 mm/slub.c:3735
 mt_alloc_bulk lib/maple_tree.c:151 [inline]
 mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
 mas_preallocate+0xff/0x2d0 lib/maple_tree.c:5662
 __vma_adjust+0x226/0x1900 mm/mmap.c:765
 vma_adjust include/linux/mm.h:2678 [inline]
 __split_vma+0x295/0x530 mm/mmap.c:2305
 do_mas_align_munmap+0x27e/0xee0 mm/mmap.c:2403
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2564
 do_munmap+0xc3/0x100 mm/mmap.c:2578
 mremap_to mm/mremap.c:820 [inline]
 __do_sys_mremap+0x1301/0x16a0 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 19514:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kmem_cache_free_bulk mm/slub.c:3660 [inline]
 kmem_cache_free_bulk+0x20e/0x780 mm/slub.c:3648
 mt_free_bulk lib/maple_tree.c:157 [inline]
 mas_destroy+0x394/0x5c0 lib/maple_tree.c:5767
 mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5646
 __vma_adjust+0x779/0x1900 mm/mmap.c:860
 vma_adjust include/linux/mm.h:2678 [inline]
 __split_vma+0x295/0x530 mm/mmap.c:2305
 do_mas_align_munmap+0x27e/0xee0 mm/mmap.c:2403
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2564
 do_munmap+0xc3/0x100 mm/mmap.c:2578
 mremap_to mm/mremap.c:820 [inline]
 __do_sys_mremap+0x1301/0x16a0 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88803fdea200
 which belongs to the cache maple_node of size 256
The buggy address is located 128 bytes inside of
 256-byte region [ffff88803fdea200, ffff88803fdea300)

The buggy address belongs to the physical page:
page:ffffea0000ff7a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3fdea
head:ffffea0000ff7a80 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88801184fdc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 17447, tgid 17447 (syz-executor.1), ts 816889309807, free_ts 814634222848
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 kmem_cache_alloc_bulk+0x21c/0x730 mm/slub.c:3711
 mt_alloc_bulk lib/maple_tree.c:151 [inline]
 mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
 mas_preallocate+0xff/0x2d0 lib/maple_tree.c:5662
 __vma_adjust+0x226/0x1900 mm/mmap.c:765
 vma_adjust include/linux/mm.h:2678 [inline]
 __split_vma+0x443/0x530 mm/mmap.c:2302
 split_vma+0x9f/0xe0 mm/mmap.c:2335
 mprotect_fixup+0x6c7/0x960 mm/mprotect.c:607
 do_mprotect_pkey+0x70f/0xa80 mm/mprotect.c:781
 __do_sys_mprotect mm/mprotect.c:808 [inline]
 __se_sys_mprotect mm/mprotect.c:805 [inline]
 __x64_sys_mprotect+0x74/0xb0 mm/mprotect.c:805
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3383 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3479
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:736 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x2f9/0x450 mm/slub.c:4420
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x368/0x400 security/tomoyo/file.c:831
 tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:199
 security_path_symlink+0xdf/0x150 security/security.c:1182
 do_symlinkat+0x106/0x2e0 fs/namei.c:4365
 __do_sys_symlinkat fs/namei.c:4387 [inline]
 __se_sys_symlinkat fs/namei.c:4384 [inline]
 __x64_sys_symlinkat+0x93/0xc0 fs/namei.c:4384
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88803fdea180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803fdea200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803fdea280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88803fdea300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803fdea380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
