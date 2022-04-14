Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28328500B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiDNKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiDNKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:35:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5BAC7C14F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:32:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C563139F;
        Thu, 14 Apr 2022 03:32:45 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE0B3F5A1;
        Thu, 14 Apr 2022 03:32:43 -0700 (PDT)
Message-ID: <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
Date:   Thu, 14 Apr 2022 11:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, joro@8bytes.org, thunder.leizhen@huawei.com,
        jgg@ziepe.ca, tglx@linutronix.de, john.garry@huawei.com,
        jean-philippe@linaro.org, christophe.jaillet@wanadoo.fr,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-13 21:19, Nicolin Chen wrote:
> Hi Robin,
> 
> On Wed, Apr 13, 2022 at 02:40:31PM +0100, Robin Murphy wrote:
>> On 2022-04-13 05:17, Nicolin Chen wrote:
>>> To calculate num_pages, the size should be aligned with
>>> "page size", determined by the tg value. Otherwise, its
>>> following "while (iova < end)" might become an infinite
>>> loop if unaligned size is slightly greater than 1 << tg.
>>
>> Hmm, how does a non-page-aligned invalidation request get generated in
>> the first place?
> 
> I don't have the testing environment because it was a bug,
> reported by a client who uses SVA feature on top of SMMU.
> 
> But judging from the log, the non-page-aligned inv request
> was coming from an likely incorrect end address, e.g.
> 	{ start = 0xff10000, end = 0xff20000 }
> So the size turned out to be 0x10001, unaligned.
> 
> I don't have a full call trace on hand right now to see if
> upper callers are doing something wrong when calculate the
> end address, though I've asked the owner to check.
> 
> By looking at the call trace within arm_smmu_* functions:
>    __arm_smmu_tlb_inv_range
>    arm_smmu_tlb_inv_range_asid
>    arm_smmu_mm_invalidate_range
>    {from mm_notifier_* functions}
> 
> There's no address alignment check. Although I do think we
> should fix the source who passes down the non-page-aligned
> parameter, the SMMU driver shouldn't silently dead loop if
> a set of unaligned inputs are given, IMHO.

Oh, sure, I'm not saying we definitely don't need to fix anything, I'd 
just like to get a better understanding of *what* we're fixing. I'd have 
(naively) expected the mm layer to give us page-aligned quantities even 
in the SVA notifier case, so if we've got a clear off-by-one somewhere 
in that path we should fix that before just blindly over-invalidating to 
paper over it; if we still also want to be robust at the SMMU driver end 
just in case, something like "if (WARN_ON(num_pages == 0)) num_pages = 
1;" might be more appropriate. However if it turns out that we *can* 
actually end up with unsanitised input from some userspace unmap 
interface getting this far, then a silent fixup is the best option, but 
if so I'd still like to confirm that we're rounding in the same 
direction as whoever touched the pagetables (since it can't have been us).

Thanks,
Robin.
