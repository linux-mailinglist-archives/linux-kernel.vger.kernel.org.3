Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2259E81F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiHWQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiHWQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:51:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61712C346
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:20:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-335624d1e26so378771877b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=QIGSKuYLQvnoRMD21X8f0KlcYQCsHc0XFdlGpoyxlY0=;
        b=u88zHSjFkMS2UaNBS+f6bEExKv0NQw0HcSqK+qZeYH2uBkrkE738VU2uXzHvMFrgQc
         eQdicCUnJ4R09f7k+3blWF6oSxaQPKHzAgUmBH50LPsg5FinLX/1v/8w73zkClR8T4A6
         M+MjjwUS0C1Qn1RvOp1B9Q1P4lxzIMI9ivobvmBU1guPDSji9JlWQXdWNOs/fABxJ62a
         QbuNZxa8d4G/HHZBj1Z+ARaQRbrEBPSlB0tjI6loE3omXV991cDpSJ0APDrb6HcbTJ9Q
         InEMndKx9yadGVlA6yFRihmAaZGfZya5tkXuE+owu8dMZmpRSSeXcQInGrQRiM7A61VH
         4KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=QIGSKuYLQvnoRMD21X8f0KlcYQCsHc0XFdlGpoyxlY0=;
        b=nPFZYsdwdtfg/YwKSWrH4r1Kvhf/eAoPiGM0MECr5MpIyFjnBppCa7AY7sLGf757Uo
         YhORKuIm/06FgF6VaDHWVgk+m0xpt23rXQ1UevK24+U9Kj8y6C/cVLUETpsbC2gstOO8
         hmwLvXGhbxMT2330qdj2lovGhcxvs6GcRIZYGSJQnyJG4JLjxy162vRfS9pJK/RxP4iR
         EpEgZi4dzO42eWZEbbh1nKjqIXq4/rGHskZ6tcdGLmb31zDzYeLW/CI6ZaNATtYi9S5t
         3HbfHgAB2GwFi0SCEh7O7UAY1gFRH15hVVf04kZhmBbp5hybaMjf8kaqCd3/iM46IiSK
         Y0EQ==
X-Gm-Message-State: ACgBeo2iGdsD+wCAxbGEF9MtosX3s3S5aCqf2bsG2mrWfjLbjbHZVwVJ
        1kxtQhbbMdZEFuU1QFUFHCeA9j/vuSUxPzquyHwCBA==
X-Google-Smtp-Source: AA6agR7umPnPBPn9mJ6uNVVoqQQENBfXC8GfBEZHvRTsE1Wm8QpFsqDB4S/wR7Td/DSmkiFo/JturuYpC3Gmu9t5MUs=
X-Received: by 2002:a0d:d5c2:0:b0:337:5d95:8bcb with SMTP id
 x185-20020a0dd5c2000000b003375d958bcbmr24099626ywd.359.1661260801866; Tue, 23
 Aug 2022 06:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com> <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com> <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com> <20220818083133.GA536@vingu-book>
 <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com> <CAKfTPtBcJhC4qPQuK9g4bL0sgtmqkA3JZmnGJz7DaejsUPkOeg@mail.gmail.com>
 <CAKfTPtBEaaLUdapJRvPFX3UZrkynRUfdDg6dAZ_vm2OK9eN0Fg@mail.gmail.com> <919c20ad-6785-59e4-e39a-a345346fb550@huawei.com>
In-Reply-To: <919c20ad-6785-59e4-e39a-a345346fb550@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 15:19:49 +0200
Message-ID: <CAKfTPtBTdmPQsC-RiOXbnMVsfz0P7tex7JMcHOsjtAN6uEri3A@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

