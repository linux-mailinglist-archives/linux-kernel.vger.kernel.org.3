Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883CF4F9C02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiDHRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiDHRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:51:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6511C056E;
        Fri,  8 Apr 2022 10:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 135F7B82C8B;
        Fri,  8 Apr 2022 17:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C301FC385A5;
        Fri,  8 Apr 2022 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649440148;
        bh=DX5uSsYLa7Jfsvg5aV44fSkze11p6BwzgWDgpOisInI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UG3t7jIJRt0wdP5v2L58X5RzBAQJVQTFqVPxpHkSJubWdVQXApkRt9rs4+WzZtbL8
         ymThaCnZ27H/PWp/S4uD2okkzYXCO5aVQN5+SRzvqPAH9gjwA6ch2AIT6vL+zIjJXn
         2fo+JAbph1eYIAhvW3orf+VWoJ+aXe0SWUyfSZwF+CF2kvUHDMnKds3JHg9aSC0xKR
         IWBqXZwDZ5tzWuBn1ufXQD6MO50EdMiofl1J+VOuOKCwLipoxFuAOcsH1Yf8OoVzs7
         ImvOb2KWsbmZnqWPQchMXe05+QKLdMIrp5cqEt4jPNHbgnbeA3U6y70z6VoMcphPQy
         8IjLautNiCEkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E5A55C015D; Fri,  8 Apr 2022 10:49:08 -0700 (PDT)
Date:   Fri, 8 Apr 2022 10:49:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:20:02PM -0400, Joel Fernandes wrote:
> On Fri, Apr 8, 2022 at 11:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 08, 2022 at 10:52:21AM -0400, Joel Fernandes wrote:
> > > On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > > > > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > > > > which ends up not offloading any CPU. This patch removes yet another
> > > > > dependency from the bootloader having to know about RCU, about how many
> > > > > CPUs the system has, and about how to provide the mask. Basically, I
> > > > > think we should stop pretending that the user knows what they are doing :).
> > > > > In other words, if NO_CB_CPU is enabled, lets make use of it.
> > > > >
> > > > > My goal is to make RCU as zero-config as possible with sane defaults. If
> > > > > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > > > > take precedence and this patch will have no effect.
> > > > >
> > > > > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
> > > >
> > > > Unless something has changed, this would change behavior relied upon
> > > > the enterprise distros.  Last I checked, they want to supply a single
> > > > binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> > > > and they also want the default to be non-offloaded.  That is, given a
> > > > kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> > > > or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.
> > >
> > > Just curious, do you have information (like data, experiment results)
> > > on why they want default non-offloaded? Or maybe they haven't tried
> > > the recent work done in NOCB code?
> >
> > I most definitely do.  When I first introduced callback offloading, I
> > made it completely replace softirq callback invocation.  There were some
> > important throughput-oriented workloads that got hit with significant
> > performance degradation due to this change.  Enterprise Java workloads
> > were the worst hit.
> >
> > Android does not run these workloads, and I am not aware of ChromeOS
> > running them, either.
> 
> Thanks a lot for mentioning this, I was not aware and will make note
> of it :-). I wonder if the scheduler had something to do with the
> degradation.

It is all too easy to blame the scheduler and all too easy to forget
that the scheduler has a hard job.  ;-)

And in this case, the scheduler was just doing what it was told.

With softirq, a common RCU code path sets a bit in a per-CPU variable.
With offloaded kthreads, that same code path does a much more expensive
wakeup operation.  In addition, in the common case, the softirq handler
runs on the back of an interrupt, and that interrupt handler has already
disrupted the caches, so additional disruption by the softirq handler
is not a big deal.  In contrast, the scheduler has to do the wakeup at
some point in time, and that point in time is very likely quite a bit
more disruptive.

> > > Another option I think is to make it enforce NOCB if NR_CPUS <= 32 if
> > > that makes sense.
> >
> > That would avoid hurting RHEL and SLES users, so this would be better
> > than making the change unconditionally.  But there are a lot of distros
> > out there.
> >
> > I have to ask...  Isn't there already a way of specifying a set of kernel
> > boot parameters that are required for ChromeOS?  If so, add rcu_nocbs=0-N
> > to that list and be happy.
> 
> Yes, that's doable.

Very good, thank you!

> > > > And is it really all -that- hard to specify an additional boot parameter
> > > > across ChromeOS devices?  Android seems to manage it.  ;-)
> > >
> > > That's not the hard part I think. The hard part is to make sure a
> > > future Linux user who is not an RCU expert does not forget to turn it
> > > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > > ;-D. AFAIR, there were Android devices too in the past where I saw
> > > this forgotten. I don't think we should rely on the users doing the
> > > right thing (as much as possible).
> > >
> > > The single kernel binary point makes sense but in this case, I think
> > > the bigger question that I'd have is what is the default behavior and
> > > what do *most* users of RCU want. So we can keep sane defaults for the
> > > majority and reduce human errors related to configuration.
> >
> > If both the ChromeOS and Android guys need it, I could reinstate the
> > old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> > about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> > and Android movers and shakers would overcome lingering objections.
> >
> > Would that help?
> 
> Yes, I think I would love for such a change. I am planning to add a
> test to ChromeOS to check whether config options were correctly set
> up. So I can test for both the RCU_NOCB_CPU options.

Very good!

Do you love such a change enough to create the patch and to collect
convincing Reviewed-by tags?

							Thanx, Paul
