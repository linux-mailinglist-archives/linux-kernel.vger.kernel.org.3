Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE674C0D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiBWHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiBWHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 415ED6D391
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645602622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18/7L9IlK0MUSWEpBnnED7xfRcmw6buBtiFVEVIoIww=;
        b=MqeUYzTmyCeOzIYBmDHKdR9yS4eUGdhgF+Fs4t6p3/wQMZwAeHYvexQWlSuB9truomnE6E
        39Rot1gt7aLp+BTsOQCtHrA9PAcK3umaiJE7Dd/DNcYkYZ4dgVvFgYJTjMF6hz/76VuZHK
        Sy2tfKaD9sQrCk34WuGse31I7JkCqHI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-g2rggbaDMzSmx44vL6MDSQ-1; Wed, 23 Feb 2022 02:50:20 -0500
X-MC-Unique: g2rggbaDMzSmx44vL6MDSQ-1
Received: by mail-lj1-f198.google.com with SMTP id q17-20020a2e7511000000b0023c95987502so6939090ljc.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18/7L9IlK0MUSWEpBnnED7xfRcmw6buBtiFVEVIoIww=;
        b=okdIZTS16Jm1VT0T+mMuruzf26b/jf4HMQpRsctguT9pWt5nPJ+MBVcFS1+ECWPH9L
         n0vwHPU7SBL00Nd4n+D6LDEjfiUVBEcdfAzt+kvlar6FuPEIP+KgrXAFsWRy/wMqMsIk
         a4HfuT3Q03LeH996ZiHftU5h5aFtAfQXmhUhrRyDJTFmtGA310zsNPFqp/ktCZcW6GgW
         G3DC7HawS1cHPqcG4ftjOCgtJOEI56ASPqMmtcZZxr6YcdB0G2bi42Cx6P2KcEQXdq4g
         TppIWb7Fkcybm3rnYpZLkY+337BGbKahFds3fgd2tVtkx3+jB1uf5YyL/p1J4Qzpsv5c
         NrGg==
X-Gm-Message-State: AOAM5330B9PDHSYLU5OUKeM3VrxHDywQeDczJCA0iCL4EsR+y4cIzyIK
        c8MErEVGDbmks2ujgkga05SRfgy45+fmg9D250jVR6RaUckRE7szLjvzRG6Jw3PC1Wepss6KeYA
        FHdKJUEL3JZpMKSFBb//0a/oR7amzepP3PefdQ96O
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id v21-20020a2e7a15000000b00236deb21f74mr20100098ljc.315.1645602619241;
        Tue, 22 Feb 2022 23:50:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXtXvHLakBc+SCeksBjaI5IBz4p+vdxHIOsU2WxMxmALaRHcCUrxNy5WT1Szp6b8RDwuFVxayNMXj5FW9I3GA=
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id
 v21-20020a2e7a15000000b00236deb21f74mr20100087ljc.315.1645602619006; Tue, 22
 Feb 2022 23:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com> <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org> <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
In-Reply-To: <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Feb 2022 15:50:07 +0800
Message-ID: <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 3:34 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > > for split virtqueue") tries to make it possible for the driver to not
> > > > read from the descriptor ring to prevent the device from corrupting
> > > > the descriptor ring. But it still read the descriptor flag from the
> > > > descriptor ring during buffer detach.
> > > >
> > > > This patch fixes by always store the descriptor flag no matter whether
> > > > DMA API is used and then we can avoid reading descriptor flag from the
> > > > descriptor ring. This eliminates the possibly of unexpected next
> > > > descriptor caused by the wrong flag (e.g the next flag).
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Michael, any comment for this?
> > >
> > > Thanks
> >
> > I don't exactly see why we should care without DMA API, it seems
> > cleaner not to poke at the array one extra time.
>
> I think the answer is that we have any special care about the DMA API

I meant "we haven't had" actually.

Thanks

> for all other places that are using desc_extra.
>
> Thanks
>
>
> >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 00f64f2f8b72..28734f4e57d3 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >         }
> > > >         /* Last one doesn't continue. */
> > > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > -       if (!indirect && vq->use_dma_api)
> > > > +       if (!indirect)
> > > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > > >                         ~VRING_DESC_F_NEXT;
> > > >
> > > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > >         /* Put back on free list: unmap first-level descriptors and find end */
> > > >         i = head;
> > > >
> > > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > > >                 vring_unmap_one_split(vq, i);
> > > >                 i = vq->split.desc_extra[i].next;
> > > >                 vq->vq.num_free++;
> > > > --
> > > > 2.25.1
> > > >
> >

