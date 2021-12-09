Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F241F46E118
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhLIDEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:04:33 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65311 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhLIDEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:04:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V-.bdvL_1639018857;
Received: from 30.21.164.175(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0V-.bdvL_1639018857)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Dec 2021 11:00:58 +0800
Message-ID: <67f08ec2-4121-d025-013d-915ee23ca369@linux.alibaba.com>
Date:   Thu, 9 Dec 2021 11:00:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208191239-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
In-Reply-To: <20211208191239-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/9 上午8:19, Michael S. Tsirkin 写道:
[snip]
>>>>>>
>>>> Hi, Michael
>>>>
>>>> Thanks for the comment, unfortunately modify device is not an option for us
>>>> :-(
>>>>
>>>> Is there any idea on how to solve this issue properly?
>>>>
>>>> Regards,
>>>> Michael Wang
>>>
>>> By the way, there is a bug in the error message. Want to fix that?
>>
>> Could you please provide more detail about the bug? We'd like to help fixing
>> it :-)
>>
>> Besides, I've checked that patch but it can't address our issue, we actually
>> have this legacy pci device on arm platform, and the memory layout is
>> unfriendly since allocation rarely providing page-address below 44bit, we
>> understand the virtio-iommu case should not do force dma, while we don't
>> have that so it's just working fine.
>>
>> Regards,
>> Michael Wang
> 
> BTW is it just the ring that's at issue?

Yes, the dma address for ring allocated as page can't fit the requirement.

> Figuring out we have this problematic config and then allocating just
> the ring from coherent memory seems more palatable.

Agree, I'm also wondering why can't we force alloc 44bit-pfn page to fit 
the requirement? I mean if there are such pages, we should use them 
firstly as dma address for legacy devices, and only fail when there are 
no such pages at all, but can't find existing API to alloc page with 
such requirement... anyway.

> 
> But please note we still need to detect config with a virtual iommu (can
> be any kind not just virtio-iommu, smmu, vtd are all affected) and
> disable the hacks. This is what the new DMA API I suggested would do.

Fair enough, any more details about the design of new API?

Regards,
Michael Wang


> 
> 
>>>
>>>
>>>>>
>>>>>> ---
>>>>>>     drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
>>>>>>     drivers/virtio/virtio_ring.c       |  3 +++
>>>>>>     include/linux/virtio.h             |  1 +
>>>>>>     3 files changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_pci_legacy.c
>>>>>> b/drivers/virtio/virtio_pci_legacy.c
>>>>>> index d62e983..11f2ebf 100644
>>>>>> --- a/drivers/virtio/virtio_pci_legacy.c
>>>>>> +++ b/drivers/virtio/virtio_pci_legacy.c
>>>>>> @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
>>>>>> *vp_dev)
>>>>>>     	vp_dev->setup_vq = setup_vq;
>>>>>>     	vp_dev->del_vq = del_vq;
>>>>>>
>>>>>> +	/*
>>>>>> +	 * The legacy pci device requre 32bit-pfn vq,
>>>>>> +	 * or setup_vq() will failed.
>>>>>> +	 *
>>>>>> +	 * Thus we make sure vring_use_dma_api() will
>>>>>> +	 * return true during the allocation by marking
>>>>>> +	 * force_dma here.
>>>>>> +	 */
>>>>>> +	vp_dev->vdev.force_dma = true;
>>>>>> +
>>>>>>     	return 0;
>>>>>>
>>>>>>     err_iomap:
>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>> index 3035bb6..6562e01 100644
>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>> @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
>>>>>> virtqueue *_vq,
>>>>>>
>>>>>>     static bool vring_use_dma_api(struct virtio_device *vdev)
>>>>>>     {
>>>>>> +	if (vdev->force_dma)
>>>>>> +		return true;
>>>>>> +
>>>>>>     	if (!virtio_has_dma_quirk(vdev))
>>>>>>     		return true;
>>>>>>
>>>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>>>> index 41edbc0..a4eb29d 100644
>>>>>> --- a/include/linux/virtio.h
>>>>>> +++ b/include/linux/virtio.h
>>>>>> @@ -109,6 +109,7 @@ struct virtio_device {
>>>>>>     	bool failed;
>>>>>>     	bool config_enabled;
>>>>>>     	bool config_change_pending;
>>>>>> +	bool force_dma;
>>>>>>     	spinlock_t config_lock;
>>>>>>     	spinlock_t vqs_list_lock; /* Protects VQs list access */
>>>>>>     	struct device dev;
>>>>>> -- 
>>>>>> 1.8.3.1
