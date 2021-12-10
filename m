Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E3470227
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhLJOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:00:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:57286 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLJOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:00:02 -0500
Received: by mail-io1-f71.google.com with SMTP id r199-20020a6b2bd0000000b005e234972ddfso10160488ior.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L1WItf1Tt7RvYXV3io3QlUeG2KrPmopBDJJK+xWtMAk=;
        b=dFiXLZGwS3Pus5OFnOjCajTTPS6XX9XF7U8u7mts7r4wDPfKMRRO36Cj2AewpiKSgG
         HV+3Ttp1vdDd5VeEnBAmuWDH8lLjC/nKOQPk3Y/lfTjMmSVC22QC0GM8157jfG7jVFK4
         XRVoRCbYte3yQShKNu1pQGf54Fz/xcZse2mFpDCQIwFo9BLVgZtc3Tg44oLrtrSc6TOW
         Nqu8Ie/069NBYwM2BeRzlOEN9qpLpWjSqvcXNON9hCjYrH24uSBBKychEN+90bl01gk9
         16NdTlgTeHCmrywfRW3SKtfSXMsX1MncNhiBtfsRd3ue1NmiiZvUR9zdIYkHi+UPp0+w
         9FAw==
X-Gm-Message-State: AOAM5318w6Fp6lIf45lqszsiGVdeewnBPnTbJMQJtIrwFmALn/xXrZGH
        pUbwfNMLodusH+V62F2weehQjjHQLpCVcuk/DD2Gi9eRF1we
X-Google-Smtp-Source: ABdhPJwY6ll655mn2uf0DsUDvCIwx+PNggmfj9OktPYnlIxJ/9P2ZNH7DRiKJHFMRoYRjxK0oU6gatCmEtjq8ops5JNWm3/sIjMr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:484:: with SMTP id b4mr20392909ils.173.1639144587140;
 Fri, 10 Dec 2021 05:56:27 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:56:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da226605d2cb1672@google.com>
Subject: [syzbot] KASAN: use-after-free Read in powermate_config_complete (2)
From:   syzbot <syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14738d75b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=9780d2b05ac158d32284
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com

powermate: config urb returned -108
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4897
Read of size 8 at addr ffff888019f26458 by task syz-executor.2/12264

CPU: 0 PID: 12264 Comm: syz-executor.2 Not tainted 5.16.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4897
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 powermate_config_complete+0x79/0xb0 drivers/input/misc/powermate.c:202
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1656
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:tomoyo_domain_quota_is_ok+0x17d/0x550 security/tomoyo/util.c:1059
Code: e9 8a d4 fd 48 8d 7d 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 42 0f b6 04 30 38 d0 7f 08 84 c0 0f 85 4a 03 00 00 0f b6 5d 18 <31> ff 89 de e8 9a 8e d4 fd 84 db 0f 85 65 ff ff ff e8 ad 8a d4 fd
RSP: 0018:ffffc90006107a40 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90002d95000
RDX: 0000000000000000 RSI: ffffffff83a32007 RDI: ffff888010dc7a98
RBP: ffff888010dc7a80 R08: 0000000000000000 R09: 0000000000000010
R10: ffffffff83a321da R11: 0000000000000010 R12: 0000000000000062
R13: 00000000000001c3 R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x419/0x590 security/tomoyo/file.c:734
 security_file_ioctl+0x50/0xb0 security/security.c:1541
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc18e33daf9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc18d2b3188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc18e450f60 RCX: 00007fc18e33daf9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00007fc18e397ff7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc18e984b2f R14: 00007fc18d2b3300 R15: 0000000000022000
 </TASK>

