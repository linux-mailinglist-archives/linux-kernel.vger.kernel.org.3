Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA654F6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381958AbiFQLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381938AbiFQLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B0D62DD4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655466455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjDQFwJzUbTNmx5JYS5EoPwX+v2MHv1quBw00Z1i85g=;
        b=AkZmWCvwUkQK7ZB0qzVEQ0Bl4Ph6VhmLC9HsPHs4fKmkXl7Y86hkJT0w7esu8/50lcK73e
        TgEo8sJbYCj91miRLe7YRrXRR1ZnUZRsWC+3+FaQcIFGUlZH9YnOrj9j5M+ki/tuqG/Wna
        VghHNWt/Lngnea6nFG6yslVwMDTcFRw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-VxbeK9rXNc-fstEHV28DFg-1; Fri, 17 Jun 2022 07:47:34 -0400
X-MC-Unique: VxbeK9rXNc-fstEHV28DFg-1
Received: by mail-lf1-f70.google.com with SMTP id u5-20020a056512128500b00479784f526cso2252305lfs.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjDQFwJzUbTNmx5JYS5EoPwX+v2MHv1quBw00Z1i85g=;
        b=Lg1Xxi9Mpkju4cz6v1tw2bf1PH+tRAKc2W0rnXQKhaWmvkkNSI4tL0lXRYtk+0IAoR
         7YmjD3SJ0nEZWDQPgrlAaq4RrDLLrOp/5ejqYcywkBW3EH/OlXk5NeGTBvUYKo2U+mrH
         0NGW0nUuuBNRPoSYT/Uk+GWIOUxSduzQfHYxYA35/wgQfbZTm6v6fm24g005nEzlpr0p
         NVtZYwDf3Fd7xGF9M6HjL7x+R/whr34RaFx0BnyyzDjcHHXz91OHfq45qmV0eErG85+I
         cIpeJHlFPwuKa5If1dr0cyGn7ooYoY+amdQamWrbg1Yby86qINxA7KbODsWLHNSftIZo
         1wRQ==
X-Gm-Message-State: AJIora9j0DKz9rzEZR3HCn1i1fG12clS8NdxjFH+mYa97JNuux5NmOoT
        lW+etpUXc/0Z1OIwHJPZ8ODdurVqMljq8InrGtzC8HXT7NO778dizMqnkz4bJHPqsLhPPOUkFJz
        Kxfo6i9yKW6MZs6gJWIWIv0HcwXx8exMiA1BeuFMN
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id c7-20020a056512104700b004797805005fmr5480993lfb.238.1655466452698;
        Fri, 17 Jun 2022 04:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsA2h2VwhQVyDmfmK0zw2nue8iMARvRgpx2KzikIV14kLezZ2kWnli9gvS2xSPBzPxb+ykQuVHaGLmaXgjO6o=
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr5480981lfb.238.1655466452430; Fri, 17
 Jun 2022 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072626.30503-1-jasowang@redhat.com> <20220617060111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220617060111-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Jun 2022 19:47:21 +0800
Message-ID: <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
Subject: Re: [PATCH] virtio: disable notification hardening by default
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
> > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > harden vring IRQ"). It works with the assumption that the driver or
> > core can properly call virtio_device_ready() at the right
> > place. Unfortunately, this seems to be not true and uncover various
> > bugs of the existing drivers, mainly the issue of using
> > virtio_device_ready() incorrectly.
> >
> > So let's having a Kconfig option and disable it by default. It gives
> > us a breath to fix the drivers and then we can consider to enable it
> > by default.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Do you want to drop irq_lock lock/unlock in ccw too?

Not a must I think. But if you insist, I can remove them.

Thanks

>
> > ---
> >  drivers/virtio/Kconfig        |  6 ++++++
> >  drivers/virtio/virtio.c       |  2 ++
> >  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
> >  include/linux/virtio_config.h |  2 ++
> >  4 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..b059c39af3d4 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable to this to harden the device notifications and
> > +          supress the ones that are illegal.
> > +
> >  config VIRTIO_PCI
> >       tristate "PCI driver for virtio devices"
> >       depends on PCI
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ef04a96942bf..21dc08d2f32d 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /*
> >        * The below virtio_synchronize_cbs() guarantees that any
> >        * interrupt for this line arriving after
> > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> >        */
> >       virtio_break_device(dev);
> >       virtio_synchronize_cbs(dev);
> > +#endif
> >
> >       dev->config->reset(dev);
> >  }
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 13a7348cedff..d9d3b6e201fb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       vq->we_own_ring = true;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       vq->broken = true;
> > +#else
> > +     vq->broken = false;
> > +#endif
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >       }
> >
> >       if (unlikely(vq->broken)) {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >               dev_warn_once(&vq->vq.vdev->dev,
> >                             "virtio vring IRQ raised before DRIVER_OK");
> >               return IRQ_NONE;
> > +#else
> > +             return IRQ_HANDLED;
> > +#endif
> >       }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy! */
> > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       vq->we_own_ring = false;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       vq->broken = true;
> > +#else
> > +     vq->broken = false;
> > +#endif
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 9a36051ceb76..d15c3cdda2d2 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >
> >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /*
> >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >        * will see the driver specific setup if it sees vq->broken
> > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >        */
> >       virtio_synchronize_cbs(dev);
> >       __virtio_unbreak_device(dev);
> > +#endif
> >       /*
> >        * The transport should ensure the visibility of vq->broken
> >        * before setting DRIVER_OK. See the comments for the transport
> > --
> > 2.25.1
>

