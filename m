Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D15627F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiGABHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGABHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2CD599E1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656637656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDRvPOfg2sqIMJ3xvadp3pU7dDplLEAQE44MLsZLEnQ=;
        b=Q1PP9WzfJz6UQ4yyLnL3yw6KEqBL+X0DHJPgcon/35Brhf2U9MKRhXkqmB3RubNLOjAOTy
        sib4L+1iPM63MQbiA92QfUUUT3pENxToej/chPAnqsRxP5F9Eeelx5WcvNDbMUJBBKA7t8
        cAfbVoy43z5VHb+asdR49SG82vVlwfk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-6O470hy9P0ixCeCcGWbvoA-1; Thu, 30 Jun 2022 21:07:34 -0400
X-MC-Unique: 6O470hy9P0ixCeCcGWbvoA-1
Received: by mail-lf1-f69.google.com with SMTP id q22-20020a0565123a9600b0047f6b8e1babso360495lfu.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDRvPOfg2sqIMJ3xvadp3pU7dDplLEAQE44MLsZLEnQ=;
        b=Ax2s17B23o5J0aOdq4WK1WnnhTEnRN2g76dZOV/Au3+ZzZxBTo0/gHcarsLWJlYOrx
         dlssvQ0KOhYJh+JixgjeKDFcwt2ab1uycGaOEJdZL5rWvKc7gjRauhYg7DNyY0JCFe1L
         Rsiu6MhoPzFteiHHDKf+9tOCTNuQyOGb55YrV2cXBKY2pk8ySSN+50DB0pC8WUXJ0+B0
         L3v/xOvMh7trcdCosMVSXxtbcevGfYCFDYx097ejtNO0sX1NZ0uuCTu6WGz1Lt8SG0PY
         5lqhZcIagHH7Tvd127hVpoRnE8+x8mk+Ed5wj6bZjylxx58KM0XTB1avrK0DyAB+Gcev
         m4LQ==
X-Gm-Message-State: AJIora+15YeN3zRQVwNpcHIuVX9+9ZT41ar+jYiA0pIeOuAJYUyoqTui
        ZjoqD/lybYWIGfz5kvvrM/1mM+X558EcaZayz/5Cyzf1fyp4TYWEhyiTSstONRNbqrGIzexA2V+
        9Yb4F7lqbTuocuTaVVTAHnvZG6BH5SxLOmgfRocoy
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id bj37-20020a2eaaa5000000b0025bae574ad7mr6841037ljb.323.1656637652784;
        Thu, 30 Jun 2022 18:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vG3zFm9S/F3A98azRf8TGVuk0Y8Yo6Dm1jFfKZpFBfwd8hhFccNip+jSVwsWmzuwAgKtCF+KqNpsyXuXcyAEc=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6841026ljb.323.1656637652543; Thu, 30
 Jun 2022 18:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org> <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
In-Reply-To: <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Jul 2022 09:07:21 +0800
Message-ID: <CACGkMEsZHB9opC6frbSwNmE1d9=yt3npZCHWcK25Xe52VJzwGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in virtqueues
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel@openvz.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 6:09 PM Alexander Atanasov
<alexander.atanasov@virtuozzo.com> wrote:
>
> Hello,
>
> On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> > On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> >> virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> >> of vq->broken. As result vring_interrupt handles IRQs for
> >> broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> >> to initiallize vqs before the driver is ready, i.e. in probe method.
> >> Balloon driver does this and it can not load because it fails in
> >> vqs_init with -EIO.
> >>
> >> So instead of changing the original intent ot the flag introduce
> >> a new flag vq->ready which servers the purpose to check of early IRQs
> >> and restore the behaviour of the vq->broken flag.
> >>
> >> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> >
> > Does
> >
> > commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Wed Jun 22 09:29:40 2022 +0800
> >
> >      virtio: disable notification hardening by default
> >
> >
> > solve the problem for you?
>
>
> No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon
> still won't be able to init vqs.
>
> The problem is in virtqueue_add_split and virtqueue_add_packed - can not
> set driver_ok without queues.
>
> The return value of the vring_interrupt gets different - and iirc
> IRQ_NONE for broken device can lead to interrupt storms - i am not sure
> if that is valid for virtio devices yet but for real harware most
> likely.

Valid but the interrupt will be noted and disabled by the kernel then.

> Either way if you have a mix of  drivers working differently
> depending on return of the handler  it would get really messy.

Yes, IRQ_HANDLED may break the driver that shares a single IRQ.

>
> RR's original intent was to flag a driver as bad why reuse it like that  ?

It's somehow the same, we want to prevent the driver from using the
malicious or buggy device.

Anyhow, I think using a dedicated variable is better.

