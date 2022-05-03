Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B31518706
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiECOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiECOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:47:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC21A38D80
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:43:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2881042;
        Tue,  3 May 2022 07:43:55 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0EB43F774;
        Tue,  3 May 2022 07:43:53 -0700 (PDT)
Date:   Tue, 3 May 2022 15:43:52 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
References: <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu>
 <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
 <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu>
 <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu>
 <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

On 05/01/22 11:20, Xuewen Yan wrote:
> Hi Qais
> Thanks for the patient explanation.:)
> And I have some other concerns.
> 
> On Wed, Apr 27, 2022 at 6:58 PM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 04/27/22 09:38, Xuewen Yan wrote:
> > > > > > The best (simplest) way forward IMHO is to introduce a new function
> > > > > >
> > > > > >         bool cpu_in_capacity_inversion(int cpu);
> 
> Maybe the implementation of this function, I have not thought of a
> good solution.
> (1)how to define the inversion, if the cpu has two
> cluster(little/big)，it is easy, but still need mark which is the big
> cpu...

I'd define it as:

	capacity_orig_of(cpu) - thermal_pressure(cpu) < capacity_orig_of(next_level_cpu)

> (2)because the mainline kernel should be common, if the cpu has three
> or more clusters, maybe the mid cpus also would be inversion;

Yes. I pray this is highly unlikely though! We should cater for it still.

> (3)what time update the cpu inversion state, if we judge the cpu
> inversion whenever the thermal pressure changed, could we receive the
> complexity? because may we should traverse all possible cpu.

In my head, it would make sense to detect the inversion in
update_cpu_capacity() OR in topology_update_thermal_pressure(). So at whatever
rate this happens at.

Does this answer your question?

Basically I believe something like this should be enough (completely untested)

--->8---


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..44c7c2598d87 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8399,16 +8399,37 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
+	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
+	struct rq *rq = cpu_rq(cpu);
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
+	rq->cpu_capacity_orig = capacity_orig;
 
 	if (!capacity)
 		capacity = 1;
 
-	cpu_rq(cpu)->cpu_capacity = capacity;
-	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+	rq->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(rq);
+
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
+
+		rq->cpu_capacity_inverted = 0;
+
+		for_each_possible_cpu(cpu) {
+			unsigned long cap = arch_scale_cpu_capacity(cpu);
+
+			if (capacity_orig <= cap)
+				continue;
+
+			if (cap > inv_cap) {
+				rq->cpu_capacity_inverted = inv_cap;
+				break;
+			}
+		}
+
+	}
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..bfe84c870bf9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -992,6 +992,7 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
+	unsigned long		cpu_capacity_inverted;
 
 	struct callback_head	*balance_callback;
 
@@ -2807,6 +2808,11 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
+static inline unsigned long cpu_in_capacity_inversion(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_inverted;
+}
+
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency


--->8---

Thanks

--
Qais Yousef
