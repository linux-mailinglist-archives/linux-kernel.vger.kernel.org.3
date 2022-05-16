Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322415287CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiEPPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiEPPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:00:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E20A3B3E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:00:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y13-20020a056602164d00b0065a9dec1ef2so10514794iow.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=atD1JTvq0nGxvQcWZCNocExfW9qBdyLjxQc8AM0gcG4=;
        b=qe7dGBYSu2iDxiynUJKL7PqJrK6i3dmTKIOBTJ0O3DnGmTU1SGbpDwlHPwVnAveAJe
         4OKbawhwLzQ8hb7mxZO7WBFwEwMQS4XwF3ytvNlT7LbB2mlOXdGmiECVD50P7lwaTmBc
         ovHR3201/xMX7ZnsIIbzcnkgfWiEQY7PNC5RVP9kNdA1Nc4BbnznzruXhepLkYTe/AiI
         7dfCme4r1Ku85AS61pDc4JHtLAIr5UZiwH4acxnJJp92u+sYgSDu5/I9logTNj1VL7mq
         9uNPFjzKi5n50+3AVafYPv+apUqyGUL7FvNte/Qc9v9vgyqJwS8NwQogf2YQjeR+a9jf
         Zssw==
X-Gm-Message-State: AOAM530R+uG9nd991N5n0ENQ8PRmBh+Sl/jZHElIPLNVY1uRAloghQwq
        ul+OECOZswR5ITuSeMYCsZKeYlA6SV3qT1BSR/LG3Jx6Evg6
X-Google-Smtp-Source: ABdhPJz+a5l8SnxqGaEb9nz8b2ovTLH+YU32u/FWM9ecjmIC6IRG2cDdtZNQjI13TQOgFgJfJGRprCxSZ1lEIlK3bJv1COG94q+x
MIME-Version: 1.0
X-Received: by 2002:a02:6a6b:0:b0:323:fcf9:2227 with SMTP id
 m43-20020a026a6b000000b00323fcf92227mr9173197jaf.137.1652713224823; Mon, 16
 May 2022 08:00:24 -0700 (PDT)
Date:   Mon, 16 May 2022 08:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae6a9905df2248a4@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in arch_stack_walk
From:   syzbot <syzbot+8631f4b15d790f42c8ad@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dvyukov@google.com, ebiederm@xmission.com,
        elver@google.com, linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=155634cef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=8631f4b15d790f42c8ad
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8631f4b15d790f42c8ad@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in walk_stackframe+0x11c/0x260 arch/riscv/kernel/stacktrace.c:57
Read of size 8 at addr ffffaf800ebe7b50 by task kworker/0:5/3954

