Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267855A28F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiHZN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiHZN7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:59:15 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BFAB0894
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:59:13 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so931129ioz.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9/EN8+QVglRp+MLN8Fpp+1AVjQDtCq5vJA5pbOEA+iY=;
        b=YQ4RsubIqR+n/g9dYdZlHX2ky26BILlwN8kKGCAiQ3vfu8sXodBl88xth3ziOzTMeL
         iI9iR3EaPQBZnAjCLLBZALeh3/46oTEacCaszgBmop6gVPpWubDWMzrg12ySPO8UotFV
         WuRC7ZB9F11r4yYIPhZbAWIwNTSsv5ilEwLVO6U3fMt7KbTQH50upgK1HTIrpq916M74
         OYFUwVwP2NzxOtGdh1BhnArJ7rDrflGXCQLg7sToLl4Nd7zswerRo4aFglveBOEI9AdE
         djKHaWFIPuZsHqssSWKGM4iTzBr8Y2/Y2lnSZr+HFYlo4QzgIAjKi+Y4N9FHdMw6/Hy1
         UVCw==
X-Gm-Message-State: ACgBeo3YSmDUrDCgYC/u682DOJvKg7MkxiriiDCmxp4UyNl9s5bNV6fn
        7YnxfUfR9Zz3WYl2arKz8NkxzHufu4RIyy/kulMGBEAvqeBt
X-Google-Smtp-Source: AA6agR5ERHRddQDWENNwCNEvdHohn8nfFtGaTEZB3sTQPx+TaD2Bcvf5fTqszH7jxuaqaiVSNMBTKHtOdDlvjddQO2+nylgivV3o
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1686:b0:346:a3a5:638d with SMTP id
 f6-20020a056638168600b00346a3a5638dmr4068712jat.0.1661522353211; Fri, 26 Aug
 2022 06:59:13 -0700 (PDT)
Date:   Fri, 26 Aug 2022 06:59:13 -0700
In-Reply-To: <20220826121322.2495-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6501e05e72551d7@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __kernfs_remove
From:   syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in __kernfs_remove

==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:335 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1262 [inline]
BUG: KASAN: use-after-free in __kernfs_remove+0xa09/0xb50 fs/kernfs/dir.c:1375
Read of size 2 at addr ffff88806b718438 by task syz-executor.4/6273

CPU: 0 PID: 6273 Comm: syz-executor.4 Not tainted 6.0.0-rc2-next-20220824-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 kernfs_type include/linux/kernfs.h:335 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1262 [inline]
 __kernfs_remove+0xa09/0xb50 fs/kernfs/dir.c:1375
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1595
 sysfs_slab_add+0x13e/0x1e0 mm/slub.c:5756
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9b91c89279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9b92d04168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f9b91d9bf80 RCX: 00007f9b91c89279
RDX: 0000000020000280 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 00007f9b91ce3189 R08: 0000000020000140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc04e2c32f R14: 00007f9b92d04300 R15: 0000000000022000
 </TASK>

Allocated by task 6271:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3229 [inline]
 slab_alloc mm/slub.c:3237 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3244 [inline]
 kmem_cache_alloc+0x2b7/0x3d0 mm/slub.c:3253
 kmem_cache_zalloc include/linux/slab.h:685 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1011
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x101/0x160 lib/kobject.c:441
 sysfs_slab_add+0x161/0x1e0 mm/slub.c:5767
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 6273:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1740 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1766
 slab_free mm/slub.c:3497 [inline]
 kmem_cache_free+0xe7/0x5b0 mm/slub.c:3519
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:547
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 __kernfs_remove+0x7a6/0xb50 fs/kernfs/dir.c:1413
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1595
 sysfs_slab_add+0x13e/0x1e0 mm/slub.c:5756
 __kmem_cache_create+0x509/0x690 mm/slub.c:4745
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x1f9/0x300 mm/slab_common.c:335
 p9_client_create+0xca5/0x1070 net/9p/client.c:993
 v9fs_session_init+0x1e2/0x1810 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806b7183a0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 152 bytes inside of
 168-byte region [ffff88806b7183a0, ffff88806b718448)

The buggy address belongs to the physical page:
page:ffffea0001adc600 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88806b7181d0 pfn:0x6b718
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000082de40 dead00000000000a ffff8880119d4c80
raw: ffff88806b7181d0 000000008011000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 4082, tgid 4082 (syz-executor.2), ts 66014543548, free_ts 13152020618
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5507
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1810 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1955
 new_slab mm/slub.c:2015 [inline]
 ___slab_alloc+0xa3e/0x11d0 mm/slub.c:3017
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3104
 slab_alloc_node mm/slub.c:3195 [inline]
 slab_alloc mm/slub.c:3237 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3244 [inline]
 kmem_cache_alloc+0x31c/0x3d0 mm/slub.c:3253
 kmem_cache_zalloc include/linux/slab.h:685 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:593
 kernfs_new_node fs/kernfs/dir.c:655 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1011
 internal_create_group+0x787/0xb10 fs/sysfs/group.c:136
 netdev_queue_add_kobject net/core/net-sysfs.c:1672 [inline]
 netdev_queue_update_kobjects+0x3aa/0x4e0 net/core/net-sysfs.c:1718
 register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
 netdev_register_kobject+0x330/0x400 net/core/net-sysfs.c:2019
 register_netdevice+0xe01/0x1680 net/core/dev.c:10070
 veth_newlink+0x33f/0x9a0 drivers/net/veth.c:1764
 rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
 __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9406
 destroy_args+0xa8/0x64c mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2954/0x29e5 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0xfe/0x650 init/main.c:1301
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1630
 kernel_init+0x1a/0x1d0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88806b718300: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88806b718380: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>ffff88806b718400: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
                                        ^
 ffff88806b718480: fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806b718500: fb fb fb fb fb fb fc fc fc fc fc fc fc fc 00 00
==================================================================


Tested on:

commit:         68a00424 Add linux-next specific files for 20220824
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156832e7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=591008a24ae652d0
dashboard link: https://syzkaller.appspot.com/bug?extid=8bee3285b9e190f1509e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cb8e4d080000

