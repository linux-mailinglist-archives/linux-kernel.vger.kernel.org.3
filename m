Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD402561F40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiF3P3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3P3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450639815;
        Thu, 30 Jun 2022 08:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C51066185C;
        Thu, 30 Jun 2022 15:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E6C34115;
        Thu, 30 Jun 2022 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656602943;
        bh=weSR96C6jicYY1bKEc0+mVZ0AKoBWEwHCgVFYGUk8q8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gcASQYFGPqQ7neoXh5ciehnk56P1oC9QTpMxwDelaxZk1ds8PHaYyv0xiUw6V7sAB
         0uxyeBZFs1hNhazxtxMbEWqAD2i8CQSl7k5wYBDvHmEKwKC5CL/U4PSI1CGwuiHjfh
         QK1j8OPuxwvDr0xS5RNXhAD15KtlFl8+cJUrvWoEVTOqEezj9Y6nwGIyJKXDTgVywb
         ph0QD0Ropv35T4XbOEBZ8MPd9eVxD/z47RzazzQjoNPmG3tb6XjmALQwStRjdFpHCU
         wg1SU4LvZ14hP3126Qucu9z4nAd2te/PgFtnjcK5hc+RdnXKvP8xEVedJbExihC/QG
         gmNmSYKSNJxUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9B135C04B3; Thu, 30 Jun 2022 08:29:02 -0700 (PDT)
Date:   Thu, 30 Jun 2022 08:29:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <20220630152902.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrsyrmDbfnkpfDEP@google.com>
 <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
 <20220629165627.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrysWAx/rMbBF5iY@google.com>
 <20220629210720.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yr2yTKZe7JmNrimV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2yTKZe7JmNrimV@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:25:16PM +0000, Joel Fernandes wrote:
> On Wed, Jun 29, 2022 at 02:07:20PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 29, 2022 at 07:47:36PM +0000, Joel Fernandes wrote:
> > > On Wed, Jun 29, 2022 at 09:56:27AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Jun 28, 2022 at 05:13:21PM -0400, Joel Fernandes wrote:
> > > > > On Tue, Jun 28, 2022 at 12:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > > > > > > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > > > > > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > > > > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > > > > > > should return the number of freeable items, but if there are no objects
> > > > > > > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > > > > > > cache should be skipped for another reason.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > > > > ---
> > > > > > > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > > > > > >               atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > > -     return count;
> > > > > > > > > > > +     return count == 0 ? SHRINK_EMPTY : count;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static unsigned long
> > > > > > > > > > > --
> > > > > > > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > > > > > > >
> > > > > > > > > > Looks good to me!
> > > > > > > > > >
> > > > > > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > >
> > > > > > > > > Now that you mention it, this does look independent of the rest of
> > > > > > > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > > > > > > >
> > > > > > > > Thanks Paul and Vlad!
> > > > > > > >
> > > > > > > > Paul, apologies for being quiet. I have been working on the series and the
> > > > > > > > review comments carefully. I appreciate your help with this work.
> > > > > > >
> > > > > > > Not a problem.  After all, this stuff is changing some of the trickier
> > > > > > > parts of RCU.  We must therefore assume that some significant time and
> > > > > > > effort will be required to get it right.
> > > > > >
> > > > > > To your point about trickier parts of RCU, the v2 series though I tested it
> > > > > > before submitting is now giving me strange results with rcuscale. Sometimes
> > > > > > laziness does not seem to be in effect (as pointed out by rcuscale), other
> > > > > > times I am seeing stalls.
> > > > > >
> > > > > > So I have to carefully look through all of this again. I am not sure why I
> > > > > > was not seeing these issues with the exact same code before (frustrated).
> > > > > 
> > > > > Looks like I found at least 3 bugs in my v2 series which testing
> > > > > picked up now. RCU-lazy was being too lazy or not too lazy. Now tests
> > > > > pass, so its progress but does beg for more testing:
> > > > 
> > > > It is entirely possible that call_rcu_lazy() needs its own special
> > > > purpose tests.  This might be a separate test parallel to the test for
> > > > kfree_rcu() in kernel/rcu/rcuscale.c, for example.
> > > 
> > > I see, perhaps I can add a 'lazy' flag to rcutorture as well, so it uses
> > > call_rcu_lazy() for its async RCU invocations?
> > 
> > That will be tricky because of rcutorture's timeliness expectations.
> 
> I have facility now to set the lazy timeout from test kernel modules. I was
> thinking I could set the same from rcu torture. Maybe something like a 100
> jiffies? Then it can run through all the regular rcutorture tests and
> still exercise the new code paths.

That might work, and of course feel free to try it.  Except that there
are a lot of forward-progress checks in rcutorture that will like as not
spew huge steaming piles of false positives if it is only lazy callbacks
that are driving the grace period forward.  You have been warned.  ;-)

> > Maybe a self-invoking lazy callback initiated by rcu_torture_fakewriter()
> > that prints a line about its statistics at shutdown time?  At a minimum,
> > the number of times that it was invoked.  Better would be to print one
> > line summarizing stats for all of them.
> > 
> > The main thing that could be detected from this is a callback being
> > stranded.  Given that rcutorture enqueues non-lazy callbacks like a
> > drunken sailor, they won't end up being all that lazy.
> 
> Thanks for this idea as well. I'll think more about it. thanks,

We probably need a special-purpose test (for example, in rcuscale), but
the self-enqueuing lazy callback should at least avoid false positives
from rcutorture's forward-progress checks.

							Thanx, Paul
