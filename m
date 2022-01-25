Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50549BDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiAYVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiAYVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:52:42 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D4C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:52:42 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c15so12663484qtv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=72lp1h1NE04/5RpYbW2oG//YRFgvq4Xep4kkAwmBrdQ=;
        b=FawlhgnHfc1kqfPadpGH5/REBqIBencJQcPBRhkXvwJJxUOCLo0Plg01bzxsPOE0Xd
         80Y1UpYNVLUB/WepPRN4z1ZpbVaN5MBLeMW0AMBBdbRKC7KPu98Pn47SDkI6ukL6csWK
         wT0FGtRlbE5MaqAcxGEcvde04YshZf44/g5pd97Xz4AM28GfCIh6alwoUKavF7B63MWh
         Ejye6OLYtetYDc6UjFia+iOcDCP2j9O+yqA0NRyArq9kOKQ5G6IoPGkH3VuxG0s1KQRr
         lv6KZfGrk1Bq4+4MdUhnLrCNTgOcrrahD3bV2khpswOH+n6kZbAXugIVuunJW8BSVhE/
         vTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=72lp1h1NE04/5RpYbW2oG//YRFgvq4Xep4kkAwmBrdQ=;
        b=gynzqMXY4pqJpSn8GIybgQMvWcGS3YrSuikdRKwYsyIFEzGMrSwzQsW0pkv/fjWx3X
         kvybmfthHCdKlMRfFw+b1Wg3AJQcZF/LbULtgsAuRZLRkeJWZhve8sW7/IDSfrT7jJml
         8EFn3nPXn8cWmAl9A/amphp0mXsxNBOQS2Si/angmsjliXKITGO+qqrrzoYq4EWdgXYV
         QP7fHewqJQuDn1fEHh7YuYc+vScJ7dwPB6nWsfGOko83ah1jjnVoL/LIhb1PXR95s5Wl
         kVR2cOyxqI7ukun1ODn5ojjspruhVvRrRafU7GKjpIUukJxaoTLdgzTNlURSJWgEr5Vp
         i1gg==
X-Gm-Message-State: AOAM531GBH6cjwjut2nxfEQtqnkI+XS4AMNYdnGsQFAOnJpMLrc5a/g+
        +16HjHGJQcQeHmfp8XthcZJhkA3Fvw==
X-Google-Smtp-Source: ABdhPJxUJU+Zmg/JlqRDmbOyk/1I+Em/5rVi9Wn2gF3hJWrUKIsxV1DTz83qIUMwgGXWkh+ggPK5uw==
X-Received: by 2002:a05:622a:1394:: with SMTP id o20mr4781433qtk.364.1643147561341;
        Tue, 25 Jan 2022 13:52:41 -0800 (PST)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id f8sm9575695qtf.81.2022.01.25.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:52:40 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:119b:19f9:7c76:518a])
        by serve.minyard.net (Postfix) with ESMTPSA id BC7811800BB;
        Tue, 25 Jan 2022 21:52:39 +0000 (UTC)
Date:   Tue, 25 Jan 2022 15:52:38 -0600
From:   Corey Minyard <minyard@acm.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible reproduction of CSD locking issue
Message-ID: <20220125215238.GP34919@minyard.net>
Reply-To: minyard@acm.org
References: <20220125182737.GO34919@minyard.net>
 <20220125185338.GP4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125185338.GP4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:53:38AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 25, 2022 at 12:27:37PM -0600, Corey Minyard wrote:
