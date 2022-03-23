Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6D4E57DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiCWRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbiCWRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:53:59 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E5F85BCA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:52:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id h14-20020a05660208ce00b00645c339411bso1544115ioz.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J1y43mE6bNM/LdVwI7vvL2XC8SCJ4ruiAt/TyEEcMXs=;
        b=P/zmLMi+ML4jo6NtS+GeYZ/yxFqem0JKOqoxwfr0RWUGVtVG3vOmJxZBuSHfjv7Vcf
         4ZBss/K93SvxWci6jLd+IKRkHXAXZhsk7Kj/Yicukw2NZB1YDn270yl2x4PpL815lO70
         JP4dHciheOYZ2+btmCSHi+M1Sb1Kwzux9oo8AuqTxANHW53o7L31MgIfbKm2pxcwmWZ+
         IgbqGLRzpTJuevQ6nXTO14uwTuK+0bHTXzTUTZCswOHMPTZ9EXScZ8bheIHcmTWcffAg
         rIq4dfEDm6v3xiqYk5KPrf8P9Yb1VVxWWd04UdGxCrLHq+R6cnD7y/7v0j+ak2QwjomM
         JPLg==
X-Gm-Message-State: AOAM533w0cYidE6PxWYPdsGQqhuTisieh6kx+uOuU8JC1BZPAhUkrdF0
        YsYuQhntUEDnmxGsRNSuoO9kbr6veOrFYWBrhl4gByrZ4dkp
X-Google-Smtp-Source: ABdhPJwW8Uxyiz7ZEqxYS7YwxT+NdchGWyoFa4MeRwOWSZp1uQLsOh22ynGCZjpO8RN7+B/QWPcZSeQ5WjozfcIabkd/QeP0iE7G
MIME-Version: 1.0
X-Received: by 2002:a05:6602:21c1:b0:640:9f52:61b4 with SMTP id
 c1-20020a05660221c100b006409f5261b4mr679791ioc.47.1648057948881; Wed, 23 Mar
 2022 10:52:28 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ccdc605dae66440@google.com>
Subject: [syzbot] INFO: task can't die in vmci_qp_broker_detach
From:   syzbot <syzbot+6e07eb10996f8ea7a825@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jhansen@vmware.com,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        syzkaller-bugs@googlegroups.com, vdasa@vmware.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    6b1f86f8e9c7 Merge tag 'folio-5.18b' of git://git.infradea..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141eed99700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc982714c733be2b
dashboard link: https://syzkaller.appspot.com/bug?extid=6e07eb10996f8ea7a825
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f0ca51700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152b7871700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e07eb10996f8ea7a825@syzkaller.appspotmail.com

