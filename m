Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFEA522A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiEKCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbiEKCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B62920EE3B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652236832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rsScbuPuNJutA0AJwuwsA+ysprCiaTZ/68Y1lfAnjY=;
        b=EtK41e8XodKyi6LBr/oCEz3RJ5KKM45ydTzB+T13qEtyoEO1dM4vt6hwpz2WJTE1VehiOA
        0+NBuLzb0709hcmzJJJironSeRWL3Ddx+xyVAV3aSsStIcokfi++MfG4Aj8Oj3xExendbc
        SB8P9TzepQmr9Kvdw0FPvrouIaXEKho=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-LHez9YA0OSahYT54E_bJbw-1; Tue, 10 May 2022 22:40:24 -0400
X-MC-Unique: LHez9YA0OSahYT54E_bJbw-1
Received: by mail-lf1-f69.google.com with SMTP id i8-20020a0565123e0800b004725f87c5f2so294528lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rsScbuPuNJutA0AJwuwsA+ysprCiaTZ/68Y1lfAnjY=;
        b=4jwEiS1+RhuFxxNuhfL80kUcrZl9bInXtPJ69mF/V8qT04iG4tstC5Ok4SMu+tvqFG
         nDRNtRiJXHnWfuoqFiH1bKt1CJK1dHOq5mz3UIL7fBrbfW8zJg4PWKpOn+BQguasVNxO
         PIBaOg7h4zEurygNL4F8Et7IBDcJ2yIfVjcrMgtj6efwlI8QlPMMLaaLlLf57/QVFtgJ
         TV22aJ5PkMayNv+A6bTnvdJhdqNsJFQHClcsV8ganIbCaRgXXuJdsYpcziaIM5WrxxaO
         FmQ8Wzoozv7PbhnCEnwLMLwA1lIAQN1dAmUok+emxVCqpWL4AYpj5TTAFnGlT7lWW9Se
         3wdQ==
X-Gm-Message-State: AOAM530SlLrWgxlfF1B5BcJ9eloZjIY0RIR5B1DVfdIF9CYpam/AsPvV
        lAbMi/JuYDetx6QGztkvWW029qe0+qDcoLp2oU+vHBUTHYSKYRp9DJMQRU+xo0xLwTnKSRTZulL
        uImslWfXWO2QzMlih1B+nO8cbcu3W1jTsotU4vsYY
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id d16-20020a05651233d000b00473a25ef9fbmr18536561lfg.98.1652236822576;
        Tue, 10 May 2022 19:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXPhsS7aZArFqRm1KQv3WcIM3fpOGbBNyqmSsuzU0vfQIcoWpVROQBx3w5Yryj7t+vM1cSBoexVRWIu8KK29c=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr18536556lfg.98.1652236822393; Tue, 10
 May 2022 19:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510072833-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 10:40:11 +0800
Message-ID: <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> > This is a rework on the previous IRQ hardening that is done for
> > virtio-pci where several drawbacks were found and were reverted:
> >
> > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> >    that is used by some device such as virtio-blk
> > 2) done only for PCI transport
> >
> > The vq->broken is re-used in this patch for implementing the IRQ
> > hardening. The vq->broken is set to true during both initialization
> > and reset. And the vq->broken is set to false in
> > virtio_device_ready(). Then vring_interrupt can check and return when
> > vq->broken is true. And in this case, switch to return IRQ_NONE to let
> > the interrupt core aware of such invalid interrupt to prevent IRQ
> > storm.
> >
> > The reason of using a per queue variable instead of a per device one
> > is that we may need it for per queue reset hardening in the future.
> >
> > Note that the hardening is only done for vring interrupt since the
> > config interrupt hardening is already done in commit 22b7050a024d7
> > ("virtio: defer config changed notifications"). But the method that is
> > used by config interrupt can't be reused by the vring interrupt
> > handler because it uses spinlock to do the synchronization which is
> > expensive.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio.c       | 15 ++++++++++++---
> >  drivers/virtio/virtio_ring.c  | 11 +++++++----
> >  include/linux/virtio_config.h | 12 ++++++++++++
> >  3 files changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 8dde44ea044a..696f5ba4f38e 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +     /*
> > +      * The below virtio_synchronize_cbs() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > +      * driver_ready == false.
> > +      */
> > +     virtio_break_device(dev);
> > +     virtio_synchronize_cbs(dev);
> > +
> >       dev->config->reset(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> >       dev->config_enabled = false;
> >       dev->config_change_pending = false;
> >
> > +     INIT_LIST_HEAD(&dev->vqs);
> > +     spin_lock_init(&dev->vqs_list_lock);
> > +
> >       /* We always start by resetting the device, in case a previous
> >        * driver messed it up.  This also tests that code path a little. */
> >       virtio_reset_device(dev);
> > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> >       /* Acknowledge that we've seen the device. */
> >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >
> > -     INIT_LIST_HEAD(&dev->vqs);
> > -     spin_lock_init(&dev->vqs_list_lock);
> > -
> >       /*
> >        * device_add() causes the bus infrastructure to look for a matching
> >        * driver.
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5b7df7c455f0..9dfad2890d7a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       vq->we_own_ring = true;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > @@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >               return IRQ_NONE;
> >       }
> >
> > -     if (unlikely(vq->broken))
> > -             return IRQ_HANDLED;
> > +     if (unlikely(vq->broken)) {
> > +             dev_warn_once(&vq->vq.vdev->dev,
> > +                           "virtio vring IRQ raised before DRIVER_OK");
> > +             return IRQ_NONE;
> > +     }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy! */
> >       if (vq->event)
> > @@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       vq->we_own_ring = false;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index d8a2340f928e..23f1694cdbd5 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> >       unsigned status = dev->config->get_status(dev);
> >
> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +
> > +     /*
> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > +      * will see the driver specific setup if it sees vq->broken
> > +      * as false.
> > +      */
> > +     virtio_synchronize_cbs(dev);
>
> since you mention vq->broken above, maybe add
>         "set vq->broken to false"

Ok.

>
> > +     __virtio_unbreak_device(dev);
> > +     /*
> > +      * The transport is expected ensure the visibility of
>
> to ensure

Will fix.

>
> > +      * vq->broken
>
> let's add: "visibility by vq callbacks"

Sure.

>
> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> > +      */
>
>
> Can I see some analysis of existing transports showing
> this is actually the case for them?

Yes.

> And maybe add a comment near set_status to document the
> requirement.

For PCI and MMIO, we can quote the memory-barriers.txt or explain that
wmb() is not needed before the MMIO writel().
For CCW, it looks not obvious, it looks to me the IO was submitted via
__ssch() which has an inline assembly.  Cornelia and Hali, could you
help me to understand if and how did virtio_ccw_set_status() can
ensure the visibility of the previous driver setup and vq->broken
here?

Thanks

>
> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >  }
> >
> > --
> > 2.25.1
>

