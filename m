Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F95144D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356256AbiD2IyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356169AbiD2Ixw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:53:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20EBF63385
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:50:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8CB1063;
        Fri, 29 Apr 2022 01:50:33 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96C363F73B;
        Fri, 29 Apr 2022 01:50:30 -0700 (PDT)
Message-ID: <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
Date:   Fri, 29 Apr 2022 09:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        yong.wu@mediatek.com, mjrosato@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 07:57, Baolu Lu wrote:
> Hi Robin,
> 
> On 2022/4/28 21:18, Robin Murphy wrote:
>> Move the bus setup to iommu_device_register(). This should allow
>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
> 
> I re-fetched the latest patches on
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
> 
> and rolled back the head to "iommu: Cleanup bus_set_iommu".
> 
> The test machine still hangs during boot.
> 
> I went through the code. It seems that the .probe_device for Intel IOMMU
> driver can't handle the probe replay well. It always assumes that the
> device has never been probed.

Hmm, but probe_iommu_group() is supposed to prevent the 
__iommu_probe_device() call even happening if the device *has* already 
been probed before :/

I've still got an old Intel box spare in the office so I'll rig that up 
and see if I can see what might be going on here...

Thanks,
Robin.

> 
> Best regards,
> baolu
> 
>>
>> At this point we can also handle cleanup better than just rolling back
>> the most-recently-touched bus upon failure - which may release devices
>> owned by other already-registered instances, and still leave devices on
>> other buses with dangling pointers to the failed instance. Now it's easy
>> to clean up the exact footprint of a given instance, no more, no less.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iommu.c | 51 +++++++++++++++++++++++--------------------
>>   1 file changed, 27 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 6c4621afc8cf..c89af4dc54c2 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -175,6 +175,14 @@ static int __init iommu_subsys_init(void)
>>   }
>>   subsys_initcall(iommu_subsys_init);
>> +static int remove_iommu_group(struct device *dev, void *data)
>> +{
>> +    if (dev->iommu && dev->iommu->iommu_dev == data)
>> +        iommu_release_device(dev);
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * iommu_device_register() - Register an IOMMU hardware instance
>>    * @iommu: IOMMU handle for the instance
>> @@ -197,12 +205,29 @@ int iommu_device_register(struct iommu_device 
>> *iommu,
>>       spin_lock(&iommu_device_lock);
>>       list_add_tail(&iommu->list, &iommu_device_list);
>>       spin_unlock(&iommu_device_lock);
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +        struct bus_type *bus = iommu_buses[i];
>> +        int err;
>> +
>> +        WARN_ON(bus->iommu_ops && bus->iommu_ops != ops);
>> +        bus->iommu_ops = ops;
>> +        err = bus_iommu_probe(bus);
>> +        if (err) {
>> +            iommu_device_unregister(iommu);
>> +            return err;
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_register);
>>   void iommu_device_unregister(struct iommu_device *iommu)
>>   {
>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
>> +        bus_for_each_dev(iommu_buses[i], NULL, iommu, 
>> remove_iommu_group);
>> +
>>       spin_lock(&iommu_device_lock);
>>       list_del(&iommu->list);
>>       spin_unlock(&iommu_device_lock);
>> @@ -1655,13 +1680,6 @@ static int probe_iommu_group(struct device 
>> *dev, void *data)
>>       return ret;
>>   }
>> -static int remove_iommu_group(struct device *dev, void *data)
>> -{
>> -    iommu_release_device(dev);
>> -
>> -    return 0;
>> -}
>> -
>>   static int iommu_bus_notifier(struct notifier_block *nb,
>>                     unsigned long action, void *data)
>>   {
>> @@ -1884,27 +1902,12 @@ static int iommu_bus_init(struct bus_type *bus)
>>    */
>>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>>   {
>> -    int err;
>> -
>> -    if (ops == NULL) {
>> -        bus->iommu_ops = NULL;
>> -        return 0;
>> -    }
>> -
>> -    if (bus->iommu_ops != NULL)
>> +    if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>>           return -EBUSY;
>>       bus->iommu_ops = ops;
>> -    /* Do IOMMU specific setup for this bus-type */
>> -    err = bus_iommu_probe(bus);
>> -    if (err) {
>> -        /* Clean up */
>> -        bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
>> -        bus->iommu_ops = NULL;
>> -    }
>> -
>> -    return err;
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(bus_set_iommu);
> 
