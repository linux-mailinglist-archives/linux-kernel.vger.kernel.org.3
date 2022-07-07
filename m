Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0991A56A39D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiGGN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiGGN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:28:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D892E6B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:28:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x4-20020a6bd004000000b00675354ad495so9865736ioa.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ICMF6Z+6hLByunHFP1A9XCQIQCd9NfDt0I8iZQQhx8k=;
        b=1frb4fsZR6+gUcXUdgNtVJSQTfALYQyUStmbv8YgqiFK6TQCtjcVVYHbSxgb+qccRw
         OKoAmawagquIbsqdTVKNjW3J6DcABHKR6/jlFAZINLb3Z7GyJHzGfPZ82wgRww09N2Bg
         sTijYEPy6Ji7yavUFQw69RczU0NZTI5P3eAX54fBhzxIdUmbNMUJlufGjid0ew2qZhVO
         Z/EHmckN5Mq2+D5hVggU3s+/sEggDbohdqHgUIvqSYJRUXJQb9ur/wU2KfZGcZmTlnH8
         tyHJY1DEFHNb+HLrSFCdewiJWbkItA0dXhxtyT9e17q0Np1+FOTovE7abD5nh9PhIHSL
         w/xg==
X-Gm-Message-State: AJIora+c7D69G6mgHBdmsdlLmBrW0qUqNCkzpVimiYpOw/XQPs4CQUey
        o/fqvZXSFDBeeTHdAa1XHA7bjIKqcri/4LI70d/vImR1QJw0
X-Google-Smtp-Source: AGRyM1vY8RpGwALyZLu3OmgFsOYHMk8TIAORceSWNVt4sX2pDNxaIFQGPA6GevdiUN1JqUjtOvxvYYd5iuyaS8RXF3AaH2jeFafx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1291:b0:2dc:2936:8da0 with SMTP id
 y17-20020a056e02129100b002dc29368da0mr8116509ilq.283.1657200487902; Thu, 07
 Jul 2022 06:28:07 -0700 (PDT)
Date:   Thu, 07 Jul 2022 06:28:07 -0700
In-Reply-To: <20220707110649.2164-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006735fa05e3370ecf@google.com>
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
INFO: task hung in blkdev_put

INFO: task syz-executor.0:4094 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc5-syzkaller-00105-g9f09069cde34-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27904 pid: 4094 ppid:  4052 flags:0x00000004
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
RIP: 0033:0x7f6efd23bd4b
RSP: 002b:00007ffe1bd4ccd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00007f6efd23bd4b
RDX: 0000001b30e20000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f6efd39d960 R08: 0000000000000000 R09: 00007ffe1bde5080
R10: 00007ffe1bde5090 R11: 0000000000000293 R12: 000000000000e2d4
R13: 00007ffe1bd4cdd0 R14: 00007ffe1bd4cdf0 R15: 0000000000000032
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by getty/3283:
 #0: ffff88814b128098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d232e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
1 lock held by udevd/4048:
 #0: ffff88801d9b3118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb90 block/bdev.c:814
1 lock held by syz-executor.0/4094:
 #0: ffff88801d9b3118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xbc/0x770 block/bdev.c:912

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.19.0-rc5-syzkaller-00105-g9f09069cde34-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c9/0x240 drivers/acpi/processor_idle.c:554


Tested on:

commit:         9f09069c Merge tag 'for-linus' of https://github.com/o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12d44d84080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa95f12403a2e0d2
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dad724080000

