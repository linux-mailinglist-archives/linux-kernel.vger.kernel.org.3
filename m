Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFC567CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGFDtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGFDsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:48:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1F2229E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657079216; x=1688615216;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1NeZfwQyd5I+JVGqkIE4Ebk0E1m00zBIsonZreeWk8o=;
  b=iZFx3hgtY+qZvKRXXB4pzPwNgTq3+1SpJIPyjjJGGC/SCQx/qOfCqtZz
   gGBmMLPtFuHBedknWnaHwftRRIv0PPVi5uzYyWegA1sK0+w6poo7DF74z
   KFNcfI43Z3XozUNql9466cazfscwdV8Y3v9Hi2qPkTPHy3uFSQQkRCNw6
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 20:46:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:46:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 20:46:55 -0700
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 20:46:55 -0700
Subject: Re: [PATCH] sched: fix rq lock recursion issue
To:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <20220630215310.wb3kab72tlh5pq2g@airbuntu>
 <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <649352a9-5cd4-cce6-62ae-e3f4aac18eef@quicinc.com>
Date:   Tue, 5 Jul 2022 20:46:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
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


On 7/1/22 1:33 AM, Peter Zijlstra wrote:
> On Thu, Jun 30, 2022 at 10:53:10PM +0100, Qais Yousef wrote:
>> Hi Satya
>>
>> On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
>>> Below recursion is observed in a rare scenario where __schedule()
>>> takes rq lock, at around same time task's affinity is being changed,
>>> bpf function for tracing sched_switch calls migrate_enabled(),
>>> checks for affinity change (cpus_ptr != cpus_mask) lands into
>>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>>> recursion bug.
>>>
>>> Fix the issue by switching to preempt_enable/disable() for non-RT
>>> Kernels.
>> Interesting bug. Thanks for the report. Unfortunately I can't see this being
>> a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
>> anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.
> Worse, there's !RT stuff that grew to rely on the preemptible migrate
> disable stuff, so this actively breaks things.
Sorry about that. I'm cross checking further on ways to repro issue easily.
>> I'm curious how the race with set affinity is happening. I would have thought
>> user space would get blocked as __schedule() will hold the rq lock.
>>
>> Do you have more details on that?
> Yeah, I'm not seeing how this works either, in order for
> migrate_enable() to actually call __set_cpus_allowed_ptr(), it needs to
> have done migrate_disable() *before* schedule, schedule() will then have
> to call migrate_disable_swich(), and *then* migrate_enable() does this.
>
> However, if things are nicely balanced (as they should be), then
> trace_call_bpf() using migrate_disable()/migrate_enable() should never
> hit this path.
>
> If, OTOH, migrate_disable() was called prior to schedule() and we did do
> migrate_disable_switch(), then it should be impossible for the
> tracepoint/bpf stuff to reach p->migration_disabled == 0.
>
Thanks for explanation. Will cross check further on these points.
>>> -010 |spin_bug(lock = ???, msg = ???)
>>> -011 |debug_spin_lock_before(inline)
>>> -011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
>>> -012 |_raw_spin_lock(inline)
>>> -012 |raw_spin_rq_lock_nested(inline)
>>> -012 |raw_spin_rq_lock(inline)
>>> -012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
>>> -013 |__set_cpus_allowed_ptr(inline)
>>> -013 |migrate_enable()
>>> -014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
>>> -015 |perf_trace_run_bpf_submit(inline)
>>> -015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
>>> -016 |__traceiter_sched_switch(inline)
>>> -016 |trace_sched_switch(inline)
>>> -016 |__schedule(sched_mode = ?)
>>> -017 |schedule()
>>> -018 |arch_local_save_flags(inline)
>>> -018 |arch_irqs_disabled(inline)
>>> -018 |__raw_spin_lock_irq(inline)
>>> -018 |_raw_spin_lock_irq(inline)
>>> -018 |worker_thread(__worker = 0xFFFFFF88CE251300)
>>> -019 |kthread(_create = 0xFFFFFF88730A5A80)
>>> -020 |ret_from_fork(asm)
> This doesn't clarify much. Please explain how things got to be
> unbalanced, don't ever just make a problem dissapear like this without
> understanding what the root cause is, that'll just get your reputation
> sullied.
Agreed, thanks for the comments and suggestion. Yes, I'm trying to cross
check further and find ways to repro the issue. Will get back once I find
a better way to handle the issue. I should have just tried to get
comments/feedback on the issue first instead proposing fix. Lesson 
learnt :)

