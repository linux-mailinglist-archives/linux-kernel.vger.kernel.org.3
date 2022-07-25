Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC157FF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiGYMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiGYMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:36:17 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7732BC98
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:36:15 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u10-20020a6be30a000000b0067bcbb8a637so4176470ioc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0uOnlvEKwo0chgvpcHrAo428dCH/D37Bd91faoGhHGQ=;
        b=lGkxbg/KPicx5K0LDLOVGSHljKdTvh1+ntT86sltjt4+NN0pw8ya2s2Bct/2j48x3/
         Q+aX0a/mELz9trEuWojCr10zlMYHm6xtouOfEoRKSQO+pOVYOWOjtHI4bSxLKxkDRanz
         4qbSjuNPSiNnzXyHHBaBoJY+wWKFot1NNqUqk5BU6KIFCGMZafQUDhpRTNQuyyxN8mwD
         OaKqnPUqVSlAlnjmIg1JfO6XLWDJIu172XrlahkwB25g1AdLjGdPvWIQB+sd3aeVKDre
         bBvEjrArF2ncR1NohhkgPtoXZKlgXsziPev4ZFtsTPfXrYzJW405EmGOQIQG0WFgYuOY
         o/6w==
X-Gm-Message-State: AJIora89iZn7s5KouZBKVzyb08S9o9mayAayAtBUNXY9oanxsS7mNPHw
        XM7t10UEKFyRFmRW8ZmOoUYBGrNwZFmEu/CMbHFdDZV/KarR
X-Google-Smtp-Source: AGRyM1tTk3/C3rMkzMrRFsvZ4ZrsRZ7wJzK8t14/yZnOEDahqARRg6IgOXGG/sf8g5L2RAiwTwD9E6Cs2A+VWWHNxXhoNdDgvbZT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2048:b0:341:590a:da16 with SMTP id
 t8-20020a056638204800b00341590ada16mr5008631jaj.147.1658752575177; Mon, 25
 Jul 2022 05:36:15 -0700 (PDT)
Date:   Mon, 25 Jul 2022 05:36:15 -0700
In-Reply-To: <20220725121931.2795-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000389d905e4a06e02@google.com>
Subject: Re: [syzbot] WARNING in p9_client_destroy
From:   syzbot <syzbot+5e28cdb7ebd0f2389ca4@syzkaller.appspotmail.com>
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
INFO: task hung in p9_client_destroy

INFO: task syz-executor.0:4046 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24520 pid: 4046 ppid:     1 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5184 [inline]
 __schedule+0xa09/0x4f10 kernel/sched/core.c:6496
 schedule+0xd2/0x1f0 kernel/sched/core.c:6568
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x378/0x530 kernel/sched/completion.c:106
 p9_client_destroy+0x306/0x3b0 net/9p/client.c:1109
 v9fs_session_close+0x45/0x2d0 fs/9p/v9fs.c:504
 v9fs_kill_super+0x49/0x90 fs/9p/vfs_super.c:226
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7586c8a677
RSP: 002b:00007fffb29ce3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7586c8a677
RDX: 00007fffb29ce48a RSI: 000000000000000a RDI: 00007fffb29ce480
RBP: 00007fffb29ce480 R08: 00000000ffffffff R09: 00007fffb29ce250
R10: 00005555571af8b3 R11: 0000000000000246 R12: 00007f7586ce22a6
R13: 00007fffb29cf540 R14: 00005555571af810 R15: 00007fffb29cf580
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bd864f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bd861f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffffffff8bd87040 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by getty/3279:
 #0: ffff88814ac14098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2177

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc18/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 46 Comm: kworker/u4:3 Not tainted 5.19.0-rc4-next-20220628-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:preempt_latency_start kernel/sched/core.c:5628 [inline]
RIP: 0010:preempt_latency_start kernel/sched/core.c:5623 [inline]
RIP: 0010:preempt_count_add+0x81/0x140 kernel/sched/core.c:5651
Code: 05 2f b0 7e 25 ff ff ff 7f 39 c3 74 03 5b 5d c3 48 8b 5c 24 10 48 89 df e8 0c 9a 0c 00 85 c0 75 35 65 48 8b 2c 25 80 6f 02 00 <48> 8d bd 48 14 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90000b779f0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff897b1e8a RCX: 1ffffffff21eeb10
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff897b1e8a
RBP: ffff888017483a80 R08: ffffffff812bb538 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4129efb990 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x10a/0x1350 kernel/locking/mutex.c:747
 arch_jump_label_transform_queue+0x58/0x100 arch/x86/kernel/jump_label.c:136
 __jump_label_update+0x12e/0x400 kernel/jump_label.c:451
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:825 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:803
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16da19aa080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=5e28cdb7ebd0f2389ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147ce022080000

