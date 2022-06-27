Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71A55D87B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiF0LAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiF0LAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:00:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A566417
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:59:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so12502392wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mq0qIYAooCDoYXxxt4pMJ0vsx2LS7YQICwC0A7jqELY=;
        b=s7yPOLeyiVe5npxDJ8DQqZJ5aSxI9PjE8tECTvhzLv+ifKRyIt0svF0+EQ7jPGkxVq
         gbGdltyr04WDPX8UUC7n/pDdnBMEwV9Q8wIk+5kw2cie9QxRM0Er0l823uyK4hPMA8yw
         z5aflgm4oPr+aifwDgzCjSpjxUnvBlGp59G6xKPA00CcXwrBABHfCwA/qVEg1xfXvtl0
         GIl8rUzBW3np38q3hBC8rA0QMgkiLk5AcNm0Y9s4SQrWfnhA8lZ4vVwbUZ8eZCrru81m
         F4wT54CIfdWUFlXhZZZm/Jt+7GMbOUDEWKNeaL5d9yFWjqS219j5mKXBcDSzx/9NWa2k
         mt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mq0qIYAooCDoYXxxt4pMJ0vsx2LS7YQICwC0A7jqELY=;
        b=PyQapstWWHaTOh4qAhX6OLHNC4Jga10Kg+HIYpaRMq5soSgYbz+W4s7+uqYMYQvE37
         lBSRGS9wa1EKaHi/AtVROBWxfOT/I666VmU74uZtqY+yerzBD9g+5YJ+yc0F0TSTCKbO
         5Q9i/ziGLhM5r1yMrlkxj3S96+Om3RasDxKBV/bEZk2re85Fe7k9l24X/ox4tQSTvs3h
         iSA2EG93eIQ1KyE+opJmvCUXl0vqoa4MnD7khPFStOWWNeU9M52dzLWE2tBDjYziTM/G
         Q1g4zHyGyNf8wN2VWtdIZBhGE0OlVxjkigLS4TrAB7vTgGf6Al6La7w5Z1QwdSPbTju/
         8+tw==
X-Gm-Message-State: AJIora997THnr4ijIm5FhJTuib4OPHxoACaeyBfu69VBZA2e93UIOYkc
        WWRtZjZsmw+CTk3WNtf9fAZjwA==
X-Google-Smtp-Source: AGRyM1sV/Dn6dHdP/wHyIjhf0vshgauOZCM1PfbIfYWrG+fi7BeAVVRdoGoNLqmwWyTtu7DFg2qHwQ==
X-Received: by 2002:a5d:5a19:0:b0:21b:8eb8:f54b with SMTP id bq25-20020a5d5a19000000b0021b8eb8f54bmr11335986wrb.663.1656327597463;
        Mon, 27 Jun 2022 03:59:57 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:1833:5ba3:b4b4:7d8d])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003a03be22f9fsm13387618wms.18.2022.06.27.03.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jun 2022 03:59:56 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:59:54 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     David Chen <david.chen@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Perf regression from scheduler load_balance rework in 5.5?
Message-ID: <20220627105954.GA7670@vingu-book>
References: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
 <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
 <409fc8d0-119a-3358-0fc5-99a786a9564a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409fc8d0-119a-3358-0fc5-99a786a9564a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le vendredi 24 juin 2022 à 21:16:05 (+0800), Zhang Qiao a écrit :
