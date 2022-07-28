Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D8583692
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiG1B4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiG1B4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:56:19 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82BD558C8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:56:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l10-20020a056e021aaa00b002dd08016baeso388991ilv.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WuLJL9+ByE8kPLgbMhLMVKkf6c1pqhm9k3UoMYZ6oQQ=;
        b=zYLkWsHRaSrvXo/QrM/13/1+V96290pU+gk/evP+fzgKgAZi8RIdUDcyWHhpb7osJO
         Tug5GBQY86J6ZsDBleDmwwUz8ngnxQv8P3DyPPU6KKvJ0nfgnx8cBx75QVmNkj/fBw3E
         2iP9eXt6EfUvtpvaD6Uwa/Zf4LHJDWAKRiVFvnDKmXoI7yJnxQmElhfvJcZdGtyFDi+J
         k69/vYRX8NpxX6qGzWIpsu9g1V+s8mqDB9fM15Rov8DviD1IzFhySbuxM3GQfAmCyXOf
         TJS9AYHoJFA9HxaEdNfh6UqUmJ3/UkYgmJINAhMqI3QPnWJhs6OxX3i8wpj1Wbshs4Ef
         bGUQ==
X-Gm-Message-State: AJIora8yXglvl7MeFiQExl/tLInPFBZbKSEoQPn11dAL6bcYYTHs9y80
        P+KsX3mGOrbbNsEOAHr+renOv+FH48CTWj0n9glwMt4GP4OK
X-Google-Smtp-Source: AGRyM1t8YQ6fgfRMZ8FzwnFetvgK4nxob8nEwTa8TUlDf603SScvTJ5Fp7v0qaaxZavoAzVtWU+kvwyEIMtMxToLU066iyzeXmP0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:2dc:43d9:51ba with SMTP id
 w7-20020a056e021a6700b002dc43d951bamr9856851ilv.180.1658973374186; Wed, 27
 Jul 2022 18:56:14 -0700 (PDT)
Date:   Wed, 27 Jul 2022 18:56:14 -0700
In-Reply-To: <20220728014433.373-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a90e8505e4d3d62a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __post_watch_notification
From:   syzbot <syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in __post_watch_notification

==================================================================
BUG: KASAN: use-after-free in __post_watch_notification+0x204/0x8d0 kernel/watch_queue.c:223
Read of size 8 at addr ffff888025dfe610 by task syz-executor.0/4264

CPU: 1 PID: 4264 Comm: syz-executor.0 Not tainted 5.19.0-rc8-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 __post_watch_notification+0x204/0x8d0 kernel/watch_queue.c:223
 post_watch_notification include/linux/watch_queue.h:109 [inline]
 notify_key security/keys/internal.h:199 [inline]
 __key_update+0x428/0x4e0 security/keys/key.c:775
 key_create_or_update+0xa8f/0xd60 security/keys/key.c:979
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x338/0x480 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff80ba89209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff80cc25168 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007ff80bb9bf60 RCX: 00007ff80ba89209
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 00007ff80bae3161 R08: fffffffffffffffc R09: 0000000000000000
R10: 0000000000000048 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc7598cc4f R14: 00007ff80cc25300 R15: 0000000000022000
 </TASK>

Allocated by task 4246:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x94/0x310 mm/slub.c:3284
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 watch_queue_init+0x4f/0x140 kernel/watch_queue.c:678
 create_pipe_files+0x478/0x6e0 fs/pipe.c:921
 __do_pipe_flags+0x46/0x200 fs/pipe.c:962
 do_pipe2+0xd0/0x300 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x56/0x60 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 26:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1780
 slab_free mm/slub.c:3536 [inline]
 kmem_cache_free_bulk+0x105/0x1d0 mm/slub.c:3683
 kfree_bulk include/linux/slab.h:456 [inline]
 kfree_rcu_work+0x35b/0x7c0 kernel/rcu/tree.c:3370
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Last potentially related work creation:
 kasan_save_stack+0x3b/0x60 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x118/0x840 kernel/rcu/tree.c:3647
 free_watch+0x3c/0x130 kernel/watch_queue.c:423
 rcu_do_batch kernel/rcu/tree.c:2578 [inline]
 rcu_core+0xa0c/0x16d0 kernel/rcu/tree.c:2838
 __do_softirq+0x382/0x793 kernel/softirq.c:571

Second to last potentially related work creation:
 kasan_save_stack+0x3b/0x60 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 insert_work+0x54/0x3e0 kernel/workqueue.c:1358
 __queue_work+0x969/0xc20 kernel/workqueue.c:1517
 queue_work_on+0x137/0x240 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:502 [inline]
 call_usermodehelper_exec+0x26d/0x430 kernel/umh.c:435
 kobject_uevent_env+0x7df/0x8e0 lib/kobject_uevent.c:618
 driver_register+0x399/0x3e0 drivers/base/driver.c:248
 __hid_register_driver+0x126/0x170 drivers/hid/hid-core.c:2864
 do_one_initcall+0xbd/0x2b0 init/main.c:1295
 do_initcall_level+0x168/0x218 init/main.c:1368
 do_initcalls+0x4b/0x8c init/main.c:1384
 kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
 kernel_init+0x19/0x2b0 init/main.c:1499
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888025dfe600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 192-byte region [ffff888025dfe600, ffff888025dfe6c0)

The buggy address belongs to the physical page:
page:ffffea0000977f80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25dfe
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888011c41a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 8881199979, free_ts 0
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4198
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5426
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2105
 alloc_slab_page+0x70/0xf0 mm/slub.c:1824
 allocate_slab+0x5e/0x520 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x42e/0xce0 mm/slub.c:3031
 __slab_alloc mm/slub.c:3118 [inline]
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x25c/0x310 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 call_usermodehelper_setup+0x8a/0x260 kernel/umh.c:365
 kobject_uevent_env+0x7c1/0x8e0 lib/kobject_uevent.c:614
 driver_register+0x399/0x3e0 drivers/base/driver.c:248
 __hid_register_driver+0x126/0x170 drivers/hid/hid-core.c:2864
 do_one_initcall+0xbd/0x2b0 init/main.c:1295
 do_initcall_level+0x168/0x218 init/main.c:1368
 do_initcalls+0x4b/0x8c init/main.c:1384
 kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
 kernel_init+0x19/0x2b0 init/main.c:1499
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888025dfe500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025dfe580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888025dfe600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888025dfe680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888025dfe700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e0dccc3b Linux 5.19-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=177befba080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfd2f9ae77f1f719
dashboard link: https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d3ebaa080000

