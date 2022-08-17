Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E31597252
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHQPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiHQPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:04:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28425B05A;
        Wed, 17 Aug 2022 08:03:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB48113E;
        Wed, 17 Aug 2022 08:03:17 -0700 (PDT)
Received: from [10.34.100.114] (pierre123.nice.arm.com [10.34.100.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD00A3F70D;
        Wed, 17 Aug 2022 08:03:13 -0700 (PDT)
Message-ID: <fd049983-bc72-9395-2a65-fb5cf96c19cd@arm.com>
Date:   Wed, 17 Aug 2022 17:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] sched/topology: Remove EM_MAX_COMPLEXITY limit
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
References: <20220812101620.627838-1-pierre.gondois@arm.com>
 <Yvz5VYjBl4emkA59@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Yvz5VYjBl4emkA59@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On 8/17/22 16:21, Ionela Voinescu wrote:
> Hi Pierre,
> 
> On Friday 12 Aug 2022 at 12:16:19 (+0200), Pierre Gondois wrote:
>> From: Pierre Gondois <Pierre.Gondois@arm.com>
>>
>> The Energy Aware Scheduler (EAS) estimates the energy consumption
>> of placing a task on different CPUs. The goal is to minimize this
>> energy consumption. Estimating the energy of different task placements
>> is increasingly complex with the size of the platform. To avoid having
>> a slow wake-up path, EAS is only enabled if this complexity is low
>> enough.
>>
>> The current complexity limit was set in:
>> commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
>> platforms").
>> base on the first implementation of EAS, which was re-computing
>> the power of the whole platform for each task placement scenario, cf:
>> commit 390031e4c309 ("sched/fair: Introduce an energy estimation helper
>> function").
>> but the complexity of EAS was reduced in:
>> commit eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")
>> and find_energy_efficient_cpu() (feec) algorithm was updated in:
>> commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective
>> utilization in feec()")
>>
>> find_energy_efficient_cpu() (feec) is now doing:
>> feec()
>> \_ for_each_pd(pd) [0]
>>    // get max_spare_cap_cpu and compute_prev_delta
>>    \_ for_each_cpu(pd) [1]
>>
>>    \_ get_pd_busy_time(pd) [2]
>>      \_ for_each_cpu(pd)
>>
>>    // evaluate pd energy without the task
>>    \_ get_pd_max_util(pd, -1) [3.0]
>>      \_ for_each_cpu(pd)
>>    \_ compute_energy(pd, -1)
>>      \_ for_each_ps(pd)
>>
>>    // evaluate pd energy with the task on prev_cpu
>>    \_ get_pd_max_util(pd, prev_cpu) [3.1]
>>      \_ for_each_cpu(pd)
>>    \_ compute_energy(pd, prev_cpu)
>>      \_ for_each_ps(pd)
>>
>>    // evaluate pd energy with the task on max_spare_cap_cpu
>>    \_ get_pd_max_util(pd, max_spare_cap_cpu) [3.2]
>>      \_ for_each_cpu(pd)
>>    \_ compute_energy(pd, max_spare_cap_cpu)
>>      \_ for_each_ps(pd)
>>
>> [3.1] happens only once since prev_cpu is unique. To have an upper
>> bound of the complexity, [3.1] is taken into account for all pds.
>> So with the same definitions for nr_pd, nr_cpus and nr_ps,
>> the complexity is of:
>> nr_pd * (2 * [nr_cpus in pd] + 3 * ([nr_cpus in pd] + [nr_ps in pd]))
>>   [0]  * (     [1] + [2]      +       [3.0] + [3.1] + [3.2]          )
>> = 5 * nr_cpus + 3 * nr_ps
>>
> 
> I just want to draw your attention to [1] and the fact that the
> structure of the function changed. Your calculations largely remain the
> same - 3 calls to compute_energy() which in turn now calls
> eenv_pd_max_util() with operations for each cpu, plus some scattered
> calls to eenv_pd_busy_time(), all for each pd.

Yes indeed, there is:
s/get_pd_max_util/eenv_pd_max_util

and also as you spotted, the following pattern:
\_ eenv_pd_max_util(pd, dst_cpu)
   \_ for_each_cpu(pd)
\_ compute_energy(pd, dst_cpu)
   \_ for_each_ps(pd)

should actually be:
\_ compute_energy(pd, dst_cpu)
   \_ eenv_pd_max_util(pd, dst_cpu)
     \_ for_each_cpu(pd)
   \_ for_each_ps(pd)

Thanks,
Pierre

> 
> [1]
> https://lore.kernel.org/lkml/20220621090414.433602-7-vdonnefort@google.com/
> 
> Thanks,
> Ionela.
