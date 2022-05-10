Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A7521149
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiEJJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiEJJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:48:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3638429B818
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:44:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1186C1063;
        Tue, 10 May 2022 02:44:44 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2B43F66F;
        Tue, 10 May 2022 02:44:42 -0700 (PDT)
Date:   Tue, 10 May 2022 10:43:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Folllowing up on LSF/MM RCU/idle discussion
Message-ID: <Ynoz13QUEAA2en0f@FVFF77S0Q05N>
References: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
 <20220510065457.GI76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510065457.GI76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:54:57AM +0200, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 08:56:33AM -0700, Paul E. McKenney wrote:
> > Hello, Jiri!
> > 
> > It was good chatting with you last week, and I hope that travels went
> > well!
> > 
> > Just wanted to follow up on the non-noinstr code between the call
> > to rcu_idle_enter() and rcu_idle_exit().  Although the most correct
> > approach is to never have non-noinstr code in arch_cpu_idle(), for all I
> > know there might well be architectures for which this is not feasible.
> > If so, one workaround would be to supply a flag set by each arch (or
> > subarch) that says that rcu_idle_enter() and rcu_idle_exit() are invoked
> > within arch_cpu_idle().
> > 
> > CCing Peter, who just might have an opinion on this.  ;-)
> 
> Definitely have an opinion; just lack the tools to enforce these rules.
> I cleaned up the worst of it for x86 but it's a shit-show for most
> others. ARM in particular has some 'issues'.

Probably worth pointing out that arch_cpu_idle() is the simple case (and I
fixed that for arm64 to be correct for RCU and noinstr). I think the same
applies for most architectures.

The real beast is the cpuidle framework, which is what I think you're referring
to below, and IIRC that does the rcu_idle_enter() ... rcu_idle_exit() itself?
Maybe that was just for suspend.

I have no strong feeling about where we call rcu_idle_{enter,exit}() for
arch_cpu_idle() specifically, but I think that case is generally simple enough
that it doesn't really matter?

For the cpuidle framework, punting this into the driver such that it can be
done at the last possible moment around entry/exit to a HW idle state does feel
like it's going to be more robust, even if that means altering all those
drivers.

Thanks,
Mark.

> But yeah, noinstr only when you do rcu_idle_enter.
> 
> The problem with validating all this is that cpuidle is a rats nest of
> indirect calls; in order to validate the noinstr'ness of something like
> that we need compiler support for pointer address spaces such that we
> can stick pointers to noinstr functions in a different address space and
> get complaints etc..
