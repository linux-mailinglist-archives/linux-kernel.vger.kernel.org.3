Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A5524366
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiELD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiELD1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D8E4D612
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652326065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lVQIk7XWLCbb+j6Gb7OWizoocgmR8cWGvz7hpNAv2/Y=;
        b=Yvnpu5ZDMTX3tPhHTqcv5vMBqhD1JmYluNxdD2tZ59p/2OALdSlhD9WMNz+KURJJgqt4wj
        DDqr+Gap0BvCA6l9DP77teYO7GQ3UWKWcsC5pZBMqgKcAWGsrLrnKAN7SmI/y4hbDTDAU9
        +fzbuiQL4KV2qdPw/POX6u3RBtIHL0w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-gYifcmv5M4SP-Ruk2PEWEw-1; Wed, 11 May 2022 23:27:44 -0400
X-MC-Unique: gYifcmv5M4SP-Ruk2PEWEw-1
Received: by mail-lf1-f69.google.com with SMTP id i8-20020a0565123e0800b004725f87c5f2so1629503lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVQIk7XWLCbb+j6Gb7OWizoocgmR8cWGvz7hpNAv2/Y=;
        b=qo7YdHrBH8of0J6KJ28z98coM227g/GVAQ/4qN0LLy0HvzDRqKFHL2oY6SPLL+YnEQ
         Qw44tvxeioOBKfSwSkr0fEHOGLf0u23S3yyP5eFD+4LB40uM7Xzu9ax93wS6GzIL2Pnq
         gq4Ap3SRJ/k8+1FIQzOjSZ1+RcpfjeSD/gz3mJYSJeL83UmA+Jyo3C5+GRO99eIrLnsM
         Bt+gBJIWTHkGFQb/Z8brhNu14xKGrI4Tj8+GMGvCY+9AbvSpdjHXRuEpGW0w4DTVvq2o
         eKt2oULF23jPplDrcWuMGMvSWVgyncoOMPDGu9KFgk39p2Rd64yPZ07GK20ea99QSIuX
         5Gww==
X-Gm-Message-State: AOAM532ElfLCz5LgkPX+A5WN6cmunlRxDAD2KXCKxr4rxdpNJ6H79/9R
        bjkCF73n9X7lpKDp2zY1jaZtZV2YnRvs0KBZf/R0Uof3cahSqSRoWJ7Z6HlhIOv2Ts5B0yaZifn
        FBxwpKfk5HuCEtOrBTe+di4Y0tWN5F+QFdMfWDsPa
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id e20-20020ac24e14000000b004741f4d9b86mr15637826lfr.257.1652326062914;
        Wed, 11 May 2022 20:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxStChmH/rVzb4XHKdnq3dQVyoUrB/39XSF0wz703iGtewPdHYj/3MruOM+2TroG/vmJKeEXh+tUmqyP34HsmQ=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr15637813lfr.257.1652326062677; Wed, 11
 May 2022 20:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org> <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
 <87o804bgrl.fsf@redhat.com> <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
 <20220511144915.02efda98.pasic@linux.ibm.com>
In-Reply-To: <20220511144915.02efda98.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 11:27:31 +0800
Message-ID: <CACGkMEuiA1Q9Z4aXKj51y8Ad+caLkrG_NvLcQvwMfnpWQ7kjzA@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>, eperezma <eperezma@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
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

