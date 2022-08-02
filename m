Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8FD58799B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiHBJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiHBJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:08:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246901E3F3;
        Tue,  2 Aug 2022 02:08:51 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LxpyB6WQYz682wj;
        Tue,  2 Aug 2022 17:06:26 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 11:08:48 +0200
Received: from [10.195.33.92] (10.195.33.92) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 10:08:47 +0100
Message-ID: <3d0c1ec0-42ec-8c51-743b-5d93cabb53fb@huawei.com>
Date:   Tue, 2 Aug 2022 10:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/17] Compress the pmu_event tables
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
References: <20220729074351.138260-1-irogers@google.com>
 <d8356ddc-56e7-7324-5330-ff2bd54bcba4@huawei.com>
 <CAP-5=fV0CMpBGkNOBMRjbdZfdw1mQjrDhLVG38jLtpsdWXtQ_Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fV0CMpBGkNOBMRjbdZfdw1mQjrDhLVG38jLtpsdWXtQ_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.92]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 18:27, Ian Rogers wrote:
>> This implementation would require core pmu.c to be changed, but there is
>> ways that this could be done without needing to change core pmu.c
>>
>> Thanks,
>> John
> Thanks John!
> 
> You are right about broadwell, it is an extreme case of sharing. IIRC
> BDX is the server core/uncore events, BDW is the consumer core/uncore
> and BDW-DE is consumer core with server uncore - so the sharing is
> inherent in this. Metrics become interesting as they may mix core and
> uncore, but I'll ignore that here.
> 
> In the old code every event needs 15 char*s, with 64-bit that is 15*8
> bytes per entry with 741 core and 23 uncore entries for BDW, and 372
> core and 1284 uncore for BDX. I expect the strings themselves will be
> shared by the C compiler, and so I just focus on the pointer sizes.
> With the new code every event is just 1 32-bit int. So for BDW we go
> from 15*8*(741+23)=91,680 to 4*(741+23)=3056, BDX is
> 15*8*(372+1284)=198720 to 4*(372+1284)=6624. This means we've gone
> from 290,400bytes to 9,680bytes for BDW and BDX. BDW-DE goes from
> 243,000bytes to 8,100bytes -


> we can ignore the costs of the strings as
> they should be fully shared, especially for BDW-DE.

Are you sure about this? I did not think that the compiler would have 
the intelligence to try to share strings. That is the basis of the size 
optimisation which I was proposing (that the compiler would not share 
strings).

> 
> If we added some kind of table sharing, so BDW-DE was core from BDW
> and uncore from BDX and the tables shared, then in the old code you
> could save nearly 0.25MB but with the new code the saving is only
> around 8KB. I think we can go after that 8KB but it is less urgent
> after this change which gets 96% of the benefit. We have 72
> architectures for jevents at the moment and so I'd ball park (assuming
> they all saved as much as BDW-DE) the max saving as about 0.5MB, which
> is 12% of what is saved here.
> 
> Longer term I'd like to make the pmu-events.c logic look closer to the
> sysfs API. Perhaps we can unify the uncore events for BDX and BDW-DE
> with some notion of a common PMU, or PMUs with common events and
> tables, and automate deduction of this. It also isn't clear to me the
> advantage of storing the metrics inside the events, separate tables
> feel cleaner. Anyway, there's lots of follow up.

Thanks,
John

