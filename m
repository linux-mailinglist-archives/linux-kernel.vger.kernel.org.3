Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555C51D60A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391082AbiEFK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbiEFK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:59:06 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF526E5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:55:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j5-20020a056e020ee500b002cbc90840ecso3978058ilk.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VWNiasscwCqH7BEFBzi0QOwSUo6R9CLeT0qes+0SG9E=;
        b=MQqH9eQueSuy5PEDVAQGjgte+T94+o1mPaGCY9SLrifgIqF61LYGESXTG5LyX8NrZM
         Otwe8nN3tffDsL3LL8kiD9Nme5j4rlWmBqrNpPfsgqOBggu7veldkI0rmLXY8k09aYgi
         l4fWd+hwYK8ai01dB1s5/ClvapotqZ/xB54KzP0KfeILDTrsbxzSEjEOpuZojz+YmkW6
         +oiVv9cZyixXd1UOJ/+vImckRw26QRwTivw7uToTa7YnLwqr8x6/n8aFHJWE2n4gwB5R
         6v1n/uBGPrDBxorzUEnOP/KZjD1ZwN22phrLZ5T8roNEYcwr0zM4sg7M52psIUvsAwAV
         JXYQ==
X-Gm-Message-State: AOAM532l48nWXarXyAEqeWgyI1h9id+jCDIRiyrHlRli8e/ZZpFEzPeO
        pxTduMO3jGkeM61VLpEDwAGZXyIGutWud9zub7NLCtw4WJJ9
X-Google-Smtp-Source: ABdhPJxEryT1hVNVWW0lWDHfBTf58UOdnvjRmcxRPvEyAQV/MUT/cgJWkxFnEU/F1ZSqb9+Hnk3ZVrLnOwlxe77SRu4Dgve+LxF1
MIME-Version: 1.0
X-Received: by 2002:a92:bf12:0:b0:2c6:7aaa:9ff2 with SMTP id
 z18-20020a92bf12000000b002c67aaa9ff2mr1063676ilh.224.1651834521806; Fri, 06
 May 2022 03:55:21 -0700 (PDT)
Date:   Fri, 06 May 2022 03:55:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e66c2805de55b15a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in driver_register
From:   syzbot <syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
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

HEAD commit:    a2673d570bd6 usb: gadget: uvc: track frames in format entr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1100a2f8f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=dc7c3ca638e773db07f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in driver_find drivers/base/driver.c:223 [inline]
BUG: KASAN: use-after-free in driver_register+0x34d/0x3a0 drivers/base/driver.c:164
Read of size 8 at addr ffff88810f8cd0c8 by task syz-executor.0/8326

CPU: 0 PID: 8326 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00112-ga2673d570bd6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 driver_find drivers/base/driver.c:223 [inline]
 driver_register+0x34d/0x3a0 drivers/base/driver.c:164
 usb_gadget_register_driver_owner+0xfb/0x1e0 drivers/usb/gadget/udc/core.c:1546
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
 raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7b05256ea7
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 34 54 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b049cb098 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7b049cc110 RCX: 00007f7b05256ea7
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000003
RBP: 0000000000000003 R08: 000000000000ffff R09: 000000000000000b
R10: 00007f7b049cb140 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000020000000 R15: 0000000000000000
 </TASK>

Allocated by task 8324:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 bus_add_driver+0xd4/0x630 drivers/base/bus.c:602
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 usb_gadget_register_driver_owner+0xfb/0x1e0 drivers/usb/gadget/udc/core.c:1546
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
 raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8326:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x10f/0x190 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook mm/slub.c:1754 [inline]
 slab_free mm/slub.c:3510 [inline]
 kfree+0xc1/0x4f0 mm/slub.c:4552
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:721
 driver_find drivers/base/driver.c:221 [inline]
 driver_register+0x1e3/0x3a0 drivers/base/driver.c:164
 usb_gadget_register_driver_owner+0xfb/0x1e0 drivers/usb/gadget/udc/core.c:1546
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
 raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88810f8cd000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 200 bytes inside of
 256-byte region [ffff88810f8cd000, ffff88810f8cd100)

The buggy address belongs to the physical page:
page:ffffea00043e3300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10f8cc
head:ffffea00043e3300 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 ffffea000433cb00 dead000000000005 ffff888100041b40
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 206, tgid 206 (kworker/u4:3), ts 5899855484, free_ts 0
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0x1373/0x27b0 mm/page_alloc.c:4182
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x95a/0x1010 mm/slub.c:3005
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
 slab_alloc_node mm/slub.c:3183 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 kmem_cache_alloc_trace+0x2fd/0x3b0 mm/slub.c:3256
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 set_kthread_struct+0xc5/0x250 kernel/kthread.c:117
 copy_process+0x332c/0x6db0 kernel/fork.c:2161
 kernel_clone+0xe7/0xab0 kernel/fork.c:2639
 kernel_thread+0xb5/0xf0 kernel/fork.c:2691
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88810f8ccf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810f8cd000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810f8cd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88810f8cd100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810f8cd180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
