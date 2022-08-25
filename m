Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AA5A0F07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiHYL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiHYL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:26:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3445AACA22;
        Thu, 25 Aug 2022 04:26:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2F7D6E;
        Thu, 25 Aug 2022 04:26:45 -0700 (PDT)
Received: from [10.57.16.12] (unknown [10.57.16.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09EDB3FAF5;
        Thu, 25 Aug 2022 04:26:38 -0700 (PDT)
Message-ID: <04bf5f9a-a170-55bd-10f0-fa3695b85347@arm.com>
Date:   Thu, 25 Aug 2022 12:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] iommu/s390: Fix race with release_device ops
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, svens@linux.ibm.com,
        joro@8bytes.org, will@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
References: <20220823203059.81919-1-mjrosato@linux.ibm.com>
 <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
 <04644ee5-2386-1f3d-c1a3-fc4227570cf7@linux.ibm.com>
 <YwcjIPcT1b0uyyFn@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <69b7b496c3658b385f2404d6e3209970b3677c08.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <69b7b496c3658b385f2404d6e3209970b3677c08.camel@linux.ibm.com>
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

On 2022-08-25 12:11, Niklas Schnelle wrote:
> On Thu, 2022-08-25 at 09:22 +0200, Alexander Gordeev wrote:
>> On Wed, Aug 24, 2022 at 04:25:19PM -0400, Matthew Rosato wrote:
>>>>> @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>>>>        struct zpci_dev *zdev = to_zpci_dev(dev);
>>>>>        struct s390_domain_device *domain_device;
>>>>>        unsigned long flags;
>>>>> -    int cc, rc;
>>>>> +    int cc, rc = 0;
>>>>>          if (!zdev)
>>>>>            return -ENODEV;
>>>>>    +    /* First check compatibility */
>>>>> +    spin_lock_irqsave(&s390_domain->list_lock, flags);
>>>>> +    /* First device defines the DMA range limits */
>>>>> +    if (list_empty(&s390_domain->devices)) {
>>>>> +        domain->geometry.aperture_start = zdev->start_dma;
>>>>> +        domain->geometry.aperture_end = zdev->end_dma;
>>>>> +        domain->geometry.force_aperture = true;
>>>>> +    /* Allow only devices with identical DMA range limits */
>>>>> +    } else if (domain->geometry.aperture_start != zdev->start_dma ||
>>>>> +           domain->geometry.aperture_end != zdev->end_dma) {
>>>>> +        rc = -EINVAL;
>>>>> +    }
>>>>> +    spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>>>>> +    if (rc)
>>>>> +        return rc;
>>>>> +
>>>>>        domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
>>>>>        if (!domain_device)
>>>>>            return -ENOMEM;
>>>>>    +    /* Leave now if the device has already been released */
>>>>> +    spin_lock_irqsave(&zdev->dma_domain_lock, flags);
>>>>> +    if (!dev_iommu_priv_get(dev)) {
>>>>> +        spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
>>>>> +        kfree(domain_device);
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>>        if (zdev->dma_table && !zdev->s390_domain) {
>>>>>            cc = zpci_dma_exit_device(zdev);
>>>>>            if (cc) {
>>>>
>>>> Am I wrong? It seems to me that zpci_dma_exit_device here is called with the spin_lock locked but this function zpci_dma_exit_device calls vfree which may sleep.
>>>>
>>>
>>> Oh, good point, I just enabled lockdep to verify that.
>>>
>>> I think we could just replace this with a mutex instead, it's not a performance path.  I've been running tests successfully today with this patch modified to instead use a mutex for dma_domain_lock.
>>
>> But your original version uses irq-savvy spinlocks.
>> Are there data that need to be protected against interrupts?
>>
>> Thanks!
> 
> I think that was a carry over from my original attempt that used the
> zdev->dma_domain_lock in some more places including in interrupt
> context. I think these are gone now so I think Matt is right in his
> version this can be a mutex.

Yes, probe/release/attach/detach should absolutely not be happening from 
atomic/IRQ context. At the very least, the IOMMU core itself needs to 
take the group mutex in those paths.

Cheers,
Robin.
