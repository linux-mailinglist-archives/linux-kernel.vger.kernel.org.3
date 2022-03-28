Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F34E90A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiC1JBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiC1JBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:01:00 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2AE47552
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:59:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u25-20020a5d8199000000b006421bd641bbso9978024ion.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jNIadBCPeN40ickgRjP0tBDvAGME+hS3m1rrg0gA71s=;
        b=eOppPRN7FPLrawv84Vw5115vr8incSPfscEPWimyYSK8YjjGS/e7kqRVZ0OqSETwOz
         HSxSbK1UqNizDZVTUUiUuglABNKpge53gSC4n28L0rTyugv/ouApJBgY+6RKjvQuB5hQ
         bkDzEZSYtkp6F+wM5S717Iq2BM3W14VbGKdXOhcqnnl5idvldYA1IbcazIkRiTPSNRHC
         byleucYMalRzNnIBHhcIQzJyP73P2tSqQHVysrWikrZehHkGzzxmdqjXFvtR1g7bHdbB
         m48hyKsFYrbq1s8xglJClnveWKcZ1Xlg4asMdbgFwM1H49kkb1LWX95u2lbGvGvEYcby
         5tOA==
X-Gm-Message-State: AOAM5327VlRYU6BOUi8sU79z9cqRlZdPuEC25UKUtqlFPuezGDYUdV9K
        bOi3QJpF5dsb4BkGExkFxmBaJnYlJ7CObBEhha34eo5Pvozq
X-Google-Smtp-Source: ABdhPJyTCSFtBB+aD+QkMSiq6InMvcLM2lGv47jmUxMdywmvYM7oB8vERN9zRsezPuUPUVjyd/CWyTHms77cv78t7eD4NgPRnksY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:2c9:bb85:847 with SMTP id
 d3-20020a056e02214300b002c9bb850847mr1611049ilv.2.1648457959179; Mon, 28 Mar
 2022 01:59:19 -0700 (PDT)
Date:   Mon, 28 Mar 2022 01:59:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000158d4005db4387c3@google.com>
Subject: [syzbot] KASAN: use-after-free Read in qd_unlock
From:   syzbot <syzbot+36c6631f1635a4a9c63a@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

syzbot found the following issue on:

HEAD commit:    1bc191051dca Merge tag 'trace-v5.18' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110faa75700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f8915481c02c4
dashboard link: https://syzkaller.appspot.com/bug?extid=36c6631f1635a4a9c63a
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36c6631f1635a4a9c63a@syzkaller.appspotmail.com

RSP: 002b:00007ffc995fc558 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f436088a4b7
RDX: 00007ffc995fc62c RSI: 000000000000000a RDI: 00007ffc995fc620
RBP: 00007ffc995fc620 R08: 00000000ffffffff R09: 00007ffc995fc3f0
R10: 0000555555cfb8b3 R11: 0000000000000246 R12: 00007f43608e21ea
R13: 00007ffc995fd6e0 R14: 0000555555cfb810 R15: 00007ffc995fd720
 </TASK>
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: use-after-free in qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:486
Read of size 8 at addr ffff88802a3bf330 by task syz-executor.4/3635

CPU: 1 PID: 3635 Comm: syz-executor.4 Tainted: G        W         5.17.0-syzkaller-02237-g1bc191051dca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x64/0x400 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:486
 gfs2_quota_sync+0x69f/0x7f0 fs/gfs2/quota.c:1317
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:642
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:445
 kill_block_super+0x79/0xd0 fs/super.c:1394
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x462/0x510 fs/namespace.c:1173
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x1dd/0x200 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:315
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f436088a4b7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc995fc558 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f436088a4b7
RDX: 00007ffc995fc62c RSI: 000000000000000a RDI: 00007ffc995fc620
RBP: 00007ffc995fc620 R08: 00000000ffffffff R09: 00007ffc995fc3f0
R10: 0000555555cfb8b3 R11: 0000000000000246 R12: 00007f43608e21ea
R13: 00007ffc995fd6e0 R14: 0000555555cfb810 R15: 00007ffc995fd720
 </TASK>

