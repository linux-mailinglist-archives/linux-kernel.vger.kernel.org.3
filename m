Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38D4D8DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiCNUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244964AbiCNUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C240A28
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1449561243
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5ACC340E9;
        Mon, 14 Mar 2022 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647288401;
        bh=DOHt3LCYvGZ+M+llhcPXpvszVirNj9b7Vx1WQLAkF94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AanFG3WOTPvNoEiZcNP6OIPA2FuwI8mElPD56f2ouM3bwPsY2Dr4XPLp6qFsIunUL
         Ox9ujc1OPKbG/whDy+/E1JxWHcUxzlTWO/Ehmvkw1zEkIlnZOq6wDnDOGTX0YizyOs
         OVUzjsz4Av7yQr7vyNMLcRPCbqaFMlzw1Er2cJRycFsOWJStqEVr2XW9e3sOH/PEPV
         hjCNQV6uxQ8020xp3h/Vo8UYB51oBeoTOxerq/5c1bQQWPZ8XLCXSuRvRFi9V6QHd0
         oMo1U50MECs6ZWvioOPQpPImwP9urRn9XNsygUo0E0hYyd4v/7etHfW7ael0Aq/9ng
         3qe5ISqwZOkoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 18CC85C023F; Mon, 14 Mar 2022 13:06:41 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:06:41 -0700
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
Message-ID: <20220314200641.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314133738.269522-3-frederic@kernel.org>
 <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:44:39PM +0100, Marco Elver wrote:
> On Mon, 14 Mar 2022 at 14:37, Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > From: Valentin Schneider <valentin.schneider@arm.com>
> >
> > CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
> > o The build-time preemption model when !PREEMPT_DYNAMIC
> > o The default boot-time preemption model when PREEMPT_DYNAMIC
> >
> > IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
> > model could have been set to something else by the "preempt=foo" cmdline
> > parameter.
> >
> > Introduce a set of helpers to determine the actual preemption mode used by
> > the live kernel.
> >
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > ---
> >  include/linux/sched.h | 16 ++++++++++++++++
> >  kernel/sched/core.c   | 11 +++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 508b91d57470..d348e886e4d0 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2096,6 +2096,22 @@ static inline void cond_resched_rcu(void)
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +
> > +extern bool preempt_mode_none(void);
> > +extern bool preempt_mode_voluntary(void);
> > +extern bool preempt_mode_full(void);
> > +
> > +#else
> > +
> > +#define preempt_mode_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> > +#define preempt_mode_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> > +#define preempt_mode_full() IS_ENABLED(CONFIG_PREEMPT)
> > +
> 
> Shame this was somehow forgotten.
> There was a v3 of this patch that fixed a bunch of things (e.g. making
> these proper functions so all builds error if accidentally used in
> #if).
> 
> https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/
> 
> Is it also possible to take all the rest of that series (all 4
> patches) from Valentin?

Me, I am assuming that #2/3 is an experimental test so that I am able
to easily whack this series over the head with rcutorture.  ;-)

							Thanx, Paul
