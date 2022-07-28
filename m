Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E301583729
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiG1CqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiG1CqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:46:16 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54745F77
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:46:15 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id 15-20020a056e0220cf00b002dd711a2677so454773ilq.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iTFVOo/wQhbUP+TY5qnSLpH/7+1d22sC14t1pUGAR6g=;
        b=QS/AxKv3g6xWOE1sJK7MucjVUZ3xk/l4hOI4impwxmDBm82KXI9bnqiU/WX7M9q3lR
         Q6vpvc6ijtLoXrO8342p/bDVcRdJptFCWUZgLYZuI2iR/j/i90+AqnIHzFwXTHD+iSO3
         Tq6YBEQ1MysQgjR3PDHjSWKF/ByBqLIypwMvZZnBnxI/T05UY+duqvEg0SqB1k7oowzw
         FbCgz4yYKPm93M/kU5ZuiplQicoRhTz4ihu/+vfQHrs424UQhjCXrEZAYmhKmnB4sp88
         rY7zxlKoPU7zE6+ZXWtALdc+GyimK18uBQOrk87hlG6/5m7BrtHn+Ba8z8r98gBcxlA9
         H3yg==
X-Gm-Message-State: AJIora/N8yPQ1jGMOSQCj3sT+ldKwfy/XwziukUhWHG8/F2fpt5YrlWD
        yOpj46SrLAgSHMzynHG4TQY+4kujbs1Gg+ew+hqF8UFxyliR
X-Google-Smtp-Source: AGRyM1sZLDK2MT3A3E6XlALPr6vS4diyxWUZWpEdwAf6r5RJHRRtsAW+co7aBPSsVaop+yJJ532d1cR2VP2QFUHnTJzZ/y6jgNQP
MIME-Version: 1.0
X-Received: by 2002:a02:a918:0:b0:33f:2a28:a2c6 with SMTP id
 n24-20020a02a918000000b0033f2a28a2c6mr10030659jam.8.1658976373747; Wed, 27
 Jul 2022 19:46:13 -0700 (PDT)
Date:   Wed, 27 Jul 2022 19:46:13 -0700
In-Reply-To: <20220728022854.432-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072ba8605e4d48900@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __post_watch_notification
From:   syzbot <syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in __post_watch_notification

==================================================================
BUG: KASAN: use-after-free in __post_watch_notification+0x1fe/0x900 kernel/watch_queue.c:221
Read of size 8 at addr ffff888021dc5410 by task syz-executor239/27731

CPU: 0 PID: 27731 Comm: syz-executor239 Not tainted 5.19.0-rc8-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 __post_watch_notification+0x1fe/0x900 kernel/watch_queue.c:221
 post_watch_notification include/linux/watch_queue.h:109 [inline]
 notify_key security/keys/internal.h:199 [inline]
 __key_update+0x428/0x4e0 security/keys/key.c:775
 key_create_or_update+0xa8f/0xd60 security/keys/key.c:979
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x338/0x480 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f503a6db9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f503a68d2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007f503a763408 RCX: 00007f503a6db9f9
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 0000000000000000 R08: 00000000fffffffc R09: 0000000000000000
R10: 0000000000000048 R11: 0000000000000246 R12: 00007f503a763400
R13: 00007f503a76340c R14: 00007f503a731064 R15: 3a74707972637366
 </TASK>

Allocated by task 27707:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x94/0x310 mm/slub.c:3284
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 watch_queue_init+0x4f/0x140 kernel/watch_queue.c:674
 create_pipe_files+0x478/0x6e0 fs/pipe.c:921
 __do_pipe_flags+0x46/0x200 fs/pipe.c:962
 do_pipe2+0xd0/0x300 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x56/0x60 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 22:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1780
 slab_free mm/slub.c:3536 [inline]
 kmem_cache_free_bulk+0x105/0x1d0 mm/slub.c:3683
 kfree_bulk include/linux/slab.h:456 [inline]
 kfree_rcu_work+0x35b/0x7c0 kernel/rcu/tree.c:3370
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Last potentially related work creation:
 kasan_save_stack+0x3b/0x60 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x118/0x840 kernel/rcu/tree.c:3647
 keyctl_watch_key+0x3d2/0x450 security/keys/keyctl.c:1839
 __do_sys_keyctl security/keys/keyctl.c:2016 [inline]
 __se_sys_keyctl+0x635/0xb60 security/keys/keyctl.c:1869
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888021dc5400
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 192-byte region [ffff888021dc5400, ffff888021dc54c0)

The buggy address belongs to the physical page:
page:ffffea0000877140 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21dc5
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888011c41a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 27704, tgid 27703 (syz-executor239), ts 435095125439, free_ts 435075154261
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4198
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5426
 alloc_slab_page+0x70/0xf0 mm/slub.c:1824
 allocate_slab+0x5e/0x520 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x42e/0xce0 mm/slub.c:3031
 __slab_alloc mm/slub.c:3118 [inline]
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x25c/0x310 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 loopback_open+0x120/0xa20 sound/drivers/aloop.c:1192
 snd_pcm_open_substream+0xd8b/0x1b70 sound/core/pcm_native.c:2739
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2454 [inline]
 snd_pcm_oss_open+0x1185/0x2060 sound/core/oss/pcm_oss.c:2535
 chrdev_open+0x5fb/0x680 fs/char_dev.c:414
 do_dentry_open+0x789/0x1040 fs/open.c:848
 do_open fs/namei.c:3520 [inline]
 path_openat+0x26c0/0x2ec0 fs/namei.c:3653
 do_filp_open+0x277/0x4f0 fs/namei.c:3680
 do_sys_openat2+0x13b/0x500 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3438
 __vunmap+0x867/0x9d0 mm/vmalloc.c:2665
 do_free_pages sound/core/pcm_memory.c:65 [inline]
 snd_pcm_lib_free_pages+0x213/0x2e0 sound/core/pcm_memory.c:467
 do_hw_free sound/core/pcm_native.c:876 [inline]
 snd_pcm_release_substream+0x2cd/0x490 sound/core/pcm_native.c:2704
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2413 [inline]
 snd_pcm_oss_release+0x1a3/0x270 sound/core/oss/pcm_oss.c:2592
 __fput+0x3b9/0x820 fs/file_table.c:317
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x134/0x160 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x60 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888021dc5300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021dc5380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888021dc5400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888021dc5480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888021dc5500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e0dccc3b Linux 5.19-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123a0752080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfd2f9ae77f1f719
dashboard link: https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cb2102080000