We are discussing a better approach for hardening the notifications.
But in case, this will be merged:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>
> >>   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
> >>   include/linux/virtio.h        |  2 +-
> >>   include/linux/virtio_config.h | 10 +++++-----
> >>   3 files changed, 20 insertions(+), 12 deletions(-)
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Halil Pasic <pasic@linux.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> >> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> >> Cc: linux-s390@vger.kernel.org
> >> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index 13a7348cedff..dca3cc774584 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -100,6 +100,9 @@ struct vring_virtqueue {
> >>      /* Other side has made a mess, don't try any more. */
> >>      bool broken;
> >>
> >> +    /* the queue is ready to handle interrupts  */
> >> +    bool ready;
> >> +
> >>      /* Host supports indirect buffers */
> >>      bool indirect;
> >>
> >> @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >>      vq->we_own_ring = true;
> >>      vq->notify = notify;
> >>      vq->weak_barriers = weak_barriers;
> >> -    vq->broken = true;
> >> +    vq->broken = false;
> >> +    vq->ready = false;
> >>      vq->last_used_idx = 0;
> >>      vq->event_triggered = false;
> >>      vq->num_added = 0;
> >> @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >>              return IRQ_NONE;
> >>      }
> >>
> >> -    if (unlikely(vq->broken)) {
> >> +    if (unlikely(vq->broken))
> >> +            return IRQ_HANDLED;
> >> +
> >> +    if (unlikely(!vq->ready)) {
> >>              dev_warn_once(&vq->vq.vdev->dev,
> >>                            "virtio vring IRQ raised before DRIVER_OK");
> >>              return IRQ_NONE;
> >> @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >>      vq->we_own_ring = false;
> >>      vq->notify = notify;
> >>      vq->weak_barriers = weak_barriers;
> >> -    vq->broken = true;
> >> +    vq->broken = false;
> >> +    vq->ready = false;
> >>      vq->last_used_idx = 0;
> >>      vq->event_triggered = false;
> >>      vq->num_added = 0;
> >> @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
> >>    * (probing and restoring). This function should only be called by the
> >>    * core, not directly by the driver.
> >>    */
> >> -void __virtio_unbreak_device(struct virtio_device *dev)
> >> +void __virtio_device_ready(struct virtio_device *dev)
> >>   {
> >>      struct virtqueue *_vq;
> >>
> >> @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
> >>              struct vring_virtqueue *vq = to_vvq(_vq);
> >>
> >>              /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> >> -            WRITE_ONCE(vq->broken, false);
> >> +            WRITE_ONCE(vq->ready, true);
> >>      }
> >>      spin_unlock(&dev->vqs_list_lock);
> >>   }
> >> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> >> +EXPORT_SYMBOL_GPL(__virtio_device_ready);
> >>
> >>   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >>   {
> >> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> >> index d8fdf170637c..538c5959949a 100644
> >> --- a/include/linux/virtio.h
> >> +++ b/include/linux/virtio.h
> >> @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
> >>   bool is_virtio_device(struct device *dev);
> >>
> >>   void virtio_break_device(struct virtio_device *dev);
> >> -void __virtio_unbreak_device(struct virtio_device *dev);
> >> +void __virtio_device_ready(struct virtio_device *dev);
> >>
> >>   void virtio_config_changed(struct virtio_device *dev);
> >>   #ifdef CONFIG_PM_SLEEP
> >> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> index 49c7c32815f1..35cf1b26e05a 100644
> >> --- a/include/linux/virtio_config.h
> >> +++ b/include/linux/virtio_config.h
> >> @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
> >>
> >>      /*
> >>       * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >> -     * will see the driver specific setup if it sees vq->broken
> >> +     * will see the driver specific setup if it sees vq->ready
> >>       * as false (even if the notifications come before DRIVER_OK).
> >>       */
> >>      virtio_synchronize_cbs(dev);
> >> -    __virtio_unbreak_device(dev);
> >> +    __virtio_device_ready(dev);
> >>      /*
> >> -     * The transport should ensure the visibility of vq->broken
> >> +     * The transport should ensure the visibility of vq->ready
> >>       * before setting DRIVER_OK. See the comments for the transport
> >>       * specific set_status() method.
> >>       *
> >>       * A well behaved device will only notify a virtqueue after
> >>       * DRIVER_OK, this means the device should "see" the coherenct
> >> -     * memory write that set vq->broken as false which is done by
> >> +     * memory write that set vq->ready as true which is done by
> >>       * the driver when it sees DRIVER_OK, then the following
> >> -     * driver's vring_interrupt() will see vq->broken as false so
> >> +     * driver's vring_interrupt() will see vq->true as true so
> >>       * we won't lose any notification.
> >>       */
> >>      dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >> --
> >> 2.25.1
>
> --
> Regards,
> Alexander Atanasov
>

