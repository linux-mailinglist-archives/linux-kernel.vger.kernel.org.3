Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69050A975
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392060AbiDUTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392057AbiDUTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:47:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9746E4CD6E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:44:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11ACF153B;
        Thu, 21 Apr 2022 12:44:42 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A64E3F5A1;
        Thu, 21 Apr 2022 12:44:39 -0700 (PDT)
Message-ID: <9c6819ec-9189-c6dd-b9ba-3687beebc538@arm.com>
Date:   Thu, 21 Apr 2022 20:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 12/13] iommu/virtio: Clean up bus_set_iommu()
Content-Language: en-GB
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
 <YmGQjYZMtaqSf87a@myrica>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YmGQjYZMtaqSf87a@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21 18:12, Jean-Philippe Brucker wrote:
> On Thu, Apr 14, 2022 at 01:42:41PM +0100, Robin Murphy wrote:
>> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
>> the probe failure path accordingly.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/virtio-iommu.c | 24 ------------------------
>>   1 file changed, 24 deletions(-)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index 25be4b822aa0..371f8657c0ce 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -7,7 +7,6 @@
>>   
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> -#include <linux/amba/bus.h>
>>   #include <linux/delay.h>
>>   #include <linux/dma-iommu.h>
>>   #include <linux/dma-map-ops.h>
> 
> <linux/platform_device.h> isn't needed anymore either. In any case it
> looks great, thanks

Ha, it totally passed me by that this one *isn't* a platform driver, derp :)

> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> and tested on QEMU (so only PCI for now)

Thanks!

Robin.

>> @@ -1146,26 +1145,6 @@ static int viommu_probe(struct virtio_device *vdev)
>>   
>>   	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
>>   
>> -#ifdef CONFIG_PCI
>> -	if (pci_bus_type.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -#endif
>> -#ifdef CONFIG_ARM_AMBA
>> -	if (amba_bustype.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -#endif
>> -	if (platform_bus_type.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -
>>   	vdev->priv = viommu;
>>   
>>   	dev_info(dev, "input address: %u bits\n",
>> @@ -1174,9 +1153,6 @@ static int viommu_probe(struct virtio_device *vdev)
>>   
>>   	return 0;
>>   
>> -err_unregister:
>> -	iommu_device_sysfs_remove(&viommu->iommu);
>> -	iommu_device_unregister(&viommu->iommu);
>>   err_free_vqs:
>>   	vdev->config->del_vqs(vdev);
>>   
>> -- 
>> 2.28.0.dirty
>>
