Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A7539F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350842AbiFAIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350896AbiFAIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:37:29 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECF4D60C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:37:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y2-20020a056602164200b00668dc549adbso524972iow.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=okVCpwToXTmu91CcSauSRe0pmtSWqtWO2ie4VvDI9Wk=;
        b=oMJeR/j2uIdzGJQ4+UtJFlgzdjiaH7N1Di/NlFlj40uoLPRpLoAXclD8gnPsrf8Qsm
         n+OviKdNJ0MWwCNRNzDEtszW0nSODClAyBYpdliZUOFWuc7v5dswfKhsLXlRhOKOjOPC
         ErIpSUvB2QH9OjHvzY5n0Gkl1ju/o0ht3EIIiHZKHCOFmXnV1kARJAB7xyZ0vwNKPntb
         yJLRFeLIL316WR5FIUP4R1yBqoMtIdWwI+Kg4QLLG0y5Rbl3SbvQ4Bz9Vv79WI+z+ZvT
         1oEn4xbY5gNrb6Liw6iaevRhRZuz8mSCOTE2Cb5TJrtiHPwb1409N+mvXmt2ahwFL4Ps
         zARQ==
X-Gm-Message-State: AOAM531mMaTDkE6xEdX9WazVUcs7UjZ+qcaokke0juNQ+j1vjcO2Zv0c
        LM3O5aGoaAd6xPKSZxUUzMsxhNptvzdn7yXM7erkAe8PAWE3
X-Google-Smtp-Source: ABdhPJxYDgRQokmT50hNr0r30xClo9chikA3PuG9RIB+dtvIz1E2N8fjTv7EDec9o4c7pfrwRhilJbOi5NMXJPrTuSk19FFY4d5h
MIME-Version: 1.0
X-Received: by 2002:a92:ddcb:0:b0:2cf:8e55:e997 with SMTP id
 d11-20020a92ddcb000000b002cf8e55e997mr32905653ilr.8.1654072640098; Wed, 01
 Jun 2022 01:37:20 -0700 (PDT)
Date:   Wed, 01 Jun 2022 01:37:20 -0700
In-Reply-To: <000000000000915bd505ddaff576@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000255a5005e05ecc6e@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From:   syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        coding@diwic.se, colin.king@intel.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13df4d13f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39e3268af9968f153591@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1286 [inline]
BUG: KASAN: use-after-free in snd_rawmidi_transmit+0x3f3/0x420 sound/core/rawmidi.c:1411
Read of size 1 at addr ffff888074d3c07f by task kworker/1:1H/756

CPU: 1 PID: 756 Comm: kworker/1:1H Not tainted 5.18.0-syzkaller-11650-g2a5699b0de4e #0
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

Allocated by task 3983:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc_node+0x262/0x400 mm/slub.c:4465
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0x6e/0x160 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 kvzalloc include/linux/slab.h:758 [inline]
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
 do_dentry_open+0x789/0x1040 fs/open.c:848
 do_open fs/namei.c:3527 [inline]
 path_openat+0x26c0/0x2ec0 fs/namei.c:3660
 do_filp_open+0x277/0x4f0 fs/namei.c:3687
 do_sys_openat2+0x13b/0x500 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3983:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kfree+0xc6/0x210 mm/slub.c:4555
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
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 ptrace_notify+0x29f/0x350 kernel/signal.c:2372
 ptrace_report_syscall include/linux/ptrace.h:427 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:489 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
 syscall_exit_to_user_mode_prepare+0x62/0x80 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff888074d3c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 127 bytes inside of
 4096-byte region [ffff888074d3c000, ffff888074d3d000)

The buggy address belongs to the physical page:
page:ffffea0001d34e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x74d38
head:ffffea0001d34e00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011442140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3983, tgid 3982 (syz-executor242), ts 217737880306, free_ts 217582307012
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4198
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5426
 alloc_slab_page+0x70/0xf0 mm/slub.c:1797
 allocate_slab+0x5e/0x520 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x41e/0xcd0 mm/slub.c:3002
 __slab_alloc mm/slub.c:3089 [inline]
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmalloc+0x2ba/0x370 mm/slub.c:4413
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xd8/0x5f0 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x22f/0x490 security/tomoyo/file.c:771
 security_file_open+0x50/0x560 security/security.c:1645
 do_dentry_open+0x34a/0x1040 fs/open.c:835
 do_open fs/namei.c:3527 [inline]
 path_openat+0x26c0/0x2ec0 fs/namei.c:3660
 do_filp_open+0x277/0x4f0 fs/namei.c:3687
 do_sys_openat2+0x13b/0x500 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3438
 free_slab mm/slub.c:2041 [inline]
 discard_slab mm/slub.c:2047 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2521
 put_cpu_partial+0x116/0x180 mm/slub.c:2597
 do_slab_free mm/slub.c:3495 [inline]
 ___cache_free+0x118/0x1a0 mm/slub.c:3514
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 __kmalloc_node+0x1f3/0x400 mm/slub.c:4461
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0x6e/0x160 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x1f6/0xd30 fs/seq_file.c:210
 call_read_iter include/linux/fs.h:2054 [inline]
 new_sync_read fs/read_write.c:401 [inline]
 vfs_read+0xa01/0xd10 fs/read_write.c:482
 ksys_read+0x19b/0x2c0 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff888074d3bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888074d3bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888074d3c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888074d3c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888074d3c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

