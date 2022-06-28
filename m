Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63955C5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiF1Ak1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiF1Ak0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030CB87C;
        Mon, 27 Jun 2022 17:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D526167A;
        Tue, 28 Jun 2022 00:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA2C341CB;
        Tue, 28 Jun 2022 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656376824;
        bh=PYURXyOC61SbNd6M9ALE5BUtZigWS+giqv1tDWkV7wk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A4C6qfzkuJGrEZyOD5RfvJctZmmyHuE8XlBVPsV8aXGP5oTPgDECnz+1eX/nopTEI
         TZtEXDH1Bl3I2HpvBPXaOI1K2uNXBXSz+iP16YkukqSSEE6096SDhdfTBm2o+kHpFq
         ORQEsyfL2TLsMUH6vKymeEu5oqu8IADUCAjJ6JwWYkfK+iQX3xr5jIPX3MPg6CnS2E
         /LrckR3ZCBdZDGck0spWPVl+JvyC3BCVozW0j80XHDyRTd/LOSbBODgF+v93HfTO6S
         J2tRLBpyvU7fWCk63/sSq4vsaM1aK8FmztZ5KiIFZUgwzfNoRC9s+BvcNTCTq/ld/p
         KZZKGGTknIYeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D507B5C04B1; Mon, 27 Jun 2022 17:40:22 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:40:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Message-ID: <20220628004022.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
 <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B496CB57A804B95977A9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880B496CB57A804B95977A9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:31:12AM +0000, Zhang, Qiang1 wrote:
> > 
> > Add Cc 
> > 
> > Currently, the sync_sched_exp_online_cleanup() is invoked in
> > cpuhp per-cpu kthreads when CPU is going online, so the CPU id
> > obtained by get_cpu() should always be equal to the CPU id of
> > the passed parameter, that is to say, the smp_call_function_single()
> > never be invoked, if be invoked, there may be problem with cpu-hotplug,
> > this commit add WARN_ON_ONCE() to remind everyone.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_exp.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index be667583a554..ae8dcfd4486c 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
> >  		put_cpu();
> >  		return;
> >  	}
> > +
> > +	WARN_ON_ONCE(my_cpu != cpu);
> 
> >If we are going to add this sort of warning, why not instead add it
> >to rcutree_online_cpu()?
> >
> >The reason the warning has not been present is the prospect of concurrent
> >onlining at boot time, which might have rcutree_online_cpu() invoked
> >from CPU 0 for multiple CPUs at boot.  However, the for_each_online_cpu()
> >loop has recently been removed from rcu_init().
> 
> The rcutree_online_cpu() is always invoked in per-cpu cpuhp kthreads, 
> and even if it is called directly through the for_each_online_cpu() loop in
> rcu_init(), since the rcu_init() takes precedence over smp initialization,
> only the CPU0 is online at this time, still only called on CPU0.

And sync_sched_exp_online_cleanup() is only ever invoked from
rcutree_online_cpu(), correct?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >But I would like to hear what others think.  Would such a warning
> >significantly help debugging?
> >
> >							Thanx, Paul
> >
> >  	/* Quiescent state needed on some other CPU, send IPI. */
> >  	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> >  	put_cpu();
> > -- 
> > 2.25.1
> > 
