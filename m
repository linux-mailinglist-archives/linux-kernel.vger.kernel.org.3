Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B085B0840
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIGPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIGPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224BF2528C;
        Wed,  7 Sep 2022 08:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D0661987;
        Wed,  7 Sep 2022 15:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDDFC433D7;
        Wed,  7 Sep 2022 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662563690;
        bh=5AbubiYwxEPaLYyJ/ZkHFOYsZR8C3QQzlzKNYzwGstw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svJ/p1fBjlhUuC3NjkkkOnG0a5mN5dGvdkQVPSjacIqDu0UiuvDxvN6B5A/37TDUG
         M/e8UF/yY8zUN+v2oVpcOsXGBgszGMl1dXtpoQUelWvfuSZe29bB45/TIa5lnAMoyW
         VQujbw8IRuRNL0+KYgj0sGD+wu3OJx/NMuG16SyYedMgwVgS/hBO9rQLnO4m5BNegO
         huIPnOAR/si2YsCBjSWfTF8p9gJapGzpDGp+qDEA25qZ9FXL3q+JZaYCIphSL5J7Po
         Iz27/Mxawf9g+NXhPzFu5CmuuKtkt4O3yiAPSuQFvWkApsiAg4DtuJPN9CN14rLKPD
         sbkbAv8Qy2hSw==
Date:   Wed, 7 Sep 2022 17:14:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 03/10] rcu: Add QS check in rcu_exp_handler() for
 non-preemptible kernels
Message-ID: <20220907151447.GA198228@lothringen>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
 <20220831180805.2693546-3-paulmck@kernel.org>
 <20220907121010.GA196513@lothringen>
 <20220907145759.GJ4315@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907145759.GJ4315@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:57:59AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 07, 2022 at 02:10:10PM +0200, Frederic Weisbecker wrote:
> > On Wed, Aug 31, 2022 at 11:07:58AM -0700, Paul E. McKenney wrote:
> > > From: Zqiang <qiang1.zhang@intel.com>
> > > 
> > > Kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y maintain
> > > preempt_count() state.  Because such kernels map __rcu_read_lock()
> > > and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
> > > respectively, this allows the expedited grace period's !CONFIG_PREEMPT_RCU
> > > version of the rcu_exp_handler() IPI handler function to use
> > > preempt_count() to detect quiescent states.
> > > 
> > > This preempt_count() usage might seem to risk failures due to
> > > use of implicit RCU readers in portions of the kernel under #ifndef
> > > CONFIG_PREEMPTION, except that rcu_core() already disallows such implicit
> > > RCU readers.  The moral of this story is that you must use explicit
> > > read-side markings such as rcu_read_lock() or preempt_disable() even if
> > > the code knows that this kernel does not support preemption.
> > > 
> > > This commit therefore adds a preempt_count()-based check for a quiescent
> > > state in the !CONFIG_PREEMPT_RCU version of the rcu_exp_handler()
> > > function for kernels built with CONFIG_PREEMPT_COUNT=y, reporting an
> > > immediate quiescent state when the interrupted code had both preemption
> > > and softirqs enabled.
> > > 
> > > This change results in about a 2% reduction in expedited grace-period
> > > latency in kernels built with both CONFIG_PREEMPT_RCU=n and
> > > CONFIG_PREEMPT_COUNT=y.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Link: https://lore.kernel.org/all/20220622103549.2840087-1-qiang1.zhang@intel.com/
> > > ---
> > >  kernel/rcu/tree_exp.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index be667583a5547..b07998159d1fa 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -828,11 +828,13 @@ static void rcu_exp_handler(void *unused)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  	struct rcu_node *rnp = rdp->mynode;
> > > +	bool preempt_bh_enabled = !(preempt_count() & (PREEMPT_MASK |
> > > SOFTIRQ_MASK));
> > 
> > I don't know if nested hardirqs still exist. I only heard old rumours
> > about broken drivers. Should we take care of them?
> 
> Last I checked, certain tracing scenarios from irq handlers looked
> to RCU like nested irq handlers.  Given that, does your more robust
> approach below work correctly?

I haven't observed that but in any case, the check I propose
is more strict than the one on this patch. So in the worst case it's
a QS not reported if a nested interrupt is detected.

Thanks.
