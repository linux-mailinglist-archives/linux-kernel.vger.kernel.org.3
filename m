Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABA54E23B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377194AbiFPNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377174AbiFPNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:41:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2632CDF2;
        Thu, 16 Jun 2022 06:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71B32B823A9;
        Thu, 16 Jun 2022 13:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F88C34114;
        Thu, 16 Jun 2022 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655386895;
        bh=u7NjnJSqpSr5lin/8LLQXoXUB9NUCCYdNVETTQ4i2sM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=osi+2nAEnVxUnJ6n97ZkThRbvfMkcaWxVcd6Z+C/MiUI3vPDa0VlTFmXVQcMMCAOb
         5yOt0L8STYnI0GxVsrrhnJUzp9NTCWl6nhFjRHh4AR+6jmUbfnirJv5cHUc8uKhCXG
         eA6SjyavcfbQPl0V/LPMa2TrbJ7f/glL2iDorm0JCc3pnuupTnddArR5vAlZGONULj
         zOaIZYsU2tdH1PPiiRX7M5JFRInAlLBkpMZDQ/IChWSRXv+mOkuoeW3LvbElWzEY7V
         pjkln5CQ2EAsWfZuroKWCaxbfIgSkJfU1hh6cyIO+oj5A/Q4ovuzJhsCoh185Oju9Z
         znSPvukG8+RzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E41365C0546; Thu, 16 Jun 2022 06:41:34 -0700 (PDT)
Date:   Thu, 16 Jun 2022 06:41:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     syzbot <syzbot+ac3a03378e4deddd5f27@syzkaller.appspotmail.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] linux-next test error: WARNING in ct_idle_exit
Message-ID: <20220616134134.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000064f6b305e18bee4c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000064f6b305e18bee4c@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:53:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1443dac3f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
> dashboard link: https://syzkaller.appspot.com/bug?extid=ac3a03378e4deddd5f27
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ac3a03378e4deddd5f27@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:335 ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335

I am going to go out on a limb and suggest that Peter Zijlstra' recent
idle-fix patch series is needed here.

							Thanx, Paul

> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> no locks held by swapper/1/0.
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  trace_lock_acquire include/trace/events/lock.h:24 [inline]
>  lock_acquire.cold+0x1f/0x40 kernel/locking/lockdep.c:5636
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
>  down_trylock+0xe/0x60 kernel/locking/semaphore.c:139
>  __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
>  console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
>  console_trylock_spinning kernel/printk/printk.c:2003 [inline]
>  vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 1 lock held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){....}-{2:2}, at: down_trylock+0xe/0x60 kernel/locking/semaphore.c:139
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  trace_lock_release include/trace/events/lock.h:69 [inline]
>  lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5676
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
>  _raw_spin_unlock_irqrestore+0x16/0x70 kernel/locking/spinlock.c:194
>  down_trylock+0x45/0x60 kernel/locking/semaphore.c:143
>  __down_trylock_console_sem+0xfb/0x120 kernel/printk/printk.c:276
>  console_trylock+0x13/0xd0 kernel/printk/printk.c:2731
>  console_trylock_spinning kernel/printk/printk.c:2003 [inline]
>  vprintk_emit+0x127/0x680 kernel/printk/printk.c:2403
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> include/trace/events/sched.h:170 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 2 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  trace_sched_waking include/trace/events/sched.h:170 [inline]
>  trace_sched_waking include/trace/events/sched.h:170 [inline]
>  try_to_wake_up+0xe14/0x17e0 kernel/sched/core.c:4089
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> include/linux/rcupdate.h:707 rcu_read_lock() used illegally while idle!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  rcu_read_lock include/linux/rcupdate.h:707 [inline]
>  select_task_rq_fair+0x649/0x3c40 kernel/sched/fair.c:6907
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/fair.c:6908 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  select_task_rq_fair+0x5e6/0x3c40 kernel/sched/fair.c:6908
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/fair.c:6537 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  select_idle_sibling kernel/sched/fair.c:6537 [inline]
>  select_task_rq_fair+0x2193/0x3c40 kernel/sched/fair.c:6938
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/fair.c:6217 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  test_idle_cores kernel/sched/fair.c:6217 [inline]
>  select_idle_sibling kernel/sched/fair.c:6542 [inline]
>  select_task_rq_fair+0x2a49/0x3c40 kernel/sched/fair.c:6938
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/fair.c:6344 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  select_idle_cpu kernel/sched/fair.c:6344 [inline]
>  select_idle_sibling kernel/sched/fair.c:6551 [inline]
>  select_task_rq_fair+0x2365/0x3c40 kernel/sched/fair.c:6938
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 5.19.0-rc2-next-20220616-syzkaller #0 Not tainted
> -----------------------------
> include/linux/rcupdate.h:735 rcu_read_unlock() used illegally while idle!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> 3 locks held by swapper/1/0:
>  #0: ffffffff8bd75ed8 ((console_sem).lock){-...}-{2:2}, at: up+0x12/0xb0 kernel/locking/semaphore.c:187
>  #1: ffff888020960988 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xaa/0x17e0 kernel/sched/core.c:4084
>  #2: ffffffff8bd87780 (rcu_read_lock){....}-{1:2}, at: select_task_rq_fair+0x269/0x3c40 kernel/sched/fair.c:6886
> 
> stack backtrace:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  rcu_read_unlock include/linux/rcupdate.h:735 [inline]
>  select_task_rq_fair+0x59b/0x3c40 kernel/sched/fair.c:6940
>  select_task_rq kernel/sched/core.c:3495 [inline]
>  try_to_wake_up+0x3d6/0x17e0 kernel/sched/core.c:4185
>  up+0x75/0xb0 kernel/locking/semaphore.c:191
>  __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:293
>  __console_unlock kernel/printk/printk.c:2831 [inline]
>  console_unlock+0x5e1/0x780 kernel/printk/printk.c:3078
>  vprintk_emit+0x144/0x680 kernel/printk/printk.c:2404
>  vprintk+0x80/0x90 kernel/printk/printk_safe.c:52
>  _printk+0xba/0xed kernel/printk/printk.c:2425
>  __warn+0x91/0x190 kernel/panic.c:611
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x1b/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc2-next-20220616-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> Code: 00 02 00 00 31 ff 48 89 de 0f 1f 44 00 00 48 85 db 75 12 0f 1f 44 00 00 5b be 03 00 00 00 31 ff e9 01 fe ff ff 0f 1f 44 00 00 <0f> 0b eb e5 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 41 89 f4 55
> RSP: 0018:ffffc90000187d78 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> RDX: ffff888011a4ba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000c9b000 CR3: 0000000079099000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  cpuidle_enter_state+0x6f7/0xc80 drivers/cpuidle/cpuidle.c:240
>  cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:352
>  call_cpuidle kernel/sched/idle.c:155 [inline]
>  cpuidle_idle_call kernel/sched/idle.c:236 [inline]
>  do_idle+0x3e8/0x590 kernel/sched/idle.c:303
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
>  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
>  secondary_startup_64_no_verify+0xce/0xdb
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
