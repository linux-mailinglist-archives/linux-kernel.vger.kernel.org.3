Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6695570F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377857AbiFWCQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377670AbiFWCQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:16:15 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B233EA4;
        Wed, 22 Jun 2022 19:16:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g18so20473614qvn.2;
        Wed, 22 Jun 2022 19:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0RzZUs4DRyzqLDhWgvnn0ajCNG8lGHnivgaAxKe1uio=;
        b=pLVkZpUYa2PjzsK6rh9EGtGT/MlpUF4i8C4d0PJBlXq48bHl3+nyWHso0DiaGta+2V
         VItuaQ2KAY55at7U+K3ii7Q2kuKpa3nRhPRl6PYxJA6CAlR58+pVGpSLWL0kTOyyTa29
         cCkteATVL8D8vGrKCkWhB+fgUpXyyrc/tQ69MoOo60TRvXCjxLewlsLENHPTG2XoC8cr
         3lkmeUnt8NoBco5X0rJMszsdoW2RNFnZqyo+1feMnnjcqHz8vw7deBJfdktC+h1ux5Uq
         4+QkyFvFOP/EQ7sAB7vi5TOXcEN/xnYdfEXqTyawmVtL/9i0JZMqFVZJcWxucKpMVXi2
         Q3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0RzZUs4DRyzqLDhWgvnn0ajCNG8lGHnivgaAxKe1uio=;
        b=bYVSBw7amqvMU/kzuTkUEFl42+nxVU/9xhpAd0lNxnaXURweVFHMH7SsPKcqoxuwup
         se3slHqKYEgw0hYAI3Wf0kA28iNPbwkNaSVS/aw3rBUfndVjiHAGeEu4l9ZWv6GaJp/M
         lB6JMfUtB4yFdTc8xO1Pw3YDigPfKsT1JKdQFlDdRzXeUcCNVojD+Ze8mzX1QZiPiufQ
         GlV1eg8HArEi1Nr9cJrrYhpp9EwPh95vGcEDOjp8zUbZhURrZ68l37lO00DaiQyuqSUc
         yFKSip3bZFNBHwnkSYilztdIsMZzU+35t412JzFDcC1+BU07KNY8XlmYZB1BrrqiIaB6
         eldg==
X-Gm-Message-State: AJIora81yaWNLnZisxXVrcWVzVaAnnOm/XWeuaSxVT+xnzM/GoP+dNQL
        LFqwhh7PxMfTdMyNJnkrbNY=
X-Google-Smtp-Source: AGRyM1sp5vDkUtAZeNpKzcbh50MXSxop7TB8yBqxeJRPTmxFsqKp1sWJjWlA2ebHQ7eJhL8W8X+HHQ==
X-Received: by 2002:a05:6214:508d:b0:470:4fca:c95e with SMTP id kk13-20020a056214508d00b004704fcac95emr11830096qvb.101.1655950573153;
        Wed, 22 Jun 2022 19:16:13 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c21-20020ac87dd5000000b00315a5fa4bf6sm2611870qte.7.2022.06.22.19.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:16:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 173EA27C0054;
        Wed, 22 Jun 2022 22:16:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Jun 2022 22:16:12 -0400
X-ME-Sender: <xms:68yzYpoJssUTQVATOyGvrs9cCUYZN6qha6kmy_aY_n-emOR4HDOPVA>
    <xme:68yzYrqOXM-OX4V7TCCICcqZcPQzYX3pA7UB_4HmuwmaAT-0wcadRmC71zDEe4ZyG
    VT-ObgqXnlSCUjJLg>
X-ME-Received: <xmr:68yzYmM5fEnZzQD64UcS-PvObsbhtlDnk9TnaffxlVV14fex5W7HgJIMFZRsoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:68yzYk7NmuupSt8hECHPBm3HULCFJlAEmcTxI22CjMR0pohYpL1ORw>
    <xmx:68yzYo5CiYnGkP7RUqZsACSkMFcUObGPTVB80ed2h9HCh_v4HtzL9Q>
    <xmx:68yzYsiGC-FInQ2WRr5imr5ROZuY3kZIaHQdgn9WmMZJACx3snsVAg>
    <xmx:68yzYiQdGNKVc17wiXku-otqHfv8zBLupUcvoACXT2W4qhOuQFKyYQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 22:16:11 -0400 (EDT)
