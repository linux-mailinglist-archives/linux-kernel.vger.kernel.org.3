Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D29581D65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiG0CED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiG0CEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:04:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A03C140
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:03:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so14663646pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yd/l1Y2v+nNxV0KyGFNfQlfxUt2Z9k1HtIC4DEOBQIU=;
        b=yf93Bqh4B7NAb5zzYjgyRtPl5sG47SRE+ksECQ5hxpl8IOazvvey1c0bfIuyUoPpjz
         Lt9XU76+4iqUu0sDqEZUbnccnCEdaOYUUqCpsDBHaagc+yJL0WTlSaJnwDoEfb8rW/D+
         IZExgYmmpTc8iwpYcu9lujNolDDLwlfqfdoMcfBxxbSy5cjMsF5RA92Db8qyhXxik/6I
         uUuNIgWXiQ6p0sVKMEeB3GaSs+D9JoNK/iULHq6yCIPfdCrk4geRD+W8gw88AVSeBGmX
         kENgXRKBaUiqZrgOiyuA8TClKTCKB/B/9xqrqB7hK3FfZI6P7nGn/P9bJuzM6gPVXAgZ
         h1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yd/l1Y2v+nNxV0KyGFNfQlfxUt2Z9k1HtIC4DEOBQIU=;
        b=zhaJzhzU3Pa0WGxPv7hXOhaP222ZM0WNMfQAhaJT5Lz9rWJurhcDMP9BIsScDxjxd8
         aW0XyFGD1Dmi7eF2rbW5BNga19PdX77LeVvrZJNi2hWUVBIXepZzUs97p13JgGWkawek
         V8ZyTjEKpjpcoi5ys327NdT0TmI0zrvkKuMk5VEZa+kZi8VE3JlwiHqAcJsz7keSsucl
         vyzwCw4U4XrXjWdG2qTE1umI1pt8cC2AQn7mmSu5vkiOecE5GwOncZYklBFhUsR3z1bO
         u8ScdtK1XsbB8ew+46ewUs1qovTxGX8det0xoSU+965qm48GGlWJ/nnHSZUbhqDbbxjl
         nyvw==
X-Gm-Message-State: AJIora8cdrwhChFxgOMkvraqHSFE0iucxOltk/Y201FzEayUgXkgwueT
        pD1hrzOo+2jAobcc2ym/crM20g==
X-Google-Smtp-Source: AGRyM1tDkPTK1dhSVBWeIzbIo15BGWiupCCg42sIRLr/tTeciL8rBbq/r2ksgg2jhug6UlZ7PcO3QQ==
X-Received: by 2002:aa7:84c1:0:b0:52a:e11a:f5e9 with SMTP id x1-20020aa784c1000000b0052ae11af5e9mr19626590pfn.55.1658887439049;
        Tue, 26 Jul 2022 19:03:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o63-20020a625a42000000b0052ba70ea97esm12330831pfb.30.2022.07.26.19.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 19:03:58 -0700 (PDT)
Date:   Wed, 27 Jul 2022 10:03:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [-next] Lockdep warnings
Message-ID: <20220727020354.GE36862@leoy-ThinkPad-X240s>
References: <20220726104134.3b3awfphvafljdgp@bogus>
 <Yt/gyEMOtGafQX4z@FVFF77S0Q05N>
 <Yt/i/o3Sb+niH2e+@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/i/o3Sb+niH2e+@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:50:06PM +0100, Mark Rutland wrote:
> On Tue, Jul 26, 2022 at 01:40:40PM +0100, Mark Rutland wrote:
> > [Adding Peter; I suspect this is due to the cpuidle rework]
> 
> Looking again I see the cpuidle rework isn't in next, so evidently not...
> 
> Sorry for the noise!

I'd like to loop in Mike.L and CoreSight ML for CTI PM callbacks.
Please see below a comment for CTI spinlock usage.

