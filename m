Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B557DC22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiGVITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiGVITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B09DEE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:19:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so5459023wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5HNAAFnMOPkpYer/ySuwst3s/TO2qkEI/+yxpQo5KR0=;
        b=N8J2EG1qLe6TeWMK34rzxKeA/6JomVqsybJsMHGZfBM/2ZRbOmWh33V+dkL3OkZxMA
         m7MTmmwsjOUTgfLNnGQLG/MaNJQ1hLPijWWe4kE3RTnsuVI5lPCM2yhmQpujdFAxXrBR
         ZKmUlrFsqffNy4HhL+tDObQWjX7ZYirhVFUwMmAlUIwjql5fnCaOJ0FSnHS658GvjukU
         adJOOr/HC+EHvzFBn54MJici4KDcG6NTRXVcUmHVnIo/9ej1yk0vDGHbumGZUmZkrXTm
         TUYydfQ9JqArRUEhWmfaCaUoULB0LS6kdWiJAQEpMaLmC+yxHJbqumWH0akaZPnsw8rk
         t8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5HNAAFnMOPkpYer/ySuwst3s/TO2qkEI/+yxpQo5KR0=;
        b=zyVEUvRCPJ95xb2knHgGuuBy5H+8RTDgzZWFk5kIYCf/bj7k6/8IbecPPV2mlgcV+H
         iBAZTa8nY2+CEBiO17YFl5+bph2usS473jJJk2uBqYJ3U/7WMLWnImeFrwB/YXlgNcQU
         xh81AV8qhqY+nseb3RykXqRONpwgBjuay5otM0R3OLW5mWm2FQSR21cAzt4zWv9W7Mss
         dPKoe8EsygWrrI9CGxs4FNL984jfcXiTdPPGncQrTKQDMjaa92WFwzz9pNYqcCbRHMcS
         pVlKh0KHuvvL/g+qiN3CZigPNuu5GeBqI8Ak24i2mdXn5Gu9Pvqp6xqeW5g1AyJfRVNS
         RZ3g==
X-Gm-Message-State: AJIora888aOj7jSTux83clqCvm7L9ieK6joVy4NKvku23AMZZyg6UazJ
        s3VdKgX3lKWvq4kkqLFr5fh5gg==
X-Google-Smtp-Source: AGRyM1uQk7Goic1LPQxcTICLbzmiU8VbMa5+NQQ9md1810cztei85myneXGPaILEy9kbUHrNn0uN8A==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr1580345wrf.208.1658477956123;
        Fri, 22 Jul 2022 01:19:16 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:4184:7da3:cc8e:4b9d])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b0021e4fd8e10bsm4004256wru.11.2022.07.22.01.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jul 2022 01:19:15 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:19:13 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use
 util_fits_cpu()
Message-ID: <20220722081913.GA6045@vingu-book>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-3-qais.yousef@arm.com>
 <CAKfTPtAxK=NGbpQkiW8-tx3kEwp-M7LAr1Rq_kdWDdsSq7Hd9A@mail.gmail.com>
 <20220712104843.frbtkgkiftaovcon@wubuntu>
 <20220721142949.fqmabrjwylkuoltw@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721142949.fqmabrjwylkuoltw@wubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 21 juil. 2022 à 15:29:49 (+0100), Qais Yousef a écrit :
> On 07/12/22 11:48, Qais Yousef wrote:
> > On 07/11/22 15:09, Vincent Guittot wrote:
> > > On Wed, 29 Jun 2022 at 21:48, Qais Yousef <qais.yousef@arm.com> wrote:
> > 

[...]

> > > > @@ -9108,7 +9125,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> > > >
> > > >         /* Check if task fits in the group */
> > > >         if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > > > -           !task_fits_capacity(p, group->sgc->max_capacity)) {
> > > > +           !task_fits_cpu(p, group->sgc->max_capacity_cpu)) {
> > > 
> > > All the changes and added complexity above for this line. Can't you
> > > find another way ?
> > 
> > You're right, I might have got carried away trying to keep the logic the same.
> > 
> > Can we use group->asym_prefer_cpu or pick a cpu from group->sgc->cpumask
> > instead?
> > 
> > I'll dig more into it anyway and try to come up with simpler alternative.
> 
> Actually we can't.
> 
> I can keep the current {max,min}_capacity field and just add the new
> {max,min}_capacity_cpu and use them where needed. Should address your concerns
> this way? That was actually the first version of the code, but then it seemed
> redundant to keep both {max,min}_capacity and {max,min}_capacity_cpu.
> 
> OR
> 
> I can add a new function to search for max spare capacity cpu in the group.
> 
> Preference?
> 

Isn't the below enough and much simpler ?

[PATCH] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()

So that the new uclamp rules in regard to migration margin and capacity
pressure are taken into account correctly.
---
 kernel/sched/fair.c  | 25 +++++++++++++++----------
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eecae32a0f6..3e0c7cc490be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4317,10 +4317,12 @@ static inline int util_fits_cpu(unsigned long util,
 	return fits;
 }

-static inline int task_fits_capacity(struct task_struct *p,
-				     unsigned long capacity)
+static inline int task_fits_cpu(struct task_struct *p, int cpu)
 {
-	return fits_capacity(uclamp_task_util(p), capacity);
+	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	unsigned long util = task_util_est(p);
+	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
 }

 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -4333,7 +4335,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}

-	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
+	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8104,7 +8106,7 @@ static int detach_tasks(struct lb_env *env)

 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
+			if (task_fits_cpu(p, env->src_cpu))
 				goto next;

 			env->imbalance = 0;
@@ -9085,6 +9087,10 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,

 	memset(sgs, 0, sizeof(*sgs));

+	/* Assume that task can't fit any CPU of the group */
+	if (sd->flags & SD_ASYM_CPUCAPACITY)
+		sgs->group_misfit_task_load = 0;
+
 	for_each_cpu(i, sched_group_span(group)) {
 		struct rq *rq = cpu_rq(i);
 		unsigned int local;
@@ -9104,12 +9110,11 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		if (!nr_running && idle_cpu_without(i, p))
 			sgs->idle_cpus++;

-	}
+		/* Check if task fits in the CPU */
+		if (sd->flags & SD_ASYM_CPUCAPACITY &&
+		    task_fits_cpu(p, i))
+			sgs->group_misfit_task_load = 0;

-	/* Check if task fits in the group */
-	if (sd->flags & SD_ASYM_CPUCAPACITY &&
-	    !task_fits_capacity(p, group->sgc->max_capacity)) {
-		sgs->group_misfit_task_load = 1;
 	}

 	sgs->group_capacity = group->sgc->capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 02c970501295..3292ad2db4ac 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2988,6 +2988,15 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 #else /* CONFIG_UCLAMP_TASK */
+static inline unsigned long uclamp_eff_value(struct task_struct *p,
+					     enum uclamp_id clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+
+	return SCHED_CAPACITY_SCALE;
+}
+
 static inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
--
2.17.1

> 
> Thanks!
> 
> --
> Qais Yousef
