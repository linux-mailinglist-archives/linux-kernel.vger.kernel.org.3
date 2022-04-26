Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6950F088
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiDZGC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDZGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D53646147
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650952759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4t6uPyVuHpjP/C6GmCEBs1kfuz7CNChglQXTuEYXBLk=;
        b=AXpUWfwa6UPQ20GLxnedV9IwRrawczhWk+7F59Y3kkTPr831bxmjr6jrCyPdtNPi9zXJ7o
        r0oUQubTNAMFs1/UwS0vmQzE5o1rv6WfJ4NoTLaG8CXackRsqLImR2k3sC3Ud5LChkaFXY
        XYiCeEAVsohu3Sm3MCOGUlzsilZoDS8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-lc8-fQg0Om2EWX-dJ3z5Cw-1; Tue, 26 Apr 2022 01:59:17 -0400
X-MC-Unique: lc8-fQg0Om2EWX-dJ3z5Cw-1
Received: by mail-lf1-f71.google.com with SMTP id b33-20020a0565120ba100b004720174b354so2576603lfv.19
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4t6uPyVuHpjP/C6GmCEBs1kfuz7CNChglQXTuEYXBLk=;
        b=C7lLBXnFnDc6N0dCySmUfWXpgf5tMpOeW2dG42CAyImcKIbsBv66SiNMqM/rN3gn81
         PMurofIfB/2zLyIgISCCa/4gM+NG2eb34M3VUCDV3RodUXUmQtjr/EQmytZQXVH7jbNX
         QvjsZxksBGc63+SKQOLz2czED2bxczejBtppGsoduCNKeILnxykiRzm0UqyRwJFjx+3e
         XVixPOMhWFUCTBTo33qIyQKUaX7uoPm0i5fq8PtBfSDO42MAL8oAmXMrx9W55HTv4iF4
         o0J5zcaPY16Q6bo0xW/P4ZItycSpUkeVWe/8lACiW+uVryZao6frPMTbwmXdyuGKHFPM
         P7eA==
X-Gm-Message-State: AOAM530qXcNQJZrZf7ll7YmAd5Z2OiO0kRl+7le1/0IpXX96F2j/XZpk
        Yz+3JkP2jCJ5E34VB5nBeMsyFgZi7z2pHqOzZwCfrNR2/sKSQK5q4S+MCdVoqUVBlR6MlEDOSXe
        h3IMHK1y0IhZx+ayu6fRTn3zsCa8C6br/w3+Dna3o
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id t10-20020a2e534a000000b0024af64fa1d6mr13632383ljd.315.1650952755615;
        Mon, 25 Apr 2022 22:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz49GsDEclRnoMEs5GA7S4rPqsU8SF034pgLLoI/IVoJBmiX3FJZzNnH+6wwRog7F/CxxvrsgdO23bRy8HkbUo=
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr13632375ljd.315.1650952755413; Mon, 25
 Apr 2022 22:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com> <20220425024418.8415-7-jasowang@redhat.com>
 <20220426053856.3325-1-hdanton@sina.com>
In-Reply-To: <20220426053856.3325-1-hdanton@sina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Apr 2022 13:59:04 +0800
Message-ID: <CACGkMEtM=Tb9LtYttj8MZ57sfThhLmU8m1-XF4iQGCcwZdPSmA@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     Hillf Danton <hdanton@sina.com>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:39 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 25 Apr 2022 10:44:15 +0800 Jason Wang wrote:
> > This patch tries to implement the synchronize_cbs() for ccw. For the
> > vring_interrupt() that is called via virtio_airq_handler(), the
> > synchronization is simply done via the airq_info's lock. For the
> > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > device spinlock for irq is introduced ans used in the synchronization
> > method.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index d35e7a3f7067..c19f07a82d62 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >       unsigned int revision; /* Transport revision */
> >       wait_queue_head_t wait_q;
> >       spinlock_t lock;
> > +     spinlock_t irq_lock;
> >       struct mutex io_lock; /* Serializes I/O requests */
> >       struct list_head virtqueues;
> >       bool is_thinint;
> > @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >       return dev_name(&vcdev->cdev->dev);
> >  }
> >
> > +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > +     struct airq_info *info = vcdev->airq_info;
> > +
> > +     /*
> > +      * Synchronize with the vring_interrupt() called by
> > +      * virtio_ccw_int_handler().
> > +      */
> > +     spin_lock(&vcdev->irq_lock);
> > +     spin_unlock(&vcdev->irq_lock);
>
> Given five lock acquirers, is the sync able to ensure the other four
> parties have complete their lock/unlock operations?

Just to make sure I understand the meaning of "four parties" here. It
looks to me the lock is only used in virtio_ccw_int_handler().

Thanks

>
> > +
> > +     if (info) {
> > +             /*
> > +              * Synchronize with the vring_interrupt() with airq indicator
> > +              */
> > +             write_lock(&info->lock);
> > +             write_unlock(&info->lock);
> > +     }
> > +}
> > +
> >  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .get_features = virtio_ccw_get_features,
> >       .finalize_features = virtio_ccw_finalize_features,
> > @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .find_vqs = virtio_ccw_find_vqs,
> >       .del_vqs = virtio_ccw_del_vqs,
> >       .bus_name = virtio_ccw_bus_name,
> > +     .synchronize_cbs = virtio_ccw_synchronize_cbs,
> >  };
> >
> >
> > @@ -1079,6 +1102,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  {
> >       __u32 activity = intparm & VIRTIO_CCW_INTPARM_MASK;
> >       struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > +     unsigned long flags;
> >       int i;
> >       struct virtqueue *vq;
> >
> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +     spin_lock_irqsave(&vcdev->irq_lock, flags);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
> > @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> >               vring_interrupt(0, vq);
> >       }
> > +     spin_unlock_irqrestore(&vcdev->irq_lock, flags);
> >       if (test_bit(0, indicators2(vcdev))) {
> >               virtio_config_changed(&vcdev->vdev);
> >               clear_bit(0, indicators2(vcdev));
> > @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
> >       init_waitqueue_head(&vcdev->wait_q);
> >       INIT_LIST_HEAD(&vcdev->virtqueues);
> >       spin_lock_init(&vcdev->lock);
> > +     spin_lock_init(&vcdev->irq_lock);
> >       mutex_init(&vcdev->io_lock);
> >
> >       spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> > --
> > 2.25.1
> >
> >
>

