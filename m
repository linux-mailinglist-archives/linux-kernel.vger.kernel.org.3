Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283C44DCCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiCQR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCQR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:56:19 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F017ECFC;
        Thu, 17 Mar 2022 10:55:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V7Sm1Zs_1647539695;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V7Sm1Zs_1647539695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 01:54:57 +0800
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
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
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <05861b8c-2c7c-ae89-613a-41fcace6a174@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 01:54:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/3/14 ÏÂÎç6:55, Peter Zijlstra Ð´µÀ:
> On Thu, Mar 10, 2022 at 11:50:33AM +0800, Wen Yang wrote:
> 
>> As you pointed out, some non-compliant rdpmc can cause problems. But you
>> also know that linux is the foundation of cloud servers, and many
>> third-party programs run on it (we don't have any code for it), and we can
>> only observe that the monitoring data will jitter abnormally (the
>> probability of this issue is not high, about dozens of tens of thousands of
>> machines).
> 
> This might be a novel insight, but I *really* don't give a crap about
> any of that. If they're not using it right, they get to keep the pieces.
> 
> I'd almost make it reschedule more to force them to fix their stuff.
> 


Thank you for your guidance.

We also found a case in thousands of servers where the PMU counter is no 
longer updated due to frequent x86_pmu_stop/x86_pmu_start.

We added logs in the kernel and found that a third-party program would 
cause the PMU counter to start/stop several times in just a few seconds, 
as follows:


[8993460.537776] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000001 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=3, hw.prev_count=0x802a877ef302, 
hw.period_left=0x7fd578810cfe, event.count=0x14db802a877ecab4, 
event.prev_count=0x14db802a877ecab4
[8993460.915873] XXX x86_pmu_start line=1312 [cpu1] 
active_mask=200000008 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=3, 
hw.prev_count=0xffff802a9cf6a166, hw.period_left=0x7fd563095e9a, 
event.count=0x14db802a9cf67918, event.prev_count=0x14db802a9cf67918
[8993461.104643] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000001 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=3, hw.prev_count=0xffff802a9cf6a166, 
hw.period_left=0x7fd563095e9a, event.count=0x14db802a9cf67918, 
event.prev_count=0x14db802a9cf67918
[8993461.442508] XXX x86_pmu_start line=1312 [cpu1] 
active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=2, 
hw.prev_count=0xffff802a9cf8492e, hw.period_left=0x7fd56307b6d2, 
event.count=0x14db802a9cf820e0, event.prev_count=0x14db802a9cf820e0
[8993461.736927] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000001 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=2, hw.prev_count=0xffff802a9cf8492e, 
hw.period_left=0x7fd56307b6d2, event.count=0x14db802a9cf820e0, 
event.prev_count=0x14db802a9cf820e0
[8993461.983135] XXX x86_pmu_start line=1312 [cpu1] 
active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=2, 
hw.prev_count=0xffff802a9cfc29ed, hw.period_left=0x7fd56303d613, 
event.count=0x14db802a9cfc019f, event.prev_count=0x14db802a9cfc019f
[8993462.274599] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000001 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=2, hw.prev_count=0x802a9d24040e, 
hw.period_left=0x7fd562dbfbf2, event.count=0x14db802a9d23dbc0, 
event.prev_count=0x14db802a9d23dbc0
[8993462.519488] XXX x86_pmu_start line=1312 [cpu1] 
active_mask=200000004 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=2, 
hw.prev_count=0xffff802ab0bb4719, hw.period_left=0x7fd54f44b8e7, 
event.count=0x14db802ab0bb1ecb, event.prev_count=0x14db802ab0bb1ecb
[8993462.726929] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000003 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=2, hw.prev_count=0xffff802ab0bb4719, 
hw.period_left=0x7fd54f44b8e7, event.count=0x14db802ab0bb1ecb, 
event.prev_count=0x14db802ab0bb1ecb
[8993463.035674] XXX x86_pmu_start line=1312 [cpu1] 
active_mask=200000008 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=3, 
hw.prev_count=0xffff802ab0bcd328, hw.period_left=0x7fd54f432cd8, 
event.count=0x14db802ab0bcaada, event.prev_count=0x14db802ab0bcaada


Then, the PMU counter will not be updated£º

[8993463.333622] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802abea31354
[8993463.359905] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802abea31354, hw.period_left=0x7fd5415cecac, 
event.count=0x14db802abea2eb06,
[8993463.504783] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802ad8760160
[8993463.521138] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802ad8760160, hw.period_left=0x7fd52789fea0, 
event.count=0x14db802ad875d912,
[8993463.638337] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993463.654441] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,
[8993463.837321] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993463.861625] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,
[8993464.012398] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993464.012402] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,
[8993464.013676] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993464.013678] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,
[8993464.016123] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993464.016125] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,
[8993464.016196] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aecb4747b
[8993464.016199] x86_perf_event_update [cpu1] active_mask=30000000f 
event=ffff880a53411000, state=1, attr.config=0x0, attr.pinned=1, 
hw.idx=3, hw.prev_count=0x802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d,

......


Until 6 seconds later, the counter is stopped/started again£º


[8993470.243959] XXX x86_pmu_stop line=1388 [cpu1] active_mask=100000001 
event=ffff880a53411000, state=1, attr.type=0, attr.config=0x0, 
attr.pinned=1, hw.idx=3, hw.prev_count=0x802aecb4747b, 
hw.period_left=0x7fd5134b8b85, event.count=0x14db802aecb44c2d, 
event.prev_count=0x14db802aecb44c2d
[8993470.243998] XXX x86_pmu_start line=1305 [cpu1] 
active_mask=200000000 event=ffff880a53411000, state=1, attr.type=0, 
attr.config=0x0, attr.pinned=1, hw.idx=3, 
hw.prev_count=0xffff802aecb4747b, hw.period_left=0x7fd5134b8b85, 
event.count=0x14db802aecb44c2d, event.prev_count=0x14db802aecb44c2d

[8993470.245285] x86_perf_event_update, event=ffff880a53411000, 
new_raw_count=802aece1e6f6

...

Such problems can be solved by avoiding unnecessary x86_pmu_{stop|start}.

Please have a look again. Thanks.

--
Best wishes,
Wen


