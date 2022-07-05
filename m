Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39425660F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiGECHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGECHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:07:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8411814
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656986819; x=1688522819;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kCl+h+ILPuM/RvclNCLRoduOSn8uCNKH6YXy8TDjQoI=;
  b=EqECdQR7D2UkHEjEasoxWI75x3dyuA7HfDcL9ckGsaq77vPZ/Qq9YtIW
   7MODZzqmYGtXMowJIcLfst4zCneVbPKIZ+H5ZpxkX0guFDEgun5GvTbTD
   7yRVuDoNCW76BV9eXdQPnnvdbdma6qQs4yqY7ncHr4IPGfgRCnP7Yki4X
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 19:06:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:06:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 19:06:57 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Jul 2022
 19:06:57 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     'Qais Yousef' <qais.yousef@arm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com> <20220630215310.wb3kab72tlh5pq2g@airbuntu>
In-Reply-To: <20220630215310.wb3kab72tlh5pq2g@airbuntu>
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Date:   Mon, 4 Jul 2022 19:06:56 -0700
Message-ID: <000001d89013$e7bd4970$b737dc50$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFw7FN9HtWlcsLjczDM6sxRXAAZjQFiJiRMAOaDo6s=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/22 2:53 PM, Qais Yousef wrote:
> Hi Satya
>
> On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
>> Below recursion is observed in a rare scenario where __schedule()
>> takes rq lock, at around same time task's affinity is being changed,
>> bpf function for tracing sched_switch calls migrate_enabled(),
>> checks for affinity change (cpus_ptr !=3D cpus_mask) lands into
>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>> recursion bug.
>>
>> Fix the issue by switching to preempt_enable/disable() for non-RT
>> Kernels.
> Interesting bug. Thanks for the report. Unfortunately I can't see this =
being
> a fix as it just limits the bug visibility to PREEMPT_RT kernels, but =
won't fix
> anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this =
failure.
Thanks for taking a look. That's right.
> I'm curious how the race with set affinity is happening. I would have =
thought
> user space would get blocked as __schedule() will hold the rq lock.
>
> Do you have more details on that?
I'm still trying to figure out how we even end with up such a race. No=20
easy way repro
the issue, I'm checking internally with some debug logs.
>
> Thanks
>
> --
> Qais Yousef
>
>> -010 |spin_bug(lock =3D ???, msg =3D ???)
>> -011 |debug_spin_lock_before(inline)
>> -011 |do_raw_spin_lock(lock =3D 0xFFFFFF89323BB600)
>> -012 |_raw_spin_lock(inline)
>> -012 |raw_spin_rq_lock_nested(inline)
>> -012 |raw_spin_rq_lock(inline)
>> -012 |task_rq_lock(p =3D 0xFFFFFF88CFF1DA00, rf =3D =
0xFFFFFFC03707BBE8)
>> -013 |__set_cpus_allowed_ptr(inline)
>> -013 |migrate_enable()
>> -014 |trace_call_bpf(call =3D ?, ctx =3D 0xFFFFFFFDEF954600)
>> -015 |perf_trace_run_bpf_submit(inline)
>> -015 |perf_trace_sched_switch(__data =3D 0xFFFFFFE82CF0BCB8, preempt =
=3D FALSE, prev =3D ?, next =3D ?)
>> -016 |__traceiter_sched_switch(inline)
>> -016 |trace_sched_switch(inline)
>> -016 |__schedule(sched_mode =3D ?)
>> -017 |schedule()
>> -018 |arch_local_save_flags(inline)
>> -018 |arch_irqs_disabled(inline)
>> -018 |__raw_spin_lock_irq(inline)
>> -018 |_raw_spin_lock_irq(inline)
>> -018 |worker_thread(__worker =3D 0xFFFFFF88CE251300)
>> -019 |kthread(_create =3D 0xFFFFFF88730A5A80)
>> -020 |ret_from_fork(asm)
>>
>> Signed-off-by: Satya Durga Srinivasu Prabhala =
<quic_satyap@quicinc.com>
>> ---
>>   kernel/sched/core.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bfa7452ca92e..e254e9227341 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2223,6 +2223,7 @@ static void migrate_disable_switch(struct rq =
*rq, struct task_struct *p)
>>  =20
>>   void migrate_disable(void)
>>   {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	struct task_struct *p =3D current;
>>  =20
>>   	if (p->migration_disabled) {
>> @@ -2234,11 +2235,15 @@ void migrate_disable(void)
>>   	this_rq()->nr_pinned++;
>>   	p->migration_disabled =3D 1;
>>   	preempt_enable();
>> +#else
>> +	preempt_disable();
>> +#endif
>>   }
>>   EXPORT_SYMBOL_GPL(migrate_disable);
>>  =20
>>   void migrate_enable(void)
>>   {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	struct task_struct *p =3D current;
>>  =20
>>   	if (p->migration_disabled > 1) {
>> @@ -2265,6 +2270,9 @@ void migrate_enable(void)
>>   	p->migration_disabled =3D 0;
>>   	this_rq()->nr_pinned--;
>>   	preempt_enable();
>> +#else
>> +	preempt_enable();
>> +#endif
>>   }
>>   EXPORT_SYMBOL_GPL(migrate_enable);
>>  =20
>> --=20
>> 2.36.1
>>