Allocated by task 4751:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:239 [inline]
 slab_post_alloc_hook mm/slab.h:749 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3245 [inline]
 kmem_cache_alloc+0x1c9/0x310 mm/slub.c:3255
 kmem_cache_zalloc include/linux/slab.h:707 [inline]
 qd_alloc+0x51/0x250 fs/gfs2/quota.c:216
 gfs2_quota_init+0x798/0x1040 fs/gfs2/quota.c:1407
 gfs2_make_fs_rw+0x4c0/0x640 fs/gfs2/super.c:153
 gfs2_fill_super+0x3663/0x4a70 fs/gfs2/ops_fstype.c:1269
 get_tree_bdev+0x406/0x630 fs/super.c:1292
 gfs2_get_tree+0x50/0x200 fs/gfs2/ops_fstype.c:1325
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:3026 [inline]
 path_mount+0x1986/0x2c30 fs/namespace.c:3356
 do_mount fs/namespace.c:3369 [inline]
 __do_sys_mount fs/namespace.c:3577 [inline]
 __se_sys_mount+0x308/0x3c0 fs/namespace.c:3554
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0x136/0x1e0 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:215 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
 slab_free mm/slub.c:3523 [inline]
 kmem_cache_free+0xc6/0x2d0 mm/slub.c:3540
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xa85/0x1700 kernel/rcu/tree.c:2786
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x3b/0x60 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xb2/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0xa70 kernel/rcu/tree.c:3074
 gfs2_quota_cleanup+0x494/0x6f0 fs/gfs2/quota.c:1471
 gfs2_make_fs_ro+0x4ba/0x600 fs/gfs2/super.c:552
 signal_our_withdraw fs/gfs2/util.c:166 [inline]
 gfs2_withdraw+0x84f/0x1860 fs/gfs2/util.c:343
 gfs2_meta_check_ii+0x70/0x80 fs/gfs2/util.c:501
 gfs2_metatype_check_i fs/gfs2/util.h:126 [inline]
 gfs2_meta_buffer+0x321/0x400 fs/gfs2/meta_io.c:493
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:70 [inline]
 gfs2_inode_refresh+0xd6/0xdc0 fs/gfs2/glops.c:472
 inode_go_instantiate+0x87/0x3b0 fs/gfs2/glops.c:498
 gfs2_instantiate+0x1a1/0x210 fs/gfs2/glock.c:509
 do_promote+0xe0a/0x15c0 fs/gfs2/glock.c:559
 finish_xmote+0x807/0x1200 fs/gfs2/glock.c:722
 do_xmote+0xb54/0x15f0 fs/gfs2/glock.c:866
 gfs2_glock_nq+0xce7/0x1790 fs/gfs2/glock.c:1576
 gfs2_glock_nq_init fs/gfs2/glock.h:254 [inline]
 do_sync+0x5d8/0xdf0 fs/gfs2/quota.c:908
 gfs2_quota_sync+0x379/0x7f0 fs/gfs2/quota.c:1310
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:642
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:445
 kill_block_super+0x79/0xd0 fs/super.c:1394
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x462/0x510 fs/namespace.c:1173
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x1dd/0x200 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:315
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x3b/0x60 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xb2/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0xa70 kernel/rcu/tree.c:3074
 gfs2_quota_cleanup+0x494/0x6f0 fs/gfs2/quota.c:1471
 gfs2_make_fs_ro+0x4ba/0x600 fs/gfs2/super.c:552
 gfs2_put_super+0x256/0x860 fs/gfs2/super.c:587
 generic_shutdown_super+0x128/0x300 fs/super.c:462
 kill_block_super+0x79/0xd0 fs/super.c:1394
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x462/0x510 fs/namespace.c:1173
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x1dd/0x200 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:315
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88802a3bf2a0
 which belongs to the cache gfs2_quotad of size 272
The buggy address is located 144 bytes inside of
 272-byte region [ffff88802a3bf2a0, ffff88802a3bf3b0)
The buggy address belongs to the page:
page:ffffea0000a8efc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a3bf
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000b983c0 dead000000000002 ffff888018a82640
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x112c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 2497, ts 1007566952843, free_ts 975272292210
 prep_new_page mm/page_alloc.c:2382 [inline]
 get_page_from_freelist+0x708/0xa80 mm/page_alloc.c:4123
 __alloc_pages+0x255/0x580 mm/page_alloc.c:5349
 alloc_slab_page+0x70/0xf0 mm/slub.c:1799
 allocate_slab+0x5d/0x380 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x40e/0xcc0 mm/slub.c:3018
 __slab_alloc mm/slub.c:3105 [inline]
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3245 [inline]
 kmem_cache_alloc+0x276/0x310 mm/slub.c:3255
 kmem_cache_zalloc include/linux/slab.h:707 [inline]
 qd_alloc+0x51/0x250 fs/gfs2/quota.c:216
 gfs2_quota_init+0x798/0x1040 fs/gfs2/quota.c:1407
 gfs2_make_fs_rw+0x4c0/0x640 fs/gfs2/super.c:153
 gfs2_fill_super+0x3663/0x4a70 fs/gfs2/ops_fstype.c:1269
 get_tree_bdev+0x406/0x630 fs/super.c:1292
 gfs2_get_tree+0x50/0x200 fs/gfs2/ops_fstype.c:1325
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:3026 [inline]
 path_mount+0x1986/0x2c30 fs/namespace.c:3356
 do_mount fs/namespace.c:3369 [inline]
 __do_sys_mount fs/namespace.c:3577 [inline]
 __se_sys_mount+0x308/0x3c0 fs/namespace.c:3554
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1348 [inline]
 free_pcp_prepare+0xcbd/0xec0 mm/page_alloc.c:1400
 free_unref_page_prepare mm/page_alloc.c:3269 [inline]
 free_unref_page+0x7d/0x580 mm/page_alloc.c:3364
 free_slab mm/slub.c:2043 [inline]
 discard_slab mm/slub.c:2049 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2536
 put_cpu_partial+0x116/0x180 mm/slub.c:2612
 do_slab_free mm/slub.c:3511 [inline]
 ___cache_free+0x117/0x1c0 mm/slub.c:3530
 qlist_free_all mm/kasan/quarantine.c:176 [inline]
 kasan_quarantine_reduce+0x127/0x190 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:239 [inline]
 slab_post_alloc_hook mm/slab.h:749 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc_trace+0x20b/0x330 mm/slub.c:3269
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:717 [inline]
 kobject_uevent_env+0x24e/0x1590 lib/kobject_uevent.c:524
 gfs2_recovery_done fs/gfs2/recovery.c:294 [inline]
 gfs2_recover_func+0xab3/0x2620 fs/gfs2/recovery.c:538
 process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
 worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff88802a3bf200: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802a3bf280: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a3bf300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802a3bf380: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff88802a3bf400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
