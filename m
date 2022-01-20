Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E991495292
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbiATQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:45:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12225 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234766AbiATQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642697115; x=1674233115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QkpJJGQO22rQYol2lb3Srsb4ZvNVuO0m8EXzJsiR5f0=;
  b=kmMnyotzwezfdHlhy80wbDE8CbxvIVB3GLzcVvRnddqe5PszPvjnQtP1
   Swwl2IwHUnNIZKVswK/jV+OBVIcRBIpMWyFzfiEaQrDMy54Uy7IZiGen2
   uUoBh6WEt5PejoNCY+ACEhpklJRJDaGfWkFrJhYiFVaZul3IyfwUG2V/a
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2022 08:45:14 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 08:45:13 -0800
Received: from [10.216.49.131] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 20 Jan
 2022 08:45:10 -0800
Message-ID: <b528a922-da84-32c2-963f-458b1e834c15@quicinc.com>
Date:   Thu, 20 Jan 2022 22:15:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/fair: Prefer small idle cores for forkees
Content-Language: en-US
To:     Vincent Donnefort <vincent.donnefort@arm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_lingutla@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <quic_rjendra@quicinc.com>
References: <20220112143902.13239-1-quic_ctheegal@quicinc.com>
 <YeBRD9zKSLPBFX+j@FVFF7649Q05P>
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
In-Reply-To: <YeBRD9zKSLPBFX+j@FVFF7649Q05P>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2022 10:05 PM, Vincent Donnefort wrote:
> On Wed, Jan 12, 2022 at 08:09:02PM +0530, Chitti Babu Theegala wrote:
>> Newly forked threads don't have any useful utilization data yet and
>> it's not possible to forecast their impact on energy consumption.
>> update_pick_idlest These forkees (though very small, most times) end up waking big
>> cores from deep sleep for that very small durations.
>>
>> Bias all forkees to small cores to prevent waking big cores from deep
>> sleep to save power.
> 
> This bias might be interesting for some workloads, but what about the
> others? (see find_energy_efficient_cpu() comment, which discusses forkees).
> 

Yes, I agree with the find_energy_efficient_cpu() comment that we don't 
have any useful utilization data yet and hence not possible to forecast. 
However, I don't see any point in penalizing the power by waking up 
bigger cores which are in deep sleep state for very small workloads.

This patch helps lighter workloads during idle conditions w.r.t power 
POV. For active (interactive or heavier) workloads, on most big.Little 
systems' these foreground tasks get pulled into gold affined cpu-sets 
where this patch would not play any spoilsport. Even for systems with 
such cpu-sets not defined, heavy workloads might need just another 1 or 
2 scheduling windows for ramping to better freq or core.

>>
>> Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
>> ---
>>   kernel/sched/fair.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6e476f6..d407bbc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5976,7 +5976,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>>   }
>>   
>>   static struct sched_group *
>> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
>> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
>>   
>>   /*
>>    * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
>> @@ -6063,7 +6063,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>>   			continue;
>>   		}
>>   
>> -		group = find_idlest_group(sd, p, cpu);
>> +		group = find_idlest_group(sd, p, cpu, sd_flag);
>>   		if (!group) {
>>   			sd = sd->child;
>>   			continue;
>> @@ -8997,7 +8997,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>   static bool update_pick_idlest(struct sched_group *idlest,
>>   			       struct sg_lb_stats *idlest_sgs,
>>   			       struct sched_group *group,
>> -			       struct sg_lb_stats *sgs)
>> +			       struct sg_lb_stats *sgs,
>> +			       int sd_flag)
>>   {
>>   	if (sgs->group_type < idlest_sgs->group_type)
>>   		return true;
>> @@ -9034,6 +9035,11 @@ static bool update_pick_idlest(struct sched_group *idlest,
>>   		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>>   			return false;
>>   
>> +		/* Select smaller cpu group for newly woken up forkees */
>> +		if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
>> +			!capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
>> +			return false;
>> +
> 
> Energy biased placement should probably be applied only when EAS is enabled.
> 
> It's especially true here, if all CPUs have the same capacity, capacity_greater
> would be always false. So unless I missed something, we wouldn't let the group_util
> evaluation happen, would we?

True. I am uploading new version patch with a EAS enablement check in place.

> 
> [...]
