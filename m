Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548D24922B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbiARJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:27:17 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46151 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234638AbiARJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642498036; x=1674034036;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pBpAdki5wF5bxKDytfc9sD9oUt2UYpuMdypcx78WBtM=;
  b=Ier3qBJOMHQ4oQxfLsfiJ1nEGTQztqkg+2xZPFoxR5mzS7E3+9/CHni8
   cHSVfn5PLYz+UlHsqBzcm0jIM7VHhhT4J9DCmsR3mHA6BHHUER/uu1yVa
   HIQxsvhltMt+bxNrt6wvqaVA0XVZqqdSXYC3yWy/OVmAQkaAvQpnBapSO
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jan 2022 01:27:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:27:16 -0800
Received: from [10.216.2.106] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 18 Jan
 2022 01:27:13 -0800
Subject: Re: Query on moving Recovery remoteproc work to a separate wq instead
 of system freezable wq
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <ea64436c-3d9b-9ac1-d4e8-38f15142a764@quicinc.com>
 <YeXrtuQglDwhNvLm@builder.lan>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
Message-ID: <03bde95c-dfd3-cdf6-2b0f-afa6a0ec036d@quicinc.com>
Date:   Tue, 18 Jan 2022 14:57:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeXrtuQglDwhNvLm@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/2022 3:50 AM, Bjorn Andersson wrote:
> On Mon 17 Jan 09:09 CST 2022, Mukesh Ojha wrote:
>
>> Hi,
>>
>> There could be a situation there is too much load(of tasks which is affined
> As in "it's theoretically possible" or "we run into this issue all the
> time"?

During recovery we notify all the remoteproc kernel clients about the 
crash and if one of the notification gets stuck

for more than 20-30s we ideally inject panic . During analysis, We saw 
that just because of the load(stress testing) on the

core we are not able to proceed. would be good to avail this work to run 
on different CPU.

>
>> to particular core) on a core on which  rproc
>> recovery thread will not get a chance to run with no reason but the load. If
>> we make this queue unbound, then this work
>> can run on any core.
>>
>> Kindly Let me if i can post a proper patch for this like below.
>>
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
>>
>>   /* Unique indices for remoteproc devices */
>>   static DEFINE_IDA(rproc_dev_index);
>> +static struct workqueue_struct *rproc_recovery_wq;
>>
>>   static const char * const rproc_crash_names[] = {
>>          [RPROC_MMUFAULT]        = "mmufault",
>> @@ -2487,7 +2488,7 @@ void rproc_report_crash(struct rproc *rproc, enum
>> rproc_crash_type type)
>>                  rproc->name, rproc_crash_to_string(type));
>>
>>          /* Have a worker handle the error; ensure system is not suspended */
>> -       queue_work(system_freezable_wq, &rproc->crash_handler);
>> +       queue_work(rproc_recovery_wq, &rproc->crash_handler);
>>   }
>>   EXPORT_SYMBOL(rproc_report_crash);
>>
>> @@ -2532,6 +2533,12 @@ static void __exit rproc_exit_panic(void)
>>
>>   static int __init remoteproc_init(void)
>>   {
>> +       rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", WQ_UNBOUND
>> |
>> +                               WQ_HIGHPRI | WQ_FREEZABLE |
>> WQ_CPU_INTENSIVE, 0);
> Afaict this is not only a separate work queue, but a high priority, "cpu
> intensive" work queue. Does that really represent the urgency of getting
> the recovery under way?

Adding a WQ_CPU_INTENSIVE(no use) here is a blunder from my end, will 
remove this.

Thanks,
-Mukesh

> Regards,
> Bjorn
>
>> +       if (!rproc_recovery_wq) {
>> +               pr_err("creation of rproc_recovery_wq failed\n");
>> +       }
>> +
>>
>> Thanks,
>> Mukesh
