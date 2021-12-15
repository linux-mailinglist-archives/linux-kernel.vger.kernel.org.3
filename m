Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89114756F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbhLOKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:52:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4283 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbhLOKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:52:50 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDX8b49Lxz683Ds;
        Wed, 15 Dec 2021 18:50:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:52:47 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 10:52:47 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Ian Rogers <irogers@google.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
Message-ID: <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
Date:   Wed, 15 Dec 2021 10:52:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.135]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

>>   const struct pmu_event *metricgroup__find_metric(const char *metric,
>>                                                   const struct pmu_events_map *map);
>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
>> index 1081b20f9891..57c0c5f2c6bd 100644
>> --- a/tools/perf/util/topdown.c
>> +++ b/tools/perf/util/topdown.c
>> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
>>   {
>>          return false;
>>   }
>> +
>> +__weak bool arch_topdown_use_json_metrics(void)
>> +{

AFAICS, only x86 supports topdown today and that is because they have 
special kernel topdown events exposed for the kernel CPU PMU driver. So 
other architectures - not only arm - would need rely on metricgroups for 
topdown support. So let's make this generic for all archs.

> I like this extension! I've ranted in the past about weak symbols
> breaking with archives due to lazy loading [1]. In this case
> tools/perf/arch/arm64/util/topdown.c has no other symbols within it
> and so the weak symbol has an extra chance of being linked
> incorrectly. We could add a new command line of --topdown-json to
> avoid this, but there seems little difference in doing this over just
> doing '-M TopDownL1'.


> Is it possible to use the json metric approach
> for when the CPU version fails?

I think that's a good idea.

In addition we could also add a --topdown arg to force using JSON 
metricgroups.

Did you actually test this patch? I have something experimental working 
from some time ago, and it was more complicated than this. I need to 
check the code again...

Thanks,
John
