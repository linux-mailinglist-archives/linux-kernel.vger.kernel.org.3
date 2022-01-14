Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F018648E858
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiANK3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:29:19 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54256 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiANK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:29:18 -0500
Received: by mail-il1-f198.google.com with SMTP id s10-20020a056e02216a00b002b7877fab0cso5831966ilv.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xhtd++bGYYni/HGfTlGdkYA8U2FdFKBk4MtD1cFOLQU=;
        b=5r23B9a1wwcyLtdtUEmHGwMD8u7lgSK0QaHLIKLEQQk+u/3hGObfRxS0gFsliVvsos
         SuX6FhvaoLl7YjysANkaDz1rxvwPhluKV8UBefDmCXtaMoULOCqgcTber5fUXnaMAekM
         H5N6E5Q++eBNnyjDxBwwJbNl1cjsLxqwXR3OFwZWzIbpu0M32S4BNtxNvJhXu1RmO86j
         HMZy2s45h/aZM2FX5ycPbtMCOz0fbAIkE/N71OngA3KczQ5pMcgqPNZcL+7GvOjEJXbx
         RaorpugrUMRxJRo548Py9nCRRemZ0uIn6lp5wHRXC1f6bsx5XYzKhdYGGEwc1rWXCtOO
         V39w==
X-Gm-Message-State: AOAM533BuC/GpggmCYvpVFqD2wn070FVAJWRIYAKGYKWeZ6FrS1PnOzl
        rseBK4YKfwiWk2SyAkUbzJ3Y52/6mbc064Hy46f+CR4JIvVy
X-Google-Smtp-Source: ABdhPJybTfEbeWpPjC5V6OZySuyfjWJz2BvKcXEvRGTbIHTq5E4Gr7jG2crU3qcB5VpWD+ea2i/ZfDMOjifT4YZtFWFRrliu0fRa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2e:: with SMTP id m14mr4494524ilh.189.1642156158148;
 Fri, 14 Jan 2022 02:29:18 -0800 (PST)
Date:   Fri, 14 Jan 2022 02:29:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078e7bb05d588464b@google.com>
Subject: [syzbot] KASAN: use-after-free Write in _atomic_dec_and_lock_irqsave (2)
From:   syzbot <syzbot+87b6a258f2769007f504@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57c149e506d5 Add linux-next specific files for 20220110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13374c1bb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f1cca5543ac6349
dashboard link: https://syzkaller.appspot.com/bug?extid=87b6a258f2769007f504
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87b6a258f2769007f504@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_add_unless include/linux/atomic/atomic-instrumented.h:607 [inline]
BUG: KASAN: use-after-free in _atomic_dec_and_lock_irqsave+0x27/0x150 lib/dec_and_lock.c:41
Write of size 4 at addr ffff888147cb7b1c by task udevd/2975

