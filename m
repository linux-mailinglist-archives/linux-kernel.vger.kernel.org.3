Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6077357C910
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiGUKfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiGUKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:35:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B4823A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1D1TNt+y52e8I+wqbglpFwxSIDJ0TYIEuP5FTx39Yo=; b=dr2GoOd0mq3CZ8Ux2Uan1oyT9E
        YKvT+ZLRogJjKVP/ka87islaEmsiCEnazbi07izitnEBmhhPnBTGZSdw+Z0Ms4ZnNZ58cqSdDaavD
        h6OMQvTkzyFVnw4ParCLGxq31+Rye4PzmffCkL7oIq4PlPIrYxocnyCEuiAxFHx2tQUB3CkZQ2W77
        sP/lQJU4KAG95iKxrpx6VLrBSk6aHngr6kieXqa6UpAyZKj5cI9o/VdCJVHXUqunzWJkr++Dyii69
        7450sNFuiDKk4QKzKZplrUWohKVa8U3lYOzlHz01qM/TpU/uf3OvNH4iylKhrshXX4dOHtlP6WV2x
        7+oiOuWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oETVH-005Wpc-M1; Thu, 21 Jul 2022 10:34:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42DB0980BBE; Thu, 21 Jul 2022 12:33:57 +0200 (CEST)
Date:   Thu, 21 Jul 2022 12:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>, hesham.almatary@huawei.com,
        john.garry@huawei.com, Yang Shen <shenyang39@huawei.com>,
        kprateek.nayak@amd.com, Chen Yu <yu.c.chen@intel.com>,
        wuyun.abel@bytedance.com
Subject: Re: [RESEND PATCH v5 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
Message-ID: <YtkrlVmqnx9VTbLl@worktop.programming.kicks-ass.net>
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
 <20220720081150.22167-3-yangyicong@hisilicon.com>
 <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
 <CAGsJ_4yrZnPbhBb4wd3x1h994tv6Jfri+y2xrPSJv7yF+Mj7tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yrZnPbhBb4wd3x1h994tv6Jfri+y2xrPSJv7yF+Mj7tg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 09:38:04PM +1200, Barry Song wrote:
> On Wed, Jul 20, 2022 at 11:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 20, 2022 at 04:11:50PM +0800, Yicong Yang wrote:
> > > +     /* TODO: Support SMT system with cluster topology */
> > > +     if (!sched_smt_active() && sd) {
> > > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> >
> > So that's no SMT and no wrap iteration..
> >
> > Does something like this work?
> >
> > ---
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_s
> >                 }
> >         }
> >
> > +       if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
> > +           static_branch_unlikely(&sched_cluster_active)) {
> > +               struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> > +               if (sdc) {
> > +                       for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> > +                               if (!cpumask_test_cpu(cpu, cpus))
> > +                                       continue;
> > +
> > +                               if (has_idle_core) {
> > +                                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > +                                       if ((unsigned int)i < nr_cpumask_bits)
> > +                                               return i;
> > +                               } else {
> > +                                       if (--nr <= 0)
> > +                                               return -1;
> > +                                       idle_cpu = __select_idle_cpu(cpu, p);
> > +                                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > +                                               break;
> 
> Guess here it should be "return idle_cpu", but not "break". as "break"
> will make us scan more
> other cpus outside the cluster if we have found idle_cpu within the cluster.
> 
> Yicong,
> Please test Peter's code with the above change.

Indeed. Sorry for that.
