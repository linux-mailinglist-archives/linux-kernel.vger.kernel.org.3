Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5204A6C51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiBBH23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:28:29 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56863 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiBBH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:28:28 -0500
Received: by mail-io1-f70.google.com with SMTP id q24-20020a5d8358000000b006133573a011so14566743ior.23
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e/4JMq2Y+wvNEusmZFjY+vtm05E37gr0OvekdbR97aU=;
        b=TiKOv7CfVQPi6k/ckopGCDsZE+/2YFsP3Adm1h4qJHVEJa4IAKCxaSsIZRqcdb2ZwU
         riC/xpPw0M++CdaLG7LKVrQcqrO399jNawhwaJhMqQF55L1/FHBQhBW6DnIe7IiBfZ2H
         YRNxI6cyDTiJjvQX099G/OzThdyBtekldQmyUSq1gMQKLdNNZSLuMqFfij/HJFcbSXJw
         yBFr1+Rx8vjESkET/e9P3F71PO08sg/yDgWU3/3A2vQ4pdX0eu/KAAjM2SUNOKIGRKGc
         c9MBOp524lay9shMo7g+ib42ISVaolXRCvaQX+NbxGDCVTP8UDRUqFrpXrogmic1z7Wg
         cRaQ==
X-Gm-Message-State: AOAM5335DtraiPzOJiYwntskr/Odwt4IIQpI4TCxD2nvcgxFyUvHGpVe
        nIcCoLyluIP2XLc9ais5Q1eKYSV0dfeMoPlRFIZRW9eunFWg
X-Google-Smtp-Source: ABdhPJw/VsS0qSnO+ADhQhVNuAkYs7ss3BnJOEMCRcvVS6simAOtxowJjCNuX4HJHx2NFnVtOYFTJENpc56hUQ+T1odxH9wcWeQQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:80d:: with SMTP id u13mr16992918ilm.151.1643786907620;
 Tue, 01 Feb 2022 23:28:27 -0800 (PST)
Date:   Tue, 01 Feb 2022 23:28:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b71cdd05d703f6bf@google.com>
Subject: [syzbot] KASAN: use-after-free Read in setup_rw_floppy
From:   syzbot <syzbot+8e8958586909d62b6840@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    26291c54e111 Linux 5.17-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108fb648700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bdff1d807acada
dashboard link: https://syzkaller.appspot.com/bug?extid=8e8958586909d62b6840
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e8958586909d62b6840@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in setup_rw_floppy+0x84a/0x9e0 drivers/block/floppy.c:1518
Read of size 1 at addr ffff888026a5fe35 by task kworker/u16:4/3773

