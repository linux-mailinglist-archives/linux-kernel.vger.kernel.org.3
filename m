Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6556458C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiGCHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGCHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:21:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6358C9598
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:21:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n4-20020a5d8244000000b0067566682c09so4040908ioo.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 00:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VDoD7h3C8AGksGr6X3wcCZsNshIAV4SW4t5fWEPCkNw=;
        b=6IzE1SJostD0cHG/QTaJ+IfpS5BRfxZeU10CUNmDtfh+3kJPcAU1GPrHsIkleECUo6
         eSeniiQWLGPibw8+h3LNwt/nMqVUhmXy4F7rPs83GCz3Iap8h300THY7MTsikcZVoZKs
         fIjuRseILRz8jZqWx5MHLC9zF5gaItWW1f204BEnmkOLqS88CZGIpW4Vpx9eGSvmLHrf
         jHS2u/bgXh41w0RVBWiz4XOf4BIgX49ukqzFhVOQgVWHNZ2frBt7lk3LTTAPHN/QIGTF
         rDWc/6NkZmUgwR6i1rZ4OWZmniMYcbZneNFaj4lU/Zb4PRU9fHM2lDdCbydkiDB4YXYn
         mM4g==
X-Gm-Message-State: AJIora8PU8pEA8Ka944ySGlMJCgdI3QjnvvHnO7pIbHVZfPtrZhcjzi+
        f4quQBEjRkGbsxDDOhGL0+4qMSqfDz8eHMSvr7WhnsQPDOzJ
X-Google-Smtp-Source: AGRyM1sklNbP8i9MrldQcZTbiD6etFJhfWB3JJ/x/PT6/llEGmFKSwKWAI0dJ0dm8SQMWIAphnaVXSA/5BjE2V3hwzlDXGwqClro
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:2d9:a3ae:16be with SMTP id
 l1-20020a056e021c0100b002d9a3ae16bemr13618004ilh.68.1656832867575; Sun, 03
 Jul 2022 00:21:07 -0700 (PDT)
Date:   Sun, 03 Jul 2022 00:21:07 -0700
In-Reply-To: <20220703065507.1176-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000862fc705e2e17680@google.com>
Subject: Re: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
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
INFO: task hung in do_read_cache_folio

INFO: task udevd:4021 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26160 pid: 4021 ppid:  2974 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 io_schedule+0xba/0x130 kernel/sched/core.c:8645
 folio_wait_bit_common+0x4f2/0xa90 mm/filemap.c:1324
 folio_put_wait_locked mm/filemap.c:1498 [inline]
 do_read_cache_folio+0x3a4/0x6e0 mm/filemap.c:3541
 do_read_cache_page mm/filemap.c:3601 [inline]
 read_cache_page+0x59/0x2a0 mm/filemap.c:3610
 read_mapping_page include/linux/pagemap.h:759 [inline]
 read_part_sector+0xf6/0x920 block/partitions/core.c:715
 adfspart_check_POWERTEC+0x93/0x530 block/partitions/acorn.c:454
 check_partition block/partitions/core.c:147 [inline]
 blk_add_partitions block/partitions/core.c:600 [inline]
 bdev_disk_changed block/partitions/core.c:686 [inline]
 bdev_disk_changed+0x629/0xf60 block/partitions/core.c:653
 blkdev_get_whole+0x18a/0x2d0 block/bdev.c:686
 blkdev_get_by_dev.part.0+0x5ec/0xb90 block/bdev.c:823
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:857
 blkdev_open+0x13c/0x2c0 block/fops.c:481
 do_dentry_open+0x4a1/0x11f0 fs/open.c:848
 do_open fs/namei.c:3520 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3653
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9721b25697
RSP: 002b:00007fff782335e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055f98610efe0 RCX: 00007f9721b25697
RDX: 00000000000a0800 RSI: 000055f98610d320 RDI: 00000000ffffff9c
RBP: 000055f98610d320 R08: 0000000000000001 R09: 00007fff7830b080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055f9860f2b80 R14: 0000000000000001 R15: 000055f9860e9910
 </TASK>
INFO: task syz-executor.0:4090 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27904 pid: 4090 ppid:  4026 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 blkdev_put+0xbc/0x770 block/bdev.c:912
 blkdev_close+0x64/0x80 block/fops.c:495
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7d9a23bd4b
RSP: 002b:00007ffdef987890 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00007f7d9a23bd4b
RDX: 0000001b2f220000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f7d9a39d960 R08: 0000000000000000 R09: 00007ffdef9d7080
R10: 00007ffdef9d7090 R11: 0000000000000293 R12: 000000000000f504
R13: 00007ffdef987990 R14: 00007ffdef9879b0 R15: 0000000000000032
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by getty/3282:
 #0: ffff8880263ab098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
1 lock held by udevd/4021:
 #0: ffff88801dafb118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb90 block/bdev.c:814
1 lock held by syz-executor.0/4090:
 #0: ffff88801dafb118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xbc/0x770 block/bdev.c:912

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events kfree_rcu_work
RIP: 0010:preempt_count_add+0x26/0x140 kernel/sched/core.c:5602
Code: 00 00 00 00 48 c7 c0 40 f8 f4 90 55 48 ba 00 00 00 00 00 fc ff df 48 89 c1 53 83 e0 07 89 fb 48 c1 e9 03 83 c0 03 0f b6 14 11 <38> d0 7c 08 84 d2 0f 85 e1 00 00 00 8b 15 18 05 a3 0f 65 01 1d 11
RSP: 0018:ffffc90000137cf0 EFLAGS: 00000006
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 1ffffffff21e9f08
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff8880b9a39700 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc90000137da8 R14: ffff8880119b7d00 R15: ffff8880b9a39700
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ab85f0c600 CR3: 000000000ba8e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:118 [inline]
 _raw_spin_lock_irq+0x16/0x50 kernel/locking/spinlock.c:170
 process_one_work+0xae0/0x1610 kernel/workqueue.c:2317
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 c7 c0 40 f8 f4 90 	mov    $0xffffffff90f4f840,%rax
   b:	55                   	push   %rbp
   c:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  13:	fc ff df
  16:	48 89 c1             	mov    %rax,%rcx
  19:	53                   	push   %rbx
  1a:	83 e0 07             	and    $0x7,%eax
  1d:	89 fb                	mov    %edi,%ebx
  1f:	48 c1 e9 03          	shr    $0x3,%rcx
  23:	83 c0 03             	add    $0x3,%eax
  26:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
* 2a:	38 d0                	cmp    %dl,%al <-- trapping instruction
  2c:	7c 08                	jl     0x36
  2e:	84 d2                	test   %dl,%dl
  30:	0f 85 e1 00 00 00    	jne    0x117
  36:	8b 15 18 05 a3 0f    	mov    0xfa30518(%rip),%edx        # 0xfa30554
  3c:	65                   	gs
  3d:	01                   	.byte 0x1
  3e:	1d                   	.byte 0x1d
  3f:	11                   	.byte 0x11


Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13817a50080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16817a50080000

