Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5283472346
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhLMI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:56:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4250 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLMI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:56:40 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JCFgc3hB3z67Zt3;
        Mon, 13 Dec 2021 16:54:36 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 09:56:38 +0100
Received: from [10.47.80.231] (10.47.80.231) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 13 Dec
 2021 08:56:36 +0000
Subject: Re: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Vineet Singh" <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <eranian@google.com>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-2-irogers@google.com>
 <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com>
 <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
 <YbOlnH0NLQdAECcK@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <02b330aa-ebce-11b2-9d3f-9b2497ae7133@huawei.com>
Date:   Mon, 13 Dec 2021 08:56:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YbOlnH0NLQdAECcK@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.231]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 19:08, Arnaldo Carvalho de Melo wrote:
>>>> +/**
>>>> + * A sized, reference counted, sorted array of integers representing CPU
>>>> + * numbers. This is commonly used to capture which CPUs a PMU is associated
>>>> + * with.
>>>> + */
>>>>    struct perf_cpu_map {
>>>>        refcount_t      refcnt;
>>>> +     /** Length of the map array. */
>>>>        int             nr;

I'd have /s/nr/len/, as it means the map length, as opposed to confusing 
nr meaning with number of cpus in the host or something else. And the 
new comment uses "Length" also.

>>>> +     /** The CPU values. */
>>>>        int             map[];
>>> would simply more distinct names for the variables help instead of or in
>>> addition to comments?
> Well, in this case the typical usage doesn't help, as 'struct
> perf_cpu_map' are being used simply as "map"

There are a lot of instances to change ... but I am all up for using 
consistent and well-meaning variable / argument names per type.

> where it should be cpu_map,
> so we would have:
> 
> 	cpu_map->nr
> 
> And all should be obvious, no? Otherwise we would have redundant 'cpu',
> like:
> 
> 	cpu_map->nr_cpus
> 
> And 'map' should really be entries, so:
> 
> 	cpu_map->entries[index];
> 
> Would be clear enough, o?
>   
>> Thanks John! I agree. The phrase that is often used is intention
>> revealing names. The kernel style for naming is to be brief:

