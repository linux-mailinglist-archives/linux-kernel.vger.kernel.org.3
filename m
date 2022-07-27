Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327458284A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiG0OLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiG0OL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:11:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E761DA7A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:11:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id v5-20020a5d9405000000b0067c98e0011dso3121972ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=plNejDtr3ZviZAWZm8SYM2SNLW397EnwckurjsFzRAs=;
        b=zEBkfXrAW+MsRYaHqULyZ4SxlS/EUqp2TGqEfmz5M1T890RZbTytd2S/1Z8VwJicXB
         lPwMPjUjM/AIsTNQbXMfAFKRcUQ54nsaLl7nvSDvQ8hvhLO99iChKND1cuPSZpfUSVUG
         OwlQjaSAK5wuVbMEJJ7MTIpNreG9+vZH0XvtdXsLRMY8l5n34kF7arEJkT+hif9Dgr3/
         I7LiS+6Jfwme9k3H26D8JkshkRUDiCjJWrGoFcIY2feBMKhK7EE0U8Z8IdCsDDsp9Dkv
         JDzBXY9QzH6M7pv6SKet7Zn5q28oCtoBD1c000b9oX1gJBmA+fjoUjayeHHpQ5FFlpeM
         oVyw==
X-Gm-Message-State: AJIora8eWA1Ns6GBfo4RMOmgc/7eODKyntMkjUgrAvPClhbMgF7MgVj6
        q6187cIVSme86iuCP0wOCsdxmjKvMKFT9e11OflZy6OKtoIu
X-Google-Smtp-Source: AGRyM1uWd6qib549sB75urpDV+vQmLrSUcguB03S7Va/2ylsNTmlNVck9vwr6bBw0l3Lp4zbtXSrIcG1Se90wjA0QfB066Qe0avy
MIME-Version: 1.0
X-Received: by 2002:a6b:5915:0:b0:67b:dbd6:3e04 with SMTP id
 n21-20020a6b5915000000b0067bdbd63e04mr7932054iob.8.1658931087274; Wed, 27 Jul
 2022 07:11:27 -0700 (PDT)
Date:   Wed, 27 Jul 2022 07:11:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029f85405e4c9fe7f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __post_watch_notification
From:   syzbot <syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e0dccc3b76fb Linux 5.19-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15be4030080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfd2f9ae77f1f719
dashboard link: https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1326814a080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ea97e080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173882ce080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b882ce080000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b882ce080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __post_watch_notification+0x1fe/0x900 kernel/watch_queue.c:221
Read of size 8 at addr ffff888020d0fb10 by task syz-executor307/4153

CPU: 0 PID: 4153 Comm: syz-executor307 Not tainted 5.19.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 __post_watch_notification+0x1fe/0x900 kernel/watch_queue.c:221
 post_watch_notification include/linux/watch_queue.h:109 [inline]
 notify_key security/keys/internal.h:199 [inline]
 __key_update+0x428/0x4e0 security/keys/key.c:775
 key_create_or_update+0xa8f/0xd60 security/keys/key.c:979
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x338/0x480 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7b34b1d9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b34acf2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007f7b34ba5408 RCX: 00007f7b34b1d9f9
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 0000000000000000 R08: 00000000fffffffc R09: 0000000000000000
R10: 0000000000000048 R11: 0000000000000246 R12: 00007f7b34ba5400
R13: 00007f7b34ba540c R14: 00007f7b34b73064 R15: 3a74707972637366
 </TASK>

Allocated by task 4144:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x94/0x310 mm/slub.c:3284
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 watch_queue_init+0x4f/0x140 kernel/watch_queue.c:675
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
 free_watch+0x3c/0x130 kernel/watch_queue.c:421
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
 kset_register+0x149/0x190 lib/kobject.c:849
 __class_register+0x232/0x350 drivers/base/class.c:188
 __class_create+0xb9/0x100 drivers/base/class.c:242
 mon_bin_init+0x1c/0xe0 drivers/usb/mon/mon_bin.c:1378
 mon_init+0xb4/0x28c drivers/usb/mon/mon_main.c:357
 do_one_initcall+0xbd/0x2b0 init/main.c:1295
 do_initcall_level+0x168/0x218 init/main.c:1368
 do_initcalls+0x4b/0x8c init/main.c:1384
 kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
 kernel_init+0x19/0x2b0 init/main.c:1499
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888020d0fb00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 192-byte region [ffff888020d0fb00, ffff888020d0fbc0)

The buggy address belongs to the physical page:
page:ffffea00008343c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20d0f
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00008376c0 dead000000000004 ffff888011c41a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 7626645136, free_ts 7626009397
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
 __kmalloc+0x2ba/0x370 mm/slub.c:4442
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 aoecmd_init+0x111/0x423 drivers/block/aoe/aoecmd.c:1697
 aoe_init+0x91/0x182 drivers/block/aoe/aoemain.c:63
 do_one_initcall+0xbd/0x2b0 init/main.c:1295
 do_initcall_level+0x168/0x218 init/main.c:1368
 do_initcalls+0x4b/0x8c init/main.c:1384
 kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
 kernel_init+0x19/0x2b0 init/main.c:1499
 ret_from_fork+0x1f/0x30
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page_list+0x12c/0x890 mm/page_alloc.c:3475
 release_pages+0x2a04/0x2cb0 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:58 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:262
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:353
 exit_mmap+0x1dc/0x530 mm/mmap.c:3164
 __mmput+0x111/0x3a0 kernel/fork.c:1187
 free_bprm+0x136/0x2f0 fs/exec.c:1486
 kernel_execve+0x40d/0xa00 fs/exec.c:2005
 call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff888020d0fa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888020d0fa80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888020d0fb00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888020d0fb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888020d0fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
