Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35344636ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhK3OoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhK3OoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:44:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE09DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15F96CE1A11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CCBC53FC1;
        Tue, 30 Nov 2021 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283248;
        bh=IF2uQZi+FT/8JXuHuTPExXJoa7XlXUahozo1xiBrO3E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cb57NJk/TaTW8IXyAhDW2niCgDR5SYnip8qjHndU+pLdKYHSJulU3kbZclyZ3cDt1
         5erkfYP5YBZXElSdFMsbNvFg88t6y3eDmRpzb+oSl92RD0cZep6Y6qqQf+I1wVl3hF
         8p/b5eM08M25pzx9WxCraL+soBi3cecorHe5T2zRdXXfUYeXX2wV8MCOEKKdjbemsP
         Onxkqn4H2bneBWnGgEu3v0JobA85fEGzRwQ4MCqZjDkOtocXqSGsAZgA0613N8mJV2
         GecwOtGZ9c3o8t3IkswjitiL28YDeW6a6D/AWvYug9QP907M1KReAdV40JJ+41xwu+
         NSE9gkuW9hFHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 144C95C00AC; Tue, 30 Nov 2021 06:40:48 -0800 (PST)
Date:   Tue, 30 Nov 2021 06:40:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified
 platforms
Message-ID: <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130064623.GB96474@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 02:46:23PM +0800, Feng Tang wrote:
> On Wed, Nov 17, 2021 at 10:37:51AM +0800, Feng Tang wrote:
> > There are cases that tsc clocksources are wrongly judged as unstable by
> > clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> > there is hardly a general reliable way to check the validity of a
> > watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
> 
> Hi All,
> 
> Some more update, last week we got report from validation team that
> the "tsc judged as unstable" happened on latest desktop platform,
> which has serial earlyprintk enabled, and the watchdog here is
> 'refined-jiffies' while hpet is disabled during the PC10 check. I
> tried severy other client platforms I can find: Kabylake, Icelake
> and Alderlake, and the mis-judging can be easily reproduced on
> Icelake and Alderlake (not on Kabylake). Which could be cued by
> this 2/2 patch.
> 
> Also, today we got same report on a 2-sockets Icelake Server with
> 5.5 kernel, while the watchdog is 'hpet', and the system is running
> stressful big-data workload.

Were these tests run with Waiman's latest patch series?  The first
two of them are on RCU's "dev" branch.

							Thanx, Paul

> Thanks,
> Feng
> 
> 
> > "I'm inclined to lift that requirement when the CPU has:
> > 
> >     1) X86_FEATURE_CONSTANT_TSC
> >     2) X86_FEATURE_NONSTOP_TSC
> >     3) X86_FEATURE_NONSTOP_TSC_S3
> >     4) X86_FEATURE_TSC_ADJUST
> >     5) At max. 4 sockets
> > 
> >  After two decades of horrors we're finally at a point where TSC seems
> >  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
> >  was really key as we can now detect even small modifications reliably
> >  and the important point is that we can cure them as well (not pretty
> >  but better than all other options)."
> > 
> > As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
> > of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
> > and X86_FEATURE_NONSTOP_TSC, skip checking it, and also be more defensive
> > to use maxim of 2 sockets.
> > 
> > The check is done inside tsc_init() before registering 'tsc-early' and
> > 'tsc' clocksources, as there were cases that both of them had been
> > wrongly judged as unreliable.
> > 
> > For more background of tsc/watchdog, there is a good summary in [2]
> > 
> > [1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
> > [2]. https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> > Change log:
> > 
> >   v3:
> >     * rebased against 5.16-rc1
> >     * refine commit log
> > 
> >   v2:
> >     * Directly skip watchdog check without messing flag
> >       'tsc_clocksource_reliable' (Thomas)
> > 
> >  arch/x86/kernel/tsc.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 2e076a459a0c..389511f59101 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1180,6 +1180,12 @@ void mark_tsc_unstable(char *reason)
> >  
> >  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> >  
> > +static void __init tsc_skip_watchdog_verify(void)
> > +{
> > +	clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > +	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > +}
> > +
> >  static void __init check_system_tsc_reliable(void)
> >  {
> >  #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
> > @@ -1196,6 +1202,17 @@ static void __init check_system_tsc_reliable(void)
> >  #endif
> >  	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
> >  		tsc_clocksource_reliable = 1;
> > +
> > +	/*
> > +	 * Ideally the socket number should be checked, but this is called
> > +	 * by tsc_init() which is in early boot phase and the socket numbers
> > +	 * may not be available. Use 'nr_online_nodes' as a fallback solution
> > +	 */
> > +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > +	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > +	    nr_online_nodes <= 2)
> > +		tsc_skip_watchdog_verify();
> >  }
> >  
> >  /*
> > @@ -1387,9 +1404,6 @@ static int __init init_tsc_clocksource(void)
> >  	if (tsc_unstable)
> >  		goto unreg;
> >  
> > -	if (tsc_clocksource_reliable || no_tsc_watchdog)
> > -		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > -
> >  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
> >  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> >  
> > @@ -1527,7 +1541,7 @@ void __init tsc_init(void)
> >  	}
> >  
> >  	if (tsc_clocksource_reliable || no_tsc_watchdog)
> > -		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > +		tsc_skip_watchdog_verify();
> >  
> >  	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
> >  	detect_art();
> > -- 
> > 2.27.0
