Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C35479CA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiFLKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiFLKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 06:38:34 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1465432
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:38:31 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso2723210ilv.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uctmbV0hgK2xuiqWbJ+CSqDdpDM7bCIrenNDXNQ8zeU=;
        b=LVNvM8nga5hSXXY0kT6at7XCHWNVKSBpNPeY9gmL1SfHSbBsKh2K4sMYEEY8sO0qzn
         rCx1F1Ad/KjjUJdK6E7FFF0uF+EUakTQDe7TD7yKS6+P8QjEOwEPZi1RNqlPK8Tq4g3T
         jJ3sdL/ox5x0s1Ep7+urGWNTMM4Q6fNzjT3XvbOjZ5a9yNbrXetvtoogdBOrj3RoQx+h
         PgzrVInKI2Tnh2bFugOQF4zoh3u0KbNHyK7t6/eiN9MEbdGoITyHnC5kyR3ra7GDdyUw
         hDKoaYycfAP+6gFufzRCZyqD36nZeJwRisRmIBhguTXUw+Ul99jWrZOqiBAXfK3p2ryq
         DO+w==
X-Gm-Message-State: AOAM5326F9Aij0cvTgN4NkJ34yDXbXdP4zdCyUAgX6b3Gs7JUsa28hhe
        wqZnyFrL1x29Indbu2vm9E4B/3E7pch+uJkhpuNANBolSsQE
X-Google-Smtp-Source: ABdhPJxYCRtT6CHGjyIAGfFiv2X0xKiwJzU9+Zzci6ZIKcAC4LBY7/GI8okFYLZJMWY21OgmYVhLbmt7SOa3unW7ANRT3hAMrtt4
MIME-Version: 1.0
X-Received: by 2002:a92:d406:0:b0:2d6:5a35:c95b with SMTP id
 q6-20020a92d406000000b002d65a35c95bmr13508628ilm.318.1655030310286; Sun, 12
 Jun 2022 03:38:30 -0700 (PDT)
Date:   Sun, 12 Jun 2022 03:38:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcbb0205e13dc53a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in search_by_entry_key (2)
From:   syzbot <syzbot+ffe24b1afbc4cb5ae8fb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    1c27f1fc1549 iov_iter: fix build issue due to possible typ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c41c0ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ac3e0ebf0db3bd
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe24b1afbc4cb5ae8fb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114e04bbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cec6e7f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe24b1afbc4cb5ae8fb@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 15748, journal first block 18, max trans len 1024, max batch 900, max commit age 0, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
==================================================================
BUG: KASAN: use-after-free in bin_search_in_dir_item fs/reiserfs/namei.c:40 [inline]
BUG: KASAN: use-after-free in search_by_entry_key+0x81f/0x960 fs/reiserfs/namei.c:165
Read of size 4 at addr ffff8880715ee014 by task syz-executor352/3611

CPU: 0 PID: 3611 Comm: syz-executor352 Not tainted 5.19.0-rc1-syzkaller-00263-g1c27f1fc1549 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 bin_search_in_dir_item fs/reiserfs/namei.c:40 [inline]
 search_by_entry_key+0x81f/0x960 fs/reiserfs/namei.c:165
 reiserfs_find_entry.part.0+0x139/0xdf0 fs/reiserfs/namei.c:322
 reiserfs_find_entry fs/reiserfs/namei.c:368 [inline]
 reiserfs_lookup+0x24a/0x490 fs/reiserfs/namei.c:368
 __lookup_slow+0x24c/0x480 fs/namei.c:1701
 lookup_one_len+0x16a/0x1a0 fs/namei.c:2730
 reiserfs_lookup_privroot+0x92/0x280 fs/reiserfs/xattr.c:980
 reiserfs_fill_super+0x21bb/0x2fb0 fs/reiserfs/super.c:2176
 mount_bdev+0x34d/0x410 fs/super.c:1367
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f33c6185c8a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd4af74c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcd4af7520 RCX: 00007f33c6185c8a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcd4af74e0
RBP: 00007ffcd4af74e0 R08: 00007ffcd4af7520 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200000a0
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000004
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c57b80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x715ee
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c57bc8 ffff8880b9a403c0 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x8(__GFP_MOVABLE), pid 1, tgid 1 (swapper/0), ts 8666191765, free_ts 9438327718
 split_map_pages+0x1ef/0x520 mm/compaction.c:99
 isolate_freepages_range+0x30f/0x350 mm/compaction.c:739
 alloc_contig_range+0x2f6/0x490 mm/page_alloc.c:9192
 __alloc_contig_pages mm/page_alloc.c:9215 [inline]
 alloc_contig_pages+0x35a/0x4c0 mm/page_alloc.c:9292
 debug_vm_pgtable_alloc_huge_page mm/debug_vm_pgtable.c:1098 [inline]
 init_args mm/debug_vm_pgtable.c:1221 [inline]
 debug_vm_pgtable+0x88f/0x2a94 mm/debug_vm_pgtable.c:1259
 do_one_initcall+0x103/0x650 init/main.c:1295
 do_initcall_level init/main.c:1368 [inline]
 do_initcalls init/main.c:1384 [inline]
 do_basic_setup init/main.c:1403 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1610
 kernel_init+0x1a/0x1d0 init/main.c:1499
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9314
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2a03/0x2a94 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x103/0x650 init/main.c:1295
 do_initcall_level init/main.c:1368 [inline]
 do_initcalls init/main.c:1384 [inline]
 do_basic_setup init/main.c:1403 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1610
 kernel_init+0x1a/0x1d0 init/main.c:1499
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Memory state around the buggy address:
 ffff8880715edf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880715edf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880715ee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880715ee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880715ee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