Allocated by task 20790:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 powermate_probe+0x24a/0x12a0 drivers/input/misc/powermate.c:323
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x23e5/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 12256:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1723 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1749
 slab_free mm/slub.c:3513 [inline]
 kfree+0xf6/0x560 mm/slub.c:4561
 powermate_disconnect+0x1ce/0x250 drivers/input/misc/powermate.c:432
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_quiesce+0x170/0x310 drivers/usb/core/hub.c:1327
 hub_disconnect+0xcb/0x510 drivers/usb/core/hub.c:1722
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
 proc_disconnect_claim+0x217/0x380 drivers/usb/core/devio.c:2464
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x2b43/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3550
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1647
 unregister_sysctl_table fs/proc/proc_sysctl.c:1685 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1660
 __devinet_sysctl_unregister net/ipv4/devinet.c:2604 [inline]
 devinet_exit_net+0x186/0x280 net/ipv4/devinet.c:2745
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3550
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1647
 unregister_sysctl_table fs/proc/proc_sysctl.c:1685 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1660
 vrf_netns_exit_sysctl drivers/net/vrf.c:1990 [inline]
 vrf_netns_exit+0x153/0x2c0 drivers/net/vrf.c:2017
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff888019f26400
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 88 bytes inside of
 256-byte region [ffff888019f26400, ffff888019f26500)
The buggy address belongs to the page:
page:ffffea000067c980 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888019f26200 pfn:0x19f26
head:ffffea000067c980 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00013e0408 ffffea0001bf1c08 ffff888010c41b40
raw: ffff888019f26200 000000000010000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6602, ts 113859934011, free_ts 113844564099
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc_trace+0x289/0x2c0 mm/slub.c:3259
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 fib6_info_alloc+0xc1/0x210 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x33e/0x1aa0 net/ipv6/route.c:3773
 ip6_route_add+0x24/0x150 net/ipv6/route.c:3867
 addrconf_prefix_route+0x30a/0x4e0 net/ipv6/addrconf.c:2424
 fixup_permanent_addr net/ipv6/addrconf.c:3458 [inline]
 addrconf_permanent_addr net/ipv6/addrconf.c:3482 [inline]
 addrconf_notify+0x1298/0x1bb0 net/ipv6/addrconf.c:3550
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 __dev_notify_flags+0x110/0x2b0 net/core/dev.c:8834
 dev_change_flags+0x112/0x170 net/core/dev.c:8872
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 __unfreeze_partials+0x343/0x360 mm/slub.c:2527
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3234 [inline]
 kmem_cache_alloc_node+0x255/0x3f0 mm/slub.c:3270
 __alloc_skb+0x215/0x340 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1126 [inline]
 alloc_skb_with_frags+0x93/0x620 net/core/skbuff.c:6078
 sock_alloc_send_pskb+0x783/0x910 net/core/sock.c:2575
 mld_newpack+0x1df/0x770 net/ipv6/mcast.c:1754
 add_grhead+0x265/0x330 net/ipv6/mcast.c:1857
 add_grec+0x1053/0x14e0 net/ipv6/mcast.c:1995
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x452/0xdc0 net/ipv6/mcast.c:2659
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445

Memory state around the buggy address:
 ffff888019f26300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888019f26380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888019f26400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888019f26480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888019f26500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	e9 8a d4 fd 48       	jmpq   0x48fdd48f
   5:	8d 7d 18             	lea    0x18(%rbp),%edi
   8:	48 89 f8             	mov    %rdi,%rax
   b:	48 89 fa             	mov    %rdi,%rdx
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	83 e2 07             	and    $0x7,%edx
  15:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  1a:	38 d0                	cmp    %dl,%al
  1c:	7f 08                	jg     0x26
  1e:	84 c0                	test   %al,%al
  20:	0f 85 4a 03 00 00    	jne    0x370
  26:	0f b6 5d 18          	movzbl 0x18(%rbp),%ebx
* 2a:	31 ff                	xor    %edi,%edi <-- trapping instruction
  2c:	89 de                	mov    %ebx,%esi
  2e:	e8 9a 8e d4 fd       	callq  0xfdd48ecd
  33:	84 db                	test   %bl,%bl
  35:	0f 85 65 ff ff ff    	jne    0xffffffa0
  3b:	e8 ad 8a d4 fd       	callq  0xfdd48aed


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
