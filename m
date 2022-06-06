Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C8C53E803
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiFFJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFFJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:41:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62C1D9B7A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:41:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so8701883wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CAnY3mZUMHGGH8uYt9cZniJ0Uj85BbWebT4j1N9De0w=;
        b=Ws5UJSx2HfJbnDEOVfDzAFCnkzPRxvY2WqfQef6Ma22Vv1Sj9x/kj0Mdmq7fEppLyz
         EX28/jT3AmBlmUGGptW47Dlh0sK0rjTB7vloTB5vyLkdDRCzN9f+xucwo0XfRZQuaXAS
         DS9yTV2krnYH/T36Rus6s57giYnPGI1yffCbntTP5ldQqpEcRSGKJKnQwmTVJ4NL+qj+
         X3L7FS7M2kkK8kAg7X055iB1sYPLCtc6Q2eD3vhucM9iDzdvW/BGVdpGZSWS+p3bSz9e
         visCTYgcUP2Z9jau/KYHmoHnjelA3RndfIT93kgKfFVzPpOt4wvkgiekT2WoDEWQHXWR
         W6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAnY3mZUMHGGH8uYt9cZniJ0Uj85BbWebT4j1N9De0w=;
        b=z4sS1BkvbIRI59Ros4D3sOYhNwYzOI/heb79GHeHc63qBKhIA5wibWTOj0qPwM/o+E
         P7m62GqOvxaP3vL0JcfZEWSDfJC6QI8ciBaQCpA/HdwUmQxngc8G3hUgAaGyrfRnHufp
         jBFiVebTuRPOZZhiPrmatTG2+RjH7la+xlDLXZTjvv5FaFhSxhN7m7BNpiBCSgwI0voZ
         W02ZUoYJlnNG1fpuQQ5CfUuR4i+38eMHXuxBT7Zllxsi8i22p2dVQU581452Ac/qTqY2
         d7o4rdq9oLGdKxWedNrQxfUtUccwbn373qBDGHJt/eijXp0KGNNHeNxwul62WH8GhDqy
         4WXg==
X-Gm-Message-State: AOAM530o/wOB34pS0LKUt0kNu1jJqP8LVUyjSz9cwrTLlPaMCgtqKZ73
        nfoERg5kdbN9jm1aFEdMmHwxr+JUcn5MDw==
X-Google-Smtp-Source: ABdhPJw7ECB1IcnwXLkWfWp0PS0wP3KHkacy95Kouxp3MWcV0whZNywERN6m1KRlubAOFtB1cPnLKQ==
X-Received: by 2002:adf:e691:0:b0:210:2d6a:8a82 with SMTP id r17-20020adfe691000000b002102d6a8a82mr20635924wrm.14.1654508500551;
        Mon, 06 Jun 2022 02:41:40 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b0039746638d6esm16639599wmj.33.2022.06.06.02.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:41:39 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:41:36 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH v9 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
Message-ID: <Yp3L0EwERCp3iAYg@google.com>
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-7-vdonnefort@google.com>
 <CAKfTPtA9qTCteP+VfR_9qnQkoxq=k3ACGrdPiKmc-sox0vXmgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA9qTCteP+VfR_9qnQkoxq=k3ACGrdPiKmc-sox0vXmgw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > +
> > +/*
> > + * compute_energy(): Use the Energy Model to estimate the energy that @pd would
> > + * consume for a given utilization landscape @eenv. If @dst_cpu < 0 the task
> 
> I find this comment a bit confusing because compute_energy() adds the
> task contribution if dst_cpu >= 0 but doesn't remove it. The fact that
> eenv->pd_busy_time has been previously computed without the
> contribution of the task, is outside the scope of this this function
> whereas the comment suggest that the remove will happen in
> compute_energy()

Arg, leftover from a previous version where this function was adding or removing
the contribution. I'll update!

> 
> > + * contribution is removed from the energy estimation.
> > + */
> > +static inline unsigned long
> > +compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> > +              struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
> > +{
> > +       unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> > +       unsigned long busy_time = eenv->pd_busy_time;
> > +
> > +       if (dst_cpu >= 0)
> > +               busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> > +
> > +       return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> >  }
> >

[...]

> > @@ -6878,13 +6947,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                 if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> >                         continue;
> >
> > +               eenv_pd_busy_time(&eenv, cpus, p);
> >                 /* Compute the 'base' energy of the pd, without @p */
> > -               base_energy_pd = compute_energy(p, -1, cpus, pd);
> > +               base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
> >                 base_energy += base_energy_pd;
> >
> >                 /* Evaluate the energy impact of using prev_cpu. */
> >                 if (compute_prev_delta) {
> > -                       prev_delta = compute_energy(p, prev_cpu, cpus, pd);
> > +                       prev_delta = compute_energy(&eenv, pd, cpus, p,
> > +                                                   prev_cpu);
> >                         if (prev_delta < base_energy_pd)
> 
> side question:
> -base_energy_pd is the energy for the perf domain without task p
> -prev_delta is the energy for the same perf domain if task p is put on dst_cpu
> 
> How can prev_delta be lower than base_energy ?

It can happen if one of the CPU utilization is updated in the middle of feec().

> 
> if dst_cpu doesn't belong to the perf domain, prev_delta should be
> equal to base_energy_pd
> if dst_cpu belongs to the perf domain, the compute_energy should be
> higher because the busy_time will be higher
> 
> >                                 goto unlock;
> >                         prev_delta -= base_energy_pd;
> > @@ -6893,8 +6964,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >
> >                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
> >                 if (max_spare_cap_cpu >= 0) {
> > -                       cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
> > -                                                  pd);
> > +                       cur_delta = compute_energy(&eenv, pd, cpus, p,
> > +                                                  max_spare_cap_cpu);
> >                         if (cur_delta < base_energy_pd)
> 
> same question as above
> 
> >                                 goto unlock;
> >                         cur_delta -= base_energy_pd;
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
