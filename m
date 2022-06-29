Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6B560A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiF2Trm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2Trj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:47:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A13D1C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:47:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c137so12868483qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zvL6K4ApubN7CXJXMHMI39STdbXUc+m2xA0jmMG/9F0=;
        b=UUNLLc317PpAN5hJCv1pP4lv9hlV84Pj1PJHCy41a5D2iqT6lke4aCL3Q27vbE7gG2
         qaHd5uZJ26Uysi2JBEmsoBTol2GbrzQLfUL/wePlXwWSruJEvM1/0ZvQHCL96jqBtcqK
         33Y6dsPdrxgfZTiAJbwMSFFxhYnssSigOvQGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zvL6K4ApubN7CXJXMHMI39STdbXUc+m2xA0jmMG/9F0=;
        b=YsOqOxtPQ6xDhSKQWk4QpgbYSQbuJrkNJZ4srs9kN3JnWYqecLmX5Sapqvhhm8Ontq
         O2PvtMuz5ce3OvZOZONNkG+qmL6REMSwX7bZnSl5htTOHLfKbpg9x9EnSmkj0qW5s9c+
         JVxtoBKlalt35pkhQXm00FEEQn2jpYhCrnB2DVnc6iSK8nrmdm8PmqC/T73Ka0GqY2Ug
         ugLPMtiPKvwEWalHlPBuNrfcE8S26Ljp1zwUojzeSTYt0VCyz2mL4B8OUdlaTo56mqV8
         ja/VKaX2/sSubexQXzRq62S20q/0DtPbolgQXHlSW+u+t6eMDe1o9aHJhJ5qKQis6nX5
         3QBg==
X-Gm-Message-State: AJIora+mhYP0WbWo7X6CYhF2cizMWDQl1S6OA8035HWv1f5YWOMqMXPD
        pS+QUfKSITo6hVEQeVJ8+LW1Cw==
X-Google-Smtp-Source: AGRyM1vZHzCEiCphgOajMwlX+lbKTAIWT9TNdifdzuhH8f922mX0lD6uU/U/m4bzCFlOc0vakN1jaQ==
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id f7-20020a05620a280700b006a66ef1fb9dmr3575735qkp.146.1656532057649;
        Wed, 29 Jun 2022 12:47:37 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bt5-20020ac86905000000b0031bf68f502esm2488452qtb.59.2022.06.29.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:47:37 -0700 (PDT)
Date:   Wed, 29 Jun 2022 19:47:36 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <YrysWAx/rMbBF5iY@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrsyrmDbfnkpfDEP@google.com>
 <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
 <20220629165627.GI1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629165627.GI1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:56:27AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 28, 2022 at 05:13:21PM -0400, Joel Fernandes wrote:
> > On Tue, Jun 28, 2022 at 12:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > > > should return the number of freeable items, but if there are no objects
> > > > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > > > cache should be skipped for another reason.
> > > > > > > >
> > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > ---
> > > > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > > >               atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > > > >       }
> > > > > > > >
> > > > > > > > -     return count;
> > > > > > > > +     return count == 0 ? SHRINK_EMPTY : count;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static unsigned long
> > > > > > > > --
> > > > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > > > >
> > > > > > > Looks good to me!
> > > > > > >
> > > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > >
> > > > > > Now that you mention it, this does look independent of the rest of
> > > > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > > > >
> > > > > Thanks Paul and Vlad!
> > > > >
> > > > > Paul, apologies for being quiet. I have been working on the series and the
> > > > > review comments carefully. I appreciate your help with this work.
> > > >
> > > > Not a problem.  After all, this stuff is changing some of the trickier
> > > > parts of RCU.  We must therefore assume that some significant time and
> > > > effort will be required to get it right.
> > >
> > > To your point about trickier parts of RCU, the v2 series though I tested it
> > > before submitting is now giving me strange results with rcuscale. Sometimes
> > > laziness does not seem to be in effect (as pointed out by rcuscale), other
> > > times I am seeing stalls.
> > >
> > > So I have to carefully look through all of this again. I am not sure why I
> > > was not seeing these issues with the exact same code before (frustrated).
> > 
> > Looks like I found at least 3 bugs in my v2 series which testing
> > picked up now. RCU-lazy was being too lazy or not too lazy. Now tests
> > pass, so its progress but does beg for more testing:
> 
> It is entirely possible that call_rcu_lazy() needs its own special
> purpose tests.  This might be a separate test parallel to the test for
> kfree_rcu() in kernel/rcu/rcuscale.c, for example.

I see, perhaps I can add a 'lazy' flag to rcutorture as well, so it uses
call_rcu_lazy() for its async RCU invocations?

> For but one example, you might need to do bunch of call_rcu_lazy()
> invocations, then keep the kernel completely quiet for long enough to
> let the timer fire, and without anything else happening.

Yes, I sort of do that in rcuscale. There is a flood of call_rcu_lazy() due
to the FS code doing it. And, the timer does fire at the right time. I then
measure the time to make sure the timing matches, that's how I found the bugs
I earlier mentioned.

You had mentioned something like for testing earlier, I thought of trying it
out:

	It also helps to make rcutorture help you out if you have not
	already done so.  For example, providing some facility to allow
	rcu_torture_fwd_prog_cr() to flood with call_rcu_lazy() instead of and
	in addition to call_rcu().


thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > On top of v2 series:
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index c06a96b6a18a..7021ee05155d 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -292,7 +292,8 @@ static void wake_nocb_gp_defer(struct rcu_data
> > *rdp, int waketype,
> >          */
> >         switch (waketype) {
> >                 case RCU_NOCB_WAKE_LAZY:
> > -                       mod_jif = jiffies_till_flush;
> > +                       if (rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_LAZY)
> > +                               mod_jif = jiffies_till_flush;
> >                         break;
> > 
> >                 case RCU_NOCB_WAKE_BYPASS:
> > @@ -714,13 +715,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >                 bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >                 lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> >                 if (lazy_ncbs &&
> > -                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
> > LAZY_FLUSH_JIFFIES) ||
> > +                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
> > jiffies_till_flush) ||
> >                      bypass_ncbs > qhimark)) {
> >                         // Bypass full or old, so flush it.
> >                         (void)rcu_nocb_try_flush_bypass(rdp, j);
> >                         bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >                         lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
> > -               } else if (bypass_ncbs &&
> > +               } else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
> >                     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> >                      bypass_ncbs > 2 * qhimark)) {
> >                         // Bypass full or old, so flush it.
