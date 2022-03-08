Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8944D1173
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbiCHIDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbiCHIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:02:56 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65353E0F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:01:59 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r22so8360585ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCqkFzJNNi9TKoUV08WshlexslNNe7GKahjutP5xzOg=;
        b=R590QIdaxvGYb7no9nzfN37UTrOe2cvp2kQz8c3WH3qpWoDMazmq8h/noeW8DTMNn9
         18EF4+pHsiDFcNQm9BWGtNmMooRow1StZKomBu9m130L1nxTxObqPSio+qDDtywFWsn4
         6Qhq8GERrMVT9Majw2lNV3jtu9QxUPX2VeFeBhSn7lPaRxspDervOTOXVQNzlRL2EkA3
         IWvdNge+V18iYuII91lw2TZizy41MgA5/cUCR2wZLve5acDpQsS1hAWAFMxy26zUoaYm
         BIx/WfHrA8C1dPxtTVyAR+qo8/E9zkNUHVWADzi2qlg92f6bAoWO89/zT5w4Viz3JPHW
         OWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCqkFzJNNi9TKoUV08WshlexslNNe7GKahjutP5xzOg=;
        b=4gg8pWIOb3E3icW0RAab/7tPJ+gn750K8kI9p0AUAyhFPj7TLK4hL5Gh7w26d0bfjF
         JlClP5RlJ8TUMnxIY1R8oNmViSTQWrd2i7NeHOX04e4KarbccwVaZoAIu7He4h3zFnx1
         Pci6jDcUZBPUqnDlHIFwFG4KiWX7Zjku/lwLuRKCWogK9siX2HHIuZ7X68fccU6Df5Zm
         3o8CdVgZLMGwP07qFX5e6vmJLduRA1SYKWnWx+SFKqg2pHspIosUa/OyU3T/loKE/I1r
         DDCZzCQRMsUjNRMSpfl1SqGNSCmgeYUCCr2rNpRUy7cXMA3voRdzOHgLqMVpsVgzLcpa
         sXGQ==
X-Gm-Message-State: AOAM530mXpk4/bQZug7yMJvUnUVlum+n77KuGlnk6tnonIk/wdQNAeer
        PWQFbIMY9thyhnDSdN2Qsem+fADZQm0EqBCzeyU50g==
X-Google-Smtp-Source: ABdhPJxn/1CSWgYkWeSHVo/kcXgYiha4elvNWmYc1dSmvwEjWgN8OFJREiV3mtlpTVQQE0O9xLYgotooITbhhxYskUc=
X-Received: by 2002:a2e:bf01:0:b0:247:dfe7:62dc with SMTP id
 c1-20020a2ebf01000000b00247dfe762dcmr7779548ljr.365.1646726517938; Tue, 08
 Mar 2022 00:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
In-Reply-To: <20220308063749.6929-1-kprateek.nayak@amd.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Mar 2022 09:01:46 +0100
Message-ID: <CAKfTPtD42KNiLkOUorLq-=Xmp9005O_awkwo-ybggxNZC+suhw@mail.gmail.com>
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, srikar@linux.vnet.ibm.com,
        Valentin.Schneider@arm.com
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

