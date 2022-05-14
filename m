Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E2527004
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiENIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiENIbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:31:17 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9438CC
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:31:15 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id 204-20020a6b01d5000000b00657bb7a0f33so6364664iob.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9tCWadOds5KZeg4EUVh7CiiBHbT7pxbsfGGetlf/ZqY=;
        b=4u8sOp1WgcxU65CFLYSsf613cOOoOEtmTHf50IXrvCpVGGm6iq4x1WuJEUFBVKLjjI
         x471KwOgX0XtpzNyoALfEuRklGOdQjqZbr0VmHQ37jc8Hs9owszmiAyxkYoMvOgswfq5
         IEvUzUazb82vQjroFvwkSCArOhqyCgiln0VOzQQ88ADzxNUV+Q014L5xJ1I6bqrvHvR/
         WXsvHf1B+o0Zn4s6ApEBW2nCS0AenkPjUUtlprvORh0cCuxz9iTo6vf6g0WimCX6m4uO
         y6zcysO9PEmwFAtrAlDUJWFAh9cg3PoxGcqDOhVqpp+vbFO8c8K4IX9z4s7JAHXVnEmE
         i1VA==
X-Gm-Message-State: AOAM531JhWhlEO2igF6FukprangFe8nbk6lLKbWf/YUUBvIcgZWC/jRy
        Ls0jV5hD1mtJxU2y1uPSeWV03CDCMviFNLM3CZiV7cqYhoAv
X-Google-Smtp-Source: ABdhPJzFKpV8Ssv4TAXsI1xGTFjAFnzyJ1OX5VXxbDuK0OyxCu3ytYHKPGEGLJIEXp7m6beIIKSNSA+UL0XXdOcUoKNX/oiiHQou
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:2cf:16dd:6210 with SMTP id
 h7-20020a056e021d8700b002cf16dd6210mr4595846ila.60.1652517075158; Sat, 14 May
 2022 01:31:15 -0700 (PDT)
Date:   Sat, 14 May 2022 01:31:15 -0700
In-Reply-To: <20220514081824.1035-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000400c6305def49d7f@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_dev_do_open (2)
From:   syzbot <syzbot+e68a3899a8927b14f863@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in hci_cmd_timeout

==================================================================
BUG: KASAN: use-after-free in hci_cmd_timeout+0x24b/0x250 net/bluetooth/hci_core.c:1475
Read of size 2 at addr ffff88807933d408 by task kworker/1:3/145

CPU: 1 PID: 145 Comm: kworker/1:3 Not tainted 5.18.0-rc5-next-20220506-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events hci_cmd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 hci_cmd_timeout+0x24b/0x250 net/bluetooth/hci_core.c:1475
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>

Allocated by task 3681:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 fib6_info_alloc+0xc1/0x210 net/ipv6/ip6_fib.c:156
 ip6_route_net_init+0x75/0x8c0 net/ipv6/route.c:6465
 ops_init+0xaf/0x470 net/core/net_namespace.c:134
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:325
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:471
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3137
 __do_sys_unshare kernel/fork.c:3208 [inline]
 __se_sys_unshare kernel/fork.c:3206 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3206
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 48:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kfree+0xd6/0x4d0 mm/slub.c:4555
 skb_free_head+0xac/0x110 net/core/skbuff.c:654
 skb_release_data+0x67a/0x810 net/core/skbuff.c:676
 skb_release_all net/core/skbuff.c:741 [inline]
 __kfree_skb net/core/skbuff.c:755 [inline]
 kfree_skb_reason.part.0+0xc3/0x2f0 net/core/skbuff.c:775
 kfree_skb_reason+0x85/0x110 include/linux/refcount.h:279
 kfree_skb include/linux/skbuff.h:1275 [inline]
 hci_dev_open_sync+0xb8c/0x2160 net/bluetooth/hci_sync.c:4053
 hci_dev_do_open+0x32/0x70 net/bluetooth/hci_core.c:482
 hci_power_on+0x133/0x630 net/bluetooth/hci_core.c:964
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

The buggy address belongs to the object at ffff88807933d400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 512-byte region [ffff88807933d400, ffff88807933d600)

The buggy address belongs to the physical page:
page:ffffea0001e4cf00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7933c
head:ffffea0001e4cf00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00006b4900 dead000000000002 ffff888010c41c80
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3049, tgid 3049 (udevadm), ts 15378275467, free_ts 12707670800
 prep_new_page mm/page_alloc.c:2431 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4172
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5393
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 __kmalloc_node_track_caller+0x2cb/0x360 mm/slub.c:4950
 kmalloc_reserve net/core/skbuff.c:353 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:425
 alloc_skb include/linux/skbuff.h:1326 [inline]
 alloc_uevent_skb+0x7b/0x210 lib/kobject_uevent.c:290
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:409 [inline]
 kobject_uevent_env+0xc42/0x1660 lib/kobject_uevent.c:593
 kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
 uevent_store+0x42/0x90 drivers/base/bus.c:581
 drv_attr_store+0x6d/0xa0 drivers/base/bus.c:77
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:290
 call_write_iter include/linux/fs.h:2045 [inline]
 new_sync_write+0x38a/0x560 fs/read_write.c:504
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1396
 free_unref_page_prepare mm/page_alloc.c:3318 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3413
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9281
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2a08/0x2a99 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x103/0x650 init/main.c:1301
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1618
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

Memory state around the buggy address:
 ffff88807933d300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807933d380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807933d400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807933d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807933d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         38a288f5 Add linux-next specific files for 20220506
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=115e78e6f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4fbf50aa82985b
dashboard link: https://syzkaller.appspot.com/bug?extid=e68a3899a8927b14f863
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165e78e6f00000

