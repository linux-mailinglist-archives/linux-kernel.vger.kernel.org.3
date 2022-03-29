Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB994EA91E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiC2IZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiC2IZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:25:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B902252D;
        Tue, 29 Mar 2022 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648542203; x=1680078203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nHVoNu5kgc0SwtZZ5WltSamwVIVIgMmiXJdovOQdV0c=;
  b=YdjO8oMOoscy5ICpCJDfEcYnfjliiGqHJ/I4GQywzcUl6mGBgN9/9MN0
   woV7MLe3JOwEIbcJh+vb9hHNyZAx+jPkuH4r+9E0eheG4nr5JRrYmQwE4
   7R4yv7XWZt6kcIyX3/iM3YSFatOJayNaF84uSs+gcWVSI5fQAGul3DmMP
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Mar 2022 01:23:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 01:23:23 -0700
Received: from [10.110.1.142] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 01:23:20 -0700
Message-ID: <404f5f3e-3211-7eb4-1bba-2eea5239d0e7@quicinc.com>
Date:   Tue, 29 Mar 2022 13:53:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] remoteproc: Use unbounded/high priority workqueue for
 recovery work
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mathieu.poirier@linaro.org>
References: <1642620644-19297-1-git-send-email-quic_mojha@quicinc.com>
 <Yiu4vKuqWHQ5wfZ1@builder.lan>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <Yiu4vKuqWHQ5wfZ1@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/2022 2:31 AM, Bjorn Andersson wrote:
> On Wed 19 Jan 13:30 CST 2022, Mukesh Ojha wrote:
>
>> There could be a scenario where there is too much load(n number
>> of tasks which is affined) on a core on which rproc recovery
>> is queued. Due to which, it takes number of seconds to complete
>> the recovery.
>>
>> If we make this queue unbounded and move it to high priority worker
>> pool then this work can be attempted to finished in less time.
> I unfortunately find this reasoning for adding WQ_HIGHPRI rather
> speculative. Please describe a concrete case that warrants the new
> work queue to be high priority.
>
> What is "number of seconds", what is "less time" and why is it more
> important to recover some remote processor than whatever else the system
> is busy doing?

Meanwhile, I will try to check if making it unbound only helps us in our 
low latency use cases.
So, does it make sense to make it  Unbound | freezable ?

-Mukesh

> Thanks,
> Bjorn
>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 69f51ac..efb6316 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
>>   
>>   /* Unique indices for remoteproc devices */
>>   static DEFINE_IDA(rproc_dev_index);
>> +static struct workqueue_struct *rproc_recovery_wq;
>>   
>>   static const char * const rproc_crash_names[] = {
>>   	[RPROC_MMUFAULT]	= "mmufault",
>> @@ -2752,8 +2753,10 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>>   	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>>   		rproc->name, rproc_crash_to_string(type));
>>   
>> -	/* Have a worker handle the error; ensure system is not suspended */
>> -	queue_work(system_freezable_wq, &rproc->crash_handler);
>> +	if (rproc_recovery_wq)
>> +		queue_work(rproc_recovery_wq, &rproc->crash_handler);
>> +	else
>> +		queue_work(system_freezable_wq, &rproc->crash_handler);
>>   }
>>   EXPORT_SYMBOL(rproc_report_crash);
>>   
>> @@ -2802,6 +2805,11 @@ static void __exit rproc_exit_panic(void)
>>   
>>   static int __init remoteproc_init(void)
>>   {
>> +	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", WQ_UNBOUND |
>> +				WQ_HIGHPRI | WQ_FREEZABLE, 0);
>> +	if (!rproc_recovery_wq)
>> +		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
>> +
>>   	rproc_init_sysfs();
>>   	rproc_init_debugfs();
>>   	rproc_init_cdev();
>> @@ -2818,6 +2826,8 @@ static void __exit remoteproc_exit(void)
>>   	rproc_exit_panic();
>>   	rproc_exit_debugfs();
>>   	rproc_exit_sysfs();
>> +	if (rproc_recovery_wq)
>> +		destroy_workqueue(rproc_recovery_wq);
>>   }
>>   module_exit(remoteproc_exit);
>>   
>> -- 
>> 2.7.4
>>
