Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE334F1259
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354905AbiDDJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiDDJzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:55:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD313AA44
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:53:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 5so16244200lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9AE95uUctgpJ2Ztw4T/0G1d2ZfGrjEvIvqQC9xYXFY=;
        b=XCwBuvynzYD3NaViA5kVBbsBLcSF/T11BqYr07glF1nuRIcZZqxo9rPsvwTv4BucbN
         wER5U0sLZLxlSSefnnMx4tA9SqjSRMtHCzAj0Zu7YFyUGPIXhtFn4Rtwj8tfuWRiyeCv
         fcJGCwX5i6lCWO4e5fBREBDHw6SeP1CrzDl03w1sq6qCIfeoEkD+XUBy3VEnuvHhm+mX
         M5aDPgKNE3mJkINZe7C0BCIqW2szfAMCxps7Vt5hJjK3FxOObtji+iK222O1G0gRxO5H
         p7md8VAXoXHlrKko2wo4vUoYVAPg5UxVU5QkGkx6hkU2Dz9Nm1RMhiL2dLwsQt3OfasM
         Tu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9AE95uUctgpJ2Ztw4T/0G1d2ZfGrjEvIvqQC9xYXFY=;
        b=520pzgq2xgLoN8YTxqw2I/yXdv/7KJFKPiRyNjqTnVsr9lIm1Y1/LX3n0yEvTDd8Sr
         LZ3KaWW6ai9chY/MBLvxWwo24gsHWsoBnORfxIrxElDTnyK1tTYUk7MiF2HANRrHgQZq
         lIzFZOIXhHN32PXYXC7KyqBkokphPWdeVPRyvWMDQqN0JPhrAtLcuZvGJwBRcdgCnHN4
         TeZDiapBAutV5v64BKv9ao4ZGIndDt77WgcN1HUWXNqjYZ3EstOL/GqeoSAeL+R+XG0I
         k+HMd6JoKxSR5HhUrDSH8HdyLttP9Gia/KuLd2p3dTCa4GL/7S3xvY3230j+e+BTIrma
         ORXA==
X-Gm-Message-State: AOAM531JfbA3MAiGOlXLGQrZxZQje8+89RuVaQNC1aAm2krIH+aTxbef
        dWxZiEF6qQI3iDqbh5u0JFTd3F8ANcCsHAiVizf+kQ==
X-Google-Smtp-Source: ABdhPJwGitnLgnZiI9JjKisnMrZ7/XNl7rW/Q0iSPsRm0XivW5wgWiQFR/cul0erMvu4E9LJH7DNtICHK3o0TXPdv4I=
X-Received: by 2002:a19:3801:0:b0:444:150b:9ef5 with SMTP id
 f1-20020a193801000000b00444150b9ef5mr21185111lfa.523.1649065982714; Mon, 04
 Apr 2022 02:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020> <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
 <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com> <CADjb_WQL7ZTSrThgFHtoF2apwwqio8wgwGYmCOq9LBfamo3D0Q@mail.gmail.com>
In-Reply-To: <CADjb_WQL7ZTSrThgFHtoF2apwwqio8wgwGYmCOq9LBfamo3D0Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Apr 2022 11:52:51 +0200
Message-ID: <CAKfTPtBEcbiqaOjY9jEAWoJH5VSixunQ_r6DcDHcp2cej9QFVA@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Huang Ying <ying.huang@intel.com>,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
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

On Fri, 1 Apr 2022 at 20:32, Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 12:17 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 31 Mar 2022 at 16:19, Chen Yu <yu.chen.surf@gmail.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec due to commit:
> > > >
> > > >
> > > > commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync of load_sum with load_avg")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > >
> > > > in testcase: stress-ng
> > > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> > > > with following parameters:
> > > >
> > > >         nr_threads: 100%
> > > >         testtime: 60s
> > > >         class: memory
> > > >         test: pipeherd
> > > >         cpufreq_governor: performance
> > > >         ucode: 0xd000280
> > > >
> > > This week we have re-run the test result and it seems that this
> > > regression is still there.
> > > As we are evaluating whether this report is valid or if the
> > > downgrading is expected, appreciated
> > > if you could give suggestion on further steps:
> > >
> > > 1.  If I understand correctly,
> > > 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
> > > of load_sum with load_avg")
> > >      fixed the calculating of  load_sum.  Before this patch  the
> > > contribution part would be 'skipped' and caused the load_sum
> > >      to be lower than expected.
> >
> > Yes, you understand it correctly
> >
> > > 2. If above is true, after this patch, the load_sum becomes higher. Is
> > > there a scenario that higher load_sum added to 1 cfs_rq brings
> > >     more imbalance between this group and other sched_group, thus
> > > brings more task migration/wake up? (because in below perf result,
> > >     it seems that, with this patch applied, there are slightly more
> > > take wake up)
> >
> > This change should not impact load balance as it only does comparison
> > and I expect the load increase to happen on all cfs rq.
> > The only place that could be impacted, would be wake_affine_weight()
> > because it removes task load from previous cfs rq load before
> > comparing.
> > The task's load was not impacted by the underestimate which means that
> > the load of prev cfs  might be seen lower than current cfs after
> > subtracting the task's load whereas both cfs rqs were similarly
> > underestimated.
> > Now the load of prev cfs rq is not underestimated and becomes
> > comparable or slightly higher than the current cfs and the task
> > migrate on current cfs instead of staying on prev one at wakeup
> >
> Could you please elaborate a little more on this scenario, since both current
> and previous cfs rqs were underestimated, how could previous cfs rq has
> lower load than the current one before applying this patch?
>
> Say, suppose the previous cfs rq has a load of L1, and current cfs rq has
> a load of L2, the waken task has a load of h, then wake_affine_weight()
> compares L1 - h  with L2 + h ,  when L1 < L2 + 2h, the task will remain on
> previous CPU.  Since L1 and L2 were underestimated in the same scale,
> I'm not quite sure how this patch would affect the choice between
> prev and current CPU.

Let's take the example of  this_cpu load L1 = 0 and prev_cpu load L2 =
2h'+d. h' reflects h in the cpu load and d is a small delta load. The
task will migrate if we have the condition below:

    h < 2h'-h+d

With this patch, we assume that h' == h as we don't underestimate the
load of cfs rqs anymore. The condition for migrating the task is :
    h < h+d
And the task will migrate on this cpu as soon as there is a small load
on prev_cpu in addition to the 2h.

Without the patch, the load of cfs_rqs are underestimated which means
that the task's load is underestimated in the cfs rq. This can be
described as h'  == h-U. U being the underestimated part. In this case
the condition to migrate the task becomes:
    h < h-2U+d
The task will migrate on this cpu is d is large enough to compensate
the underestimation so we will migrate less often

> > One possible test would be to run the test with WA_WEIGHT features
> > disable and check if there is still a difference
> >
> Yes, after disabling WA_WEIGHT, the performance came back.
> The following score is the output of stress-ng.pipeherd.ops_per_sec
>
> WA_WEIGHT                 yes                        no
> -------------------
> patched
>         yes                      58069733.01          69940547.7*
>         no                        64591593.69          73503396.9
>
> --
> Thanks,
> Chenyu
