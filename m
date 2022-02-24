Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303254C3429
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiBXR4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4075323531F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645725356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyZ+8mwH7A7IyXyP8sy2oOYKxL6VPV73PTdkRXEFeIw=;
        b=MX4R9q2wzjzws8tux1M6ilcba2dKm3rlcHYJeVp7cK2NH07MskjFd9Gi4RIu3RKLVLaAlU
        F9R7RmNSbWMpJwqhdisayaE1aVsJaWpEs3jM8zQtzMbJq9gxJQGN3fE3PTP5qJ7pIuzN+v
        i8reQblmmaZYMR2IHhTwpl8GF/nP5sM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-qH-6tEONP6e-IovcrIIhyQ-1; Thu, 24 Feb 2022 12:55:54 -0500
X-MC-Unique: qH-6tEONP6e-IovcrIIhyQ-1
Received: by mail-wr1-f70.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so193203wrg.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xyZ+8mwH7A7IyXyP8sy2oOYKxL6VPV73PTdkRXEFeIw=;
        b=eVZ3t+b+LKAO1PzhjllnkIt4aRMnIg7Owdsqxg9jXStSzr/FMqsDsCAFRzJZB4al7g
         +EV3+QV3pWrmrUYiHEvDCSgZAX5PVWhfE7Hn/JVdjKugzTCOQSV8cV834AkaUYfddHMk
         jINqJThx0cs8l6ug4qceUjVU27IQ/GoMnT6V6Ewyr42rtWYpb2i0yUKnFKhojF7XqvFZ
         zp2V7sxZoo/i7iaiKXx1VzQrxo8w33gEIpQcotvZK09gyDp+c8ArUQsg/W9ldLxPmp5W
         PYe1bty3Awr/OwCuCqQFXjEbwxM3kmXQ/s12QBfVeG7493bJpwvFd8t2fqF8bl/3uAxm
         aY/Q==
X-Gm-Message-State: AOAM531NppqkAQdLewnmFnPikYAPWrzwddinW30WDH2rxUbWB0urpPYN
        vvXFMAnEExXonmRYpQ4bv0gOkJ542NBJD1nMfrAZ6h/fpytUxTpCJgdmViVDUpvZmT/mhSmrs5Y
        Fcda/Y6ove6VC7/FCVUwc5Kjq
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id f13-20020a05600c4e8d00b0037c4e20baa6mr3332962wmq.19.1645725353272;
        Thu, 24 Feb 2022 09:55:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPIbEkonNCeTz8FUscHAS8oihHXjPH9/S9rkSQ1S5nl9l6gCfI9+XK+q8zBFoGHuqRfK+4Tg==
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id f13-20020a05600c4e8d00b0037c4e20baa6mr3332937wmq.19.1645725352901;
        Thu, 24 Feb 2022 09:55:52 -0800 (PST)
Received: from redhat.com ([2.55.145.157])
        by smtp.gmail.com with ESMTPSA id q7-20020adfcd87000000b001e8a4f58a8csm15343wrj.66.2022.02.24.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:55:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:55:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220224122655-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108081324.14204-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in the subject btw.

minor tweaks to commit log below

On Mon, Nov 08, 2021 at 04:13:24PM +0800, Jason Wang wrote:
> Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> for split virtqueue") tries to make it possible for the driver to not
> read from the descriptor ring to prevent the device from corrupting
> the descriptor ring. But it still read 

reads

>the descriptor flag from the
> descriptor ring during buffer detach.
> 
> This patch fixes 

fixes this

>by always store 

storing

>the descriptor flag no matter whether
> DMA API is used and then we can avoid reading descriptor flag from the
> descriptor ring. This eliminates the possibly of unexpected next
> descriptor caused by the wrong flag (e.g the next flag).
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


I'd also like the commit log to document what the issue is in a bit more depth.
I think the main reason we are checking the dma API is this


static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
                                          unsigned int i)
{
        struct vring_desc_extra *extra = vq->split.desc_extra;
        u16 flags;

        if (!vq->use_dma_api)
                goto out;

	...
}


so I guess with a bad flag, what will happen is num_free will become too
big is that right?




> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..28734f4e57d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	}
>  	/* Last one doesn't continue. */
>  	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vq->use_dma_api)
> +	if (!indirect)
>  		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>  			~VRING_DESC_F_NEXT;
>  

BTW I'm a bit confused why we need the & (vq->split.vring.num - 1) logic.
Maybe it's time we stopped writing out descriptor then overwriting it -
e.g. return the desc_extra pointer from virtqueue_add_desc_split
instead of an index. Worth checking what this does to performance.


> @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>  
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (vq->split.desc_extra[i].flags & nextflag) {
>  		vring_unmap_one_split(vq, i);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
> -- 
> 2.25.1

