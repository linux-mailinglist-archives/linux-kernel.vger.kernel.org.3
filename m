Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1249946E38E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhLIIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:00:00 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49134 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhLIH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:59:52 -0500
Received: by mail-il1-f197.google.com with SMTP id k9-20020a056e02156900b002a1acf9a52dso6358094ilu.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 23:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KLhfin0FaQXWcx8PBNwB5umi/m5vv8PTiubJWFxxJ58=;
        b=4IFDpEB64vS+zydgxgX5Eq2WrrCGu2egD7owcCzPj4X3lo8E6rRQ3HKWpOeSLHnMJC
         eX++VVBrwP3XUBVWsHPKCt7RlLeYYj/iXocSQXf4K2/iwYcB/0PEBu3+6rUBRtCYcU9X
         RKBQqpWMhXvZmUqI8Wf0vmxo3bZCkUYyRlVhqZClbBY6JTVz5SK4ywwdwzQpzLGzBqJe
         kuDlyX5muU3QQS61GWxhOVVpjd6/N5//+d9EoWG0YCS7HE3HJWA6PtRR2gIeZ6SRG2tk
         Hg3EAYp1VckJcVOK0w2F3bNDoU8Qf39x7G7wwnVu955ommmniZuhMveMNeDeNd+TkfFN
         sL+w==
X-Gm-Message-State: AOAM532Fn4/lNzsZ31zjvYTA9IvokwvwUYxgJocycLrmmvRcd1v3juwA
        dDlfhqU8PFQZwwZJlZWvL25hSqGKabH9W62HEmSMLxwOM7aA
X-Google-Smtp-Source: ABdhPJxS/LdICeoypW7gUloloV0ewap2gycMgM3R/UpRk1J1iej+f+6C3NjVaj42QwYxjR9Ao5/UE94CPZ/qQE4XgjES0rcv3ZIZ
MIME-Version: 1.0
X-Received: by 2002:a02:6064:: with SMTP id d36mr6795024jaf.80.1639036578771;
 Wed, 08 Dec 2021 23:56:18 -0800 (PST)
Date:   Wed, 08 Dec 2021 23:56:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d378505d2b1f18e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in reiserfs_fill_super (2)
From:   syzbot <syzbot+66c88846eb5fa7a16641@syzkaller.appspotmail.com>
To:     christian.brauner@ubuntu.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f9e455b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
dashboard link: https://syzkaller.appspot.com/bug?extid=66c88846eb5fa7a16641
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66c88846eb5fa7a16641@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in init_inode fs/reiserfs/inode.c:1325 [inline]
BUG: KASAN: use-after-free in reiserfs_read_locked_inode+0x1e47/0x2160 fs/reiserfs/inode.c:1574
Read of size 4 at addr ffff88808189c000 by task syz-executor.5/24610

CPU: 0 PID: 24610 Comm: syz-executor.5 Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xa5/0x3ed mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 init_inode fs/reiserfs/inode.c:1325 [inline]
 reiserfs_read_locked_inode+0x1e47/0x2160 fs/reiserfs/inode.c:1574
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
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5e666f401a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e65667fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5e666f401a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5e65668000
RBP: 00007f5e65668040 R08: 00007f5e65668040 R09: 0000000020000000
R10: 0000000000200000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f5e65668000 R15: 0000000020011400
 </TASK>

The buggy address belongs to the page:
page:ffffea0002062700 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x8189c
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0002062748 ffff8880b9c40140 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x1100cca(GFP_HIGHUSER_MOVABLE), pid 21718, ts 549829566702, free_ts 550946257184
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f40 mm/page_alloc.c:4164
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5376
 alloc_pages_vma+0xf3/0x7d0 mm/mempolicy.c:2153
 shmem_alloc_page+0x11f/0x1f0 mm/shmem.c:1579
 shmem_alloc_and_acct_page+0x161/0x10b0 mm/shmem.c:1604
 shmem_getpage_gfp+0xb2d/0x23a0 mm/shmem.c:1902
 shmem_fault+0x1b4/0x750 mm/shmem.c:2114
 __do_fault+0x10d/0x790 mm/memory.c:3845
 do_read_fault mm/memory.c:4160 [inline]
 do_fault mm/memory.c:4289 [inline]
 handle_pte_fault mm/memory.c:4547 [inline]
 __handle_mm_fault+0x2771/0x4170 mm/memory.c:4682
 handle_mm_fault+0x1c8/0x790 mm/memory.c:4780
 faultin_page mm/gup.c:939 [inline]
 __get_user_pages+0x522/0xfb0 mm/gup.c:1160
 populate_vma_page_range+0x24d/0x330 mm/gup.c:1492
 __mm_populate+0x1ea/0x3e0 mm/gup.c:1601
 mm_populate include/linux/mm.h:2734 [inline]
 vm_mmap_pgoff+0x20e/0x290 mm/util.c:524
 ksys_mmap_pgoff+0x79/0x5a0 mm/mmap.c:1629
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1351 [inline]
 free_pcp_prepare+0x414/0xb60 mm/page_alloc.c:1403
 free_unref_page_prepare mm/page_alloc.c:3324 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3440
 release_pages+0x3ed/0x1b30 mm/swap.c:980
 __pagevec_release+0x77/0x100 mm/swap.c:1000
 pagevec_release include/linux/pagevec.h:81 [inline]
 shmem_undo_range+0x94e/0x1b00 mm/shmem.c:957
 shmem_truncate_range mm/shmem.c:1056 [inline]
 shmem_evict_inode+0x3a4/0xbd0 mm/shmem.c:1138
 evict+0x2ed/0x6b0 fs/inode.c:639
 iput_final fs/inode.c:1719 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1745
 iput+0x58/0x70 fs/inode.c:1735
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:376
 __dentry_kill+0x3c0/0x640 fs/dcache.c:582
 dentry_kill fs/dcache.c:708 [inline]
 dput+0x738/0xbc0 fs/dcache.c:888
 __fput+0x3ab/0x9f0 fs/file_table.c:293
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 get_signal+0x1b01/0x28b0 kernel/signal.c:2628
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868

Memory state around the buggy address:
 ffff88808189bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88808189bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88808189c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88808189c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88808189c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
