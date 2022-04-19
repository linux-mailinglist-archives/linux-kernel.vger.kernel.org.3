Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCD506FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbiDSOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346632AbiDSOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:19:03 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE75FE3;
        Tue, 19 Apr 2022 07:16:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VAVirkf_1650377772;
Received: from 30.39.169.99(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0VAVirkf_1650377772)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Apr 2022 22:16:14 +0800
Message-ID: <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com>
Date:   Tue, 19 Apr 2022 22:16:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
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
In-Reply-To: <e50c5307-8b2d-9338-0acc-9375b76c211d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/17 下午11:06, Wen Yang 写道:
> 
> 
> 在 2022/3/18 上午1:54, Wen Yang 写道:
>>
>>
>> 在 2022/3/14 下午6:55, Peter Zijlstra 写道:
>>> On Thu, Mar 10, 2022 at 11:50:33AM +0800, Wen Yang wrote:
>>>
>>>> As you pointed out, some non-compliant rdpmc can cause problems. But 
>>>> you
>>>> also know that linux is the foundation of cloud servers, and many
>>>> third-party programs run on it (we don't have any code for it), and 
>>>> we can
>>>> only observe that the monitoring data will jitter abnormally (the
>>>> probability of this issue is not high, about dozens of tens of 
>>>> thousands of
>>>> machines).
>>>
>>> This might be a novel insight, but I *really* don't give a crap about
>>> any of that. If they're not using it right, they get to keep the pieces.
>>>
>>> I'd almost make it reschedule more to force them to fix their stuff.
>>>
>>
>>
>> Thank you for your guidance.
>>
>> We also found a case in thousands of servers where the PMU counter is 
>> no longer updated due to frequent x86_pmu_stop/x86_pmu_start.
>>
>> We added logs in the kernel and found that a third-party program would 
>> cause the PMU counter to start/stop several times in just a few 
>> seconds, as follows:
>>
>>
>> [8993460.537776] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000001 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0x802a877ef302, hw.period_left=0x7fd578810cfe, 
>> event.count=0x14db802a877ecab4, event.prev_count=0x14db802a877ecab4
>> [8993460.915873] XXX x86_pmu_start line=1312 [cpu1] 
>> active_mask=200000008 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0xffff802a9cf6a166, hw.period_left=0x7fd563095e9a, 
>> event.count=0x14db802a9cf67918, event.prev_count=0x14db802a9cf67918
>> [8993461.104643] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000001 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0xffff802a9cf6a166, hw.period_left=0x7fd563095e9a, 
>> event.count=0x14db802a9cf67918, event.prev_count=0x14db802a9cf67918
>> [8993461.442508] XXX x86_pmu_start line=1312 [cpu1] 
>> active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0xffff802a9cf8492e, hw.period_left=0x7fd56307b6d2, 
>> event.count=0x14db802a9cf820e0, event.prev_count=0x14db802a9cf820e0
>> [8993461.736927] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000001 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0xffff802a9cf8492e, hw.period_left=0x7fd56307b6d2, 
>> event.count=0x14db802a9cf820e0, event.prev_count=0x14db802a9cf820e0
>> [8993461.983135] XXX x86_pmu_start line=1312 [cpu1] 
>> active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0xffff802a9cfc29ed, hw.period_left=0x7fd56303d613, 
>> event.count=0x14db802a9cfc019f, event.prev_count=0x14db802a9cfc019f
>> [8993462.274599] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000001 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0x802a9d24040e, hw.period_left=0x7fd562dbfbf2, 
>> event.count=0x14db802a9d23dbc0, event.prev_count=0x14db802a9d23dbc0
>> [8993462.519488] XXX x86_pmu_start line=1312 [cpu1] 
>> active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0xffff802ab0bb4719, hw.period_left=0x7fd54f44b8e7, 
>> event.count=0x14db802ab0bb1ecb, event.prev_count=0x14db802ab0bb1ecb
>> [8993462.726929] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000003 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=2, 
>> hw.prev_count=0xffff802ab0bb4719, hw.period_left=0x7fd54f44b8e7, 
>> event.count=0x14db802ab0bb1ecb, event.prev_count=0x14db802ab0bb1ecb
>> [8993463.035674] XXX x86_pmu_start line=1312 [cpu1] 
>> active_mask=200000008 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0xffff802ab0bcd328, hw.period_left=0x7fd54f432cd8, 
>> event.count=0x14db802ab0bcaada, event.prev_count=0x14db802ab0bcaada
>>
>>
>> Then, the PMU counter will not be updated：
>>
>> [8993463.333622] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802abea31354
>> [8993463.359905] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802abea31354, hw.period_left=0x7fd5415cecac, 
>> event.count=0x14db802abea2eb06,
>> [8993463.504783] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802ad8760160
>> [8993463.521138] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802ad8760160, hw.period_left=0x7fd52789fea0, 
>> event.count=0x14db802ad875d912,
>> [8993463.638337] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993463.654441] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>> [8993463.837321] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993463.861625] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>> [8993464.012398] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993464.012402] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>> [8993464.013676] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993464.013678] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>> [8993464.016123] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993464.016125] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>> [8993464.016196] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aecb4747b
>> [8993464.016199] x86_perf_event_update [cpu1] active_mask=30000000f 
>> event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
>> hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d,
>>
>> ......
>>
>>
>> Until 6 seconds later, the counter is stopped/started again：
>>
>>
>> [8993470.243959] XXX x86_pmu_stop line=1388 [cpu1] 
>> active_mask=100000001 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d, event.prev_count=0x14db802aecb44c2d
>> [8993470.243998] XXX x86_pmu_start line=1305 [cpu1] 
>> active_mask=200000000 event=ffff880a53411000, state=1, attr.type=0, 
>> attr.config=0x0, attr.pinned=1, hw.idx=3, 
>> hw.prev_count=0xffff802aecb4747b, hw.period_left=0x7fd5134b8b85, 
>> event.count=0x14db802aecb44c2d, event.prev_count=0x14db802aecb44c2d
>>
>> [8993470.245285] x86_perf_event_update, event=ffff880a53411000, 
>> new_raw_count=802aece1e6f6
>>
>> ...
>>
>> Such problems can be solved by avoiding unnecessary x86_pmu_{stop|start}.
>>
>> Please have a look again. Thanks.
>>
> 
> We recently tracked this issue again found that it may be related to the 
> behavior of the third GP of  the Intel(R) Xeon(R) Platinum 8163 CPU:
> 
> 
> [54511836.022997] CPU#1: ctrl:       000000070000000f
> [54511836.022997] CPU#1: status:     0000000000000000
> [54511836.022998] CPU#1: overflow:   0000000000000000
> [54511836.022998] CPU#1: fixed:      00000000000000bb
> [54511836.022998] CPU#1: pebs:       0000000000000000
> [54511836.022999] CPU#1: debugctl:   0000000000000000
> [54511836.022999] CPU#1: active:     000000030000000f
> [54511836.023000] CPU#1:   gen-PMC0 ctrl:  000000000053412e
> [54511836.023000] CPU#1:   gen-PMC0 count: 0000985b7d1a15e7
> [54511836.023000] CPU#1:   gen-PMC0 left:  000067a483643939
> [54511836.023001] CPU#1:   gen-PMC1 ctrl:  00000000005310d1
> [54511836.023002] CPU#1:   gen-PMC1 count: 000080000016448e
> [54511836.023002] CPU#1:   gen-PMC1 left:  00007ffffffffd37
> [54511836.023003] CPU#1:   gen-PMC2 ctrl:  00000000005301d1
> [54511836.023003] CPU#1:   gen-PMC2 count: 00008000e615b9ab
> [54511836.023004] CPU#1:   gen-PMC2 left:  00007fffffffffff
> [54511836.023005] CPU#1:   gen-PMC3 ctrl:  000000000053003c
> [54511836.023005] CPU#1:   gen-PMC3 count: 0000801f6139b1e1
> [54511836.023005] CPU#1:   gen-PMC3 left:  00007fe2a2dc14b7
> [54511836.023006] CPU#1: fixed-PMC0 count: 00008e0fa307b34e
> [54511836.023006] CPU#1: fixed-PMC1 count: 0000ffff3d01adb8
> [54511836.023007] CPU#1: fixed-PMC2 count: 0000cf10d01b651e
> 
> 
> The Gen-pmc3 Ctrl will be changed suddenly:
> 
> [54511836.023085] CPU#1: ctrl:       000000070000000f
> [54511836.023085] CPU#1: status:     0000000000000000
> [54511836.023085] CPU#1: overflow:   0000000000000000
> [54511836.023086] CPU#1: fixed:      00000000000000bb
> [54511836.023086] CPU#1: pebs:       0000000000000000
> [54511836.023086] CPU#1: debugctl:   0000000000000000
> [54511836.023087] CPU#1: active:     000000030000000f
> [54511836.023087] CPU#1:   gen-PMC0 ctrl:  000000000053412e
> [54511836.023088] CPU#1:   gen-PMC0 count: 0000985b7d1a183b
> [54511836.023088] CPU#1:   gen-PMC0 left:  000067a483643939
> [54511836.023089] CPU#1:   gen-PMC1 ctrl:  00000000005310d1
> [54511836.023089] CPU#1:   gen-PMC1 count: 0000800000164ca8
> [54511836.023090] CPU#1:   gen-PMC1 left:  00007ffffffffd37
> [54511836.023091] CPU#1:   gen-PMC2 ctrl:  00000000005301d1
> [54511836.023091] CPU#1:   gen-PMC2 count: 00008000e61634fd
> [54511836.023092] CPU#1:   gen-PMC2 left:  00007fffffffffff
> [54511836.023092] CPU#1:   gen-PMC3 ctrl:  000000010043003c
> [54511836.023093] CPU#1:   gen-PMC3 count: 0000801f613b87d0
> [54511836.023093] CPU#1:   gen-PMC3 left:  00007fe2a2dc14b7
> [54511836.023094] CPU#1: fixed-PMC0 count: 00008e0fa309e091
> [54511836.023095] CPU#1: fixed-PMC1 count: 0000ffff3d050901
> [54511836.023095] CPU#1: fixed-PMC2 count: 0000cf10d01b651e
> 
> 
> The gen-PMC3 ctrl changed,
> 000000000053003c -> 000000010043003c
> 
> After that, the gen-PMC3 count remains 0000801f613b87d0 and will not be 
> updated. A series of subsequent issues, such as abnormal CPI data, are 
> generated.
> 
> However, the special value (000000010043003c) of the gen-pmc3 Ctrl is 
> not actively set by the application. It is suspected that some special 
> operation has caused the GP3 Ctrl to be changed, and it is still under 
> discussion with Intel’s FAE.
> > At present, only the above phenomenon has been observed, but the exact
> cause has not yet been found.


We finally found that TFA (TSX Force Abort) may affect PMC3's behavior, 
refer to the following patch:

400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")

When the MSR gets set; the microcode will no longer use PMC3 but will
Force Abort every TSX transaction (upon executing COMMIT).

When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
unused.

When TFA is not allowed; clear PMC3 from all constraints such that it
will not get used.


> 
> However, this patch attempts to avoid the switching of the pmu counters 
> in various perf_events, so the special behavior of a single pmu counter 
> will not be propagated to other events.
> 

Since PMC3 may have special behaviors, the continuous switching of PMU 
counters may not only affects the performance, but also may lead to 
abnormal data, please consider this patch again.

Thanks.

> -- 
> Best wishes,
> Wen
> 