Date:   Wed, 22 Jun 2022 19:15:58 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Message-ID: <YrPM3ub+BGukLi+l@boqun-archlinux>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:34:09PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 22, 2022 at 11:34:15PM +0000, Zhang, Qiang1 wrote:
> > 
> > On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> > > In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
> > > grace period begins, if detected current CPU enters idle in
> > > rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> > > current cpu, at this time, maybe not being in an RCU read-side critical
> > > section, but need wait until rcu-softirq or sched-clock irq or sched-switch
> > > occurs on current CPU to check and report exp QS.
> > > 
> > 
> > >I think the idea is OK, however, this "optimization" is based on the
> > >implementation detail that rcu_read_lock() counts preempt_count when
> > >CONFIG_PREEMPT_COUNT=y, right? It's a little bit dangerous because the
> > >preempt_count when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n is mostly
> > >for debugging purposes IIUC, and in other words, _it could be gone_.
> > >
> > 
> > Yes, for CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n kernel
> > The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and the 
> > preempt-count is exists,  so can report exp QS when not being an  RCU 
> > read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )return zero).
> > in IPI handler. 
> > 
> > For CONFIG_PREEMPT_COUNT=n and CONFIG_PREEMPT=n kernel, 
> > The rcu_read_lock/unlock is just barrier(). 
> > 
> > 
> > So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.
> > 
> > Of course, for CONFIG_PREEMPT_COUNT=n  kernel, in RCU softirq, the 
> > preempt-count is also checked
> > 
> > /* Report any deferred quiescent states if preemption enabled. */
> >  if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
> >                  rcu_preempt_deferred_qs(current);
> > 
> > but the RCU softirq may not be triggered in time and reported exp QS, for
> > example a kernel loop exist on NO_HZ_FULL CPU
> > 
> > this change, It is to capture the exp QS state earlier and report it.
> > 
> > 
> > >Also I'm not aware of any but there could be someone assuming that RCU
> > >read-side critical sections can be formed without
> > >rcu_read_{lock,unlock}() in CONFIG_PREEMPT=n kernel. For example, there
> > >might be "creative" code like the following:
> > >
> > >	void do_something_only_in_nonpreempt(void)
> > >	{
> > >		int *p;
> > >
> > >		// This function only gets called in PREEMPT=n kernel,
> > >		// which means everywhere is a RCU read-side critical
> > >		// section, let's save some lines of code.
> > >
> > 		rcu_read_lock();
> > >		p = rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
> > >		... // of course no schedule() here.
> > >		<access p>
> >                              rcu_read_unlock();
> > >	}
> > >
> > 
> > Usually access to pointers of type rcu needs to be protected.

Yes, _ususally_ they are, but what about the special cases? Because
in PREEMPT=n kernel, almost everywhere is a RCU read-side critical
section, some one might have been "creative" enough to omit these
rcu_read_lock() and rcu_read_unlock().

> 
> Indeed, lockdep would normally complain about this sort of thing.
> But in kernels built with (say) CONFIG_PREEMPT_NONE=y but without
> CONFIG_PREEMPT_COUNT=N, can lockdep really tell the difference?
> 

Actually with the rcu_dereference_check() above, lockdep cannot detect
even CONFIG_PREEMPT_COUNT=y, that rcu_dereference_check() basically says
"I know I'm in a read-side critical section if it's a non-preempt
kernel, so don't bother to check". ;-)

> > Any thoughts?
> 
> It would be good to have some performance data on this change to expedited
> grace periods.  It is adding code, so it needs some real motivation.

Agreed.

Regards,
Boqun

> So, does this change make a system-level difference in (say) expedited
> RCU grace-period latency, and if so, under what conditions?
> 
> 						Thanx, Paul
> 
> > >Again, I'm not aware of any existing code that does this but we need to
> > >be sure.
> > >
> > >Regards,
> > >Boqun
> > >
> > > This commit add a exp QS check in rcu_exp_handler(), when not being
> > > in an RCU read-side critical section, report exp QS earlier.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tree_exp.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index be667583a554..34f08267410f 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  	struct rcu_node *rnp = rdp->mynode;
> > > +	bool preempt_bh_disabled =
> > > +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> > >  
> > >  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> > >  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
> > >  		return;
> > > -	if (rcu_is_cpu_rrupt_from_idle()) {
> > > +	if (rcu_is_cpu_rrupt_from_idle() ||
> > > +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
> > >  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
> > >  		return;
> > >  	}
> > > -- 
> > > 2.25.1
> > > 
