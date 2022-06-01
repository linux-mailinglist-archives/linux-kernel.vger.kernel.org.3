Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5653A9D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355289AbiFAPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbiFAPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:18:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2CC996BA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:18:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FB5B1FB;
        Wed,  1 Jun 2022 08:18:33 -0700 (PDT)
Received: from wubuntu (FVFF764EQ05P.cambridge.arm.com [10.1.29.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA15F3F66F;
        Wed,  1 Jun 2022 08:18:32 -0700 (PDT)
Date:   Wed, 1 Jun 2022 16:18:31 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Paul Bone <pbone@mozilla.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scheduling for heterogeneous computers
Message-ID: <20220601151831.abbo3fxuua5lqj23@wubuntu>
References: <20220308092141.GF748856@aluminium>
 <20220321121611.ssa7o2npy3ahdofk@wubuntu>
 <CANdLaqA6aHr3K0apZLsXVbx1_zZvK6iMvX+HVcu7888HOeEjhg@mail.gmail.com>
 <20220525152956.5oz2chfwlgevvaul@wubuntu>
 <20220527054556.GA2350963@aluminium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527054556.GA2350963@aluminium>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/22 15:45, Paul Bone wrote:
> On Wed, May 25, 2022 at 04:29:56PM +0100, Qais Yousef wrote:
> > Hi Paul
> > 
> > On 05/24/22 15:23, Paul Bone wrote:
> > > Hi Qais,
> > > 
> > > That's excellent.
> > > 
> > > I'll definitely check out those links.  This could be very interesting for
> > > people using firefox on a phone/tablet, where we can run background tasks with
> > > a lower UCLAMP_MAX
> > 
> > If you're running on Android, you might find that you won't have permission to
> > use uclamp directly. Android restricts access and requires you to use higher
> > level APIs sometimes.
> > 
> > And I'm not sure if they have API to allow you to do what you want. I've seen
> > they have the concept of creating Foreground and Background jobs in one of
> > their Google IO presentations. But not sure if this will be tied to uclamp_max.
> > It might give you similar results still though regardless of the underlying
> > mechanism.
> 
> We want to support both desktop and android.  I have been assuming there's
> an API for android already, I vaguely remember hearing about it before.  We
> might already be using it (at least for processes but not yet for individual
> threads).
> 
> I was searching online now, but not for very long, and didn't find something
> like this, so maybe Android doesn't expose it, or at least not in one of the
> APIs they encourage you to use.

I am not an Android developer, so don't take it as a guidance :-)

But what I've seen and seemed related is this:

	* https://developer.android.com/guide/background
	* https://www.youtube.com/watch?v=IqnCqHyu1E4

I don't know the inner plumbing of these APIs and just some relevant stuff I've
come across. I hope they get attached to background cgroup and benefit from
uclamp indirectly that way.

> 
> What I'd really like is an API where I can choose one of:
> 
>  * This task is user-interactive, as-quick-as-possible please.
>  * This task is not user-interactive, but does have a deadline.

What's the difference between the two?

as-quickly-as-possible is about wake up latency or DVFS latency?

If the former then we had several discussions for that in OSPM and LPC. Latest
proposal is here to try to help tag tasks that care about wake up latency:

	https://lore.kernel.org/lkml/86066641739c4897b0001153e598a261@AcuMS.aculab.com/

If the latter, then uclamp_min should help you tell the kernel what performance
you need to get your work done in time. You can dynamically adjust it, or set
it once after a short discovery period assuming your workload is constant for
the duration of its lifetime. The goal to keep it as small as possible to
avoid wasting unnecessary power yet without missing a deadline.

>  * This task doesn't have a deadline.

I think we have enough plumbing in the kernel to provide these classifications.
It'd be nice to have a library that provides higher level API maybe for the end
users.

> Rather than choosing a suitable UCLAMP_MAX, I'll expriment with the numbers
> but choosing "400" on one system might mean something different from "400"
> on another system.  But I guess that's the problem, there are gray areas
> between my discrete options above.  A deadline could be "finish doing GC
> before we run out of memory" (which can have feedback from the GC about if
> it's on target), or "Finish encoding this video before the client wants to
> publish it", or "finish rendering this frame of a video game before the next
> VBLANK".  Depending on how on-target any of these are we could decrese or
> increase clock speed, because decreasing will always save power as long as
> things get done by their deadline.

Yep. I'm glad you're aware that "400" could mean anything and depends on the
target.

Any feedback on how to make this more useful will be appreciated. I think
picking the middle (512) and then expand or shrink based how much headroom you
have (or performance you're willing to sacrifice) might be a good starting
point. I think steering away from the top perf points will yield good results
in general. To squeeze more, maybe we'll need to expose more info to allow for
potable code. If you know your system, you can make some assumptions.

I'd be interested to know how well you can do with simple controls like these.

Cheers

--
Qais Yousef
