Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D547D5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbhLVRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:33:27 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54797 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhLVRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:33:26 -0500
Received: by mail-il1-f197.google.com with SMTP id g14-20020a92c7ce000000b002b1e78da1f9so1658362ilk.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bEbdWmUFAsr/tvwx1s231eqfR4JsDg+TU1S7GLvjmuM=;
        b=Jq2li+yGU+D8o0nLYXgx8Vv0mVpx1C/YZaEea9cPX10kOgNIQPf7W+ywzr2jSUdT54
         b7r2Yp2ZTezONXumvlLshxwiqLV5C9gzZlIRy2sbBAyFx0oiP0zM4pShjNhE6dI/YQ7x
         oqQJqGXaLgNF7o88DrryqYfCSNasuGpN9GRTnUfmgyjqadqR2jiir//prVy32conqeLg
         G6ZXNLGxt13xFH0S9o0KVuFIhw7n8YLsRGDfmzzoI1tis0C9E5Skf3CONSTqosDWcvNh
         eIdGWuU/bxgsW6qL2N+w3GR6YX9Seq0hQc60tUWdbXOxInbMw70YVSguTJFjhhltjgE6
         zucg==
X-Gm-Message-State: AOAM531q1mgKIbe/VC8771K7oh9N1n8EkQAWCE7433gmPD+7JGx+Xixq
        3ZKU8Ac7OgLvAml2ZsyPiXzHLYe5OM4E4KFtWzgWGUaL1WTW
X-Google-Smtp-Source: ABdhPJyYBiS5x4l3gZVXhYpVRV8hsZ20+LzUWD5jeiI1BvDACkJEmO0Es+DquPVuHpzU77a9fjRcOGK7d92ugqKUVFmAHj0BMLZB
MIME-Version: 1.0
X-Received: by 2002:a02:a306:: with SMTP id q6mr2126689jai.319.1640194406057;
 Wed, 22 Dec 2021 09:33:26 -0800 (PST)
Date:   Wed, 22 Dec 2021 09:33:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef8cbb05d3bf84cd@google.com>
Subject: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (4)
From:   syzbot <syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9eaa88c7036e Merge tag 'libata-5.16-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142d4143b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bdfd29b408d1b6
dashboard link: https://syzkaller.appspot.com/bug?extid=03464269af631f4a4bdf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b1537db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125de549b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=10502 jiffies, g=5509, q=170)
rcu: All QSes seen, last rcu_preempt kthread activity 8642 (4295000735-4294992093), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 8643 jiffies! g5509 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28208 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881 kernel/time/timer.c:1881
 rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1955 kernel/rcu/tree.c:1955
 rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2128 kernel/rcu/tree.c:2128
 kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 0
