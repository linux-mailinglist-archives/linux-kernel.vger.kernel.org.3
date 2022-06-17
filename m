Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2499E54F7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382377AbiFQMeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381579AbiFQMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4643A6161E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655469255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sNsK5VV48v+4Pt6W8O4pM7sdsWEZT55OqmvpYIk2hsQ=;
        b=SjwTb5Ht4zgqOwe9BgqqEJiKls4sTWYAqniFeX7ZIvGzsORO56J3tMLvcy3WWQch9okLeZ
        UFg/IODHXEkafntUxS+UJiGBwrzGYbujK7wLv+sDYc/vVPGch7vUuAJf7ZgrjuIziVw2MA
        hMsxPMNlQnC8a21ksWYMI/Q88xS9F4A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-UtIgtcRKPheKmF8cBwcbFA-1; Fri, 17 Jun 2022 08:34:14 -0400
X-MC-Unique: UtIgtcRKPheKmF8cBwcbFA-1
Received: by mail-ej1-f72.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso2000964ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNsK5VV48v+4Pt6W8O4pM7sdsWEZT55OqmvpYIk2hsQ=;
        b=YAb+bLtXOZ2a60Qryxtxp/Cx/NHxzQDvs2L5BXi21NUshbA3jdTqPWTNH0LCOv5IvZ
         cPzp6W5qpt+sAxUxoRsilVHpu957Fa4y3EIZbi5C7fvY22YbbGIwRYg1CyRV1yn25DtB
         RIakqa2RgMaJBV7nk8RV1rxMekKDNuaX43YHiBAsDaKO5F0tJ/mt0EWobd0jQ1Hl4bPn
         yk5eclh/nGerpkTPyd3ywcmcBekSbo0GdjGNUuFMZOgK+HaxnZUOX0ROP7D9fAMxs5jF
         itPWo7McVKEW+nYVboqf4iIV+li+CsTCut/z/BzKap2TnEKRF2Q1gC47Xl0aP6mknqoO
         dr9Q==
X-Gm-Message-State: AJIora+2YhXqfd18FRg8Z3kaoGjWliZaqF5TbcYM1xFcfnUqMgbj5erD
        t0R7YWq+bsvqRuSMelimKquZivm73B3JqNpYziXHtLa4AvMJmIpsmAiznU2EYWAzwJR2L/9zEpP
        cNSO+WlYyd6baR3y+0N213p0+
X-Received: by 2002:a17:906:a57:b0:718:bd7e:e45b with SMTP id x23-20020a1709060a5700b00718bd7ee45bmr8973404ejf.204.1655469252665;
        Fri, 17 Jun 2022 05:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uetBAoDUswjTrKzjPLBZk+a2VJDZzU+POciodvxjH1l6wMuN3Sr6EJUi2y+5mbeAOAFWQM3Q==
X-Received: by 2002:a17:906:a57:b0:718:bd7e:e45b with SMTP id x23-20020a1709060a5700b00718bd7ee45bmr8973378ejf.204.1655469252385;
        Fri, 17 Jun 2022 05:34:12 -0700 (PDT)
Received: from redhat.com ([2.54.189.19])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0070d9aad64a1sm2041541eja.208.2022.06.17.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:34:11 -0700 (PDT)
Date:   Fri, 17 Jun 2022 08:34:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617083353-mutt-send-email-mst@kernel.org>
References: <20220617072626.30503-1-jasowang@redhat.com>
 <20220617060111-mutt-send-email-mst@kernel.org>
 <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsx77aTyx84Q6OAmogni97nt3wWsRguzTBKY8msqrYK-A@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:47:21PM +0800, Jason Wang wrote:
> On Fri, Jun 17, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
> > > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > > harden vring IRQ"). It works with the assumption that the driver or
> > > core can properly call virtio_device_ready() at the right
> > > place. Unfortunately, this seems to be not true and uncover various
> > > bugs of the existing drivers, mainly the issue of using
> > > virtio_device_ready() incorrectly.
> > >
> > > So let's having a Kconfig option and disable it by default. It gives
> > > us a breath to fix the drivers and then we can consider to enable it
> > > by default.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > Do you want to drop irq_lock lock/unlock in ccw too?
> 
> Not a must I think. But if you insist, I can remove them.
> 
> Thanks


With the ifdef. Seems safer ...

> >
> > > ---
> > >  drivers/virtio/Kconfig        |  6 ++++++
> > >  drivers/virtio/virtio.c       |  2 ++
> > >  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
> > >  include/linux/virtio_config.h |  2 ++
> > >  4 files changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index b5adf6abd241..b059c39af3d4 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
> > >
> > >  if VIRTIO_MENU
> > >
> > > +config VIRTIO_HARDEN_NOTIFICATION
> > > +        bool "Harden virtio notification"
> > > +        help
> > > +          Enable to this to harden the device notifications and
> > > +          supress the ones that are illegal.
> > > +
> > >  config VIRTIO_PCI
> > >       tristate "PCI driver for virtio devices"
> > >       depends on PCI
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index ef04a96942bf..21dc08d2f32d 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > >   * */
> > >  void virtio_reset_device(struct virtio_device *dev)
> > >  {
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       /*
> > >        * The below virtio_synchronize_cbs() guarantees that any
> > >        * interrupt for this line arriving after
> > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > >        */
> > >       virtio_break_device(dev);
> > >       virtio_synchronize_cbs(dev);
> > > +#endif
> > >
> > >       dev->config->reset(dev);
> > >  }
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 13a7348cedff..d9d3b6e201fb 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >       vq->we_own_ring = true;
> > >       vq->notify = notify;
> > >       vq->weak_barriers = weak_barriers;
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       vq->broken = true;
> > > +#else
> > > +     vq->broken = false;
> > > +#endif
> > >       vq->last_used_idx = 0;
> > >       vq->event_triggered = false;
> > >       vq->num_added = 0;
> > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > >       }
> > >
> > >       if (unlikely(vq->broken)) {
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >               dev_warn_once(&vq->vq.vdev->dev,
> > >                             "virtio vring IRQ raised before DRIVER_OK");
> > >               return IRQ_NONE;
> > > +#else
> > > +             return IRQ_HANDLED;
> > > +#endif
> > >       }
> > >
> > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >       vq->we_own_ring = false;
> > >       vq->notify = notify;
> > >       vq->weak_barriers = weak_barriers;
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       vq->broken = true;
> > > +#else
> > > +     vq->broken = false;
> > > +#endif
> > >       vq->last_used_idx = 0;
> > >       vq->event_triggered = false;
> > >       vq->num_added = 0;
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > >
> > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > >
> > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > >       /*
> > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > >        * will see the driver specific setup if it sees vq->broken
> > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > >        */
> > >       virtio_synchronize_cbs(dev);
> > >       __virtio_unbreak_device(dev);
> > > +#endif
> > >       /*
> > >        * The transport should ensure the visibility of vq->broken
> > >        * before setting DRIVER_OK. See the comments for the transport
> > > --
> > > 2.25.1
> >

