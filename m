Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310504AF46D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiBIOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiBIOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:52:52 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57971C06157B;
        Wed,  9 Feb 2022 06:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644418375; x=1675954375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jy56aOvIJnkxVupadGEe3soUmE/7DFN/aslWw/+yKeE=;
  b=Jt1mraJkGqdqG2Y+OA1WnezYS2wuE6gllxDucPjmajX4WGBnjCE92b26
   864/KfKgOqlYrg/iD4RIk7mhfrmpjM8VPjnzKo8mOBP4ef6eViGwrRsXO
   AXzyj+hKdqBQE2f+auJPZA6otWOHxUsQUwxmmGC7/A6dVd5jC5+yk6MnB
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 06:52:55 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:52:55 -0800
Received: from [10.216.56.214] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 06:52:51 -0800
Message-ID: <636929f8-0448-8ed9-34d2-ddc442f6b205@quicinc.com>
Date:   Wed, 9 Feb 2022 20:22:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/uclamp: New sysctl to tweak boost for uclamp tasks
Content-Language: en-US
To:     Vincent Donnefort <vincent.donnefort@arm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_lingutla@quicinc.com>, <linux-kernel@vger.kernel.org>
References: <20220209134319.1183-1-quic_ctheegal@quicinc.com>
 <YgPIzXWpWeEpUJbi@FVFF7649Q05P>
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
In-Reply-To: <YgPIzXWpWeEpUJbi@FVFF7649Q05P>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, please ignore this patch. It was wrongly uploaded here.
Will pursue this to right tree.

On 2/9/2022 7:29 PM, Vincent Donnefort wrote:
> [...]
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 634d571e39d77..55019eb9c83c5 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1269,6 +1269,14 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>>    */
>>   unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
>>   
>> +/* UCLAMP_MIN knob clamps the util_value within uclamp_min & max. By default,
>> + * these uclamped tasks are also boosted to bigger cores which can impact power.
>> + *
>> + * This knob provides an option to turn-off 'boosting to gold cores' and
>> + * just restrict to 'clamping util value' job.
>> + */
>> +unsigned int sysctl_sched_uclamp_util_min_to_boost = 1;
>> +
>>   /* All clamps are required to be less or equal than these values */
>>   static struct uclamp_se uclamp_default[UCLAMP_CNT];
>>   
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7cd316793f4e3..44adcbfa9eb32 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6829,7 +6829,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu, int sy
>>   		goto unlock;
>>   
>>   	latency_sensitive = uclamp_latency_sensitive(p);
> 
> I don't think this is the right tree.

Thanks ! I just noticed it :-(

> 
> 
>> -	boosted = uclamp_boosted(p);
>> +	boosted = sysctl_sched_uclamp_util_min_to_boost && uclamp_boosted(p);
>>   	target_cap = boosted ? 0 : ULONG_MAX;
>>   
>>   	for (; pd; pd = pd->next) {
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 8f196ed2ec065..6463d60fed84e 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1882,6 +1882,15 @@ static struct ctl_table kern_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= sysctl_sched_uclamp_handler,
>>   	},
>> +	{
>> +		.procname	= "sched_util_clamp_min_to_boost",
>> +		.data		= &sysctl_sched_uclamp_util_min_to_boost,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>>   #endif
>>   #ifdef CONFIG_SCHED_AUTOGROUP
>>   	{
>> -- 
>> 2.17.1
>>
