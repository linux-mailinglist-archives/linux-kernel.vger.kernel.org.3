Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE45A9291
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiIAI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiIAI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:58:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8358130A17
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:58:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id a21-20020a5d9815000000b006882e9be20aso10233589iol.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gnwWiTBesqBtTpf5srkJZwPb9vI4gWm69WHle44tYRo=;
        b=pCwUoBR+JVQ0CmNGhVQnacNb0VD6Ovh5Id5MxtZWN3oW+BzAFqmiTTJ0pxOuxpGwhK
         gQ5ajvwOSZ+u4/ECGy424yqQmrz5208nZJdXDja0jC6epU3PLAUE6hn98RO2AltCxwA0
         iTSjVgVLmVOP0JTxYNsPK6/3+/a4B5+lUKpQJ+a9CxcY8D7/+4jGhDUVNT0goRZgLRF7
         eAh+l/eXKzWtdEkpvhfzgqdzFIhiGIMzww4UQ1Qg+E/aMe85zcJzMkHJPmw6RkXPEQgp
         2MHWeMh63pgK47FABIvQsYRlJ4fm3WpEnxXOjGJiTuy47NIhTJhGEf1U1Au4ucplfSDG
         8few==
X-Gm-Message-State: ACgBeo2pf9k9SNYugshyT2TsfZOENcAcOOGvJQHJebI/j5BZjYdFFMFw
        z9CvfSPxUwR4gosoiSmhvmfnrV+ipoAItVESeCiTf2U7tMni
X-Google-Smtp-Source: AA6agR5v6uN4hx4zcEDZtvnuTGYrZDGbSFRFNEEjdtGnGAhKNE0fnddXuT2gRviFiwcw3bsR08uZWHc9hUl7cPKTuuluWRcr46EE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1baf:b0:2e0:e64c:c68b with SMTP id
 n15-20020a056e021baf00b002e0e64cc68bmr16300244ili.200.1662022705123; Thu, 01
 Sep 2022 01:58:25 -0700 (PDT)
Date:   Thu, 01 Sep 2022 01:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f296b105e799d0d6@google.com>
Subject: [syzbot] KASAN: use-after-free Read in powermate_config_complete (4)
From:   syzbot <syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
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

HEAD commit:    ffcf9c5700e4 x86: link vdso and boot with -z noexecstack -..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15757783080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62757afbf52714ca
dashboard link: https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/7f6fb0733c70/disk-ffcf9c57.raw.xz
vmlinux: https://storage.googleapis.com/767503818e0d/vmlinux-ffcf9c57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com

powermate 5-1:0.0: powermate_irq - usb_submit_urb failed with result: -19
powermate: config urb returned -71
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
Read of size 8 at addr ffff88813fb04058 by task ksoftirqd/1/19

CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.19.0-syzkaller-13666-gffcf9c5700e4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 powermate_config_complete+0x79/0xb0 drivers/input/misc/powermate.c:202
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1c0/0x9a9 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 24122:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 __kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 powermate_probe+0x24a/0x12a0 drivers/input/misc/powermate.c:323
 usb_probe_interface+0x30b/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x206/0x2e0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd4/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x206/0x2e0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26c7/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 24523:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x14a/0x1b0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kfree+0xca/0x5c0 mm/slub.c:4562
 powermate_disconnect+0x1ce/0x250 drivers/input/misc/powermate.c:432
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:520 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:512
 __device_release_driver drivers/base/dd.c:1209 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1235
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88813fb04000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 88 bytes inside of
 256-byte region [ffff88813fb04000, ffff88813fb04100)

The buggy address belongs to the physical page:
page:ffffea0004fec100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13fb04
head:ffffea0004fec100 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 ffffea0004021380 dead000000000004 ffff888100041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 20353, tgid 20353 (syz-executor.1), ts 1943819602580, free_ts 1943661399748
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x11cc/0x2a20 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7b4/0xda0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x2ea/0x320 mm/slub.c:4420
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 ops_init+0xfb/0x470 net/core/net_namespace.c:125
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:326
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:472
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:227
 ksys_unshare+0x445/0x920 kernel/fork.c:3183
 __do_sys_unshare kernel/fork.c:3254 [inline]
 __se_sys_unshare kernel/fork.c:3252 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3252
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5d2/0xb80 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x420 mm/page_alloc.c:3476
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x78/0x80 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x354/0x4a0 mm/slub.c:3268
 vm_area_alloc+0x1c/0x110 kernel/fork.c:459
 mmap_region+0x7fd/0x12b0 mm/mmap.c:1729
 do_mmap+0x863/0xfa0 mm/mmap.c:1540
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:552
 ksys_mmap_pgoff+0x41b/0x5a0 mm/mmap.c:1586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88813fb03f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813fb03f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813fb04000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88813fb04080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813fb04100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
