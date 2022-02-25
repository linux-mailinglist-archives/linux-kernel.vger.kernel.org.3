Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12B4C3BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiBYCgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D8402614A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645756567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU8GS8BgzaMD7fDEtovQ458r1iAvIqdNLZPe70i9638=;
        b=GMlamDOCQxKXK+co5+WTHWpJBPxqtN9yu50BBVRSRDKnZ2MQSm81QtNMfL+kYLLe/Iwe5M
        IhqpSyI3cxOXud4T8Tv5HWRWK9YrbGQgNLHatnpees9ts7vnTuFDyzJCGzUdXXIcKsBHHm
        PILx149w7i+vH61RNqArFf5N2NYSV5E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-qgtWoS3JMxSmY4TTuN5HkA-1; Thu, 24 Feb 2022 21:36:05 -0500
X-MC-Unique: qgtWoS3JMxSmY4TTuN5HkA-1
Received: by mail-lj1-f198.google.com with SMTP id r27-20020a2e575b000000b002463f43ca0aso2009842ljd.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yU8GS8BgzaMD7fDEtovQ458r1iAvIqdNLZPe70i9638=;
        b=TKug39Wra+nz+3ar8i6iNmOsNMhgv19BNIVxTxHipXj5qoPFsK2KVfi8rDruuOz9pa
         O6jIBpwJeMmt3bJU4bXlGgwIKtN5H6YZFjJ6Adz3+Gu39a89UXvYK41kAHPjJCz0pX7/
         TmXtebAaYrNNP2J3zJKRWPWdypl6EqKXoJqPapYDJ2xPzEg3BI+wyz+ebKBDyja+pO0i
         UL1Xfl4bobqMJuJf+Q5GwCgnRvapQOlar7/rKC2OC5JuWk98qW9z3mzYoSrbx2nIsw9Y
         LxPQp40g3dyUk2IZHVcJ2nxG/p1ZNhn1SZEV3BwDtKck7/o+K3bJf9mYFAfOZXaiK4xd
         62uA==
X-Gm-Message-State: AOAM533HOPlgwJKz4cmrbZpVJNEF4XdK3yT8u2mBz3AmyiM5v+ytawmu
        I/eN6Ax+YuV5S/sZ5emCqpXkTZNJPhUVICRgRzYqV5HCEY86+rJggXjwWWYxbZivdWlnU8FLHSH
        xati+i6zGnccfz+G9dCdiQ0EbsOgZC9Y/US/fsZki
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id 7-20020a05651c00c700b00244f9d77c48mr4028966ljr.300.1645756564234;
        Thu, 24 Feb 2022 18:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjAhhNdJ81uWG2TggCgB0pGDHZN6gLYH0DcvEADiHYUKFvn60w4UU5WCGJu9wPo8OI5eChZ4BpTaH0LrHjkM4=
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr4028959ljr.300.1645756563999; Thu, 24 Feb
 2022 18:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com> <20220224122655-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220224122655-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 25 Feb 2022 10:35:52 +0800
Message-ID: <CACGkMEuCWE-oHQXJYfQZh2k5s8BNWRgXW4wZrHyo7Z2=k89EeA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 1:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Typo in the subject btw.
>
> minor tweaks to commit log below
>
> On Mon, Nov 08, 2021 at 04:13:24PM +0800, Jason Wang wrote:
> > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > for split virtqueue") tries to make it possible for the driver to not
> > read from the descriptor ring to prevent the device from corrupting
> > the descriptor ring. But it still read
>
> reads
>
> >the descriptor flag from the
> > descriptor ring during buffer detach.
> >
> > This patch fixes
>
> fixes this
>
> >by always store
>
> storing
>

Will fix.

> >the descriptor flag no matter whether
> > DMA API is used and then we can avoid reading descriptor flag from the
> > descriptor ring. This eliminates the possibly of unexpected next
> > descriptor caused by the wrong flag (e.g the next flag).
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> I'd also like the commit log to document what the issue is in a bit more depth.
> I think the main reason we are checking the dma API is this
>
>
> static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>                                           unsigned int i)
> {
>         struct vring_desc_extra *extra = vq->split.desc_extra;
>         u16 flags;
>
>         if (!vq->use_dma_api)
>                 goto out;
>
>         ...
> }
>
>
> so I guess with a bad flag, what will happen is num_free will become too
> big is that right?

Yes, and it may have other implications and this is not easy to answer
since with the current code, next/flag is the only one that can be
controlled by the device. From what I've seen so far, it can cause an
early unmap for the descriptors in the free list. This may cause
several issues when using DMA API (e.g IOTLB for bouncing). Indeed
software IOMMU/IOTLB has done a lot of checks for this but we can't
solely depend on IOMMU/IOTLB to handle malicious inputs.

So my understanding is that, instead of trying to figuring out what
may happens if some flag or descriptor is modified by the malicious
device/hypervisor, we can simply eliminate all those possibilities
with minimal efforts and this is why we try not read anything from
shared memory area (e.g the descriptor ring etc) if possible.

>
>
>
>
> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..28734f4e57d3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       }
> >       /* Last one doesn't continue. */
> >       desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > -     if (!indirect && vq->use_dma_api)
> > +     if (!indirect)
> >               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> >                       ~VRING_DESC_F_NEXT;
> >
>
> BTW I'm a bit confused why we need the & (vq->split.vring.num - 1) logic.
> Maybe it's time we stopped writing out descriptor then overwriting it -

Right since the next can be read from the descriptor ring directly (as
you said below, this needs to be fixed as well).

> e.g. return the desc_extra pointer from virtqueue_add_desc_split
> instead of an index. Worth checking what this does to performance.

Right, let me try to do that in the next version.

Thanks

>
>
> > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >       /* Put back on free list: unmap first-level descriptors and find end */
> >       i = head;
> >
> > -     while (vq->split.vring.desc[i].flags & nextflag) {
> > +     while (vq->split.desc_extra[i].flags & nextflag) {
> >               vring_unmap_one_split(vq, i);
> >               i = vq->split.desc_extra[i].next;
> >               vq->vq.num_free++;
> > --
> > 2.25.1
>

