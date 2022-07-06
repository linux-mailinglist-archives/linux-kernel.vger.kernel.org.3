Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3C567CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiGFDuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiGFDty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:49:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C502205DB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657079288; x=1688615288;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FtAQ47kRhcsSDlE6KTDwkolcwd+jvA+etT4YjBKsmM0=;
  b=i52ws6+aDrB9+XkNaAFnhw3IruZXZnF7auoqvUgUiyOdfb4b9fOLY6Pm
   wjowZJyz7GpwHNyNVu9KMLv8oh1/GA4gY1j4zWK3oykMiW9yqqy6W4Q+Q
   4GHcKUL3jhuJeG6Gjwr15zfeR/dChDQaY8QSIb3UAJM1K3TwjfHz77krC
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 20:48:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:48:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 20:47:33 -0700
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 20:47:33 -0700
Subject: Re: [PATCH] sched: fix rq lock recursion issue
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <037be4d3-0474-ba9f-fd0f-4bd9af3e835d@quicinc.com>
Date:   Tue, 5 Jul 2022 20:47:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/22 3:37 PM, Steven Rostedt wrote:
> On Fri, Jun 24, 2022 at 12:42:40AM -0700, Satya Durga Srinivasu Prabhala wrote:
>> Below recursion is observed in a rare scenario where __schedule()
>> takes rq lock, at around same time task's affinity is being changed,
>> bpf function for tracing sched_switch calls migrate_enabled(),
>> checks for affinity change (cpus_ptr != cpus_mask) lands into
>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>> recursion bug.
>>
>> Fix the issue by switching to preempt_enable/disable() for non-RT
>> Kernels.
>>
>> -010 |spin_bug(lock = ???, msg = ???)
>> -011 |debug_spin_lock_before(inline)
>> -011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
>> -012 |_raw_spin_lock(inline)
>> -012 |raw_spin_rq_lock_nested(inline)
>> -012 |raw_spin_rq_lock(inline)
>> -012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
>> -013 |__set_cpus_allowed_ptr(inline)
>> -013 |migrate_enable()
>> -014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
>> -015 |perf_trace_run_bpf_submit(inline)
>> -015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
>> -016 |__traceiter_sched_switch(inline)
>> -016 |trace_sched_switch(inline)
> trace_sched_switch() disables preemption.
>
> So how is this a fix?
Thanks for your time and comments.
I was more looking at non-RT Kernel where switching to 
preempt_disable/enable() helps as it's
just increment/decrement of count. I agree, this isn't a right fix.
I'm still cross checking on easy way to repro the issue. Will cross 
check further and get back.

>
> -- Steve
>
>> -016 |__schedule(sched_mode = ?)
>> -017 |schedule()
>> -018 |arch_local_save_flags(inline)
>> -018 |arch_irqs_disabled(inline)
>> -018 |__raw_spin_lock_irq(inline)
>> -018 |_raw_spin_lock_irq(inline)
>> -018 |worker_thread(__worker = 0xFFFFFF88CE251300)
>> -019 |kthread(_create = 0xFFFFFF88730A5A80)
>> -020 |ret_from_fork(asm)
>>
>> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
>> ---
>>   kernel/sched/core.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bfa7452ca92e..e254e9227341 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2223,6 +2223,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
>>   
>>   void migrate_disable(void)
>>   {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	struct task_struct *p = current;
>>   
>>   	if (p->migration_disabled) {
>> @@ -2234,11 +2235,15 @@ void migrate_disable(void)
>>   	this_rq()->nr_pinned++;
>>   	p->migration_disabled = 1;
>>   	preempt_enable();
>> +#else
>> +	preempt_disable();
>> +#endif
>>   }
>>   EXPORT_SYMBOL_GPL(migrate_disable);
>>   
>>   void migrate_enable(void)
>>   {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	struct task_struct *p = current;
>>   
>>   	if (p->migration_disabled > 1) {
>> @@ -2265,6 +2270,9 @@ void migrate_enable(void)
>>   	p->migration_disabled = 0;
>>   	this_rq()->nr_pinned--;
>>   	preempt_enable();
>> +#else
>> +	preempt_enable();
>> +#endif
>>   }
>>   EXPORT_SYMBOL_GPL(migrate_enable);
>>   
>> -- 
>> 2.36.1
