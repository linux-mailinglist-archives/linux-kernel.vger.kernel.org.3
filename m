Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4E58FE80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiHKOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:47:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF56F56C;
        Thu, 11 Aug 2022 07:47:35 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3V5X2zx7z67tXN;
        Thu, 11 Aug 2022 22:47:28 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 16:47:33 +0200
Received: from [10.48.150.65] (10.48.150.65) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 11 Aug
 2022 15:47:31 +0100
Message-ID: <0dff14dc-0287-71cf-72e8-0c8419c6fb3a@huawei.com>
Date:   Thu, 11 Aug 2022 15:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 10/17] perf pmu-events: Hide pmu_events_map
To:     Ian Rogers <irogers@google.com>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Zhengjun Xing" <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-11-irogers@google.com>
 <463cffea-51d9-98ad-86ac-d064faac05b9@huawei.com>
 <CAP-5=fXuG9Jt5x-e3um=-hYNSb18j8dL5np5Edozw+H5PoZ2eA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fXuG9Jt5x-e3um=-hYNSb18j8dL5np5Edozw+H5PoZ2eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.150.65]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 15:29, Ian Rogers wrote:
>>>          _args.output_file.write("""{
>>> @@ -389,6 +409,61 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
>>>    \t},
>>>    };
>>>
>>> +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
>>> +{
>>> +        const struct pmu_event *table = NULL;
>>> +        char *cpuid = perf_pmu__getcpuid(pmu);
>> This seems an identical implementation to that in empty-pmu-events.c -
>> can we reduce this duplication? Maybe a seperate common c file which can
>> be linked in
>>
>> The indentation seems different also - this version seems to use whitespaces
> Agreed. Later on this will change, the empty version isn't compressed
> and the jevents.py one is. Having a common C file would defeat the
> goal of hiding the API, but ultimately we'd need to get rid of it in
> later changes when the empty/compressed implementations diverge.

ok, I suppose.. I have to say that this divergence is less then ideal 
and I don't so like much all the difference in pmu-events/pmu-events.c 
and pmu-events/empty-pmu-events.c

thanks,
John
