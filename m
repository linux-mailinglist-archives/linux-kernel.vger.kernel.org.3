Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A752567F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiGFHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiGFHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:16:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27561222A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:16:34 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h7-20020a05660224c700b0067898a33ceaso2506745ioe.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y03HAd2n7KrZBQcSvwfN+i2mGrLafM6uP4es/cAva+0=;
        b=taQOeLwKlmbF8vru2aIAfjM+J6ttIwzwSwMZ6fVXNWQKwlgYUOGyMBVtXg1lOQmyM5
         w+917prmN6Ri5+MC/FvfFrML5KzDxIlQX5XmBBnod6/Wn7r/U3hHDCxTenStrB0ZIU2g
         q8q29PyReMseLyce1BhguhBbwt2fGADOeH+W069OS8iO6csJ/LjM9aY5fKg/L+/qps1X
         Zo0j/KPMMci2ImN54dv73wfNH5eKaAH/3F1QfecbeL+ZZD5clpbF3Q8InUuhWyfePMhT
         yIYYJ/c25wgrbyXlKjiM2PEdMQZ9Myie4xN18WQtfUN08t3MlJVCk0dpl3aghPltl3Aj
         sKig==
X-Gm-Message-State: AJIora+o2fE87gkUVm7GfEImRZLK2dS23lVNasxUKH1w+g/oIjgmDe2C
        cN9Qo5MnhHyCpXMzK7ddUnpXIs7qpX6IKEGv+bHBv0wU5HFS
X-Google-Smtp-Source: AGRyM1vHm5Mh9RYGgDHbEGlD2beM9F8hE+cfdvKS2cFxsyuITDWF0XmkU8iySLqzsC+qTQYLN95DvfoEa8noa/y17KbORxW4ohBH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3298:b0:675:7d23:6643 with SMTP id
 d24-20020a056602329800b006757d236643mr19863638ioz.143.1657091793403; Wed, 06
 Jul 2022 00:16:33 -0700 (PDT)
Date:   Wed, 06 Jul 2022 00:16:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4c85f05e31dbfe4@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_xattr_get
From:   syzbot <syzbot+5369664846610db4fa13@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1ce8c443e956 Merge tag 'thermal-5.19-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17851f98080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a010dbf6a7af480
dashboard link: https://syzkaller.appspot.com/bug?extid=5369664846610db4fa13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5369664846610db4fa13@syzkaller.appspotmail.com

usb 8-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 8-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: use-after-free in __kernfs_iattrs fs/kernfs/inode.c:34 [inline]
BUG: KASAN: use-after-free in kernfs_iattrs_noalloc fs/kernfs/inode.c:65 [inline]
BUG: KASAN: use-after-free in kernfs_xattr_get+0x91/0xa0 fs/kernfs/inode.c:303
Read of size 8 at addr ffff88801accf650 by task kworker/0:3/3502

CPU: 0 PID: 3502 Comm: kworker/0:3 Not tainted 5.19.0-rc4-syzkaller-00185-g1ce8c443e956 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x467 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 __kernfs_iattrs fs/kernfs/inode.c:34 [inline]
 kernfs_iattrs_noalloc fs/kernfs/inode.c:65 [inline]
 kernfs_xattr_get+0x91/0xa0 fs/kernfs/inode.c:303
 selinux_kernfs_init_security+0xf2/0x4c0 security/selinux/hooks.c:3509
 security_kernfs_init_security+0x48/0xa0 security/security.c:1510
 __kernfs_new_node+0x54f/0x8b0 fs/kernfs/dir.c:632
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2ce/0x900 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 class_dir_create_and_add drivers/base/core.c:2954 [inline]
 get_device_parent+0x3d7/0x590 drivers/base/core.c:3009
 device_add+0x2af/0x1ea0 drivers/base/core.c:3338
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2da/0xbb0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbd2/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Allocated by task 15:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x85/0xb0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc mm/slab.c:3302 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3479 [inline]
 kmem_cache_alloc+0x265/0x560 mm/slab.c:3499
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2ce/0x900 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 device_add+0x36d/0x1ea0 drivers/base/core.c:3352
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x25d5/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Freed by task 15:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x13d/0x180 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 __cache_free mm/slab.c:3425 [inline]
 kmem_cache_free.part.0+0xa9/0x240 mm/slab.c:3735
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:547
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 sysfs_put include/linux/sysfs.h:641 [inline]
 __kobject_del+0xea/0x200 lib/kobject.c:589
 kobject_del lib/kobject.c:611 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:603
 device_del+0x81c/0xc80 drivers/base/core.c:3615
 usb_disconnect.cold+0x4ba/0x6ec drivers/usb/core/hub.c:2254
 hub_port_connect drivers/usb/core/hub.c:5207 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

The buggy address belongs to the object at ffff88801accf5b0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 160 bytes inside of
 168-byte region [ffff88801accf5b0, ffff88801accf658)

The buggy address belongs to the physical page:
page:ffffea00006b33c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801accfa38 pfn:0x1accf
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00006f2e48 ffffea00006cfe48 ffff888012215000
raw: ffff88801accfa38 ffff88801accf040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 3824, tgid 3815 (syz-executor.3), ts 192593686130, free_ts 192576612676
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x1290/0x3b70 mm/page_alloc.c:4198
 __alloc_pages_slowpath.constprop.0+0x2e9/0x2160 mm/page_alloc.c:4973
 __alloc_pages+0x436/0x510 mm/page_alloc.c:5439
 __alloc_pages_node include/linux/gfp.h:587 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x350 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3024 [inline]
 ____cache_alloc mm/slab.c:3007 [inline]
 __do_cache_alloc mm/slab.c:3253 [inline]
 slab_alloc mm/slab.c:3295 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3479 [inline]
 kmem_cache_alloc+0x450/0x560 mm/slab.c:3499
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1010
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2ce/0x900 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x101/0x160 lib/kobject.c:441
 nfs_netns_client_alloc fs/nfs/sysfs.c:163 [inline]
 nfs_netns_sysfs_setup+0xc4/0x160 fs/nfs/sysfs.c:175
 nfs_net_init+0x11/0x20 fs/nfs/inode.c:2341
 ops_init+0xaf/0x470 net/core/net_namespace.c:134
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:325
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:471
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
 slab_destroy mm/slab.c:1615 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1635
 cache_flusharray mm/slab.c:3397 [inline]
 ___cache_free+0x34e/0x670 mm/slab.c:3460
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4f/0x1b0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc mm/slab.c:3302 [inline]
 __do_kmalloc mm/slab.c:3694 [inline]
 __kmalloc_track_caller+0x277/0x4d0 mm/slab.c:3711
 kmemdup_nul+0x2d/0xa0 mm/util.c:152
 security_context_to_sid_core+0xb4/0x820 security/selinux/ss/services.c:1531
 security_context_to_sid+0x35/0x40 security/selinux/ss/services.c:1607
 selinux_inode_setxattr+0x36e/0x8a0 security/selinux/hooks.c:3191
 security_inode_setxattr+0xf1/0x240 security/security.c:1359
 __vfs_setxattr_locked+0xa5/0x260 fs/xattr.c:268
 vfs_setxattr+0x13f/0x330 fs/xattr.c:303
 setxattr+0x146/0x160 fs/xattr.c:611

Memory state around the buggy address:
 ffff88801accf500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88801accf580: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
>ffff88801accf600: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                                                 ^
 ffff88801accf680: fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801accf700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
