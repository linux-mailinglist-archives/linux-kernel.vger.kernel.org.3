Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF2470173
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbhLJNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:25:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4244 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbhLJNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:25:44 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9Wfl2PhCz684R2;
        Fri, 10 Dec 2021 21:17:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:22:07 +0100
Received: from [10.47.85.63] (10.47.85.63) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 13:22:06 +0000
Subject: Re: [PATCH v2 1/2] perf vendor events: For the Arm Neoverse N2
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <20211210123706.7490-1-andrew.kilroy@arm.com>
 <20211210123706.7490-2-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
Date:   Fri, 10 Dec 2021 13:21:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211210123706.7490-2-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.63]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 12:37, Andrew Kilroy wrote:
> Updates the common and microarch json file to add counters available in
> the Arm Neoverse N2 chip, but should also apply to other ArmV8 and ArmV9
> cpus.  Specified in ArmV8 architecture reference manual
> 
>    https://developer.arm.com/documentation/ddi0487/gb/?lang=en
> 
> Some of the counters added to armv8-common-and-microarch.json are
> specified in the ArmV9 architecture reference manual supplement
> (issue A.a):
> 
>    https://developer.arm.com/documentation/ddi0608/aa
> 
> The additional ArmV9 counters are
> 
>    TRB_WRAP
>    TRCEXTOUT0
>    TRCEXTOUT1
>    TRCEXTOUT2
>    TRCEXTOUT3
>    CTI_TRIGOUT4
>    CTI_TRIGOUT5
>    CTI_TRIGOUT6
>    CTI_TRIGOUT7
> 
> This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
> perf list to output the counter names in categories.
> 
> Counters on the Neoverse N2 are stated in its reference manual:
> 
>    https://developer.arm.com/documentation/102099/0000
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> ---
>   .../arch/arm64/arm/neoverse-n2/branch.json    |   8 +
>   .../arch/arm64/arm/neoverse-n2/bus.json       |  20 ++
>   .../arch/arm64/arm/neoverse-n2/cache.json     | 155 ++++++++++++++
>   .../arch/arm64/arm/neoverse-n2/exception.json |  47 +++++
>   .../arm64/arm/neoverse-n2/instruction.json    | 143 +++++++++++++
>   .../arch/arm64/arm/neoverse-n2/memory.json    |  38 ++++
>   .../arch/arm64/arm/neoverse-n2/other.json     |   5 +
>   .../arch/arm64/arm/neoverse-n2/pipeline.json  |  23 ++
>   .../arch/arm64/arm/neoverse-n2/spe.json       |  14 ++
>   .../arch/arm64/arm/neoverse-n2/trace.json     |  29 +++
>   .../arm64/armv8-common-and-microarch.json     | 198 ++++++++++++++++++
>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>   12 files changed, 681 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json

This looks ok,

Reviewed-by: John Garry <john.garry@huawei.com>

BTW, I was looking at adding perf tool --topdown support for arm64. This 
will require L1 metricgroup support per core - see what I did here for 
our hisilicon platform already:

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json

I would like to add support for more cores. Generally the arm common 
events match up to the definitions here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-stat.txt#n400

Apart from frontend_bound - would you have an equivalent metric 
expression for this for these Neoverse cores?

[0] Note that I think that the divisor in the metric expressions is max 
uops that the core can deal with.

Thanks,
John

