Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68510570880
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiGKQml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:42:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E4313A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:42:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l11so9606260ybu.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlUkWztlt/Z3BrxJzglVgqLX7nuvonSknHaXQX/e1J0=;
        b=s19kH2XwfNwBdLLnbQ6b9TMpziP8ilyJJgOmBulTPx9dOHyxDJdHfl+ABgkjDoxGI9
         JuFYhbfo37JCNVlOYTeCRBXWXsKPam62QnY/2mM8Vg9OL0c2ESXDZflM+rdqQhtIgxTH
         uV6KWWwQgUZ7nLpaZlNf51aE2/4oCdQXTZpmFO9riHjefDONWT1jseUDHT50jIup1UID
         qjYonec1F8huwm6EYbXgLcRXveVu6gtzLJrM/OWgpocUrBXyrgSdMbSXD9tF1cq48L02
         wzvmh6x9KBmwTfJspOJwiycDm8pOFUAs2N/O/yOYCODL5pmBAtS6CVw/OPpeC2FqJkKY
         ItmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlUkWztlt/Z3BrxJzglVgqLX7nuvonSknHaXQX/e1J0=;
        b=cQ4Kp/jN1zZvUwm1fmEuLYwZB2u1Wgj7iSgF5kCdOdMye82SpHwdMxHd1udFHjkVlO
         u9O57df3phMDRd7uBzs5XahFXwFnV3j+3pk5TpRGvwdW5bSDZ65wm83lfmvGV2O/NdgI
         m4mCI2nSVXzAE/mJU4BPVy4/HS4TKp/NROECAI7Spdt2XJDvPwE9ckFdRItzeqFB9G01
         EAmSsxyidbvTdkrA9j0s3qfvrTmju6sMSOExsaKeJ2k3TmJxtrWk9t4Bi8ZDsfTz/WeW
         tjDDPu1mi+/wZOn2oYoaAz+nfZzaxAW07Hl1wxJGgqJgrWNj11qmlmHmobkkwvjK0cdO
         48Mg==
X-Gm-Message-State: AJIora/REwuWE3Fth9c86pE0YZAeNLfcAx7RlpSDKFjB68/opW6AVy8b
        YZEGrY+zKt7HMqgjWhs8Ym884KrwHDlK8849+wruFw==
X-Google-Smtp-Source: AGRyM1vVxKAogB28O9SMTeUrMlpavA2zHi5auzRspM0exEtRTGWA4nFzWjYmSb44rZYagCTXJHfgva+2r92lQZ8PGwM=
X-Received: by 2002:a25:9382:0:b0:66d:ae8e:19e8 with SMTP id
 a2-20020a259382000000b0066dae8e19e8mr18256347ybm.236.1657557757366; Mon, 11
 Jul 2022 09:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220708154401.21411-1-vincent.guittot@linaro.org> <20220711160304.njkd3ml7nqpokiim@wubuntu>
In-Reply-To: <20220711160304.njkd3ml7nqpokiim@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jul 2022 18:42:25 +0200
Message-ID: <CAKfTPtBDYqXP4gx9_QFK-ibrC=FynufbXAiup6hxsmBT2AxOQQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix case with reduced capacity CPU
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
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

On Mon, 11 Jul 2022 at 18:03, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> On 07/08/22 17:44, Vincent Guittot wrote:
> > The capacity of the CPU available for CFS tasks can be reduced because of
> > other activities running on the latter. In such case, it's worth trying to
> > move CFS tasks on a CPU with more available capacity.
> >
> > The rework of the load balance has filtered the case when the CPU is
> > classified to be fully busy but its capacity is reduced.
> >
> > Check if CPU's capacity is reduced while gathering load balance statistic
> > and classify it group_misfit_task instead of group_fully_busy so we can
> > try to move the load on another CPU.
> >
> > Reported-by: David Chen <david.chen@nutanix.com>
> > Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: David Chen <david.chen@nutanix.com>
> > Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
> > ---
>
> [...]
>
> > @@ -8820,8 +8833,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >
> >       for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >               struct rq *rq = cpu_rq(i);
> > +             unsigned long load = cpu_load(rq);
> >
> > -             sgs->group_load += cpu_load(rq);
> > +             sgs->group_load += load;
> >               sgs->group_util += cpu_util_cfs(i);
> >               sgs->group_runnable += cpu_runnable(rq);
> >               sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> > @@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               if (local_group)
> >                       continue;
> >
> > -             /* Check for a misfit task on the cpu */
> > -             if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > -                 sgs->group_misfit_task_load < rq->misfit_task_load) {
> > -                     sgs->group_misfit_task_load = rq->misfit_task_load;
> > -                     *sg_status |= SG_OVERLOAD;
> > +             if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> > +                     /* Check for a misfit task on the cpu */
> > +                     if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> > +                             sgs->group_misfit_task_load = rq->misfit_task_load;
> > +                             *sg_status |= SG_OVERLOAD;
> > +                     }
> > +             } else if ((env->idle != CPU_NOT_IDLE) &&
> > +                        sched_reduced_capacity(rq, env->sd)) {
> > +                     /* Check for a task running on a CPU with reduced capacity */
> > +                     if (sgs->group_misfit_task_load < load)
> > +                             sgs->group_misfit_task_load = load;
> >               }
> >       }
>
> Small questions mostly for my education purposes.
>
> The new condition only applies for SMP systems. The reason asym systems don't
> care is because misfit check already considers capacity pressure when checking
> that the task fits_capacity()?

Yes

>
> It **seems** to me that the migration margin in fits_capacity() acts like the
> sd->imbalance_pct when check_cpu_capacity() is called by
> sched_reduced_capacity(), did I get it right?

Yes

>
> If I got it right, if the migration margin ever tweaked, could we potentially
> start seeing this kind of reported issue on asym systems then? I guess not. It
> just seems to me for asym systems tweaking the migration margin is similar to
> tweaking imbalance_pct for smp ones. But the subtlety is greater as
> imbalance_pct is still used in asym systems.

You should not because the task will end up being misfit whatever the
margin. The only change would be how fast you will detect and migrate


>
>
> Thanks
>
> --
> Qais Yousef
