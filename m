Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4152CDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiESIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiESICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C8A57171
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652947365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
        b=LHQMQSUHiRGj6vv9A4x+UN4aJUlN8/oDsWNhfyWtQkmYn625XTwbAD9M2iUO9/kbNohxXF
        YaxBus9WICDEOR3APB3zXxTJgD48lh5CG1GP43EuKHm1xpWNCjywRuaKMsl6WqIWH/6hxA
        sOr1mbEJMIr+d7zqDb78A1pANjybjIQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-LB1Wen_xMT61BggZBw1_KQ-1; Thu, 19 May 2022 04:02:43 -0400
X-MC-Unique: LB1Wen_xMT61BggZBw1_KQ-1
Received: by mail-lf1-f70.google.com with SMTP id bt27-20020a056512261b00b004779fd292b1so2303239lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
        b=EIF2TZYXYouSODIvLzce6H7vQimPthpukxyR54K16XCj41VNtEpzjGbbF7XCN8IXJx
         JyZ/U11S9Q36VV6Vc7fe2jp3AEfH2QOGz/ul9DyKK69Xz4jt6ZgGRl3uY9T/9Ne/2eFl
         HCkzhxDE9yb5Thy69m8smrqpiYrCH55NEckq+PFAsukLJ1nQoScoFLt+OzPoxUXgwmFf
         Hci7+4xMovRwQAQy5G4y37PkvWyK3pm2wiUIIba6KP4GV0yd83FiD86omboRXjs+Y0qE
         Ltxb6P0drRghDV+dSfajLrIoJXWt+YWns/LRLuxXWLLuzz7ru2+T17gFlMu6dnyEjLoP
         LR9Q==
X-Gm-Message-State: AOAM532bWSkuKuNZCdUD0FGiW/nyjK0B2zMsLZ5OPNzroZoO0V1O+NKe
        OCs1QrOCv8OHAUdlTzT/nkrkx75tMI3ZnN0rZIPEltOthS1wKagvC71q/H6/j7zVq6NBYJUNHFV
        5dVul6mSmQzm7C35BjXoqb3SLupK93t/nprgEa0fa
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr2463624lfa.210.1652947362301;
        Thu, 19 May 2022 01:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnED6RSEVAGwD+6jZQlEqqnkm9njtiJZnFEYibosooBXmmsa4+cJ2PSgTUPo3sWmsUgAZgWgEnJrDT+wPlxRw=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr2463601lfa.210.1652947362047; Thu, 19
 May 2022 01:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com> <20220518035951.94220-7-jasowang@redhat.com>
 <87tu9nfaoe.fsf@redhat.com>
In-Reply-To: <87tu9nfaoe.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 May 2022 16:02:30 +0800
Message-ID: <CACGkMEsiMQ7zDZ6r-q2W=yFqW8WbMEwUc8OFd+o1JzUL-E19Ew@mail.gmail.com>
Subject: Re: [PATCH V5 6/9] virtio-ccw: implement synchronize_cbs()
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

On Wed, May 18, 2022 at 5:32 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch tries to implement the synchronize_cbs() for ccw. For the
> > vring_interrupt() that is called via virtio_airq_handler(), the
> > synchronization is simply done via the airq_info's lock. For the
> > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > device rwlock is introduced ans used in the synchronization method.
>
> s/ans/and/
>

Will fix.

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
> >  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index d35e7a3f7067..22d36594bcdd 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >       unsigned int revision; /* Transport revision */
> >       wait_queue_head_t wait_q;
> >       spinlock_t lock;
> > +     rwlock_t irq_lock;
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
> > +     if (info) {
> > +             /*
> > +              * Synchronize with the vring_interrupt() with airq indicator
>
> Maybe
>
> /*
>  * This device uses adapter interrupts: synchronize with
>  * vring_interrupt() called by virtio_airq_handler() via the indicator
>  * area lock.
>  */
>

Fine.

> > +              */
> > +             write_lock_irq(&info->lock);
> > +             write_unlock_irq(&info->lock);
> > +     } else {
> > +             /*
> > +              * Synchronize with the vring_interrupt() called by
> > +              * virtio_ccw_int_handler().
>
> /*
>  * This device uses classic interrupts: synchronize with
>  * vring_interrupt() called by virtio_ccw_int_handler() via the
>  * per-device irq_lock.
>  */
>

Looks fine.

> > +              */
> > +             write_lock_irq(&vcdev->irq_lock);
> > +             write_unlock_irq(&vcdev->irq_lock);
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
> > @@ -1106,6 +1129,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +     /* Local interrupt should be disabled at this time */
>
> /* Interrupts are disabled here. */
>
> ?
>
> Interrupts enabled here would surely be a bug.

Right.

Thanks

>
> > +     read_lock(&vcdev->irq_lock);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
>

