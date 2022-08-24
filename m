Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1505A0207
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiHXTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiHXTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:21:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB925B074;
        Wed, 24 Aug 2022 12:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88735B82660;
        Wed, 24 Aug 2022 19:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF44C433D6;
        Wed, 24 Aug 2022 19:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661368890;
        bh=sSUP1soFdnM84s15NQ7LYscruLuO6dP0arOnIGJ7h90=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XMDu8XhMJx0rsy/rJ2rpKKgnKf8QbCT+PZGopvuw85IPjO8eYQhho0XHOjV2JE8pz
         MHy7dPW9MVusnJ3Nt/PU3vVenz15TXFtayFs6qON5DTJnbnF9RQ0H0+KLQItIcQdw6
         Q7lNmlx/zSOsLZkxQ05/1yxQ36So/si7CUVZ1gWXvv9LB+nAWWBC44s4SARCYdIeHZ
         r6K4LVqm4btxJkUV7K0yxGy1uV8ZDV8qAutwTVnXGywTKoCvh0egyGOafzEt9sQeD9
         B9++OAP08sM6ywcb/XyH+LEg3pUH4tK3Z3xHWMd22mjiExn9hLmAhxHBsz7rRJceXq
         rNktdWdfZaZhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A55D95C055D; Wed, 24 Aug 2022 12:21:29 -0700 (PDT)
Date:   Wed, 24 Aug 2022 12:21:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Message-ID: <20220824192129.GE6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
 <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1>
 <de70b840-df04-5a52-c36f-9eaed839aa7c@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de70b840-df04-5a52-c36f-9eaed839aa7c@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:26:01PM -0400, Joel Fernandes wrote:
> 
> 
> On 8/24/2022 12:20 PM, Paul E. McKenney wrote:
> > On Wed, Aug 24, 2022 at 09:53:11PM +0800, Pingfan Liu wrote:
> >> On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>
> >>> On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> >>>> On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> >>>>> On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> >>>>>> In order to support parallel, rcu_state.n_online_cpus should be
> >>>>>> atomic_dec()
> >>>>>>
> >>>>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >>>>>
> >>>>> I have to ask...  What testing have you subjected this patch to?
> >>>>>
> >>>>
> >>>> This patch subjects to [1]. The series aims to enable kexec-reboot in
> >>>> parallel on all cpu. As a result, the involved RCU part is expected to
> >>>> support parallel.
> >>>
> >>> I understand (and even sympathize with) the expectation.  But results
> >>> sometimes diverge from expectations.  There have been implicit assumptions
> >>> in RCU about only one CPU going offline at a time, and I am not sure
> >>> that all of them have been addressed.  Concurrent CPU onlining has
> >>> been looked at recently here:
> >>>
> >>> https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
> >>>
> >>> You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
> >>> atomic, which is good.  Did you look through the rest of RCU's CPU-offline
> >>> code paths and related code paths?
> >>
> >> I went through those codes at a shallow level, especially at each
> >> cpuhp_step hook in the RCU system.
> > 
> > And that is fine, at least as a first step.
> > 
> >> But as you pointed out, there are implicit assumptions about only one
> >> CPU going offline at a time, I will chew the google doc which you
> >> share.  Then I can come to a final result.
> > 
> > Boqun Feng, Neeraj Upadhyay, Uladzislau Rezki, and I took a quick look,
> > and rcu_boost_kthread_setaffinity() seems to need some help.  As it
> > stands, it appears that concurrent invocations of this function from the
> > CPU-offline path will cause all but the last outgoing CPU's bit to be
> > (incorrectly) set in the cpumask_var_t passed to set_cpus_allowed_ptr().
> > 
> > This should not be difficult to fix, for example, by maintaining a
> > separate per-leaf-rcu_node-structure bitmask of the concurrently outgoing
> > CPUs for that rcu_node structure.  (Similar in structure to the
> > ->qsmask field.)
> > 
> > There are probably more where that one came from.  ;-)
> 
> Should rcutree_dying_cpu() access to rnp->qsmask have a READ_ONCE() ? I was
> thinking grace period initialization or qs reporting paths racing with that. Its
> just tracing, still :)

Looks like it should be regardless of Pingfan's patches, given that
the grace-period kthread might report a quiescent state concurrently.

Good catch!

							Thanx, Paul
