Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED96954FC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383115AbiFQRnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382893AbiFQRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB2338AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F86061EFC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861F2C3411B;
        Fri, 17 Jun 2022 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655487786;
        bh=nH0w0MBUUISFnSYblL27SMlNQSr9qEIJNcp2uDMuG08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QzGxPwLcBMHQ4ZWrulhnIlsxVoTn/hvrdd5JnbcVYsVdnQE+e1wrRGZQwm2cqnLFE
         tltHGtIkTyj/7wUDBZndw4/rK7B1t7KZgQnTW9FsO6HQ1Y4hLMbNVC9UhwOkxakxXn
         yh4KhAH0oqI89jCUZ1kSKaTcsQwblAPJOj9CjY8znUgSA2H6os4ihHHw/5YsP7h16L
         m65s6MgMbF1ID1vB6BFEv33JQaFWuX9X5OoDecXmB+6/Mxr4mzSMWyjWkmPk1ycLRD
         Yo8otIPoX8kv+O1eP4LnXIynsNjUrkPUWUKPZTJbC7bYpJBgp7tL/dbnVzU0ZcXPwm
         yQ6Av83cYU78g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B7E85C0328; Fri, 17 Jun 2022 10:43:06 -0700 (PDT)
Date:   Fri, 17 Jun 2022 10:43:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     syzbot <syzbot+d9bf4b9035073dc73df9@syzkaller.appspotmail.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in ct_idle_exit
Message-ID: <20220617174306.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000f82cf305e19e70e6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f82cf305e19e70e6@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:58:19PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c6d7e3b385f1 Add linux-next specific files for 20220616
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=120e19a7f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d495405e4a98620
> dashboard link: https://syzkaller.appspot.com/bug?extid=d9bf4b9035073dc73df9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d9bf4b9035073dc73df9@syzkaller.appspotmail.com

This bug is due to the fact that I jumped the gun with this commit:

fd2cb972fdc7 ("context_tracking: Interrupts always disabled for ct_idle_exit()")

I will move this to an experimental branch for the time being, and please
accept my apologies for the hassle!

							Thanx, Paul

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:335 ct_idle_exit+0x34/0x40 kernel/context_tracking.c:335
> 
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
> RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
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
> RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
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
> RDX: ffff888011aaba80 RSI: 0000000000000200 RDI: 0000000000000000
> RBP: ffffffff8c7bf520 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00060eda0 CR3: 000000001d18f000 CR4: 00000000003506e0
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
