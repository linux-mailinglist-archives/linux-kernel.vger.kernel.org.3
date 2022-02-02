Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC34A7530
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345639AbiBBQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiBBQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:01:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE43C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE4361647
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A0CC004E1;
        Wed,  2 Feb 2022 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643817706;
        bh=aIj6kLUJOPm3pipxmkj0OFAkJmTcxZCTVYlvSurhL5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwC9uVJ+WduPa3svoc0sx+2QgpRF9lOvwJQk7/qmaCwxRA6Q/9a2WskC8zgBYOJaB
         4zRGYYjOr19sp+fqkzTv6QunPQ+lp9wyUsV+u1wxOR89rpP0J/UVUNwTFMnqynGfmK
         w6eBNqREWuoeLtcTMeonkxkblrOD5hhuA9h0XPlTwvCL5/+Bo+do5oVDcWZ12HZkrp
         LtB+T9qMdkwpl52CI5rvDNDN47LS4+m2whLOPbLMSa7/pAvO9y25Q8KWYave4mBwlN
         O8zG0R6JrnsHlnc9dmzecSUuLsi79snlpvEku+U5adl54D1J7P+dlnd1Gd13+4ptV2
         Pz/ZKgIEEZVig==
Date:   Wed, 2 Feb 2022 17:01:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/6] sched/preempt: refactor sched_dynamic_update()
Message-ID: <20220202160144.GA458420@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-3-mark.rutland@arm.com>
 <20211210151343.GA755274@lothringen>
 <YfqftfWSJfuH60Mi@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfqftfWSJfuH60Mi@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:13:57PM +0000, Mark Rutland wrote:
> Hi,
> 
> I'm looking at what I need to do to rebase/repost this atop v5.17-rc2, and I
> realised I need your S-o-B to take your suggestion below.
> 
> On Fri, Dec 10, 2021 at 04:13:43PM +0100, Frederic Weisbecker wrote:
> > On Tue, Nov 09, 2021 at 05:24:04PM +0000, Mark Rutland wrote:
> > > Currently sched_dynamic_update needs to open-code the enabled/disabled
> > > function names for each preemption model it supoprts, when in practice
> > > this is a boolean enabled/disabled state for each function.
> > > 
> > > Make this clearer and avoid repetition by defining the enabled/disabled
> > > states at the function definition, and using helper macros to peform the
> > > static_call_update(). Where x86 currently overrides the enabled
> > > function, it is made to provide both the enabled and disabled states for
> > > consistency, with defaults provided by the core code otherwise.
> 
> > > -#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
> > > +#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
> > > +#define preempt_schedule_notrace_dynamic_disabled	NULL
> > 
> > I'm worried about un-greppable macro definitions like this.
> I assume you mean that it's hard to go from:
> 
>   preempt_dynamic_enable(preempt_schedule_notrace);
> 
> ... to this, because the `_dynamic_enabled` or `_dynamic_disabled` part gets
> token-pasted on?

Right.

> 
> The above will show up in a grep for `preempt_schedule_notrace`, but I agree
> it's not necessarily ideal, especially if grepping for an exact match.
> 
> > Also this enable/disable switch look like a common pattern on static call so
> > how about moving that logic to static call itself? As in below (only
> > build-tested):
> 
> Sure; if others also prefer that I'm more than happy to build atop.
> 
> Can I have your Signed-off-by for that, or can you post that as its own patch?

Sure, here is a better split and tested version here:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	static_call/toggle

I was hoping to make a default backend based on static keys to implement these
toggeable static calls, but I had some issues on the way, although I can't
remember exactly which.

So eventually I don't know if this stuff will be useful for you....

Well, I guess this can still ease a wrapper like:

preempt_dynamic_enable(sym)
	---> CONFIG_STATIC_CALL=y? -----> static_call_enable(sym)
	else
	---> CONFIG_STATIC_KEY=y? -----> static_key_enable(sym)

Thanks.
