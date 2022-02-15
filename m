Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEE4B6D76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiBONaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:30:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiBONao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:30:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE146106B0E;
        Tue, 15 Feb 2022 05:30:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8934F1480;
        Tue, 15 Feb 2022 05:30:34 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2253F718;
        Tue, 15 Feb 2022 05:30:30 -0800 (PST)
Message-ID: <9018a1d9-4d42-3a99-dbc6-c55139abcb1e@arm.com>
Date:   Tue, 15 Feb 2022 13:30:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Yicong Yang <yangyicong@huawei.com>
Cc:     mark.rutland@arm.com, prime.zeng@huawei.com,
        alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, Yicong Yang <yangyicong@hisilicon.com>,
        daniel.thompson@linaro.org, peterz@infradead.org, mingo@redhat.com,
        helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        acme@kernel.org, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        leo.yan@linaro.org
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
 <20220215130044.GA7154@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220215130044.GA7154@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15 13:00, Will Deacon wrote:
> On Mon, Feb 14, 2022 at 08:55:20PM +0800, Yicong Yang wrote:
>> On 2022/1/24 21:11, Yicong Yang wrote:
>>> The DMA of HiSilicon PTT device can only work with identical
>>> mapping. So add a quirk for the device to force the domain
>>> passthrough.
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 6dc6d8b6b368..6f67a2b1dd27 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>>   	}
>>>   }
>>>   
>>> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>>> +					 (pdev)->device == 0xa12e)
>>> +
>>> +static int arm_smmu_def_domain_type(struct device *dev)
>>> +{
>>> +	if (dev_is_pci(dev)) {
>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +		if (IS_HISI_PTT_DEVICE(pdev))
>>> +			return IOMMU_DOMAIN_IDENTITY;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static struct iommu_ops arm_smmu_ops = {
>>>   	.capable		= arm_smmu_capable,
>>>   	.domain_alloc		= arm_smmu_domain_alloc,
>>> @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
>>>   	.sva_unbind		= arm_smmu_sva_unbind,
>>>   	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>>>   	.page_response		= arm_smmu_page_response,
>>> +	.def_domain_type	= arm_smmu_def_domain_type,
>>>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>>   	.owner			= THIS_MODULE,
>>>   };
>>>
>>
>> Is this quirk ok with the SMMU v3 driver? Just want to confirm that I'm on the
>> right way to dealing with the issue of our device.
> 
> I don't think the quirk should be in the SMMUv3 driver. Assumedly, you would
> have the exact same problem if you stuck the PTT device behind a different
> type of IOMMU, and so the quirk should be handled by a higher level of the
> stack.

Conceptually, yes, but I'm inclined to be pragmatic here. Default domain 
quirks could only move out as far as the other end of the call from 
iommu_get_def_domain_type() - it's not like we could rely on some flag 
in a driver which may not even be loaded yet, let alone matched to the 
device. And even then there's an equal and opposite argument for why the 
core code should have to maintain a list of platform-specific quirks 
rather than code specific to the relevant platforms. The fact is that a 
HiSilicon RCiEP is not going to end up behind anything other than a 
HiSilicon IOMMU, and if those ever stop being SMMUv3 *and* such a quirk 
still exists we can worry about it then.

Ugly as it is, this is the status quo. I don't recall anyone ever 
arguing that the equivalent quirks for Intel integrated graphics should 
be made generic ;)

Cheers,
Robin.
