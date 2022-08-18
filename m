Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AF598307
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiHRMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiHRMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:19:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D394D786DB;
        Thu, 18 Aug 2022 05:19:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE3D106F;
        Thu, 18 Aug 2022 05:19:57 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EAA63F70D;
        Thu, 18 Aug 2022 05:19:54 -0700 (PDT)
Message-ID: <257c43fb-0fb5-959a-788c-3c4a14b188dc@arm.com>
Date:   Thu, 18 Aug 2022 14:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/topology: Remove EM_MAX_COMPLEXITY limit
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org
References: <20220812101620.627838-1-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220812101620.627838-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 12:16, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>

[...]

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
> The complexity limit was set to 2048 in:
> commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
> platforms")
> to make "EAS usable up to 16 CPUs with per-CPU DVFS and less than 8
> performance states each". For the same platform, the complexity would
> actually be of:
> 5 * 16 + 3 * 7 = 101

This is somewhat hard to grasp.

Example: 16 CPUs w/ per-CPU DVFS and < 8 performance states (OPPs) each

C  : Complexity

Nc : #CPUs in system
Ns : Sum of PSs (Performance States) over all PDs
Nd : #PDs

Nc' : #CPUs in PD
Ns' : #PSs in PD

(1) Currently we have:

    C = Nd * (Nc + Ns)

    Nc = 16, Nd = 16, Ns = 16 * 7

    C = 16 * (16 + 16 * 7)

      = 2048

(2) Your new formula is:

    Nc' = 1, Ns' = 7

    C = Nd * (2 * Nc' + 3 * (Nc' + Ns'))

      = Nd * (5 * Nc' + 3 * Ns')

      = 16 * (5 * 1 + 3 * 7)

      = 416

      = 5 * Nc + 3 * Ns

I would update the example and leave C ~ at 2048.

> Since the EAS complexity was greatly reduced, bigger platforms can
> handle EAS. For instance, a platform with 256 CPUs with 256
> performance states each would reach it. To reflect this improvement,
> remove the EAS complexity check.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>

We should definitely align feec()'s implementation with the EM
complexity check and documentation. I would suggest that we keep both in
place but we update them.

> ---
>  Documentation/scheduler/sched-energy.rst | 37 ++--------------------
>  kernel/sched/topology.c                  | 39 ++----------------------
>  2 files changed, 6 insertions(+), 70 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> index 8fbce5e767d9..3d1d71134d16 100644
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -356,38 +356,7 @@ placement. For EAS it doesn't matter whether the EM power values are expressed
>  in milli-Watts or in an 'abstract scale'.
>  
>  
> -6.3 - Energy Model complexity
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The task wake-up path is very latency-sensitive. When the EM of a platform is
> -too complex (too many CPUs, too many performance domains, too many performance
> -states, ...), the cost of using it in the wake-up path can become prohibitive.
> -The energy-aware wake-up algorithm has a complexity of:
> -
> -	C = Nd * (Nc + Ns)
> -
> -with: Nd the number of performance domains; Nc the number of CPUs; and Ns the
> -total number of OPPs (ex: for two perf. domains with 4 OPPs each, Ns = 8).
> -
> -A complexity check is performed at the root domain level, when scheduling
> -domains are built. EAS will not start on a root domain if its C happens to be
> -higher than the completely arbitrary EM_MAX_COMPLEXITY threshold (2048 at the
> -time of writing).
> -
> -If you really want to use EAS but the complexity of your platform's Energy
> -Model is too high to be used with a single root domain, you're left with only
> -two possible options:
> -
> -    1. split your system into separate, smaller, root domains using exclusive
> -       cpusets and enable EAS locally on each of them. This option has the
> -       benefit to work out of the box but the drawback of preventing load
> -       balance between root domains, which can result in an unbalanced system
> -       overall;
> -    2. submit patches to reduce the complexity of the EAS wake-up algorithm,
> -       hence enabling it to cope with larger EMs in reasonable time.
> -
> -

I see value in this paragraph. Obviously it has to match the actual
feec() implementation.

[...]
