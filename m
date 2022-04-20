Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C324508AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379763AbiDTOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379751AbiDTOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:47:23 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F5427C6;
        Wed, 20 Apr 2022 07:44:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VAaWWIp_1650465867;
Received: from 30.30.111.41(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0VAaWWIp_1650465867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Apr 2022 22:44:30 +0800
Message-ID: <9f137001-276d-0c7c-d0f3-1d0a34355f4c@linux.alibaba.com>
Date:   Wed, 20 Apr 2022 22:44:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
From:   Wen Yang <wenyang@linux.alibaba.com>
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com>
 <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
 <YidREXNn2AtI3V1c@hirez.programming.kicks-ass.net>
 <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com>
 <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
 <05861b8c-2c7c-ae89-613a-41fcace6a174@linux.alibaba.com>
 <e50c5307-8b2d-9338-0acc-9375b76c211d@linux.alibaba.com>
 <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com>
 <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
 <CABPqkBSnJcioAeppPXtURu9+qSFpompWMrs-A=FdD76a6-+S8A@mail.gmail.com>
In-Reply-To: <CABPqkBSnJcioAeppPXtURu9+qSFpompWMrs-A=FdD76a6-+S8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/20 上午5:18, Stephane Eranian 写道:
> Hi,
> 
> Going back to the original description of this patch 2/2, it seems the
> problem was that you expected PINNED events to always remain in
> the same counters. This is NOT what the interface guarantees. A pinned
> event is guaranteed to either be on a counter or in error state if active.
> But while active the event can change counters because of event scheduling
> and this is fine. The kernel only computes deltas of the raw counter. If you
> are using the read() syscall to extract a value, then this is totally
> transparent
> and you will see no jumps. If you are instead using RDPMC, then you cannot
> assume the counter index of a pinned event remains the same. If you do, then
> yes, you will see discrepancies in the count returned by RDPMC.  You cannot
> just use RDPMC to read a counter from user space. You need kernel help.
> The info you need is in the page you must mmap on the fd of the event. It
> shows the current counter index of the event along with sequence number and
> timing to help scale the count if necessary. This proper loop for
> RDPMC is documented
> in include/uapi/linux/perf_event.h inside the perf_event_mmap_page definition.
> 
> As for TFA, it is not clear to me why this is a problem unless you
> have the RDPMC problem
> I described above.
> 

Thank you for your comments.

Our scenario is: all four GP are used up, and the abnormal PMC3 counter 
is observed on several machines. In addition, the kernel version is 
4.9/4.19.

After we encountered the problem of abnormal CPI data a few months ago, 
we checked all kinds of applications according to your suggestions here 
and finally determined that they all comply with the specifications in 
include/uapi/linux/perf_event.h.

After a long experiment, it was found that this problem was caused by TFA:

When Restricted Transactional Memory (RTM) is supported 
(CPUID.07H.EBX.RTM [bit 11] = 1) and CPUID.07H.EDX[bit 13]=1 and 
TSX_FORCE_ABORT[RTM_FORCE_ABORT]=0 (described later in this document), 
then Performance Monitor Unit (PMU) general purpose counter 3 
(IA32_PMC3, MSR C4H and IA32_A_PMC3, MSR 4C4H) may contain unexpected 
values. Specifically, IA32_PMC3 (MSR C4H), IA32_PERF_GLOBAL_CTRL[3] (MSR 
38FH) and IA32_PERFEVTSEL3 (MSR 189H) may contain unexpected values, 
which also affects IA32_A_PMC3 (MSR 4C4H) and IA32_PERF_GLOBAL_INUSE[3] 
(MSR 392H).
--> from 
https://www.intel.com/content/dam/support/us/en/documents/processors/Performance-Monitoring-Impact-of-TSX-Memory-Ordering-Issue-604224.pdf

We also submitted an IPS to Intel:
https://premiersupport.intel.com/IPS/5003b00001fqdhaAAA

For the latest kernel, this issue could be handled by the following commit:
400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")

However, many production environments are 4.9, 4.19, or even 3.10 
kernel, which do not contain the above commit, and it is difficult to 
make hotfix from this commit, so these kernels will be affected by this 
problem.

This patch 2/2 attempts to avoid the switching of the pmu counters in 
various perf_events, so the special behavior of a single pmu counter 
(eg, PMC3 here) will not be propagated to other events. We also made 
hotfix from it and verified it on some machines.

Please have another look.
Thanks

--
Best wishes,
Wen


> 
> On Tue, Apr 19, 2022 at 1:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Apr 19, 2022 at 10:16:12PM +0800, Wen Yang wrote:
>>> We finally found that TFA (TSX Force Abort) may affect PMC3's behavior,
>>> refer to the following patch:
>>>
>>> 400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")
>>>
>>> When the MSR gets set; the microcode will no longer use PMC3 but will
>>> Force Abort every TSX transaction (upon executing COMMIT).
>>>
>>> When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
>>> PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
>>> unused.
>>>
>>> When TFA is not allowed; clear PMC3 from all constraints such that it
>>> will not get used.
>>>
>>>
>>>>
>>>> However, this patch attempts to avoid the switching of the pmu counters
>>>> in various perf_events, so the special behavior of a single pmu counter
>>>> will not be propagated to other events.
>>>>
>>>
>>> Since PMC3 may have special behaviors, the continuous switching of PMU
>>> counters may not only affects the performance, but also may lead to abnormal
>>> data, please consider this patch again.
>>
>> I'm not following. How do you get abnormal data?
>>
>> Are you using RDPMC from userspace? If so, are you following the
>> prescribed logic using the self-monitoring interface?
