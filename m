Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7044489F68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbiAJSna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:43:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4382 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiAJSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:43:28 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JXjL339Pyz6H7Tm;
        Tue, 11 Jan 2022 02:39:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 19:43:25 +0100
Received: from [10.47.24.251] (10.47.24.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 18:43:24 +0000
Subject: Re: [PATCH v4 03/48] perf stat: Correct aggregation CPU map
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>, <zhengjun.xing@intel.com>
CC:     <eranian@google.com>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-4-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1ae917ec-4d32-4ee7-0948-f91eb3bf35fb@huawei.com>
Date:   Mon, 10 Jan 2022 18:43:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220105061351.120843-4-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.251]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 06:13, Ian Rogers wrote:
> Switch the perf_cpu_map in aggr_update_shadow from
> the evlist to the counter's cpu map, so the index is appropriate. This
> addresses a problem where uncore counts, with a cpumap like:
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,18
> Don't aggregate counts in CPUs based on the index of those values in the
> cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
> metric calculations in per-socket mode for counters without a full
> cpumask.
> 
> On a SkylakeX with a tweaked DRAM_BW_Use metric, to remove unnecessary
> scaling, this gives:
> 
> Before:
> $ /perf stat --per-socket -M DRAM_BW_Use -I 1000
>       1.001102293 S0        1              27.01 MiB  uncore_imc/cas_count_write/ #   103.00 DRAM_BW_Use
>       1.001102293 S0        1              30.22 MiB  uncore_imc/cas_count_read/
>       1.001102293 S0        1      1,001,102,293 ns   duration_time
>       1.001102293 S1        1              20.10 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
>       1.001102293 S1        1              32.74 MiB  uncore_imc/cas_count_read/
>       1.001102293 S1        0      <not counted> ns   duration_time
>       2.003517973 S0        1              83.04 MiB  uncore_imc/cas_count_write/ #   920.00 DRAM_BW_Use
>       2.003517973 S0        1             145.95 MiB  uncore_imc/cas_count_read/
>       2.003517973 S0        1      1,002,415,680 ns   duration_time
>       2.003517973 S1        1             302.45 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
>       2.003517973 S1        1             290.99 MiB  uncore_imc/cas_count_read/
>       2.003517973 S1        0      <not counted> ns   duration_time
> 
> After:
> $ perf stat --per-socket -M DRAM_BW_Use -I 1000
>       1.001080840 S0        1              24.96 MiB  uncore_imc/cas_count_write/ #    54.00 DRAM_BW_Use
>       1.001080840 S0        1              33.64 MiB  uncore_imc/cas_count_read/
>       1.001080840 S0        1      1,001,080,840 ns   duration_time
>       1.001080840 S1        1              42.43 MiB  uncore_imc/cas_count_write/ #    84.00 DRAM_BW_Use
>       1.001080840 S1        1              47.05 MiB  uncore_imc/cas_count_read/
>       1.001080840 S1        0      <not counted> ns   duration_time
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

Tested-by: John Garry <john.garry@huawei.com>
