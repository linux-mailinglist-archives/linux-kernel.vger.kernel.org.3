Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC547CF76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhLVJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:43:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57240 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbhLVJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:43:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V.Pf2n8_1640166233;
Received: from 30.225.24.125(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V.Pf2n8_1640166233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 17:43:54 +0800
Message-ID: <3d29e86f-e45a-4917-5d73-8a7ab348e8f1@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 17:43:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] iommu: alloc iommu group for pasid supported devices
To:     Robin Murphy <robin.murphy@arm.com>, bhelgaas@google.com,
        will@kernel.org, joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1639657018-39884-1-git-send-email-yaohongbo@linux.alibaba.com>
 <32307396-e364-7858-2b58-8419279d0597@arm.com>
 <3351c0fe-98dc-d018-bae5-aa0a00ccb603@linux.alibaba.com>
 <948af995-05f4-5257-6add-3b4f8e0dbd5d@arm.com>
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
In-Reply-To: <948af995-05f4-5257-6add-3b4f8e0dbd5d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/21 下午6:35, Robin Murphy 写道:
> On 2021-12-21 03:22, Yao Hongbo wrote:
>>
>>
>> 在 2021/12/21 上午12:28, Robin Murphy 写道:
>>> On 2021-12-16 12:16, Yao Hongbo wrote:
>>>> Fix a pci hotlug problem for PCI pasid enabled devices.
>>>>
>>>> We can probe PCI pasid enabled devices on boot normally,
>>>> but the following error is seen while we poweroff and poweron
>>>> this pci slot:
>>>> [  312.407485] nvme 0000:9c:00.0: cannot attach to incompatible domain
>>>> (0 SSID bits != 20)
>>>> [  312.415618] nvme 0000:9c:00.0: Failed to add to iommu group 11: -22
>>>>
>>>> Each device would alloc an iommu group when the os starts.
>>>> But when we hot-plug the pcie device, the device may be added to the
>>>> parent iommu group. If the device supports pasid, master->ssid_bits
>>>> would be changed in arm_smmu_enable_pasid(), but smmu->domain is from
>>>> the parent iommu, which will result in the upon error in
>>>> arm_smmu_attach_dev().
>>>>
>>>> Realloc a new iommu group if the device supports to enable pasid.
>>>
>>> I'm not sure I fully understand the circumstances of the issue, but the code in the patch doesn't look right to me - it seems to be saying that if we don't have ACS enabled, then the the mere fact that end-to-end PASID support exists somehow guarantees peer-to-peer isolation anyway. Surely that's not true?
>>
>> Hi, robin.
>> I create a bugzilla.  ref: https://bugzilla.kernel.org/show_bug.cgi?id=215379
>>
>>
>> What i want to do is actually that we should not find an iommu group anymore in circumstances of the issue.
>>
>>
>>> Is there something in the hotplug path which causes ACS and/or PASID enablement in a different order from boot-time probing?
>>
>> There is no different order, the only difference is that:
>>
>> Boot time probing will alloc new iommu group for a device, and in hotplug path, it will try to find an iommu group.
>>
>> boot-time log:
>> [   29.887367] nvme 0000:9c:00.0: Adding to iommu group 17
> 
> Am I correct in assuming that no other devices get added to group 17?
> 
>> [   29.887961] nvme nvme1: pci function 0000:9c:00.0
>>
>> echo 0 > /sys/bus/pci/slots/44/power
>> echo 1 > /sys/bus/pci/slots/44/power
>>
>> hot-plug log:
>> [  455.717886] pci 0000:9c:00.0: Removing from iommu group 17
>> ...
>> [  503.493130] nvme 0000:9c:00.0: cannot attach to incompatible domain (0 SSID bits != 20)
>> [  503.501268] nvme 0000:9c:00.0: Failed to add to iommu group 11: -22
> 
> Based on what the hack in this patch does, group 11 must belong to a bridge upstream of the NVMe. Clearly that group already existed when the NVMe was probed at boot (because we assign IDs sequentially), but at that point we *didn't* try to add it to group 11 but instead allocated group 17, which must mean the pci_acs_path_enabled() check returned true. Now in the hotplug path, that same check, at the same nominal stage of probing, must now be returning false - that is most certainly a difference that needs figuring out.
> 
> Robin.
> 
>> [  503.507848] nvme nvme1: pci function 0000:9c:00.0
>> [  503.507883] nvme 0000:9c:00.0: enabling device (0000 -> 0002)
>>
>>
>>> Looking at the symptom, I also wonder whether the SMMU driver really needs to be that strict (if the device can support more PASID bits than the domain is configured for, couldn't we just... not use all of them?), but we should definitely make sense of the fundamental group lookup issue here before considering any other changes that might happen to mask it.
>>> Robin.

Hi, Robin.
Thanks for your guidance. The root cause is that pcie acs ctrl register is cleared by the hardware during the hotplug process.
There is no need to change the iommu.

Thanks.
Hongbo.
>>>> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
>>>> ---
>>>>    drivers/iommu/iommu.c   |  4 ++++
>>>>    drivers/pci/ats.c       | 12 ++++++++++++
>>>>    include/linux/pci-ats.h |  3 +++
>>>>    3 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index dd7863e..61b5360 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <linux/notifier.h>
>>>>    #include <linux/err.h>
>>>>    #include <linux/pci.h>
>>>> +#include <linux/pci-ats.h>
>>>>    #include <linux/bitops.h>
>>>>    #include <linux/property.h>
>>>>    #include <linux/fsl/mc.h>
>>>> @@ -1475,6 +1476,9 @@ struct iommu_group *pci_device_group(struct device *dev)
>>>>            if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
>>>>                break;
>>>>    +        if (pci_pasid_supported(pdev))
>>>> +            break;
>>>> +
>>>>            pdev = bus->self;
>>>>              group = iommu_group_get(&pdev->dev);
>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>> index c967ad6..8fcca4f 100644
>>>> --- a/drivers/pci/ats.c
>>>> +++ b/drivers/pci/ats.c
>>>> @@ -349,6 +349,18 @@ void pci_pasid_init(struct pci_dev *pdev)
>>>>        pdev->pasid_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>>>>    }
>>>>    +bool pci_pasid_supported(struct pci_dev *pdev)
>>>> +{
>>>> +    if (!pdev->pasid_cap)
>>>> +        return false;
>>>> +
>>>> +    if (!pdev->eetlp_prefix_path)
>>>> +        return false;
>>>> +
>>>> +    return true;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_pasid_supported);
>>>> +
>>>>    /**
>>>>     * pci_enable_pasid - Enable the PASID capability
>>>>     * @pdev: PCI device structure
>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>> index df54cd5b..623725b 100644
>>>> --- a/include/linux/pci-ats.h
>>>> +++ b/include/linux/pci-ats.h
>>>> @@ -35,11 +35,14 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
>>>>    #endif /* CONFIG_PCI_PRI */
>>>>      #ifdef CONFIG_PCI_PASID
>>>> +bool pci_pasid_supported(struct pci_dev *dev);
>>>>    int pci_enable_pasid(struct pci_dev *pdev, int features);
>>>>    void pci_disable_pasid(struct pci_dev *pdev);
>>>>    int pci_pasid_features(struct pci_dev *pdev);
>>>>    int pci_max_pasids(struct pci_dev *pdev);
>>>>    #else /* CONFIG_PCI_PASID */
>>>> +static inline bool pci_pasid_supported(struct pci_dev *d)
>>>> +{ return false; }
>>>>    static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
>>>>    { return -EINVAL; }
>>>>    static inline void pci_disable_pasid(struct pci_dev *pdev) { }