> > We have a customer that had been seeing CSD lock issues on a Centos 7
> > kernel (unfortunately).  I couldn't find anything or any kernel changes
> > that might fix it, so I was consdering it was the CSD locking issue you
> > have been chasing for a while.
> > 
> > So I backported the debug patches.  And of course, they stopped seeing
> > the issue, at least as much, and they had trouble with the extra CPU
> > time the debug code took.  But they just reproduced it.  Here are the
> > logs:
> > 
> > Jan 23 23:39:43 worker0 kernel: [285737.522743] csd: Detected non-responsive CSD lock (#1) on CPU#3, waiting 5000000042 ns for CPU#55 flush_tlb_func+0x0/0xb0(0xffff8e0b3e2afbe8).
> > Jan 23 23:39:43 worker0 kernel: [285737.522744]  csd: CSD lock (#1) unresponsive.
> > Jan 23 23:39:43 worker0 kernel: [285737.522747]  csd: cnt(0000000): 0000->0000 queue
> > Jan 23 23:39:43 worker0 kernel: [285737.522748]  csd: cnt(0000001): ffff->0037 idle
> > Jan 23 23:39:43 worker0 kernel: [285737.522749]  csd: cnt(63d8dd8): 0003->0037 ipi
> > Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dd9): 0003->0037 ping
> > Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dda): 0003->ffff pinged
> > Jan 23 23:39:43 worker0 kernel: [285737.522751]  csd: cnt(63d8dea): 0035->0037 pinged
> > Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8deb): ffff->0037 gotipi
> > Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8dec): ffff->0037 handle
> > Jan 23 23:39:43 worker0 kernel: [285737.522753]  csd: cnt(63d8ded): ffff->0037 dequeue (src CPU 0 == empty)
> > Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8dee): ffff->0037 hdlend (src CPU 0 == early)
> > Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8e1f): 0003->0037 queue
> > Jan 23 23:39:43 worker0 kernel: [285737.522755]  csd: cnt(63d8e20): 0003->0037 ipi
> > Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e21): 0003->0037 ping
> > Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e22): 0003->0037 queue
> > Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt(63d8e23): 0003->0037 noipi
> > Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt now: 63fe4cd
> > Jan 23 23:39:43 worker0 kernel: [285737.522758] Task dump for CPU 55:
> > Jan 23 23:39:43 worker0 kernel: [285737.522761] kubelet         R  running task        0 277695      1 0x00080000
> > Jan 23 23:39:43 worker0 kernel: [285737.522761] Call Trace:
> > Jan 23 23:39:43 worker0 kernel: [285737.522769]  [<ffffffff84376b6a>] ? __schedule+0x46a/0x990
> > Jan 23 23:39:43 worker0 kernel: [285737.522774]  [<ffffffff83db6353>] ? context_tracking_user_enter+0x13/0x20
> > Jan 23 23:39:43 worker0 kernel: [285737.522776]  [<ffffffff843775b5>] ? schedule_user+0x45/0x50
> > Jan 23 23:39:43 worker0 kernel: [285737.522779]  [<ffffffff8437b518>] ? retint_careful+0x16/0x34
> 
> Long-running interrupt handler, maybe?  Or am I misinterpreting this
> stack trace?

Well, maybe.  But why would the condition clear up immediately when
another IPI is sent?  If I understand correctly this box is doing mostly
polled I/O, there shouldn't be many interrupts.  But possibly a driver
bug, I hadn't thought of that.

I could have the system panic when this happens and maybe I can find
some breadcrumbs lying around in the core dump.  The trouble is it's
been two months now to reproduce this.

