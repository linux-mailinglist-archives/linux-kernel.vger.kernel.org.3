Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819605797AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiGSK3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiGSK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:29:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A001181B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:29:43 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31d7db3e6e5so135589157b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT2xAmMvCEu65/e244GqY3FacfnM2+yprrHg1ALHKsc=;
        b=jBQ6uZQxAyYK8Zi9//e111+KH7u36uQScL1uiomTG5E0v+K2OzoikNTQzEVo56dgxP
         sLc9AY02w++qp1inyNONciXcC4/gOehCIeuIQtz04XXm1bWKZozDT2K+pe8RC2hUxVWE
         tFigjKzAbTFdWB2luHY19h3dfTU7Y/ydh49vl63o2Wjts7FYSqcRlibU9/P3qktG7gkf
         IF14u9iLBStJNjBLFrk2hJS0oOhRflUAEiRKUDEEAeNd9JCcnR4uz/iusVmcGj206mYr
         KPfl9oq8vcYm0Flvn8aEJ3CY8HRF1Z80hq9sbLHBbVFevqipVCh/e/elF6bAq7WVw2v9
         pivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gT2xAmMvCEu65/e244GqY3FacfnM2+yprrHg1ALHKsc=;
        b=MBg3mj4RQVdvrs4lOIgDiHk52TE9rK7sLXh5OKfMXQpP3WLY3tV99IyV6WaX/6mZd7
         KT5JC/6GIAhXCDRklu2CJb4wRKMYZJcB4NxEVEI39CKBXN0Lm2IQmO5HmIFvGcxZVwPu
         acSFZsWc/x4hmVGfbnySi7pKRDGzBNqfbNe+H+t9WH63Mj6QYtHDDimloXvhsKQM70+q
         LlekUI7z8q9nz43vHI1wKoix9sY0Qs6kgAddJBNGM/dJUSiiOqUBDBbkTZdVkbhMbire
         4EWy+1MSbZ2PodnNSUQm64kC/uKu078R88j9aM0QpYWUXl3aDwrpSTPLZ9l5Actpwsyv
         nJWA==
X-Gm-Message-State: AJIora8NayaKZmq52R/PUMWop+/+dx8rL4ZmANrntgURyWC1nwKnOiq/
        bVusyAQ95dybLYw4oIotUZBAQ62LLUCENzjPRTsCUw==
X-Google-Smtp-Source: AGRyM1tEdJ7E0EQcZqdpzL+dzUQKifBFowit7hoHtzmZuHRNsjYdEP9u9+nYaD1/9l39e1br8UAJUbaY+PT+vYKQPhk=
X-Received: by 2002:a81:ad0d:0:b0:31e:61a5:3b49 with SMTP id
 l13-20020a81ad0d000000b0031e61a53b49mr790061ywh.67.1658226582465; Tue, 19 Jul
 2022 03:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com> <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
In-Reply-To: <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jul 2022 12:29:31 +0200
Message-ID: <CAKfTPtCsd2RkOZoa10SSwKhm0NRzmOphAVNW7_JykqzxqfkSXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 18:21, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/7/15 19:18, Dietmar Eggemann wrote:
> > On 13/07/2022 06:04, Chengming Zhou wrote:
> >> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
> >> use update_load_avg() to implement attach/detach entity load_avg.
> >>
> >> Another advantage of using update_load_avg() is that it will check
> >> last_update_time before attach or detach, instead of unconditional
> >> attach/detach in the current code.
> >>
> >> This way can avoid some corner problematic cases of load tracking,
> >> like twice attach problem, detach unattached NEW task problem.
> >
> > This explanation is somewhat hard to follow for me. Since both issues
> > have been fixed already (you mention this further below) you're saying
> > that with you change you don't reintroduce them?
>
> Sorry for this not very clear explanation.
>
> Yes, both issues have been fixed already, what I want to say is that bugfix
> brings its own problem and limitation mentioned below.

