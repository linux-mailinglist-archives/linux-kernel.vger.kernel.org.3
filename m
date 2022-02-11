Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581C4B23B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349198AbiBKKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:51:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiBKKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:51:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CAD6A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GLm+KvRrEwRZFrrXIWURqoXEA2SInMX7B9xsdcrqh6s=; b=jCqg6DeYVDkrxdmWUhOcOTD5XL
        KJ3I9M2hquDsH+ryirBtogtgzPZXQIIQ3o+62eTtPafU4TArgxKROYT45pdXFTUyiXUJq+8ID6Mm5
        XaU/e1GX4MeDlxbzUyyBLSzSiAlw/xg2puiswy4RsQD0JJf89ba7fBHs6w7JfU+XoQFkaDRu2JDeS
        XWGVMNsQ5dJccmN3PX6RgYzmbMxyAaHxLBIZMioEpJrvyTuA7IMmjYUPWtObttQJ2NCUQqbA4Z4vZ
        qkX7uM6uL6Xr+zD50rDwMvP8wRUl0VarXLV9Qq1KcROU/796NdVAkGmtbGLliR3S8DXCKFJUZfVJC
        57vG8NSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nITW7-00AKRa-96; Fri, 11 Feb 2022 10:51:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BA8C9853C7; Fri, 11 Feb 2022 11:51:06 +0100 (CET)
Date:   Fri, 11 Feb 2022 11:51:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <20220211105106.GS23216@worktop.programming.kicks-ass.net>
References: <20220118153254.358748-1-longman@redhat.com>
 <YgTms3tGYeQ4HYFZ@hirez.programming.kicks-ass.net>
 <e30a6464-708b-4946-65f0-c9a1e6bf2b35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30a6464-708b-4946-65f0-c9a1e6bf2b35@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:04:59PM -0500, Waiman Long wrote:
> On 2/10/22 05:19, Peter Zijlstra wrote:

> I am sorry that I might have stripped out too much for the lockdep splat to
> make it understandable. Below is the full lockdep splat:

Right, so please just transcribe the relevant bits instead of including
this massive splat. It really isn't too complicated.

