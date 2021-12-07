Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5B46B6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhLGJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:13:29 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52721 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233039AbhLGJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:13:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uzl0wxe_1638868196;
Received: from 30.21.164.179(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Uzl0wxe_1638868196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 17:09:57 +0800
Message-ID: <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
Date:   Tue, 7 Dec 2021 17:09:56 +0800
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
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
In-Reply-To: <20211207031217-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/7 下午4:13, Michael S. Tsirkin 写道:
> On Tue, Dec 07, 2021 at 03:51:45PM +0800, 王贇 wrote:
>> We observed issues like:
>>    virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must
>>    not be used with RAM above 0x4000GB
>>
>> when we have a legacy pci device which desired 32bit-pfn vq
>> but gain 64bit-pfn instead, lead into the failure of probe.
>>
>> vring_use_dma_api() is playing the key role in here, to help the
>> allocation process understand which kind of vq it should alloc,
>> however, it failed to take care the legacy pci device, which only
>> have 32bit feature flag and can never have VIRTIO_F_ACCESS_PLATFORM
>> setted.
>>
>> This patch introduce force_dma flag to help vring_use_dma_api()
>> understanding the requirement better, to avoid the failing.
>>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> This will break configs where the device appears behind
> a virtual iommu, so this won't fly.
> Just make your device support 1.0, eh?

Hi, Michael

Thanks for the comment, unfortunately modify device is not an option for 
us :-(

Is there any idea on how to solve this issue properly?

Regards,
Michael Wang

> 
>> ---
>>   drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
>>   drivers/virtio/virtio_ring.c       |  3 +++
>>   include/linux/virtio.h             |  1 +
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_pci_legacy.c
>> b/drivers/virtio/virtio_pci_legacy.c
>> index d62e983..11f2ebf 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
>> *vp_dev)
>>   	vp_dev->setup_vq = setup_vq;
>>   	vp_dev->del_vq = del_vq;
>>
>> +	/*
>> +	 * The legacy pci device requre 32bit-pfn vq,
>> +	 * or setup_vq() will failed.
>> +	 *
>> +	 * Thus we make sure vring_use_dma_api() will
>> +	 * return true during the allocation by marking
>> +	 * force_dma here.
>> +	 */
>> +	vp_dev->vdev.force_dma = true;
>> +
>>   	return 0;
>>
>>   err_iomap:
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 3035bb6..6562e01 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
>> virtqueue *_vq,
>>
>>   static bool vring_use_dma_api(struct virtio_device *vdev)
>>   {
>> +	if (vdev->force_dma)
>> +		return true;
>> +
>>   	if (!virtio_has_dma_quirk(vdev))
>>   		return true;
>>
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 41edbc0..a4eb29d 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -109,6 +109,7 @@ struct virtio_device {
>>   	bool failed;
>>   	bool config_enabled;
>>   	bool config_change_pending;
>> +	bool force_dma;
>>   	spinlock_t config_lock;
>>   	spinlock_t vqs_list_lock; /* Protects VQs list access */
>>   	struct device dev;
>> -- 
>> 1.8.3.1
