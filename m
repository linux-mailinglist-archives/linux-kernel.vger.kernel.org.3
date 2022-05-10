Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD89522085
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbiEJQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347592AbiEJQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:01:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161C580E2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E5CB81DB5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B99C385C2;
        Tue, 10 May 2022 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652198154;
        bh=eDC3cwakUOMwoxGXClABJcgAE7WUGToWsV0/PUUq8m4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GFNqjuLYwC3csX7gEbjwy54bYIq94tGU7O/8RHCZVdS/bNiRdpAXQGO1zQHQdAF8r
         uSrmjq0im1ImqaHNSV3A8bi6XGOSNO4sv71IIgY4QiHV+xkgYj3ZZIg/pekeZKmQln
         TjNYdis8DbTNrRju16oKfV76o69ARH2cFztGVyFeELlQFX/ufxIM3z0WppbSFS31ea
         MQd1nvnv99oT+akrHNj42quOAef46epuDjdwGGfdAExiGaVVB18KHEgVCUd5munuxp
         jxdIhuQJAYwPRZwTfhsp/nwPnOdZofvRiy9HilOhwcyH31fBDn+0jp4ZdrJg2NeaK4
         YMXMWwAnwSEFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CA605C0602; Tue, 10 May 2022 08:55:53 -0700 (PDT)
Date:   Tue, 10 May 2022 08:55:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Folllowing up on LSF/MM RCU/idle discussion
Message-ID: <20220510155553.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
 <20220510065457.GI76023@worktop.programming.kicks-ass.net>
 <Ynoz13QUEAA2en0f@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynoz13QUEAA2en0f@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:43:51AM +0100, Mark Rutland wrote:
> On Tue, May 10, 2022 at 08:54:57AM +0200, Peter Zijlstra wrote:
> > On Mon, May 09, 2022 at 08:56:33AM -0700, Paul E. McKenney wrote:
> > > Hello, Jiri!
> > > 
> > > It was good chatting with you last week, and I hope that travels went
> > > well!
> > > 
> > > Just wanted to follow up on the non-noinstr code between the call
> > > to rcu_idle_enter() and rcu_idle_exit().  Although the most correct
> > > approach is to never have non-noinstr code in arch_cpu_idle(), for all I
> > > know there might well be architectures for which this is not feasible.
> > > If so, one workaround would be to supply a flag set by each arch (or
> > > subarch) that says that rcu_idle_enter() and rcu_idle_exit() are invoked
> > > within arch_cpu_idle().
> > > 
> > > CCing Peter, who just might have an opinion on this.  ;-)
> > 
> > Definitely have an opinion; just lack the tools to enforce these rules.
> > I cleaned up the worst of it for x86 but it's a shit-show for most
> > others. ARM in particular has some 'issues'.
> 
> Probably worth pointing out that arch_cpu_idle() is the simple case (and I
> fixed that for arm64 to be correct for RCU and noinstr). I think the same
> applies for most architectures.
> 
> The real beast is the cpuidle framework, which is what I think you're referring
> to below, and IIRC that does the rcu_idle_enter() ... rcu_idle_exit() itself?
> Maybe that was just for suspend.
> 
> I have no strong feeling about where we call rcu_idle_{enter,exit}() for
> arch_cpu_idle() specifically, but I think that case is generally simple enough
> that it doesn't really matter?
> 
> For the cpuidle framework, punting this into the driver such that it can be
> done at the last possible moment around entry/exit to a HW idle state does feel
> like it's going to be more robust, even if that means altering all those
> drivers.

There does seem to be some ability to select where the rcu_idle_enter()
and rcu_idle_exit() are executed using CPUIDLE_FLAG_RCU_IDLE.
So depending on exactly which configuration Jiri is running, maybe there
is already a straightforward fix.

However, default_idle_call() invokes rcu_idle_enter() and rcu_idle_exit()
unconditionally, perhaps because it is not considered to be part of
cpuidle.

							Thanx, Paul

> Thanks,
> Mark.
> 
> > But yeah, noinstr only when you do rcu_idle_enter.
> > 
> > The problem with validating all this is that cpuidle is a rats nest of
> > indirect calls; in order to validate the noinstr'ness of something like
> > that we need compiler support for pointer address spaces such that we
> > can stick pointers to noinstr functions in a different address space and
> > get complaints etc..
