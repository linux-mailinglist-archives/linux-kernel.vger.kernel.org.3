Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58C4C3BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiBYCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23FC22692C0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645756810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tizsj4bPO0QBsPJAqUXEPjagkzoPs8d5YiCjb2hGNHY=;
        b=U6WYaJqXGG0hekQ9c2fGiXbKJwW60zLsaGpXuwm44YrkPP/yawJFCh3gxmSJMxfT4n0wBI
        dixDpmanVlSBIYc3BBOGEBQK+g6nJ12wmix/5MM+zB1ghU9/3QWW6KaG+sjEsbcB20fWeh
        VA/J8WOeGqVucT2zrCLl+pBJgNlea9o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-N1WUtscTP6eA4Gvw3Yrupw-1; Thu, 24 Feb 2022 21:40:08 -0500
X-MC-Unique: N1WUtscTP6eA4Gvw3Yrupw-1
Received: by mail-lj1-f197.google.com with SMTP id x8-20020a2ea7c8000000b00246215e0fc3so2004115ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tizsj4bPO0QBsPJAqUXEPjagkzoPs8d5YiCjb2hGNHY=;
        b=gqDev6JJC9pskBBOWIJiEwcQXDVSDs5TSZN1x3RGejp5MAEA0TVSsUn28ImpRJWYpX
         Tj9utdtwiwty9JO9g8Lm6uB9PF5MXi6eiHzgJzHHN/X8WHrOWDKBU/1CbNqfKONwuq5u
         kVE2HkIBZzhRM2trOCouxcbCgrn25aGsAZ0Q5ap8nU4TDHaehXhlzQNLX6CLr8uveSTu
         3uLiUqurxms+A8//3EJ5M6Kw3zPVU+j9KIEK51oUEBFsOUeoLXfNSym5SwXTmyNNvZs/
         NQITTnlGptj0O31cfq5O3eZxAM/pCemw3QW0Qw930gwvxgWGZZwi6TpYdaGoUeuNhz6w
         UOuQ==
X-Gm-Message-State: AOAM531SxM9rqs91cA0sBnlOLufT/DblZAyAavwL55O6e1KZ6Qr2yRQM
        VK6qug9dEN01yGjfVCvpxBdpvAjBLWELgczvEQKucaUswU5tnts7wvz+Ku7MI2ldYigNui7D7EZ
        EPvzBYgJt4PgBVfKZkBpMEF6CxSpuXnUwnZpfmw0m
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr3522653lfd.190.1645756807200;
        Thu, 24 Feb 2022 18:40:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUbmQTASv2aaxGJpDDBbqtehfsoN38J/JU91xlQJLh9nHs3fmoj+R4Z3CnVsXjhWW+FAg32LXS48NmxeCSc5s=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr3522640lfd.190.1645756806989; Thu, 24
 Feb 2022 18:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com> <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org> <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
 <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com> <20220224122533-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220224122533-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 25 Feb 2022 10:39:56 +0800
Message-ID: <CACGkMEtCNpwH5zmA7yySJSZ9sRqJB+zKDJN9xgva0SxCPAz3-Q@mail.gmail.com>
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

On Fri, Feb 25, 2022 at 1:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 03:50:07PM +0800, Jason Wang wrote:
> > On Wed, Feb 23, 2022 at 3:34 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > > > > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > > > > for split virtqueue") tries to make it possible for the driver to not
> > > > > > read from the descriptor ring to prevent the device from corrupting
> > > > > > the descriptor ring. But it still read the descriptor flag from the
> > > > > > descriptor ring during buffer detach.
> > > > > >
> > > > > > This patch fixes by always store the descriptor flag no matter whether
> > > > > > DMA API is used and then we can avoid reading descriptor flag from the
> > > > > > descriptor ring. This eliminates the possibly of unexpected next
> > > > > > descriptor caused by the wrong flag (e.g the next flag).
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > Michael, any comment for this?
> > > > >
> > > > > Thanks
> > > >
> > > > I don't exactly see why we should care without DMA API, it seems
> > > > cleaner not to poke at the array one extra time.
> > >
> > > I think the answer is that we have any special care about the DMA API
> >
> > I meant "we haven't had" actually.
> >
> > Thanks
>
> I'm just asking what's better for performance. An extra write in the
> first chunk has a cost. Want to test and see?

I will do it.

Thanks

>
> > > for all other places that are using desc_extra.
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 00f64f2f8b72..28734f4e57d3 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > >         }
> > > > > >         /* Last one doesn't continue. */
> > > > > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > > > -       if (!indirect && vq->use_dma_api)
> > > > > > +       if (!indirect)
> > > > > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > > > > >                         ~VRING_DESC_F_NEXT;
> > > > > >
> > > > > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > > > >         /* Put back on free list: unmap first-level descriptors and find end */
> > > > > >         i = head;
> > > > > >
> > > > > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > > > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > > > > >                 vring_unmap_one_split(vq, i);
> > > > > >                 i = vq->split.desc_extra[i].next;
> > > > > >                 vq->vq.num_free++;
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > >
>

