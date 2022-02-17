Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A84BA491
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbiBQPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:39:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiBQPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:39:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78592B2E15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk11so8273831ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uspxbZfUGmLZDlE0gtJUW5Kh7h6indLorBvrarnojYo=;
        b=LbHf2tUeiPA9VAaV2oyKy6s/qf++ZBc9tR4kBx2n/xEEOsNvfXY8t6ej1mkSkeCZTr
         91lkrKUYCK23FnWIz7uxygfsUc4Blu/ukIefDhxo5Oj3r6gIlbqW3QOIhHnnUoVRitcF
         0KvxuHeyebdEnZ4CFso2exgstaCYM9NoT3xVaZz4m+0rZFk6MUH+tvQJn0JJvqZBGjYz
         kI0UHEZ3s18eFtk7fSZI1Nw+m8HRwsj6gVsRLieQmty9pjLXNU+KJUClATF1A9johMdA
         TmCQYsXQs1NLpgFcsmre7dM10mSR6mmZOgcXwM4SLUp1n0iMRROY2BmqwVHk7inbsBWW
         I70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uspxbZfUGmLZDlE0gtJUW5Kh7h6indLorBvrarnojYo=;
        b=cTuwEGF+u6oqAV1BB1JgApoEaZ7eJ6N6RDGT3SN9N8rSCXhIAHFV5GUgbQPBHXu46g
         ddK50jGv14gsVL/CPzAtLJXAVCr+h3bW7/Rr4Jo4HomCafXY36CzWV6QMUnSw64AOuqV
         D9/SQD+7zjEWpKdca1D8kPiwATE4sxSDqaZYjuCY1qSDM1UM2z11Wy1kMsD/8sAZ02OQ
         tBmgSZHphjL8rDv2ZDRwNuGfzh1NhQdit0e17a3g7lQCyb0KgikLNH7blh6mWfcpw0UN
         Vlq2e6M0NFVOm7E3tfw+aJGIDzrg5/1D3PGoTpS7etCzSko+8DGhHPo6WBywjfwQ7k1w
         0q4A==
X-Gm-Message-State: AOAM531jYuVrOOw5R4Y83qDmrEJ2DxWbdbesicoaa1jeq4yRtPIVypju
        wND8OhryxUJG/phF51V06fLF9OngPhyj13Dc8X8=
X-Google-Smtp-Source: ABdhPJwE2PjbQh76F0bG1uOct/j454LN1UJHA2GX7cM+2m49H88k00K2BzREIbtAVph9YhPD3VN5xw==
X-Received: by 2002:a17:906:2695:b0:6cf:e1b4:118b with SMTP id t21-20020a170906269500b006cfe1b4118bmr2866493ejc.348.1645112365145;
        Thu, 17 Feb 2022 07:39:25 -0800 (PST)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id f29sm1318153ejl.12.2022.02.17.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:39:24 -0800 (PST)
Date:   Thu, 17 Feb 2022 16:39:24 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] workqueue: Fix race in schedule and flush work
Message-ID: <20220217153924.GA19121@pswork>
References: <20220210184319.25009-1-treasure4paddy@gmail.com>
 <Ygqw+EHo//6VGs6q@slm.duckdns.org>
 <20220216184939.GA3868@pswork>
 <20220216190700.GL4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216190700.GL4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:07:00AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 16, 2022 at 07:49:39PM +0100, Padmanabha Srinivasaiah wrote:
> > On Mon, Feb 14, 2022 at 09:43:52AM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > > index 33f1106b4f99..a3f53f859e9d 100644
> > > > --- a/kernel/workqueue.c
> > > > +++ b/kernel/workqueue.c
> > > > @@ -3326,28 +3326,38 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
> > > >   */
> > > >  int schedule_on_each_cpu(work_func_t func)
> > > >  {
> > > > -	int cpu;
> > > >  	struct work_struct __percpu *works;
> > > > +	cpumask_var_t sched_cpumask;
> > > > +	int cpu, ret = 0;
> > > >  
> > > > -	works = alloc_percpu(struct work_struct);
> > > > -	if (!works)
> > > > +	if (!alloc_cpumask_var(&sched_cpumask, GFP_KERNEL))
> > > >  		return -ENOMEM;
> > > >  
> > > > +	works = alloc_percpu(struct work_struct);
> > > > +	if (!works) {
> > > > +		ret = -ENOMEM;
> > > > +		goto free_cpumask;
> > > > +	}
> > > > +
> > > >  	cpus_read_lock();
> > > >  
> > > > -	for_each_online_cpu(cpu) {
> > > > +	cpumask_copy(sched_cpumask, cpu_online_mask);
> > > > +	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask) {
> > > 
> > > This definitely would need a comment explaining what's going on cuz it looks
> > > weird to be copying the cpumask which is supposed to stay stable due to the
> > > cpus_read_lock().Given that it can only happen during early boot and the
> > > online cpus can only be expanding, maybe just add sth like:
> > > 
> > >         if (early_during_boot) {
> > >                 for_each_possible_cpu(cpu)
> > >                         INIT_WORK(per_cpu_ptr(works, cpu), func);
> > >         }
> > > 
> > 
> > Thanks tejun for the reply and suggestions.
> > 
> > Yes, unfortunately cpus_read_lock not keeping cpumask stable at
> > secondary boot. Not sure, may be it only gurantee 'cpu' dont go down
> > under cpus_read_[lock/unlock].
> > 
> > As suggested will tryout something like:
> > 	if (system_state != RUNNING) {
> > 		:
> > 	}
> > > BTW, who's calling schedule_on_each_cpu() that early during boot. It makes
> > > no sense to do this while the cpumasks can't be stabilized.
> > >
> > It is  implemenation of CONFIG_TASKS_RUDE_RCU.
> 
> Another option would be to adjust CONFIG_TASKS_RUDE_RCU based on where
> things are in the boot process.  For example:
> 
> 	// Wait for one rude RCU-tasks grace period.
> 	static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> 	{
> 		if (num_online_cpus() <= 1)
> 			return;  // Fastpath for only one CPU.
> 		rtp->n_ipis += cpumask_weight(cpu_online_mask);
> 		schedule_on_each_cpu(rcu_tasks_be_rude);
> 	}
> 
> Easy enough either way!
> 
> 							Thanx, Paul

Thank you Paul for suggestion, tried same and it fixes the issue.
Have submitted same as suggested-by Paul.

Link :
https://lore.kernel.org/all/20220217152520.18972-1-treasure4paddy@gmail.com/T/#t
