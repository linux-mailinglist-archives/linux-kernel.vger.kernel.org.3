Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63CA4758FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbhLOMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:39:07 -0500
Received: from foss.arm.com ([217.140.110.172]:50848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234378AbhLOMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:39:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854CAD6E;
        Wed, 15 Dec 2021 04:39:05 -0800 (PST)
Received: from [10.57.33.203] (unknown [10.57.33.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E90B53F774;
        Wed, 15 Dec 2021 04:39:02 -0800 (PST)
Message-ID: <d91a1b98-2c2b-a961-543f-d540b3c7a146@arm.com>
Date:   Wed, 15 Dec 2021 12:38:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
 <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ian, John, thanks for the feedback.

On 15/12/2021 10:52, John Garry wrote:
> Hi Andrew,
> 
>>>   const struct pmu_event *metricgroup__find_metric(const char *metric,
>>>                                                   const struct 
>>> pmu_events_map *map);
>>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>>> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
>>> index 1081b20f9891..57c0c5f2c6bd 100644
>>> --- a/tools/perf/util/topdown.c
>>> +++ b/tools/perf/util/topdown.c
>>> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel 
>>> *leader __maybe_unused)
>>>   {
>>>          return false;
>>>   }
>>> +
>>> +__weak bool arch_topdown_use_json_metrics(void)
>>> +{
> 
> AFAICS, only x86 supports topdown today and that is because they have 
> special kernel topdown events exposed for the kernel CPU PMU driver. So 
> other architectures - not only arm - would need rely on metricgroups for 
> topdown support. So let's make this generic for all archs.
> 
>> I like this extension! I've ranted in the past about weak symbols
>> breaking with archives due to lazy loading [1]. In this case
>> tools/perf/arch/arm64/util/topdown.c has no other symbols within it
>> and so the weak symbol has an extra chance of being linked
>> incorrectly. We could add a new command line of --topdown-json to
>> avoid this, but there seems little difference in doing this over just
>> doing '-M TopDownL1'.
> 
> 
>> Is it possible to use the json metric approach
>> for when the CPU version fails?
> 
> I think that's a good idea.
> 

Taking a look.

> In addition we could also add a --topdown arg to force using JSON 
> metricgroups.
> 

What arg do think would be supplied?

> Did you actually test this patch? I have something experimental working 
> from some time ago, and it was more complicated than this. I need to 
> check the code again...
> 

I got stats back from this implementation, yes.  Let me know if there's 
things my patch isn't catering for.

> Thanks,
> John
