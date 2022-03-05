Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5C4CE62E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiCERJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 12:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiCERJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 12:09:12 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E023BD5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 09:08:22 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c13-20020a5e8f0d000000b00644c39c4c69so7597245iok.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 09:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vHQtDbEKPciDEUBtrlmKgVGEoFccyuLghhpOzsslT/A=;
        b=g1BlQkAFj/VzKaiDY2F5sjv458KhY5g5vWTMziQAKY2sRrLCE4/IsyDEva1r433oYq
         xC7GIe6RWn/d/4VAqP+fbAKdbnXdCiL+b48bra6TKS9nocZ9XJZUxo+20DosHjd0cWRn
         a9kg2CFeAi7sa/hVxKrn/eRo0Kv+Um1EYDWJpi08kE3I9NfdrKwzurSTe0n0W3F31c0P
         ppSPwqm8l7360hetmN7Ry/OnRBJT2mcTgW4ef5/quJ0yGVg/ZkT99w6eh/XRUhu9Rzvc
         /d0Gg+a5IXCSKWryyQLvUnVYl6LvmRnn29QXz020w1IwvnU5aqu1jHduN2IqdXi2OCTY
         Dx/Q==
X-Gm-Message-State: AOAM533vLirIwzxfc5hkNAf4Pq5p3tS3bKN1LXI4nmOeIFXgYXeC6g5j
        DxmIKnAvvEJRpp8u51yXRf7BTwgDqAsd+Z3GMnBjhMLfe8BY
X-Google-Smtp-Source: ABdhPJx3UBnWJBUFvpANzTbPtxTJcoY1YSMGd+oJcoI+WNDfjOMvZlSaFkNmPf9JyUDTsjlHKiba1tUOGsndb2EEfojEWHhaViBW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:2c2:c95a:c390 with SMTP id
 h10-20020a056e021d8a00b002c2c95ac390mr4104852ila.322.1646500101563; Sat, 05
 Mar 2022 09:08:21 -0800 (PST)
Date:   Sat, 05 Mar 2022 09:08:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad2a2705d97bad64@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_activate
From:   syzbot <syzbot+82240fa5f8dffe45d4f1@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    719fce7539cd Merge tag 'soc-fixes-5.17-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15240076700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66c6970b31a1a2ff
dashboard link: https://syzkaller.appspot.com/bug?extid=82240fa5f8dffe45d4f1
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82240fa5f8dffe45d4f1@syzkaller.appspotmail.com

usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:48 [inline]
BUG: KASAN: use-after-free in kernfs_next_descendant_post fs/kernfs/dir.c:1272 [inline]
BUG: KASAN: use-after-free in kernfs_activate+0xef/0x520 fs/kernfs/dir.c:1312
Read of size 8 at addr ffff88802e502118 by task kworker/0:9/14749

CPU: 0 PID: 14749 Comm: kworker/0:9 Not tainted 5.17.0-rc6-syzkaller-00046-g719fce7539cd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x65/0x3a0 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
 kernfs_root fs/kernfs/kernfs-internal.h:48 [inline]
 kernfs_next_descendant_post fs/kernfs/dir.c:1272 [inline]
 kernfs_activate+0xef/0x520 fs/kernfs/dir.c:1312
 kernfs_add_one+0x56c/0x6d0 fs/kernfs/dir.c:767
 kernfs_create_dir_ns+0x1bf/0x220 fs/kernfs/dir.c:1004
 sysfs_create_dir_ns+0x181/0x390 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x418/0xb50 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x14c/0x210 lib/kobject.c:442
 class_dir_create_and_add drivers/base/core.c:2942 [inline]
 get_device_parent+0x3d5/0x430 drivers/base/core.c:2997
 device_add+0x3b7/0x16d0 drivers/base/core.c:3326
 fw_load_sysfs_fallback+0xd2/0x7d0 drivers/base/firmware_loader/fallback.c:512
 fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:588
 _request_firmware+0x3b9/0x670 drivers/base/firmware_loader/main.c:774
 request_firmware_work_func+0x128/0x270 drivers/base/firmware_loader/main.c:1020
 process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
 worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 14749:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x1c9/0x310 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:704 [inline]
 __kernfs_new_node+0xdb/0x720 fs/kernfs/dir.c:585
 kernfs_new_node fs/kernfs/dir.c:647 [inline]
 kernfs_create_dir_ns+0x90/0x220 fs/kernfs/dir.c:994
 sysfs_create_dir_ns+0x181/0x390 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x418/0xb50 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x14c/0x210 lib/kobject.c:442
 class_dir_create_and_add drivers/base/core.c:2942 [inline]
 get_device_parent+0x3d5/0x430 drivers/base/core.c:2997
 device_add+0x3b7/0x16d0 drivers/base/core.c:3326
 fw_load_sysfs_fallback+0xd2/0x7d0 drivers/base/firmware_loader/fallback.c:512
 fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:588
 _request_firmware+0x3b9/0x670 drivers/base/firmware_loader/main.c:774
 request_firmware_work_func+0x128/0x270 drivers/base/firmware_loader/main.c:1020
 process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
 worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30