INFO: task syz-executor172:4407 blocked for more than 143 seconds.
      Tainted: G        W         5.17.0-syzkaller-02172-g6b1f86f8e9c7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor172 state:D stack:25016 pid: 4407 ppid:  3638 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5073 [inline]
 __schedule+0x937/0x1090 kernel/sched/core.c:6382
 schedule+0xeb/0x1b0 kernel/sched/core.c:6454
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6513
 __mutex_lock_common+0xd1f/0x2590 kernel/locking/mutex.c:673
 __mutex_lock kernel/locking/mutex.c:733 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:785
 vmci_qp_broker_detach+0x129/0x12b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:444 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x7e2/0xf00 drivers/misc/vmw_vmci/vmci_context.c:497
 vmci_ctx_enqueue_datagram+0x3a7/0x440 drivers/misc/vmw_vmci/vmci_context.c:360
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:275 [inline]
 vmci_datagram_dispatch+0x479/0xc40 drivers/misc/vmw_vmci/vmci_datagram.c:339
 qp_notify_peer drivers/misc/vmw_vmci/vmci_queue_pair.c:1479 [inline]
 vmci_qp_broker_detach+0xb35/0x12b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2186
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:444 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x7e2/0xf00 drivers/misc/vmw_vmci/vmci_context.c:497
 vmci_host_close+0x96/0x160 drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x3fc/0x870 fs/file_table.c:317
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:190 [inline]
 exit_to_user_mode_prepare+0x1dd/0x200 kernel/entry/common.c:222
 __syscall_exit_to_user_mode_work kernel/entry/common.c:304 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:315
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa95cd5cc5b
RSP: 002b:00007fffd32b0640 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007fa95cd5cc5b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000c284f
R13: 00007fa95ce2540c R14: 00007fffd32b06a0 R15: 00007fa95ce25400
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Tainted: G        W         5.17.0-syzkaller-02172-g6b1f86f8e9c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc82/0xcd0 kernel/hung_task.c:369
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 55 Comm: kworker/u4:3 Tainted: G        W         5.17.0-syzkaller-02172-g6b1f86f8e9c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:rcu_read_lock_held_common kernel/rcu/update.c:104 [inline]
RIP: 0010:rcu_read_lock_sched_held+0x5a/0x130 kernel/rcu/update.c:123
Code: 8a b5 41 48 c7 44 24 08 36 db 5f 8c 48 c7 44 24 10 00 94 6f 81 48 89 e3 48 c1 eb 03 48 b8 f1 f1 f1 f1 00 f3 f3 f3 4a 89 04 33 <e8> f1 59 b3 08 85 c0 74 2a 45 31 ff e8 35 e8 00 00 84 c0 74 24 e8
RSP: 0018:ffffc90001a3f5e0 EFLAGS: 00000802
RAX: f3f3f300f1f1f1f1 RBX: 1ffff92000347ebc RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8e2054e8
RBP: ffffc90001a3f668 R08: dffffc0000000000 R09: fffffbfff1c40a9e
R10: fffffbfff1c40a9e R11: 0000000000000000 R12: ffffffff8cde7c60
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff888012408000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005620a28f3680 CR3: 00000001406f6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_tlb_flush+0x7b/0x190 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x5c7/0x910
 use_temporary_mm arch/x86/kernel/alternative.c:924 [inline]
 __text_poke+0x5bd/0x9f0 arch/x86/kernel/alternative.c:1021
 text_poke arch/x86/kernel/alternative.c:1083 [inline]
 text_poke_bp_batch+0x1b5/0x920 arch/x86/kernel/alternative.c:1297
 text_poke_flush arch/x86/kernel/alternative.c:1470 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1477
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 static_key_disable_cpuslocked+0xcc/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate+0x3c8/0x460 mm/kfence/core.c:793
 process_one_work+0x86c/0x1190 kernel/workqueue.c:2307
 worker_thread+0xab1/0x1300 kernel/workqueue.c:2454
 kthread+0x2a3/0x2d0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.059 msecs
----------------
Code disassembly (best guess):
   0:	8a b5 41 48 c7 44    	mov    0x44c74841(%rbp),%dh
   6:	24 08                	and    $0x8,%al
   8:	36 db 5f 8c          	fistpl %ss:-0x74(%rdi)
   c:	48 c7 44 24 10 00 94 	movq   $0xffffffff816f9400,0x10(%rsp)
  13:	6f 81
  15:	48 89 e3             	mov    %rsp,%rbx
  18:	48 c1 eb 03          	shr    $0x3,%rbx
  1c:	48 b8 f1 f1 f1 f1 00 	movabs $0xf3f3f300f1f1f1f1,%rax
  23:	f3 f3 f3
  26:	4a 89 04 33          	mov    %rax,(%rbx,%r14,1)
* 2a:	e8 f1 59 b3 08       	callq  0x8b35a20 <-- trapping instruction
  2f:	85 c0                	test   %eax,%eax
  31:	74 2a                	je     0x5d
  33:	45 31 ff             	xor    %r15d,%r15d
  36:	e8 35 e8 00 00       	callq  0xe870
  3b:	84 c0                	test   %al,%al
  3d:	74 24                	je     0x63
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
