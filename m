Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7E52BC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiEROOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiEROOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:14:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D053C1C9AF6;
        Wed, 18 May 2022 07:14:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC5B23A;
        Wed, 18 May 2022 07:14:35 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9843F73D;
        Wed, 18 May 2022 07:14:32 -0700 (PDT)
Message-ID: <7a17256d-cad0-bd94-02e7-f8adaa959654@arm.com>
Date:   Wed, 18 May 2022 15:14:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
 <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
 <5773b630-8159-1eba-481a-1bf3c406c055@arm.com>
 <cf7d8003-9700-880f-0e46-ff40e6348bb1@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cf7d8003-9700-880f-0e46-ff40e6348bb1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-18 14:48, John Garry wrote:
> On 18/05/2022 13:32, Robin Murphy wrote:
>>> If we were to add to arm32/arm then the common event numbers and 
>>> maybe other JSONs in future would need to be duplicated.
>>>
>>> Would there be any reason to add to arm32/arm apart to from being 
>>> strictly proper? Maybe if lots of other 32b support for other vendors 
>>> came along then it could make sense (to separate them out).
>>
>> That's the heart of the question, really. At best it seems 
>> unnecessarily confusing as-is. 
> 
> I think it comes down to the first core supported was TX2 and the build 
> system relies on the target arch to decide which arch from 
> pmu-events/arch to compile.
> 
>> AFAICS either the naming isn't functional, wherein it would 
>> potentially make the most sense to rename the whole thing 
>> "pmu-events/arch/arm" if it's merely for categorising Arm 
>> architectures in general, or it is actually tied to the host triplet, 
>> in which case the above patches are most likely useless.
> 
> Today ARCH=arm has no pmu-events support. I think that it should be easy 
> to add plumbing for that. It becomes more tricky with supporting a 
> single "arm" folder.
> 
> But then do people really care enough about pmu-events for these 32b 
> cores? Until now, it seems not.
> 
>>
>> I'd agree that there doesn't seem much point in trying to separate 
>> things along relatively arbitrary lines if it *isn't* functionally 
>> necessary - the PMUv2 common events look to be a straightforward 
>> subset of the PMUv3 ones, but then there's Cortex-A32 anyway, plus 
>> most of the already-supported CPUs could equally run an AArch32 perf 
>> tool as well.
> 
> Sure, we should have these 32b cores supported for ARCH=arm if they are 
> supported for ARCH=arm64. But then does it even make sense to have A7 
> support in arch/arm64?

That's what I'm getting at. If it is tied to the build target as you've 
said above, then there is no point in an AArch64 perf tool including 
data for CPUs on which that tool cannot possibly run; it's simply a 
waste of space.

If there is interest in plumbing in support on AArch32 builds as well, 
then I'd still be inclined to have a single arch/arm events directory, 
and either do some build-time path munging or just symlink an arch/arm64 
sibling back to it. Yes, technically there are AArch64-only CPUs whose 
data would then be redundant when building for AArch32, but those are 
such a minority that it seems like an entirely reasonable compromise.

Thanks,
Robin.
