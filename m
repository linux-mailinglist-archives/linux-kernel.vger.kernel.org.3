Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC857270C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiGLUNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGLUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:13:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D652DE;
        Tue, 12 Jul 2022 13:13:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08874165C;
        Tue, 12 Jul 2022 13:13:32 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218E23F70D;
        Tue, 12 Jul 2022 13:13:29 -0700 (PDT)
Message-ID: <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
Date:   Tue, 12 Jul 2022 21:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Content-Language: en-GB
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
 <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com>
 <SJ0PR12MB567600F730B47F3A1007775AA0829@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20220712163638.GA2945984@p14s>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220712163638.GA2945984@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 17:36, Mathieu Poirier wrote:
[...]
>>> If we have decied to call this arm_system_pmu, (which I am perfectly
>>> happy with), could we please stick to that name for functions that we
>>> export ?
>>>
>>> e.g,
>>> s/coresight_pmu_sysfs_event_show/arm_system_pmu_event_show()/
>>>
>>
>> Just want to confirm, is it just the public functions or do we need to replace
>> all that has "coresight" naming ? Including the static functions, structs, filename.
> 
> I think all references to "coresight" should be changed to "arm_system_pmu",
> including filenames.  That way there is no doubt this IP block is not
> related, and does not interoperate, with the any of the "coresight" IP blocks
> already supported[1] in the kernel.
> 
> I have looked at the documentation[2] in the cover letter and I agree
> with an earlier comment from Sudeep that this IP has very little to do with any
> of the other CoreSight IP blocks found in the CoreSight framework[1].  Using the
> "coresight" naming convention in this driver would be _extremely_ confusing,
> especially when it comes to exported functions.

But conversely, how is it not confusing to make up completely different 
names for things than what they're actually called? The CoreSight 
Performance Monitoring Unit is a part of the Arm CoreSight architecture, 
it says it right there on page 1. What if I instinctively associate the 
name Mathieu with someone more familiar to me, so to avoid confusion I'd 
prefer to call you Steve? Is that OK?

As it happens, Steve, I do actually agree with you that "coresight_" is 
a bad prefix here, but only for the reason that it's too general. TBH I 
think that's true of the existing Linux subsystem too, but that damage 
is already done, and I'd concur that there's little value in trying to 
unpick that now, despite the clear existence of products like CoreSight 
DAP and CoreSight ELA which don't have all that much to do with program 
trace either.

However, hindsight and inertia are hardly good reasons to double down on 
poor decisions, so if I was going to vote for anything here it would be 
"cspmu_", which is about as 
obviously-related-to-the-thing-it-actually-is as we can get while also 
being pleasantly concise.

[ And no, this isn't bikeshedding. Naming things right is *important* ]

Cheers,
Robin.

> 
> Thanks,
> Steve
> 
> [1]. drivers/hwtracing/coresight/
> [2]. https://developer.arm.com/documentation/ihi0091/latest