As Dietmar said, the commit message is misleading because someone can
think you fix these bugs whereas it's not the case

>
> So I want to use another way to solve these problems better.
>
> >
> >> 1. switch to fair class (twice attach problem)
> >>
> >> p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
> >> if (queued)
> >>   enqueue_task(p);
> >>     ...
> >>       enqueue_entity()
> >>         update_load_avg(UPDATE_TG | DO_ATTACH)
> >>           if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
> >>             attach_entity_load_avg()  --> attached, will set last_update_time
> >> check_class_changed()
> >>   switched_from() (!fair)
> >>   switched_to()   (fair)
> >>     switched_to_fair()
> >>       attach_entity_load_avg()  --> unconditional attach again!
> >>
> >> 2. change cgroup of NEW task (detach unattached task problem)
> >>
> >> sched_move_group(p)
> >>   if (queued)
> >>     dequeue_task()
> >>   task_move_group_fair()
> >>     detach_task_cfs_rq()
> >>       detach_entity_load_avg()  --> detach unattached NEW task
> >>     set_task_rq()
> >>     attach_task_cfs_rq()
> >>       attach_entity_load_avg()
> >>   if (queued)
> >>     enqueue_task()
> >>
> >> These problems have been fixed in commit 7dc603c9028e
> >> ("sched/fair: Fix PELT integrity for new tasks"), which also
> >> bring its own problems.
> >>
> >> First, it add a new task state TASK_NEW and an unnessary limitation
> >> that we would fail when change the cgroup of TASK_NEW tasks.
>
> This is the limitation that bugfix has brought.
>
> We can't change cgroup or switch to fair for task with last_update_time=0
> if we don't have conditional detach/attach.
>
> So we have to:
>
> 1. !fair task also need to set last_update_time.
> 2. cpu_cgroup_can_attach() have to wait for TASK_NEW to fully attached.
>
> >>
> >> Second, it attach entity load_avg in post_init_entity_util_avg(),
> >> in which we only set sched_avg last_update_time for !fair tasks,
> >> will cause PELT integrity problem when switched_to_fair().
> >
> > I guess those PELT integrity problems are less severe since we have the
> > enqueue_task_fair() before the switched_to_fair() for enqueued tasks. So
> > we always decay the time the task spend outside fair.
>
> enqueue_task_fair()
>   enqueue_entity()
>     update_load_avg()
>       if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
>         __update_load_avg_se(now, cfs_rq, se);  --> (1)
>
> We can see above, for queued !fair task, (1) will deay the delta time
> (now - se.avg.last_update_time) even for a NEW !fair task.
>
> >
> > Looks to me that you want to replace this by your `freeze PELT when
> > outside fair` model.
>
> Yes, want to freeze PELT for two !fair cases:
>
> 1. !fair task hasn't been fair before: will still have its init load_avg
>    when switch to fair.

But I'm not sure it makes sense to keep these init values. As an
example, the util_avg is set according to the cpu utilization at the
time of the task creation. I would tend to decay them as these init
values become less and less relevant.

so we should return early in post_init_entity_util_avg() and don't set
util_avg if sched class is not cfs

>
> 2. !fair task has been switched_from_fair(): will still keep its lastest
>    load_avg when switch to fair.
>
> >
> >> This patch make update_load_avg() the only location of attach/detach,
> >> and can handle these corner cases like change cgroup of NEW tasks,
> >> by checking last_update_time before attach/detach.
> >
> > [...]
> >
> >> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
> >>      struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >>
> >>      /* Catch up with the cfs_rq and remove our load when we leave */
> >> -    update_load_avg(cfs_rq, se, 0);
> >> -    detach_entity_load_avg(cfs_rq, se);
> >> -    update_tg_load_avg(cfs_rq);
> >> +    update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
> >
> > IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
> > updated in this case.
>
> Correct, will do.
>
> Thanks.
>
> >
> > [...]
