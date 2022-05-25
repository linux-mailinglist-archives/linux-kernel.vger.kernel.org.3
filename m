Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729EA533EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiEYOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbiEYOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D908C6E67;
        Wed, 25 May 2022 07:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B0461917;
        Wed, 25 May 2022 14:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D35C385B8;
        Wed, 25 May 2022 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653487409;
        bh=l5kWhYSM4ve8ORITaw5DdUYn/ri7Dxo2vsMbyi4/aU0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g532N1MUaTCynWSV4XQ2Wp5b4npysDBjQgb6shWf0YfqjT+xKFDexMc29SbobYni3
         TpHC0zfKAiS2B3H16WdvYBuKEylKHuAFL1C4g+ysx+kFNXQPbFyCvKyqrf1VckTPpK
         JEwtNFcLseANyNjPvJ3n/Ca5lWdNUsQJ9Jp52sfIEHpWtZUW0amlBWuWajlzcfJrjD
         rB4n6s4zYSUBxCdRFQaRKfsHXmerj5pmLkFMHKO3VA9++qiYTh7JRPp4IHy+wn/2XK
         vPDeGxMJ9Ua7CQgKYdA3z0tDPsO707mrX3XWMCpfb0yNG7cU3/i9u2krvWLNDfDaAH
         rjE3M+x2wuFwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C46885C018D; Wed, 25 May 2022 07:03:28 -0700 (PDT)
Date:   Wed, 25 May 2022 07:03:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add rnp->expmask output to show_rcu_gp_kthreads()
Message-ID: <20220525140328.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220525044503.2083630-1-qiang1.zhang@intel.com>
 <e531081f-4871-5292-6a31-782fa7228788@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e531081f-4871-5292-6a31-782fa7228788@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 10:29:23AM +0530, Mukesh Ojha wrote:
> 
> 
> On 5/25/2022 10:15 AM, Zqiang wrote:
> > Currently, for expedited rcu we only check 'rnp->exp_tasks', however
> > the 'rnp->exp_tasks' are not always exist for expedited grace period
> > that not end. this commit add 'rnp->expmask' condition.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Thanks !! for the patch.
> Commit log could require wordsmith from Paul :-)

For Paul to wordsmith this commit log, he must first understand why this
change is useful, keeping in mind that show_rcu_gp_kthreads() is invoked
for normal grace periods, but not for expedited ones.

The point of ->exp_mask for debugging forward-progress issues for normal
grace periods is to understand why tasks blocking the current normal
grace period are not yet being boosted (because the expedited grace
period's boosting takes precedence).  How do these additions help you?

(Not saying that they cannot possibly help you.  I am instead saying
that you must tell me how they have helped you guys.)

							Thanx, Paul

> Reviewed-by: quic_mojha@quicinc.com
> 
> -Mukesh
> 
> > ---
> >   kernel/rcu/tree_stall.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 2464b0eccfd0..5c4df855f2ac 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -865,13 +865,15 @@ void show_rcu_gp_kthreads(void)
> >   	rcu_for_each_node_breadth_first(rnp) {
> >   		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
> >   		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
> > -		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
> > +		    !data_race(READ_ONCE(rnp->expmask)) && !data_race(READ_ONCE(rnp->exp_tasks)) &&
> > +			!data_race(READ_ONCE(rnp->gp_tasks)))
> >   			continue;
> > -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> > +		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx ->expmask %#lx %c%c%c%c ->n_boosts %ld\n",
> >   			rnp->grplo, rnp->grphi,
> >   			(long)data_race(READ_ONCE(rnp->gp_seq)),
> >   			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> >   			data_race(READ_ONCE(rnp->qsmask)),
> > +			data_race(READ_ONCE(rnp->expmask)),
> >   			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> >   			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> >   			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