On Mon, 22 Aug 2022 at 08:49, zhangsong (J) <zhangsong34@huawei.com> wrote:
>
> Hi, Vincent,
>
> On 2022/8/20 0:04, Vincent Guittot wrote:
> > On Fri, 19 Aug 2022 at 14:35, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> Hi Zhang,
> >>
> >> On Fri, 19 Aug 2022 at 12:54, zhangsong (J) <zhangsong34@huawei.com> w=
rote:
> >>>
> >>>
> >>> On 2022/8/18 16:31, Vincent Guittot wrote:
> >>>> Le jeudi 18 ao=C3=BBt 2022 =C3=A0 10:46:55 (+0800), Abel Wu a =C3=A9=
crit :
> >>>>> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
> >>>>>> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.co=
m> wrote:
> >>>>>>>
> >>>> ...

...

> >>>
> >>> Thanks for your reply.
> >>> I have tried your patch and run test compared with it, it seems that =
the
> >>> patch you provide makes no sense.
> >>> The test result is below(1000 idle tasks bounds to CPU 0-1 and 10 nor=
mal
> >>> tasks bounds to CPU 1-2):
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> Without patch:
> >>>
> >>>
> >>>             6,777.37 msec cpu-clock                 #    1.355 CPUs u=
tilized
> >>>               20,812      context-switches          #    0.003 M/sec
> >>>                    0      cpu-migrations            #    0.000 K/sec
> >>>                    0      page-faults               #    0.000 K/sec
> >>>       13,333,983,148      cycles                    #    1.967 GHz
> >>>        6,457,930,305      instructions              #    0.48  insn p=
er cycle
> >>>        2,125,644,649      branches                  #  313.639 M/sec
> >>>            1,690,587      branch-misses             #    0.08% of all
> >>> branches
> >>>         5.001931983 seconds time elapsed
> >>>
> >>> With your patch:
> >>>
> >>>
> >>>             6,791.46 msec cpu-clock                 #    1.358 CPUs u=
tilized
> >>>               20,996      context-switches          #    0.003 M/sec
> >>>                    0      cpu-migrations            #    0.000 K/sec
> >>>                    0      page-faults               #    0.000 K/sec
> >>>       13,467,573,052      cycles                    #    1.983 GHz
> >>>        6,516,989,062      instructions              #    0.48  insn p=
er cycle
> >>>        2,145,139,220      branches                  #  315.858 M/sec
> >>>            1,751,454      branch-misses             #    0.08% of all
> >>> branches
> >>>
> >>>          5.002274267 seconds time elapsed
> >>>
> >>> With my patch:
> >>>
> >>>
> >>>             7,495.14 msec cpu-clock                 #    1.499 CPUs u=
tilized
> >>>               23,176      context-switches          #    0.003 M/sec
> >>>                  309      cpu-migrations            #    0.041 K/sec
> >>>                    0      page-faults               #    0.000 K/sec
> >>>       14,849,083,489      cycles                    #    1.981 GHz
> >>>        7,180,832,268      instructions              #    0.48  insn p=
er cycle
> >>>        2,363,300,644      branches                  #  315.311 M/sec
> >>>            1,964,169      branch-misses             #    0.08% of all
> >>> branches
> >>>
> >>>          5.001713352 seconds time elapsed
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> Obviously,  when your patch is applied, the cpu-migrations of normal
> >>> tasks is still 0 and the
> >>> CPU ulization of normal tasks have no improvement compared with no pa=
tch
> >>> applied.
> >>> When apply my patch, the cpu-migrations and CPU ulization of normal
> >>> tasks can both improve.
> >>> I cannot explain the result with your patch, you also can test it by
> >>> yourself.
> >>
> >> Do you have more details about the test that your are running ?
> >>
> >> Do cpu0-2 share their cache ?
> >> Which kingd of task are the normal and idle tasks ? always running tas=
ks ?
> >>
> >> I'm going to try to reproduce your problem locally
> >
> > Some details of your UC are missing. I have tried to reproduce your
> > example above:
> >      1000 idle tasks bounds to CPU 0-1 and 10 normal tasks bounds to CP=
U 1-2
> >
> > Let assume that for any reason, the 10 normal tasks wake up on CPU 1.
> > Then, the thousand of idle tasks are moved to CPU0 by load balance and
> > only normal tasks stay on CPU1. Then load balance will move some
> > normal tasks to CPU2.
> >
> > My only way to reproduce something similar to your example, is to pin
> > the 1000 idle tasks on CPU1 so they can't move to CPU0. Then I can see
> > that load balance reaches loop_max limit and gets hard time moving
> > normal tasks on CPU2. But in this later case, my patch helps to move
> > normal tasks on CPU2. Something is missing in the description of your
> > UC.
> >
> > Sidenote, I have the same kind of problem with 1000 normal task with
> > low priority so it's not a matter of idle vs normal tasks
> >
> > Regards,
> > Vincent
> >
>
> Sorry for my slow reply.
>
> I have found a test case which can more illustrate this problem
> accurately. The test case is below.
>
> 1. a dead foreach loop process run as normal or idle task
> $ cat test.c
> int main(int argc, char **argv)
> {
>          int i =3D 0;
>          int duration =3D atoi(argv[1]);
>
>          while(1) {
>                  usleep(duration);
>                  for(i =3D 0; i < 100000; i++) {}
>          }
> }
> $ gcc -o test test.c
>
> 2. firstly spawn 500 idle tasks which bounds to CPU 0-2
> 3. secondly spawn 10 normal tasks which also bounds to CPU 0-2
> 4. lastly spawn 500 idle tasks which bounds to CPU 0 only
> 5. perf stat normal tasks and get CPU utilization and cpu-migrations
>
>
> Below is the whole test script.
> $ cat test.sh
> #!/bin/bash
>
> # create normal and idle cgroup path
> mkdir /sys/fs/cgroup/cpu/normal/
> mkdir /sys/fs/cgroup/cpu/idle/