CPU: 0 PID: 3672 Comm: syz-executor549 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline] kernel/rcu/tree_stall.h:481
 rcu_check_gp_kthread_starvation.cold+0x1fb/0x200 kernel/rcu/tree_stall.h:481 kernel/rcu/tree_stall.h:481
 print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:729 [inline]
 rcu_pending kernel/rcu/tree.c:3878 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:586 [inline] kernel/rcu/tree.c:2597
 check_cpu_stall kernel/rcu/tree_stall.h:729 [inline] kernel/rcu/tree.c:2597
 rcu_pending kernel/rcu/tree.c:3878 [inline] kernel/rcu/tree.c:2597
 rcu_sched_clock_irq+0x2125/0x2200 kernel/rcu/tree.c:2597 kernel/rcu/tree.c:2597
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428 kernel/time/tick-sched.c:1428
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline] kernel/time/hrtimer.c:1749
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline] arch/x86/kernel/apic/apic.c:1103
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638 arch/x86/include/asm/idtentry.h:638
RIP: 0010:owner_on_cpu kernel/locking/rwsem.c:667 [inline]
RIP: 0010:owner_on_cpu kernel/locking/rwsem.c:667 [inline] kernel/locking/rwsem.c:750
RIP: 0010:rwsem_spin_on_owner+0x1aa/0x290 kernel/locking/rwsem.c:750 kernel/locking/rwsem.c:750
Code: a8 08 75 33 49 8d 7c 24 34 48 89 f8 48 c1 e8 03 42 0f b6 14 28 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 b0 00 00 00 <41> 8b 44 24 34 85 c0 0f 85 14 ff ff ff b8 08 00 00 00 48 83 c4 08
RSP: 0018:ffffc90002817448 EFLAGS: 00000246
RAX: 0000000000000007 RBX: ffff88806da34680 RCX: ffffffff815a9743
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88807d2000b4
RBP: ffff88806da34688 R08: 0000000000000000 R09: ffff888078b322c7
R10: ffffed100f166458 R11: 0000000000000001 R12: ffff88807d200080
R13: dffffc0000000000 R14: ffff888078b322c0 R15: ffffed100f166458
 rwsem_optimistic_spin kernel/locking/rwsem.c:808 [inline]
 rwsem_optimistic_spin kernel/locking/rwsem.c:808 [inline] kernel/locking/rwsem.c:1068
 rwsem_down_write_slowpath+0x1a8/0x1110 kernel/locking/rwsem.c:1068 kernel/locking/rwsem.c:1068
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 __down_write_common kernel/locking/rwsem.c:1268 [inline] kernel/locking/rwsem.c:1524
 __down_write_common kernel/locking/rwsem.c:1265 [inline] kernel/locking/rwsem.c:1524
 __down_write kernel/locking/rwsem.c:1277 [inline] kernel/locking/rwsem.c:1524
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524 kernel/locking/rwsem.c:1524
 inode_lock include/linux/fs.h:783 [inline]
 inode_lock include/linux/fs.h:783 [inline] fs/ext4/file.c:263
 ext4_buffered_write_iter+0xb6/0x3b0 fs/ext4/file.c:263 fs/ext4/file.c:263
 ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:681 fs/ext4/file.c:681
 call_write_iter include/linux/fs.h:2162 [inline]
 call_write_iter include/linux/fs.h:2162 [inline] fs/read_write.c:725
 do_iter_readv_writev+0x472/0x750 fs/read_write.c:725 fs/read_write.c:725
 do_iter_write+0x188/0x710 fs/read_write.c:851 fs/read_write.c:851
 vfs_iter_write+0x70/0xa0 fs/read_write.c:892 fs/read_write.c:892
 iter_file_splice_write+0x6fa/0xc10 fs/splice.c:689 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 do_splice_from fs/splice.c:767 [inline] fs/splice.c:936
 direct_splice_actor+0x110/0x180 fs/splice.c:936 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979 fs/splice.c:979
 do_sendfile+0xaf2/0x1250 fs/read_write.c:1245 fs/read_write.c:1245
 __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 __do_sys_sendfile64 fs/read_write.c:1310 [inline] fs/read_write.c:1296
 __se_sys_sendfile64 fs/read_write.c:1296 [inline] fs/read_write.c:1296
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296 fs/read_write.c:1296
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f34d1e3f169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc49095728 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f34d1e3f169
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00008400fffffffb R11: 0000000000000246 R12: 0000000000076d4d
R13: 00007ffc4909573c R14: 00007ffc49095750 R15: 00007ffc49095740
 </TASK>
----------------
Code disassembly (best guess):
   0:	a8 08                	test   $0x8,%al
   2:	75 33                	jne    0x37
   4:	49 8d 7c 24 34       	lea    0x34(%r12),%rdi
   9:	48 89 f8             	mov    %rdi,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 0f b6 14 28       	movzbl (%rax,%r13,1),%edx
  15:	48 89 f8             	mov    %rdi,%rax
  18:	83 e0 07             	and    $0x7,%eax
  1b:	83 c0 03             	add    $0x3,%eax
  1e:	38 d0                	cmp    %dl,%al
  20:	7c 08                	jl     0x2a
  22:	84 d2                	test   %dl,%dl
  24:	0f 85 b0 00 00 00    	jne    0xda
* 2a:	41 8b 44 24 34       	mov    0x34(%r12),%eax <-- trapping instruction
  2f:	85 c0                	test   %eax,%eax
  31:	0f 85 14 ff ff ff    	jne    0xffffff4b
  37:	b8 08 00 00 00       	mov    $0x8,%eax
  3c:	48 83 c4 08          	add    $0x8,%rsp
----------------
Code disassembly (best guess):
   0:	a8 08                	test   $0x8,%al
   2:	75 33                	jne    0x37
   4:	49 8d 7c 24 34       	lea    0x34(%r12),%rdi
   9:	48 89 f8             	mov    %rdi,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 0f b6 14 28       	movzbl (%rax,%r13,1),%edx
  15:	48 89 f8             	mov    %rdi,%rax
  18:	83 e0 07             	and    $0x7,%eax
  1b:	83 c0 03             	add    $0x3,%eax
  1e:	38 d0                	cmp    %dl,%al
  20:	7c 08                	jl     0x2a
  22:	84 d2                	test   %dl,%dl
  24:	0f 85 b0 00 00 00    	jne    0xda
* 2a:	41 8b 44 24 34       	mov    0x34(%r12),%eax <-- trapping instruction
  2f:	85 c0                	test   %eax,%eax
  31:	0f 85 14 ff ff ff    	jne    0xffffff4b
  37:	b8 08 00 00 00       	mov    $0x8,%eax
  3c:	48 83 c4 08          	add    $0x8,%rsp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
