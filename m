Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85257CACA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGUMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:42:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7873ED41
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:42:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LpXDJ3zdqzWf76;
        Thu, 21 Jul 2022 20:38:24 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 20:42:13 +0800
CC:     <yangyicong@hisilicon.com>, Ingo Molnar <mingo@redhat.com>,
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
        <prime.zeng@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        Yang Shen <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        Chen Yu <yu.c.chen@intel.com>, <wuyun.abel@bytedance.com>
Subject: Re: [RESEND PATCH v5 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
To:     Peter Zijlstra <peterz@infradead.org>,
        Barry Song <21cnbao@gmail.com>
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
 <20220720081150.22167-3-yangyicong@hisilicon.com>
 <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
 <CAGsJ_4yrZnPbhBb4wd3x1h994tv6Jfri+y2xrPSJv7yF+Mj7tg@mail.gmail.com>
 <YtkrlVmqnx9VTbLl@worktop.programming.kicks-ass.net>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <0af67cbc-10a3-b5d4-d80a-e878706f8be5@huawei.com>
Date:   Thu, 21 Jul 2022 20:42:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YtkrlVmqnx9VTbLl@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/21 18:33, Peter Zijlstra wrote:
> On Thu, Jul 21, 2022 at 09:38:04PM +1200, Barry Song wrote:
>> On Wed, Jul 20, 2022 at 11:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Jul 20, 2022 at 04:11:50PM +0800, Yicong Yang wrote:
>>>> +     /* TODO: Support SMT system with cluster topology */
>>>> +     if (!sched_smt_active() && sd) {
>>>> +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
>>>
>>> So that's no SMT and no wrap iteration..
>>>
>>> Does something like this work?
>>>
>>> ---
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_s
>>>                 }
>>>         }
>>>
>>> +       if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
>>> +           static_branch_unlikely(&sched_cluster_active)) {
>>> +               struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
>>> +               if (sdc) {
>>> +                       for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
>>> +                               if (!cpumask_test_cpu(cpu, cpus))
>>> +                                       continue;
>>> +
>>> +                               if (has_idle_core) {
>>> +                                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>> +                                       if ((unsigned int)i < nr_cpumask_bits)
>>> +                                               return i;
>>> +                               } else {
>>> +                                       if (--nr <= 0)
>>> +                                               return -1;
>>> +                                       idle_cpu = __select_idle_cpu(cpu, p);
>>> +                                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>> +                                               break;
>>
>> Guess here it should be "return idle_cpu", but not "break". as "break"
>> will make us scan more
>> other cpus outside the cluster if we have found idle_cpu within the cluster.
>>

That can explain why the performance regress when underload.

>> Yicong,
>> Please test Peter's code with the above change.
> 
> Indeed. Sorry for that.
> 

The performance's still positive based on the tip/sched/core used in this patch's commit.
70fb5ccf2ebb ("sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg").

On numa 0:
                           tip/core                 patched
Hmean     1        345.89 (   0.00%)      398.43 *  15.19%*
Hmean     2        697.77 (   0.00%)      794.40 *  13.85%*
Hmean     4       1392.51 (   0.00%)     1577.60 *  13.29%*
Hmean     8       2800.61 (   0.00%)     3118.38 *  11.35%*
Hmean     16      5514.27 (   0.00%)     6124.51 *  11.07%*
Hmean     32     10869.81 (   0.00%)    10690.97 *  -1.65%*
Hmean     64      8315.22 (   0.00%)     8520.73 *   2.47%*
Hmean     128     6324.47 (   0.00%)     7253.65 *  14.69%*

On numa 0-1:
                           tip/core                 patched
Hmean     1        348.68 (   0.00%)      397.74 *  14.07%*
Hmean     2        693.57 (   0.00%)      795.54 *  14.70%*
Hmean     4       1369.26 (   0.00%)     1548.72 *  13.11%*
Hmean     8       2772.99 (   0.00%)     3055.54 *  10.19%*
Hmean     16      4825.83 (   0.00%)     5936.64 *  23.02%*
Hmean     32     10250.32 (   0.00%)    11780.59 *  14.93%*
Hmean     64     16309.51 (   0.00%)    19864.38 *  21.80%*
Hmean     128    13022.32 (   0.00%)    16365.43 *  25.67%*
Hmean     256    11335.79 (   0.00%)    13991.33 *  23.43%*

Hi Peter,

Do you want me to respin a v6 based on your change?

Thanks,
Yicong
