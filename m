Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6F4639A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhK3PSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:18:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:52124 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244054AbhK3PPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:15:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223111392"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223111392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="595454520"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2021 07:02:57 -0800
Date:   Tue, 30 Nov 2021 23:02:56 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified
 platforms
Message-ID: <20211130150256.GA19477@shbuild999.sh.intel.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the review!

On Tue, Nov 30, 2021 at 06:40:48AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 30, 2021 at 02:46:23PM +0800, Feng Tang wrote:
> > On Wed, Nov 17, 2021 at 10:37:51AM +0800, Feng Tang wrote:
> > > There are cases that tsc clocksources are wrongly judged as unstable by
> > > clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> > > there is hardly a general reliable way to check the validity of a
> > > watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
> > 
> > Hi All,
> > 
> > Some more update, last week we got report from validation team that
> > the "tsc judged as unstable" happened on latest desktop platform,
> > which has serial earlyprintk enabled, and the watchdog here is
> > 'refined-jiffies' while hpet is disabled during the PC10 check. I
> > tried severy other client platforms I can find: Kabylake, Icelake
> > and Alderlake, and the mis-judging can be easily reproduced on
> > Icelake and Alderlake (not on Kabylake). Which could be cued by
> > this 2/2 patch.
> > 
> > Also, today we got same report on a 2-sockets Icelake Server with
> > 5.5 kernel, while the watchdog is 'hpet', and the system is running
> > stressful big-data workload.
> 
> Were these tests run with Waiman's latest patch series?  The first
> two of them are on RCU's "dev" branch.
 
No, I haven't tried Waiman's patches, which are more about refining
cs_watchdog_read() check, while these 2 cases are about the really
big gap between watchog and cur_clocksource

The error log of first client platform (5.15 kernel) is: 

[    2.994266] clocksource:                       'refined-jiffies' wd_nsec: 516032250 wd_now: fffedc09 wd_last: fffedb88 mask: ffffffff
[    2.998352] initcall irq_sysfs_init+0x0/0x97 returned 0 after 0 usecs
[    3.002266] clocksource:                       'tsc-early' cs_nsec: 767553349 cs_now: 71a87fd2f cs_last: 6db4968ff mask: ffffffffffffffff
[    3.006266] calling  dma_atomic_pool_init+0x0/0x152 @ 1
[    3.010266] clocksource:                       No current clocksource.
[    3.010267] tsc: Marking TSC unstable due to clocksource watchdog

We can see the gap is 516 ms vs 767 ms, and the delta is 267 ms. 
And the root cause is with earlyprintk serial console enabled,
the periodic timer interrupt is severely affected to be not
accurate.

And similar big gap between 'tsc' and 'hpet' is seen for the server
case (5.5 kernel which doesn't have the cs_watchdog_read() patchset). 

[1196945.314929] clocksource: timekeeping watchdog on CPU67: Marking clocksource 'tsc' as unstable because the skew is too large:
[1196945.314935] clocksource:                       'hpet' wd_now: 25272026 wd_last: 2e9ce418 mask: ffffffff
[1196945.314938] clocksource:                       'tsc' cs_now: 95b400003fdf1 cs_last: 95ae7ed7c33f7 mask: ffffffffffffffff
[1196945.314948] tsc: Marking TSC unstable due to clocksource watchdog
[1196945.314977] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[1196945.314981] sched_clock: Marking unstable (1196945264804527, 50153181)<-(1196945399926576, -84962703)
[1196945.316255] clocksource: Switched to clocksource hpet

For this case, I don't have access to the HW and only have the
dmesg log, from which it seems the watchdog timer has been postponed
a very long time from running.


Thanks,
Feng


> 							Thanx, Paul
> 
> > Thanks,
> > Feng
> > 
> > 
> > > "I'm inclined to lift that requirement when the CPU has:
> > > 
> > >     1) X86_FEATURE_CONSTANT_TSC
> > >     2) X86_FEATURE_NONSTOP_TSC
> > >     3) X86_FEATURE_NONSTOP_TSC_S3
> > >     4) X86_FEATURE_TSC_ADJUST
> > >     5) At max. 4 sockets
> > > 
> > >  After two decades of horrors we're finally at a point where TSC seems
> > >  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
> > >  was really key as we can now detect even small modifications reliably
> > >  and the important point is that we can cure them as well (not pretty
> > >  but better than all other options)."
> > > 
> > > As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
> > > of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
> > > and X86_FEATURE_NONSTOP_TSC, skip checking it, and also be more defensive
> > > to use maxim of 2 sockets.
> > > 
> > > The check is done inside tsc_init() before registering 'tsc-early' and
> > > 'tsc' clocksources, as there were cases that both of them had been
> > > wrongly judged as unreliable.
> > > 
> > > For more background of tsc/watchdog, there is a good summary in [2]
> > > 
> > > [1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
> > > [2]. https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > ---
> > > Change log:
> > > 
> > >   v3:
> > >     * rebased against 5.16-rc1
> > >     * refine commit log
> > > 
> > >   v2:
> > >     * Directly skip watchdog check without messing flag
> > >       'tsc_clocksource_reliable' (Thomas)
> > > 
> > >  arch/x86/kernel/tsc.c | 22 ++++++++++++++++++----
> > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 2e076a459a0c..389511f59101 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -1180,6 +1180,12 @@ void mark_tsc_unstable(char *reason)
> > >  
> > >  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> > >  
> > > +static void __init tsc_skip_watchdog_verify(void)
> > > +{
> > > +	clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > > +	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > > +}
> > > +
> > >  static void __init check_system_tsc_reliable(void)
> > >  {
> > >  #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
> > > @@ -1196,6 +1202,17 @@ static void __init check_system_tsc_reliable(void)
> > >  #endif
> > >  	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
> > >  		tsc_clocksource_reliable = 1;
> > > +
> > > +	/*
> > > +	 * Ideally the socket number should be checked, but this is called
> > > +	 * by tsc_init() which is in early boot phase and the socket numbers
> > > +	 * may not be available. Use 'nr_online_nodes' as a fallback solution
> > > +	 */
> > > +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > > +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > > +	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > > +	    nr_online_nodes <= 2)
> > > +		tsc_skip_watchdog_verify();
> > >  }
> > >  
> > >  /*
> > > @@ -1387,9 +1404,6 @@ static int __init init_tsc_clocksource(void)
> > >  	if (tsc_unstable)
> > >  		goto unreg;
> > >  
> > > -	if (tsc_clocksource_reliable || no_tsc_watchdog)
> > > -		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > > -
> > >  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
> > >  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> > >  
> > > @@ -1527,7 +1541,7 @@ void __init tsc_init(void)
> > >  	}
> > >  
> > >  	if (tsc_clocksource_reliable || no_tsc_watchdog)
> > > -		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> > > +		tsc_skip_watchdog_verify();
> > >  
> > >  	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
> > >  	detect_art();
> > > -- 
> > > 2.27.0
