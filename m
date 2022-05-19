Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102052D52D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiESNyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiESNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:51:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 430CB1E3E2;
        Thu, 19 May 2022 06:50:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AD931650;
        Thu, 19 May 2022 06:50:07 -0700 (PDT)
Received: from [10.57.3.56] (unknown [10.57.3.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E373F66F;
        Thu, 19 May 2022 06:50:04 -0700 (PDT)
Message-ID: <b4a16e3e-efbe-c06b-1bc3-c02e151a19a6@arm.com>
Date:   Thu, 19 May 2022 14:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
 <7a17256d-cad0-bd94-02e7-f8adaa959654@arm.com>
 <2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <2d73146a-86fc-e0d1-11b9-432c7431d58a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/2022 08:59, John Garry wrote:
> On 18/05/2022 15:14, Robin Murphy wrote:
>>> Sure, we should have these 32b cores supported for ARCH=arm if they 
>>> are supported for ARCH=arm64. But then does it even make sense to 
>>> have A7 support in arch/arm64?
>>
>> That's what I'm getting at. If it is tied to the build target as 
>> you've said above, then there is no point in an AArch64 perf tool 
>> including data for CPUs on which that tool cannot possibly run; it's 
>> simply a waste of space.
>>
>> If there is interest in plumbing in support on AArch32 builds as 
>> well, then I'd still be inclined to have a single arch/arm events 
>> directory, and either do some build-time path munging or just symlink 
>> an arch/arm64 sibling back to it. Yes, technically there are 
>> AArch64-only CPUs whose data would then be redundant when building 
>> for AArch32, 
>
> If size is an issue then we have ways to cut this down, like doing the 
> arch standard events fixup dynamically when running perf tool, or even 
> not describing those events in the JSONs and rely on reading the CPU 
> PMU events folder to learn which of those events are supported.
>
> > but those are
> > such a minority that it seems like an entirely reasonable compromise.
>
> @Nick, Can you drop the 32b core support for arm64? Or, if you really 
> want them, look into ARCH=arm pmu-events support?

No problem - I'll resubmit without the 32b-only CPUs.

Thanks,
Nick

