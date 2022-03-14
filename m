Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DD4D8635
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiCNNue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCNNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:50:32 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF740A3C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:49:19 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u25-20020a5d8199000000b006421bd641bbso12316580ion.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xuBC5gwn7vhLmy5l6WeBh5449G2AmRJl+kcUIDDVmto=;
        b=5BcMEzHE3Xt1fw/Qqieq7ulWn57ALeUbOvuauortXkW0O2aSeq+pORv8GMnYv44TS+
         W2fSBbsjspDbLYljAW5gspuxKQbyQ3OVQA5jlWkOG38+6iC+viS8myGcS7kV5lnbP6KY
         +ge9OzrNKk5OkXiJ24Bc8Aq1p2KUKnpSo5VTtEnFfpbLiQKa2k1WYUydb+xNBaW1EFEQ
         JrikgGMjB14oX5rnqxlsf+6mfqz0k/LCvJQRtPRHCYKvw1mhJUpoh0ycX+u99HCTN3ZJ
         mdg1OnwV1YWi03bzvyEx2bgie9SxcLjG8Hl7XwppQo+nfuq8J19pEGY84hkI5bw/wlP8
         CMtg==
X-Gm-Message-State: AOAM5306JhqC1AKqZCoWqiKrhjaQyOfPzhYHTNCr8lC58orxRVmLeZgj
        UTwSOh1k8aKGQH2Yl4IzV+WjoY2DFnJvdh99tyk+pzmRC/NB
X-Google-Smtp-Source: ABdhPJzD1ejbznbCYtwdlt7iTG+eYixbQc6hqLVsNlH68b3vWJCgOe/r5ZJEsn3Qu5dTEM7tBU8Tpr1aakL4DWJnYn2LW+J3Xkh8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1488:b0:314:2073:afe2 with SMTP id
 j8-20020a056638148800b003142073afe2mr21063875jak.56.1647265759034; Mon, 14
 Mar 2022 06:49:19 -0700 (PDT)
Date:   Mon, 14 Mar 2022 06:49:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b04e005da2df2f3@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_get
From:   syzbot <syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com>
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

HEAD commit:    09688c0166e7 Linux 5.17-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b42729700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6da459dcfde3b8d0
dashboard link: https://syzkaller.appspot.com/bug?extid=97a16334dbd58916f7fb
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97a16334dbd58916f7fb@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/adi930.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/adi930.fw
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in kernfs_get+0x1c/0x90 fs/kernfs/dir.c:496
Read of size 4 at addr ffff88801ded39f8 by task kworker/1:2/2510

CPU: 1 PID: 2510 Comm: kworker/1:2 Not tainted 5.17.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x65/0x3a0 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 kernfs_get+0x1c/0x90 fs/kernfs/dir.c:496
 sysfs_get include/linux/sysfs.h:635 [inline]
 create_dir lib/kobject.c:111 [inline]
 kobject_add_internal+0x5e5/0xb50 lib/kobject.c:255
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

Allocated by task 2510:
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

Freed by task 7376:
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

The buggy address belongs to the object at ffff88801ded39f8
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 0 bytes inside of
 168-byte region [ffff88801ded39f8, ffff88801ded3aa0)
The buggy address belongs to the page:
page:ffffea000077b4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ded3
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001d9dd80 dead000000000002 ffff888140007b40
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3627, ts 120049121188, free_ts 120016924446
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
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x54c/0xed0 fs/sysfs/group.c:148
 internal_create_groups fs/sysfs/group.c:188 [inline]
 sysfs_create_groups+0x5d/0x130 fs/sysfs/group.c:214
 create_dir lib/kobject.c:100 [inline]
 kobject_add_internal+0x5a1/0xb50 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_init_and_add+0x123/0x190 lib/kobject.c:473
 netdev_queue_add_kobject net/core/net-sysfs.c:1653 [inline]
 netdev_queue_update_kobjects+0x214/0x4c0 net/core/net-sysfs.c:1705
 register_queue_kobjects net/core/net-sysfs.c:1766 [inline]
 netdev_register_kobject+0x263/0x310 net/core/net-sysfs.c:2012
 register_netdevice+0x127a/0x1c00 net/core/dev.c:9667
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0xd1c/0xe00 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x7d/0x580 mm/page_alloc.c:3404
 free_slab mm/slub.c:2043 [inline]
 discard_slab mm/slub.c:2049 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2536
 put_cpu_partial+0x116/0x180 mm/slub.c:2612
 do_slab_free mm/slub.c:3497 [inline]
 ___cache_free+0x107/0x160 mm/slub.c:3516
 qlist_free_all mm/kasan/quarantine.c:176 [inline]
 kasan_quarantine_reduce+0x169/0x1f0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 kmem_cache_alloc_node+0x201/0x370 mm/slub.c:3266
 __alloc_skb+0xd8/0x5a0 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1158 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 rtmsg_ifinfo_build_skb+0x81/0x190 net/core/rtnetlink.c:3833
 rtmsg_ifinfo_event net/core/rtnetlink.c:3869 [inline]
 rtnetlink_event+0xed/0x1b0 net/core/rtnetlink.c:5647
 notifier_call_chain kernel/notifier.c:84 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:392
 call_netdevice_notifiers_info net/core/dev.c:1919 [inline]
 netdev_lower_state_changed+0x1a4/0x250 net/core/dev.c:7894
 team_lower_state_changed drivers/net/team/team.c:89 [inline]
 team_refresh_port_linkup drivers/net/team/team.c:99 [inline]
 __team_port_change_send+0x20b/0x5a0 drivers/net/team/team.c:2902
 __team_port_change_check drivers/net/team/team.c:2949 [inline]
 team_port_change_check+0x9c/0x210 drivers/net/team/team.c:2971
 team_device_event+0x388/0x410 drivers/net/team/team.c:3000

Memory state around the buggy address:
 ffff88801ded3880: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff88801ded3900: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801ded3980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
                                                                ^
 ffff88801ded3a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ded3a80: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
