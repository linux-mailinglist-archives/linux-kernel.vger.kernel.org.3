Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B352244C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiEJSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiEJSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:44:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A66652BD236
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:44:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A5B012FC;
        Tue, 10 May 2022 11:44:39 -0700 (PDT)
Received: from wubuntu (unknown [10.57.65.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D42A23F5A1;
        Tue, 10 May 2022 11:44:37 -0700 (PDT)
Date:   Tue, 10 May 2022 19:44:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, Xuewen Yan <xuewen.yan94@gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220510184436.fdgzzcfqqevinx5p@wubuntu>
References: <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
 <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu>
 <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu>
 <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
 <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
 <CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com>
 <20220510145625.t5py7atlhgojsfyf@wubuntu>
 <37357c86-bab7-d0c7-88d0-ace63ccdb6c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37357c86-bab7-d0c7-88d0-ace63ccdb6c8@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/22 18:44, Lukasz Luba wrote:

[...]

> To properly answer this question we probably have to analyze the timings
> and this update path - how often it is actually called. Keep in mind
> we are going to solve CPU capacity inversion for RT class, which
> contains latency sensitive tasks. In this approach the information

This was an attempt for a generic inversion detection. We update
rq->cpu_capacity which is used by capacity_of() in the same path.

I didn't feel brave to write a quick patch in the topology code, but we can
certainly do the detection there in topology_update_thermal_pressure().

> about HW status is coming from this CFS load balance path.
> What if that load balance is not called that often as RT might require?
> What if there is a light load on CPUs, but GPU caused them to throttle,
> reducing capacity by a decent chunk e.g. 50%?
> That would translate to some RT periodic task which takes 2ms every
> 8ms to take 4ms, while maybe on other less power hungry CPU it could
> take 3ms.
> 
> The usage of thermal_load_avg() in the scale_rt_capacity() looks OK
> for the CFS, but might not be from the RT class point of view.
> The RT class might want to realize faster that CPUs have changed the
> capacity.
> Maybe it's OK with that patch [1] and boot config shifter=-5, but in
> default boot config for shifter=0 we can suffer for hundreds of ms
> running on lower capacity cpu (which is quite high number of frames
> nowadays).
> 
> Without a research and experiments data I'm afraid this is too
> big step to make, with this CFS load balance path.

I think Xuewen didn't want to use thermal_load_avg(), and that's the question
I deferred.

> 
> > 
> > > 
> > > > +
> > > > +               rq->cpu_capacity_inverted = 0;
> > > > +
> > > > +               for_each_possible_cpu(cpu) {
> > > > +                       unsigned long cap = arch_scale_cpu_capacity(cpu);
> > > > +
> > > > +                       if (capacity_orig <= cap)
> > > > +                               continue;
> 
> The search loop here assumes that other CPUs (fortunately not in the
> same freq domain) don't suffer due to reduced capacity. This might be
> not true - when we have ~1 Watt budget for all CPUs in the system and
> single big core can use 3-4W at max or single mid core ~1.2W.

I defined capacity inversion against capacity_orig. IMHO that's the sensible
definition to make.

Would be good to hear more/other suggestions.

> 
> > > > +
> > > > +                       if (cap > inv_cap) {
> > > > +                               rq->cpu_capacity_inverted = inv_cap;
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +
> > > > +       }
> > > > 
> > > >          sdg->sgc->capacity = capacity;
> > > >          sdg->sgc->min_capacity = capacity;
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index 8dccb34eb190..bfe84c870bf9 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -992,6 +992,7 @@ struct rq {
> > > > 
> > > >          unsigned long           cpu_capacity;
> > > >          unsigned long           cpu_capacity_orig;
> > > > +       unsigned long           cpu_capacity_inverted;
> > > > 
> > > >          struct callback_head    *balance_callback;
> > > > 
> > > > @@ -2807,6 +2808,11 @@ static inline unsigned long capacity_orig_of(int cpu)
> > > >          return cpu_rq(cpu)->cpu_capacity_orig;
> > > >   }
> > > > 
> > > > +static inline unsigned long cpu_in_capacity_inversion(int cpu)
> > > > +{
> > > > +       return cpu_rq(cpu)->cpu_capacity_inverted;
> > > > +}
> > > > +
> > > >   /**
> > > >    * enum cpu_util_type - CPU utilization type
> > > >    * @FREQUENCY_UTIL:    Utilization used to select frequency
> > > > 
> > > > 
> > > > --->8---
> > > 
> > > The patch is amazing for me, and the complexity is not too high. Would
> > > you please push the patch?
> > > I think the idea is yours, I don't want to use it as my patch v2.
> > 
> > I'd be happy to add a commit message so that you can include it in your v2.
> > 
> > First, I'd like to hear from Vincent and Lukasz they're happy with this
> > approach.
> > 
> > I've been trying to think how we can do this generically but can't find an
> > alternative to the extra loop or additional fallback_cpu_mask. Maybe the mask
> > is okay if we protect it with sched_asymmetric_cpucapacity static key..
> > 
> 
> I'm sorry Qais, I see that you are trying to bring this
> real-CPU-capacity information into RT, but the source and quality of
> this information IMO might matter. I cannot help you w/o experiment
> results of your proposed approach.

The question I was posing here is whether to handle thermal only in inversion
case as I was suggesting or do better. We are still trickling through the
details, but first, I wanted to make sure there's no objection to this
direction (detect inversion and bail out in rt_task_fits_capacity() for cpus in
capacity inversion).

Cheers

--
Qais Yousef
