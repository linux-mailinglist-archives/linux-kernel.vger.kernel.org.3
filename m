Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7B5282DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiEPLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiEPLKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:10:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E412F004;
        Mon, 16 May 2022 04:10:29 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L1xK23xzzz6GCX1;
        Mon, 16 May 2022 19:06:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 13:10:26 +0200
Received: from [10.47.25.151] (10.47.25.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 12:10:25 +0100
Message-ID: <f1f932f1-1b0b-120d-f082-f9df32b7b9c4@huawei.com>
Date:   Mon, 16 May 2022 12:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Ian Rogers <irogers@google.com>
CC:     Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Qi Liu <liuqi115@huawei.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org>
 <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
 <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
 <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.151]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 23:03, Ian Rogers wrote:
> I'll raise John's "ok" and say this looks great!:-D  Some thoughts:
> 
> The mapfile.csv cpuid values don't directly align with:
> https://github.com/ARM-software/data/blob/master/cpus.json
> but this definitely looks deliberate.
> 

Hi Ian,

> The new events lack the PMU "Unit" value.

For arm support we work on the basis that no "Unit" means CPU PMU. I 
assume the same for other archs, but maybe this hybrid PMU support 
changes that.

> The current perf json is
> pretty free form and leads to problems if two PMUs are present.

Can you clarify - for my benefit - exactly what you mean by "two PMUs 
are present"?

> Context is here:
> https://lore.kernel.org/lkml/CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com/
> 

We have another problem but I am not sure if exactly the same.

The issue is that if we have an event alias "cycles" for an uncore PMU, 
then if we use "stat" command then perf tool matches "cycles" to CPU 
cycles and not the uncore PMU, which we would not want.

We have ways to work around it, though.

> My idea to rationalize this is to mirror what is already done in
> sysfs, that is the event data is specific to a PMU. As a lot of "Unit"
> values are missing from events on x86 a reasonable guess if the "Unit"
> is missing is to use "cpu". 

This sounds like what I mentioned in the reply to 1/20:

"I had a patch series which makes perf read the armv8 pmu
sysfs event file to learn all the events which the core supports and
create the aliases from that. So, in this, we don't require the JSONs to
list these events explicitly. "

Is this like what Andi was talking about in terms of runtime loading?

> Poking a Google Pixel 4a, I see that all
> PMU data is in "armv8_pmuv3". So for ARM I could guess this is always
> the case, ie all events should belong to armv8_pmuv3. This may not be
> right and could lead to confusion like an event BR_COND_MIS_PRED
> having an alias of "armv8_pmuv3/BR_COND_MIS_PRED/" but it really
> should have some other PMU name in there. I just raise this in case
> there is a fix for this we could incorporate into this patch series,
> maybe "armv8_pmuv3" is always the PMU and my life is easy.

Thanks,
John
