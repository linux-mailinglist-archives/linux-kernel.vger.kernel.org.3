Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59DA5A55B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiH2UhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiH2UhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:37:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906109C1C0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:36:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j6so4226237ilu.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oJHGzlK4MXpKYnbX5FGsG5NEr72dUa0+Mw2OmYfvH9o=;
        b=RF8xjkxbgQYH8+YGfOnlHbjvDqzfMEWPbwWPcmnvzdErGl+0kKZ6hHb9CttlfZQjxZ
         733Ut+gsDoI9ZH1cWXRDQtDMFFNMRm0sAYKomj7va332Dofp/YL+YoOuCuCfKI+hfX8M
         Xz1Zqgs7IGG91nf/JQPn517Np0MeXR3sKIu2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oJHGzlK4MXpKYnbX5FGsG5NEr72dUa0+Mw2OmYfvH9o=;
        b=fCdKUuckY34DVhpXFyYJqyuGSjb3cjEV+Db8fg9lYekKTiHFkQ4e42QD05sVOVJsQX
         OKJ/Qp+pRAVhNYq356PeMn4d4uuB7Ax2/IiSRJNbHThUNXqmULcmwcnvnzOSrycd8qB2
         Yjr1DT5QSDK+E0frkCEPNuGxvwnY5PFSr1e+OfSdadYxATIteZg+DLQtYIZ7rRKTcY5B
         klm5qzScoyWa24l4c1K8adVlIh1LnXKh7Xrq5FJnRG5t3hFtjMbOHWbAfNo6J3xoEeBr
         m12Ua2BtqwrHQJhlPq/SiX8F4b6tZQ6WQSXx1cJRJXACzBqaje+18Fl5tex9Ycza4/DM
         apvg==
X-Gm-Message-State: ACgBeo3T3vnG3tcIZ5fdYM0C6acBrp/0m0gg2zCciJau4VHHJloUYsKY
        RvS6mImCywOebx10+L9MIiRQd5tioRbPBW/D5s8Biw==
X-Google-Smtp-Source: AA6agR45QqBbRwD0r4E0ka+5HzzCvmoghkOil3jvUA44Kf7NupJwRDGpiCgMa6ifcGhoUkmWsk3emi9+MKzjpT9ts4k=
X-Received: by 2002:a05:6e02:1e06:b0:2e9:97e7:880a with SMTP id
 g6-20020a056e021e0600b002e997e7880amr11000238ila.148.1661805413020; Mon, 29
 Aug 2022 13:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen> <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
In-Reply-To: <20220829194622.GA58291@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 29 Aug 2022 16:36:40 -0400
Message-ID: <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     Frederic Weisbecker <frederic@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
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

On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > Hi Frederick,
> >
> > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > > On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
> > >> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
> > >> and rcuscale tests.
> > >>
> > >> Fixes on top of v3:
> > >> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
> > >>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
> > >> - Fixed trace_rcu_callback tracepoint
> > >>
> > >> I tested power previously [1], I am in the process of testing power again but I
> > >> wanted share my latest code as others who are testing power as well could use
> > >> the above fixes.
> > >
> > > Your patch is very likely to be _generally_ useful and therefore,
> > > the more I look into this, the more I wonder if it is a good idea to rely on
> > > bypass at all, let alone NOCB. Of course in the long term the goal is to have
> > > bypass working without NOCB but why even bothering implementing it for nocb
> > > in the first place?
> >
> > This was discussed with Paul [1]. Quoting:
> >
> > ----
> > Joel:
> > >> Also, does doing so not prevent usage of lazy CBs on systems without
> > >> NOCB? So if we want to future-proof this, I guess that might not be a
> > >> good decision.
> > >
> > Paul:
> > > True enough, but would this future actually arrive?  After all, if
> > > someone cared enough about energy efficiency to use call_rcu_lazy(),
> > > why wouldn't they also offload callbacks?
> >
> > Joel: I am not sure, but I also don't mind making it depend on NOCB for now
> > (see below).
> >
> > [1] https://www.spinics.net/lists/rcu/msg07908.html
> > ----
> >
> > While I agree with you that perhaps making it more generic is better, this did
> > take a significant amount of time, testing and corner case hunting to come up
> > with, and v5 is also in the works so I'd appreciate if we can do it the
> > bypass-way and optimize later. Arguably the bypass way is quite simple and
> > allows us to leverage its effects of rcu_barrier and such. And the API will not
> > change.
>
> Keep in mind that if we later need to rewrite the whole in order to have a
> generic approach, this will take even more time in the long run.

Agreed on that. But the use

