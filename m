Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A65A18BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbiHYSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiHYSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:25:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C913F55
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:35 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g12-20020a5d8c8c000000b006894fb842e3so11107133ion.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0Xo5XIz5MrPJqgkwKps5fee/urRjPi7BHKDNMnZ+IHc=;
        b=rng458wPiaSQX9fWAvViwqc5V1EnaBXzotpyYEvvaAsSbmcqvad+CEnpWzWS40KtzK
         SnGNc5h/5HPphtBYoGgjxkcFeMwl9HRmnDfS9mhJyc2FYQ4lTWlfZMiQ5jU2ZN9Txads
         e4dmIJU7w2CWiBBmTIWHvmadrLisJiqzvH1oJ/PYuKcYLKf5vlUjY+IsFjgRvv+69zQN
         YjSnfTAlwQSz3RQhkEXMGVacNho6JuxsrRhVmr0rqrb4S9i0u3D3ZEKKQEcXBRvABb91
         J0wiuS6Y5DmZQ1a3wsUtEaRMdUY7KjIOaw6UtEJSnDBwuHKpD9O6Bf6Kxg1mWaVvQJ/Y
         LcRA==
X-Gm-Message-State: ACgBeo3r0s1ckJk30Vlr1upLV97y47m+sbjh4a/J1QkV8fQ7H0YU0dxR
        J1K0O/70waRPKD6oUzr7LklcyvsWtoMH77I0qfNy+9iGdgJI
X-Google-Smtp-Source: AA6agR5qI6FAoLiL/WkIOfcdVsWClN2kbWe+y73OJ0FaT6MK4DO2BVkZWzY3+ygwQ4S8cTNpd+6LBsW/aFVN8/E6/sd2sc4/F5/4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d8e:b0:349:d8fe:3a4b with SMTP id
 l14-20020a0566380d8e00b00349d8fe3a4bmr2289298jaj.44.1661451934918; Thu, 25
 Aug 2022 11:25:34 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000646c9605e714ec6e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __kernfs_remove
From:   syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    68a00424bf69 Add linux-next specific files for 20220824
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10cedc45080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=591008a24ae652d0
dashboard link: https://syzkaller.appspot.com/bug?extid=8bee3285b9e190f1509e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123a6fb5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15381113080000

The issue was bisected to:

commit b10b85fe5149ee8b39fbbf86095b303632dde2cd
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed Jul 27 14:31:30 2022 +0000

    ovl: warn if trusted xattr creation fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126b3c65080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116b3c65080000
console output: https://syzkaller.appspot.com/x/log.txt?x=166b3c65080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com
Fixes: b10b85fe5149 ("ovl: warn if trusted xattr creation fails")

==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:335 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1261 [inline]
BUG: KASAN: use-after-free in __kernfs_remove+0xa09/0xb50 fs/kernfs/dir.c:1369
Read of size 2 at addr ffff8880175239a8 by task syz-executor325/4044

CPU: 1 PID: 4044 Comm: syz-executor325 Not tainted 6.0.0-rc2-next-20220824-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 kernfs_type include/linux/kernfs.h:335 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1261 [inline]
 __kernfs_remove+0xa09/0xb50 fs/kernfs/dir.c:1369
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1589
 sysfs_slab_add+0x13e/0x1e0 mm/slub.c:5756
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9adb816389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4b66cf98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff4b66cfd0 RCX: 00007f9adb816389
RDX: 0000000020000280 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000140 R09: 000000000000c837
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 000000000000c837 R14: 00007fff4b66cfbc R15: 00007fff4b66cfc0
 </TASK>

Allocated by task 4039:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3229 [inline]
 slab_alloc mm/slub.c:3237 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3244 [inline]
 kmem_cache_alloc+0x2b7/0x3d0 mm/slub.c:3253
 kmem_cache_zalloc include/linux/slab.h:685 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x101/0x160 lib/kobject.c:441
 sysfs_slab_add+0x161/0x1e0 mm/slub.c:5767
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4044:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1740 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1766
 slab_free mm/slub.c:3497 [inline]
 kmem_cache_free+0xe7/0x5b0 mm/slub.c:3519
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:547
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 __kernfs_remove+0x7a6/0xb50 fs/kernfs/dir.c:1407
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1589
 sysfs_slab_add+0x13e/0x1e0 mm/slub.c:5756
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888017523910
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 152 bytes inside of
 168-byte region [ffff888017523910, ffff8880175239b8)

The buggy address belongs to the physical page:
page:ffffea00005d48c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888017523570 pfn:0x17523
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00005d4c80 dead000000000006 ffff8880119d4c80
raw: ffff888017523570 000000008011000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2122740088, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5507
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2113
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2275
 alloc_slab_page mm/slub.c:1810 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1955
 new_slab mm/slub.c:2015 [inline]
 ___slab_alloc+0xa3e/0x11d0 mm/slub.c:3017
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3104
 slab_alloc_node mm/slub.c:3195 [inline]
 slab_alloc mm/slub.c:3237 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3244 [inline]
 kmem_cache_alloc+0x31c/0x3d0 mm/slub.c:3253
 kmem_cache_zalloc include/linux/slab.h:685 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 internal_create_group+0x787/0xb10 fs/sysfs/group.c:136
 kernel_add_sysfs_param kernel/params.c:814 [inline]
 param_sysfs_builtin kernel/params.c:851 [inline]
 param_sysfs_init+0x342/0x43b kernel/params.c:970
 do_one_initcall+0xfe/0x650 init/main.c:1301
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1630
 kernel_init+0x1a/0x1d0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888017523880: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff888017523900: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888017523980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
                                  ^
 ffff888017523a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017523a80: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
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
