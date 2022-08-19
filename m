Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8EC59A248
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353042AbiHSQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353068AbiHSQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A111C948
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:04:44 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33365a01f29so133308577b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=YXESTZDcUiCGjixm/Ny1l24ykaWVY7si0JYAd8lcp3k=;
        b=vjvUTlreFnl+R/d8XSKBiZ/HMOzY8RhSkaWyUhuA7RH5KzDVHAxqQti9Ie8k+T9/V7
         KPcBrgI4wg/sNGfjHAX5FoEJ4nprCvePmP4jHIePmB7QPxH4oK8HjgK8qOs4wziLVTdy
         jmq5tKcJw5QppeAFBtK1CbWMJ5iD9BTEV6lmoZfbNI8QAppsxwYxhmIC7AUe8S5agRxi
         pbXa2VZLHbXKoxrhs20QuoD3jMLCPLQNXMJc9UII8AFWHVw1VoZMejEOfBb7chsFw4yf
         7T9yrOfD5LtNkvKJlxlckc/z356d/LFYXnoJptfvcSwltahwkhx/WhPldiRrVC2mB7Jg
         XUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=YXESTZDcUiCGjixm/Ny1l24ykaWVY7si0JYAd8lcp3k=;
        b=MdQraR0D33pHrp9BFVeQEvF03kvB1OAik28i2TbnYcifp2QxY7+CB1fBANqGtaLmPD
         2vlvtpwsWuYZKaNyh6vZAIj9NBnC76OAIdbD48jAHc6XqaROhj1QNo9M0I+gJl3pPWem
         CSg9/TIdtZZSVS9nQpBm3PAk7SCHLPwbi21DUFAXneC6DBPBJz2s2Qx261nBye5Rn2Ot
         OsfSv3dR36U/1bIgqHbP1t7svOhZ/dHrxR6S+XKDp6fr1ahfKt3FkTRfXYywQnHbeAyI
         q2rc/OkFmAWdG151PV67qhHRjT6E8DrM0naGfaRQn+1JCL0n/jFHyoyc4us0X3GQQqic
         kwhA==
X-Gm-Message-State: ACgBeo10Fo5LDvlQeNx7wi173vjPQccU0o7oM67bsPoNhi/fMdBtxJYp
        KxO/+e30e8qdSjlW2RUDZ+pNifiVV2HAR8Wk06ztJA==
X-Google-Smtp-Source: AA6agR6xNZR5qwP6Wv5QjmvYXeeeU1W9XRwFIR12aoZAvBVU1o7AcPGSKes3sCd6zBd3CuneYT0a8C6g3NxlGiw1vUE=
X-Received: by 2002:a0d:cb02:0:b0:334:e16c:8d36 with SMTP id
 n2-20020a0dcb02000000b00334e16c8d36mr8459357ywd.86.1660925082827; Fri, 19 Aug
 2022 09:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com> <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com> <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com> <20220818083133.GA536@vingu-book>
 <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com> <CAKfTPtBcJhC4qPQuK9g4bL0sgtmqkA3JZmnGJz7DaejsUPkOeg@mail.gmail.com>
In-Reply-To: <CAKfTPtBcJhC4qPQuK9g4bL0sgtmqkA3JZmnGJz7DaejsUPkOeg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Aug 2022 18:04:30 +0200
Message-ID: <CAKfTPtBEaaLUdapJRvPFX3UZrkynRUfdDg6dAZ_vm2OK9eN0Fg@mail.gmail.com>
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

On Fri, 19 Aug 2022 at 14:35, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Zhang,
>
> On Fri, 19 Aug 2022 at 12:54, zhangsong (J) <zhangsong34@huawei.com> wrot=
e:
> >
> >
> > On 2022/8/18 16:31, Vincent Guittot wrote:
> > > Le jeudi 18 ao=C3=BBt 2022 =C3=A0 10:46:55 (+0800), Abel Wu a =C3=A9c=
rit :
> > >> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
> > >>> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com=
> wrote:
> > >>>>
> > > ...
> > >
> > >>>> Yes, this is usually a corner case, but suppose that some non-idle=
 tasks bounds to CPU 1-2
> > >>>>
> > >>>> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks=
 and some non-idle
> > >>>>
> > >>>> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when t=
rigger load balance if
> > >>>>
> > >>>> CPU 2 should pull some tasks from CPU 1, the bad result is idle ta=
sks of CPU 1 cannot be
> > >>>>
> > >>>> migrated and non-idle tasks also cannot be migrated in case of env=
->loop_max constraint.
> > >>> env->loop_max adds a break but load_balance will continue with next
> > >>> tasks so it also tries to pull your non idle task at the end after
> > >>> several breaks.
> > >> Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :=
)
> > > Argh yes, my brain is not yet back from vacation
> > > I have been confused by loop_max and loop_break being set to the same=
 value 32
> > >
> > > Zhang Song, Could you try the patch below ? If it works, I will prepa=
re a
> > > clean patch with all tags
> > >
> > >
> > >
> > > sched/fair: make sure to try to detach at least one movable task
> > >
> > > During load balance we try at most env->loop_max time to move a task.=
 But
