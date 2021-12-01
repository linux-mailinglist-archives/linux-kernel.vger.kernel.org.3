Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A446447B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbhLABaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:30:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:24840 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhLABaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:30:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260326756"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="260326756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 17:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="500023263"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2021 17:26:56 -0800
Date:   Wed, 1 Dec 2021 09:26:55 +0800
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
Message-ID: <20211201012655.GA20240@shbuild999.sh.intel.com>
References: <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
 <87ilw9b95q.ffs@tglx>
 <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
 <87tuft9qpc.ffs@tglx>
 <20211130233726.GD641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130233726.GD641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:37:26PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 01, 2021 at 12:19:43AM +0100, Thomas Gleixner wrote:
> > On Tue, Nov 30 2021 at 14:48, Paul E. McKenney wrote:
> > > On Tue, Nov 30, 2021 at 10:55:45PM +0100, Thomas Gleixner wrote:
> > >> > OK, HPET or nothing, then.
> > >> 
> > >> Older machines also have pm_timer. But those beasts seem to have lost
> > >> that too.
> > >
> > > I suppose that one way of avoiding clock-skew messages is to have only
> > > one clock.
> > 
> > Indeed. It's a complete mystery why it takes ages to implement reliable
> > clocks in hardware.
> 
> That one is easy.  It is because the previous clocksource watchdog was
> too lenient.  ;-)
> 
> (Sorry, couldn't resist...)
> 
> > >> >> We really need to remove the watchdog requirement for modern hardware.
> > >> >> Let me stare at those patches and get them merged.
> > >> >
> > >> > You are more trusting of modern hardware than I am, but for all I know,
> > >> > maybe rightfully so.  ;-)
> > >> 
> > >> Well, I rather put a bet on the hardware, which has become reasonable
> > >> over the last decade, than on trying to solve a circular dependency
> > >> problem with tons of heuristics which won't ever work correctly.
> > >
> > > Use of HPET to check the interval length would not be circular, right?
> > 
> > As long as the HPET works reliably :)
> 
> Is it also a complete mystery why clocksources previously deemed
> reliable no longer work reliably?  ;-)

For HPET, it's a long story :) Back in 2012 or so, the HPET on Baytrail
platform has a new feature that it will stop counting in PC10 (a cpuidle
state), which prevent it to be a clocksource, and we have to disable
HPET explicitly for that platform. Since then, some new platforms also
have the same feature, and their HPET got disabled too. 

Thanks,
Feng