so you put "idle" tasks in a task group and normal tasks in another
one. But both groups have default weight/share so you lose the idle
weight for idle tasks and each group will have half the cpus capacity,
i.e. 1.5 cpus per group. And this is  what I have with the current
kernel, with your patch or with my patch.

In fact, there is enough tasks (510) not pinned to cpu0 to make the
system balance correctly

With this group hierarchy, the idle tasks will have the same weight
priority as normal tasks. Is it really what you want ?

tip kernel:
          7 673,15 msec task-clock                #    1,534 CPUs
utilized
            12 662      context-switches          #    1,650 K/sec
                 0      cpu-migrations            #    0,000 /sec
       5,003493176 seconds time elapsed

your patch:
          7 488,35 msec task-clock                #    1,497 CPUs
utilized
            12 338      context-switches          #    1,648 K/sec
                 3      cpu-migrations            #    0,401 /sec
       5,003406005 seconds time elapsed

my patch
          7 569,57 msec task-clock                #    1,513 CPUs
utilized
            12 460      context-switches          #    1,646 K/sec
                 0      cpu-migrations            #    0,000 /sec
       5,003437278 seconds time elapsed


>
> # spawn 500 idle tasks and bind tasks to CPU 0-2
> for ((i =3D 0; i < 500; i++))
> do
>                 taskset -c 0-2 ./test 200 &
>                 pid=3D$!
>                 # change to SCHED_IDLE policy
>                 chrt -i -p 0 $pid
>                 echo $pid > /sys/fs/cgroup/cpu/idle/tasks
> done
>
> # spawn 10 normal tasks and bind tasks to CPU 0-2
> normal_tasks=3D
> for ((i =3D 0; i < 10; i++))
> do
>                 taskset -c 0-2 ./test 500 &
>                 pid=3D$!
>                 normal_tasks+=3D$pid,
>                 echo $pid > /sys/fs/cgroup/cpu/normal/tasks
> done
>
> # spawn 500 idle tasks and bind tasks to CPU 0 only
> for ((i =3D 0; i < 500; i++))
> do
>                 taskset -c 0 ./test 200 &
>                 pid=3D$!
>                 # change to SCHED_IDLE policy
>                 chrt -i -p 0 $pid
>                 echo $pid > /sys/fs/cgroup/cpu/idle/tasks
> done
>
> # perf stat normal tasks
> perf stat -a -p $normal_tasks sleep 5
> pkill -f test
>
>
> You can try the above case and test it with your patch.
>
> Regards,
> Zhang Song
