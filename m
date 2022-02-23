Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446154C0D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiBWHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiBWHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792BB70CD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645601686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McSwbVQkHiXC8iu7T4MJhFzHcjjvF5/k+kIazZQNsRc=;
        b=NXqqOOoVewjVxm6Y4nBHoRCPIV6X2ThJApM55ZSj2Uel5BvKmnS/XJ1IoW1xh8tJ4ICBmf
        joXv2pfYZbLxTZfeRfoiofwM9axupqWuquoGRfbBj8s74gvT7mJrhFh+PcwtfkdRn26DX8
        u9HWxMy2ZzBFn7fXptc9wBoDlDrnRWU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-hou8sPpWOQaW_tQ8U9ecVw-1; Wed, 23 Feb 2022 02:34:45 -0500
X-MC-Unique: hou8sPpWOQaW_tQ8U9ecVw-1
Received: by mail-lf1-f72.google.com with SMTP id r14-20020ac252ae000000b00443987dc996so3144887lfm.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McSwbVQkHiXC8iu7T4MJhFzHcjjvF5/k+kIazZQNsRc=;
        b=iiLmiO5GGWLGH2K/loc8y8nNng9LRnvG9Cdn7zTo0LhY2XwBeJMXR/40c05RIQkij+
         pRraAgLthy6KQ5bD09fKan92JFj3PofxxZXaGdC/DKSXNEftSLPDEpffqPiXi6oOBQZH
         fK4Trl+UloqEe9nXbVA9xMXyzYpbBCiDO1lCZfJSLBBhoivqMQMktFgzGmRAQY6x5E8N
         S6DJOrIXmo1WbOAe3XIjidfSKtoAl/ZHc4nm7QBWNZ3YNDk/Jj/vkf1nh0l7pitpIItV
         3wEDjfXeeZU59MqpENdGkC+W4NK0Vva8ANL0ote75utwisn7S+C01OnafvKQITPco/C9
         jkEQ==
X-Gm-Message-State: AOAM5337aKb07DdN5qyVChpv8lQDtP6O74z0CKZjujLnkVZsseMefsaQ
        dnex4OD8RUGmyfrzDZ8pecVp4B2zvEUFrQK9fdpkNXqIVzDzJ4W5/tzdJUSaD7u6VrAR1iRtQlc
        R2RoIVFmkbHKvYeqBz1HOeszKcIqj4tpDOxWmZFxE
X-Received: by 2002:a05:6512:15a0:b0:443:96ac:11d with SMTP id bp32-20020a05651215a000b0044396ac011dmr18882994lfb.471.1645601683499;
        Tue, 22 Feb 2022 23:34:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz46i8/q8ySRYQ6BTiY1ws+UNE6QavM6rT+wdU2ZmAtcmlZScVKO5j44ixU2NQgf2Y3Yx8osUMfzsWo/hJLY0g=
X-Received: by 2002:a05:6512:15a0:b0:443:96ac:11d with SMTP id
 bp32-20020a05651215a000b0044396ac011dmr18882988lfb.471.1645601683277; Tue, 22
 Feb 2022 23:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com> <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220223020452-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Feb 2022 15:34:32 +0800
Message-ID: <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > for split virtqueue") tries to make it possible for the driver to not
> > > read from the descriptor ring to prevent the device from corrupting
> > > the descriptor ring. But it still read the descriptor flag from the
> > > descriptor ring during buffer detach.
> > >
> > > This patch fixes by always store the descriptor flag no matter whether
> > > DMA API is used and then we can avoid reading descriptor flag from the
> > > descriptor ring. This eliminates the possibly of unexpected next
> > > descriptor caused by the wrong flag (e.g the next flag).
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Michael, any comment for this?
> >
> > Thanks
>
> I don't exactly see why we should care without DMA API, it seems
> cleaner not to poke at the array one extra time.

I think the answer is that we have any special care about the DMA API
for all other places that are using desc_extra.

Thanks


>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..28734f4e57d3 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >         }
> > >         /* Last one doesn't continue. */
> > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > -       if (!indirect && vq->use_dma_api)
> > > +       if (!indirect)
> > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > >                         ~VRING_DESC_F_NEXT;
> > >
> > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > >         /* Put back on free list: unmap first-level descriptors and find end */
> > >         i = head;
> > >
> > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > >                 vring_unmap_one_split(vq, i);
> > >                 i = vq->split.desc_extra[i].next;
> > >                 vq->vq.num_free++;
> > > --
> > > 2.25.1
> > >
>

