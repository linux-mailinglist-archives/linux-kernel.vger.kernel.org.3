Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3924AB3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiBGFur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiBGFT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:19:26 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC7C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 21:19:24 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n13-20020a056602340d00b006361f2312deso8350517ioz.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 21:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GONV750ekXkuvP6R4EeQzhr1MpWaoqB8SjXmEi0s2QM=;
        b=fH9X0uOIpLeNdah2lZCr9sNP99ZDQW7GbkAJ5UVOrSTd2gmGbV8udLPWplUYOXbTmC
         5Qfskl4jB8qVPuNPCJdKQkzg4kBjsX3bAFLEnL/LaTUZmL4Z2muiDacADA3CfWkVp9HP
         FFPSArP0HlEAVbp9ZrzDWRGPW1iZZ5MqKfMBFlnMoy/lKSZLZ0JaGHpuArvQzzA7SPya
         kqH9RJo4/gaDwaztTB/+6obgfxphqhPjKCz/KA47CkBZCbriCawoVssaYqSeTH0fpTWx
         baeab7RkqdRRrt0SP8umo+JAN7C5HnfU1HXOlpWaqBjZuY1mCxU6ZKyaF976VA34yDtD
         cWBA==
X-Gm-Message-State: AOAM530dk8bXdKXnMaJEbt2Zljs9NrDbbJ2V1UIw++senrGum5AzHNlM
        sAjyUCsVdEMYmx2uMtd+VbmGy1CY0R1Uq10O2OrqmQXs0XGB
X-Google-Smtp-Source: ABdhPJyotJ5lbq5bfzhNMmcCNYowvyfXky2PugHMBb66r31tBEjaRidtCJWfSX1icT2Vk3TqgtAIcATfZ02cdl6B8e/qPshXqm+K
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2416:: with SMTP id z22mr4862256jat.203.1644211163536;
 Sun, 06 Feb 2022 21:19:23 -0800 (PST)
Date:   Sun, 06 Feb 2022 21:19:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056a4cf05d766be6b@google.com>
Subject: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    27bb0b18c208 Merge tag 'linux-kselftest-kunit-fixes-5.17-r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c4f1cc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c9b92aaaee24
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154c5624700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com

INFO: task udevd:3663 blocked for more than 143 seconds.
      Not tainted 5.17.0-rc2-syzkaller-00054-g27bb0b18c208 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26280 pid: 3663 ppid:  2964 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4db0 kernel/sched/core.c:6295
 schedule+0xd2/0x260 kernel/sched/core.c:6368
 io_schedule+0xee/0x170 kernel/sched/core.c:8407
 folio_wait_bit_common+0x4f2/0xa90 mm/filemap.c:1322
 folio_wait_bit mm/filemap.c:1471 [inline]
 folio_wait_locked include/linux/pagemap.h:847 [inline]
 folio_wait_locked include/linux/pagemap.h:844 [inline]
 do_read_cache_folio+0x506/0x760 mm/filemap.c:3495
 do_read_cache_page mm/filemap.c:3567 [inline]
 read_cache_page+0x59/0x1c0 mm/filemap.c:3576
 read_mapping_page include/linux/pagemap.h:641 [inline]
 read_part_sector+0xf6/0x5b0 block/partitions/core.c:724
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:148 [inline]
 blk_add_partitions block/partitions/core.c:609 [inline]
 bdev_disk_changed+0x629/0xf60 block/partitions/core.c:695
 blkdev_get_whole+0x206/0x2d0 block/bdev.c:679
 blkdev_get_by_dev.part.0+0x5c6/0xc70 block/bdev.c:813
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:847
 blkdev_open+0x154/0x2e0 block/fops.c:501
 do_dentry_open+0x4b9/0x1240 fs/open.c:824
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c9e/0x2940 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f27d7675697
RSP: 002b:00007ffc91e0e6e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f27d8f5d4a0 RCX: 00007f27d7675697
RDX: 00000000000a0800 RSI: 00007f27d8f3f370 RDI: 00000000ffffff9c
RBP: 00007f27d8f3f370 R08: 0000000000000001 R09: 00007ffc91fcb080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 00007f27d8f30940 R14: 0000000000000001 R15: 00007f27d8f222c0
 </TASK>
