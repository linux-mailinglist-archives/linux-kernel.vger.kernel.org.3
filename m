Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3E54C89A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiFOMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiFOMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:32:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B84476B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:32:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s189-20020a6b2cc6000000b00669add3c306so5949364ios.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Hk37ekpwwvB27g8el17DaKg6oc0nnRoSOpA+7oVy2/8=;
        b=p72or0vAZ/32D7stlgA63vcvRDk/wd9vDl8cZORZ2OxtjtPG9NzyZ3f8a0Y0fUdibA
         rDoslYhdk2Ye4GIsatTmUakQoaeLYZQJosNBn+lUgyN1hcte8iWy7SIOQ7UHP5IM7wDc
         H1bsSDWlKmouIH59CG3Iv5mJ0qK5fHJGrM6cs33dYsIODqwlb3cnkDaiBVc01Kyu9CWE
         hRb9T+YbdUC7z9qq+3CrrTyiElBZdx1Y7mFl75NsmvKrdEt7vRLc2JaC6ixNPc9f3tvB
         FVKw9UuxQuQPAmQfj3i4mK+1qFbBrxXHsLtP4nIsGjlgZBZVy4yR0nEaQQOhFSQyb4QM
         4Ypw==
X-Gm-Message-State: AJIora+oaHVLguObnjKHxWzoTm/MELj9cj6in5ZMk877h9Lr/nhVXAqO
        pwKPXNAYvSQCVuDteHisqv/ykj2Tw44WEbXHNjtQSlyD8XO2
X-Google-Smtp-Source: AGRyM1vdm5hTxtOWcG13X9ZOFQCoQREbaSB7DITgRY0mZXKY7jhdxmnSPJaIEWlvN3q1AHxB8IE+gtnP7S8l1xkLrFV1IFuK7Xge
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:2d3:cb8b:218c with SMTP id
 j7-20020a056e02218700b002d3cb8b218cmr5717981ila.28.1655296328555; Wed, 15 Jun
 2022 05:32:08 -0700 (PDT)
Date:   Wed, 15 Jun 2022 05:32:08 -0700
In-Reply-To: <20220615121701.2143-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9640305e17bb533@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in route4_destroy
From:   syzbot <syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in route4_destroy

==================================================================
BUG: KASAN: use-after-free in route4_destroy+0x861/0x9d0 net/sched/cls_route.c:302
Read of size 8 at addr ffff888021de7700 by task syz-executor.0/4141

CPU: 1 PID: 4141 Comm: syz-executor.0 Not tainted 5.19.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 route4_destroy+0x861/0x9d0 net/sched/cls_route.c:302
 tcf_proto_destroy+0x6a/0x2d0 net/sched/cls_api.c:314
 tcf_proto_put+0x8c/0xc0 net/sched/cls_api.c:326
 tcf_chain_flush+0x21a/0x360 net/sched/cls_api.c:632
 tcf_block_flush_all_chains net/sched/cls_api.c:1034 [inline]
 __tcf_block_put+0x15a/0x510 net/sched/cls_api.c:1196
 tcf_block_put_ext net/sched/cls_api.c:1396 [inline]
 tcf_block_put+0xb3/0x100 net/sched/cls_api.c:1411
 drr_destroy_qdisc+0x44/0x1d0 net/sched/sch_drr.c:455
 qdisc_destroy+0xc4/0x4e0 net/sched/sch_generic.c:1067
 qdisc_put+0xcd/0xe0 net/sched/sch_generic.c:1086
 notify_and_destroy net/sched/sch_api.c:1012 [inline]
 qdisc_graft+0xeb1/0x1270 net/sched/sch_api.c:1084
 tc_modify_qdisc+0xbb7/0x1a00 net/sched/sch_api.c:1671
 rtnetlink_rcv_msg+0x43a/0xc90 net/core/rtnetlink.c:6089
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f157e77d188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665f9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd57f086af R14: 00007f157e77d300 R15: 0000000000022000
 </TASK>

Allocated by task 4137:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 route4_change+0x28c/0x24a0 net/sched/cls_route.c:500
 tc_new_tfilter+0x98d/0x2200 net/sched/cls_api.c:2148
 rtnetlink_rcv_msg+0x946/0xc90 net/core/rtnetlink.c:6080
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 42:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kfree+0xd6/0x4d0 mm/slub.c:4555
 __route4_delete_filter net/sched/cls_route.c:262 [inline]
 route4_delete_filter_work+0xb0/0xf0 net/sched/cls_route.c:271
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x62f/0x1150 kernel/workqueue.c:1517
 rcu_work_rcufn+0x58/0x80 kernel/workqueue.c:1754
 rcu_do_batch kernel/rcu/tree.c:2578 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2838
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:3126
 queue_rcu_work+0x82/0xa0 kernel/workqueue.c:1774
 route4_change+0x19ed/0x24a0 net/sched/cls_route.c:557
 tc_new_tfilter+0x98d/0x2200 net/sched/cls_api.c:2148
 rtnetlink_rcv_msg+0x946/0xc90 net/core/rtnetlink.c:6080
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
 __sys_sendmsg net/socket.c:2575 [inline]
 __do_sys_sendmsg net/socket.c:2584 [inline]
 __se_sys_sendmsg net/socket.c:2582 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff888021de7700
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff888021de7700, ffff888021de77c0)

The buggy address belongs to the physical page:
page:ffffea00008779c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21de7
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000841500 dead000000000003 ffff888010c41a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 10074698598, free_ts 0
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x1290/0x3b70 mm/page_alloc.c:4198
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5426
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2105
 alloc_pages+0x2b1/0x310 mm/mempolicy.c:2267
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 kmem_cache_alloc_trace+0x310/0x3f0 mm/slub.c:3253
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
 kobject_uevent_env+0xefa/0x1660 lib/kobject_uevent.c:614
 driver_register+0x2db/0x3a0 drivers/base/driver.c:248
 usb_register_driver+0x249/0x460 drivers/usb/core/driver.c:1062
 do_one_initcall+0x103/0x650 init/main.c:1295
 do_initcall_level init/main.c:1368 [inline]
 do_initcalls init/main.c:1384 [inline]
 do_basic_setup init/main.c:1403 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1610
 kernel_init+0x1a/0x1d0 init/main.c:1499
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888021de7600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888021de7680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888021de7700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888021de7780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888021de7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         018ab4fa netfs: fix up netfs_inode_init() docbook comm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a20787f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f21890d74080ef72
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3efb5eb71cb5075ba7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dcf608080000

