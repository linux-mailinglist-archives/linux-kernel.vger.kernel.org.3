Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF94D8F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiCNVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiCNVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B135DD0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 274F46135E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB5C340E9;
        Mon, 14 Mar 2022 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647294828;
        bh=QDOU3spVqdpsvf3p9pseTP+NSIdd5DYDKvSNKCwGzW4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B679eC4f8RA5kqmFnEQCHQP4gvmFpWWq+Ilj1vxGUuIinGAEna9umrZDACtJY6iOd
         Fa0y49+p6iqarq5CTdfwC+ujQmTVwLnh8zmLGbnMTcgdpaSm5tlOLwY5j8Rj1tQ+lf
         45SZZa9/mvqvluPaMU2MaY2jTEuiwkg15DceBXc2WAjvkA6vqRqwW/uvLYOP3rhyh6
         J0HFyVCuAlbS/G9ngim1O8a+YMB0EjwHbKLzvsPFv3briJspSjBYHfxL5zkiID/4zw
         Si4HN8j7ka2WeOIUy4ZbaXJeewovsgw8MY4T1Tx4g5dOx5RZV5GBUa3DFstbZtf2zD
         zfipzdG9XHUKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1DB075C023F; Mon, 14 Mar 2022 14:53:48 -0700 (PDT)
Date:   Mon, 14 Mar 2022 14:53:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
Message-ID: <20220314215348.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314133738.269522-3-frederic@kernel.org>
 <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
 <20220314200641.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMsyb9aOqcvUUMLbkyHiE9ZieBigU1XqBXgtYz_O00y3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMsyb9aOqcvUUMLbkyHiE9ZieBigU1XqBXgtYz_O00y3g@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 09:34:26PM +0100, Marco Elver wrote:
> On Mon, 14 Mar 2022 at 21:06, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Mar 14, 2022 at 03:44:39PM +0100, Marco Elver wrote:
> > > On Mon, 14 Mar 2022 at 14:37, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > From: Valentin Schneider <valentin.schneider@arm.com>
> > > >
> > > > CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
> > > > o The build-time preemption model when !PREEMPT_DYNAMIC
> > > > o The default boot-time preemption model when PREEMPT_DYNAMIC
> > > >
> > > > IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
> > > > model could have been set to something else by the "preempt=foo" cmdline
> > > > parameter.
> > > >
> > > > Introduce a set of helpers to determine the actual preemption mode used by
> > > > the live kernel.
> > > >
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > ---
> > > >  include/linux/sched.h | 16 ++++++++++++++++
> > > >  kernel/sched/core.c   | 11 +++++++++++
> > > >  2 files changed, 27 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index 508b91d57470..d348e886e4d0 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -2096,6 +2096,22 @@ static inline void cond_resched_rcu(void)
> > > >  #endif
> > > >  }
> > > >
> > > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > > +
> > > > +extern bool preempt_mode_none(void);
> > > > +extern bool preempt_mode_voluntary(void);
> > > > +extern bool preempt_mode_full(void);
> > > > +
> > > > +#else
> > > > +
> > > > +#define preempt_mode_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> > > > +#define preempt_mode_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> > > > +#define preempt_mode_full() IS_ENABLED(CONFIG_PREEMPT)
> > > > +
> > >
> > > Shame this was somehow forgotten.
> > > There was a v3 of this patch that fixed a bunch of things (e.g. making
> > > these proper functions so all builds error if accidentally used in
> > > #if).
> > >
> > > https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/
> > >
> > > Is it also possible to take all the rest of that series (all 4
> > > patches) from Valentin?
> >
> > Me, I am assuming that #2/3 is an experimental test so that I am able
> > to easily whack this series over the head with rcutorture.  ;-)
> 
> I might be out of the loop here. All I can add is that any issues that
> are a consequence of the preempt mode accessors are only testable if
> the preemption model is actually changed at runtime and AFAIK
> rcutorture doesn't do that. But as noted, this patch wasn't the latest
> version and there were issues with it fixed by Valentin's latest v3
> (from November, but had never been picked up anywhere).

I will be marking 2/3 "EXP" to prevent myself from accidentally sending
it upstream.

But longer term, maybe I should pick up Valentin's series.

This stuff is v5.19 at the earliest, so not (yet) urgent.

							Thanx, Paul