CPU: 0 PID: 2975 Comm: udevd Not tainted 5.16.0-rc8-next-20220110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xa5/0x3e0 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_add_unless include/linux/atomic/atomic-instrumented.h:607 [inline]
 _atomic_dec_and_lock_irqsave+0x27/0x150 lib/dec_and_lock.c:41
 put_ucounts+0x73/0x1c0 kernel/ucount.c:206
 put_cred_rcu+0x27a/0x520 kernel/cred.c:124
 rcu_do_batch kernel/rcu/tree.c:2536 [inline]
 rcu_core+0x7b8/0x1540 kernel/rcu/tree.c:2787
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:unwind_next_frame+0xcbe/0x1ce0 arch/x86/kernel/unwind_orc.c:534
Code: 0f f5 ff ff 4c 89 ff 4c 89 44 24 20 e8 bb f1 8e 00 4c 8b 44 24 20 e9 2c f7 ff ff e8 b3 de cb ff e9 aa f7 ff ff 48 8b 44 24 60 <4c> 89 e2 4c 89 f7 48 89 4c 24 30 4c 89 44 24 28 48 8d 70 f8 48 89
RSP: 0018:ffffc90001a3f5c0 EFLAGS: 00000246
RAX: ffffc90001a3fa78 RBX: 1ffff92000347ec0 RCX: ffffffff8e3dc5a9
RDX: ffffc90001a3fa48 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff8e3dc5a4 R09: 0000000000000001
R10: fffff52000347ede R11: 0000000000088078 R12: ffffc90001a3f6e0
R13: ffffc90001a3f6cd R14: ffffc90001a3f698 R15: ffffffff8e3dc5a8
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:738 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 lsm_file_alloc security/security.c:572 [inline]
 security_file_alloc+0x34/0x170 security/security.c:1508
 __alloc_file+0xd8/0x280 fs/file_table.c:137
 alloc_empty_file+0x6d/0x170 fs/file_table.c:181
 path_openat+0xe4/0x2940 fs/namei.c:3595
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9ff4696697
Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
RSP: 002b:00007ffe78ddb200 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ff4696697
RDX: 00000000000a0800 RSI: 00007f9ff4b4cb40 RDI: 00000000ffffff9c
RBP: 00007f9ff4b4cb40 R08: 0000000000000008 R09: 00007f9ff4b7b7b0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 9924:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 alloc_ucounts+0x1c3/0x590 kernel/ucount.c:175
 set_cred_ucounts+0x163/0x320 kernel/cred.c:682
 copy_creds+0x708/0xb50 kernel/cred.c:373
 copy_process+0x1440/0x7300 kernel/fork.c:2034
 kernel_clone+0xe7/0xab0 kernel/fork.c:2557
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 7654:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xce/0x380 mm/slub.c:4562
 put_ucounts+0x153/0x1c0 kernel/ucount.c:209
 do_dec_rlimit_put_ucounts+0xfb/0x1a0 kernel/ucount.c:299
 __sigqueue_free kernel/signal.c:455 [inline]
 __sigqueue_free kernel/signal.c:450 [inline]
 flush_sigqueue+0x18e/0x280 kernel/signal.c:469
 __exit_signal kernel/exit.c:155 [inline]
 release_task+0xbd0/0x17e0 kernel/exit.c:200
 wait_task_zombie kernel/exit.c:1116 [inline]
 wait_consider_task+0x2fa6/0x3b80 kernel/exit.c:1343
 do_wait_thread kernel/exit.c:1406 [inline]
 do_wait+0x6ca/0xce0 kernel/exit.c:1523
 kernel_wait4+0x14c/0x260 kernel/exit.c:1686
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1714
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1368
 __queue_work+0x5ca/0xf30 kernel/workqueue.c:1534
 queue_work_on+0xee/0x110 kernel/workqueue.c:1562
 queue_work include/linux/workqueue.h:502 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x42f/0x8a0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:84
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1919
 call_netdevice_notifiers_extack net/core/dev.c:1931 [inline]
 call_netdevice_notifiers net/core/dev.c:1945 [inline]
 __dev_notify_flags+0x110/0x2b0 net/core/dev.c:8176
 dev_change_flags+0x112/0x170 net/core/dev.c:8214
 do_setlink+0x96d/0x3a10 net/core/rtnetlink.c:2729
 __rtnl_newlink+0xde5/0x1750 net/core/rtnetlink.c:3412
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3527
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5592
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x904/0xdf0 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 __sys_sendto+0x21c/0x320 net/socket.c:2040
 __do_sys_sendto net/socket.c:2052 [inline]
 __se_sys_sendto net/socket.c:2048 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2048
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1368
 __queue_work+0x5ca/0xf30 kernel/workqueue.c:1534
 queue_work_on+0xee/0x110 kernel/workqueue.c:1562
 queue_work include/linux/workqueue.h:502 [inline]
 addr_event.part.0+0x326/0x4e0 drivers/infiniband/core/roce_gid_mgmt.c:853
 addr_event drivers/infiniband/core/roce_gid_mgmt.c:824 [inline]
 inet6addr_event+0x13e/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:883
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:84
 atomic_notifier_call_chain+0x70/0x180 kernel/notifier.c:199
 ipv6_add_addr+0x16bf/0x1f30 net/ipv6/addrconf.c:1161
 addrconf_add_linklocal+0x1ca/0x590 net/ipv6/addrconf.c:3197
 addrconf_addr_gen+0x387/0x3d0 net/ipv6/addrconf.c:3328
 addrconf_dev_config+0x255/0x420 net/ipv6/addrconf.c:3373
 addrconf_notify+0xdb5/0x1ba0 net/ipv6/addrconf.c:3613
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:84
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1919
 call_netdevice_notifiers_extack net/core/dev.c:1931 [inline]
 call_netdevice_notifiers net/core/dev.c:1945 [inline]
 __dev_notify_flags+0x110/0x2b0 net/core/dev.c:8176
 dev_change_flags+0x112/0x170 net/core/dev.c:8214
 do_setlink+0x96d/0x3a10 net/core/rtnetlink.c:2729
 __rtnl_newlink+0xde5/0x1750 net/core/rtnetlink.c:3412
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3527
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5592
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x904/0xdf0 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 __sys_sendto+0x21c/0x320 net/socket.c:2040
 __do_sys_sendto net/socket.c:2052 [inline]
 __se_sys_sendto net/socket.c:2048 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2048
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888147cb7b00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 28 bytes inside of
 192-byte region [ffff888147cb7b00, ffff888147cb7bc0)
The buggy address belongs to the page:
page:ffffea00051f2dc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x147cb7
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 ffffea000511fa00 dead000000000004 ffff888010c41a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 8603444765, free_ts 0
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f40 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5381
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2116
 alloc_pages+0x2b1/0x310 mm/mempolicy.c:2266
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28d/0x380 mm/slub.c:2004
 ___slab_alloc+0x6be/0xd60 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc_trace+0x289/0x2c0 mm/slub.c:3255
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
 kobject_uevent_env+0xf28/0x1600 lib/kobject_uevent.c:614
 driver_register+0x2db/0x3a0 drivers/base/driver.c:179
 hwsim_init_module+0xf9/0x174 drivers/net/ieee802154/mac802154_hwsim.c:904
 do_one_initcall+0x103/0x650 init/main.c:1303
 do_initcall_level init/main.c:1378 [inline]
 do_initcalls init/main.c:1394 [inline]
 do_basic_setup init/main.c:1413 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1618
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888147cb7a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888147cb7a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888147cb7b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888147cb7b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888147cb7c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	0f f5 ff             	pmaddwd %mm7,%mm7
   3:	ff 4c 89 ff          	decl   -0x1(%rcx,%rcx,4)
   7:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
   c:	e8 bb f1 8e 00       	callq  0x8ef1cc
  11:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
  16:	e9 2c f7 ff ff       	jmpq   0xfffff747
  1b:	e8 b3 de cb ff       	callq  0xffcbded3
  20:	e9 aa f7 ff ff       	jmpq   0xfffff7cf
  25:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
* 2a:	4c 89 e2             	mov    %r12,%rdx <-- trapping instruction
  2d:	4c 89 f7             	mov    %r14,%rdi
  30:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
  35:	4c 89 44 24 28       	mov    %r8,0x28(%rsp)
  3a:	48 8d 70 f8          	lea    -0x8(%rax),%rsi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
