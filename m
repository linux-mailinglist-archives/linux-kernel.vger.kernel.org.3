Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707D567CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiGFDoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGFDoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:44:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD1167EF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657079051; x=1688615051;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aIw+qYPgwNY5VI1B0vDeShD58+usuE8lYmG7gBeu15s=;
  b=ixsUaPT8NdSUvHOY+MkSSzuwpluijrwLzxjPOw09Usf7jrvQGZmriFgS
   Guf2NtGo1xHoNdQH3+5s1q0MYjYBAq61I0HYBn/vDNibXGRoV+tRmSFoI
   UDFoPlN5DYI0eNJnAYr+4bZ44y/v3HvzBrtryO5fw3qhTIpmY8mArJrZH
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 20:44:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:44:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 20:44:10 -0700
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 20:44:09 -0700
Subject: Re: [PATCH] sched: fix rq lock recursion issue
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
 <20220701115453.259b17e6@gandalf.local.home>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <006eb3a2-acc0-3d65-f7cb-2abb6f5aadd1@quicinc.com>
Date:   Tue, 5 Jul 2022 20:44:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220701115453.259b17e6@gandalf.local.home>
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


On 7/1/22 8:54 AM, Steven Rostedt wrote:
> On Thu, 30 Jun 2022 18:37:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>>> Fix the issue by switching to preempt_enable/disable() for non-RT
>>> Kernels.
>>>
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
>> trace_sched_switch() disables preemption.
>>
>> So how is this a fix?
> Let me rephrase my question.
>
> As trace_sched_switch() disables preemption, why is trace_call_bpf()
> calling migrate_disable()?
I'm not sure, why we have migrate_disable/enable(). I will need to cross
check further.

>
> Looks like you could modify the code to include a __bpf_prog_run_array()
> that skips the migrate_disable(). You even have a "cant_sleep()" call in
> trace_call_bpf().
Thanks for the inputs. I still need to cross check and find a better way 
to repro
the issue to be able to comment further. Will cross check on your 
suggestion.

>
> -- Steve
