Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7A58E947
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiHJJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiHJJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:05:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8286F55F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:05:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i3-20020a5d8403000000b0067bd73cc9eeso7639239ion.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=7CAwyYN1P7bwYCfNd++c46KHxEzhG6alY7g04EoLak0=;
        b=X/ibBf7P3LehYBwAdAhfW+5vttk2m4UxhZXZGW7zWyBteCE/JiuRl5e9+j9vGq/UVC
         ev0Wh5vCZZvwYTSjT8FDoSKdxWnGFv+BK1bKFWh4akG/3RX7ngf1//kChiewisg171sd
         tt1EM9Z7XcP7wvp4mGwqRKRnKtb9Tm6VuPumJq3faGSPM6dKgtwAD+FT3wMkF3+u4iaI
         XDHPQEs5eyRlck4kzIcmY9H5pafwOp8RbenEvhx4lBWA08RQFVA+nMbe1SwJzhDHugBL
         zhd23nbYfMl6DHbdpCA/+r5g+z4uouLd9Z1V29AJBF6KDzPFQNCNE9m2VRNeBxXVtV/Y
         OxQA==
X-Gm-Message-State: ACgBeo0IRFgY+2ZOpEmNiMETOqElYYVi8DX/lLcFJVHAqPo5/8gCt/2E
        DURZaDrOV7j6+4WOtgnMFjRLBWzRm8IpPYn1nd9iRZFkdYIA
X-Google-Smtp-Source: AA6agR6OWplUDG8NQR3v1zr67/0fm3uuAZoKvRY2oNqFwwbMTG+6vm+Qwc0S7XSN8lWtYCYSoERVpeiiQNt8uc127xAgCRU2psmq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c5:b0:343:4296:3d28 with SMTP id
 l5-20020a05663814c500b0034342963d28mr536209jak.36.1660122323539; Wed, 10 Aug
 2022 02:05:23 -0700 (PDT)
Date:   Wed, 10 Aug 2022 02:05:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060d9d005e5df5995@google.com>
Subject: [syzbot] KASAN: use-after-free Read in slcan_open (2)
From:   syzbot <syzbot+ee59a5daa4a85fecd0cf@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f873b1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=ee59a5daa4a85fecd0cf
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee59a5daa4a85fecd0cf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in slc_sync drivers/net/can/slcan.c:510 [inline]
BUG: KASAN: use-after-free in slcan_open+0x13f/0x990 drivers/net/can/slcan.c:587
Read of size 8 at addr ffff888086ad8c88 by task syz-executor.3/1717

CPU: 1 PID: 1717 Comm: syz-executor.3 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 slc_sync drivers/net/can/slcan.c:510 [inline]
 slcan_open+0x13f/0x990 drivers/net/can/slcan.c:587
 tty_ldisc_open drivers/tty/tty_ldisc.c:433 [inline]
 tty_set_ldisc+0x369/0x670 drivers/tty/tty_ldisc.c:558
 tty_ioctl+0xada/0xc60 drivers/tty/tty_io.c:2714
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc050689209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc0517be168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc05079bf60 RCX: 00007fc050689209
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007fc0506e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0af3dd9f R14: 00007fc0517be300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00021ab600 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x86ad8
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001cfb608 ffffea0001fdca08 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x546dc0(GFP_USER|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO|__GFP_ACCOUNT), pid 1705, tgid 1697 (syz-executor.1), ts 1569421082832, free_ts 1569554373784
 prep_new_page mm/page_alloc.c:2457 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4203
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5431
 __alloc_pages_node include/linux/gfp.h:587 [inline]
 alloc_pages_node include/linux/gfp.h:610 [inline]
 kmalloc_large_node+0x7c/0x180 mm/slub.c:4438
 __kmalloc_node+0x2fd/0x420 mm/slub.c:4454
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0x6e/0x160 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 kvzalloc include/linux/slab.h:758 [inline]
 alloc_netdev_mqs+0x85/0xea0 net/core/dev.c:10584
 slc_alloc drivers/net/can/slcan.c:540 [inline]
 slcan_open+0x317/0x990 drivers/net/can/slcan.c:598
 tty_ldisc_open drivers/tty/tty_ldisc.c:433 [inline]
 tty_set_ldisc+0x369/0x670 drivers/tty/tty_ldisc.c:558
 tty_ioctl+0xada/0xc60 drivers/tty/tty_io.c:2714
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3344 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3439
 free_large_kmalloc+0xeb/0x1a0 mm/slub.c:3573
 kfree+0x182/0x210 mm/slub.c:4558
 device_release+0x98/0x1c0
 kobject_cleanup+0x235/0x470 lib/kobject.c:673
 netdev_run_todo+0xf9c/0x1090 net/core/dev.c:10366
 unregister_netdev+0x1a0/0x210 net/core/dev.c:10903
 tty_ldisc_kill drivers/tty/tty_ldisc.c:608 [inline]
 tty_ldisc_release+0x23c/0x510 drivers/tty/tty_ldisc.c:776
 tty_release_struct+0x27/0xd0 drivers/tty/tty_io.c:1694
 tty_release+0xc06/0xe60 drivers/tty/tty_io.c:1865
 __fput+0x3b9/0x820 fs/file_table.c:319
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x134/0x160 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x60 kernel/entry/common.c:294

Memory state around the buggy address:
 ffff888086ad8b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888086ad8c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888086ad8c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff888086ad8d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888086ad8d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
