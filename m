Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92157012F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiGKLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:51:13 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223B92252E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:51:12 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w12-20020a5d960c000000b00678e4b1197bso2514619iol.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rS+R9GWy1py7GT7TxE7whcugLlJy/Px+u10hszPsr2w=;
        b=tQ2apSS3Kr49C7XRa2FQlk3jI9G6N+sncmpq0StPxC7Eajl/iGr4qac0iC3P88g5tC
         dJ+90vBgCmFeASZvQM9CEvLbHLXXc7++X8DPyoGUN/+O2EgqrsU0HO67CwaQWFcQGuYj
         4x2aPZDdFGAGVjGWD+aeuJhakqSakMv5Ja4ApGXA0of7U6+ZpbjDwzewIFR4PmHITHFa
         Lz0o0dfQjGKsDt2fGV1Ut51X7ZHf9xmeznlvnBCYH1dNVgiPSjnOaihBKqdX4Q3NS9H5
         MBqV8c/Yy88Sx1pBbYAFMbBX2RJ+GBFwwrGefo0kr7CfpyPhJjdNfc5aqppVolmGOMF3
         qI4A==
X-Gm-Message-State: AJIora8e8MEv5IAqGdKqGa3zabeQfhkUnoJD8CGa7totScmvtezpT1YZ
        f86wpKEKGXShZbk8XcWNimmkKc6WSIuPpkYbAkeXSSAIpH+2
X-Google-Smtp-Source: AGRyM1vJEhTnngcqdccL62XD+k9xqMBLy37bIeAubjfhjyYYkWJZif7o+DfV4BH8Gzn7USDEStCMOCL1ypoVr+Qxv9h0KuijIsQD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349f:b0:33f:68a2:5eb5 with SMTP id
 t31-20020a056638349f00b0033f68a25eb5mr382877jal.167.1657540271289; Mon, 11
 Jul 2022 04:51:11 -0700 (PDT)
Date:   Mon, 11 Jul 2022 04:51:11 -0700
In-Reply-To: <20220711111127.2643-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000123baa05e3862bd8@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kill_fasync
From:   syzbot <syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in kill_fasync

IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
Bluetooth: hci0: command 0x0409 tx timeout
==================================================================
BUG: KASAN: use-after-free in kill_fasync+0x45e/0x470 fs/fcntl.c:1014
Read of size 8 at addr ffff88807d1e9168 by task kworker/1:3/3621

CPU: 1 PID: 3621 Comm: kworker/1:3 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events key_garbage_collector
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 kill_fasync+0x45e/0x470 fs/fcntl.c:1014
 post_one_notification.isra.0+0x71a/0x9d0 kernel/watch_queue.c:131
 remove_watch_from_object+0x35a/0x9d0 kernel/watch_queue.c:530
 remove_watch_list include/linux/watch_queue.h:115 [inline]
 key_gc_unused_keys.constprop.0+0x2e5/0x600 security/keys/gc.c:135
 key_garbage_collector+0x3d7/0x920 security/keys/gc.c:297
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Allocated by task 4105:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 alloc_pipe_info+0x105/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 4104:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x4d0 mm/slub.c:4562
 put_pipe_info fs/pipe.c:711 [inline]
 pipe_release+0x2b6/0x310 fs/pipe.c:734
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807d1e9000
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff88807d1e9000, ffff88807d1e9200)

The buggy address belongs to the physical page:
page:ffffea0001f47a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d1e8
head:ffffea0001f47a00 order:2 compound_mapcount:0 compound_pincount:0
memcg:ffff88807c9f0b01
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011842dc0
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff88807c9f0b01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2958, tgid 2958 (klogd), ts 15679614274, free_ts 14007295278
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 __kmalloc_node_track_caller+0x360/0x480 mm/slub.c:4955
 kmalloc_reserve net/core/skbuff.c:358 [inline]
 __alloc_skb+0xd9/0x340 net/core/skbuff.c:430
 alloc_skb include/linux/skbuff.h:1249 [inline]
 alloc_skb_with_frags+0x93/0x6d0 net/core/skbuff.c:5990
 sock_alloc_send_pskb+0x793/0x920 net/core/sock.c:2663
 unix_dgram_sendmsg+0x415/0x1b60 net/unix/af_unix.c:1884
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x21a/0x320 net/socket.c:2116
 __do_sys_sendto net/socket.c:2128 [inline]
 __se_sys_sendto net/socket.c:2124 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3383 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3479
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9400
 destroy_args+0xa8/0x64c mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2954/0x29e5 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0xfe/0x650 init/main.c:1300
 do_initcall_level init/main.c:1375 [inline]
 do_initcalls init/main.c:1391 [inline]
 do_basic_setup init/main.c:1410 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1617
 kernel_init+0x1a/0x1d0 init/main.c:1506
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Memory state around the buggy address:
 ffff88807d1e9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d1e9080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807d1e9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807d1e9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d1e9200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134d24c8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=695e91d821f66ab5
dashboard link: https://syzkaller.appspot.com/bug?extid=382c8824777dca2812fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105a9782080000

