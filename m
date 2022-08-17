Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114AA5970F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbiHQOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHQOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:21:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 546888D3F8;
        Wed, 17 Aug 2022 07:21:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B931E113E;
        Wed, 17 Aug 2022 07:21:12 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 829673F70D;
        Wed, 17 Aug 2022 07:21:11 -0700 (PDT)
Date:   Wed, 17 Aug 2022 15:21:09 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz.Luba@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Remove EM_MAX_COMPLEXITY limit
Message-ID: <Yvz5VYjBl4emkA59@arm.com>
References: <20220812101620.627838-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812101620.627838-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Friday 12 Aug 2022 at 12:16:19 (+0200), Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The Energy Aware Scheduler (EAS) estimates the energy consumption
> of placing a task on different CPUs. The goal is to minimize this
> energy consumption. Estimating the energy of different task placements
> is increasingly complex with the size of the platform. To avoid having
> a slow wake-up path, EAS is only enabled if this complexity is low
> enough.
> 
> The current complexity limit was set in:
> commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
> platforms").
> base on the first implementation of EAS, which was re-computing
> the power of the whole platform for each task placement scenario, cf:
> commit 390031e4c309 ("sched/fair: Introduce an energy estimation helper
> function").
> but the complexity of EAS was reduced in:
> commit eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")
> and find_energy_efficient_cpu() (feec) algorithm was updated in:
> commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective
> utilization in feec()")
> 
> find_energy_efficient_cpu() (feec) is now doing:
> feec()
> \_ for_each_pd(pd) [0]
>   // get max_spare_cap_cpu and compute_prev_delta
>   \_ for_each_cpu(pd) [1]
> 
>   \_ get_pd_busy_time(pd) [2]
>     \_ for_each_cpu(pd)
> 
>   // evaluate pd energy without the task
>   \_ get_pd_max_util(pd, -1) [3.0]
>     \_ for_each_cpu(pd)
>   \_ compute_energy(pd, -1)
>     \_ for_each_ps(pd)
> 
>   // evaluate pd energy with the task on prev_cpu
>   \_ get_pd_max_util(pd, prev_cpu) [3.1]
>     \_ for_each_cpu(pd)
>   \_ compute_energy(pd, prev_cpu)
>     \_ for_each_ps(pd)
> 
>   // evaluate pd energy with the task on max_spare_cap_cpu
>   \_ get_pd_max_util(pd, max_spare_cap_cpu) [3.2]
>     \_ for_each_cpu(pd)
>   \_ compute_energy(pd, max_spare_cap_cpu)
>     \_ for_each_ps(pd)
> 
> [3.1] happens only once since prev_cpu is unique. To have an upper
> bound of the complexity, [3.1] is taken into account for all pds.
> So with the same definitions for nr_pd, nr_cpus and nr_ps,
> the complexity is of:
> nr_pd * (2 * [nr_cpus in pd] + 3 * ([nr_cpus in pd] + [nr_ps in pd]))
>  [0]  * (     [1] + [2]      +       [3.0] + [3.1] + [3.2]          )
> = 5 * nr_cpus + 3 * nr_ps
> 

I just want to draw your attention to [1] and the fact that the
structure of the function changed. Your calculations largely remain the
same - 3 calls to compute_energy() which in turn now calls
eenv_pd_max_util() with operations for each cpu, plus some scattered
calls to eenv_pd_busy_time(), all for each pd.

[1]
https://lore.kernel.org/lkml/20220621090414.433602-7-vdonnefort@google.com/

Thanks,
Ionela.
