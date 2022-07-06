Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0B567CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGFDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiGFDpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:45:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D891CFE4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657079113; x=1688615113;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E2AGY44ukjmR7luNq8ch7uiSXlr/YkhnwBdinzjcxg8=;
  b=v3qfQPGiRnlwmzGgW+2sQ1e7yBelJKsbZfzzXldonIIW9Ig1x5Pd1GfB
   BwFQMDCgDUloXBrKX55bZpDkrpi9F/Ubpm5vHdyKAhJ85lRn+SggQCber
   ad0arcZb6srWsl5frZA2RCaLZJaRyPEbQiOX9NffbFJSTYSu+OEu6Jd9g
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 20:45:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:45:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 20:45:12 -0700
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 20:45:11 -0700
Subject: Re: [PATCH] sched: fix rq lock recursion issue
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <20220630215310.wb3kab72tlh5pq2g@airbuntu>
 <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
 <20220701114846.42o2tkm5fqt325df@wubuntu>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <8e1760f5-bf3e-ceed-3a13-64ac1bd85a29@quicinc.com>
Date:   Tue, 5 Jul 2022 20:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220701114846.42o2tkm5fqt325df@wubuntu>
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


On 7/1/22 4:48 AM, Qais Yousef wrote:
> On 07/01/22 10:33, Peter Zijlstra wrote:
>> On Thu, Jun 30, 2022 at 10:53:10PM +0100, Qais Yousef wrote:
>>> Hi Satya
>>>
>>> On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
>>>> Below recursion is observed in a rare scenario where __schedule()
>>>> takes rq lock, at around same time task's affinity is being changed,
>>>> bpf function for tracing sched_switch calls migrate_enabled(),
>>>> checks for affinity change (cpus_ptr != cpus_mask) lands into
>>>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>>>> recursion bug.
>>>>
>>>> Fix the issue by switching to preempt_enable/disable() for non-RT
>>>> Kernels.
>>> Interesting bug. Thanks for the report. Unfortunately I can't see this being
>>> a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
>>> anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.
>> Worse, there's !RT stuff that grew to rely on the preemptible migrate
>> disable stuff, so this actively breaks things.
>>
>>> I'm curious how the race with set affinity is happening. I would have thought
>>> user space would get blocked as __schedule() will hold the rq lock.
>>>
>>> Do you have more details on that?
>> Yeah, I'm not seeing how this works either, in order for
>> migrate_enable() to actually call __set_cpus_allowed_ptr(), it needs to
>> have done migrate_disable() *before* schedule, schedule() will then have
>> to call migrate_disable_swich(), and *then* migrate_enable() does this.
>>
>> However, if things are nicely balanced (as they should be), then
>> trace_call_bpf() using migrate_disable()/migrate_enable() should never
>> hit this path.
>>
>> If, OTOH, migrate_disable() was called prior to schedule() and we did do
>> migrate_disable_switch(), then it should be impossible for the
>> tracepoint/bpf stuff to reach p->migration_disabled == 0.
> I think it's worth to confirm which kernel Satya is on too. If it's GKI, then
> worth checking first this is actually reproducible on/applicable to mainline.
We are seeing the issue on 5.15 GKI Kernel. On older Kernels, like 5.10 
Kernel
migrate_disable/enable() end-up calling preempt_disable/enable(). I will 
cross
check further on comments and inputs I received so far.

>
> Cheers
>
> --
> Qais Yousef