> > I'll go give next a spin in a VM, but I suspect I might need real HW to see
> > this due to the way PSCI idle states work.
> > 
> > Mark.
> > 
> > On Tue, Jul 26, 2022 at 11:41:34AM +0100, Sudeep Holla wrote:
> > > I was seeing the below lockdep warnings on my arm64 Juno development
> > > platform almost 2 weeks back with -next. I wanted to check for similar
> > > reports before post and forgot.
> > > 
> > > --->8
> > > 
> > > DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> > >  hardirqs last  enabled at (46157): cpuidle_enter_state+0x174/0x2b4
> > >  WARNING: CPU: 5 PID: 0 at kernel/locking/lockdep.c:5506 check_flags+0x90/0x1e8
> > >  hardirqs last disabled at (46158): el1_interrupt+0x2c/0xc8
> > >  Modules linked in:
> > >  softirqs last  enabled at (46154): __do_softirq+0x2c0/0x388
> > >  softirqs last disabled at (46139): __irq_exit_rcu+0x118/0x18c
> > >  CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.19.0-rc6-next-20220714 #9
> > >  pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > >  pc : check_flags+0x90/0x1e8
> > >  lr : check_flags+0x90/0x1e8
> > >  Call trace:
> > >   check_flags+0x90/0x1e8
> > >   lock_is_held_type+0x80/0x164
> > >   rcu_read_lock_sched_held+0x40/0x7c
> > >   trace_rcu_dyntick+0x5c/0x140
> > >   ct_kernel_enter+0x78/0xd4
> > >   ct_idle_exit+0x1c/0x44
> > >   cpu_idle_poll+0x74/0xb8
> > >   do_idle+0x90/0x2c4
> > >   cpu_startup_entry+0x30/0x34
> > >   secondary_start_kernel+0x130/0x144
> > >   __secondary_switched+0xb0/0xb4
> > >  irq event stamp: 64229
> > >  hardirqs last  enabled at (64229): cpu_idle_poll+0x40/0xb8
> > >  hardirqs last disabled at (64228): do_idle+0xbc/0x2c4
> > >  softirqs last  enabled at (64190): __do_softirq+0x2c0/0x388
> > >  softirqs last disabled at (64185): __irq_exit_rcu+0x118/0x18c
> > >  ---[ end trace 0000000000000000 ]---
> > >  possible reason: unannotated irqs-off.
> > >  irq event stamp: 64229
> > >  hardirqs last  enabled at (64229): cpu_idle_poll+0x40/0xb8
> > >  hardirqs last disabled at (64228): do_idle+0xbc/0x2c4
> > >  softirqs last  enabled at (64190): __do_softirq+0x2c0/0x388
> > >  softirqs last disabled at (64185): __irq_exit_rcu+0x118/0x18c
> > > 
> > > ----
> > > 
> > > However I don't see the above warning with the latest -next. When I tried
> > > yesterday's -next now, I see a different warning. Not sure if they are
> > > related. I haven't tried to bisect.
> > > 
> > > --->8
> > > =============================
> > > [ BUG: Invalid wait context ]
> > > 5.19.0-rc8-next-20220725 #38 Not tainted
> > > -----------------------------
> > > swapper/0/0 is trying to lock:
> > > (&drvdata->spinlock){....}-{3:3}, at: cti_cpu_pm_notify+0x54/0x114
> > > other info that might help us debug this:
> > > context-{5:5}
> > > 1 lock held by swapper/0/0:
> > >  #0: (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x2c/0x80
> > > stack backtrace:
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-next-20220725-00004-g599e6691ed8c #38
> > > Call trace:
> > >  dump_backtrace+0xe8/0x108
> > >  show_stack+0x18/0x4c
> > >  dump_stack_lvl+0x90/0xc8
> > >  dump_stack+0x18/0x54
> > >  __lock_acquire+0xa70/0x32d0
> > >  lock_acquire+0x160/0x308
> > >  _raw_spin_lock+0x60/0xa0
> > >  cti_cpu_pm_notify+0x54/0x114
> > >  raw_notifier_call_chain_robust+0x50/0xd4
> > >  cpu_pm_enter+0x48/0x80
> > >  psci_enter_idle_state+0x34/0x74
> > >  cpuidle_enter_state+0x120/0x2a8
> > >  cpuidle_enter+0x38/0x50
> > >  do_idle+0x1e8/0x2b8
> > >  cpu_startup_entry+0x24/0x28
> > >  kernel_init+0x0/0x1a0
> > >  start_kernel+0x0/0x470
> > >  start_kernel+0x34c/0x470
> > >  __primary_switched+0xbc/0xc4

If we look into for this callback, we can see the lock sequence is:

  cti_cpu_pm_notify()
    `> cpu_pm_notify_robust():
         `> raw_spin_lock_irqsave(cpu_pm_notifier.lock, flag) -> a raw spinlock
         `> cti_cpu_pm_notify()
              `> spin_lock(&drvdata->spinlock) -> a normal spinlock

A raw spinlock is not a sleepable lock, and normal spinlock can be a
sleepable lock (e.g. it can be a mutex after enabled PREEMPT_RT).

One solution is we can change to a raw spinlock in CTI driver, so this
can dismiss the lockdep warning.

Actually, I am a bit suspect if it's really necessary to use spinlock in
CTI PM callbacks, the reason is in CPU's idle flow, it will run into
idle thread context and disable the local IRQ, which means it likely has
no race condition with thread context and interrupt handler, so we can
remove the locking in PM callbacks.

Mike, could you check for this?  Thanks!

Leo
