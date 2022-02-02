Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B24A6C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiBBHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:19:28 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45801 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiBBHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:19:25 -0500
Received: by mail-io1-f69.google.com with SMTP id z28-20020a056602081c00b00611596ef96fso14615294iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UAHkUH1MA/+8rdQ51kee7aWuVbJItay3/6WcLB1JeAo=;
        b=IiDsnq5K95irP9ARBSs/fW1MccWJUe82aVA1sJeJhuR37rHR/HNxBC/glIRMuIIiTo
         L++8h+BAfIx8lQnRpHzjogI1gybeN9mTVtbNR5KW+lc+QJFhVqDZjgPZ+nq6t4g5Lc/Z
         Th8aQZR/F4Zw6n6VI5pp+UnX1+X3V8V+/3BJh86IaheYZVATRwur0WPgXobKktr/idzf
         gnovy+gfejJqIdvau3YrrUwQrMYY/MLwTIPkgIyUZ2xKdzKmSydQRYTNBQKLWzjymKHV
         q5O/RhUQdsB4o+VrJixkyFgNIaBXgqm8oGoUClUcY7C59KTeqBr+zAgvDutL85qdqnDD
         LjEQ==
X-Gm-Message-State: AOAM531XewmcCn8kVHoHKUR7XEvRHJ7fgXrdEHig/02NwlIoAYjgJVA+
        /zsaG3rXVtuykyH2WsPUgHxpLPkSIpiEN8Q0piYXuZj5/FKO
X-Google-Smtp-Source: ABdhPJx3mmWJu2fTkK0/71y7h41nw8ZoOrztw5PhXt38ULXsnGqhFVLRlHLhDDhWWjz2q6mAyppd7OgR0NqqrpNUPBLewk6FLNZ5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6a1:: with SMTP id d1mr15127097jad.309.1643786365309;
 Tue, 01 Feb 2022 23:19:25 -0800 (PST)
Date:   Tue, 01 Feb 2022 23:19:25 -0800
In-Reply-To: <0000000000000560cc05d4bce058@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064159d05d703d683@google.com>
Subject: Re: [syzbot] general protection fault in hidraw_release
From:   syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f7fb8de5d9b Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1653b6cbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c9b92aaaee24
dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fff530700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106469f0700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xe0/0xf0 lib/list_debug.c:51
Read of size 8 at addr ffff8880143e8eb0 by task syz-executor753/4862

CPU: 0 PID: 4862 Comm: syz-executor753 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __list_del_entry_valid+0xe0/0xf0 lib/list_debug.c:51
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 hidraw_release+0xd5/0x370 drivers/hid/hidraw.c:353
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4256d1c749
Code: Unable to access opcode bytes at RIP 0x7f4256d1c71f.
RSP: 002b:00007fffddc9a4e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f4256d913f0 RCX: 00007f4256d1c749
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007fffddc9a560
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4256d913f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 20:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:270 [inline]
 kmem_cache_alloc_trace+0x1ea/0x4a0 mm/slab.c:3567
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 hidraw_connect+0x4b/0x440 drivers/hid/hidraw.c:543
 hid_connect+0x5be/0xbc0 drivers/hid/hid-core.c:1960
 hid_hw_start drivers/hid/hid-core.c:2059 [inline]
 hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2050
 hid_generic_probe drivers/hid/hid-generic.c:67 [inline]
 hid_generic_probe+0x6d/0x90 drivers/hid/hid-generic.c:56
 hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2380
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3405
 hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2530
 uhid_device_add_worker+0x36/0x60 drivers/hid/uhid.c:73
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 4861:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xee/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:236 [inline]
 __cache_free mm/slab.c:3437 [inline]
 kfree+0xf6/0x290 mm/slab.c:3794
 drop_ref+0x28f/0x390 drivers/hid/hidraw.c:335
 hidraw_release+0x255/0x370 drivers/hid/hidraw.c:357
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880143e8e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 176 bytes inside of
 192-byte region [ffff8880143e8e00, ffff8880143e8ec0)
The buggy address belongs to the page:
page:ffffea000050fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143e8
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000050f188 ffffea000050fc48 ffff888010c40000
raw: 0000000000000000 ffff8880143e8000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 1, ts 2151082992, free_ts 0
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
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
 kzalloc include/linux/slab.h:715 [inline]
 call_usermodehelper_setup+0x9d/0x340 kernel/umh.c:365
 kobject_uevent_env+0xf28/0x1600 lib/kobject_uevent.c:614
 kernel_add_sysfs_param kernel/params.c:816 [inline]
 param_sysfs_builtin kernel/params.c:851 [inline]
 param_sysfs_init+0x367/0x43b kernel/params.c:970
 do_one_initcall+0x103/0x650 init/main.c:1300
 do_initcall_level init/main.c:1373 [inline]
 do_initcalls init/main.c:1389 [inline]
 do_basic_setup init/main.c:1408 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880143e8d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880143e8e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880143e8e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff8880143e8f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880143e8f80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