Freed by task 14455:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0x126/0x180 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kmem_cache_free+0xb6/0x1c0 mm/slub.c:3526
 kernfs_put+0x340/0x490 fs/kernfs/dir.c:539
 __kernfs_remove+0xe80/0x1150 fs/kernfs/dir.c:1388
 kernfs_remove+0x6c/0x80 fs/kernfs/dir.c:1403
 __kobject_del+0xcc/0x310 lib/kobject.c:620
 kobject_del+0x41/0x60 lib/kobject.c:643
 device_del+0xa1e/0xbf0 drivers/base/core.c:3603
 usb_disconnect+0x56f/0x8a0 drivers/usb/core/hub.c:2254
 hub_port_connect+0x29c/0x2910 drivers/usb/core/hub.c:5202
 hub_port_connect_change+0x5f9/0xc20 drivers/usb/core/hub.c:5502
 port_event+0xca0/0x13e0 drivers/usb/core/hub.c:5660
 hub_event+0x4ed/0xe40 drivers/usb/core/hub.c:5742
 process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
 process_scheduled_works kernel/workqueue.c:2370 [inline]
 worker_thread+0xe18/0x1300 kernel/workqueue.c:2456
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff88802e5020e8
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 48 bytes inside of
 168-byte region [ffff88802e5020e8, ffff88802e502190)
The buggy address belongs to the page:
page:ffffea0000b94080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e502
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888140007b40
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 14455, ts 555782168656, free_ts 555704660304
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x729/0x9e0 mm/page_alloc.c:4165
 __alloc_pages+0x255/0x580 mm/page_alloc.c:5389
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0xce/0x3f0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x3fe/0xc30 mm/slub.c:3018
 __slab_alloc mm/slub.c:3105 [inline]
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x276/0x310 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:704 [inline]
 __kernfs_new_node+0xdb/0x720 fs/kernfs/dir.c:585
 kernfs_new_node+0x95/0x160 fs/kernfs/dir.c:647
 __kernfs_create_file+0x45/0x2e0 fs/kernfs/file.c:987
 sysfs_add_file_mode_ns+0x21d/0x330 fs/sysfs/file.c:294
 sysfs_merge_group+0x1ff/0x430 fs/sysfs/group.c:342
 dpm_sysfs_add+0xbd/0x260 drivers/base/power/sysfs.c:707
 device_add+0xe2c/0x16d0 drivers/base/core.c:3362
 usb_create_ep_devs+0x12e/0x240 drivers/usb/core/endpoint.c:169
 usb_new_device+0x117c/0x1940 drivers/usb/core/hub.c:2594
 hub_port_connect+0x100b/0x2910 drivers/usb/core/hub.c:5358
 hub_port_connect_change+0x5f9/0xc20 drivers/usb/core/hub.c:5502
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0xd1c/0xe00 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x7d/0x580 mm/page_alloc.c:3404
 do_slab_free mm/slub.c:3497 [inline]
 ___cache_free+0x107/0x160 mm/slub.c:3516
 qlist_free_all mm/kasan/quarantine.c:176 [inline]
 kasan_quarantine_reduce+0x169/0x1f0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 __kmalloc_node+0x21f/0x420 mm/slub.c:4468
 kmalloc_node include/linux/slab.h:604 [inline]
 kvmalloc_node+0x6e/0xe0 mm/util.c:580
 kvmalloc include/linux/slab.h:731 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x1f6/0xd30 fs/seq_file.c:210
 call_read_iter include/linux/fs.h:2068 [inline]
 new_sync_read fs/read_write.c:400 [inline]
 vfs_read+0xaf9/0xe60 fs/read_write.c:481
 ksys_read+0x18f/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88802e502000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e502080: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
>ffff88802e502100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802e502180: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802e502200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
