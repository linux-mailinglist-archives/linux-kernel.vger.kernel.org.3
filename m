Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD94A7788
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiBBSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:08:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbiBBSId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:08:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03FD8113E;
        Wed,  2 Feb 2022 10:08:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731B03F40C;
        Wed,  2 Feb 2022 10:08:31 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:08:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/6] sched/preempt: refactor sched_dynamic_update()
Message-ID: <YfrImx6c4RuVuY7l@FVFF77S0Q05N>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-3-mark.rutland@arm.com>
 <20211210151343.GA755274@lothringen>
 <YfqftfWSJfuH60Mi@FVFF77S0Q05N>
 <20220202160144.GA458420@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160144.GA458420@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 05:01:44PM +0100, Frederic Weisbecker wrote:
> On Wed, Feb 02, 2022 at 03:13:57PM +0000, Mark Rutland wrote:
> > Hi,
> > 
> > I'm looking at what I need to do to rebase/repost this atop v5.17-rc2, and I
> > realised I need your S-o-B to take your suggestion below.
> > 
> > On Fri, Dec 10, 2021 at 04:13:43PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Nov 09, 2021 at 05:24:04PM +0000, Mark Rutland wrote:
> > > > Currently sched_dynamic_update needs to open-code the enabled/disabled
> > > > function names for each preemption model it supoprts, when in practice
> > > > this is a boolean enabled/disabled state for each function.
> > > > 
> > > > Make this clearer and avoid repetition by defining the enabled/disabled
> > > > states at the function definition, and using helper macros to peform the
> > > > static_call_update(). Where x86 currently overrides the enabled
> > > > function, it is made to provide both the enabled and disabled states for
> > > > consistency, with defaults provided by the core code otherwise.
> > 
> > > > -#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
> > > > +#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
> > > > +#define preempt_schedule_notrace_dynamic_disabled	NULL
> > > 
> > > I'm worried about un-greppable macro definitions like this.
> > I assume you mean that it's hard to go from:
> > 
> >   preempt_dynamic_enable(preempt_schedule_notrace);
> > 
> > ... to this, because the `_dynamic_enabled` or `_dynamic_disabled` part gets
> > token-pasted on?
> 
> Right.

Looking at this some more, I'm probably going to need to do token-pasting at
some level no matter what we do, so how big of a concern is this? Searching
for 'foo_function' should also find 'foo_function_dynamic_enabled' and
'foo_function_dynamic_disabled', and searching for either of those will find
their original definition.

If others aren't concerned, could we just live with that for now?

> > The above will show up in a grep for `preempt_schedule_notrace`, but I agree
> > it's not necessarily ideal, especially if grepping for an exact match.
> > 
> > > Also this enable/disable switch look like a common pattern on static call so
> > > how about moving that logic to static call itself? As in below (only
> > > build-tested):
> > 
> > Sure; if others also prefer that I'm more than happy to build atop.
> > 
> > Can I have your Signed-off-by for that, or can you post that as its own patch?
> 
> Sure, here is a better split and tested version here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	static_call/toggle

Thanks!

> I was hoping to make a default backend based on static keys to implement these
> toggeable static calls, but I had some issues on the way, although I can't
> remember exactly which.
> 
> So eventually I don't know if this stuff will be useful for you....

Having had a play with this, since you need to generate a wrapper for the
static_key case, you either need to match the prototype or have a generic
macro (and you likely end up back in token-pasting hell again anyhow).

So as above, how much does this matter for now?

> Well, I guess this can still ease a wrapper like:
> 
> preempt_dynamic_enable(sym)
> 	---> CONFIG_STATIC_CALL=y? -----> static_call_enable(sym)
> 	else
> 	---> CONFIG_STATIC_KEY=y? -----> static_key_enable(sym)

In this series I just define preempt_dynamic_enable() dependent on
CONFIG_STATIC_CALL or CONFIG_STATIC_KEY, which is functionally equivalent.

Thanks,
Mark.
