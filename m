Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C658E4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiHJCC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHJCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:02:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60980F47
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:02:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id bb13-20020a056602380d00b006849ed2e8a2so4255913iob.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 19:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=EUqcMCnkW9ptlpOtVDUqxUIBPbjt8Mo7rSYsVIeMRi8=;
        b=CrzhE4rwpaHgzn7c074QG6wVPCTdsLQnaN//JDjrvDw+CZstINRPgZmDTHgsTapqMl
         WE2xOwxLmu3tR2Hfsj8Y+XX+1I8fb57sT9D3SCjl0yNO2lZbmvwK6W+dIQ26jE+IpgWQ
         1NeQ4IfuMwOSlybxKs9dtmaHVRvXmGquS8nCRdmkDftWMVskiy+jetcObb3h9GKBC6GR
         0vLDn9NuB0v9H7/+ntkqKEd6cz11FxKsp6zvhhOAXq4P0/TYPIZL09DCzXpYjjXxbWHi
         huwo8Wqms63BPmBHfG7DQFmSQPvEjKeoWfMGa7CcKx7AZrO6fncrW08qLxvINXJqYjxr
         vD8g==
X-Gm-Message-State: ACgBeo0FAqlb6k8cjhg+86LwPoNIzX/lk/4UPbUmuywJqpT+RQDXzp34
        cf5AfuuAcyIn8DxaoyjT8u+dF5xHb15Zzlp1aKcTnJ0+4zN5
X-Google-Smtp-Source: AA6agR54NPc2vW1qogwyuaEe9hhHm7H1JEraW38yluhGcKhHj2EGuwBllZUO/bnl/iEQ+Qaon75VcSdJhSt6PtzpSEcZ7ciYjRNC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:2de:c3b:91d with SMTP id
 n12-20020a056e02148c00b002de0c3b091dmr12043433ilk.95.1660096942244; Tue, 09
 Aug 2022 19:02:22 -0700 (PDT)
Date:   Tue, 09 Aug 2022 19:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008909d405e5d970b8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __io_remove_buffers
From:   syzbot <syzbot+6a8a923895a61a5dbf18@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e0afb1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=6a8a923895a61a5dbf18
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d81cbc080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c7f1c1080000

The issue was bisected to:

commit c7fb19428d67dd0a2a78a4f237af01d39c78dc5a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Apr 30 20:38:53 2022 +0000

    io_uring: add support for ring mapped supplied buffers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17499eb6080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c99eb6080000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c99eb6080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a8a923895a61a5dbf18@syzkaller.appspotmail.com
Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")

==================================================================
BUG: KASAN: use-after-free in __io_remove_buffers.part.0+0x3c6/0x4f0 io_uring/kbuf.c:217
Read of size 2 at addr ffff8880269a8012 by task kworker/u4:0/8

CPU: 1 PID: 8 Comm: kworker/u4:0 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events_unbound io_ring_exit_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 __io_remove_buffers.part.0+0x3c6/0x4f0 io_uring/kbuf.c:217
 __io_remove_buffers io_uring/kbuf.c:255 [inline]
 io_destroy_buffers+0x9a/0x3b0 io_uring/kbuf.c:255
 io_ring_ctx_free io_uring/io_uring.c:2477 [inline]
 io_ring_exit_work+0x784/0xc7c io_uring/io_uring.c:2661
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Allocated by task 3601:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kmalloc_array include/linux/slab.h:639 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 io_init_bl_list+0x4c/0x139 io_uring/kbuf.c:195
 io_register_pbuf_ring.cold+0x11/0x84 io_uring/kbuf.c:495
 __io_uring_register io_uring/io_uring.c:3855 [inline]
 __do_sys_io_uring_register+0x6b2/0x1030 io_uring/io_uring.c:3897
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3601:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x4d0 mm/slub.c:4562
 io_register_pbuf_ring+0x4e9/0x5d0 io_uring/kbuf.c:515
 __io_uring_register io_uring/io_uring.c:3855 [inline]
 __do_sys_io_uring_register+0x6b2/0x1030 io_uring/io_uring.c:3897
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
 netlink_release+0xf08/0x1db0 net/netlink/af_netlink.c:815
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff8880269a8000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 18 bytes inside of
 2048-byte region [ffff8880269a8000, ffff8880269a8800)

The buggy address belongs to the physical page:
page:ffffea00009a6a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x269a8
head:ffffea00009a6a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011842000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 10266954305, free_ts 0
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2113
 alloc_pages+0x2b1/0x310 mm/mempolicy.c:2275
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 __kmalloc_node_track_caller+0x360/0x480 mm/slub.c:4955
 kmalloc_reserve net/core/skbuff.c:358 [inline]
 __alloc_skb+0xd9/0x340 net/core/skbuff.c:430
 alloc_skb include/linux/skbuff.h:1249 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 rtmsg_ifinfo_build_skb+0x72/0x1a0 net/core/rtnetlink.c:3904
 rtmsg_ifinfo_event net/core/rtnetlink.c:3940 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:3931 [inline]
 rtmsg_ifinfo+0x83/0x120 net/core/rtnetlink.c:3949
 register_netdevice+0x128d/0x15e0 net/core/dev.c:10112
 register_netdev+0x2d/0x50 net/core/dev.c:10191
 rose_proto_init+0x317/0x66a net/rose/af_rose.c:1532
 do_one_initcall+0xfe/0x650 init/main.c:1300
 do_initcall_level init/main.c:1375 [inline]
 do_initcalls init/main.c:1391 [inline]
 do_basic_setup init/main.c:1410 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1617
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880269a7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880269a7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880269a8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880269a8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880269a8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
