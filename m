Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D74A5814
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiBAHsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:48:22 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41828 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBAHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:48:21 -0500
Received: by mail-il1-f199.google.com with SMTP id o8-20020a056e0214c800b002bc2f9cffffso4318990ilk.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PsU8K40jOpf8tc4OuLs57473g1eDGxIE4YR8KVoUK2Q=;
        b=wVHRrk8qndI/LhWawJFnczX4UBkVKOAu6nYUCP+U2iPimYpp8xnGuyD8DqjBfa0SIx
         QtWjUdrwf8/eUciXE0+vKLkjVik3lCcK6N0vt0Fod6edQ1eyIEmIQXcHhXgoxmkXNcdK
         ONO2xJvWE90Mq6zR3M5jwUzIIGiHwQWuGbq3jehYq0f1psqNH4A1tgK4bURg0ox0pq9/
         Tn0HQkOmN4OkrELNWJKr4FTGuaW8sRwLCt0a5T3BW/k7x67v+LGwNPcFsCdr5K/JuDwP
         5nP789EAcAa0S8jbUDQjpYDw+wnOqJCP2wlz17Wqi/pfWEq3L5aZIfrHBePPkpDgkpe/
         cvOA==
X-Gm-Message-State: AOAM533dW3ctiIGFokqSnsivUkBNenYDWbQYwVUDqojh+r4ChlMKh8o5
        1opY27VgRMLwjt5aL6N6AAIdoZV32iwUhSfWtCYc3/X3Ld2O
X-Google-Smtp-Source: ABdhPJwhSPPtkYVUrio/VdpJxNZ687gZK5yAkXWGFxNe1K6OOTNdI3Om6fcOrN10Pz3u8UAVfhP25dynUyFvZLr0QKLSfyIpwqD8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e01:: with SMTP id g1mr13169435ila.263.1643701701488;
 Mon, 31 Jan 2022 23:48:21 -0800 (PST)
Date:   Mon, 31 Jan 2022 23:48:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008b80505d6f02054@google.com>
Subject: [syzbot] KASAN: use-after-free Read in recv_work (2)
From:   syzbot <syzbot+476bd1c816c8c9c340d7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0280e3c58f92 Merge tag 'nfs-for-5.17-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b3dde4700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=916d34c0d501b86
dashboard link: https://syzkaller.appspot.com/bug?extid=476bd1c816c8c9c340d7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+476bd1c816c8c9c340d7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in recv_work+0x840/0x8b0 drivers/block/nbd.c:863
Read of size 8 at addr ffff88801886e9b0 by task kworker/u5:5/3653

CPU: 0 PID: 3653 Comm: kworker/u5:5 Not tainted 5.17.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: nbd1-recv recv_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 recv_work+0x840/0x8b0 drivers/block/nbd.c:863
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 7763:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc_node include/linux/slab.h:604 [inline]
 __vmalloc_area_node mm/vmalloc.c:2948 [inline]
 __vmalloc_node_range+0x444/0x1060 mm/vmalloc.c:3107
 __vmalloc_node mm/vmalloc.c:3157 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3227
 do_ipt_get_ctl+0x60d/0x9d0 net/ipv4/netfilter/ip_tables.c:801
 nf_getsockopt+0x72/0xd0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt net/ipv4/ip_sockglue.c:1786 [inline]
 ip_getsockopt+0x164/0x1c0 net/ipv4/ip_sockglue.c:1765
 tcp_getsockopt+0x86/0xd0 net/ipv4/tcp.c:4284
 __sys_getsockopt+0x21f/0x5f0 net/socket.c:2224
 __do_sys_getsockopt net/socket.c:2239 [inline]
 __se_sys_getsockopt net/socket.c:2236 [inline]
 __x64_sys_getsockopt+0xba/0x150 net/socket.c:2236
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 29418:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x130/0x160 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xcb/0x280 mm/slub.c:4562
 krealloc+0x69/0xf0 mm/slab_common.c:1219
 nbd_add_socket+0x2cb/0x810 drivers/block/nbd.c:1130
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88801886e9b0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88801886e9b0, ffff88801886e9b8)
The buggy address belongs to the page:
page:ffffea0000621b80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1886e
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001d57400 dead000000000002 ffff888010c41280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 3634, ts 181715914950, free_ts 181667651758
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28a/0x3b0 mm/slub.c:2004
 ___slab_alloc+0x87c/0xe90 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmalloc+0x2fb/0x340 mm/slub.c:4420
 kmalloc_array include/linux/slab.h:621 [inline]
 kcalloc include/linux/slab.h:652 [inline]
 nsim_fib6_event_init drivers/net/netdevsim/fib.c:807 [inline]
 nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:940 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:991 [inline]
 nsim_fib_event_nb+0x2f1/0xc50 drivers/net/netdevsim/fib.c:1028
 call_fib_notifier+0x32/0x70 net/core/fib_notifier.c:24
 call_fib6_entry_notifier net/ipv6/ip6_fib.c:373 [inline]
 fib6_rt_dump net/ipv6/ip6_fib.c:452 [inline]
 fib6_node_dump+0x1c4/0x2d0 net/ipv6/ip6_fib.c:462
 fib6_walk_continue+0x3e9/0x6c0 net/ipv6/ip6_fib.c:2112
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2160
 fib6_table_dump net/ipv6/ip6_fib.c:474 [inline]
 fib6_tables_dump+0x1dc/0x340 net/ipv6/ip6_fib.c:503
 fib6_dump+0x47/0x60 net/ipv6/fib6_notifier.c:39
 fib_net_dump net/core/fib_notifier.c:71 [inline]
 register_fib_notifier+0x1fc/0x7b0 net/core/fib_notifier.c:109
 nsim_fib_create+0x7a5/0xa60 drivers/net/netdevsim/fib.c:1557
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x6d/0x160 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 kmem_cache_alloc_node+0x255/0x3f0 mm/slub.c:3266
 __alloc_skb+0x215/0x340 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1158 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 devlink_param_notify+0xba/0x230 net/core/devlink.c:4729
 devlink_notify_register net/core/devlink.c:9112 [inline]
 devlink_register+0x398/0x4a0 net/core/devlink.c:9164
 nsim_drv_probe+0xd81/0x11c0 drivers/net/netdevsim/dev.c:1604
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970

Memory state around the buggy address:
 ffff88801886e880: fc fc fc fa fc fc fc fc fa fc fc fc fc fb fc fc
 ffff88801886e900: fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc fc
>ffff88801886e980: fc fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc
                                     ^
 ffff88801886ea00: fa fc fc fc fc fa fc fc fc fc fb fc fc fc fc fa
 ffff88801886ea80: fc fc fc fc fa fc fc fc fc fb fc fc fc fc fa fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
