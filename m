Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E404B27BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbiBKOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiBKOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:21:55 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150E188
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:21:54 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id o5so8633030qvm.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T5JGiO2ZMME0+oggsFCI/HiSknAw5C3gREAKyfpMDM4=;
        b=OmS501mKL9CHka2alvtAwjpoDhlzv0ORg3bJSnhe89PBmSiGGsDUIcJzGzBHJhNHlM
         IIdn3agoiRwYDwjoz4rZtA9E/fyRib4yyCEcaE4kBemAsljqjHEwV2a64LllZimrDa5U
         DuTDDHzFUiKs1Dt4vJHUn6nQzp9cyj8dZgbsamMjq7ABM/kG8r3GIBcr3DLFMUk1BSAf
         9SpiOWjo1Jf+GUCF+KnM0X0XSTAq4Nlbl23+THDZuIwLc7+zS/KJa+pvV/vwZshKCr4Y
         vE4CSfE2w2cp2PUYFADIcA4mpfi0gq+z8UNpmsmADQkwihfYo5AVwk6/h/6GHSqB98mA
         EGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5JGiO2ZMME0+oggsFCI/HiSknAw5C3gREAKyfpMDM4=;
        b=f2sLQ/jw/+Wu42hDyHD70jcJ9OyOdEs11rVjvBv35CzYmQoh3eOe7oCbK5jmWq/AKg
         aPjbuiEhpAyo0szIg5EoD5ew7yW3dXDEFzGttBp9YH4a/JDlxszbIBO2Lk7o3SmmJP35
         QkNNkMTQA2M6EdS+oiHZXnRJRena0mtZ2coqeDSclSQQk833HZ0p9H5z+Nl8F2HWiulm
         rtV7ap/xBrYzsFoeUj9SdXCp1Rqcy9LhTqvO29vjpNFpkAmxq25S+wWyjPxv/UDtnZTV
         LvdLz+HzJFAGYo+41ded6drxMywkwbq+niDTsygPpIs91MPzIah249Ptk22wLv/uRNfy
         ypIQ==
X-Gm-Message-State: AOAM532gqlVz9dQyn77+MHYLaRJ3WxNEKdVl978nOQ2rWp4d+eTbEqS+
        f84cWRpvBr5P2Ky44RqZ4GY=
X-Google-Smtp-Source: ABdhPJwtEYjP3AHeWIrAiLH6Npo5wJraVu13VVnPwPPJs8SG5MCUtjALlnWRm1rseIu96zbcysGoTA==
X-Received: by 2002:ad4:5ca1:: with SMTP id q1mr1218127qvh.21.1644589313727;
        Fri, 11 Feb 2022 06:21:53 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id h5sm13332257qth.54.2022.02.11.06.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:21:53 -0800 (PST)
Date:   Fri, 11 Feb 2022 06:19:41 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 22/49] sched: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <YgZwfcfKYWuIrDpm@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-23-yury.norov@gmail.com>
 <20220211101958.GQ23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211101958.GQ23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:19:58AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 10, 2022 at 02:49:06PM -0800, Yury Norov wrote:
> > In some places, kernel/sched code calls cpumask_weight() to check if
> > any bit of a given cpumask is set. We can do it more efficiently with
> > cpumask_empty() because cpumask_empty() stops traversing the cpumask as
> > soon as it finds first set bit, while cpumask_weight() counts all bits
> > unconditionally.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Neither of these paths are really performance sentitive, but whatever.
> 
> Do you want me to take this now,

Yes please. Many patches from this series already merged this way.

> or do you want to merge the whole
> series somewere else? In which case:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> > ---
> >  kernel/sched/core.c     | 2 +-
> >  kernel/sched/topology.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 28d1b7af03dc..ed7b392945b7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8711,7 +8711,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
> >  {
> >  	int ret = 1;
> >  
> > -	if (!cpumask_weight(cur))
> > +	if (cpumask_empty(cur))
> >  		return ret;
> >  
> >  	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..8478e2a8cd65 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -74,7 +74,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
> >  			break;
> >  		}
> >  
> > -		if (!cpumask_weight(sched_group_span(group))) {
> > +		if (cpumask_empty(sched_group_span(group))) {
> >  			printk(KERN_CONT "\n");
> >  			printk(KERN_ERR "ERROR: empty group\n");
> >  			break;
> > -- 
> > 2.32.0
> > 