> > > 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> > > https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> > > )
> >
> > Really? Android has been using it for a long time. It seems to be quite popular
> > in the battery-powered space.
>
> It's really sad that this is the first time I hear about that. I've been working
> on this code for years now without this usecase in mind. And yet it's fundamental.
>
> I asked several times around about other usecases of rcu_nocbs than nohz_full=
> and nobody reported that. I can hardly even google a significant link
> between power saving and rcu_nocbs=
>
> If this is really used that way for a long time then it's a cruel disconnection
> between users and developers.

I was not involved with Android or RCU back then. But my guess is I
don't think it was enabled with the intent of saving power, it is just
that using RCU_NO_CB_CPU has become the way to go to keep dynick-idle
CPUs undisturbed: https://paulmck.livejournal.com/66807.html . Paul ,
+Dietmar Eggemann can probably provide more history.

> > > 2) NOCB implies performance issues.
> >
> > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > with the extra scheduling overhead of the extra threads which is usually not a
> > problem except that RCU is used in the critical path of boot up (on ChromeOS).
>
> I never measured it myself but executing callbacks on another CPUs, with
> context switches and locking can only involve significant performance issues if callbacks
> are frequent. So it's a tradeoff between power and performance.

In my testing of benchmarks on real systems with 8-16 CPUs, the
performance hit is down in the noise. It is possible though that maybe
one can write a non-realistic synthetic test to force the performance
issues, but I've not seen it in the real world. Maybe on
networking-heavy servers with lots of cores, you'll see it but their
batteries if any would be pretty big :-).

> > > 3) We are mixing up two very different things in a single list of callbacks:
> > >    lazy callbacks and flooding callbacks, as a result we are adding lots of
> > >    off-topic corner cases all around:
> > >      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
> > >        general than just bypass/lazy
> > >      * "lazy" specialized parameters to general purpose cblist management
> > >        functions
> >
> > I think just 1 or 2 functions have a new lazy param. It didn't seem too
> > intrusive to me.
>
> What bothers me is that struct cblist has a general purpose and we are adding a field
> and a parameter that is relevant to only one specialized user.

To Paul's point, we can change it to a flag I think. The 3 states are:
- no CBs.
- All lazy
- All non-lazy

Or, worse case, we can move the flag to the per-cpu rcu_data
structure, I think. Does that alleviate your concern?

> > > 4) This is further complexifying bypass core code, nocb timer management, core
> > >    nocb group management, all of which being already very complicated.
> >
> > True, I agree, a few more cases to handle for sure, but I think I got them all
> > now (hopefully).
>
> Now I'm worried about maintainability. Hence why I'd rather see a generic code
> for them all if possible.

Maintainability is a concern for any new code. I rely a lot on testing
both synthetic, and real-world. I have spent a lot of time on test
code on this.

> > > So here is a proposal: how about forgetting NOCB for now and instead add a new
> > > RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> > > Then ignore that segment until some timer expiry has been met or the CPU is
> > > known to be busy? Probably some tiny bits need to be tweaked in segcblist
> > > management functions but probably not that much. And also make sure that entrain()
> > > queues to RCU_LAZY_TAIL.
> > >
> > > Then the only difference in the case of NOCB is that we add a new timer to the
> > > nocb group leader instead of a local timer in !NOCB.
> >
> > It sounds reasonable, but I'll go with Paul on the usecase argument - who would
> > actually care about lazy CBs outside of power, and would those guys ever use
> > !NO_CB if they cared about power / battery?
>
> _Everybody_ cares about power. Those who don't yet will very soon ;-)
>
> And given the numbers you provided with your measurements, I bet this will
> be significant with !NOCB as well. This is not only delaying callbacks execution,
> this also reduces the frequency of grace periods, and that impact should be
> quite visible.

I will defer to Paul on whether the current approach is a viable
solution. If it is not, and we are to take a different design route,
it would be good to know that so I can cease current efforts and go
back to the drawing board.

>
> Note I'm not stricly opposed to the current approach. But I can't say I'm
> comfortable with it.

Maybe we can find a way in the code to see what can be changed. One
concern you rightly raised is the length variables , but I think
that's not a blocker.

> Can we do a simple test? Would it be possible to affine every rcuo%c/%d kthread
> to the corresponding CPU%d? For example affine rcuop/1 to CPU 1, rcuop/2 to
> CPU2, etc... And then relaunch your measurements on top of that?

We already did that and it does not help, it makes things worse. The
decision of where to run RCU threads is best left to the scheduler
(for both performance and power).

> The point is that having the callback kthreads affined to their corresponding
> CPUs should elude the power saving advantages of rcu_nocbs=, back to roughly
> a !NOCB behaviour powerwise (except we have context switches). If you find good
> numbers with this setup then you'll find good numbers with !NOCB.

You'll be surprised at the results! ;-) The reaction of everyone I
know off who has tried this is a pleasant surprise that "the scheduler
might actually know what it's doing" ;-)

thanks,

 - Joel
