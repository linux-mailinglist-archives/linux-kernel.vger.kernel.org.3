Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2347E055
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347126AbhLWIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:23:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16855 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347084AbhLWIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:23:46 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JKNVP6SR0z91th;
        Thu, 23 Dec 2021 16:22:53 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 16:23:44 +0800
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <mgorman@techsingularity.net>,
        <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>, <21cnbao@gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in
 select_idle_cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
 <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com>
Date:   Thu, 23 Dec 2021 16:23:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/22 18:47, Vincent Guittot wrote:
> On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
>>
>> We regulate the LLC domain scan in select_idle_cpu() by comparing
>> the average scan cost of this_sd against the average idle time of
>> this_rq. This is correct when the domain to scan is the LLC domain
>> of this cpu. But when the domain to scan is different from this
>> LLC domain, we'll have an inaccurate estimation of the scan cost
>> on the target domain as this_sd->avg_scan_cost contains contributions
>> of scanning other domains besides the target domain.
>>
>> Track the avg_scan_cost of the target domain to make the estimation
>> more accurate.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  kernel/sched/fair.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6e476f6d9435..6301740d98cb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>                 }
>>
>>                 avg_idle = this_rq->wake_avg_idle;
>> -               avg_cost = this_sd->avg_scan_cost + 1;
>> +               avg_cost = sd->avg_scan_cost + 1;
>>
>>                 span_avg = sd->span_weight * avg_idle;
>>                 if (span_avg > 4*avg_cost)
>> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>                  */
>>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
>>
>> -               update_avg(&this_sd->avg_scan_cost, time);
>> +               update_avg(&sd->avg_scan_cost, time);
> 
> But then you can have several cpus updating the same value simultaneously
> 

yes. sd->avg_scan_cost should includes the contributions of all the cpus scanned the sd.

We regulated the scanning nr based on two things:
- avg_idle: to indicate how much time we can have for this time scanning
- avg_cost: to indicate how much time we'll spend for scanning the target domain based
            on the history cost

Previously sd->avg_scan_cost may not reflect the cost as it count the scanning cost
on the domain of the scanner cpu, which may not be the domain the cpu scanned.
For example, cpu 0 on llc A scanned llc B and llc C, we'll count the cost of scanning B
and C on llc A's avg_scan_cost and we'll use this to estimate the cost for scanning
llc A, which is not accurate.

>>         }
>>
>>         return idle_cpu;
>> --
>> 2.33.0
>>
> .
> 