> 
> > Jan 23 23:39:43 worker0 kernel: [285737.522780] csd: Re-sending CSD lock (#1) IPI from CPU#03 to CPU#55
> > Jan 23 23:39:43 worker0 kernel: [285737.522788] CPU: 3 PID: 54671 Comm: runc:[2:INIT] Kdump: loaded Tainted: G           OE  ------------ T 3.10.0-1062.12.1.rt56.1042.mvista.test.14.el7.x86_64 #1
> > Jan 23 23:39:43 worker0 kernel: [285737.522789] Hardware name: Dell Inc. PowerEdge R740/0YWR7D, BIOS 2.9.4 11/06/2020
> > Jan 23 23:39:43 worker0 kernel: [285737.522789] Call Trace:
> > Jan 23 23:39:43 worker0 kernel: [285737.522793]  [<ffffffff843718ba>] dump_stack+0x19/0x1b
> > Jan 23 23:39:43 worker0 kernel: [285737.522798]  [<ffffffff83d0bcd8>] __csd_lock_wait+0x1a8/0x2a0
> > Jan 23 23:39:43 worker0 kernel: [285737.522800]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > Jan 23 23:39:43 worker0 kernel: [285737.522802]  [<ffffffff83d0bfa4>] smp_call_function_single+0xc4/0x1b0
> > Jan 23 23:39:43 worker0 kernel: [285737.522804]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > Jan 23 23:39:43 worker0 kernel: [285737.522809]  [<ffffffff83e2684b>] ? page_counter_uncharge+0x3b/0x70
> > Jan 23 23:39:43 worker0 kernel: [285737.522811]  [<ffffffff83d0c614>] smp_call_function_many+0x344/0x380
> > Jan 23 23:39:43 worker0 kernel: [285737.522813]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > Jan 23 23:39:43 worker0 kernel: [285737.522816]  [<ffffffff83c6da38>] native_flush_tlb_others+0xb8/0xc0
> > Jan 23 23:39:43 worker0 kernel: [285737.522818]  [<ffffffff83c6dc25>] flush_tlb_page+0x65/0xf0
> > Jan 23 23:39:43 worker0 kernel: [285737.522821]  [<ffffffff83dfdf98>] ptep_clear_flush+0x68/0xa0
> > Jan 23 23:39:43 worker0 kernel: [285737.522825]  [<ffffffff83de6806>] wp_page_copy.isra.83+0x3d6/0x650
> > Jan 23 23:39:43 worker0 kernel: [285737.522828]  [<ffffffff83de8cb4>] do_wp_page+0xb4/0x710
> > Jan 23 23:39:43 worker0 kernel: [285737.522832]  [<ffffffff83decbb4>] handle_mm_fault+0x884/0x1340
> > Jan 23 23:39:43 worker0 kernel: [285737.522835]  [<ffffffff83cd7799>] ? update_cfs_shares+0xa9/0xf0
> > Jan 23 23:39:43 worker0 kernel: [285737.522839]  [<ffffffff8437efc3>] __do_page_fault+0x213/0x5a0
> > Jan 23 23:39:43 worker0 kernel: [285737.522841]  [<ffffffff8437f385>] do_page_fault+0x35/0x90
> > Jan 23 23:39:43 worker0 kernel: [285737.522842]  [<ffffffff8437b728>] page_fault+0x28/0x30
> > Jan 23 23:39:43 worker0 kernel: [285737.522845] csd: CSD lock (#1) got unstuck on CPU#03, CPU#55 released the lock.
> > 
> > Hopefully this is the issue you are chasing and not something else.
> > I've been studying them to see what they mean, but I thought you might
> > be interested to get them asap.
> 
> Well, there have been several bugs causing these CSD lock issues, so what
> is one more?  ;-)
> 
> More seriously, have you tried Frederic's patch?  This fixes the issue
> described here:  https://paulmck.livejournal.com/62071.html
> If your stack above was due to an interrupt storm rather than a
> long-running interrupt, this might well be the fix.

The code is so different that it will take me some time.  I'll have to
understand the issue more deeply to trace that down.  But thanks for the
reference.

> 
> Oh, and Jürgen Groß reportedly found an issue about a year ago that
> could potentially be related, but I see that he is already on CC.
> 
> And, unfortunately, even more seriously, this CSD-lock diagnostic code
> will very likely continue to find problems, just as the infamous RCU
> CPU stall warnings and hard/soft lockup warnings do.

Yeah, I've already fixed a couple of bugs related to CSD lockups.  So I
suppose I've handled all the low-hanging fruit.  With a 104 core box it
makes uncovering these sorts of issues more likely, I suppose.

-corey

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 53e87e3cdc155f20c3417b689df8d2ac88d79576
> Author: Frederic Weisbecker <frederic@kernel.org>
> Date:   Tue Oct 26 16:10:54 2021 +0200
> 
>     timers/nohz: Last resort update jiffies on nohz_full IRQ entry
>     
>     When at least one CPU runs in nohz_full mode, a dedicated timekeeper CPU
>     is guaranteed to stay online and to never stop its tick.
>     
>     Meanwhile on some rare case, the dedicated timekeeper may be running
>     with interrupts disabled for a while, such as in stop_machine.
>     
>     If jiffies stop being updated, a nohz_full CPU may end up endlessly
>     programming the next tick in the past, taking the last jiffies update
>     monotonic timestamp as a stale base, resulting in an tick storm.
>     
>     Here is a scenario where it matters:
>     
>     0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.
>     
>     1) A stop machine callback is queued to execute somewhere.
>     
>     2) CPU 0 reaches MULTI_STOP_DISABLE_IRQ while CPU 1 is still in
>        MULTI_STOP_PREPARE. Hence CPU 0 can't do its timekeeping duty. CPU 1
>        can still take IRQs.
>     
>     3) CPU 1 receives an IRQ which queues a timer callback one jiffy forward.
>     
>     4) On IRQ exit, CPU 1 schedules the tick one jiffy forward, taking
>        last_jiffies_update as a base. But last_jiffies_update hasn't been
>        updated for 2 jiffies since the timekeeper has interrupts disabled.
>     
>     5) clockevents_program_event(), which relies on ktime_get(), observes
>        that the expiration is in the past and therefore programs the min
>        delta event on the clock.
>     
>     6) The tick fires immediately, goto 3)
>     
>     7) Tick storm, the nohz_full CPU is drown and takes ages to reach
>        MULTI_STOP_DISABLE_IRQ, which is the only way out of this situation.
>     
>     Solve this with unconditionally updating jiffies if the value is stale
>     on nohz_full IRQ entry. IRQs and other disturbances are expected to be
>     rare enough on nohz_full for the unconditional call to ktime_get() to
>     actually matter.
>     
>     Reported-by: Paul E. McKenney <paulmck@kernel.org>
>     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Tested-by: Paul E. McKenney <paulmck@kernel.org>
>     Link: https://lore.kernel.org/r/20211026141055.57358-2-frederic@kernel.org
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 322b65d456767..41f470929e991 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -595,7 +595,8 @@ void irq_enter_rcu(void)
>  {
>  	__irq_enter_raw();
>  
> -	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
> +	if (tick_nohz_full_cpu(smp_processor_id()) ||
> +	    (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET)))
>  		tick_irq_enter();
>  
>  	account_hardirq_enter(current);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 6bffe5af8cb11..17a283ce2b20f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1375,6 +1375,13 @@ static inline void tick_nohz_irq_enter(void)
>  	now = ktime_get();
>  	if (ts->idle_active)
>  		tick_nohz_stop_idle(ts, now);
> +	/*
> +	 * If all CPUs are idle. We may need to update a stale jiffies value.
> +	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
> +	 * alive but it might be busy looping with interrupts disabled in some
> +	 * rare case (typically stop machine). So we must make sure we have a
> +	 * last resort.
> +	 */
>  	if (ts->tick_stopped)
>  		tick_nohz_update_jiffies(now);
>  }
