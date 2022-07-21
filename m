Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EE57CCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGUOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGUOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:11:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E8653D34
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:11:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53191042;
        Thu, 21 Jul 2022 07:11:07 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A601B3F73D;
        Thu, 21 Jul 2022 07:11:05 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:11:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use
 util_fits_cpu()
Message-ID: <20220721141104.3d4ohdyxxlqyttle@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-3-qais.yousef@arm.com>
 <CAB8ipk99oZNBP6kxSh6c+DrU-0tEX-wANYw3QDYHgES9AME38w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk99oZNBP6kxSh6c+DrU-0tEX-wANYw3QDYHgES9AME38w@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/22 15:23, Xuewen Yan wrote:
> On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > So that the new uclamp rules in regard to migration margin and capacity
> > pressure are taken into account correctly.
> >
> > To cater for update_sg_wakeup_stats() user, we add new
> > {min,max}_capacity_cpu to struct sched_group_capacity since
> > util_fits_cpu() takes the cpu rather than capacity as an argument.
> >
> > This includes updating capacity_greater() definition to take cpu as an
> > argument instead of capacity.
> >
> > Fixes: a7008c07a568 ("sched/fair: Make task_fits_capacity() consider uclamp restrictions")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/fair.c     | 67 ++++++++++++++++++++++++++---------------
> >  kernel/sched/sched.h    | 13 ++++++--
> >  kernel/sched/topology.c | 18 ++++++-----
> >  3 files changed, 64 insertions(+), 34 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5eecae32a0f6..313437bea5a2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -160,7 +160,7 @@ int __weak arch_asym_cpu_priority(int cpu)
> >   *
> >   * (default: ~5%)
> >   */
> > -#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
> > +#define capacity_greater(cpu1, cpu2) ((capacity_of(cpu1)) * 1024 > (capacity_of(cpu2)) * 1078)
> >  #endif
> >
> >  #ifdef CONFIG_CFS_BANDWIDTH
> > @@ -4317,10 +4317,12 @@ static inline int util_fits_cpu(unsigned long util,
> >         return fits;
> >  }
> >
> > -static inline int task_fits_capacity(struct task_struct *p,
> > -                                    unsigned long capacity)
> > +static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >  {
> > -       return fits_capacity(uclamp_task_util(p), capacity);
> > +       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > +       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > +       unsigned long util = task_util_est(p);
> > +       return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> >  }
> 
> May we should consider the CONFIG_UCLAMP_TASK...

The uclamp functions are protected with CONFIG_UCLAMP_TASK and should result in
dummy implementation and dead code to be compiled out.

It avoids sprinkling ifdefs all over the place this way.


Cheers

--
Qais Yousef