> > > it can happen that the LRU tasks (ie tail of the cfs_tasks list) can'=
t
> > > be moved to dst_cpu because of affinity. In this case, loop in the li=
st
> > > until we found at least one.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >   kernel/sched/fair.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index da388657d5ac..02b7b808e186 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
> > >               p =3D list_last_entry(tasks, struct task_struct, se.gro=
up_node);
> > >
> > >               env->loop++;
> > > -             /* We've more or less seen every task there is, call it=
 quits */
> > > -             if (env->loop > env->loop_max)
> > > +             /*
> > > +              * We've more or less seen every task there is, call it=
 quits
> > > +              * unless we haven't found any movable task yet.
> > > +              */
> > > +             if (env->loop > env->loop_max &&
> > > +                 !(env->flags & LBF_ALL_PINNED))
> > >                       break;
> > >
> > >               /* take a breather every nr_migrate tasks */
> > > @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct =
rq *this_rq,
> > >
> > >               if (env.flags & LBF_NEED_BREAK) {
> > >                       env.flags &=3D ~LBF_NEED_BREAK;
> > > -                     goto more_balance;
> > > +                     /* Stop if we tried all running tasks */
> > > +                     if (env.loop < busiest->nr_running)
> > > +                             goto more_balance;
> > >               }
> > >
> > >               /*
> > > --
> > > 2.17.1
> >
> > Thanks for your reply.
> > I have tried your patch and run test compared with it, it seems that th=
e
> > patch you provide makes no sense.
> > The test result is below(1000 idle tasks bounds to CPU 0-1 and 10 norma=
l
> > tasks bounds to CPU 1-2):
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Without patch:
> >
> >
> >            6,777.37 msec cpu-clock                 #    1.355 CPUs util=
ized
> >              20,812      context-switches          #    0.003 M/sec
> >                   0      cpu-migrations            #    0.000 K/sec
> >                   0      page-faults               #    0.000 K/sec
> >      13,333,983,148      cycles                    #    1.967 GHz
> >       6,457,930,305      instructions              #    0.48  insn per =
cycle
> >       2,125,644,649      branches                  #  313.639 M/sec
> >           1,690,587      branch-misses             #    0.08% of all
> > branches
> >        5.001931983 seconds time elapsed
> >
> > With your patch:
> >
> >
> >            6,791.46 msec cpu-clock                 #    1.358 CPUs util=
ized
> >              20,996      context-switches          #    0.003 M/sec
> >                   0      cpu-migrations            #    0.000 K/sec
> >                   0      page-faults               #    0.000 K/sec
> >      13,467,573,052      cycles                    #    1.983 GHz
> >       6,516,989,062      instructions              #    0.48  insn per =
cycle
> >       2,145,139,220      branches                  #  315.858 M/sec
> >           1,751,454      branch-misses             #    0.08% of all
> > branches
> >
> >         5.002274267 seconds time elapsed
> >
> > With my patch:
> >
> >
> >            7,495.14 msec cpu-clock                 #    1.499 CPUs util=
ized
> >              23,176      context-switches          #    0.003 M/sec
> >                 309      cpu-migrations            #    0.041 K/sec
> >                   0      page-faults               #    0.000 K/sec
> >      14,849,083,489      cycles                    #    1.981 GHz
> >       7,180,832,268      instructions              #    0.48  insn per =
cycle
> >       2,363,300,644      branches                  #  315.311 M/sec
> >           1,964,169      branch-misses             #    0.08% of all
> > branches
> >
> >         5.001713352 seconds time elapsed
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Obviously,  when your patch is applied, the cpu-migrations of normal
> > tasks is still 0 and the
> > CPU ulization of normal tasks have no improvement compared with no patc=
h
> > applied.
> > When apply my patch, the cpu-migrations and CPU ulization of normal
> > tasks can both improve.
> > I cannot explain the result with your patch, you also can test it by
> > yourself.
>
> Do you have more details about the test that your are running ?
>
> Do cpu0-2 share their cache ?
> Which kingd of task are the normal and idle tasks ? always running tasks =
?
>
> I'm going to try to reproduce your problem locally

Some details of your UC are missing. I have tried to reproduce your
example above:
    1000 idle tasks bounds to CPU 0-1 and 10 normal tasks bounds to CPU 1-2

Let assume that for any reason, the 10 normal tasks wake up on CPU 1.
Then, the thousand of idle tasks are moved to CPU0 by load balance and
only normal tasks stay on CPU1. Then load balance will move some
normal tasks to CPU2.

My only way to reproduce something similar to your example, is to pin
the 1000 idle tasks on CPU1 so they can't move to CPU0. Then I can see
that load balance reaches loop_max limit and gets hard time moving
normal tasks on CPU2. But in this later case, my patch helps to move
normal tasks on CPU2. Something is missing in the description of your
UC.

Sidenote, I have the same kind of problem with 1000 normal task with
low priority so it's not a matter of idle vs normal tasks

Regards,
Vincent

>
> Regards,
> Vincent
>
> >
> > Best,
> > Zhang Song
> >
> > >
> > >>>> This will cause non-idle  tasks cannot achieve  more CPU utilizati=
on.
> > >>> Your problem is not linked to IDLE vs NORMAL tasks but to the large
> > >>> number of pinned tasks that can't migrate on CPU2. You can end with
> > >>> the same behavior without using IDLE tasks but only NORMAL tasks.
> > >> I feel the same thing.
> > >>
> > >> Best,
> > >> Abel
> > > .
