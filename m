Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E131508CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355646AbiDTQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbiDTQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:08:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B11FA5FE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:05:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5433E1424;
        Wed, 20 Apr 2022 09:05:13 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9C83F766;
        Wed, 20 Apr 2022 09:05:10 -0700 (PDT)
Message-ID: <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
Date:   Wed, 20 Apr 2022 17:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
 <20220419144042.GA6186@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220419144042.GA6186@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-19 15:40, Will Deacon wrote:
> On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
>> Stop calling bus_set_iommu() since it's now unnecessary. With device
>> probes now replayed for every IOMMU instance registration, the whole
>> sorry ordering workaround for legacy DT bindings goes too, hooray!
> 
> Ha, I hope you tested this!

Oh alright then, since it's you... :)

I've hacked up a Juno DT with the old bindings, and (after needing a 
while to remember that they're fundamentally incompatible with 
disable_bypass), can confirm that with my whole dev branch including 
this series applied, it boots and creates IOMMU groups as expected. I 
then made the mistake of trying without the branch to check whether the 
squawks from iommu_setup_dma_ops() were new or not, and... well... plain 
rc3 doesn't even boot on the same setup - it's somehow blowing up in the 
failure cleanup path of iommu_bus_init(), apparently calling 
iommu_release_device() on something where dev->iommu->iommu_dev is NULL, 
for reasons that are far from clear and I'm not sure I can really be 
bothered to debug further... :/

Cheers,
Robin.

>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
>>   1 file changed, 2 insertions(+), 82 deletions(-)
> 
> Assuming it works,
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
