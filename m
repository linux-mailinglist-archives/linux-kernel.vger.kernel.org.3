Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26746544A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351787AbhLAR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhLAR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:56:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E0FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B836CE2021
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A75C53FCC;
        Wed,  1 Dec 2021 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381173;
        bh=jNxvjxMIuskzFMYi8OzajdDm/hsNb3YSqkmXmlvTq2M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sNnpgYK4DCVEE1KJ9EJBj1lUOTGBR9XUCP4KIoBXo7v7DU/HZWwGXfJomqIiqjJLB
         moaiDpNKh55gB7XLScl2orIpdtwhiOmYQvPPgcilfAQTooxcvoHKGVcBzXsSHvXSqz
         o+3kUy1uftKeVXbKrE9MDtEFAsCmA1I4vUUFDPpt+KtW89EgvnrVcTh+ko9W6Bs6GK
         CwZtIwBQvKa0fZt67XseOp2w5Eysj6YpplbzwLtYo+MaF39eqaborRzFnaUA7KvWKr
         xMXFXSEnBX6wgZSbrNhNJVAbfTEmDVUtCRSsqLdRecjV+fPfM9MXwK9dn/zq1a2tW3
         SHF1VXBtt6eTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 050335C0FCC; Wed,  1 Dec 2021 09:52:53 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:52:52 -0800
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
Message-ID: <20211201175252.GK641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
 <87ilw9b95q.ffs@tglx>
 <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
 <87tuft9qpc.ffs@tglx>
 <20211130233726.GD641268@paulmck-ThinkPad-P17-Gen-1>
 <20211201012655.GA20240@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201012655.GA20240@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:26:55AM +0800, Feng Tang wrote:
> On Tue, Nov 30, 2021 at 03:37:26PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 01, 2021 at 12:19:43AM +0100, Thomas Gleixner wrote:
> > > On Tue, Nov 30 2021 at 14:48, Paul E. McKenney wrote:
> > > > On Tue, Nov 30, 2021 at 10:55:45PM +0100, Thomas Gleixner wrote:
> > > >> > OK, HPET or nothing, then.
> > > >> 
> > > >> Older machines also have pm_timer. But those beasts seem to have lost
> > > >> that too.
> > > >
> > > > I suppose that one way of avoiding clock-skew messages is to have only
> > > > one clock.
> > > 
> > > Indeed. It's a complete mystery why it takes ages to implement reliable
> > > clocks in hardware.
> > 
> > That one is easy.  It is because the previous clocksource watchdog was
> > too lenient.  ;-)
> > 
> > (Sorry, couldn't resist...)
> > 
> > > >> >> We really need to remove the watchdog requirement for modern hardware.
> > > >> >> Let me stare at those patches and get them merged.
> > > >> >
> > > >> > You are more trusting of modern hardware than I am, but for all I know,
> > > >> > maybe rightfully so.  ;-)
> > > >> 
> > > >> Well, I rather put a bet on the hardware, which has become reasonable
> > > >> over the last decade, than on trying to solve a circular dependency
> > > >> problem with tons of heuristics which won't ever work correctly.
> > > >
> > > > Use of HPET to check the interval length would not be circular, right?
> > > 
> > > As long as the HPET works reliably :)
> > 
> > Is it also a complete mystery why clocksources previously deemed
> > reliable no longer work reliably?  ;-)
> 
> For HPET, it's a long story :) Back in 2012 or so, the HPET on Baytrail
> platform has a new feature that it will stop counting in PC10 (a cpuidle
> state), which prevent it to be a clocksource, and we have to disable
> HPET explicitly for that platform. Since then, some new platforms also
> have the same feature, and their HPET got disabled too. 

I must confess that I have been involved in similar things more times
than I care to admit.  ;-)

So the upshot is that if HPET does not work, it should be disabled,
in which case the clocksource watchdog will be ignoring it.  In cases
where HPET can stop counting and is not disabled in the Linux kernel,
that is a bug that needs to be fixed by disabing HPET for those cases.

If TSC is the only clocksource, then the clocksource watchdog won't be
checking it.

All of this points to using the presumed-good clocksource to measure the
time between clocksource-watchdog checks, but excluding any silly cases.
For example, as Thomas Gleixner suggested, if the jiffies counter is
trying to be the presumed-good clocksource.

							Thanx, Paul
