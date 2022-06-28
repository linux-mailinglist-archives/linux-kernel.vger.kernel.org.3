Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8255F039
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiF1VNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiF1VNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:13:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335E2F64B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:13:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y18so14162910iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qp7m25bGp4I89hC9EZpofxhYEVk1KWO6oJQ/kcdvaxA=;
        b=HupYSzp689CQV0E6Tuz+gCu5aYArRYpMD22UZWCiMV0jddRn9HN5NraSSRhV28U3K1
         WGqBdybhyEqZAyimZsAa6iHHwE1GeDsRPCunAv6Xyrw/iAvz+e1NKzG+dnY1aUSeYRMX
         mrvCgFzwOPh4ge9jEuKxEvVKHdER7+M73iL8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp7m25bGp4I89hC9EZpofxhYEVk1KWO6oJQ/kcdvaxA=;
        b=wNylauLVZLprlQU7208FJMpm4WHCOVhRJtl0CZwuvH+BBWn9eaiuEhEdAmGVkfUdkT
         8uCR0mKEM/GEa12k2odxGPsdE6X/5XwchRK9DeUWfdrJZOekvd2l3yYtl4/8+XaEqceU
         W1/k2IfFxKyOTkvkZW3Ii97sU4TWQuCiKVPUf+5/bpUstjUOHAPR4/JyDv9HIQJblNG5
         QDHGPUcmGQSGAbmcZTfobyYvUaEyx5mQ6tLn2KQw+IxhjByP2EYEGghvTZ/bSi1p/rqv
         RgP7sKE7cwiISJdhan7UPUmQji5JLjUy1CGITOueuD2eDToQi5ySuSc3G0Bu+Ohxw2jB
         qNAg==
X-Gm-Message-State: AJIora+OveX622MUe+3bruNGXCCQwiP10Lhzg6t8RcEgn4+hfL8Qe9jn
        VY7CKlaInVl9wj9LaivvxeApaUwGSKBCbuOjgmS8OtZ/2cO9mxYA
X-Google-Smtp-Source: AGRyM1uHJfh1IUsC0zg5f3tGppvO+ibhy6mRgLKJY6wKTAWVS+wk1tk7y177SL+Rj6cTbrAY4cpIGkhmjX16Ra2eqC4=
X-Received: by 2002:a02:c48e:0:b0:33c:25bb:a1b2 with SMTP id
 t14-20020a02c48e000000b0033c25bba1b2mr56113jam.180.1656450813355; Tue, 28 Jun
 2022 14:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org> <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1> <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1> <YrsyrmDbfnkpfDEP@google.com>
In-Reply-To: <YrsyrmDbfnkpfDEP@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Jun 2022 17:13:21 -0400
Message-ID: <CAEXW_YRQiuvsy1FsMNWG7wd9ah_gfgcOUAeNzA-QbmDcACa+Uw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return value
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > should return the number of freeable items, but if there are no objects
> > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > cache should be skipped for another reason.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > >               atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > >       }
> > > > > >
> > > > > > -     return count;
> > > > > > +     return count == 0 ? SHRINK_EMPTY : count;
> > > > > >  }
> > > > > >
> > > > > >  static unsigned long
> > > > > > --
> > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > >
> > > > > Looks good to me!
> > > > >
> > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >
> > > > Now that you mention it, this does look independent of the rest of
> > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > >
> > > Thanks Paul and Vlad!
> > >
> > > Paul, apologies for being quiet. I have been working on the series and the
> > > review comments carefully. I appreciate your help with this work.
> >
> > Not a problem.  After all, this stuff is changing some of the trickier
> > parts of RCU.  We must therefore assume that some significant time and
> > effort will be required to get it right.
>
> To your point about trickier parts of RCU, the v2 series though I tested it
> before submitting is now giving me strange results with rcuscale. Sometimes
> laziness does not seem to be in effect (as pointed out by rcuscale), other
> times I am seeing stalls.
>
> So I have to carefully look through all of this again. I am not sure why I
> was not seeing these issues with the exact same code before (frustrated).

Looks like I found at least 3 bugs in my v2 series which testing
picked up now. RCU-lazy was being too lazy or not too lazy. Now tests
pass, so its progress but does beg for more testing:

On top of v2 series:
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c06a96b6a18a..7021ee05155d 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -292,7 +292,8 @@ static void wake_nocb_gp_defer(struct rcu_data
*rdp, int waketype,
         */
        switch (waketype) {
                case RCU_NOCB_WAKE_LAZY:
-                       mod_jif = jiffies_till_flush;
+                       if (rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_LAZY)
+                               mod_jif = jiffies_till_flush;
                        break;

                case RCU_NOCB_WAKE_BYPASS:
@@ -714,13 +715,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
                bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
                lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
                if (lazy_ncbs &&
-                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
LAZY_FLUSH_JIFFIES) ||
+                   (time_after(j, READ_ONCE(rdp->nocb_bypass_first) +
jiffies_till_flush) ||
                     bypass_ncbs > qhimark)) {
                        // Bypass full or old, so flush it.
                        (void)rcu_nocb_try_flush_bypass(rdp, j);
                        bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
                        lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
-               } else if (bypass_ncbs &&
+               } else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
                    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
                     bypass_ncbs > 2 * qhimark)) {
                        // Bypass full or old, so flush it.