> 
> Hi,
> 在 2022/6/24 16:22, Vincent Guittot 写道:
> > On Thu, 23 Jun 2022 at 21:50, David Chen <david.chen@nutanix.com> wrote:
> >>
> >> Hi,
> >>
> >> I'm working on upgrading our kernel from 4.14 to 5.10
> >> However, I'm seeing performance regression when doing rand read from windows client through smbd
> >> with a well cached file.
> >>
> >> One thing I noticed is that on the new kernel, the smbd thread doing socket I/O tends to stay on
> >> the same cpu core as the net_rx softirq, where as in the old kernel it tends to be moved around
> >> more randomly. And when they are on the same cpu, it tends to saturate the cpu more and causes
> >> performance to drop.
> >>
> >> For example, here's the duration (ns) the thread spend on each cpu I captured using bpftrace
> >> On 4.14:
> >> @cputime[7]: 20741458382
> >> @cputime[0]: 25219285005
> >> @cputime[6]: 30892418441
> >> @cputime[5]: 31032404613
> >> @cputime[3]: 33511324691
> >> @cputime[1]: 35564174562
> >> @cputime[4]: 39313421965
> >> @cputime[2]: 55779811909 (net_rx cpu)
> >>
> >> On 5.10:
> >> @cputime[3]: 2150554823
> >> @cputime[5]: 3294276626
> >> @cputime[7]: 4277890448
> >> @cputime[4]: 5094586003
> >> @cputime[1]: 6058168291
> >> @cputime[0]: 14688093441
> >> @cputime[6]: 17578229533
> >> @cputime[2]: 223473400411 (net_rx cpu)
> >>
> >> I also tried setting the cpu affinity of the smbd thread away from the net_rx cpu and indeed that
> >> seems to bring the perf on par with old kernel.
> 
> I observed the same problem for the past two weeks.
> 
> >>
> >> I noticed that there's scheduler load_balance rework in 5.5, so I did the test on 5.4 and 5.5 and
> >> it did show the behavior changed between 5.4 and 5.5.
> > 
> > Have you tested v5.18 ? several improvements happened since v5.5
> > 
> >>
> >> Anyone know how to work around this?
> > 
> > Have you enabled IRQ_TIME_ACCOUNTING ?
> 
> 
> CONFIG_IRQ_TIME_ACCOUNTING=y.
> 
> > 
> > When the time spent under interrupt becomes significant, scheduler
> > migrate task on another cpu
> 
> 
> My board has two cpus, and i used iperf3 to test upload bandwidth，then I saw the same situation，
> the iperf3 thread run on the same cpu as the NET_RX softirq.
> 
> After debug in find_busiest_group(), i noticed when the cpu(env->idle is CPU_IDLE or CPU_NEWLY_IDLE) try to pull task,
> the busiest->group_type == group_fully_busy, busiest->sum_h_nr_running == 1, local->group_type==group_has_spare,
> and the loadbalance will failed at find_busiest_group(), as follows:
> 
> find_busiest_group():
>     ...
>     if (busiest->group_type != group_overloaded) {
> 	....
> 	if (busiest->sum_h_nr_running == 1)
> 		goto out_balanced;     ----> loadbalance will returned at here.

Yes, you're right, we filter such case. Could you try the patch below ?
I use the misfit task state to detect cpu with reduced capacity and migrate_load
to check if it worth migration the task on the dst cpu. 

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6775a117f3c1..013dcd97472b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8757,11 +8757,19 @@ static inline void update_sg_lb_stats(struct lb_env *env,
                if (local_group)
                        continue;
 
-               /* Check for a misfit task on the cpu */
-               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-                   sgs->group_misfit_task_load < rq->misfit_task_load) {
-                       sgs->group_misfit_task_load = rq->misfit_task_load;
-                       *sg_status |= SG_OVERLOAD;
+               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+                       /* Check for a misfit task on the cpu */
+                       if (sgs->group_misfit_task_load < rq->misfit_task_load) {
+                               sgs->group_misfit_task_load = rq->misfit_task_load;
+                               *sg_status |= SG_OVERLOAD;
+                       }
+                } else if ((env->idle != CPU_NOT_IDLE) &&
+                           (group->group_weight == 1) &&
+                           (rq->cfs.h_nr_running == 1) &&
+                           check_cpu_capacity(rq, env->sd) &&
+                           (sgs->group_misfit_task_load < cpu_load(rq))) {
+                       /* Check for a task running on a CPU with reduced capacity */
+                       sgs->group_misfit_task_load = cpu_load(rq);
                }
        }
 
@@ -8814,7 +8822,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
         * CPUs in the group should either be possible to resolve
         * internally or be covered by avg_load imbalance (eventually).
         */
-       if (sgs->group_type == group_misfit_task &&
+       if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+           (sgs->group_type == group_misfit_task) &&
            (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
             sds->local_stat.group_type != group_has_spare))
                return false;
@@ -9360,9 +9369,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
        busiest = &sds->busiest_stat;
 
        if (busiest->group_type == group_misfit_task) {
-               /* Set imbalance to allow misfit tasks to be balanced. */
-               env->migration_type = migrate_misfit;
-               env->imbalance = 1;
+               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+                       /* Set imbalance to allow misfit tasks to be balanced. */
+                       env->migration_type = migrate_misfit;
+                       env->imbalance = 1;
+               } else {
+                       /* Set group overloaded as one cpu has reduced capacity */
+                       env->migration_type = migrate_load;
+                       env->imbalance = busiest->group_misfit_task_load;
+               }
                return;
        }


> ....
> 
> 
> Thanks,
> Qiao
> 
> 
> > Vincent>>
> >> Thanks,
> >> David
> > .
> > 