INFO: task syz-executor.0:3687 blocked for more than 143 seconds.
      Not tainted 5.17.0-rc2-syzkaller-00054-g27bb0b18c208 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28288 pid: 3687 ppid:  3667 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4986 [inline]
 __schedule+0xab2/0x4db0 kernel/sched/core.c:6295
 schedule+0xd2/0x260 kernel/sched/core.c:6368
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6427
 __mutex_lock_common kernel/locking/mutex.c:673 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:733
 blkdev_put+0x99/0x950 block/bdev.c:902
 blkdev_close+0x6a/0x80 block/fops.c:515
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7efd9b888c9b
RSP: 002b:00007ffd940a8da0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007efd9b888c9b
RDX: 0000001b30d20000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007efd9b9ea960 R08: 0000000000000000 R09: 00007ffd941ec080
R10: 00007ffd941ec090 R11: 0000000000000293 R12: 00000000001274c9
R13: 00007ffd940a8ea0 R14: 00007efd9b9e9030 R15: 0000000000000032
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb81120 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
5 locks held by kworker/u4:2/44:
2 locks held by getty/3273:
 #0: ffff88807f6b9098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b5b2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2077
1 lock held by udevd/3663:
 #0: ffff88801b222118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xc70 block/bdev.c:804
1 lock held by syz-executor.0/3687:
 #0: ffff88801b222118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x950 block/bdev.c:902

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.17.0-rc2-syzkaller-00054-g27bb0b18c208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 1154 Comm: kworker/0:3 Not tainted 5.17.0-rc2-syzkaller-00054-g27bb0b18c208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:prep_new_page mm/page_alloc.c:2436 [inline]
RIP: 0010:get_page_from_freelist+0xa8d/0x2f50 mm/page_alloc.c:4165
Code: 00 00 48 8b 7c 24 28 44 89 fe e8 6e 8d ff ff 8b 5c 24 14 83 e3 04 45 85 ff 0f 84 bd 18 00 00 f7 84 24 84 00 00 00 00 00 04 00 <0f> 85 76 19 00 00 85 db 0f 85 22 1a 00 00 48 8b 44 24 28 48 8d 78
RSP: 0018:ffffc900047c7838 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801d5c00c0 RSI: ffffffff81b4ee92 RDI: 0000000000000003
RBP: 000000000003d5f8 R08: 0000000000000002 R09: 0000000000000001
R10: ffffffff81c58582 R11: 000000000000001f R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88813fffa700 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f46530a1600 CR3: 000000000b88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 __alloc_pages_node include/linux/gfp.h:572 [inline]
 kmem_getpages mm/slab.c:1378 [inline]
 cache_grow_begin+0x75/0x350 mm/slab.c:2584
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2957
 ____cache_alloc mm/slab.c:3040 [inline]
 ____cache_alloc mm/slab.c:3023 [inline]
 slab_alloc_node mm/slab.c:3241 [inline]
 kmem_cache_alloc_node_trace+0x49c/0x5b0 mm/slab.c:3609
 __do_kmalloc_node mm/slab.c:3631 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3646
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1158 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:745 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:802 [inline]
 nsim_dev_trap_report_work+0x29a/0xbc0 drivers/net/netdevsim/dev.c:843
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
   7:	44 89 fe             	mov    %r15d,%esi
   a:	e8 6e 8d ff ff       	callq  0xffff8d7d
   f:	8b 5c 24 14          	mov    0x14(%rsp),%ebx
  13:	83 e3 04             	and    $0x4,%ebx
  16:	45 85 ff             	test   %r15d,%r15d
  19:	0f 84 bd 18 00 00    	je     0x18dc
  1f:	f7 84 24 84 00 00 00 	testl  $0x40000,0x84(%rsp)
  26:	00 00 04 00
* 2a:	0f 85 76 19 00 00    	jne    0x19a6 <-- trapping instruction
  30:	85 db                	test   %ebx,%ebx
  32:	0f 85 22 1a 00 00    	jne    0x1a5a
  38:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  3d:	48                   	rex.W
  3e:	8d                   	.byte 0x8d
  3f:	78                   	.byte 0x78


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
