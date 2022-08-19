Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71E4599C21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348613AbiHSMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiHSMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:35:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34121D6336
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:35:49 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31f445bd486so116936097b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=14TBO6qOq1fRQ+FbYLje80t5Pt+y91sZvBjhjHqXvZg=;
        b=qeqVIXgtGQtGiQDJq7lingW4Jp3U3jFObhQl62jNRWGefBmVkC2E+HYKgkvmTIgczP
         5XGRbCi2zhPBW9ibK94cnjaQYXiCP4p4hPoW5+4VmvcsxEijAVBXvnQJVNdi924dA6aM
         1QCzY1mccq+ClAhb3RG+LMSq6NxE2qMlnD8m+O5Zk3Merw0/252adoeqokTa70fcXqSO
         XsBTYJ5Fn3ZPfhHeSmcGLSks7ZZjNu3T7whTsdSO+kNvJQqc2WhtnC1w/y3mssB++mAj
         i1Bm0FbOy0MCTqg8GdYrunhoaEVVRys92t6S7sbmj8U1a2cq+QwTNA3vyKUZATWkkj/h
         Ld4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=14TBO6qOq1fRQ+FbYLje80t5Pt+y91sZvBjhjHqXvZg=;
        b=OFcCDh63EYEjrromkpX+ap3VRQ9uqY0fBhTxeXtcqjrIVY6n7oTjmXHx952qr0oLv4
         RAAbS8XpDFMjybmF/ap6FAdYaB6X5OD8dE0oLpzWqZlpVvrfZWJ3jjnvMqBpIjYEGOpD
         coSOlDfJ6imanUZh5lIc0Tcd207aeDWSl6a5TgW8bP9szHxGfCKk7HViFA7AlJj3O2rm
         BeOG9ubuOcUrxSLtP3MuG01jxDayrWZvQ1vPGzV/DoL0ZyyWUrQiII2ma0WFiKTiZUTA
         IlMVEJhR30JWcU9+uF+dsxK0apRHpk/+OkyQm6neiVMc48nRCpptnpsgRQ9JEEuCTail
         Si+A==
X-Gm-Message-State: ACgBeo0/ShhD1TnRCOoY2xgKcuzZSvUytHxbomOGqVLCz/lLN6EODyj3
        SFzmaiXH2BBcgBN2cN6hxefCrzjyYKLzu7lMqYl4Ng==
X-Google-Smtp-Source: AA6agR6OS7pLRthOidAx+JKrQI9sTIIGI2hB3yGaQ1H1LxS+5UqWvryrXVrXGWMhaGy3M7MuQB/AFjdMDnQO1ughwLw=
X-Received: by 2002:a25:b849:0:b0:67b:93e9:2acc with SMTP id
 b9-20020a25b849000000b0067b93e92accmr7750153ybm.241.1660912548339; Fri, 19
 Aug 2022 05:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com> <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com> <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com> <20220818083133.GA536@vingu-book>
 <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com>
In-Reply-To: <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Aug 2022 14:35:37 +0200
Message-ID: <CAKfTPtBcJhC4qPQuK9g4bL0sgtmqkA3JZmnGJz7DaejsUPkOeg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
To:     "zhangsong (J)" <zhangsong34@huawei.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

Hi Zhang,

On Fri, 19 Aug 2022 at 12:54, zhangsong (J) <zhangsong34@huawei.com> wrote:
>
>
> On 2022/8/18 16:31, Vincent Guittot wrote:
> > Le jeudi 18 ao=C3=BBt 2022 =C3=A0 10:46:55 (+0800), Abel Wu a =C3=A9cri=
t :
> >> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
> >>> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> =
wrote:
> >>>>
> > ...
> >
> >>>> Yes, this is usually a corner case, but suppose that some non-idle t=
asks bounds to CPU 1-2
> >>>>
> >>>> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks a=
nd some non-idle
> >>>>
> >>>> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when tri=
gger load balance if
> >>>>
> >>>> CPU 2 should pull some tasks from CPU 1, the bad result is idle task=
s of CPU 1 cannot be
> >>>>
> >>>> migrated and non-idle tasks also cannot be migrated in case of env->=
loop_max constraint.
> >>> env->loop_max adds a break but load_balance will continue with next
> >>> tasks so it also tries to pull your non idle task at the end after
> >>> several breaks.
> >> Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :)
> > Argh yes, my brain is not yet back from vacation
> > I have been confused by loop_max and loop_break being set to the same v=
alue 32
> >
> > Zhang Song, Could you try the patch below ? If it works, I will prepare=
 a
