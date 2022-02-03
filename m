Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415D4A80F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbiBCJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348756AbiBCJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:06:07 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315AC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:06:07 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so1023556ooo.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1axPy9IK7yDElGYNLpy/rkzQ0xFcCix7QrxDXPZ52cA=;
        b=l3jt85DaEDw4v11dp+j7IPjBilW4DIbm396A8xTzRRwYHQr5tbLLXzYZgh7Frk7cgO
         wSdX6b+n5rZghKLHBDQOXbYzYF835k20QTML4rZbkKg1A1p6cGCgtb2MGHoOOO7cpRz/
         NvV1+5rr5XIt77AEOrOed7jfDCxE1F83GVv5AUnAIwf4dpyzIJ6zAd4vFTt7xVxF4PrT
         L6H6e2t38qUfCpOWJ53FvSfV26C6CTn3Lk6Qwt5+pLcO+S6rFXITWc3FzooG6OetqAur
         OqVrCg4HubDJHcyy7Ydio4rEaFCpS6+yS5O3j+GYaIf3YHR40HVTn6XFwSankYG/a9Bn
         dXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1axPy9IK7yDElGYNLpy/rkzQ0xFcCix7QrxDXPZ52cA=;
        b=h7GNuC/xcd7zmi3ySSSS2vA4zQzbAg8n7IKIzkrdec/JrytUMPXCNflCUCXc0Hox0b
         ALKZfZPogpe7iH8L+ICE+ER31l8AOL/nNa8ULjsFkHDmNmxEeMVeCTRJWarkve0nc3bp
         nP4vh/hhAeDQ1s6Uk5QlrOxdwn5QU20X+SZZbYIaDvU2M9faKjc87K5QTRVgldRiALWi
         3TRhb3x58A7YchNxVLZmZZ2i5JXx/9Zo+ulHChL74izeN6aPobTma19slFC8xVSbYIli
         prCBJUf2rLG2S2L/J3CWHBQwoDs4mEkqi0nwHixizlg4t5vLcl5qCF8xanfoUdOcx2Pc
         VSCg==
X-Gm-Message-State: AOAM531zi1xW2fYFg7HKRVp5R2xkgsbc5CjZW+d+4NjUG/FkpfmP8i4F
        eJsXFWowuddijPjCehkdst2ncPd0ei7QsiXzdN+J0g==
X-Google-Smtp-Source: ABdhPJxl6htaorIJAOU/5AH9JtyB6jfQ8nsZVcwR6CNYBz1R8OJQZolL4rljz+dLYXISDb9wHtALDNBZP4rJAxQnTEE=
X-Received: by 2002:a4a:de58:: with SMTP id z24mr8976377oot.53.1643879166163;
 Thu, 03 Feb 2022 01:06:06 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000560cc05d4bce058@google.com> <00000000000064159d05d703d683@google.com>
 <20220203040227.2057-1-hdanton@sina.com> <CACT4Y+bm+S-_b3saGichr3aA06rvsXyp28og_CONrh5fRhe8Eg@mail.gmail.com>
 <20220203084246.2133-1-hdanton@sina.com>
