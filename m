Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C67522A09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiEKCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiEKCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A625A4C40E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652236930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nGkvcvFWz+odk5yhwLYeDyIG2eWn1ClUMoDKPyJdBk=;
        b=GSklQrxnk4oJqeDhQkPUD4cW23eZuuXShA899Dudk4vcn4NGUx345Z3ONrM4+Xxs8moKOH
        vDEDUQZ+NE4rqNmgnf5VLjTA74b/gjIGl3jLOWASkp56OHnfsQDvJZOXiyX9v2BORLN+kh
        0qwnPRjlCou9+hlQcglU02xbpF7mZKo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-hiCtTezCPaWz2zOrOMD6CA-1; Tue, 10 May 2022 22:42:09 -0400
X-MC-Unique: hiCtTezCPaWz2zOrOMD6CA-1
Received: by mail-lf1-f71.google.com with SMTP id x36-20020a056512132400b0044b07b24746so287203lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nGkvcvFWz+odk5yhwLYeDyIG2eWn1ClUMoDKPyJdBk=;
        b=ZSP/eMlFHtc8446fN1uO3aHximkgn9+u/NUhYjf0iEScSwoVQzxmwWeoJHKKuI3gD8
         kLF17UzLWaaCWIk0KtTjhBES1vsINIJrn8LTqAY3ied0bKKOW/bxfqBb5jbsZb+WCLC/
         crCQH1Tq32uRRNyHkKVv6S4m5lUYI+lcyRyBQnn3oimS8hURSAUv6kK9sUiC7IrIc3MP
         jdU0cqfc3vXfjVoAs0b6OArlnWoTJEX39CtoRIsviQktSGcDJcTWUxjL3ffC6wytRmP4
         FfSuHs69iNXGdhLYacoE3KSkTAVW6vB2HdoG/FhcRvnfaz09e1b8ZmErgDugo/WF/g++
         2zLA==
X-Gm-Message-State: AOAM530nm0B8MHmLwxWBU1RFn8j63FD+8V7W4P4jE2VQ6dkAZu0egNA2
        qKxdu17YKePREggLimtMPtxfm5vxUFmK1vbqRB7otNjhPMO5C+kUC1VS0JvZLEQ5rnS3XSoaeX/
        Sjjco5FDUHXypTuLmA3dBPcV9AlN3uKki42S7+066
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr18230633lfj.587.1652236927983;
        Tue, 10 May 2022 19:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHTIitvlKBo9gntoR+9nuIVQxt66PfDgGM8uDAMiSrYJWVeqcsjWShA2gwMUq9hVPezrkTWEGfgTI37LaNx88=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18230621lfj.587.1652236927813; Tue, 10
 May 2022 19:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510072451-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 10:41:56 +0800
Message-ID: <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
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

On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
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
> > index d35e7a3f7067..001e1f0e6037 100644
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
> > +              */
> > +             write_lock(&info->lock);
> > +             write_unlock(&info->lock);
> > +     } else {
> > +             /*
> > +              * Synchronize with the vring_interrupt() called by
> > +              * virtio_ccw_int_handler().
> > +              */
> > +             write_lock(&vcdev->irq_lock);
> > +             write_unlock(&vcdev->irq_lock);
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
> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
>
> Cornelia sent a lockdep trace on this.
>
> Basically I think this gets the irqsave/restore logic wrong.
> It attempts to disable irqs in the handler (which is an interrupt
> anyway).

The reason I use irqsave/restore is that it can be called from process
context (if I was not wrong), e.g from io_subchannel_quiesce().

> And it does not disable irqs in the synchronize_cbs.
>
> As a result in interrupt might try to take a read lock while
> .synchronize_cbs has the writer lock, resulting in a deadlock.
>
> I think you want regular read_lock + write_lock_irq.

Yes.

Thanks

>
>
> > @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> >               vring_interrupt(0, vq);
> >       }
> > +     read_unlock_irqrestore(&vcdev->irq_lock, flags);
> >       if (test_bit(0, indicators2(vcdev))) {
> >               virtio_config_changed(&vcdev->vdev);
> >               clear_bit(0, indicators2(vcdev));
> > @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
> >       init_waitqueue_head(&vcdev->wait_q);
> >       INIT_LIST_HEAD(&vcdev->virtqueues);
> >       spin_lock_init(&vcdev->lock);
> > +     rwlock_init(&vcdev->irq_lock);
> >       mutex_init(&vcdev->io_lock);
> >
> >       spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> > --
> > 2.25.1
>

