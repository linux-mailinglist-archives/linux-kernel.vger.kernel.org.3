Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850955F2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiF2BLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiF2BLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:11:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082729801
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:11:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so8357684wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FADPujuaz1aLOqCIx4QABl+puLiLB9in9PVa2M8nz6c=;
        b=Ee/Mn6fupFOx1RsAsUTfLTo83y2nDuwz/vZQlJrcy+MQKrDDeGu4XxxFCT2yOGhCC6
         Bw2SI4DAj91L4IxN4wQtfwJLO4udddz3ZWW9AHN1Ch3KnDz2jaIrV91FX+fZV1ysbQAe
         W8BvkymGEOrFsHoRJ50tgVxCE0fd0vBd8zUF2ephMjQwJDkYa50Yo89IROL988qAnXk1
         jTEub7BcOWdXc6ytsq93cIH+lLLDDZLY/TwEPmjC5VHaAahijj1+uqHzPqLOibL7nxTr
         At60zaJigpgP++fb9tOSs7AtCIi9AYTRVVWXjtldywo5mIVFS+tdwHddadA8T1FRCTPa
         UJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FADPujuaz1aLOqCIx4QABl+puLiLB9in9PVa2M8nz6c=;
        b=gTYY/awrbyEZkgQd4ZavuI8JDaHdyBOu7RDIIHUKJDwvzTeJ/WS2OOi+zy5SrzYsjC
         jp6aqxn+nta/+J+k9G+wZm59eNscmh//V9qKV67TiRSOvfN+98zfDTUVKohGnnVJpHsH
         GxzHHDD/baVyD9vWCBrSTZ1RBRmoqzqRITTRIoIr/fqsGufjijUGukTiSHNRCiWBJZDp
         gk6PN0t1qDuZX7tEi7QcI368I6NDIdTsAfPz72vwm0QWBWV2xYCJZedmOjPLe8v9cQBM
         6O+q6tn8V30YYkT/1zZEUnEpr8L8aNIYbODl4m+Vrz8CicCRMg112HF56m2SxSEu++5E
         tOEA==
X-Gm-Message-State: AJIora89GcdYLd4dxOKwAt4htMCx5j2sR2HqbtxpcBCxrlnajdNlN37+
        vofDFtDdgRsX6meJUslv3/cGgxJIBizx9Xx1iPobJQ==
X-Google-Smtp-Source: AGRyM1tuvXQVwBWgmZgIpprStMeRA8F9duhl/iDK2nFekqHL9I5MmARUZ32KFLWdGW/lfSZYoj0Ixjf3b83Cb63U9IA=
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr686836wms.57.1656465075814; Tue, 28 Jun
 2022 18:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-6-wuyun.abel@bytedance.com> <CABk29NtsTgJT1c-Vg6B5dgYbi+nHEDk2vsBRzRowCXiOPT2qnA@mail.gmail.com>
 <c353f360-e630-ea29-2045-1a9f005d033d@bytedance.com>
In-Reply-To: <c353f360-e630-ea29-2045-1a9f005d033d@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 28 Jun 2022 18:11:04 -0700
Message-ID: <CABk29NuSONYdmLqUDbJKQfwF3tf1Uv3Yy+WbHkh_gY5FXti1cA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 27, 2022 at 11:53 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> >>
> >> -static inline bool test_idle_cores(int cpu)
> >> +static inline enum sd_state sd_get_state(int cpu)
> >>   {
> >>          struct sched_domain_shared *sds;
> >>
> >>          sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> >>          if (sds)
> >> -               return READ_ONCE(sds->has_idle_cores);
> >> +               return READ_ONCE(sds->state);
> >>
> >> -       return false;
> >> +       return sd_has_icpus;
> >> +}
> >
> > Why is default not sd_is_busy?
>
> The state of sd_is_busy will prevent us from searching the LLC. By
> design, both sd_has_icores and sd_is_busy indicate deterministic
> status: has idle cores / no idle cpu exists. While sd_has_icpus is
> not deterministic, it means there could be unoccupied cpus.
>
> The naming seems misleading, it would be nice to have other options.

sd_has_icores isn't deterministic; when the last fully idle core gets
an occupied sibling, it will take until the next select_idle_cpu() to
mark the state as sd_has_icpus instead.

A comment here and also at the enum definitions would be helpful I think.

> >
> >> +
> >> +static inline void set_idle_cores(int cpu, int idle)
> >
> > nit: Slightly confusing to call the param 'idle', since in the case it
> > is false we still mark icpus. Consider possibly 'core_idle'.
>
> What about changing the param 'cpu' to 'core'?

I think keeping it as "cpu" is fine, since as "core" that would imply
some per-core state (when we're still setting this per-cpu).

> >>          for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >>                  struct rq *rq = cpu_rq(i);
> >> @@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                  nr_running = rq->nr_running;
> >>                  sgs->sum_nr_running += nr_running;
> >>
> >> +               if (update_core)
> >> +                       sd_classify(sds, rq);
> >> +
> >>                  if (nr_running > 1)
> >>                          *sg_status |= SG_OVERLOAD;
> >>
> >> @@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >>          return idlest;
> >>   }
> >>
> >> +static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
> >> +{
> >> +       if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> >> +               set_idle_cpus(env->dst_cpu, true);
> >> +}
> >
> > We're only setting state to has_icpus here in sd_update_state. That
> > doesn't feel good enough, since we're only updating state for
> > env->dst_cpu; all the other per-cpu state will remain stale (ie.
> > falsely sd_is_busy).
>
> It's LLC-wide shared :)

Oh wow, yea that's the thing I missed... Thanks.

> > I think you also want a case in __update_idle_core() to call
> > set_idle_cores(core, 0) in the case where we have a non-idle sibling,
> > since we want to at least mark has_icpus even if the entire core isn't
> > idle.

More specifically, in the __update_idle_core() function, if the
sibling is still busy and the sd_state is sd_is_busy, we should
instead mark it as sd_has_icpus, since the current cpu is guaranteed
to be going idle.

Additionally, to be consistent with what we're calling "idle"
elsewhere, I think you mean to have __update_idle_core() check either
available_idle_cpu() or sched_idle_cpu()?