In-Reply-To: <20220203084246.2133-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Feb 2022 10:05:54 +0100
Message-ID: <CACT4Y+ZpnUz9hjO00cryFsOE27UbJOftSf4DmK6C3PNm3ofGNw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in hidraw_release
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"On Thu, 3 Feb 2022 at 09:43, Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 3 Feb 2022 07:09:52 +0100 Dmitry Vyukov wrote:
> > On Thu, 3 Feb 2022 at 05:02, Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Tue, 01 Feb 2022 23:19:25 -0800
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    9f7fb8de5d9b Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1653b6cbb00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c9b92aaaee24
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fff530700000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106469f0700000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in __list_del_entry_valid+0xe0/0xf0 lib/list_debug.c:51
> > > > Read of size 8 at addr ffff8880143e8eb0 by task syz-executor753/4862
> > > >
> > > > CPU: 0 PID: 4862 Comm: syz-executor753 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > >  print_address_description.constprop.0.cold+0x8d/0x303 mm/kasan/report.c:255
> > > >  __kasan_report mm/kasan/report.c:442 [inline]
> > > >  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
> > > >  __list_del_entry_valid+0xe0/0xf0 lib/list_debug.c:51
> > > >  __list_del_entry include/linux/list.h:134 [inline]
> > > >  list_del include/linux/list.h:148 [inline]
> > >
> > > What is difficult to follow is syzbot instead did not complain at the spin_lock
> > > prior to list_del in regard to uaf.
> > >
> > > Any light on the difficulty is welcome.
> >
> > Hi Hillf,
>
> Hi Dmitry
>
> Thanks for taking a look at it.
>
> >
> > If you mean these lock/unlock:
>
> Yes I did.
> >
> > spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
> > list_del(&list->node);
> > spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
> >
> > They seem to operate on a global hidraw_table locks.
> > I would assume only this file is corrupted/bad, but the global lock
> > table is fine.
> >
> 0/ in  hidraw_connect()
>
>         dev = kzalloc(sizeof(struct hidraw), GFP_KERNEL);
>         ...
>         spin_lock_init(&dev->list_lock);
>         dev->minor = minor;
>
> 1/ in hidraw_open()
>
>         down_read(&minors_rwsem);
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 err = -ENODEV;
>                 goto out_unlock;
>         }
>
>         dev = hidraw_table[minor];
>         ...
>         spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
>         list_add_tail(&list->node, &hidraw_table[minor]->list);
>         spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
>
> 3/ in drop_ref()
>
>         hidraw_table[hidraw->minor] = NULL;
>         kfree(hidraw);
>
> 4/ in __list_del_entry_valid()
>
> 51      CHECK_DATA_CORRUPTION(prev->next != entry,
>
>
> Given the kfree in 3/ can explain
> "Read of size 8 at addr ffff8880143e8eb0 by task syz-executor753/4862",
> I failed to work out how syzbot survived locking hidraw->list_lock after
> scratching scalp twenty minutes in fear of unlnown hardware glitch. But
> that fear does not have any chance for making sense given the reproducer
> in your toolkit.

The kernel may have survived locking hidraw->list_lock because it's a
racy use-after-free: use and free happened in different tasks. So
based on timing the task can start using freed memory at any line of
code.
Note sometimes it also manifests as "general protection fault in
hidraw_release". Races frequently have different manifestations.



> > > >  hidraw_release+0xd5/0x370 drivers/hid/hidraw.c:353
> > > >  __fput+0x286/0x9f0 fs/file_table.c:311
> > > >  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
> > > >  exit_task_work include/linux/task_work.h:32 [inline]
> > > >  do_exit+0xb29/0x2a30 kernel/exit.c:806
> > > >  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
> > > >  __do_sys_exit_group kernel/exit.c:946 [inline]
> > > >  __se_sys_exit_group kernel/exit.c:944 [inline]
> > > >  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > RIP: 0033:0x7f4256d1c749
> > > > Code: Unable to access opcode bytes at RIP 0x7f4256d1c71f.
> > > > RSP: 002b:00007fffddc9a4e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > > > RAX: ffffffffffffffda RBX: 00007f4256d913f0 RCX: 00007f4256d1c749
> > > > RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> > > > RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007fffddc9a560
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4256d913f0
> > > > R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> > > >  </TASK>
> > > >
> > > > Allocated by task 20:
> > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > >  kasan_set_track mm/kasan/common.c:45 [inline]
> > > >  set_alloc_info mm/kasan/common.c:436 [inline]
> > > >  ____kasan_kmalloc mm/kasan/common.c:515 [inline]
> > > >  ____kasan_kmalloc mm/kasan/common.c:474 [inline]
> > > >  __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:524
> > > >  kasan_kmalloc include/linux/kasan.h:270 [inline]
> > > >  kmem_cache_alloc_trace+0x1ea/0x4a0 mm/slab.c:3567
> > > >  kmalloc include/linux/slab.h:581 [inline]
> > > >  kzalloc include/linux/slab.h:715 [inline]
> > > >  hidraw_connect+0x4b/0x440 drivers/hid/hidraw.c:543
> > > >  hid_connect+0x5be/0xbc0 drivers/hid/hid-core.c:1960
> > > >  hid_hw_start drivers/hid/hid-core.c:2059 [inline]
> > > >  hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2050
> > > >  hid_generic_probe drivers/hid/hid-generic.c:67 [inline]
> > > >  hid_generic_probe+0x6d/0x90 drivers/hid/hid-generic.c:56
> > > >  hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2380
> > > >  call_driver_probe drivers/base/dd.c:517 [inline]
> > > >  really_probe+0x245/0xcc0 drivers/base/dd.c:596
> > > >  __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
> > > >  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
> > > >  __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
> > > >  bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
> > > >  __device_attach+0x228/0x4a0 drivers/base/dd.c:970
> > > >  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
> > > >  device_add+0xc17/0x1ee0 drivers/base/core.c:3405
> > > >  hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2530
> > > >  uhid_device_add_worker+0x36/0x60 drivers/hid/uhid.c:73
> > > >  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
> > > >  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
> > > >  kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > >
> > > > Freed by task 4861:
> > > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > > >  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> > > >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> > > >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> > > >  ____kasan_slab_free mm/kasan/common.c:328 [inline]
> > > >  __kasan_slab_free+0xee/0x130 mm/kasan/common.c:374
> > > >  kasan_slab_free include/linux/kasan.h:236 [inline]
> > > >  __cache_free mm/slab.c:3437 [inline]
> > > >  kfree+0xf6/0x290 mm/slab.c:3794
> > > >  drop_ref+0x28f/0x390 drivers/hid/hidraw.c:335
> > > >  hidraw_release+0x255/0x370 drivers/hid/hidraw.c:357
> > > >  __fput+0x286/0x9f0 fs/file_table.c:311
> > > >  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
> > > >  exit_task_work include/linux/task_work.h:32 [inline]
> > > >  do_exit+0xb29/0x2a30 kernel/exit.c:806
> > > >  do_group_exit+0xd2/0x2f0 kernel/exit.c:935
> > > >  __do_sys_exit_group kernel/exit.c:946 [inline]
> > > >  __se_sys_exit_group kernel/exit.c:944 [inline]
> > > >  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > The buggy address belongs to the object at ffff8880143e8e00
> > > >  which belongs to the cache kmalloc-192 of size 192
> > > > The buggy address is located 176 bytes inside of
> > > >  192-byte region [ffff8880143e8e00, ffff8880143e8ec0)
> > > > The buggy address belongs to the page:
> > > > page:ffffea000050fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143e8
> > > > flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> > > > raw: 00fff00000000200 ffffea000050f188 ffffea000050fc48 ffff888010c40000
> > > > raw: 0000000000000000 ffff8880143e8000 0000000100000010 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > > page_owner tracks the page as allocated
> > > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 1, ts 2151082992, free_ts 0
> > > >  prep_new_page mm/page_alloc.c:2434 [inline]
> > > >  get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
> > > >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
> > > >  __alloc_pages_node include/linux/gfp.h:572 [inline]
> > > >  kmem_getpages mm/slab.c:1378 [inline]
> > > >  cache_grow_begin+0x75/0x350 mm/slab.c:2584
> > > >  cache_alloc_refill+0x27f/0x380 mm/slab.c:2957
> > > >  ____cache_alloc mm/slab.c:3040 [inline]
> > > >  ____cache_alloc mm/slab.c:3023 [inline]
> > > >  __do_cache_alloc mm/slab.c:3267 [inline]
> > > >  slab_alloc mm/slab.c:3308 [inline]
> > > >  kmem_cache_alloc_trace+0x380/0x4a0 mm/slab.c:3565
> > > >  kmalloc include/linux/slab.h:581 [inline]
> > > >  kzalloc include/linux/slab.h:715 [inline]
> > > >  call_usermodehelper_setup+0x9d/0x340 kernel/umh.c:365
> > > >  kobject_uevent_env+0xf28/0x1600 lib/kobject_uevent.c:614
> > > >  kernel_add_sysfs_param kernel/params.c:816 [inline]
> > > >  param_sysfs_builtin kernel/params.c:851 [inline]
> > > >  param_sysfs_init+0x367/0x43b kernel/params.c:970
> > > >  do_one_initcall+0x103/0x650 init/main.c:1300
> > > >  do_initcall_level init/main.c:1373 [inline]
> > > >  do_initcalls init/main.c:1389 [inline]
> > > >  do_basic_setup init/main.c:1408 [inline]
> > > >  kernel_init_freeable+0x6b1/0x73a init/main.c:1613
> > > >  kernel_init+0x1a/0x1d0 init/main.c:1502
> > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > page_owner free stack trace missing
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff8880143e8d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > >  ffff8880143e8e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >ffff8880143e8e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > >                                      ^
> > > >  ffff8880143e8f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >  ffff8880143e8f80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > > ==================================================================