CPU: 0 PID: 3954 Comm: kworker/0:5 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
[<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
[<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
[<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
[<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
[<ffffffff8000a052>] walk_stackframe+0x11c/0x260 arch/riscv/kernel/stacktrace.c:57
[<ffffffff8000a4a4>] arch_stack_walk+0x2c/0x3c arch/riscv/kernel/stacktrace.c:146
[<ffffffff80162ac8>] stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
[<ffffffff80473abe>] kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
[<ffffffff80473bb6>] kasan_set_track+0x1a/0x26 mm/kasan/common.c:45
[<ffffffff8047608c>] kasan_set_free_info+0x1e/0x3a mm/kasan/generic.c:370
[<ffffffff80473a70>] ____kasan_slab_free mm/kasan/common.c:366 [inline]
[<ffffffff80473a70>] ____kasan_slab_free+0x15e/0x180 mm/kasan/common.c:328
[<ffffffff80473fde>] __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
[<ffffffff80469750>] kasan_slab_free include/linux/kasan.h:236 [inline]
[<ffffffff80469750>] slab_free_hook mm/slub.c:1728 [inline]
[<ffffffff80469750>] slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
[<ffffffff8046d302>] slab_free mm/slub.c:3509 [inline]
[<ffffffff8046d302>] kfree+0xe0/0x3e4 mm/slub.c:4562

Allocated by task 2066:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0x80/0xb2 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:270 [inline]
 __kmalloc_node+0x1b0/0x36c mm/slub.c:4472
 kmalloc_node include/linux/slab.h:604 [inline]
 kzalloc_node include/linux/slab.h:726 [inline]
 qdisc_alloc+0x7c/0x522 net/sched/sch_generic.c:941
 qdisc_create_dflt+0x66/0x42c net/sched/sch_generic.c:1000
 attach_one_default_qdisc+0x94/0x11e net/sched/sch_generic.c:1148
 netdev_for_each_tx_queue include/linux/netdevice.h:2373 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1166 [inline]
 dev_activate+0x3f2/0x7c0 net/sched/sch_generic.c:1221
 __dev_open+0x2e8/0x384 net/core/dev.c:1416
 __dev_change_flags+0x41a/0x4e0 net/core/dev.c:8139
 dev_change_flags+0x50/0xba net/core/dev.c:8210
 do_setlink+0x5d6/0x21c4 net/core/rtnetlink.c:2729
 __rtnl_newlink+0x99e/0xfa0 net/core/rtnetlink.c:3412
 rtnl_newlink+0x60/0x8c net/core/rtnetlink.c:3527
 rtnetlink_rcv_msg+0x338/0x9a0 net/core/rtnetlink.c:5592
 netlink_rcv_skb+0xf8/0x2be net/netlink/af_netlink.c:2494
 rtnetlink_rcv+0x26/0x30 net/core/rtnetlink.c:5610
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x40e/0x5fe net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x4e0/0x994 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xa0/0xc4 net/socket.c:725
 __sys_sendto+0x1f2/0x2e0 net/socket.c:2040
 __do_sys_sendto net/socket.c:2052 [inline]
 sys_sendto+0x3e/0x52 net/socket.c:2048
 ret_from_syscall+0x0/0x2

The buggy address belongs to the object at ffffaf800ebe7800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 848 bytes inside of
 1024-byte region [ffffaf800ebe7800, ffffaf800ebe7c00)
The buggy address belongs to the page:
page:ffffaf807aa6e700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8ede0
head:ffffaf807aa6e700 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x8800010200(slab|head|section=17|node=0|zone=0)
raw: 0000008800010200 0000000000000100 0000000000000122 ffffaf8007201dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
raw: 00000000000007ff
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 2132, ts 1413880102700, free_ts 1413506823600
 __set_page_owner+0x48/0x136 mm/page_owner.c:183
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0xd0/0x10a mm/page_alloc.c:2427
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x8da/0x12d8 mm/page_alloc.c:4165
 __alloc_pages+0x150/0x3b6 mm/page_alloc.c:5389
 alloc_pages+0x132/0x2a6 mm/mempolicy.c:2271
 alloc_slab_page.constprop.0+0xc2/0xfa mm/slub.c:1799
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x76/0x2cc mm/slub.c:2004
 ___slab_alloc+0x56e/0x918 mm/slub.c:3018
 __slab_alloc.constprop.0+0x50/0x8c mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmalloc+0x268/0x318 mm/slub.c:4420
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc+0x26/0x32 include/linux/slab.h:715
 neigh_alloc net/core/neighbour.c:433 [inline]
 ___neigh_create+0xe86/0x1cf0 net/core/neighbour.c:618
 __neigh_create+0x30/0x40 net/core/neighbour.c:707
 ip6_finish_output2+0xd64/0x1256 net/ipv6/ip6_output.c:123
 __ip6_finish_output net/ipv6/ip6_output.c:191 [inline]
 __ip6_finish_output+0x47c/0x8f6 net/ipv6/ip6_output.c:170
 ip6_finish_output+0x3e/0x176 net/ipv6/ip6_output.c:201
page last free stack trace:
 __reset_page_owner+0x4a/0xea mm/page_owner.c:142
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x29c/0x45e mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x6a/0x31e mm/page_alloc.c:3404
 free_the_page mm/page_alloc.c:706 [inline]
 __free_pages+0xe2/0x112 mm/page_alloc.c:5474
 __free_slab+0x122/0x27c mm/slub.c:2028
 free_slab mm/slub.c:2043 [inline]
 discard_slab+0x4c/0x7a mm/slub.c:2049
 __unfreeze_partials+0x16a/0x18e mm/slub.c:2536
 put_cpu_partial+0xf6/0x162 mm/slub.c:2612
 __slab_free+0x166/0x29c mm/slub.c:3378
 do_slab_free mm/slub.c:3497 [inline]
 ___cache_free+0x17c/0x354 mm/slub.c:3516
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x7c/0x132 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14c/0x1c8 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x5c/0x98 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x338/0x3de mm/slub.c:3243
 vm_area_dup+0xa4/0x224 kernel/fork.c:357
 __split_vma+0x7c/0x2fa mm/mmap.c:2720

Memory state around the buggy address:
 ffffaf800ebe7a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffaf800ebe7a80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffffaf800ebe7b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                 ^
 ffffaf800ebe7b80: fc fc fc fc f1 f1 f1 f1 00 00 00 f3 f3 f3 f3 f3
 ffffaf800ebe7c00: 00 00 00 00 fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
