Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCF53F6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiFGG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiFGG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:57:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4B10FC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:57:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w2so29579047ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4uR5LbV6EbWG9F2qM3fIinCESP1HArAd0O7vuPpEds=;
        b=pMuwb7jvfkdxK8pbZCWeKKSg0+Kv9kt1do1kXVTFq+txdIuBwlB1UcIwp57DKh7i9g
         szai/PtBxsDy+76Fqksu4Gc8kwsS/ROWpTvx3qN8hzbJ3WdCoH3Bh3Fn2YT9apwRBF6l
         ih+xe8ACA+kYvlXM6qLdo5POpDiTlNYkapy3rBLKHFr5RNh7OVfzlEoI6dnWrt46dpQU
         c9tBAuzh8e+2DLroOqjo0UwAKKIVMoZX5KqG3zEidJVZlbqm5oQ4KCix4/H10xJCk6bM
         dBrmEeOlP0QuCOdwA86sHSfvdBl83wAkplC+C+mq3Qm6VBQF+RQ0sa/JJOIUvm7a1iEf
         o82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4uR5LbV6EbWG9F2qM3fIinCESP1HArAd0O7vuPpEds=;
        b=e7XMjhrO2ig1TvTMUIf86TUYKMbp0c0hzUZ9iO9scbjz1xUSinQMsy0RC6lD3GYq4w
         jx/Fkv4bhsuRmZPu63ZpUOl955bRtAtiBHS36Pt/RJUvhi4XPNKuwWdmh3MTTPP/9jI4
         9g0ejzJAZUiMZfIL7lwEpH4J1oM3iNXfPTkCM0nFFVz+lGCIPmXBxWohCpnb50z+3tz1
         paxGJ0bnN8FgUJQFB4zW5Ob9JlxkiyQ1WW1VjPwhpX9Cyl3RCfrDMXGuXgwY0MGrc4uX
         CYlUQHTbDByHeuKZvUzlkj71xrxZduE5NGNXYoMl/Jf5onsLTt8OSIo9h1JQ8ipm1Fsy
         iqeg==
X-Gm-Message-State: AOAM533ikiEONwhqkjsuoOvTfQNAWKJNU9xSGLbCyJ3YzNMkAUnTNXzB
        OcKZyzIzaOOXfnAjzBU0dHiQTi/4KVDoBL7W+DS3/A==
X-Google-Smtp-Source: ABdhPJycGoatlV+SG49QjETFiIpead89XGEIv/BQTi+Beq0Q6TNzic9FjRAFVjuVipLQ5UKzpQkzp7CCWT9e7rrJzTk=
X-Received: by 2002:a25:6041:0:b0:663:6f4c:b3b8 with SMTP id
 u62-20020a256041000000b006636f4cb3b8mr11869917ybb.236.1654585073784; Mon, 06
 Jun 2022 23:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-3-vdonnefort@google.com> <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
 <Yp3JZIokwFxT+X6M@google.com>
In-Reply-To: <Yp3JZIokwFxT+X6M@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jun 2022 08:57:42 +0200
Message-ID: <CAKfTPtD6TpaJoz37Xv2_1Cc8ij_XGFjDTwA+TvN3ddiASkYc4g@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com
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

On Mon, 6 Jun 2022 at 11:31, Vincent Donnefort <vdonnefort@google.com> wrote:
>
> [...]
> > > @@ -8114,6 +8212,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
> > >             if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> > >                     update_tg_load_avg(cfs_rq);
> > >
> > > +                   /* sync clock_pelt_idle with last update */
> >
> > update_idle_cfs_rq_clock_pelt() syncs cfs_rq->throttled_pelt_idle with
> > cfs_rq->throttled_clock_pelt_time. Not sure what `clock_pelt_idle` and
> > `last update` here mean?
>
>
> Indeed, this comment is not helpful at all. What matters here is that the cfs_rq
> is idle and we need to update the throttled_pelt_idle accordingly.
>
> >
> > [...]
> >
> > > +/* The rq is idle, we can sync to clock_task */
> > > +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> > > +{
> > > +   rq->clock_pelt  = rq_clock_task(rq);
> > > +
> > > +   u64_u32_store(rq->enter_idle, rq_clock(rq));
> > > +   /* Paired with smp_rmb in migrate_se_pelt_lag */
> >
> > minor:
> >
> > s/migrate_se_pelt_lag/migrate_se_pelt_lag()
> >
> > [...]
> >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index bf4a0ec98678..97bc26e5c8af 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -648,6 +648,10 @@ struct cfs_rq {
> > >     int                     runtime_enabled;
> > >     s64                     runtime_remaining;
> > >
> > > +   u64                     throttled_pelt_idle;
> > > +#ifndef CONFIG_64BIT
> > > +   u64                     throttled_pelt_idle_copy;
> > > +#endif
> > >     u64                     throttled_clock;
> > >     u64                     throttled_clock_pelt;
> > >     u64                     throttled_clock_pelt_time;
> > > @@ -1020,6 +1024,12 @@ struct rq {
> > >     u64                     clock_task ____cacheline_aligned;
> > >     u64                     clock_pelt;
> > >     unsigned long           lost_idle_time;
> > > +   u64                     clock_pelt_idle;
> > > +   u64                     enter_idle;
> > > +#ifndef CONFIG_64BIT
> > > +   u64                     clock_pelt_idle_copy;
> > > +   u64                     enter_idle_copy;
> > > +#endif
> > >
> > >     atomic_t                nr_iowait;
> >
> > `throttled_pelt_idle`, `clock_pelt_idle` and `enter_idle` are clock
> > snapshots when cfs_rq resp. rq go idle. But the naming does not really
> > show this relation. And this makes reading those equations rather difficult.
> >
> > What about something like `throttled_clock_pelt_time_enter_idle`,
> > `clock_pelt_enter_idle`, `clock_enter_idle`? Especially the first one is
> > too long but something which shows that those are clock snapshots when
> > enter idle would IMHO augment readability in migrate_se_pelt_lag().
>
> What if I drop the "enter"?
>
>  clock_idle;
>  clock_pelt_idle;
>  throttled_clock_pelt_time_idle;

and you can even remove the _time for throttled_clock_pelt_idle

>
> >
> > Besides these small issues:
> >
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Thanks!
