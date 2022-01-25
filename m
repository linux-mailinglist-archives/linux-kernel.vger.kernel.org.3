Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F149AD48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442903AbiAYHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:12:01 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6123 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1442276AbiAYHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643094542; x=1674630542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zr+uci7nAntwhy8NrWrL5PmRMbYwGWsGjAlVl3fZ4k0=;
  b=cCIsVpRp+Hp7ZnvPMKZvI6zOPlq8SyeACy5LWty6UNFH93bQpbPDggrl
   5DGYmXa4XhTouQUN7VhetFlQNz0acGXWtmrdOyJ1aY93lxVtJQGtpkUic
   Qexs7fAzCS/cB6AiU/lmKd0iXe6MyxgT2sQpmjwd7DuSdoYYue9rj8L79
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jan 2022 23:08:59 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:08:59 -0800
Received: from [10.216.52.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 24 Jan
 2022 23:08:54 -0800
Message-ID: <e60c7e8a-3eb4-d6b4-18c5-819089256c34@quicinc.com>
Date:   Tue, 25 Jan 2022 12:38:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] sched/fair: Prefer small idle cores for forkees
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <joel@joelfernandes.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_lingutla@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <Vincent.Donnefort@arm.com>
References: <20220121050233.8708-1-quic_ctheegal@quicinc.com>
 <CAKfTPtDTm5O_P504=_6Gjk2Uv0DiLS8Mu=c6km3uVO0h8BB1Lw@mail.gmail.com>
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
In-Reply-To: <CAKfTPtDTm5O_P504=_6Gjk2Uv0DiLS8Mu=c6km3uVO0h8BB1Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/2022 7:57 PM, Vincent Guittot wrote:
> On Fri, 21 Jan 2022 at 06:03, Chitti Babu Theegala
> <quic_ctheegal@quicinc.com> wrote:
>>
>> Newly forked threads don't have any useful utilization data yet and
>> it's not possible to forecast their impact on energy consumption.
> 
> It would be worth mentioning that you consider only EAS mode in the patch
> 
>> These forkees (though very small, most times) end up waking big
> 
> The assumption that " (though very small, most times)" is maybe true
> for the cases that you are interested in and you monitor, but it's not
> always true. It seems that Vincent D. raised some concerns about
> forkee which would not be small at the end
Agreed.

>> cores from deep sleep for that very small durations.
>>
>> Bias all forkees to small cores to prevent waking big cores from deep
> 
> you are testing idlest_sgs->idle_cpus so you don't bias to small cores
> but small & idle cores but if there is no small idle core then you
> will wake up a big core though the forkees are small most times
> 

The function "find_idlest_cpu" expected to return idle cpu. So, I 
followed the same. If idle small cpu is available, then we can use it 
otherwise its ok to wakeup big cpu for newly forked tasks.
I felt that using idle CPUs for new tasks will be better as that would 
give them a faster chance to run immediately.

>> sleep to save power.
> 
> Then why do you want to wake up a small core from deep state instead
> of packing in one of these already running cpus? If you care about
> power, selecting a small idle core may not always be the best choice.
> Would it be better to select a non idle cpu with largest spare
> capacity at the current opp ?
> 

How about running find_energy_efficient_cpu() for newly forked tasks as 
well (with some default util value configured) ?

>>
>> Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
>> ---
>> Changes in v2:
>> 1. Enclosed the EAS check for this small core preferring logic
>> ---
>>   kernel/sched/fair.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c6046446c50b3..72f9ea7c98c05 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5872,7 +5872,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>>   }
>>
>>   static struct sched_group *
>> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
>> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
>>
>>   /*
>>    * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
>> @@ -5959,7 +5959,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>>                          continue;
>>                  }
>>
>> -               group = find_idlest_group(sd, p, cpu);
>> +               group = find_idlest_group(sd, p, cpu, sd_flag);
>>                  if (!group) {
>>                          sd = sd->child;
>>                          continue;
>> @@ -8885,7 +8885,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>   static bool update_pick_idlest(struct sched_group *idlest,
>>                                 struct sg_lb_stats *idlest_sgs,
>>                                 struct sched_group *group,
>> -                              struct sg_lb_stats *sgs)
>> +                              struct sg_lb_stats *sgs,
>> +                              int sd_flag)
>>   {
>>          if (sgs->group_type < idlest_sgs->group_type)
>>                  return true;
>> @@ -8922,6 +8923,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
>>                  if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>>                          return false;
>>
>> +               if (sched_energy_enabled()) {
> 
> This is not enough, the find_energy_efficient_cpu() returns early to
> fallback to the default performance mode when the system is
> overutilized
> 
> 
>> +                   /* Select smaller cpu group for newly woken up forkees */
>> +                   if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
>> +                       !capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
>> +                       return false;
>> +               }
>> +
>>                  /* Select group with lowest group_util */
>>                  if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
>>                          idlest_sgs->group_util <= sgs->group_util)
>> @@ -8940,7 +8948,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
>>    * Assumes p is allowed on at least one CPU in sd.
>>    */
>>   static struct sched_group *
>> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag)
>>   {
>>          struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>>          struct sg_lb_stats local_sgs, tmp_sgs;
>> @@ -8978,7 +8986,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>
>>                  update_sg_wakeup_stats(sd, group, sgs, p);
>>
>> -               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
>> +               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs, sd_flag)) {
>>                          idlest = group;
>>                          idlest_sgs = *sgs;
>>                  }
>> --
>> 2.17.1
>>
