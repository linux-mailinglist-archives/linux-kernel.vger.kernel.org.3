Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334C4F913B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiDHI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiDHI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:59:35 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B6FE436
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:57:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5e9025c20so88366907b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hr6J2iPWEM1G7f/GWAb9UseXtfq7g0i2J/Jf0pGrEeA=;
        b=CfKyNLLdlzoSnVWbuL18jbZh3k0NYHmE7xz045BxLpwzVB9xiTBJj+vaXYCc60dVLe
         37hsTlNWhWYDkm89uCYX1VpAU1EYe+M4MrAIaAwfRUVrG/yKVYc+GUE7PvjQPJr/NS88
         94dgmwQaVU8clCz9YdZLWbBm6Rx23DefakRwti6+VHFBjUVpdRjWlJWruxeAGohZTyKq
         xOI0XYdcjaV7wG9ewnsuvFGDEh20mYLpakYUrLm2qu/DDt/ESy63epRA30Xw9VhwCYGp
         xWAVSOxBc07s8i7t6NYqZU5ApSCSI3p2LvH1A2HSfvXr4VAMJ1JGJunwVAnDp7Gk21oS
         zzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hr6J2iPWEM1G7f/GWAb9UseXtfq7g0i2J/Jf0pGrEeA=;
        b=cLeCBOPjUFDrPxd8T6XDpJIwALRga6/uuYCcAUc1JczNycWZYToinhA2YWR6vYgEIM
         BNgrK+q4vEyPmdCNplf/6NhmmVeauu3b/o8t1pfVHSHwTJq9LTnsph6c1nqvl05k2iwm
         nGIIZnYDxVgNm46eeWOOqOyWV3aAPadIAyo0EIJWPFZW6zvTliYpPjm/nwaCykUEK7US
         jPKisuaDWR8JEaw6gc3gZWjEtQXHVIRy6MEmlrKD8uGiSMUdvJygU1MDuh6tO3gsogX4
         C7+wwrCDo+n+675fm1UVvTtdjaCv869DIgYrn7wsxt3QANTbiUXvIwJ54kG1eb6yArwO
         DFwA==
X-Gm-Message-State: AOAM530ZFt+vIGT8mlxT/0p8WA7B2F3Ft2xg8d0nSXl6ciQcUBKOVqj2
        idxocV+6PAumfYB9UirZuzKSl4ppFHXZ1gCKDN0IRzlz94E=
X-Google-Smtp-Source: ABdhPJwsUiUt8HXafvzY8HWkiqUJqhCSoXJGUTMwW6nSVzoIY4h8nywnaQNGIe/XjW5dGwphFcZ4DS0lG+mTgRIwoxY=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr15578498ywf.86.1649408251125; Fri, 08
 Apr 2022 01:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020> <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
 <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com>
 <CADjb_WQL7ZTSrThgFHtoF2apwwqio8wgwGYmCOq9LBfamo3D0Q@mail.gmail.com>
 <CAKfTPtBEcbiqaOjY9jEAWoJH5VSixunQ_r6DcDHcp2cej9QFVA@mail.gmail.com> <CADjb_WRbm3pt9kqhPKhTRSAcJFt1whaKw2MMMyYzkdW=rDXFdA@mail.gmail.com>
