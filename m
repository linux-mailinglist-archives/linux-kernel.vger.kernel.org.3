Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720B553AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354052AbiFUTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbiFUTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:36:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE292D1D0;
        Tue, 21 Jun 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0BE0CE1C1F;
        Tue, 21 Jun 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0076AC341C4;
        Tue, 21 Jun 2022 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655840201;
        bh=/fhO8DKOPNqPlZBEyqMbHF7H/mKy0R9KV9oyQ1GuVeM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=he2Za5EBD/5TYylCuV5tsn3rzYx4ZTNI9Vw3J556c18n/dhFyh2bGZZ0/rFMNQCQC
         0oUWBhtdFJAmRsiOz4aInOhQ0t/RybZ/YA1R1+Ap0V5/mkRsxvGTXzzb1EqeoJgmw1
         eCL2WiVJdMp+YvrnQPHTcOUE2ABoJscI9GeCh53IdT9luyTWu+k+nqKFTmb/uvC/uy
         mM3MCJ3aumWB1UljHJmgcmlHELtHVm9CtzJ0giiwKnDr5V2pl1Z3wdpDTBfKzr1DDD
         kW9IQmru1yithHauxeBYf/p7Wb1/TOfGRlSsg3pJAJ+yRkNQ8Ehxwq6qhvVQn1sZ4Q
         g54LuYWML2jbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 936E45C0500; Tue, 21 Jun 2022 12:36:40 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:36:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Message-ID: <20220621193640.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
 <fef4fbd55b88481490d52cbd65e1b1f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef4fbd55b88481490d52cbd65e1b1f8@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 07:43:08AM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Paul E. McKenney [mailto:paulmck@kernel.org]
> > Sent: 20 June 2022 23:21
> > To: rcu@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; kernel-team@fb.com;
> > rostedt@goodmis.org; Paul E. McKenney <paulmck@kernel.org>; Zhangfei
> > Gao <zhangfei.gao@linaro.org>; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH rcu 12/12] srcu: Block less aggressively for expedited grace
> > periods
> > 
> > Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > from consuming CPU") fixed a problem where a long-running expedited
> > SRCU
> > grace period could block kernel live patching.  It did so by giving up
> > on expediting once a given SRCU expedited grace period grew too old.
> > 
> > Unfortunately, this added excessive delays to boots of embedded systems
> > running on qemu that use the ARM IORT RMR feature. 
> 
> As pointed out here[0]/[1], this delay has nothing to do with ARM IORT RMR
> feature. The delay is due to the "-bios QEMU_EFI.fd" line which emulates flash
> devices and requires excessive memslot ops during boot.

Good eyes, and I will update.

Are we stuck with the excessive memslot ops?  If not, great.

If we are stuck with them, there probably needs to be a way of adjusting
the SRCU delay parameters.  Making "-bios QEMU_EFI.fd" go quickly seems
to require quite a bit of spinning, more than is likely to be helpful
in general.

							Thanx, Paul

> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/all/110bbec5cee74efba0aad64360069a12@huawei.com/
> [1] https://lore.kernel.org/all/8735g649ew.wl-maz@kernel.org/
> 
> 
>  This commit
> > therefore
> > makes the transition away from expediting less aggressive, increasing
> > the per-grace-period phase number of non-sleeping polls of readers from
> > one to three and increasing the required grace-period age from one jiffy
> > (actually from zero to one jiffies) to two jiffies (actually from one
> > to two jiffies).
> > 
> > Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > from consuming CPU")
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
> > Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Link:
> > https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro
> > .org/
> > ---
> >  kernel/rcu/srcutree.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 50ba70f019dea..0db7873f4e95b 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct
> > *ssp)
> > 
> >  #define SRCU_INTERVAL		1	// Base delay if no expedited GPs
> > pending.
> >  #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from
> > slow readers.
> > -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase
> > consecutive no-delay instances.
> > +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase
> > consecutive no-delay instances.
> >  #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay
> > instances.
> > 
> >  /*
> > @@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct
> > *ssp)
> >   */
> >  static unsigned long srcu_get_delay(struct srcu_struct *ssp)
> >  {
> > +	unsigned long gpstart;
> > +	unsigned long j;
> >  	unsigned long jbase = SRCU_INTERVAL;
> > 
> >  	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
> > READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> >  		jbase = 0;
> > -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> > -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> > -	if (!jbase) {
> > -		WRITE_ONCE(ssp->srcu_n_exp_nodelay,
> > READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > -		if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
> > SRCU_MAX_NODELAY_PHASE)
> > -			jbase = 1;
> > +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> > +		j = jiffies - 1;
> > +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> > +		if (time_after(j, gpstart))
> > +			jbase += j - gpstart;
> > +		if (!jbase) {
> > +			WRITE_ONCE(ssp->srcu_n_exp_nodelay,
> > READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
> > SRCU_MAX_NODELAY_PHASE)
> > +				jbase = 1;
> > +		}
> >  	}
> >  	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
> >  }
> > --
> > 2.31.1.189.g2e36527f23
> 
