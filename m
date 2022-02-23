Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2C4C0D06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiBWHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiBWHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00886359
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645600120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rm2KeOaWQm/yGgRbJdODchW0H4miVO9/iqeAXn0Nkc=;
        b=L6aY7BxytTX9yqp29ME+/AzXu6v0CIze1jfkmO2sQqNNfNDjjIq7xYIAP0wde7itm+eAJM
        URZ/Nt6IB5pzp5TTG9ik3nvvirYq/hxmjkf/xityQ3s7aJJcEzHjRukRBH8Jluz2iac9/W
        eardfpkmEigdhWA1+1Zk7gjK1n0FA0Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-mQmloIUWMNm6FKgmvF-G3A-1; Wed, 23 Feb 2022 02:08:39 -0500
X-MC-Unique: mQmloIUWMNm6FKgmvF-G3A-1
Received: by mail-wr1-f71.google.com with SMTP id m2-20020adff382000000b001edbdae0527so7651wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rm2KeOaWQm/yGgRbJdODchW0H4miVO9/iqeAXn0Nkc=;
        b=eqqyZHG5nbvITABbPIyZlANNqi+CY6TIHnm+Pa4gUfE8laGp75pxLLOl8X6ad4SHAI
         tvxERTUBb1URhVltJy8JpjnSzU4zRElUIJC/wkMzeIOu6AbyCZy8fs3NKAO/9oRq6qv2
         GGvyCNzWh2V4aT17hYcrG0L5AmFXYXcfJMI9ObyWtCyqY7nXVV7qZf/XMIRfgr1VkrcK
         Qc8CGMO/8yqhswJhQ3YBrzg4XF+VJ+J7KjTGwYXrCbCvY3oDBK/tH5tdQGaw6Vjg7xQN
         Wq2ndVpO3l6OcYvbXz5WVq9Gabn27FH9MAgpO3CPNkrqhRppQCVM0yupLi/2I3czhvA9
         Cd2Q==
X-Gm-Message-State: AOAM533mdu4Kq+IldNKOc01+/AiAxKhWPd1/XJClEWw2KT0lpolU81iD
        6O9m1ylw3IbEcoaaNO07oYeyuVK7bC8PfhQE7+0z3Y9S7yN5px1fxPfaeDJIk0ZIlhR2hHkTWpC
        km4VFCnqSlZwFgcIkFa2SaaFG
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id z3-20020a7bc143000000b0037bdacdbf2fmr6154645wmi.16.1645600117177;
        Tue, 22 Feb 2022 23:08:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+GFh97whIOSuNZIFHT24l5YnFjkQwsxacN320vC8AIXK0xpLOYTUY/wY71XkrJ/Nn38fVQQ==
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id z3-20020a7bc143000000b0037bdacdbf2fmr6154632wmi.16.1645600116974;
        Tue, 22 Feb 2022 23:08:36 -0800 (PST)
Received: from redhat.com ([2.55.144.92])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b0037bf81c237dsm4859013wms.32.2022.02.22.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:08:36 -0800 (PST)
Date:   Wed, 23 Feb 2022 02:08:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220223020452-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > for split virtqueue") tries to make it possible for the driver to not
> > read from the descriptor ring to prevent the device from corrupting
> > the descriptor ring. But it still read the descriptor flag from the
> > descriptor ring during buffer detach.
> >
> > This patch fixes by always store the descriptor flag no matter whether
> > DMA API is used and then we can avoid reading descriptor flag from the
> > descriptor ring. This eliminates the possibly of unexpected next
> > descriptor caused by the wrong flag (e.g the next flag).
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Michael, any comment for this?
> 
> Thanks

I don't exactly see why we should care without DMA API, it seems
cleaner not to poke at the array one extra time.

> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..28734f4e57d3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >         }
> >         /* Last one doesn't continue. */
> >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > -       if (!indirect && vq->use_dma_api)
> > +       if (!indirect)
> >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> >                         ~VRING_DESC_F_NEXT;
> >
> > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >         /* Put back on free list: unmap first-level descriptors and find end */
> >         i = head;
> >
> > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > +       while (vq->split.desc_extra[i].flags & nextflag) {
> >                 vring_unmap_one_split(vq, i);
> >                 i = vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> > --
> > 2.25.1
> >

