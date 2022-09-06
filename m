Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE25AE965
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiIFNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiIFNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:21:41 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0872E685
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:21:40 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g12-20020a5d8c8c000000b006894fb842e3so6740221ion.21
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tjShcthE4HE0+ubf529nLA4jv+DWpJkiBnPmb+mmp0U=;
        b=XDBPomTV2QoEOibqymDX3PlWd38lxtBEopvfXVGIHJUELd7xisT67WUjO6++McFfF2
         HmSrGwZBOyK5b0cPDHnZrdWe4RAs6vYwj4o3ZfPzM5iKerv9jbLRanoYRJk6rKCmovOw
         oRJiqfPvyGN8ScZTDfWRaWJ2B2WNftGyxJOJ+40ofDVEhnjO12wb+BIliL2sNb05AdCF
         rCNFZGzbQGz2f1oLLTePZRAlemwjoUVWC2DPwkMPNXGjC+PskbGiu/LqJxQkEXBr8Vqt
         II3YCSvFimIDq4X4ngtFu89avz4tzTfK7kssJFON37Ft/Pb+grUunG2f4jhn75dHbHi4
         mAkw==
X-Gm-Message-State: ACgBeo1dqLzpUUhDz/KWKvWxyJ+dFTA4xPFZdF9ePgDpNQnKN/ZOJgAd
        yruIeSZPlBiFXrBCqrk1b4BIUTlvizQiLeCN9OfwjBCYQfxh
X-Google-Smtp-Source: AA6agR6EytlyX2yXt4GDjjmswrcLALpLr9X4ZzZ4DL9yfBADQS0aqXG1JOHLeqgyOn1oO3ja33mX01J6FBhSFBlzygypfnneMkap
MIME-Version: 1.0
X-Received: by 2002:a92:c247:0:b0:2eb:9874:dddf with SMTP id
 k7-20020a92c247000000b002eb9874dddfmr15072679ilo.189.1662470499812; Tue, 06
 Sep 2022 06:21:39 -0700 (PDT)
Date:   Tue, 06 Sep 2022 06:21:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000974e2805e802137e@google.com>
Subject: [syzbot] linux-next boot error: KASAN: slab-out-of-bounds Read in _find_next_bit
From:   syzbot <syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
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

HEAD commit:    840126e36e8f Add linux-next specific files for 20220906
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1216969b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=239c4c4e44185526
dashboard link: https://syzkaller.appspot.com/bug?extid=08ca1fa706a22cc17efe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b9017e387a8/disk-840126e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12182558f88d/vmlinux-840126e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26

CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.0.0-rc4-next-20220906-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: events pcpu_balance_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:287 [inline]
 print_report+0x164/0x463 mm/kasan/report.c:398
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:486
 _find_next_bit+0x143/0x160 lib/find_bit.c:109
 find_next_bit include/linux/find.h:55 [inline]
 pcpu_balance_populated mm/percpu.c:2086 [inline]
 pcpu_balance_workfn+0x6c0/0xea0 mm/percpu.c:2246
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 26:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa1/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:931 [inline]
 __kmalloc+0x54/0xc0 mm/slab_common.c:944
 kmalloc include/linux/slab.h:565 [inline]
 kzalloc include/linux/slab.h:696 [inline]
 pcpu_mem_zalloc+0x70/0xa0 mm/percpu.c:514
 pcpu_alloc_chunk mm/percpu.c:1446 [inline]
 pcpu_create_chunk+0x23/0x930 mm/percpu-vm.c:338
 pcpu_balance_populated mm/percpu.c:2108 [inline]
 pcpu_balance_workfn+0xc4e/0xea0 mm/percpu.c:2246
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888017576600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 184 bytes inside of
 192-byte region [ffff888017576600, ffff8880175766c0)

The buggy address belongs to the physical page:
page:ffffea00005d5d80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17576
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888011841a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2455007664, free_ts 0
 prep_new_page mm/page_alloc.c:2544 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4294
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5552
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2113
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2275
 alloc_slab_page mm/slub.c:1734 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1879
 new_slab mm/slub.c:1932 [inline]
 ___slab_alloc+0xad0/0x1440 mm/slub.c:3113
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3211
 slab_alloc_node mm/slub.c:3296 [inline]
 __kmem_cache_alloc_node+0x18a/0x3d0 mm/slub.c:3369
 __do_kmalloc_node mm/slab_common.c:930 [inline]
 __kmalloc_node_track_caller+0x45/0xc0 mm/slab_common.c:951
 __do_krealloc mm/slab_common.c:1324 [inline]
 krealloc+0x8c/0xf0 mm/slab_common.c:1357
 add_sysfs_param+0xca/0x960 kernel/params.c:651
 kernel_add_sysfs_param kernel/params.c:812 [inline]
 param_sysfs_builtin kernel/params.c:851 [inline]
 param_sysfs_init+0x301/0x43b kernel/params.c:970
 do_one_initcall+0xfe/0x650 init/main.c:1307
 do_initcall_level init/main.c:1382 [inline]
 do_initcalls init/main.c:1398 [inline]
 do_basic_setup init/main.c:1417 [inline]
 kernel_init_freeable+0x6ff/0x788 init/main.c:1637
 kernel_init+0x1a/0x1d0 init/main.c:1525
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888017576580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888017576600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888017576680: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                        ^
 ffff888017576700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888017576780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
