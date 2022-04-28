Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20524512ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbiD1FOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiD1FOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:14:47 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97874DC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:11:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g15-20020a056e021a2f00b002cd868be1faso1168028ile.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xJZar25IIMoQhmB/ByVvMxwj9FB6T+m4xFo/nmu9HX8=;
        b=X4/x01aFU3aFRqztoEy39UgaIXVJFu8cR0ZW3budN6UtKiClLyAFLJsvRCxxnq077G
         uzC3egiWgQbNY13A21f1h1U3lQ9r5CtQbqtAJ8zMJ24mZpL85CAuAphzuIx5Wb3bp7u9
         2vwWuJx9PInZw8SCq90X0hoQW9YxZCQXmjvlw5bQjkuJpxRHGxz2Fl7Nf9iLhEeH1VIv
         dVGhKVzL0I2GS6PxI0QZBGV09XsiMqb+rYqvyoe9svNbf6YvSCdpOgk69748aYGLfoNi
         eaOm4FYv0dAyxJokbV/hsQKs1lL/jFc2+sK7yTJjz7g+HRtJDYrA1YdP7PXEzYqt+AVX
         4blA==
X-Gm-Message-State: AOAM531J2oH3t+BGLdV4qo9ei0nefrxWb5wZ3ShjtD2iXKSFGjmGxEFn
        pDpJVgm5VAPprjFXYnShnxuQSpPxMOnHbvSJyLU8ib8pc7yR
X-Google-Smtp-Source: ABdhPJztTtdnM4nWksmEfEv+EL25zPl+YHTuiLd2Q6nulORxcYO7Z3N9r9GrWghMaT/t+uOS+ZyGSfhNiQQeCmnTEEEdMgbYVYoA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34c:b0:32a:e06d:b6f8 with SMTP id
 x12-20020a056638034c00b0032ae06db6f8mr9159601jap.213.1651122692510; Wed, 27
 Apr 2022 22:11:32 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:11:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000915bd505ddaff576@google.com>
Subject: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From:   syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, coding@diwic.se, colin.king@intel.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    45ab9400e73f Merge tag 'perf-tools-fixes-for-v5.18-2022-04..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115cb458f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1843173f299d1e8
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39e3268af9968f153591@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1286 [inline]
BUG: KASAN: use-after-free in snd_rawmidi_transmit+0x3f3/0x420 sound/core/rawmidi.c:1411
Read of size 1 at addr ffff88804ece205e by task kworker/0:1H/9

CPU: 0 PID: 9 Comm: kworker/0:1H Not tainted 5.18.0-rc3-syzkaller-00196-g45ab9400e73f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_highpri snd_usbmidi_out_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1286 [inline]
 snd_rawmidi_transmit+0x3f3/0x420 sound/core/rawmidi.c:1411
 snd_usbmidi_standard_output+0x202/0xf30 sound/usb/midi.c:650
 snd_usbmidi_do_output+0x20e/0x530 sound/usb/midi.c:311
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 7013:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc_node+0x262/0x400 mm/slub.c:4462
 kmalloc_node include/linux/slab.h:604 [inline]
 kvmalloc_node+0x6d/0x100 mm/util.c:580
 kvmalloc include/linux/slab.h:731 [inline]
 kvzalloc include/linux/slab.h:739 [inline]
 snd_rawmidi_runtime_create sound/core/rawmidi.c:162 [inline]
 open_substream+0x2a1/0x6d0 sound/core/rawmidi.c:306
 rawmidi_open_priv+0xc2/0x6a0 sound/core/rawmidi.c:357
 snd_rawmidi_kernel_open+0x1e3/0x280 sound/core/rawmidi.c:392
 midisynth_use+0xf9/0x2b0 sound/core/seq/seq_midi.c:215
 subscribe_port sound/core/seq/seq_ports.c:412 [inline]
 check_and_subscribe_port+0x633/0xac0 sound/core/seq/seq_ports.c:495
 snd_seq_port_connect+0x27e/0x480 sound/core/seq/seq_ports.c:581
 snd_seq_ioctl_subscribe_port+0x394/0x750 sound/core/seq/seq_clientmgr.c:1492
 snd_seq_oss_midi_open+0x44b/0x9b0 sound/core/seq/oss/seq_oss_midi.c:359
 snd_seq_oss_synth_setup_midi+0x126/0x530 sound/core/seq/oss/seq_oss_synth.c:269
 snd_seq_oss_open+0x96d/0x1020 sound/core/seq/oss/seq_oss_init.c:260
 odev_open+0x5e/0x90 sound/core/seq/oss/seq_oss.c:128
 chrdev_open+0x5fb/0x680 fs/char_dev.c:414
 do_dentry_open+0x77f/0xfd0 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x26c0/0x2ec0 fs/namei.c:3609
 do_filp_open+0x277/0x4f0 fs/namei.c:3636
 do_sys_openat2+0x13b/0x500 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_sys_openat fs/open.c:1245 [inline]
 __se_sys_openat fs/open.c:1240 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1240
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 7013:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kfree+0xc6/0x210 mm/slub.c:4552
 snd_rawmidi_runtime_free sound/core/rawmidi.c:176 [inline]
 close_substream+0x38a/0x5f0 sound/core/rawmidi.c:528
 rawmidi_release_priv+0xf1/0x180 sound/core/rawmidi.c:547
 snd_rawmidi_kernel_release+0x42/0xa0 sound/core/rawmidi.c:564
 unsubscribe_port sound/core/seq/seq_ports.c:437 [inline]
 __delete_and_unsubscribe_port+0x15c/0x330 sound/core/seq/seq_ports.c:537
 snd_seq_port_disconnect+0x533/0x660 sound/core/seq/seq_ports.c:616
 snd_seq_ioctl_unsubscribe_port+0x394/0x750 sound/core/seq/seq_clientmgr.c:1537
 snd_seq_oss_midi_close+0x33f/0x740 sound/core/seq/oss/seq_oss_midi.c:404
 snd_seq_oss_synth_reset+0x3b6/0x9d0 sound/core/seq/oss/seq_oss_synth.c:406
 snd_seq_oss_reset+0x5b/0x240 sound/core/seq/oss/seq_oss_init.c:435
 snd_seq_oss_release+0xe9/0x300 sound/core/seq/oss/seq_oss_init.c:412
 odev_release+0x52/0x70 sound/core/seq/oss/seq_oss.c:144
 __fput+0x3b9/0x820 fs/file_table.c:317
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 get_signal+0x15d9/0x1780 kernel/signal.c:2641
 arch_do_signal_or_restart+0x8d/0x750 arch/x86/kernel/signal.c:867
 exit_to_user_mode_loop+0x74/0x160 kernel/entry/common.c:166
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88804ece2000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 94 bytes inside of
 4096-byte region [ffff88804ece2000, ffff88804ece3000)

