Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F85467977
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352585AbhLCOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:36:24 -0500
Received: from foss.arm.com ([217.140.110.172]:50036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhLCOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12C7C1396;
        Fri,  3 Dec 2021 06:32:59 -0800 (PST)
Received: from [10.57.82.23] (unknown [10.57.82.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376473F73B;
        Fri,  3 Dec 2021 06:32:57 -0800 (PST)
Message-ID: <1086e7bc-3b13-417f-95e9-ef61fffb8ea4@arm.com>
Date:   Fri, 3 Dec 2021 14:32:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] virtio_vring: Fix maximum DMA mapping size computation
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>
References: <20211203121614.3380162-1-suzuki.poulose@arm.com>
 <0a13bd69696e1197bbc022d88ff0781c@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <0a13bd69696e1197bbc022d88ff0781c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 12:26, Marc Zyngier wrote:
> On 2021-12-03 12:16, Suzuki K Poulose wrote:
>> The virtio vring is a bit messy about the DMA allocations. We
>> use the parent device for any DMA alloc/free. However, we use the
>> child device for calculating the maximum size mapped by the DMA API
>> for the device. This leads to issues where the max size is set to
>> SIZE_MAX, and if the virtio device (e.g, virtio-blk) is bound to
>> swiotlb (e.g., via restricted-dma pool), we end up trying to allocate
>> larger chunks of memory, which are never satisfied by the swiotlb and
>> eventually fails.
>>
>> Fix this by using the parent device (just like all the other
>> DMA API calls) for the max mapping size.
>>
>> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/virtio/virtio_ring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 6d2614e34470..028b05d44546 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device 
>> *vdev)
>>      size_t max_segment_size = SIZE_MAX;
>>
>>      if (vring_use_dma_api(vdev))
>> -        max_segment_size = dma_max_mapping_size(&vdev->dev);
>> +        max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>>
>>      return max_segment_size;
>>  }
> 
> Ah, it looks like we all hit the same thing[1] at the same time!

Aha ! Thanks for the pointer Marc.

Suzuki

> 
>          M.
> 
> [1] https://lore.kernel.org/r/20211201112018.25276-1-will@kernel.org

