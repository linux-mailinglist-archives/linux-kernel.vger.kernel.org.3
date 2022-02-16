Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA17F4B90B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiBPSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBPSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:49:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B82AD677
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:49:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so5505305edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/COvjkXtEZda9jeXezpZm3EMBCJ6hYD5ta53dGN4wSg=;
        b=GGcJ4b7eNFAQu7BjZhNj7Y+qpzoMz+YO6vahcslZQlidY8PCZR2CiKKcPcMiV+yVq8
         pNyidYvGlW74UouySlIBVO3p4EP7oE0hutb+JEapQGUENaFmbrzzHEU/au0QGnU6w7p8
         LH/4GH/Q89gGFZ7nJMF+ly2CEzivONVr9r1xBFzQ0q2nzXBRKEk+7AcEmU8notoJnoU8
         smz9qieaiwOtCWuCqzwawTKO5QcfLdThFAhAjZGMuaIH14UYZ+ZQnlYnK4lWKiyvO1Ho
         m+m39gYnonib0e1dStq61ZX72kVlfK0QedSEsDBQ3gwTcv7tuI5JJmmoRHxjI+HcgTUE
         N88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/COvjkXtEZda9jeXezpZm3EMBCJ6hYD5ta53dGN4wSg=;
        b=xexYoQJMZqHhcJkBi21jH4SqxwA2H1Dy9WSkH3gxg+D/rDLGUe2g8vX6+r0lwW6w1N
         apmvoOfRh4DC5wDPfyb1nB2acKz+xq8kn02PoawXAYYWJgpTC1V1WTdsi0X78oL9PJFA
         20HohvfRvcJaFs5zZOa0SazUeHqfHLNhryTUWfyMMzWkmmdODwy0yP27THouBptrVlkO
         m2owlJSLMbKobscp3qbiZQsWWB9bj9YHNTRZduenQILjl6JwObMywtY2oorDnHpWoop9
         pzxqeBvfv3XuTKQfdYBpjc+btB36mHsAweIQnwHF3lzBlfF7qJtzi3f7ooppg7nJz1jo
         hw6Q==
X-Gm-Message-State: AOAM5315dcoijcVZbbhZiu4f4XVE6uRH2YTinVzLkM37wtvmEiooJQlS
        36aOvVJQ3CNCpe+0DfBsXIo=
X-Google-Smtp-Source: ABdhPJx041ZxjVCiSN74SkQP9Cu0BVADSNROH7zpshOsvMs5rKZ0JRbTt+5ScQ6YNIEG8907DKCBdQ==
X-Received: by 2002:a50:e081:0:b0:401:8823:c9a8 with SMTP id f1-20020a50e081000000b004018823c9a8mr4459340edl.401.1645037380512;
        Wed, 16 Feb 2022 10:49:40 -0800 (PST)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id m27sm214038ejn.134.2022.02.16.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:49:40 -0800 (PST)
Date:   Wed, 16 Feb 2022 19:49:39 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] workqueue: Fix race in schedule and flush work
Message-ID: <20220216184939.GA3868@pswork>
References: <20220210184319.25009-1-treasure4paddy@gmail.com>
 <Ygqw+EHo//6VGs6q@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygqw+EHo//6VGs6q@slm.duckdns.org>
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

On Mon, Feb 14, 2022 at 09:43:52AM -1000, Tejun Heo wrote:
> Hello,
> 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 33f1106b4f99..a3f53f859e9d 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -3326,28 +3326,38 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
> >   */
> >  int schedule_on_each_cpu(work_func_t func)
> >  {
> > -	int cpu;
> >  	struct work_struct __percpu *works;
> > +	cpumask_var_t sched_cpumask;
> > +	int cpu, ret = 0;
> >  
> > -	works = alloc_percpu(struct work_struct);
> > -	if (!works)
> > +	if (!alloc_cpumask_var(&sched_cpumask, GFP_KERNEL))
> >  		return -ENOMEM;
> >  
> > +	works = alloc_percpu(struct work_struct);
> > +	if (!works) {
> > +		ret = -ENOMEM;
> > +		goto free_cpumask;
> > +	}
> > +
> >  	cpus_read_lock();
> >  
> > -	for_each_online_cpu(cpu) {
> > +	cpumask_copy(sched_cpumask, cpu_online_mask);
> > +	for_each_cpu_and(cpu, sched_cpumask, cpu_online_mask) {
> 
> This definitely would need a comment explaining what's going on cuz it looks
> weird to be copying the cpumask which is supposed to stay stable due to the
> cpus_read_lock().Given that it can only happen during early boot and the
> online cpus can only be expanding, maybe just add sth like:
> 
>         if (early_during_boot) {
>                 for_each_possible_cpu(cpu)
>                         INIT_WORK(per_cpu_ptr(works, cpu), func);
>         }
> 

Thanks tejun for the reply and suggestions.

Yes, unfortunately cpus_read_lock not keeping cpumask stable at
secondary boot. Not sure, may be it only gurantee 'cpu' dont go down
under cpus_read_[lock/unlock].

As suggested will tryout something like:
	if (system_state != RUNNING) {
		:
	}
> BTW, who's calling schedule_on_each_cpu() that early during boot. It makes
> no sense to do this while the cpumasks can't be stabilized.
>
It is  implemenation of CONFIG_TASKS_RUDE_RCU.

> Thanks.
> 
> -- 
> tejun
