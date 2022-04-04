Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F54F12EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356705AbiDDKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbiDDKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:18:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DFD33353
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:16:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so16245252lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ev3IdRW0xJLPMDAo9UIbDP3kUhqMzNzH09LBuegMrKY=;
        b=npRethTZTv7RsLtjpSNsFN7R2euWEErluwrdhC5vB7pXBIMiy9z1YGBktXsJex4nOl
         rq44ujIicvFurvkA2XcKkuvYGSIYV5EGlL0rkKkZ2OW8g+M+4yDp4J8cz6YseWbMWtpD
         4RGQRzuAxvWZj32enwrsBOf1GsVEh2EQ9LpKUwR9jBgk+fr837Fr7Cz2PBYErDM2Telc
         mnznLbxRLxmxMYiXweXuRPckGcLT/CLZZfEAGTZ+HON4V7qyczlV43lbtIW9wb/yVSj/
         dZPPi7T7T0k/SmECaKyNkjVTpFh4UmTDl84Q9vDwHgHHavrse/zJLbcZie0jl7Vd/5PT
         k0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ev3IdRW0xJLPMDAo9UIbDP3kUhqMzNzH09LBuegMrKY=;
        b=7oeZdcBc3iaUYGWKC+vIFF7cfPXHwkP3m3vadVNo1rNi/8xfY3njpgr0ash9dIQWsJ
         Cp90HPXi/A6vinIegWMOaAWtkk8sYyZwyB8HmLscLHfasxt9llvT00vUINdYpbUKngYJ
         eVoH+2r5TRBgzlKRXEgjoV1ZtgGBXVkdOhzGPd+thiK8gKnM2VwtAqMRtFhI93QUebQf
         9bMT6UskvRvJ6l/TBdmRcMV2xF+RtPn5ZdZgZbuIhKH4TkPcO4BSQOUpeOx7NzXUCpNx
         MsEjmmal7Vh37h0r28r0ITRkpWdrbY03AlPT/rJcLStqOK704CTHrxL3+CWk2IEK6CK2
         RGdw==
X-Gm-Message-State: AOAM532gePvKh06eJlwKKStAAquMzkHPFUEtpL1TrJj32TM4yqtr1+yB
        0GBhGb5VgQurAryyi0pJmbK9c2QZZFFxNdi9Gco3mTUcwkk=
X-Google-Smtp-Source: ABdhPJxqcz9HA4KjDwSHw2AZIO77HODfrPT278AhJBYzv3Jba0ZsSXxHODqtzoniSwABEckvIHOznd+EjpD4sUS2Hs0=
X-Received: by 2002:ac2:5f19:0:b0:44a:f3de:58bd with SMTP id
 25-20020ac25f19000000b0044af3de58bdmr6275954lfq.645.1649067391648; Mon, 04
 Apr 2022 03:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220401091127.3234638-1-zhangsong34@huawei.com>
 <CAKfTPtCNLELdiQXCdbxrXotqCkRV-2mKK7uVXQv---mbnekaUQ@mail.gmail.com> <5f60ad7e-6809-e314-53e5-aa081dbffff5@huawei.com>
In-Reply-To: <5f60ad7e-6809-e314-53e5-aa081dbffff5@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Apr 2022 12:16:20 +0200
Message-ID: <CAKfTPtBVSWoFNTcHwm1Z6AzqoxjafCea4e6hafLvONeM_2UEig@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Allow non-idle task to preempt idle task directly
To:     "zhangsong (J)" <zhangsong34@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhangsong <zhangsong34@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2022 at 05:33, zhangsong (J) <zhangsong34@huawei.com> wrote:
>
>
> =E5=9C=A8 2022/4/1 21:09, Vincent Guittot =E5=86=99=E9=81=93:
> > On Fri, 1 Apr 2022 at 11:13, zhangsong <zhangsong34@huawei.com> wrote:
> >> From: zhangsong <zhangsong34@gmail.com>
> >>
> >> In check_preempt_tick(), the sched idle task may exectue at least
> >> `sysctl_sched_min_granularity` time but any other cfs tasks cannot
> >> preempt it. So it is nessesary to ignore the `sysctl_sched_min_granula=
rity`
> >> resctriction for sched idle task preemption.
> > Could you explain why you need to remove this condition for sched_idle =
?
> > sched_idle tasks are already preempted at wakeup by others. And they
> > run while others are runnable only if they has not run for a very long
> > time compares to other. The ideal_runtime of a sched_idle task is
> > capped to 750us min to ensure a minimum progress. But this will happen
> > not more than once  every 256ms and most probably even less often.
>
> Thanks for your reply=EF=BC=81I think that sched idle task is treated off=
line
> task, and sched normal task is treated online task. To reduce latency of
> online tasks and the interference from offline tasks, it is no need to
> let offline task occupy any CPU time.

This doesn't explain why you want to do this. What particular problem
are you facing that needs this change ?
Not sure what you mean by offline task. sched_idle tasks are cfs tasks
with very low weight, preempted at wakeup and which don't preempt
others. Nevertheless, they need to make progress to not starve the
system so there is a need to let sched_idle task to make progress from
time to time so we ensure them 0.3% of cpu bandwidth.

>
> >
> >> Signed-off-by: zhangsong <zhangsong34@gmail.com>
> >> ---
> >>   kernel/sched/fair.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index d4bd299d6..edcb33440 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4477,6 +4477,15 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struc=
t sched_entity *curr)
> >>          struct sched_entity *se;
> >>          s64 delta;
> >>
> >> +       se =3D __pick_first_entity(cfs_rq);
> >> +
> >> +       if ((cfs_rq->last && se_is_idle(cfs_rq->last) - se_is_idle(cur=
r) < 0) ||
> >> +           (cfs_rq->next && se_is_idle(cfs_rq->last) - se_is_idle(cur=
r) < 0) ||
> >> +           se_is_idle(se) - se_is_idle(curr) < 0) {
> >> +               resched_curr(rq_of(cfs_rq));
> >> +               return;
> > Why all these complex conditions ?
> > if (se_is_idle(curr)) should be enough
> >
> I think that if se/next/last is not idle and curr is idle, current
> cfs_rq should resched and curr can be preempt by others.
> >> +       }
> >> +
> >>          ideal_runtime =3D sched_slice(cfs_rq, curr);
> >>          delta_exec =3D curr->sum_exec_runtime - curr->prev_sum_exec_r=
untime;
> >>          if (delta_exec > ideal_runtime) {
> >> @@ -4497,7 +4506,6 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct=
 sched_entity *curr)
> >>          if (delta_exec < sysctl_sched_min_granularity)
> >>                  return;
> >>
> >> -       se =3D __pick_first_entity(cfs_rq);
> >>          delta =3D curr->vruntime - se->vruntime;
> >>
> >>          if (delta < 0)
> >> --
> >> 2.27.0
> >>
> > .