> > clean patch with all tags
> >
> >
> >
> > sched/fair: make sure to try to detach at least one movable task
> >
> > During load balance we try at most env->loop_max time to move a task. B=
ut
> > it can happen that the LRU tasks (ie tail of the cfs_tasks list) can't
> > be moved to dst_cpu because of affinity. In this case, loop in the list
> > until we found at least one.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index da388657d5ac..02b7b808e186 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
> >               p =3D list_last_entry(tasks, struct task_struct, se.group=
_node);
> >
> >               env->loop++;
> > -             /* We've more or less seen every task there is, call it q=
uits */
> > -             if (env->loop > env->loop_max)
> > +             /*
> > +              * We've more or less seen every task there is, call it q=
uits
> > +              * unless we haven't found any movable task yet.
> > +              */
> > +             if (env->loop > env->loop_max &&
> > +                 !(env->flags & LBF_ALL_PINNED))
> >                       break;
> >
> >               /* take a breather every nr_migrate tasks */
> > @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq=
 *this_rq,
> >
> >               if (env.flags & LBF_NEED_BREAK) {
> >                       env.flags &=3D ~LBF_NEED_BREAK;
> > -                     goto more_balance;
> > +                     /* Stop if we tried all running tasks */
> > +                     if (env.loop < busiest->nr_running)
> > +                             goto more_balance;
> >               }
> >
> >               /*
> > --
> > 2.17.1
>
> Thanks for your reply.
> I have tried your patch and run test compared with it, it seems that the
> patch you provide makes no sense.
> The test result is below(1000 idle tasks bounds to CPU 0-1 and 10 normal
> tasks bounds to CPU 1-2):
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Without patch:
>
>
>            6,777.37 msec cpu-clock                 #    1.355 CPUs utiliz=
ed
>              20,812      context-switches          #    0.003 M/sec
>                   0      cpu-migrations            #    0.000 K/sec
>                   0      page-faults               #    0.000 K/sec
>      13,333,983,148      cycles                    #    1.967 GHz
>       6,457,930,305      instructions              #    0.48  insn per cy=
cle
>       2,125,644,649      branches                  #  313.639 M/sec
>           1,690,587      branch-misses             #    0.08% of all
> branches
>        5.001931983 seconds time elapsed
>
> With your patch:
>
>
>            6,791.46 msec cpu-clock                 #    1.358 CPUs utiliz=
ed
>              20,996      context-switches          #    0.003 M/sec
>                   0      cpu-migrations            #    0.000 K/sec
>                   0      page-faults               #    0.000 K/sec
>      13,467,573,052      cycles                    #    1.983 GHz
>       6,516,989,062      instructions              #    0.48  insn per cy=
cle
>       2,145,139,220      branches                  #  315.858 M/sec
>           1,751,454      branch-misses             #    0.08% of all
> branches
>
>         5.002274267 seconds time elapsed
>
> With my patch:
>
>
>            7,495.14 msec cpu-clock                 #    1.499 CPUs utiliz=
ed
>              23,176      context-switches          #    0.003 M/sec
>                 309      cpu-migrations            #    0.041 K/sec
>                   0      page-faults               #    0.000 K/sec
>      14,849,083,489      cycles                    #    1.981 GHz
>       7,180,832,268      instructions              #    0.48  insn per cy=
cle
>       2,363,300,644      branches                  #  315.311 M/sec
>           1,964,169      branch-misses             #    0.08% of all
> branches
>
>         5.001713352 seconds time elapsed
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Obviously,  when your patch is applied, the cpu-migrations of normal
> tasks is still 0 and the
> CPU ulization of normal tasks have no improvement compared with no patch
> applied.
> When apply my patch, the cpu-migrations and CPU ulization of normal
> tasks can both improve.
> I cannot explain the result with your patch, you also can test it by
> yourself.

Do you have more details about the test that your are running ?

Do cpu0-2 share their cache ?
Which kingd of task are the normal and idle tasks ? always running tasks ?

I'm going to try to reproduce your problem locally

Regards,
Vincent

>
> Best,
> Zhang Song
>
> >
> >>>> This will cause non-idle  tasks cannot achieve  more CPU utilization=
.
> >>> Your problem is not linked to IDLE vs NORMAL tasks but to the large
> >>> number of pinned tasks that can't migrate on CPU2. You can end with
> >>> the same behavior without using IDLE tasks but only NORMAL tasks.
> >> I feel the same thing.
> >>
> >> Best,
> >> Abel
> > .