On Tue, 8 Mar 2022 at 07:38, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> In the case of systems containing multiple LLCs per socket, like
> AMD Zen systems, users want to spread bandwidth hungry applications
> across multiple LLCs. Stream is one such representative workload where
> the best performance is obtained by limiting one stream thread per LLC.
> To ensure this, users are known to pin the tasks to a specify a subset
> of the CPUs consisting of one CPU per LLC while running such bandwidth
> hungry tasks.
>
> Suppose we kickstart a multi-threaded task like stream with 8 threads
> using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
> server where each socket contains 128 CPUs
> (0-63,128-191 in one socket, 64-127,192-255 in another socket)
>
> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>
> Here each CPU in the list is from a different LLC and 4 of those LLCs
> are on one socket, while the other 4 are on another socket.
>
> Ideally we would prefer that each stream thread runs on a different
> CPU from the allowed list of CPUs. However, the current heuristics in
> find_idlest_group() do not allow this during the initial placement.
>
> Suppose the first socket (0-63,128-191) is our local group from which
> we are kickstarting the stream tasks. The first four stream threads
> will be placed in this socket. When it comes to placing the 5th
> thread, all the allowed CPUs are from the local group (0,16,32,48)
> would have been taken.
>
> However, the current scheduler code simply checks if the number of
> tasks in the local group is fewer than the allowed numa-imbalance
> threshold. This threshold was previously 25% of the NUMA domain span
> (in this case threshold = 32) but after the v6 of Mel's patchset
> "Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
> Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
> when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
> in the NUMA domain, for processors with multiple LLCs.
> (in this case threshold = 8).
>
> For this example, the number of tasks will always be within threshold
> and thus all the 8 stream threads will be woken up on the first socket
> thereby resulting in sub-optimal performance.
>
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks in the current tip/sched/core on the Zen3 machine:
>
> stream-5045    [032] d..2.   167.914699: sched_wakeup_new: comm=stream pid=5047 prio=120 target_cpu=048
> stream-5045    [032] d..2.   167.914746: sched_wakeup_new: comm=stream pid=5048 prio=120 target_cpu=000
> stream-5045    [032] d..2.   167.914846: sched_wakeup_new: comm=stream pid=5049 prio=120 target_cpu=016
> stream-5045    [032] d..2.   167.914891: sched_wakeup_new: comm=stream pid=5050 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914928: sched_wakeup_new: comm=stream pid=5051 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914976: sched_wakeup_new: comm=stream pid=5052 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.915011: sched_wakeup_new: comm=stream pid=5053 prio=120 target_cpu=032
>
> Once the first four threads are distributed among the allowed CPUs of
> socket one, the rest of the treads start piling on these same CPUs
> when clearly there are CPUs on the second socket that can be used.
>
> Following the initial pile up on a small number of CPUs, though the
> load-balancer eventually kicks in, it takes a while to get to {4}{4}
> and even {4}{4} isn't stable as we observe a bunch of ping ponging
> between {4}{4} to {5}{3} and back before a stable state is reached
> much later (1 Stream thread per allowed CPU) and no more migration is
> required.
>
> We can detect this piling and avoid it by checking if the number of
> allowed CPUs in the local group are fewer than the number of tasks
> running in the local group and use this information to spread the
> 5th task out into the next socket (after all, the goal in this
> slowpath is to find the idlest group and the idlest CPU during the
> initial placement!).
>
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks after adding this fix on the Zen3 machine:
>
> stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
> stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
> stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
> stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
> stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
> stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
> stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080
>
> We see that threads are using all of the allowed CPUs and there is
> no pileup.
>
> No output is generated for tracepoint sched_migrate_task with this
> patch due to a perfect initial placement which removes the need
> for balancing later on - both across NUMA boundaries and within
> NUMA boundaries for stream.
>
> Following are the results from running 8 Stream threads with and
> without pinning on a dual socket Zen3 Machine (2 x 64C/128T):
>
> Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>
>                    5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
>                                                                        + pinning
>
>  Copy:    97699.28 (0.00 pct)     95933.60  (-1.80 pct)    156578.91 (60.26 pct)
> Scale:   107754.15 (0.00 pct)     91869.88 (-14.74 pct)    149783.25 (39.00 pct)
>   Add:   126383.29 (0.00 pct)    105730.86 (-16.34 pct)    186493.09 (47.56 pct)
> Triad:   124896.78 (0.00 pct)    106394.38 (-14.81 pct)    184733.48 (47.90 pct)
>
> Pinning currently hurts the performance compared to unbound case on
> tip/sched/core. With the addition of this patch, we are able to
> outperform tip/sched/core by a good margin with pinning.
>
> Following are the results from running 16 Stream threads with and
> without pinning on a dual socket Skylake Machine (2 x 24C/48T):
>
> Pinning is done using: numactl -C 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ./stream16
>
>                    5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
>                                                                        + pinning
>
>  Copy:   126620.67 (0.00 pct)     141062.10 (11.40 pct)    147615.44 (16.58 pct)
> Scale:   91313.51 (0.00 pct)      112879.61 (23.61 pct)    122591.28 (34.25 pct)
>   Add:   102035.43 (0.00 pct)     125889.98 (23.37 pct)    138179.01 (35.42 pct)
> Triad:   102281.91 (0.00 pct)     123743.48 (20.98 pct)    138940.41 (35.84 pct)
>
> In case of Skylake machine, with single LLC per socket, we see good
> improvement brought about by pinning which is further benefited by
> this patch.
>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changelog v5-->v6:
>  -  Move the cpumask variable declaration to the block it is
>     used in.
>  -  Collect tags from v5.
> Changelog v4-->v5:
>  -  Only perform cpumask operations if nr_cpus_allowed is not
>     equal to num_online_cpus based on Mel's suggestion.
> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 16874e112fe6..6cc90d76250f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9183,6 +9183,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>
>         case group_has_spare:
>                 if (sd->flags & SD_NUMA) {
> +                       int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>                         int idlest_cpu;
>                         /*
> @@ -9200,10 +9201,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                          * Otherwise, keep the task close to the wakeup source
>                          * and improve locality if the number of running tasks
>                          * would remain below threshold where an imbalance is
> -                        * allowed. If there is a real need of migration,
> -                        * periodic load balance will take care of it.
> +                        * allowed while accounting for the possibility the
> +                        * task is pinned to a subset of CPUs. If there is a
> +                        * real need of migration, periodic load balance will
> +                        * take care of it.
>                          */
> -                       if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> +                       imb = sd->imb_numa_nr;
> +                       if (p->nr_cpus_allowed != num_online_cpus()) {
> +                               struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +
> +                               cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +                               imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +                       }
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>                                 return NULL;
>                 }
>
> --
> 2.25.1
>
