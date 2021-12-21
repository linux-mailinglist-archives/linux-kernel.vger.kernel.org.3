Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3047BE32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhLUKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:35:47 -0500
Received: from foss.arm.com ([217.140.110.172]:48644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhLUKfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:35:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF451FB;
        Tue, 21 Dec 2021 02:35:44 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198633F718;
        Tue, 21 Dec 2021 02:35:42 -0800 (PST)
Message-ID: <948af995-05f4-5257-6add-3b4f8e0dbd5d@arm.com>
Date:   Tue, 21 Dec 2021 10:35:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] iommu: alloc iommu group for pasid supported devices
Content-Language: en-GB
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>, bhelgaas@google.com,
        will@kernel.org, joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1639657018-39884-1-git-send-email-yaohongbo@linux.alibaba.com>
 <32307396-e364-7858-2b58-8419279d0597@arm.com>
 <3351c0fe-98dc-d018-bae5-aa0a00ccb603@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3351c0fe-98dc-d018-bae5-aa0a00ccb603@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-21 03:22, Yao Hongbo wrote:
> 
> 
> 在 2021/12/21 上午12:28, Robin Murphy 写道:
>> On 2021-12-16 12:16, Yao Hongbo wrote:
>>> Fix a pci hotlug problem for PCI pasid enabled devices.
>>>
>>> We can probe PCI pasid enabled devices on boot normally,
>>> but the following error is seen while we poweroff and poweron
>>> this pci slot:
>>> [  312.407485] nvme 0000:9c:00.0: cannot attach to incompatible domain
>>> (0 SSID bits != 20)
>>> [  312.415618] nvme 0000:9c:00.0: Failed to add to iommu group 11: -22
>>>
>>> Each device would alloc an iommu group when the os starts.
>>> But when we hot-plug the pcie device, the device may be added to the
>>> parent iommu group. If the device supports pasid, master->ssid_bits
>>> would be changed in arm_smmu_enable_pasid(), but smmu->domain is from
>>> the parent iommu, which will result in the upon error in
>>> arm_smmu_attach_dev().
>>>
>>> Realloc a new iommu group if the device supports to enable pasid.
>>
>> I'm not sure I fully understand the circumstances of the issue, but the code in the patch doesn't look right to me - it seems to be saying that if we don't have ACS enabled, then the the mere fact that end-to-end PASID support exists somehow guarantees peer-to-peer isolation anyway. Surely that's not true?
> 
> Hi, robin.
> I create a bugzilla.  ref: https://bugzilla.kernel.org/show_bug.cgi?id=215379
> 
> 
> What i want to do is actually that we should not find an iommu group anymore in circumstances of the issue.
> 
> 
>> Is there something in the hotplug path which causes ACS and/or PASID enablement in a different order from boot-time probing?
> 
> There is no different order, the only difference is that:
> 
> Boot time probing will alloc new iommu group for a device, and in hotplug path, it will try to find an iommu group.
> 
> boot-time log:
> [   29.887367] nvme 0000:9c:00.0: Adding to iommu group 17

Am I correct in assuming that no other devices get added to group 17?

> [   29.887961] nvme nvme1: pci function 0000:9c:00.0
> 
> echo 0 > /sys/bus/pci/slots/44/power
> echo 1 > /sys/bus/pci/slots/44/power
> 
> hot-plug log:
> [  455.717886] pci 0000:9c:00.0: Removing from iommu group 17
> ...
> [  503.493130] nvme 0000:9c:00.0: cannot attach to incompatible domain (0 SSID bits != 20)
> [  503.501268] nvme 0000:9c:00.0: Failed to add to iommu group 11: -22

Based on what the hack in this patch does, group 11 must belong to a 
bridge upstream of the NVMe. Clearly that group already existed when the 
NVMe was probed at boot (because we assign IDs sequentially), but at 
that point we *didn't* try to add it to group 11 but instead allocated 
group 17, which must mean the pci_acs_path_enabled() check returned 
true. Now in the hotplug path, that same check, at the same nominal 
stage of probing, must now be returning false - that is most certainly a 
difference that needs figuring out.

Robin.

> [  503.507848] nvme nvme1: pci function 0000:9c:00.0
> [  503.507883] nvme 0000:9c:00.0: enabling device (0000 -> 0002)
> 
> 
>> Looking at the symptom, I also wonder whether the SMMU driver really needs to be that strict (if the device can support more PASID bits than the domain is configured for, couldn't we just... not use all of them?), but we should definitely make sense of the fundamental group lookup issue here before considering any other changes that might happen to mask it.
>> Robin.
>>
>>> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
>>> ---
>>>    drivers/iommu/iommu.c   |  4 ++++
>>>    drivers/pci/ats.c       | 12 ++++++++++++
>>>    include/linux/pci-ats.h |  3 +++
>>>    3 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index dd7863e..61b5360 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/notifier.h>
>>>    #include <linux/err.h>
>>>    #include <linux/pci.h>
>>> +#include <linux/pci-ats.h>
>>>    #include <linux/bitops.h>
>>>    #include <linux/property.h>
>>>    #include <linux/fsl/mc.h>
>>> @@ -1475,6 +1476,9 @@ struct iommu_group *pci_device_group(struct device *dev)
>>>            if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
>>>                break;
>>>    +        if (pci_pasid_supported(pdev))
>>> +            break;
>>> +
>>>            pdev = bus->self;
>>>              group = iommu_group_get(&pdev->dev);
>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>> index c967ad6..8fcca4f 100644
>>> --- a/drivers/pci/ats.c
>>> +++ b/drivers/pci/ats.c
>>> @@ -349,6 +349,18 @@ void pci_pasid_init(struct pci_dev *pdev)
>>>        pdev->pasid_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>>>    }
>>>    +bool pci_pasid_supported(struct pci_dev *pdev)
>>> +{
>>> +    if (!pdev->pasid_cap)
>>> +        return false;
>>> +
>>> +    if (!pdev->eetlp_prefix_path)
>>> +        return false;
>>> +
>>> +    return true;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_pasid_supported);
>>> +
>>>    /**
>>>     * pci_enable_pasid - Enable the PASID capability
>>>     * @pdev: PCI device structure
>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>> index df54cd5b..623725b 100644
>>> --- a/include/linux/pci-ats.h
>>> +++ b/include/linux/pci-ats.h
>>> @@ -35,11 +35,14 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
>>>    #endif /* CONFIG_PCI_PRI */
>>>      #ifdef CONFIG_PCI_PASID
>>> +bool pci_pasid_supported(struct pci_dev *dev);
>>>    int pci_enable_pasid(struct pci_dev *pdev, int features);
>>>    void pci_disable_pasid(struct pci_dev *pdev);
>>>    int pci_pasid_features(struct pci_dev *pdev);
>>>    int pci_max_pasids(struct pci_dev *pdev);
>>>    #else /* CONFIG_PCI_PASID */
>>> +static inline bool pci_pasid_supported(struct pci_dev *d)
>>> +{ return false; }
>>>    static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
>>>    { return -EINVAL; }
>>>    static inline void pci_disable_pasid(struct pci_dev *pdev) { }
