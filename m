Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFF46775D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380785AbhLCM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:29:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50762 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351984AbhLCM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:29:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92768B825B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C810C53FAD;
        Fri,  3 Dec 2021 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638534386;
        bh=hIpKbVdYxBLoMXzQtLxPqNUSCAziJ7hqe4vDBkjvXik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gz5/r2cEvtABFzusLHtE/5K5mp2ZmvsiyS/ima8DkxqsRVTQ2gFgYf5M6fFlTQmMj
         aVVnziwkm/59WACxNjWpCrbwDz6bU+nwtBDzBjknivQy+yGaS7tG8WazW4YpcdMR5e
         VKsJWEto4g0Lck8XwX7W0YRAH67B8+gU2YidddYv52WTibnnSZ4kN7GuiFnmJxKE2V
         bfhlzeNnOKA2ECY7/8HbhxE06UYpPIdSuiPG/RIxY4TleKOtnbAOTc6sZZRLfSKbo0
         b46JrjYGoY9NSz+wGNsupvi4w4Z976djxZlEUOhlRCHF/sBty2cDbbmv1pk1cx2zbL
         hS6YxLPRYXQUQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mt7dw-009b8a-BZ; Fri, 03 Dec 2021 12:26:24 +0000
MIME-Version: 1.0
Date:   Fri, 03 Dec 2021 12:26:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] virtio_vring: Fix maximum DMA mapping size computation
In-Reply-To: <20211203121614.3380162-1-suzuki.poulose@arm.com>
References: <20211203121614.3380162-1-suzuki.poulose@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0a13bd69696e1197bbc022d88ff0781c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, jasowang@redhat.com, virtualization@lists.linux-foundation.org, jroedel@suse.de, konrad.wilk@oracle.com, hch@lst.de, mst@redhat.com, robin.murphy@arm.com, steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-03 12:16, Suzuki K Poulose wrote:
> The virtio vring is a bit messy about the DMA allocations. We
> use the parent device for any DMA alloc/free. However, we use the
> child device for calculating the maximum size mapped by the DMA API
> for the device. This leads to issues where the max size is set to
> SIZE_MAX, and if the virtio device (e.g, virtio-blk) is bound to
> swiotlb (e.g., via restricted-dma pool), we end up trying to allocate
> larger chunks of memory, which are never satisfied by the swiotlb and
> eventually fails.
> 
> Fix this by using the parent device (just like all the other
> DMA API calls) for the max mapping size.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c 
> b/drivers/virtio/virtio_ring.c
> index 6d2614e34470..028b05d44546 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device 
> *vdev)
>  	size_t max_segment_size = SIZE_MAX;
> 
>  	if (vring_use_dma_api(vdev))
> -		max_segment_size = dma_max_mapping_size(&vdev->dev);
> +		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> 
>  	return max_segment_size;
>  }

Ah, it looks like we all hit the same thing[1] at the same time!

         M.

[1] https://lore.kernel.org/r/20211201112018.25276-1-will@kernel.org
-- 
Jazz is not dead. It just smells funny...
