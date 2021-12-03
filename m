Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34BC467A9C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381867AbhLCPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:54:09 -0500
Received: from foss.arm.com ([217.140.110.172]:50752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352847AbhLCPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:54:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43D2B1396;
        Fri,  3 Dec 2021 07:50:44 -0800 (PST)
Received: from [10.57.82.23] (unknown [10.57.82.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2189E3F73B;
        Fri,  3 Dec 2021 07:50:42 -0800 (PST)
Message-ID: <a39f8dff-8be5-c739-d0eb-7cdab3b76a05@arm.com>
Date:   Fri, 3 Dec 2021 15:50:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] virtio_ring: Fix querying of maximum DMA mapping size for
 virtio device
To:     Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20211201112018.25276-1-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211201112018.25276-1-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 11:20, Will Deacon wrote:
> virtio_max_dma_size() returns the maximum DMA mapping size of the virtio
> device by querying dma_max_mapping_size() for the device when the DMA
> API is in use for the vring. Unfortunately, the device passed is
> initialised by register_virtio_device() and does not inherit the DMA
> configuration from its parent, resulting in SWIOTLB errors when bouncing
> is enabled and the default 256K mapping limit (IO_TLB_SEGSIZE) is not
> respected:
> 
>    | virtio-pci 0000:00:01.0: swiotlb buffer is full (sz: 294912 bytes), total 1024 (slots), used 725 (slots)
> 
> Follow the pattern used elsewhere in the virtio_ring code when calling
> into the DMA layer and pass the parent device to dma_max_mapping_size()
> instead.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>

We hit a similar problem and ended up in the same patch, a bit late [0].

FWIW:

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[0] 
https://lkml.kernel.org/r/20211203121614.3380162-1-suzuki.poulose@arm.com


> ---
>   drivers/virtio/virtio_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6d2614e34470..028b05d44546 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>   	size_t max_segment_size = SIZE_MAX;
>   
>   	if (vring_use_dma_api(vdev))
> -		max_segment_size = dma_max_mapping_size(&vdev->dev);
> +		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>   
>   	return max_segment_size;
>   }
> 

