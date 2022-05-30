Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED605538527
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiE3Pmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiE3PmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DAB60D92;
        Mon, 30 May 2022 07:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ABA60FB6;
        Mon, 30 May 2022 14:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0431DC3411A;
        Mon, 30 May 2022 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653922163;
        bh=P5JWUzEVw4owKrA2NgsS0ui84/Nc0qx354IFutwuBHU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QqLKY3ZoZyv7mso5XtjQ4iknbfc7HECtfJq823BOrzgI7RMq5sLr4AulTa0jY5wVq
         mn3TtWVuolsZNb+Kz0PgTHAAzWCmxrZKDZO6qE+BhrgzyrbBR9peasBTfAlr5Ve9V0
         JXb5nFbqs7V/jvu0GgnI40snw9EgteoG2lyHZ69udNVNhqCjkAaM/Fn/CDpW5zyUTZ
         jA+irbfev3ty6ti6sEbKX8ge4DbrgqILhSnIom0QqLaVfKAWSqxp1PZeQGqRSN9hh3
         HOP5LLpoLb3ISkGiHaYn9xaHrUfEU/bHBVF4aq4VhsxL47+8tKRTK4D8uQpCUPvv4D
         fC+PciD8nevMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 995485C034D; Mon, 30 May 2022 07:49:22 -0700 (PDT)
Date:   Mon, 30 May 2022 07:49:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220530144922.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <e3010471ee43e7e134f882f320fc4643fe4e4810.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3010471ee43e7e134f882f320fc4643fe4e4810.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:29:56PM +0200, nicolas saenz julienne wrote:
> On Mon, 2022-05-30 at 02:40 +0200, Frederic Weisbecker wrote:
> > On Sat, May 28, 2022 at 04:24:50PM +0200, Peter Zijlstra wrote:
> > > On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> > > > Hi,
> > > > 
> > > > On 26/05/22 14:37, Tejun Heo wrote:
> > > > > On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > > > > > I am thinking along the line that it will not be hierarchical. However,
> > > > > > cpuset can be useful if we want to have multiple isolated partitions
> > > > > > underneath the top cpuset with different isolation attributes, but no more
> > > > > > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > > > > > set them at the first level under top_cpuset. Will that be useful?
> > > > > 
> > > > > At that point, I'd just prefer to have it under /proc or /sys.
> > > > 
> > > > FWIW, I was under the impression that this would nicely fit along the
> > > > side of other feaures towards implenting dynamic isolation of CPUs (say
> > > > https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> > > > for example). Wouldn't be awkward to have to poke different places to
> > > > achieve isolation at runtime?
> > > 
> > > This, that's what I was thinking.
> > > 
> > > My main objection to the whole thing is that it's an RCU_NOCB specific
> > > interface. *That* I think is daft.
> > > 
> > > I was thinking a partition would be able to designate a house-keeping
> > > sub-partition/mask, but who cares about all the various different
> > > housekeeping parties.
> > 
> > It's time for the isolation users to step up here! I very rarely hear from them
> > and I just can't figure out by myself all the variants of uses for each of the
> > isolation features. May be some people are only interested in nocb for some
> > specific uses, or may be it never makes sense without nohz full and all the rest
> > of the isolation features. So for now I take the very cautious path to split the
> > interface.
> 
> OK, my 2 cents. I personally deal with virtualisation setups that involve RT
> and CPU isolation on both host and guests.
> 
> The main use-case ATM is running DPDK-like workloads. We want to achieve
> latencies in the order of tens of microseconds, so it's essential to avoid
> entering the kernel at all cost. So, no HW interrupts, sched tick, RCU
> callbacks, clocksource watchdogs, softlockup, intel_pstate, timers, etc...
> Everything is deferred onto housekeeping CPUs or disabled.
> 
> Then we have setups that need to deal with HW on the host, exposed to the guest
> through emulation or VirtIO. The same rules apply really, except for some IRQ
> affinity tweaks and sched priority magic.
> 
> I find it hard to see how running RCU callback locally could be useful to any
> latency sensitive workload.
> 
> Frederic, out of curiosity, do you have a use-case in mind that might benefit
> from nohz_full but not rcu_nocb? Maybe HPC?

Would users looking for millisecond-scale latencies want rcu_nocbs but
not nohz_full, that is, the other way around?

							Thanx, Paul