CPU: 2 PID: 3773 Comm: kworker/u16:4 Not tainted 5.17.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy fd_timer_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 setup_rw_floppy+0x84a/0x9e0 drivers/block/floppy.c:1518
 seek_floppy drivers/block/floppy.c:1639 [inline]
 floppy_ready drivers/block/floppy.c:1956 [inline]
 floppy_ready+0x345/0x1850 drivers/block/floppy.c:1927
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 16034:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:270 [inline]
 kmem_cache_alloc_trace+0x1ea/0x4a0 mm/slab.c:3567
 kmalloc include/linux/slab.h:581 [inline]
 raw_cmd_copyin drivers/block/floppy.c:3095 [inline]
 raw_cmd_ioctl drivers/block/floppy.c:3162 [inline]
 fd_locked_ioctl+0x100e/0x2830 drivers/block/floppy.c:3530
 fd_ioctl+0x35/0x50 drivers/block/floppy.c:3557
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 16034:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xee/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:236 [inline]
 __cache_free mm/slab.c:3437 [inline]
 kfree+0xf6/0x290 mm/slab.c:3794
 raw_cmd_free+0x8a/0x1c0 drivers/block/floppy.c:3079
 raw_cmd_ioctl drivers/block/floppy.c:3182 [inline]
 fd_locked_ioctl+0x207e/0x2830 drivers/block/floppy.c:3530
 fd_ioctl+0x35/0x50 drivers/block/floppy.c:3557
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0x7e/0x90 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3591
 __hw_addr_flush+0x152/0x240 net/core/dev_addr_lists.c:488
 dev_addr_flush+0x1d/0x50 net/core/dev_addr_lists.c:533
 free_netdev+0x1f5/0x5b0 net/core/dev.c:10283
 netdev_run_todo+0x8a0/0xaa0 net/core/dev.c:9964
 ip_tunnel_delete_nets+0x3a4/0x5b0 net/ipv4/ip_tunnel.c:1124
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:173
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:597
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0x7e/0x90 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3591
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1705
 unregister_sysctl_table fs/proc/proc_sysctl.c:1743 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1718
 mpls_dev_sysctl_unregister net/mpls/af_mpls.c:1441 [inline]
 mpls_dev_notify+0x4fb/0x8a0 net/mpls/af_mpls.c:1654
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:84
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1919
 call_netdevice_notifiers_extack net/core/dev.c:1931 [inline]
 call_netdevice_notifiers net/core/dev.c:1945 [inline]
 unregister_netdevice_many+0x964/0x1850 net/core/dev.c:10415
 ip_tunnel_delete_nets+0x39f/0x5b0 net/ipv4/ip_tunnel.c:1123
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:173
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:597
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff888026a5fe00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 53 bytes inside of
 128-byte region [ffff888026a5fe00, ffff888026a5fe80)
The buggy address belongs to the page:
page:ffffea00009a97c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26a5f
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000083f648 ffffea0000657d48 ffff888010c40400
raw: 0000000000000000 ffff888026a5f000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x242220(__GFP_HIGH|__GFP_ATOMIC|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 7589, ts 856054219165, free_ts 610363186592
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages_slowpath.constprop.0+0x2eb/0x20d0 mm/page_alloc.c:4934
 __alloc_pages+0x412/0x500 mm/page_alloc.c:5402
 __alloc_pages_node include/linux/gfp.h:572 [inline]
 kmem_getpages mm/slab.c:1378 [inline]
 cache_grow_begin+0x75/0x350 mm/slab.c:2584
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2957
 ____cache_alloc mm/slab.c:3040 [inline]
 ____cache_alloc mm/slab.c:3023 [inline]
 __do_cache_alloc mm/slab.c:3267 [inline]
 slab_alloc mm/slab.c:3308 [inline]
 kmem_cache_alloc_trace+0x380/0x4a0 mm/slab.c:3565
 kmalloc include/linux/slab.h:581 [inline]
 __hw_addr_create net/core/dev_addr_lists.c:58 [inline]
 __hw_addr_add_ex+0x22d/0x7e0 net/core/dev_addr_lists.c:116
 __hw_addr_add net/core/dev_addr_lists.c:133 [inline]
 dev_addr_init+0x13a/0x220 net/core/dev_addr_lists.c:556
 alloc_netdev_mqs+0x280/0x1070 net/core/dev.c:10180
 ip6gre_init_net+0x1b6/0x630 net/ipv6/ip6_gre.c:1593
 ops_init+0xaf/0x470 net/core/net_namespace.c:140
 setup_net+0x554/0xbb0 net/core/net_namespace.c:330
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:474
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3048
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3441
 release_pages+0x317/0x1220 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:50 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:243 [inline]
 tlb_flush_mmu mm/mmu_gather.c:250 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:341
 exit_mmap+0x21b/0x670 mm/mmap.c:3180
 __mmput+0x122/0x4b0 kernel/fork.c:1114
 mmput+0x56/0x60 kernel/fork.c:1135
 exit_mm kernel/exit.c:507 [inline]
 do_exit+0xa3c/0x2a30 kernel/exit.c:793
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888026a5fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888026a5fd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888026a5fe00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888026a5fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888026a5ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
