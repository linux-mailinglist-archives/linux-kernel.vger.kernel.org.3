Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7A4676FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380700AbhLCMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:08:11 -0500
Received: from foss.arm.com ([217.140.110.172]:48358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380690AbhLCMID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:08:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA281396;
        Fri,  3 Dec 2021 04:04:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9613F5A1;
        Fri,  3 Dec 2021 04:04:37 -0800 (PST)
Date:   Fri, 3 Dec 2021 12:04:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v2 8/8] drivers/perf: Add Apple icestorm/firestorm CPU
 PMU driver
Message-ID: <YaoH07BzWSLKQ6K3@FVFF77S0Q05N>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-9-maz@kernel.org>
 <YaepolizIKkzDQoV@FVFF77S0Q05N>
 <877dcnm2wt.wl-maz@kernel.org>
 <Yajwydy37psEPaS2@lakrids>
 <875ys6lype.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ys6lype.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:22:53AM +0000, Marc Zyngier wrote:
> On Thu, 02 Dec 2021 16:14:01 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Dec 02, 2021 at 03:39:46PM +0000, Marc Zyngier wrote:
> > > On Wed, 01 Dec 2021 16:58:10 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Wed, Dec 01, 2021 at 01:49:09PM +0000, Marc Zyngier wrote:
> > > > > +	state = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
> > > > > +	overflow = read_sysreg_s(SYS_IMP_APL_PMSR_EL1);
> > > > 
> > > > I assume the overflow behaviour is free-running rather than stopping?
> > > 
> > > Configurable, apparently. At the moment, I set it to stop on overflow.
> > > Happy to change the behaviour though.
> > 
> > The architected PMU continues counting upon overflow (which prevents
> > losing counts around the overlflow occurring), so I'd prefer that.
> > 
> > Is that behaviour per-counter, or for the PMU as a whole?
> 
> It is global. This will probably require some additional rework to
> clear bit 47 in overflowing counters, which we can't do atomically.

Ah; I see.

To calrify my comment above, the reason for wanting the counter to keep
counting is to count during the window between the IRQ being asserted and the
PMU IRQ handler being invoked, and it's fine for there to be a blackout period
*within* the PMU IRQ handler.

So for example it would be fine to have:

	irq_handler() 
	{
		if (!any_counter_overflowed())
			return IRQ_NONE;

		stop_all_counters();

		for_each_counter(c) {
			handle_counter(c);
		}
		
		start_all_counters();

		return IRQ_HANDLED;

	}

... and I think with that the regular per-counter period reprogramming would do
the right thing?

Really, all the PMU drivers should do that so that repgoramming is consistent
and we don't get skewed groups.

Thanks,
Mark.