In-Reply-To: <CADjb_WRbm3pt9kqhPKhTRSAcJFt1whaKw2MMMyYzkdW=rDXFdA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Apr 2022 10:57:19 +0200
Message-ID: <CAKfTPtCCLH8dHx=J7mUNthbu785nr5d1LkZz6z6cG9BK85LFcA@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        0day robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>, tim.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 16:23, Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> On Mon, Apr 4, 2022 at 5:53 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 1 Apr 2022 at 20:32, Chen Yu <yu.chen.surf@gmail.com> wrote:
> > >
> > > On Fri, Apr 1, 2022 at 12:17 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Thu, 31 Mar 2022 at 16:19, Chen Yu <yu.chen.surf@gmail.com> wrote:
> > > > >
> > > > > Hi Vincent,
> > > > >
> > > > > On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > Greeting,
> > > > > >
> > > > > > FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec due to commit:
> > > > > >
> > > > > >
> > > > > > commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync of load_sum with load_avg")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > >
> > > > > > in testcase: stress-ng
> > > > > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> > > > > > with following parameters:
> > > > > >
> > > > > >         nr_threads: 100%
> > > > > >         testtime: 60s
> > > > > >         class: memory
> > > > > >         test: pipeherd
> > > > > >         cpufreq_governor: performance
> > > > > >         ucode: 0xd000280
> > > > > >
> > > > > This week we have re-run the test result and it seems that this
> > > > > regression is still there.
> > > > > As we are evaluating whether this report is valid or if the
> > > > > downgrading is expected, appreciated
> > > > > if you could give suggestion on further steps:
> > > > >
> > > > > 1.  If I understand correctly,
> > > > > 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
> > > > > of load_sum with load_avg")
> > > > >      fixed the calculating of  load_sum.  Before this patch  the
> > > > > contribution part would be 'skipped' and caused the load_sum
> > > > >      to be lower than expected.
> > > >
> > > > Yes, you understand it correctly
> > > >
> > > > > 2. If above is true, after this patch, the load_sum becomes higher. Is
> > > > > there a scenario that higher load_sum added to 1 cfs_rq brings
> > > > >     more imbalance between this group and other sched_group, thus
> > > > > brings more task migration/wake up? (because in below perf result,
> > > > >     it seems that, with this patch applied, there are slightly more
> > > > > take wake up)
> > > >
> > > > This change should not impact load balance as it only does comparison
> > > > and I expect the load increase to happen on all cfs rq.
> > > > The only place that could be impacted, would be wake_affine_weight()
> > > > because it removes task load from previous cfs rq load before
> > > > comparing.
> > > > The task's load was not impacted by the underestimate which means that
> > > > the load of prev cfs  might be seen lower than current cfs after
> > > > subtracting the task's load whereas both cfs rqs were similarly
> > > > underestimated.
> > > > Now the load of prev cfs rq is not underestimated and becomes
> > > > comparable or slightly higher than the current cfs and the task
> > > > migrate on current cfs instead of staying on prev one at wakeup
> > > >
> > > Could you please elaborate a little more on this scenario, since both current
> > > and previous cfs rqs were underestimated, how could previous cfs rq has
> > > lower load than the current one before applying this patch?
> > >
> > > Say, suppose the previous cfs rq has a load of L1, and current cfs rq has
> > > a load of L2, the waken task has a load of h, then wake_affine_weight()
> > > compares L1 - h  with L2 + h ,  when L1 < L2 + 2h, the task will remain on
> > > previous CPU.  Since L1 and L2 were underestimated in the same scale,
> > > I'm not quite sure how this patch would affect the choice between
> > > prev and current CPU.
> >
> > Let's take the example of  this_cpu load L1 = 0 and prev_cpu load L2 =
> > 2h'+d. h' reflects h in the cpu load and d is a small delta load. The
> > task will migrate if we have the condition below:
> >
> >     h < 2h'-h+d
> >
> > With this patch, we assume that h' == h as we don't underestimate the
> > load of cfs rqs anymore. The condition for migrating the task is :
> >     h < h+d
> > And the task will migrate on this cpu as soon as there is a small load
> > on prev_cpu in addition to the 2h.
> >
> > Without the patch, the load of cfs_rqs are underestimated which means
> > that the task's load is underestimated in the cfs rq. This can be
> > described as h'  == h-U. U being the underestimated part. In this case
> > the condition to migrate the task becomes:
> >     h < h-2U+d
> > The task will migrate on this cpu is d is large enough to compensate
> > the underestimation so we will migrate less often
> >
> I see. Thanks for this example! So in this scenario when previous CPU
> has some higher load than the current CPU, without this patch applied,
> the OS would have more chances to keep the task on the previous CPU,
> thus less migration and less rq lock contention(according to the perf result).
> I don't have a good idea in mind on how to deal with this case, except that
> by disabling WA_WEIGHT or WA_BIAS(prefer 'this' CPU I suppose).

I don't think that there is any good solution for this bench. It was
taking advantage of the underestimated load_avg because it seems that
it doesn't like to migrate on local cpu but on the other side, some
benches will take advantage of this migration.

Thanks
Vincent
>
> --
> Thanks,
> Chenyu
