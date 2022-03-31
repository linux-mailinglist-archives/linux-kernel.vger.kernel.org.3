Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9C4ED97A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiCaMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiCaMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:17:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E062419B9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:15:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k21so41149884lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Il9zjRpJKZdoIZgQvsM+O3M/+gPBA3EfbiVEQllsPmY=;
        b=zxC9544pU0G0GrJ7i5/7yramOxIjcjrrHlhmYHP4YdrE9OYK47MtQBw2N4OSHcWX9l
         84QvA0+jgDPhQSV4l6OAJQ/7y/xVnGOVEGQm36RcKRSaaBXDbxW+BjduWn0QasD6+nG/
         Kl4/k3HGl5tdOZKICps7G6D9n3bFUJ1WwAodD46u4O3JOhAUOGU/fP+7hzqsmCnw3OfQ
         s61qqcq3eeWg7d2OLvTjb8u57mbY/dG5DFYdnV0kIXsi62WhakeysrZmfno4McmuIv+x
         XZsXa01L4PeTVOFKzkD/JnB73qBUKiHt3RPSbwALQ3nup1y+suW1JD8/83Jc8VL4VGTR
         a7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il9zjRpJKZdoIZgQvsM+O3M/+gPBA3EfbiVEQllsPmY=;
        b=XNcET5Pt4d3SnSa+Lf9h92+FInuy2Ft9xCWtj+jdm28GqmJFLpnQLSKA7TD2ldbiMk
         F1TTfnVoIlVjloEi+DQKuW9hNy4mp1j9XDmcZ7njlntaaHRmvNuQPkylKqYpfQcHCk1m
         e6amflNZZCFUqxFQSugbRSLmUohTvZxuVO3+nv/72ZnRuztZW9zV8x5A5H6Ycl536NlC
         nQB/0qZcvDIvDqY1zrgooX6xBmSrZe22s3l86rP9RNNMbgw5YamqzTJPmQMDQT+uSIz7
         Yiv/zY943m/p9Om9Gv9WJgnFVrC0aHijMLJXr8AM+J2Ii5gMjd2+h5hqpRRKIVOAQVZn
         odVA==
X-Gm-Message-State: AOAM532jDtymy5KWq01yPMre3Qe0tvIkuuXO4teNl+QZH+A6h5uQpdmH
        nOjPr7fDBCt0L4J+7WSNy8gYVIxOT8kruvk4jsmFfg==
X-Google-Smtp-Source: ABdhPJxLigaByZDlRGkGcaCFv/QSJZpaH7gUy7pfgH7C5etjkKrg0bPpzNq+ZItshTbBct8ZTTcqYqJAcjVUTVm0BfA=
X-Received: by 2002:a05:6512:6cf:b0:44a:25d1:a27 with SMTP id
 u15-20020a05651206cf00b0044a25d10a27mr10545659lff.18.1648728949618; Thu, 31
 Mar 2022 05:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648228023.git.tim.c.chen@linux.intel.com>
 <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
 <CAKfTPtBDA1uZ1xvo_uhqnNVg69DPXXJBeo0+aQdVJiosB_qgrw@mail.gmail.com> <20220331114709.GS8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220331114709.GS8939@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Mar 2022 14:15:38 +0200
Message-ID: <CAKfTPtD-gezaAu5kn_vRjWdhHdu_NQLufpTFbSAKQtxPKPO_ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>,
        Juri Lelli <juri.lelli@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
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

On Thu, 31 Mar 2022 at 13:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> It's been 3 months since I wrote these patches, so memory is vague at
> best :/
>
> On Tue, Mar 29, 2022 at 11:03:44AM +0200, Vincent Guittot wrote:
>
> > > +static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > +{
> > > +       if (!sched_feat(PLACE_MIGRATE))
> > > +               return;
> > > +
> > > +       if (cfs_rq->nr_running < se->migrated) {
> > > +               /*
> > > +                * Migrated to a shorter runqueue, go first because
> > > +                * we were under-served on the old runqueue.
> > > +                */
> > > +               se->vruntime = cfs_rq->min_vruntime;
> > > +               return;
> > > +       }
> > > +
> > > +       /*
> > > +        * Migrated to a longer runqueue, go last because
> > > +        * we got over-served on the old runqueue.
> > > +        */
> > > +       se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
> > > +}
> > > +
> > >  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> > >
> > >  static inline bool cfs_bandwidth_used(void);
> > > @@ -4296,6 +4317,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >
> > >         if (flags & ENQUEUE_WAKEUP)
> > >                 place_entity(cfs_rq, se, 0);
> > > +       else if (se->migrated)
> > > +               place_entity_migrate(cfs_rq, se);
> > >
> > >         check_schedstat_required();
> > >         update_stats_enqueue_fair(cfs_rq, se, flags);
>
> > > @@ -6973,14 +6997,15 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >                  * wakee task is less decayed, but giving the wakee more load
> > >                  * sounds not bad.
> > >                  */
> > > -               remove_entity_load_avg(&p->se);
> > > +               remove_entity_load_avg(se);
> > >         }
> > >
> > >         /* Tell new CPU we are migrated */
> > > -       p->se.avg.last_update_time = 0;
> > > +       se->avg.last_update_time = 0;
> > >
> > >         /* We have migrated, no longer consider this task hot */
> > > -       p->se.migrated = 1;
> > > +       for_each_sched_entity(se)
> > > +               se->migrated = READ_ONCE(cfs_rq_of(se)->nr_running) + !se->on_rq;
> >
> > Why do we need to loop on se ? Isn't p->se enough ?
>
> Yeah; I really don't recall why I did that. And looking at it now, it
> doesn't really make much sense. I suppose it will trigger
> place_entity_migrate() for the group entries, but on the old CPU.

Yes, that is the reason for my question. task is still connected to
prev cfs so you trigger place_entity_migrate() on the sched_entity of
previous hierarchy. Also this will only happen during enqueue if the
se has not run in the meantime. So it 's probably to be a nop most of
the time as the parent cfs is already enqueued when we migrate a
runnable task and in the other case it will break sched_group vruntime
and fairness

>
>