> [ 9776.459819] ======================================================
> [ 9776.459820] WARNING: possible circular locking dependency detected
> [ 9776.459821] 5.14.0-0.rc4.35.el9.x86_64+debug #1 Not tainted
> [ 9776.459823] ------------------------------------------------------
> [ 9776.459824] stress-ng/117708 is trying to acquire lock:
> [ 9776.459825] ffffffff892d41d8 ((console_sem).lock){-...}-{2:2}, at:
> down_trylock+0x13/0x70
> 
> [ 9776.459831] but task is already holding lock:
> [ 9776.459832] ffff888e005f6d18 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x27/0x130
> 
> [ 9776.459837] which lock already depends on the new lock.
> 
> 
> [ 9776.459839] the existing dependency chain (in reverse order) is:
> 
> [ 9776.459841] -> #2 (&rq->__lock){-.-.}-{2:2}:
> [ 9776.459845]        __lock_acquire+0xb72/0x1870
> [ 9776.459846]        lock_acquire+0x1ca/0x570
> [ 9776.459847]        _raw_spin_lock_nested+0x2f/0x80
> [ 9776.459848]        raw_spin_rq_lock_nested+0x27/0x130
> [ 9776.459849]        task_fork_fair+0x41/0x550
> [ 9776.459850]        sched_fork+0x40b/0xb60
> [ 9776.459851]        copy_process+0x160b/0x4db0
> [ 9776.459852]        kernel_clone+0xba/0x880
> [ 9776.459853]        kernel_thread+0xae/0xe0
> [ 9776.459853]        rest_init+0x22/0x2f0
> [ 9776.459854]        start_kernel+0x3cd/0x3eb
> [ 9776.459855]        secondary_startup_64_no_verify+0xc2/0xcb
> 
> [ 9776.459857] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> [ 9776.459860]        __lock_acquire+0xb72/0x1870
> [ 9776.459861]        lock_acquire+0x1ca/0x570
> [ 9776.459862]        _raw_spin_lock_irqsave+0x40/0x90
> [ 9776.459863]        try_to_wake_up+0x9d/0x1210
> [ 9776.459864]        up+0x7a/0xb0
> [ 9776.459864]        __up_console_sem+0x33/0x70
> [ 9776.459865]        console_unlock+0x3a1/0x5f0
> [ 9776.459866]        vprintk_emit+0x23b/0x2b0
> [ 9776.459867]        devkmsg_emit.constprop.0+0xab/0xdc
> [ 9776.459868]        devkmsg_write.cold+0x4e/0x78
> [ 9776.459869]        do_iter_readv_writev+0x343/0x690
> [ 9776.459870]        do_iter_write+0x123/0x340
> [ 9776.459871]        vfs_writev+0x19d/0x520
> [ 9776.459871]        do_writev+0x110/0x290
> [ 9776.459872]        do_syscall_64+0x3b/0x90
> [ 9776.459873]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [ 9776.459875] -> #0 ((console_sem).lock){-...}-{2:2}:
> [ 9776.459878]        check_prev_add+0x15e/0x20f0
> [ 9776.459880]        validate_chain+0xaba/0xde0
> [ 9776.459880]        __lock_acquire+0xb72/0x1870
> [ 9776.459881]        lock_acquire+0x1ca/0x570
> [ 9776.459883]        _raw_spin_lock_irqsave+0x40/0x90
> [ 9776.459884]        down_trylock+0x13/0x70
> [ 9776.459885]        __down_trylock_console_sem+0x2a/0xb0
> [ 9776.459886]        console_trylock_spinning+0x13/0x1f0
> [ 9776.459887]        vprintk_emit+0x1e6/0x2b0
> [ 9776.459888]        printk+0xb2/0xe3
> [ 9776.459889]        __warn_printk+0x9b/0xf3
> [ 9776.459889]        update_rq_clock+0x3c2/0x780
> [ 9776.459890]        do_sched_rt_period_timer+0x19e/0x9a0
> [ 9776.459891]        sched_rt_period_timer+0x6b/0x150
> [ 9776.459892]        __run_hrtimer+0x27a/0xb20
> [ 9776.459893]        __hrtimer_run_queues+0x159/0x260
> [ 9776.459894]        hrtimer_interrupt+0x2cb/0x8f0
> [ 9776.459895]        __sysvec_apic_timer_interrupt+0x13e/0x540
> [ 9776.459896]        sysvec_apic_timer_interrupt+0x6a/0x90
> [ 9776.459897]        asm_sysvec_apic_timer_interrupt+0x12/0x20
> [ 9776.459897]        _raw_spin_unlock_irqrestore+0x3f/0x50
> [ 9776.459898]        __sched_setscheduler+0xb9a/0x2c80
> [ 9776.459899]        _sched_setscheduler.isra.0+0xd0/0x140
> [ 9776.459900]        do_sched_setscheduler+0x151/0x2b0
> [ 9776.459901]        __x64_sys_sched_setscheduler+0x76/0xa0
> [ 9776.459902]        do_syscall_64+0x3b/0x90
> [ 9776.459903]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [ 9776.459904] other info that might help us debug this:
> 
> [ 9776.459905] Chain exists of:
> [ 9776.459906]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
> 
> [ 9776.459911]  Possible unsafe locking scenario:
> 
> [ 9776.459913]        CPU0                    CPU1
> [ 9776.459914]        ----                    ----
> [ 9776.459914]   lock(&rq->__lock);
> [ 9776.459917] lock(&p->pi_lock);
> [ 9776.459919] lock(&rq->__lock);
> [ 9776.459921]   lock((console_sem).lock);
> 
> [ 9776.459923]  *** DEADLOCK ***
> 
> [ 9776.459925] 2 locks held by stress-ng/117708:
> [ 9776.459925]  #0: ffffffff89403960 (&cpuset_rwsem){++++}-{0:0}, at:
> __sched_setscheduler+0xe2f/0x2c80
> [ 9776.459930]  #1: ffff888e005f6d18 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x27/0x130
> 
> [ 9776.459935] stack backtrace:
> [ 9776.459936] CPU: 95 PID: 117708 Comm: stress-ng Kdump: loaded Not tainted
> 5.14.0-0.rc4.35.el9.x86_64+debug #1
> [ 9776.459938] Hardware name: FUJITSU PRIMEQUEST 2800E3/D3752, BIOS
> PRIMEQUEST 2000 Series BIOS Version 01.51 06/29/2020
> [ 9776.459939] Call Trace:
> [ 9776.459940]  <IRQ>
> [ 9776.459940]  dump_stack_lvl+0x57/0x7d
> [ 9776.459941]  check_noncircular+0x26a/0x310
> [ 9776.459942]  ? print_circular_bug+0x1f0/0x1f0
> [ 9776.459943]  ? data_push_tail.part.0+0x92/0x3e0
> [ 9776.459944]  ? alloc_chain_hlocks+0x1de/0x530
> [ 9776.459945]  check_prev_add+0x15e/0x20f0
> [ 9776.459946]  validate_chain+0xaba/0xde0
> [ 9776.459947]  ? check_prev_add+0x20f0/0x20f0
> [ 9776.459947]  ? vsnprintf+0x852/0x15f0
> [ 9776.459948]  __lock_acquire+0xb72/0x1870
> [ 9776.459949]  lock_acquire+0x1ca/0x570
> [ 9776.459950]  ? down_trylock+0x13/0x70
> [ 9776.459950]  ? rcu_read_unlock+0x40/0x40
> [ 9776.459951]  ? validate_chain+0x14c/0xde0
> [ 9776.459952]  _raw_spin_lock_irqsave+0x40/0x90
> [ 9776.459953]  ? down_trylock+0x13/0x70
> [ 9776.459954]  down_trylock+0x13/0x70
> [ 9776.459954]  ? vprintk_emit+0x1e6/0x2b0
> [ 9776.459955]  __down_trylock_console_sem+0x2a/0xb0
> [ 9776.459956]  console_trylock_spinning+0x13/0x1f0
> [ 9776.459957]  vprintk_emit+0x1e6/0x2b0
> [ 9776.459958]  printk+0xb2/0xe3
> [ 9776.459958]  ? record_print_text.cold+0x11/0x11
> [ 9776.459959]  ? lock_acquire+0x1ca/0x570
> [ 9776.459960]  __warn_printk+0x9b/0xf3
> [ 9776.459961]  ? __mmdrop.cold+0x33/0x33
> [ 9776.459961]  ? __lock_contended+0x910/0x910
> [ 9776.459962]  ? do_raw_spin_trylock+0xb5/0x180
> [ 9776.459963]  ? do_raw_spin_lock+0x270/0x270
> [ 9776.459964]  update_rq_clock+0x3c2/0x780
> [ 9776.459965]  ? raw_spin_rq_lock_nested+0x27/0x130
> [ 9776.459966]  do_sched_rt_period_timer+0x19e/0x9a0
> [ 9776.459967]  ? sched_rt_period_timer+0x60/0x150
> [ 9776.459968]  sched_rt_period_timer+0x6b/0x150
> [ 9776.459969]  __run_hrtimer+0x27a/0xb20
> [ 9776.459969]  ? do_sched_rt_period_timer+0x9a0/0x9a0
> [ 9776.459970]  __hrtimer_run_queues+0x159/0x260
> [ 9776.459971]  ? __run_hrtimer+0xb20/0xb20
> [ 9776.459972]  ? recalibrate_cpu_khz+0x10/0x10
> [ 9776.459973]  ? ktime_get_update_offsets_now+0xe0/0x2c0
> [ 9776.459974]  hrtimer_interrupt+0x2cb/0x8f0
> [ 9776.459976]  __sysvec_apic_timer_interrupt+0x13e/0x540
> [ 9776.459977]  sysvec_apic_timer_interrupt+0x6a/0x90
> [ 9776.459977]  </IRQ>
> [ 9776.459978]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [ 9776.459979] RIP: 0010:_raw_spin_unlock_irqrestore+0x3f/0x50
> [ 9776.459981] Code: 10 e8 75 82 28 fe 48 89 ef e8 ed 15 29 fe 81 e3 00 02
> 00 00 75 17 9c 58 f6 c4 02 75 17 48 85 db 74 01 fb 65 ff 0d d1 c8 54 78 <5b>
> 5d c3 e8 a9 4f 4c fe eb e2 e8 62 7b fd ff eb e2 0f 1f 44 00 00
> [ 9776.459983] RSP: 0018:ffffc90028e8fcb8 EFLAGS: 00000282
> [ 9776.459984] RAX: 0000000000000002 RBX: 0000000000000200 RCX:
> 1ffffffff15ba646
> [ 9776.459985] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffffffff87ad28b7
> [ 9776.459986] RBP: ffff888453ac8d28 R08: 0000000000000001 R09:
> ffffffff8adc9fd7
> [ 9776.459987] R10: fffffbfff15b93fa R11: 0000000000000001 R12:
> 0000000000000000
> [ 9776.459988] R13: ffff888453ac8000 R14: ffff8c8ccbdf6d00 R15:
> ffff8c8ccbdf77d0
> [ 9776.459989]  ? _raw_spin_unlock_irqrestore+0x47/0x50
> [ 9776.459990]  __sched_setscheduler+0xb9a/0x2c80
> [ 9776.459991]  ? cpu_cgroup_fork+0x180/0x180
> [ 9776.459992]  ? sched_clock_cpu+0x15/0x170
> [ 9776.459993]  ? find_held_lock+0x33/0x110
> [ 9776.459993]  _sched_setscheduler.isra.0+0xd0/0x140
> [ 9776.459994]  ? lock_downgrade+0x110/0x110
> [ 9776.459995]  ? __ia32_sys_sched_setattr+0xa0/0xa0
> [ 9776.459996]  ? do_sched_setscheduler+0x111/0x2b0
> [ 9776.459997]  do_sched_setscheduler+0x151/0x2b0
> [ 9776.459998]  ? _sched_setscheduler.isra.0+0x140/0x140
> [ 9776.459998]  ? ktime_get_coarse_real_ts64+0x128/0x160
> [ 9776.459999]  __x64_sys_sched_setscheduler+0x76/0xa0
> [ 9776.460000]  do_syscall_64+0x3b/0x90
> [ 9776.460001]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 9776.460002] RIP: 0033:0x7fe60257a27b
> [ 9776.460003] Code: 73 01 c3 48 8b 0d ad 2b 10 00 f7 d8 64 89 01 48 83 c8
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 90 00 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7d 2b 10 00 f7 d8 64 89 01 48
> [ 9776.460004] RSP: 002b:00007ffdfe38c5e8 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000090
> [ 9776.460006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007fe60257a27b
> [ 9776.460007] RDX: 00007ffdfe38c604 RSI: 0000000000000002 RDI:
> 000000000001cbcc
> [ 9776.460008] RBP: 0000000000000002 R08: 00007ffdfe38c510 R09:
> 0000000000000883
> [ 9776.460009] R10: 0000000000000000 R11: 0000000000000206 R12:
> 0000000000000002
> [ 9776.460010] R13: 0000000000000001 R14: 000000000001cbcc R15:
> 000055b909b568c6
> [ 9779.843476] sched: RT throttling activated

That can be summarized as:

	0:		1:		2:
	pi_lock		rq->lock	console_sem
	  rq->lock	  console_sem	  pi_lock

Which is *much* shorter and *much* easier to read.

> > More concerning, that ordering is invalid to begin with, so the above
> > seems like a very poor justification for this patch.
> 
> Which lock ordering are you considered invalid?

1: above. You cannot take a semaphore inside a (raw) spinlock.

> The stack trace included in the patch description show the
> (console_sem).lock --> &p->pi_lock --> &rq->__lock sequence because of the
> wake_up_process() call while holding the console_sem.lock.
> 
> The reverse &rq->__lock lock may happen when a printk() statement is called
> while holding the rq lock.
> 
> In this case, the printk() is triggered by a SCHED_WARN_ON() statement in
> update_rq_clock() which don't call printk_deferred and so won't have
> LOGLEVEL_SCHED set. I guess there is alternative way to work around this
> issue, but moving the process wakeup out from the semaphore spinlock will
> solve this problem in case there are other corner cases like that.
> 
> I will update the patch description to include this additional information.

The right solution is to burn printk_deferred at the stake and most of
printk along with it (they're working on it).

Hitting that WARN is the real problem, the rest is collateral damage and
I'm really not interested in fixing that.
