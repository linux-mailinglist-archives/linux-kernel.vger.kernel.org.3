Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9047A4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhLTGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:24:27 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35823 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhLTGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:24:24 -0500
Received: by mail-io1-f70.google.com with SMTP id x11-20020a0566022c4b00b005e702603028so6556636iov.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 22:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ojqEaAhKapGt9pT+17rb8zrjKsb/aFm2qhBV+nRiYRo=;
        b=uLRd6O6nINE3wbYajRZKYc8l47+u4/Jgi2cEM55CVbck0bLHmvnn0OkXxuSOVnrGST
         kECOkRXGwVJZPG8gYYqxOW6ob2CEtuV80af+/k9XScx+dtUmpM/09vb8YTV1E2X6AOoE
         Fgtmbw77uEbJMCQbRHPuG5V5SY/wYJgb8/Dz+ZMDu6weMypq/VDxr51/plUHh7BlG9G/
         ZHtQoioqUFaej/8baEMWpQatf8qZQh3wuMPprlR5Gwa9NlfYxU53sXX5oqobJRe5y7yU
         g2ciwdf55KEPB4cX8R8xRABeMWvQWQAKf0wbFva86Qu8PUePLC/bLs7127xQ+3+5Lc2I
         IM0A==
X-Gm-Message-State: AOAM533gpW+oToCBKTkg8ChMkhSVfd1pFQX6jBH8QW8qjGj3F06AoVNq
        HVkgaf/qGrQG293elGC9T4C5G/VIJfTGGgUm/bWxzS+N02Le
X-Google-Smtp-Source: ABdhPJzWAgeIe6diX8umv+n0qDu5Bq5XSM8YNZhuywzGTs9VCsJ24D2qe6/GO/0a3c3FkTvMoMZs9zuk4/lavaw7315nMoPf90MR
MIME-Version: 1.0
X-Received: by 2002:a92:d407:: with SMTP id q7mr7387598ilm.251.1639981464219;
 Sun, 19 Dec 2021 22:24:24 -0800 (PST)
Date:   Sun, 19 Dec 2021 22:24:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cf46b05d38df092@google.com>
Subject: [syzbot] KASAN: use-after-free Read in tty_write_room
From:   syzbot <syzbot+f1c7696a5552d2b56ca4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10036ccdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=f1c7696a5552d2b56ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1c7696a5552d2b56ca4@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: use-after-free in tty_write_room+0x76/0x80 drivers/tty/tty_ioctl.c:78
Read of size 8 at addr ffff88808d3b1018 by task aoe_tx0/1224

CPU: 1 PID: 1224 Comm: aoe_tx0 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 tty_write_room+0x76/0x80 drivers/tty/tty_ioctl.c:78
 handle_tx+0x159/0x610 drivers/net/caif/caif_serial.c:226
 __netdev_start_xmit include/linux/netdevice.h:4994 [inline]
 netdev_start_xmit include/linux/netdevice.h:5008 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x1eb/0x920 net/core/dev.c:3606
 __dev_queue_xmit+0x299a/0x3650 net/core/dev.c:4229
 tx+0x68/0xb0 drivers/block/aoe/aoenet.c:63
 kthread+0x1e7/0x3b0 drivers/block/aoe/aoecmd.c:1230
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 20462:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 alloc_tty_struct+0x94/0x920 drivers/tty/tty_io.c:3122
 tty_init_dev.part.0+0x20/0x610 drivers/tty/tty_io.c:1422
 tty_init_dev+0x5b/0x80 drivers/tty/tty_io.c:1419
 ptmx_open drivers/tty/pty.c:834 [inline]
 ptmx_open+0x112/0x360 drivers/tty/pty.c:800
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x1250 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1cad/0x2750 fs/namei.c:3559
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_openat fs/open.c:1244 [inline]
 __se_sys_openat fs/open.c:1239 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 3204:
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
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1354
 __queue_work+0x5ca/0xee0 kernel/workqueue.c:1520
 queue_work_on+0xee/0x110 kernel/workqueue.c:1547
 kref_put include/linux/kref.h:65 [inline]
 tty_kref_put drivers/tty/tty_io.c:1581 [inline]
 release_tty+0x4e9/0x610 drivers/tty/tty_io.c:1618
 tty_release_struct+0xb4/0xe0 drivers/tty/tty_io.c:1717
 tty_release+0xc70/0x1200 drivers/tty/tty_io.c:1878
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xc14/0x2b40 kernel/exit.c:832
 do_group_exit+0x125/0x310 kernel/exit.c:929
 get_signal+0x47d/0x2220 kernel/signal.c:2852
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3550
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1647
 unregister_sysctl_table fs/proc/proc_sysctl.c:1685 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1660
 __devinet_sysctl_unregister net/ipv4/devinet.c:2604 [inline]
 devinet_sysctl_unregister net/ipv4/devinet.c:2632 [inline]
 inetdev_destroy net/ipv4/devinet.c:326 [inline]
 inetdev_event+0xcaf/0x15d0 net/ipv4/devinet.c:1600
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 unregister_netdevice_many+0x94f/0x1790 net/core/dev.c:11080
 unregister_netdevice_queue+0x2dd/0x3c0 net/core/dev.c:11014
 unregister_netdevice include/linux/netdevice.h:2989 [inline]
 unregister_netdev+0x18/0x20 net/core/dev.c:11139
 sixpack_close+0x184/0x270 drivers/net/hamradio/6pack.c:674
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:474
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:629
 tty_ldisc_release+0xe3/0x2a0 drivers/tty/tty_ldisc.c:803
 tty_release_struct+0x20/0xe0 drivers/tty/tty_io.c:1706
 tty_release+0xc70/0x1200 drivers/tty/tty_io.c:1878
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88808d3b1000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 2048-byte region [ffff88808d3b1000, ffff88808d3b1800)
The buggy address belongs to the page:
page:ffffea000234ec00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8d3b0
head:ffffea000234ec00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888010c42000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 19949, ts 1477681241546, free_ts 1477666677183
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
 __kmalloc_track_caller+0x2e7/0x320 mm/slub.c:4925
 kmemdup+0x23/0x50 mm/util.c:128
 kmemdup include/linux/fortify-string.h:304 [inline]
 neigh_sysctl_register+0x9a/0x680 net/core/neighbour.c:3725
 devinet_sysctl_register+0xb1/0x230 net/ipv4/devinet.c:2618
 inetdev_init+0x267/0x560 net/ipv4/devinet.c:278
 inetdev_event+0xa8a/0x15d0 net/ipv4/devinet.c:1532
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 register_netdevice+0x1073/0x1500 net/core/dev.c:10367
 register_netdev+0x2d/0x50 net/core/dev.c:10460
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
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3247
 kmem_cache_zalloc include/linux/slab.h:714 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:585
 kernfs_new_node fs/kernfs/dir.c:647 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:984
 sysfs_create_dir_ns+0x128/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kset_register+0x165/0x1e0 lib/kobject.c:878
 kset_create_and_add+0x12e/0x1a0 lib/kobject.c:1015
 register_queue_kobjects net/core/net-sysfs.c:1758 [inline]
 netdev_register_kobject+0x1c6/0x430 net/core/net-sysfs.c:2014
 register_netdevice+0xd31/0x1500 net/core/dev.c:10336
 ldisc_open+0x473/0x8b0 drivers/net/caif/caif_serial.c:351

Memory state around the buggy address:
 ffff88808d3b0f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88808d3b0f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88808d3b1000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88808d3b1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808d3b1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
