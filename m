Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9C49FFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbiA1SBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:01:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4554 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbiA1SBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:01:37 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jlld10xyxz67WZ5;
        Sat, 29 Jan 2022 02:01:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 19:01:35 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 18:01:34 +0000
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "Andi Kleen" <ak@linux.intel.com>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
 <6ba550d1-61bc-e229-2a64-331cfa59c388@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2bd5593e-615f-2ad1-ce03-cb452c7cd370@huawei.com>
Date:   Fri, 28 Jan 2022 18:00:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <6ba550d1-61bc-e229-2a64-331cfa59c388@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 16:58, Andrew Kilroy wrote:
>>
> 

Sorry for very slow response..

> The --topdown kernel event colouring is dictated by a large if-else 
> statement in stat-shadow.c:perf_stat__print_shadow_stats.
> 
> There are branches depending on what is returned by 
> perf_stat_evsel__is() for example
> 
>      } else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
>          double fe_bound = td_fe_bound(cpu, st, &rsd);
> 
>          if (fe_bound > 0.2)
>              color = PERF_COLOR_RED;
>          print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
>                  fe_bound * 100.);
>      } else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
> 
> 
> 
> Because the patches are enabling metrics (equivalent of the -M 
> 'somemetricname' option), the perf_stat__print_shadow_stats function 
> always makes calls to generic_metric(), where colours are never picked.
> 
> Seeing thresholds like:
> 
>    retiring > 0.7
>    fe_bound > 0.2
>    be_bound > 0.2
>    bad_spec > 0.1
> 
> 
> I'm not sure about adding the colouring really.  Are these thresholds 
> x86 specific?

There is info on topdown for vtune here:

https://www.intel.com/content/www/us/en/develop/documentation/vtune-cookbook/top/methodologies/top-down-microarchitecture-analysis-method.html

The threshold info described there seems somewhat consistent with perf 
tool topdown thresholds and that is based on general guidelines for 
certain compute categories.

Andi did mention "specification" here:
https://lore.kernel.org/lkml/CABPqkBRftsHEAEwgCn3i3=mfk9fjh5r4MycdjHKRka5voTj9JA@mail.gmail.com/

But I don't know it, apart from a paper:
file:///home/john/Downloads/TopDown-Yasin-ISPASS14.pdf

Thanks,
John