The buggy address belongs to the physical page:
page:ffffea00013b3800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ece0
head:ffffea00013b3800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00014fe200 dead000000000002 ffff888011442140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4945, tgid 4938 (syz-executor.5), ts 180879892415, free_ts 180837137303
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0x72e/0x7a0 mm/page_alloc.c:4182
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5408
 alloc_slab_page+0x70/0xf0 mm/slub.c:1799
 allocate_slab+0x5e/0x560 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x41e/0xcd0 mm/slub.c:3005
 __slab_alloc mm/slub.c:3092 [inline]
 slab_alloc_node mm/slub.c:3183 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 kmem_cache_alloc_trace+0x25c/0x310 mm/slub.c:3256
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 ipv4_mib_init_net+0x2da/0x4d0 net/ipv4/af_inet.c:1772
 ops_init+0x313/0x430 net/core/net_namespace.c:134
 setup_net+0x4bb/0xc10 net/core/net_namespace.c:325
 copy_net_ns+0x359/0x5b0 net/core/net_namespace.c:471
 create_new_namespaces+0x4db/0x8e0 kernel/nsproxy.c:110
 copy_namespaces+0x333/0x390 kernel/nsproxy.c:178
 copy_process+0x18e9/0x3f70 kernel/fork.c:2237
 kernel_clone+0x22f/0x7a0 kernel/fork.c:2639
 __do_sys_clone kernel/fork.c:2756 [inline]
 __se_sys_clone kernel/fork.c:2740 [inline]
 __x64_sys_clone+0x289/0x310 kernel/fork.c:2740
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1356 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3328 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3423
 free_slab mm/slub.c:2043 [inline]
 discard_slab mm/slub.c:2049 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2523
 put_cpu_partial+0x116/0x180 mm/slub.c:2599
 do_slab_free mm/slub.c:3498 [inline]
 ___cache_free+0x118/0x1a0 mm/slub.c:3517
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:749 [inline]
 slab_alloc_node mm/slub.c:3217 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
 kmem_cache_alloc+0x199/0x2f0 mm/slub.c:3242
 getname_flags+0xb8/0x4e0 fs/namei.c:138
 user_path_at_empty+0x2a/0x1a0 fs/namei.c:2850
 do_readlinkat+0x11b/0x3b0 fs/stat.c:456
 __do_sys_readlink fs/stat.c:489 [inline]
 __se_sys_readlink fs/stat.c:486 [inline]
 __x64_sys_readlink+0x7b/0x90 fs/stat.c:486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88804ece1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804ece1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804ece2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88804ece2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804ece2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
