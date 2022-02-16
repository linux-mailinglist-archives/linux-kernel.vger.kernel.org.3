Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E84B9100
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiBPTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:07:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiBPTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:07:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AD29CB1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1F5BB81FBE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE32C004E1;
        Wed, 16 Feb 2022 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645038420;
        bh=O6rg2EA0mmSpBoicY2+Pis/uzSG9J5E6UibqILOjyKw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LOf5dpqk49yNupWbhM4D9S7tOGpeM38BEzumCRrduLE79xfb93b/4OpN4bMO3T9fj
         SIKBTAWJEez+QFt2krProHGJPtVLZy8+vfg/M4Ll6JEc5UZawZ1N8USk6Ko5qBcXae
         TvSwSfJTko/mQdZHuicQnnGN3pM1+VlbVNm2DRpOOMm6KmNVEyTDJwRniCi6kP9nXC
         nNO9R4pgVHJaYKf8uEa/dW/H5DaQEPUs7RNhvcWeXjLMpWuAMacFSNrq8719AfbuJd
         4xIsmr6bcuexOQZJDk2Dzb61DpCID4xMhmZ8ydIKGpiNj43A813e2naZPGRgYGptqU
         zHjsk43fRadVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33F275C064D; Wed, 16 Feb 2022 11:07:00 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:07:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] workqueue: Fix race in schedule and flush work
Message-ID: <20220216190700.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220210184319.25009-1-treasure4paddy@gmail.com>
 <Ygqw+EHo//6VGs6q@slm.duckdns.org>
 <20220216184939.GA3868@pswork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216184939.GA3868@pswork>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 07:49:39PM +0100, Padmanabha Srinivasaiah wrote:
> On Mon, Feb 14, 2022 at 09:43:52AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 33f1106b4f99..a3f53f859e9d 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -3326,28 +3326,38 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
> > >   */
> > >  int schedule_on_each_cpu(work_func_t func)
> > >  {
> > > -	int cpu;
> > >  	struct work_struct __percpu *works;
> > > +	cpumask_var_t sched_cpumask;
> > > +	int cpu, ret = 0;
> > >  
> > > -	works = alloc_percpu(struct work_struct);
> > > -	if (!works)
> > > +	if (!alloc_cpumask_var(&sched_cpumask, GFP_KERNEL))
> > >  		return -ENOMEM;
> > >  
> > > +	works = alloc_percpu(struct work_struct);
> > > +	if (!works) {
> > > +		ret = -ENOMEM;
> > > +		goto free_cpumask;
> > > +	}
> > > +
> > >  	cpus_read_lock();
> > >  
> > > -	for_each_online_cpu(cpu) {
> > > +	cpumask_copy(sched_cpumask, cpu_online_mask);
> > > +	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask) {
> > 
> > This definitely would need a comment explaining what's going on cuz it looks
> > weird to be copying the cpumask which is supposed to stay stable due to the
> > cpus_read_lock().Given that it can only happen during early boot and the
> > online cpus can only be expanding, maybe just add sth like:
> > 
> >         if (early_during_boot) {
> >                 for_each_possible_cpu(cpu)
> >                         INIT_WORK(per_cpu_ptr(works, cpu), func);
> >         }
> > 
> 
> Thanks tejun for the reply and suggestions.
> 
> Yes, unfortunately cpus_read_lock not keeping cpumask stable at
> secondary boot. Not sure, may be it only gurantee 'cpu' dont go down
> under cpus_read_[lock/unlock].
> 
> As suggested will tryout something like:
> 	if (system_state != RUNNING) {
> 		:
> 	}
> > BTW, who's calling schedule_on_each_cpu() that early during boot. It makes
> > no sense to do this while the cpumasks can't be stabilized.
> >
> It is  implemenation of CONFIG_TASKS_RUDE_RCU.

Another option would be to adjust CONFIG_TASKS_RUDE_RCU based on where
things are in the boot process.  For example:

	// Wait for one rude RCU-tasks grace period.
	static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
	{
		if (num_online_cpus() <= 1)
			return;  // Fastpath for only one CPU.
		rtp->n_ipis += cpumask_weight(cpu_online_mask);
		schedule_on_each_cpu(rcu_tasks_be_rude);
	}

Easy enough either way!

							Thanx, Paul
