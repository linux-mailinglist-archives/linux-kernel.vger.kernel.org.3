Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35C4D05C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiCGRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiCGRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:55:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E26FA18
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2FCCCE0EDB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82ECC340F6;
        Mon,  7 Mar 2022 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646675671;
        bh=skJXL8/N2xCsgKAp+CXm32RgRJoIRM8CbDaIsqyS5+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVFXmd5iXoXH64fcOXo1x8kyRaopJJw7P0/ydyBOtJiC4KItvqq3AicpSs44vn1R1
         0hM+MVkZk3BWyZIrzK0QLlWxeI6+8y27fhD63zmOfJk2Z8yrsXoEAm2W53wQmoteGE
         e20cUSpUPPMvyySRtwRZS2NoBcxsIJbPB8G6IY2NNe6VW4rtq5SrVSoarx0Fy3W3LP
         YGMaVIkxneeBXxN+M3tq+/BsAanyhmbsfaxP2a9xw2+bX7YhTQVIy9CyDsiPfJh1Cr
         CUzPiFXLrPGY+blvo1zyWmq4IumfSEMLfUB4f69QbIqyUeRyLkNd8g8HBCmIta1EwG
         Y96HaS1kd3SMg==
Date:   Mon, 7 Mar 2022 10:54:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     trix@redhat.com
Cc:     mst@redhat.com, jasowang@redhat.com, ndesaulniers@google.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] virtio_ring: Initialize vring_size_in_bytes
Message-ID: <YiZG0Nx9j++bJaA4@dev-arch.thelio-3990X>
References: <20220307174916.892433-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307174916.892433-1-trix@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 09:49:16AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> On the clang build, there is this error
> virtio_ring.c:1772:26: error: variable 'ring_size_in_bytes'
>   is uninitialized when used here
>   vring_free_queue(vdev, ring_size_in_bytes,
>                          ^~~~~~~~~~~~~~~~~~
> 
> ring_dma_addr was intialized twice, once with the ring_size_in_bytes.
> value.  So fix typo.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

I was getting ready to send the same patch.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 905c882600618..b2b567ebb9120 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1756,7 +1756,7 @@ static void vring_free_vring_packed(struct vring_packed *vring,
>  	ring                  = vring->ring;
>  	driver                = vring->driver;
>  	device                = vring->device;
> -	ring_dma_addr         = vring->ring_size_in_bytes;
> +	ring_size_in_bytes    = vring->ring_size_in_bytes;
>  	event_size_in_bytes   = vring->event_size_in_bytes;
>  	ring_dma_addr         = vring->ring_dma_addr;
>  	driver_event_dma_addr = vring->driver_event_dma_addr;
> -- 
> 2.26.3
> 
> 
