Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B056A678
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiGGO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiGGO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:59:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A6159258;
        Thu,  7 Jul 2022 07:58:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34AA71063;
        Thu,  7 Jul 2022 07:58:46 -0700 (PDT)
Received: from [10.57.85.108] (unknown [10.57.85.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFB303F792;
        Thu,  7 Jul 2022 07:58:43 -0700 (PDT)
Message-ID: <8ad2fec1-8a51-dc35-39bb-a05a0d837ad9@arm.com>
Date:   Thu, 7 Jul 2022 15:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 15/15] iommu: Clean up bus_set_iommu()
Content-Language: en-GB
To:     Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
 <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
 <a6317b8e-87ea-122d-c1fe-c320f030a7f3@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a6317b8e-87ea-122d-c1fe-c320f030a7f3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-07 13:54, Matthew Rosato wrote:
> On 7/7/22 8:49 AM, Matthew Rosato wrote:
>> On 7/5/22 1:08 PM, Robin Murphy wrote:
>>> Clean up the remaining trivial bus_set_iommu() callsites along
>>> with the implementation. Now drivers only have to know and care
>>> about iommu_device instances, phew!
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> v3: Also catch Intel's cheeky open-coded assignment
>>>
>>
>> ...
>>
>>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>>> index c898bcbbce11..dd957145fb81 100644
>>> --- a/drivers/iommu/s390-iommu.c
>>> +++ b/drivers/iommu/s390-iommu.c
>>> @@ -385,9 +385,3 @@ static const struct iommu_ops s390_iommu_ops = {
>>>           .free        = s390_domain_free,
>>>       }
>>>   };
>>> -
>>> -static int __init s390_iommu_init(void)
>>> -{
>>> -    return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
>>> -}
>>> -subsys_initcall(s390_iommu_init);
>>
>> Previously s390_iommu_ops was only being set for pci_bus_type, but 
>> with this series it will now also be set for platform_bus_type.

Ah, indeed I hadn't got as far as fully appreciating that to_zpci_dev() 
isn't robust enough on its own. Thanks for the patch, I've pulled it in 
and will include it in v4. Do I take it that all else works OK with this 
fixed?

Cheers,
Robin.

>>
>> To tolerate that, this series needs a change along the lines of:
>>
> 
> ...  Sorry, let's try that again without a mangled diff:
> 
> From: Matthew Rosato <mjrosato@linux.ibm.com>
> Date: Thu, 7 Jul 2022 08:45:44 -0400
> Subject: [PATCH] iommu/s390: fail probe for non-pci device
> 
> 
> s390-iommu only supports pci_bus_type today
> 
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   drivers/iommu/s390-iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index dd957145fb81..762f892b4ec3 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -185,7 +185,12 @@ static void s390_iommu_detach_device(struct 
> iommu_domain *domain,
> 
> 
>   static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>   {
> -       struct zpci_dev *zdev = to_zpci_dev(dev);
> +       struct zpci_dev *zdev;
> +
> +       if (!dev_is_pci(dev))
> +               return ERR_PTR(-ENODEV);
> +
> +       zdev = to_zpci_dev(dev);
> 
> 
>          return &zdev->iommu_dev;
>   }
> 
