Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F75A18C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiHYSZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbiHYSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:25:37 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82013FBD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:35 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l5-20020a056e021c0500b002ea96994711so120486ilh.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Q/OxLttWX+8mRdPCqVGQv8eU88ZX7k7qF3o/CyRQAI8=;
        b=3WHYkDKu1RqrNDMJDiChLFyBRuRH95A9ibloU43mHGIvPoF5ORnneb+ZATK3zVkP0R
         6M17V9qydIKReAmO/noLJZT2gvsTSS3JGWvt1uEy0eTKizMotgdLqy9ONCOAicjZaEWo
         3Hq7OvYPxINOJdeRu1jOA+C/VyEXtll5vmMcpyC/No4gvVIRrqN2keMHPcj6U18N84iS
         oPHC05ego/M5IwvtbIrZDKqOYUaXqlPmdqetLcdqyu00ZH8QVqoS4yUpttZqYtcW6Wnx
         0hEps2Q4MRraRqg8blHlJN+4iLFlcfz6MjTNsKQrWYFcFxtSjC3h3yAvf+6iyKzwms0I
         amnQ==
X-Gm-Message-State: ACgBeo0ZYI8Hzt69/chc+JEf6O1z/9G0hzkRvcWTDN6oC4YlzaO0R3fI
        3H7PyKKcgJsil5CpNXqkmnt6aU0K5cq+yaoeqWZv6rBK2Frt
X-Google-Smtp-Source: AA6agR5Lmyct7skCZWQXECwmKmPhf4qWt3ybtHsiOXVU1ZndgKo73+jyNoVjCbLGGQMD/Frn6yLTSygAmwGs00j2nkvHtbVbsmDU
MIME-Version: 1.0
X-Received: by 2002:a5d:9408:0:b0:688:189d:267f with SMTP id
 v8-20020a5d9408000000b00688189d267fmr2068273ion.55.1661451935185; Thu, 25 Aug
 2022 11:25:35 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:25:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006886bd05e714ec18@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ntfs_attr_find
From:   syzbot <syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
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

HEAD commit:    c40e8341e3b3 Merge tag 'cgroup-for-6.0-rc2-fixes' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161114c7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f8dcabe4a3b2c51c607
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dd8265080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f30033080000

The issue was bisected to:

commit 38c9c22a85aeed28d0831f230136e9cf6fa2ed44
Author: ChenXiaoSong <chenxiaosong2@huawei.com>
Date:   Thu Jul 7 10:53:29 2022 +0000

    ntfs: fix use-after-free in ntfs_ucsncmp()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f6cd8d080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f6cd8d080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f6cd8d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
Fixes: 38c9c22a85ae ("ntfs: fix use-after-free in ntfs_ucsncmp()")

loop0: detected capacity change from 0 to 64
ntfs: (device loop0): is_boot_sector_ntfs(): Invalid end of sector marker.
==================================================================
BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607

CPU: 1 PID: 3607 Comm: syz-executor153 Not tainted 6.0.0-rc2-syzkaller-00054-gc40e8341e3b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
 ntfs_attr_lookup+0x1056/0x2070 fs/ntfs/attrib.c:1193
 ntfs_read_inode_mount+0x89a/0x2580 fs/ntfs/inode.c:1845
 ntfs_fill_super+0x1799/0x9320 fs/ntfs/super.c:2854
 mount_bdev+0x34d/0x410 fs/super.c:1400
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
RIP: 0033:0x7f7916be3b4a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 f8 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd20250468 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd202504c0 RCX: 00007f7916be3b4a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd20250480
RBP: 00007ffd20250480 R08: 00007ffd202504c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000230
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000002
 </TASK>

Allocated by task 3311:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:320 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:315
 security_file_open+0x45/0xb0 security/security.c:1646
 do_dentry_open+0x349/0x13a0 fs/open.c:865
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1c92/0x28f0 fs/namei.c:3691
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3311:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x580 mm/slub.c:4562
 tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:320 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:315
 security_file_open+0x45/0xb0 security/security.c:1646
 do_dentry_open+0x349/0x13a0 fs/open.c:865
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1c92/0x28f0 fs/namei.c:3691
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807e352000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 9 bytes inside of
 4096-byte region [ffff88807e352000, ffff88807e353000)

The buggy address belongs to the physical page:
page:ffffea0001f8d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e350
head:ffffea0001f8d400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3311, tgid 3311 (cmp), ts 23752313648, free_ts 23694935443
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x32b/0x340 mm/slub.c:4420
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1345
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x16a/0x390 fs/stat.c:232
 vfs_fstatat+0x8c/0xb0 fs/stat.c:255
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 kmem_cache_alloc_node+0x2b1/0x3f0 mm/slub.c:3293
 __alloc_skb+0x210/0x2f0 net/core/skbuff.c:418
 alloc_skb include/linux/skbuff.h:1257 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1191 [inline]
 netlink_sendmsg+0x9a2/0xe10 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x236/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
