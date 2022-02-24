Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB25E4C33A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiBXR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiBXR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3FBD7EA2D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645723614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOt11P3yaaZUw/7BmU9CxBeIQu22cwdFYgYDt8CuHzs=;
        b=CC0V0z5IBm/OtpLTRhOQ+/ppTtPg8gD46aNgEzm2AIfnNplmVl2/QYI0Hv2dmHw4uftfDz
        SACeddVXuMV/ugLlZKJs6II5DMH7BxpAmFioCI1VxvLTTdBpz8btyGNVw7jeeTFqDpHxi1
        a1U5jiknAb5yaR4VmlkOg3bhd/j18vo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-mptVZWKyOxSWSqUSDwz4Bg-1; Thu, 24 Feb 2022 12:26:52 -0500
X-MC-Unique: mptVZWKyOxSWSqUSDwz4Bg-1
Received: by mail-wm1-f71.google.com with SMTP id az39-20020a05600c602700b00380e48f5994so141923wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KOt11P3yaaZUw/7BmU9CxBeIQu22cwdFYgYDt8CuHzs=;
        b=wCYuNe2G0BTeor529eobPY4uw11FpS793KIJRcaozkQHNeoZaw800FUbc3bCQ2z11T
         dUqdI15Q37XlS3xfUOGxsVeFLDTYjOMByh2fRF8QnPRDXtT8p3tgDfBCK7DH8Tf6tuNo
         oRYXs2EY6yyqTM/knEgG1SeT8u60ae87QP6xHkc3Ujg7Ow/qtw9Vn5bRUIBw3Al4oweA
         dZsaO0W/zVu7nYyPIhLZViD44iPcd+SEL6miFaPJLzRw5Y9iig3lkidUhLkEyG3auuUd
         3GZ2aQvb4oYcrckk/H9mnWXCvmbZMNxEAQrMfHJYtyihCYsaQH7S50G3WjWr4Yd9RdFE
         RawA==
X-Gm-Message-State: AOAM532+Jo/ZzHlYReOXHCiaJhXWPnfWA8aX7MgBLAYrWTM0WXbCKD5t
        qN2TSb4PuAC66im3XYUh68cEAwo5aDGrC/FIMy4n3HYwxIKqWmj/sGgKPtHoDAevrBN3y3zoCEv
        v2s89jQ2knAbZYYq4BfUl+laZ
X-Received: by 2002:adf:e552:0:b0:1ef:58cc:fd3c with SMTP id z18-20020adfe552000000b001ef58ccfd3cmr702088wrm.264.1645723611342;
        Thu, 24 Feb 2022 09:26:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp6nduuBu8KKk5GwR9BSY8FWCyD58WiMZsQiFTE9p+p5m/wsAqEbG8mtV8Mp+fucekaoMpvQ==
X-Received: by 2002:adf:e552:0:b0:1ef:58cc:fd3c with SMTP id z18-20020adfe552000000b001ef58ccfd3cmr702070wrm.264.1645723611096;
        Thu, 24 Feb 2022 09:26:51 -0800 (PST)
Received: from redhat.com ([2.55.145.157])
        by smtp.gmail.com with ESMTPSA id 14sm4243666wrb.34.2022.02.24.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:26:50 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:26:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220224122533-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org>
 <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
 <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 03:50:07PM +0800, Jason Wang wrote:
> On Wed, Feb 23, 2022 at 3:34 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > > > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > > > for split virtqueue") tries to make it possible for the driver to not
> > > > > read from the descriptor ring to prevent the device from corrupting
> > > > > the descriptor ring. But it still read the descriptor flag from the
> > > > > descriptor ring during buffer detach.
> > > > >
> > > > > This patch fixes by always store the descriptor flag no matter whether
> > > > > DMA API is used and then we can avoid reading descriptor flag from the
> > > > > descriptor ring. This eliminates the possibly of unexpected next
> > > > > descriptor caused by the wrong flag (e.g the next flag).
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Michael, any comment for this?
> > > >
> > > > Thanks
> > >
> > > I don't exactly see why we should care without DMA API, it seems
> > > cleaner not to poke at the array one extra time.
> >
> > I think the answer is that we have any special care about the DMA API
> 
> I meant "we haven't had" actually.
> 
> Thanks

I'm just asking what's better for performance. An extra write in the
first chunk has a cost. Want to test and see?

> > for all other places that are using desc_extra.
> >
> > Thanks
> >
> >
> > >
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 00f64f2f8b72..28734f4e57d3 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >         }
> > > > >         /* Last one doesn't continue. */
> > > > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > > -       if (!indirect && vq->use_dma_api)
> > > > > +       if (!indirect)
> > > > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > > > >                         ~VRING_DESC_F_NEXT;
> > > > >
> > > > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > > >         /* Put back on free list: unmap first-level descriptors and find end */
> > > > >         i = head;
> > > > >
> > > > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > > > >                 vring_unmap_one_split(vq, i);
> > > > >                 i = vq->split.desc_extra[i].next;
> > > > >                 vq->vq.num_free++;
> > > > > --
> > > > > 2.25.1
> > > > >
> > >

