Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7349E4734D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhLMTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:20:31 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38776 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbhLMTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:20:30 -0500
Received: by mail-il1-f197.google.com with SMTP id j4-20020a056e02218400b002ab6e4dbf88so2741125ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vwc41IJxAaaBt+Mt67GWSjMlPa85Pj/CmHoWGwGNQwk=;
        b=CTceJ2HooeQHsm/D9zYFMCy+wzNbkl6QqBLVEYRl3RxhZGneS3porLbq5Z/Rn/XUJS
         VMR+7xf0e3fG2BpsNRz69UxzKgIXpXZ2/VeXN+reYbwC2y/hxGdzUDEaaZC4ujuJGCS2
         atumkA6bydY1LK8A000BtMwQxKgLwg632WWJ9URpusQs4tz0n2Qy/rGM0N9Uyqmm9HVp
         bHx42sl0tlOeHew4PbWjmqLWT2E890S594jqg38UeyEq0Ggs1aGG50uzBR/wMHbbmRjU
         qi3p4rE5mT9WMd7NGRfVOoqJORge4bU4P/bL8ewuR0zPVu5fv8ZeU6BuqCgZrNEb4MCf
         2e6A==
X-Gm-Message-State: AOAM533vDTLAJSaPCsiFxycZWzJJYmAj46jZHugaj+Cu3YSZluLx3TkR
        wJrWEC0s6Nb7ySDGDlQiUeukr8YS29iRN79FtvgrysbA2Oh9
X-Google-Smtp-Source: ABdhPJz+/fUH2ghhANmNq42Wi7kFZZuSv1+IWSYe4JNkTyeQHIuvd27zgJVrhA3H7no2RpO1WOxBUMvGffkEKBGzEOLzx3N2c8VW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr153799jak.273.1639423230245;
 Mon, 13 Dec 2021 11:20:30 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:20:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000467dff05d30bf75a@google.com>
Subject: [syzbot] KASAN: out-of-bounds Read in leaf_paste_entries (2)
From:   syzbot <syzbot+38b79774b6c990637f95@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2585cf9dfaad Linux 5.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1627c4d1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95a8e2162a0920fc
dashboard link: https://syzkaller.appspot.com/bug?extid=38b79774b6c990637f95
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140a32d5b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b3de05b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38b79774b6c990637f95@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using tea hash to sort names
==================================================================
BUG: KASAN: out-of-bounds in memmove include/linux/fortify-string.h:241 [inline]
BUG: KASAN: out-of-bounds in leaf_paste_entries+0x449/0x910 fs/reiserfs/lbalance.c:1377
Read of size 18446744073709551584 at addr ffff888064651fa4 by task syz-executor913/3605

CPU: 1 PID: 3605 Comm: syz-executor913 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x2ed mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memmove+0x20/0x60 mm/kasan/shadow.c:54
 memmove include/linux/fortify-string.h:241 [inline]
 leaf_paste_entries+0x449/0x910 fs/reiserfs/lbalance.c:1377
 balance_leaf_finish_node_paste_dirent fs/reiserfs/do_balan.c:1295 [inline]
 balance_leaf_finish_node_paste fs/reiserfs/do_balan.c:1321 [inline]
 balance_leaf_finish_node fs/reiserfs/do_balan.c:1364 [inline]
 balance_leaf+0x951e/0xd8b0 fs/reiserfs/do_balan.c:1452
 do_balance+0x315/0x810 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x762/0x8e0 fs/reiserfs/stree.c:2159
 reiserfs_add_entry+0x8cb/0xcf0 fs/reiserfs/namei.c:567
 reiserfs_mkdir+0x675/0x980 fs/reiserfs/namei.c:860
 create_privroot fs/reiserfs/xattr.c:889 [inline]
 reiserfs_xattr_init+0x4de/0xb60 fs/reiserfs/xattr.c:1012
 reiserfs_fill_super+0x21ea/0x2f80 fs/reiserfs/super.c:2175
 mount_bdev+0x34d/0x410 fs/super.c:1370
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1bcda75d2a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9ad780d8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd9ad78130 RCX: 00007f1bcda75d2a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd9ad780f0
RBP: 00007ffd9ad780f0 R08: 00007ffd9ad78130 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200002a8
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000007
 </TASK>

The buggy address belongs to the page:
page:ffffea0001919440 refcount:3 mapcount:0 mapping:ffff88801715bc80 index:0x3d97 pfn:0x64651
memcg:ffff8880114d4000
aops:def_blk_aops ino:700000
flags: 0xfff00000002022(referenced|active|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002022 0000000000000000 dead000000000122 ffff88801715bc80
raw: 0000000000003d97 ffff8880701d4040 00000003ffffffff ffff8880114d4000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 3605, ts 68498864248, free_ts 15483839908
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2201
 filemap_alloc_folio mm/filemap.c:1036 [inline]
 __filemap_get_folio+0x5f2/0xd60 mm/filemap.c:1951
 pagecache_get_page+0x2c/0x1a0 mm/folio-compat.c:125
 find_or_create_page include/linux/pagemap.h:489 [inline]
 grow_dev_page fs/buffer.c:949 [inline]
 grow_buffers fs/buffer.c:1014 [inline]
 __getblk_slow+0x1ed/0xae0 fs/buffer.c:1041
 __getblk_gfp+0x6e/0x80 fs/buffer.c:1334
 sb_getblk include/linux/buffer_head.h:327 [inline]
 search_by_key+0x3a5/0x3cc0 fs/reiserfs/stree.c:672
 reiserfs_read_locked_inode+0x154/0x2160 fs/reiserfs/inode.c:1557
 reiserfs_fill_super+0x1350/0x2f80 fs/reiserfs/super.c:2071
 mount_bdev+0x34d/0x410 fs/super.c:1370
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 free_contig_range+0xa8/0xf0 mm/page_alloc.c:9271
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1016
 debug_vm_pgtable+0x2984/0x2a16 mm/debug_vm_pgtable.c:1330
 do_one_initcall+0x103/0x650 init/main.c:1297
 do_initcall_level init/main.c:1370 [inline]
 do_initcalls init/main.c:1386 [inline]
 do_basic_setup init/main.c:1405 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1610
 kernel_init+0x1a/0x1d0 init/main.c:1499
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888064651e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888064651f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888064651f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                               ^
 ffff888064652000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888064652080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
