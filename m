Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A574A8356
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350317AbiBCLw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350321AbiBCLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F97C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 901CAB833FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE885C340E4;
        Thu,  3 Feb 2022 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643889141;
        bh=xqeQ8J1eLBewrk6Mue9ZGQqdEUirZcc5PbW3BH9s4bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nu+hc8ZuO5e7BtcDA8dV1LZF0o05VaHWN+CA6ohXHRaW9yQhyz/Wt3yum+loIyoH4
         XAv5uEpNj21zuZ7Vu9Zpnlk/wEdlqscFAs2qd+PDbnVX5hyO4XW/v6G3fxhkhPV/LG
         0MtDKllieKPzISPjzuuY+G51LTR572NY3AFp6uTGGa4RhYoZKzhb7FjxQTnhxFhI8r
         TEGKrmdCE30mrgXfbMEL8LDWzSZ666zAuLKnESGr4los6JLNsUL2yXd7bnbMWmHO2n
         k1TwBskuQnSlkD2D2IqcEVnEAHLrkUSf+fusQ7z4wbwBxyQ50CoPPLZsyDEZAjZuEf
         gnRpkdPHh9wCw==
Date:   Thu, 3 Feb 2022 12:52:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/6] sched/preempt: refactor sched_dynamic_update()
Message-ID: <20220203115218.GB471778@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-3-mark.rutland@arm.com>
 <20211210151343.GA755274@lothringen>
 <YfqftfWSJfuH60Mi@FVFF77S0Q05N>
 <20220202160144.GA458420@lothringen>
 <YfrImx6c4RuVuY7l@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfrImx6c4RuVuY7l@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:08:27PM +0000, Mark Rutland wrote:
> On Wed, Feb 02, 2022 at 05:01:44PM +0100, Frederic Weisbecker wrote:
> > On Wed, Feb 02, 2022 at 03:13:57PM +0000, Mark Rutland wrote:
> > > > > +#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
> > > > > +#define preempt_schedule_notrace_dynamic_disabled	NULL
> > > > 
> > > > I'm worried about un-greppable macro definitions like this.
> > > I assume you mean that it's hard to go from:
> > > 
> > >   preempt_dynamic_enable(preempt_schedule_notrace);
> > > 
> > > ... to this, because the `_dynamic_enabled` or `_dynamic_disabled` part gets
> > > token-pasted on?
> > 
> > Right.
> 
> Looking at this some more, I'm probably going to need to do token-pasting at
> some level no matter what we do, so how big of a concern is this? Searching
> for 'foo_function' should also find 'foo_function_dynamic_enabled' and
> 'foo_function_dynamic_disabled', and searching for either of those will find
> their original definition.
> 
> If others aren't concerned, could we just live with that for now?

Sure, I don't have a better idea right now. I'll try to think of something
after the next iteration.

> > I was hoping to make a default backend based on static keys to implement these
> > toggeable static calls, but I had some issues on the way, although I can't
> > remember exactly which.
> > 
> > So eventually I don't know if this stuff will be useful for you....
> 
> Having had a play with this, since you need to generate a wrapper for the
> static_key case, you either need to match the prototype or have a generic
> macro (and you likely end up back in token-pasting hell again anyhow).
> 
> So as above, how much does this matter for now?
> 
> > Well, I guess this can still ease a wrapper like:
> > 
> > preempt_dynamic_enable(sym)
> > 	---> CONFIG_STATIC_CALL=y? -----> static_call_enable(sym)
> > 	else
> > 	---> CONFIG_STATIC_KEY=y? -----> static_key_enable(sym)
> 
> In this series I just define preempt_dynamic_enable() dependent on
> CONFIG_STATIC_CALL or CONFIG_STATIC_KEY, which is functionally equivalent.

You're right.

It's just that instead of:

#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_notrace_dynamic_enabled
 #define preempt_schedule_notrace_dynamic_enabled       preempt_schedule_notrace
 #define preempt_schedule_notrace_dynamic_disabled      NULL
 #endif

#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)      static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)     static_call_update(f, #f##_dynamic_disabled)

You have:

DECLARE_STATIC_CALL_TOGGLE(preempt_schedule_notrace, __preempt_schedule_notrace_func);

#define preempt_dynamic_enable(f)      static_call_enable(f)
#define preempt_dynamic_disable(f)     static_call_disable(f)

Thanks.
