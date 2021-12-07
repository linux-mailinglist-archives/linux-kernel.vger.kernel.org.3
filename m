Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589A46AFED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhLGBol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:44:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:61467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhLGBoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:44:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224323202"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224323202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="502371270"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 17:41:07 -0800
Date:   Tue, 7 Dec 2021 09:41:06 +0800
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
Message-ID: <20211207014106.GB32145@shbuild999.sh.intel.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Nov 30, 2021 at 08:28:15AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 30, 2021 at 11:02:56PM +0800, Feng Tang wrote:
> > And similar big gap between 'tsc' and 'hpet' is seen for the server
> > case (5.5 kernel which doesn't have the cs_watchdog_read() patchset). 
> > 
> > [1196945.314929] clocksource: timekeeping watchdog on CPU67: Marking clocksource 'tsc' as unstable because the skew is too large:
> > [1196945.314935] clocksource:                       'hpet' wd_now: 25272026 wd_last: 2e9ce418 mask: ffffffff
> > [1196945.314938] clocksource:                       'tsc' cs_now: 95b400003fdf1 cs_last: 95ae7ed7c33f7 mask: ffffffffffffffff
> > [1196945.314948] tsc: Marking TSC unstable due to clocksource watchdog
> > [1196945.314977] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > [1196945.314981] sched_clock: Marking unstable (1196945264804527, 50153181)<-(1196945399926576, -84962703)
> > [1196945.316255] clocksource: Switched to clocksource hpet
> > 
> > For this case, I don't have access to the HW and only have the
> > dmesg log, from which it seems the watchdog timer has been postponed
> > a very long time from running.
> 
> Thank you for the analysis!
> 
> One approach to handle this situation would be to avoid checking for
> clock skew if the time since the last watchdog read was more than (say)
> twice the desired watchdog spacing.  This does leave open the question of
> exactly which clocksource to use to measure the time between successive
> clocksource reads.  My thought is to check this only once upon entry to
> the handler and to use the designated-good clocksource.
> 
> Does that make sense, or would something else work better?

For this case that the watchdog timer has been delayed for too long
time (170 seconds here), it may be a general problem. IIRC, there
was a similar report in LKML for a non-x86 platform. 

As for fix, I thought about scalable comparing, say if the timer
is delayed 10 seconds, and our checking interval is 500 ms, then
maybe we can lift the checking margin to 20X. But this has a problem
that the watchdog's counter could wrap, in above case, the HPET
already wrapped once (about 170+ seconds), and the wrap time 
could be much shorter for other timers (4 seconds for acpi_pm timer?).
So your idea of limiting the max delay is reasonable.

Thanks,
Feng

> 							Thanx, Paul
