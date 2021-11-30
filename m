Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD546438F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbhK3Xkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:40:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60716 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbhK3Xku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:40:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D35FECE1A82
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E61C53FC7;
        Tue, 30 Nov 2021 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638315447;
        bh=lvzUmU5/ZHXS+sd4tahorc905Zy3/hldQXd1YVNzU7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r8QJ3X4qJoVNWpB7tdbuq4i8lLrxC6UTjEq1keV8xYKJ649QujAK5jKzZUgH37jti
         7SY1PoWx1Zsr6/fOT978M5faJQ5RC72JPcCgQDWS+obGgDXrYnhb1SLwXkQ0E2iOte
         l4XKJBWZX+XoZtYQmhKCbKx4ni0Wa0oHoPuV+7X1F/Q2c4V6q6dZ3two+MEGOVblEf
         sKuEUEzDWOKgStK0knhDbkC2EtBDDPFOqBDdOcTsuAsA+qYyY5esoQYxgjpCTjmXzQ
         5GOBkTXKsiW7JTBuQipf8JnEzwVcsLpLJw6UVWL8R1tSk6qQhZTB/TAnqVWRSODfU8
         MoZSKI4uoa/Yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B14B5C0E58; Tue, 30 Nov 2021 15:37:26 -0800 (PST)
Date:   Tue, 30 Nov 2021 15:37:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified
 platforms
Message-ID: <20211130233726.GD641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117023751.24190-2-feng.tang@intel.com>
 <20211130064623.GB96474@shbuild999.sh.intel.com>
 <20211130144048.GQ641268@paulmck-ThinkPad-P17-Gen-1>
 <20211130150256.GA19477@shbuild999.sh.intel.com>
 <20211130162815.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <87r1axbcor.ffs@tglx>
 <20211130204721.GZ641268@paulmck-ThinkPad-P17-Gen-1>
 <87ilw9b95q.ffs@tglx>
 <20211130224825.GA641268@paulmck-ThinkPad-P17-Gen-1>
 <87tuft9qpc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuft9qpc.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:19:43AM +0100, Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 14:48, Paul E. McKenney wrote:
> > On Tue, Nov 30, 2021 at 10:55:45PM +0100, Thomas Gleixner wrote:
> >> > OK, HPET or nothing, then.
> >> 
> >> Older machines also have pm_timer. But those beasts seem to have lost
> >> that too.
> >
> > I suppose that one way of avoiding clock-skew messages is to have only
> > one clock.
> 
> Indeed. It's a complete mystery why it takes ages to implement reliable
> clocks in hardware.

That one is easy.  It is because the previous clocksource watchdog was
too lenient.  ;-)

(Sorry, couldn't resist...)

> >> >> We really need to remove the watchdog requirement for modern hardware.
> >> >> Let me stare at those patches and get them merged.
> >> >
> >> > You are more trusting of modern hardware than I am, but for all I know,
> >> > maybe rightfully so.  ;-)
> >> 
> >> Well, I rather put a bet on the hardware, which has become reasonable
> >> over the last decade, than on trying to solve a circular dependency
> >> problem with tons of heuristics which won't ever work correctly.
> >
> > Use of HPET to check the interval length would not be circular, right?
> 
> As long as the HPET works reliably :)

Is it also a complete mystery why clocksources previously deemed
reliable no longer work reliably?  ;-)

> >> TSC_ADJUST is a reasonable safety net and since its invention the amount
> >> of BIOS wreckage has been massively reduced. Seems the nastigram in
> >> dmesg when detecting a change in TSC_ADJUST had an effect or maybe
> >> Microsoft enforces a tinkerfree TSC by now and we get the benefit. :)
> >> 
> >> I still wish to have a knob to lock down TSC to read only, but that's
> >> probably for christmas 2030 or later. :)
> >
> > Indeed.  How would BIOS writers hide their SMI handlers?  :-/
> 
> TSC_ADJUST already ruined that party.

Give the BIOS writers time, they will figure something else out.  :-(

							Thanx, Paul
