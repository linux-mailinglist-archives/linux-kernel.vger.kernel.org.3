Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05C853F6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiFGHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiFGHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:00:04 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7EBE274E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:00:02 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-30fdbe7467cso130086267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0Wwqj0q0gz7akdNJ/mCyQgDbF5i0epVi6uOBkYKKA4=;
        b=jl8zwanvnIbT7jXgIxjYYkcfSXe365gZdAkgVrAIeKNohsRMzBjqxG1kLh83J6ckcR
         t8rslBph93nZ/xFZc8qEc8LT+UvMnkw9KR2e7jkyQFLICVQ4TG5feXsD+ru1MojTy/zC
         ZAmFhDujfBelHN65KDbjDx0zYdOwmLPTVXhwNgdnsmftaSXpBBsKSj4cJIAxdgumnm2p
         tHkMIBiQ15r+LyGM3rUucVtfMeCmet6JZ20+vnRr9NHSpr23vHVzOZ23gclrY6dEyGHG
         KWHjjz63JU8ZqcUiQVnToBlPnamSofIBGtfLEyIHTBmnKFQwwpdwPbcgZhJeQgo9vyyR
         lfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0Wwqj0q0gz7akdNJ/mCyQgDbF5i0epVi6uOBkYKKA4=;
        b=xsJ7Y9tRVtvuRiFWIPyZA4Hoj5C3VSsEfljaAmbrM8GPrM76sikGAE1MZWQrPTNUIz
         XCSGxtovJIxM/OxRnVbje9VjFU3B5Pb76eVveRd52eWCwjo9nhHYwO/9vdw+pUGrZtjO
         qOfQ9KAd2IHUxayPUxvC7w89t9kTOF2rPLLyHrkv+rPqy0aGzcOacWbpQZlFHSKYhEnq
         OFa8CTicDkQGVVa2kDWP0yDq4WhXZSQ2ZqGHGvOpIMyJjiF2zglB9oTgg2ak8981uJ2B
         TSsPvS/2wo6OJ11g9uV34ylptccp5CARxdsRAQ8d48Lj1fTBulSI7vToYEoNC6fOvRrZ
         Jfew==
X-Gm-Message-State: AOAM532pODfJkx/oqbJVgpcW+3aCDn/9qhvLe6SfTTD4Njkgg4gNjLB4
        ZyYYuguSppxY1Ga3YM/ljZUpCZiC0s/zGrpO4Mv1QvEyU34=
X-Google-Smtp-Source: ABdhPJwZx0NFEO4N+FxS8zmpT1e9CXKKfkgeC9akV/pg3wzxptbnowPB+Oe0uIRnBNNSTdMNFl8/JtPFy5vyOyzG0jc=
X-Received: by 2002:a81:f15:0:b0:30c:9e77:e6fa with SMTP id
 21-20020a810f15000000b0030c9e77e6famr30723403ywp.248.1654585201996; Tue, 07
 Jun 2022 00:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-7-vdonnefort@google.com> <CAKfTPtA9qTCteP+VfR_9qnQkoxq=k3ACGrdPiKmc-sox0vXmgw@mail.gmail.com>
 <Yp3L0EwERCp3iAYg@google.com>
In-Reply-To: <Yp3L0EwERCp3iAYg@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jun 2022 08:59:50 +0200
Message-ID: <CAKfTPtCQLNhhNgXVYi0NAVpjmmy1duV9PW5kq16BPYSd2gtfXQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 at 11:41, Vincent Donnefort <vdonnefort@google.com> wrote:
>
> [...]
>
> > > +
> > > +/*
> > > + * compute_energy(): Use the Energy Model to estimate the energy that @pd would
> > > + * consume for a given utilization landscape @eenv. If @dst_cpu < 0 the task
> >
> > I find this comment a bit confusing because compute_energy() adds the
> > task contribution if dst_cpu >= 0 but doesn't remove it. The fact that
> > eenv->pd_busy_time has been previously computed without the
> > contribution of the task, is outside the scope of this this function
> > whereas the comment suggest that the remove will happen in
> > compute_energy()
>
> Arg, leftover from a previous version where this function was adding or removing
> the contribution. I'll update!
>
> >
> > > + * contribution is removed from the energy estimation.
> > > + */
> > > +static inline unsigned long
> > > +compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> > > +              struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
> > > +{
> > > +       unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> > > +       unsigned long busy_time = eenv->pd_busy_time;
> > > +
> > > +       if (dst_cpu >= 0)
> > > +               busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> > > +
> > > +       return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > >  }
> > >
>
> [...]
>
> > > @@ -6878,13 +6947,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                 if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> > >                         continue;
> > >
> > > +               eenv_pd_busy_time(&eenv, cpus, p);
> > >                 /* Compute the 'base' energy of the pd, without @p */
> > > -               base_energy_pd = compute_energy(p, -1, cpus, pd);
> > > +               base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
> > >                 base_energy += base_energy_pd;
> > >
> > >                 /* Evaluate the energy impact of using prev_cpu. */
> > >                 if (compute_prev_delta) {
> > > -                       prev_delta = compute_energy(p, prev_cpu, cpus, pd);
> > > +                       prev_delta = compute_energy(&eenv, pd, cpus, p,
> > > +                                                   prev_cpu);
> > >                         if (prev_delta < base_energy_pd)
> >
> > side question:
> > -base_energy_pd is the energy for the perf domain without task p
> > -prev_delta is the energy for the same perf domain if task p is put on dst_cpu
> >
> > How can prev_delta be lower than base_energy ?
>
> It can happen if one of the CPU utilization is updated in the middle of feec().

Ok. A comment would be helpful

>
> >
> > if dst_cpu doesn't belong to the perf domain, prev_delta should be
> > equal to base_energy_pd
> > if dst_cpu belongs to the perf domain, the compute_energy should be
> > higher because the busy_time will be higher
> >
> > >                                 goto unlock;
> > >                         prev_delta -= base_energy_pd;
> > > @@ -6893,8 +6964,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >
> > >                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
> > >                 if (max_spare_cap_cpu >= 0) {
> > > -                       cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
> > > -                                                  pd);
> > > +                       cur_delta = compute_energy(&eenv, pd, cpus, p,
> > > +                                                  max_spare_cap_cpu);
> > >                         if (cur_delta < base_energy_pd)
> >
> > same question as above
> >
> > >                                 goto unlock;
> > >                         cur_delta -= base_energy_pd;
> > > --
> > > 2.36.1.124.g0e6072fb45-goog
> > >
