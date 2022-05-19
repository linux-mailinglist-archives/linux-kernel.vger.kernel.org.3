Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4669152CDED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiESIIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiESIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B70F5DA21
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652947716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
        b=YglDRBKj6NtFtEJYgfjfIpd1ByEZctatedn6v9j81LNqt+xhBZV61SoFn79PG0s02KGQUu
        a/UgZ74/I1bUEYl+5IjHPdee1b7/n8vcOIg0ctb8k6uydrnF8a3j4nl7JLUs+qp16r4rQV
        lh8SI1THDehlZ7EwnriNP+yGI6IbaaE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-xS9TcFqtOf2KTyDVhC4OCQ-1; Thu, 19 May 2022 04:08:35 -0400
X-MC-Unique: xS9TcFqtOf2KTyDVhC4OCQ-1
Received: by mail-lf1-f72.google.com with SMTP id y12-20020a0565123f0c00b00477bab7c83aso2062791lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
        b=bZOoPCPhu6a9wZQ6gfOtKuuHrDqHzTzl1NhvjuCrlnpM0YqEwZ57VSRjav9mLwpm9F
         IgmxYm+lkmygIZbfzyljVUIh6QqL4IGkr6Eh2D2gWj0351Qo+8NwOkB9R/8jE4dc1GnH
         P9KW6E8uORdn1ABadNFKdezfYeBWzwZ26JVNAYIaCW3JjwqNPg0frNla27djYhXkpf/7
         K2RqFpgMBz5pHRiJdd+kF8KOhrs0DaIdqwnhbUV5LurXyykbqKeWQu/0KUZs4fI2/tm9
         JvO7UUur6v8bRrFpuPP+xyqCLJrx3uNYr8Zn2r9E+5Ju9a7ikX0ZGfn9B1kzz8XDOzlA
         jdsg==
X-Gm-Message-State: AOAM5331KTBN+Si/SF6jql6UaS4Gc9V90GYeEM3tXrfj1xUhvLj4CCm5
        3W+OMsXbYZxkpn6AkSUF0eQZe8qAQTNPhFsKGFC6EjKY+ES7DUlquG403RQxuYUCiRo6mZCO8EJ
        m1SRR1MxP3dQqqea3VqKJJBLdB+JhizGkax3+Q6Bc
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id o5-20020a2ebd85000000b002509bf28e27mr1936020ljq.177.1652947713551;
        Thu, 19 May 2022 01:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTVSo9SydbYuTdAcj6vvShrXEBo1eZDTyMXTBaYDqgH2C2D8RyXds5Ke02dPdHxXw8Kdl7wrNxJTIMixKQCm4=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr1936002ljq.177.1652947713385; Thu, 19
 May 2022 01:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com> <20220518035951.94220-8-jasowang@redhat.com>
 <87r14rf983.fsf@redhat.com>
In-Reply-To: <87r14rf983.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 May 2022 16:08:22 +0800
Message-ID: <CACGkMEs7f63SDxed0qg4XVspJ9cSCTRrV8R-MUUVQCvjAXp+DA@mail.gmail.com>
Subject: Re: [PATCH V5 7/9] virtio: allow to unbreak virtqueue
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 6:04 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch allows the new introduced __virtio_break_device() to
> > unbreak the virtqueue.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
> >  include/linux/virtio.h       |  1 +
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cfb028ca238e..5b7df7c455f0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2397,6 +2397,27 @@ void virtio_break_device(struct virtio_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_break_device);
> >
> > +/*
> > + * This should allow the device to be used by the driver. You may
> > + * need to grab appropriate locks to flush. This should only be used
>
> Hm, to flush what?

How about "to flush the write to vq->broken"?

>
> > + * in some specific case e.g (probing and restoring). Driver should
> > + * not call this directly.
>
> Maybe "This function should only be called by the core, not directly by
> the driver."?

Ok.

Thanks

>
> > + */
> > +void __virtio_unbreak_device(struct virtio_device *dev)
> > +{
> > +     struct virtqueue *_vq;
> > +
> > +     spin_lock(&dev->vqs_list_lock);
> > +     list_for_each_entry(_vq, &dev->vqs, list) {
> > +             struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > +             WRITE_ONCE(vq->broken, false);
> > +     }
> > +     spin_unlock(&dev->vqs_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > +
> >  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
>