On Wed, May 11, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 11 May 2022 17:27:44 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On Wed, May 11, 2022 at 4:44 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > > On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >>
> > > >> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> > > >> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > >> > index d8a2340f928e..23f1694cdbd5 100644
> > > >> > --- a/include/linux/virtio_config.h
> > > >> > +++ b/include/linux/virtio_config.h
> > > >> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> > > >> >       unsigned status = dev->config->get_status(dev);
> > > >> >
> > > >> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > >> > +
> > > >> > +     /*
> > > >> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > >> > +      * will see the driver specific setup if it sees vq->broken
> > > >> > +      * as false.
> > > >> > +      */
> > > >> > +     virtio_synchronize_cbs(dev);
> > > >>
> > > >> since you mention vq->broken above, maybe add
> > > >>         "set vq->broken to false"
> > > >
> > > > Ok.
> > > >
> > > >>
> > > >> > +     __virtio_unbreak_device(dev);
> > > >> > +     /*
> > > >> > +      * The transport is expected ensure the visibility of
> > > >>
> > > >> to ensure
> > > >
> > > > Will fix.
> > > >
> > > >>
> > > >> > +      * vq->broken
> > > >>
> > > >> let's add: "visibility by vq callbacks"
> > > >
> > > > Sure.
> > > >
> > > >>
> > > >> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> > > >> > +      */
> > > >>
> > > >>
> > > >> Can I see some analysis of existing transports showing
> > > >> this is actually the case for them?
> > > >
> > > > Yes.
> > > >
> > > >> And maybe add a comment near set_status to document the
> > > >> requirement.
> > > >
> > > > For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> > > > wmb() is not needed before the MMIO writel().
> > > > For CCW, it looks not obvious, it looks to me the IO was submitted via
> > > > __ssch() which has an inline assembly.  Cornelia and Hali, could you
> > > > help me to understand if and how did virtio_ccw_set_status() can
> > > > ensure the visibility of the previous driver setup and vq->broken
> > > > here?
> > >
> > > I'm not sure I completely understand the question here, but let me try:
> >
> > It's something like the following case:
> >
> > CPU 0: vq->broken = false
> > CPU 0: set_status(DRIVER_OK)
> > CPU 1: vring_interrupt() { if (vq->broken) return IRQ_NONE; }
> >
> > We need to make sure the CPU 1 sees the vq->broken if the interrupt is
> > raised after DRVER_OK.
> >
> > For PCI, we use MMIO of writel() for set_status(), a wmb() is not
> > needed in this case according to memory-barriers.txt.
> >
> > "
> > Note that, when using writel(), a prior
> > wmb() is not needed to guarantee that the cache coherent memory writes
> > have completed before writing to the MMIO region.
> > "
>
>
> IMHO the key facts here are the following:
> * ssch and all other I/O instructions are serializing instructions
> * all interruptions are serializing operations
>
> For reference see
> https://www.ibm.com/resources/publications/OutputPubsDetails?PubID=SA22783213
> page 5-138.

I see thanks for the pointer.

>
>
> Maybe we should add that to the linux documentation somewhere if
> not already mentioned.

Maybe somewhere in memory-barriers.txt.

>
> So IMHO we don't need CPU0 to do a wmb() because of the ssch.
>

Right.

> >
> > So CPU 1 will see the broken as false.
>
> But barriers need to be paired.

Yes, actually the pairing is done by the device where it need something like:

if (get_status(DRIVER_OK)) {
    rmb();
    start_device_logic();
    raise_interrupt();
}

> And in my understanding the ssch
> doesn't really ensure that CPU1 is about to see the change, unless
> there is a suitable barrier that pairs with the barrier implied
> the ssch instruction.
>
> Assumed vring_interrupt() is always done in hard-irq context, AFAIU,
> we should be fine. Is that assumption correct?
>
> Why are we fine:
> * Either the ssch was performed before the interrupt for
>   vring_interrupt() got delivered on CPU1, and then we are guaranteed to
>   see the updated value for vq->broken,

Yes, for a well behaved device, the device will raise the interrupt
after it sees DRIVER_OK and the ssch guarantees that when the device
sees DRIVER_OK vq->broken is false.

> * or the interrupt that triggered vring_interrupt() was delivered before
>   the ssch instruction got executed. But in this case it is fine to
>   ignore the notification, because this is actually the bad case
>   we want to guard against: we got a notification when
>   notifications are not allowed.

Exactly.

>
> We may end up with !vq->broken and !DEVICE_OK as well, but that should
> be fine because, although that notification would be a should not happen
> one, I understand it would not catch us with our pants down.

Right.

>
> Regards,
> Halil
>
>
> >
> > >
> > > virtio_ccw_set_status() uses a channel command to set the status, with
> > > the interesting stuff done inside ccw_io_helper(). That function
> > > - takes the subchannel lock, disabling interrupts
> >
> > Then it is, for x86 the operation to disable interrupt is a full
> > barrier. I guess this should apply to other architecture like s390. I
> > see a stnsm is used in this case but a quick google doesn't tell me if
> > it's a barrier.

Looks like it's not a serialization instruction and this
memory-barriers.rst told me irq-disabling is only a compiler barrier:

"""
Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
(RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
barriers are required in such a situation, they must be provided from some
other means.
"""

Thanks

> > If this is true. The vring_interrupt will see broken as false.
> >
> > > - does the ssch; this instruction will fail if there's already another
> > >   I/O in progress, or an interrupt is pending for the subchannel; on
> > >   success, it is guaranteed that we'll get an interrupt eventually
> >
> > I guess ssch might imply a barrier as well, otherwise we may need a
> > lot of barriers before this.
> >
> > Thanks
> >
> > > - unlock the subchannel, and wait for the interupt handler to eventually
> > >   process the interrupt, so I guess it should see the vq->broken value?
> > >
> > > If the I/O fails, virtio_ccw_set_status() will revert its internal
> > > status to the old value.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >>
> > > >> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > >> >  }
> > >
> >
>

