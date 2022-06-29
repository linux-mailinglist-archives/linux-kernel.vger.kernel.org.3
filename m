Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A65606C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiF2Q4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Q4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:56:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6623164;
        Wed, 29 Jun 2022 09:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 901D3B8224C;
        Wed, 29 Jun 2022 16:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F171C34114;
        Wed, 29 Jun 2022 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656521788;
        bh=cYSL0YOVWZXXddvxYd1mYdL/puCFMqcb38NQLJLQ0nc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dH9oftYHYwcdy6giOnmITOmkE5VyNm04kXBlgidTr9P8l28t7F29mh4IqhX2DCXxK
         dZUTItYI1/TiGYhjMMx4Psn6xJ2H96svC1OaX5cYzq8wXsMLMIscQ99agE4zX1Sarw
         q2wzH+3I8HqFLM2B9Z49FZBzRVDc7RyPl685R334fFpI0plF/cgZSeNvtPSTmpexGK
         +8vXE2CTVHSL4QYVmqctsAbHKc1FOXQI2YVSrRxIFcQ7rAdOjYZ+Dwh8tedtDFXF2g
         8Eyv4mZVT5st+ngH3j1Jsiw9zuyyK4r2gczRAsUTTHLI2P4t10Qkma7fpjBu3jBT18
         UYuUQInFb3ZEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D1E3B5C0E5F; Wed, 29 Jun 2022 09:56:27 -0700 (PDT)
Date:   Wed, 29 Jun 2022 09:56:27 -0700
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
Message-ID: <20220629165627.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrsyrmDbfnkpfDEP@google.com>
 <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:13:21PM -0400, Joel Fernandes wrote:
> On Tue, Jun 28, 2022 at 12:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > > should return the number of freeable items, but if there are no objects
> > > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > > cache should be skipped for another reason.
> > > > > > >
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > ---
> > > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > >               atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > > >       }
> > > > > > >
> > > > > > > -     return count;
> > > > > > > +     return count == 0 ? SHRINK_EMPTY : count;
> > > > > > >  }
> > > > > > >
> > > > > > >  static unsigned long
> > > > > > > --
> > > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > > >
> > > > > > Looks good to me!
> > > > > >
> > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > >
> > > > > Now that you mention it, this does look independent of the rest of
> > > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > > >
> > > > Thanks Paul and Vlad!
> > > >
> > > > Paul, apologies for being quiet. I have been working on the series and the
> > > > review comments carefully. I appreciate your help with this work.
> > >
> > > Not a problem.  After all, this stuff is changing some of the trickier
> > > parts of RCU.  We must therefore assume that some significant time and
> > > effort will be required to get it right.
> >
> > To your point about trickier parts of RCU, the v2 series though I tested it
> > before submitting is now giving me strange results with rcuscale. Sometimes
> > laziness does not seem to be in effect (as pointed out by rcuscale), other
> > times I am seeing stalls.
> >
> > So I have to carefully look through all of this again. I am not sure why I
> > was not seeing these issues with the exact same code before (frustrated).
> 
> Looks like I found at least 3 bugs in my v2 series which testing
> picked up now. RCU-lazy was being too lazy or not too lazy. Now tests
> pass, so its progress but does beg for more testing:

It is entirely possible that call_rcu_lazy() needs its own special
purpose tests.  This might be a separate test parallel to the test for
kfree_rcu() in kernel/rcu/rcuscale.c, for example.

For but one example, you might need to do bunch of call_rcu_lazy()
invocations, then keep the kernel completely quiet for long enough to
let the timer fire, and without anything else happening.

							Thanx, Paul

> On top of v2 series:
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index c06a96b6a18a..7021ee05155d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -292,7 +292,8 @@ static void wake_nocb_gp_defer(struct rcu_data
> *rdp, int waketype,
>          */
>         switch (waketype) {
>                 case RCU_NOCB_WAKE_LAZY:
> -                       mod_jif = jiffies_till_flush;
> +                       if (rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_LAZY)
> +                               mod_jif = jiffies_till_flush;
>                         break;
> 
>                 case RCU_NOCB_WAKE_BYPASS:
> @@ -714,13 +715,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>                 bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>                 lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
>                 if (lazy_ncbs &&
> -                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
> LAZY_FLUSH_JIFFIES) ||
> +                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
> jiffies_till_flush) ||
>                      bypass_ncbs > qhimark)) {
>                         // Bypass full or old, so flush it.
>                         (void)rcu_nocb_try_flush_bypass(rdp, j);
>                         bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>                         lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> -               } else if (bypass_ncbs &&
> +               } else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
>                     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
>                      bypass_ncbs > 2 * qhimark)) {
>                         // Bypass full or old, so flush it.
