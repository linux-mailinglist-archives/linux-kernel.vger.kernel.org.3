Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458FE52CDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiESH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiESH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:59:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67C3983C;
        Thu, 19 May 2022 00:59:52 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3j1l050rz6F9F7;
        Thu, 19 May 2022 15:59:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:59:50 +0200
Received: from [10.47.92.25] (10.47.92.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 08:59:49 +0100
Message-ID: <2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com>
Date:   Thu, 19 May 2022 08:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Robin Murphy <robin.murphy@arm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
 <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
 <5773b630-8159-1eba-481a-1bf3c406c055@arm.com>
 <cf7d8003-9700-880f-0e46-ff40e6348bb1@huawei.com>
 <7a17256d-cad0-bd94-02e7-f8adaa959654@arm.com>
In-Reply-To: <7a17256d-cad0-bd94-02e7-f8adaa959654@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.25]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 15:14, Robin Murphy wrote:
>> Sure, we should have these 32b cores supported for ARCH=arm if they 
>> are supported for ARCH=arm64. But then does it even make sense to have 
>> A7 support in arch/arm64?
> 
> That's what I'm getting at. If it is tied to the build target as you've 
> said above, then there is no point in an AArch64 perf tool including 
> data for CPUs on which that tool cannot possibly run; it's simply a 
> waste of space.
> 
> If there is interest in plumbing in support on AArch32 builds as well, 
> then I'd still be inclined to have a single arch/arm events directory, 
> and either do some build-time path munging or just symlink an arch/arm64 
> sibling back to it. Yes, technically there are AArch64-only CPUs whose 
> data would then be redundant when building for AArch32, 

If size is an issue then we have ways to cut this down, like doing the 
arch standard events fixup dynamically when running perf tool, or even 
not describing those events in the JSONs and rely on reading the CPU PMU 
events folder to learn which of those events are supported.

 > but those are
 > such a minority that it seems like an entirely reasonable compromise.

@Nick, Can you drop the 32b core support for arm64? Or, if you really 
want them, look into ARCH=arm pmu-events support?

thanks,
John
