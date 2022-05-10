Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C252210B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiEJQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbiEJQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977E2A1FEC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZAVnZ27/jnJ3ke30PAhjL3cS2la+AU7xgMnxDcmMOxo=; b=Un6O9ftO+C1yvKs4xRrOVca7IV
        CM3l/znwtiJ1gpcmd/mxJYzyXkNbuJhKKSsY+FwDzy3s6N5xEwwzLvts2O3HfEzAM8sCg40Ysf/9T
        haaihCAd/yMmarrjqcUZAQ2GbXthqeEHMHWcaGW7hWpvl+gS9PitHOtPF+d0f0aD5Mgmq+znFCT28
        ySQWzr1BbQBh+bCkS/xOPgCrYD0fKjiU/qOzPep6JjtZYEAju8GgsN7swgWBveAfHJPEbZWjTSHw1
        OXTOD4EG6NFRX+zk0wmGfnFaOnQVP1x8yWrJRGfCQTEBV82mFMldVNeWbA53+VsuELWvLzoxsu0Yb
        y0tfHbAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noSa1-004cRb-Kr; Tue, 10 May 2022 16:19:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9494798100A; Tue, 10 May 2022 18:19:19 +0200 (CEST)
Date:   Tue, 10 May 2022 18:19:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Folllowing up on LSF/MM RCU/idle discussion
Message-ID: <20220510161919.GN76023@worktop.programming.kicks-ass.net>
References: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
 <20220510065457.GI76023@worktop.programming.kicks-ass.net>
 <Ynoz13QUEAA2en0f@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynoz13QUEAA2en0f@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

The whole group idle nonsense on arm32 was the worse I think.
