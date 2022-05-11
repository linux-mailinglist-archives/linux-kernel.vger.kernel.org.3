Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082E1522F62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiEKJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiEKJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C2B2E5299
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652261280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehAdFMHQin7sBzIsjKPJMBNM1tNTUowv6Coiiw6E2YI=;
        b=bKKCg1m8r9y+gSruvmXUWmM9bQd7gUeWSwJ4cyCeE5kMK1sE79iAtWHBKmgyKdLmNsdEuO
        /+UZVlyZ6/Z2ATVDMJ3vDHHqUt9j2XXyv0QTG9cn0MuItUGTND3mQKxSe+9Tu/V48fcLxv
        M8YaiMo8PgiU97TbPh2ZowubOSlaVhg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-tDcr2LFbMRy9maZKk_mODQ-1; Wed, 11 May 2022 05:27:57 -0400
X-MC-Unique: tDcr2LFbMRy9maZKk_mODQ-1
Received: by mail-lf1-f71.google.com with SMTP id a13-20020a19ca0d000000b0047233f64994so584893lfg.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehAdFMHQin7sBzIsjKPJMBNM1tNTUowv6Coiiw6E2YI=;
        b=SVKcJFcUzaST8Ba+grHjZMtJcv4x2zbK0JVffH3iCGICX829JNt2qG5GbFnphrMhWh
         ar/TY0UYB+/GHFjrrCD59o73FtNOUOe3hJw61nRbkg0MKnaZQk6Xvg8GU4YI4iaVSmj6
         YTXGP7PlLKPjqzYGxIaPK2QNNlMdaTFq6gX4lAj7w/LX1zYHYUyAKTLxXhSGVEW9g2YK
         hXUF1KQuIZ6jh7YJgHLhA6F/EuRZLZwLPGIVmAXHmXAAE9yVcq7s2pi+kHmFPv+1Saro
         v6V3Q9E+8rP/HPro/RtaHcr7wNJ7sZPBUwQrVKQPhOhE9cgz+pL3INvNKJbBZP99qyTH
         FALA==
X-Gm-Message-State: AOAM530yl4f8zQsOhRGEk1RCEAkpiVI+whvF+lcaRxbq4eAK9XMclYct
        zSMq2Qav9bSYDiQijcE9CtcxkTL4L1mzwzMvqEgWATwe6WaUAvThyWTENBvyz3rmZNoAqFVfelK
        LTq4CsEp4V4X5cLwMeDUsxnf60QaClB/KW54/W57Q
X-Received: by 2002:a2e:b057:0:b0:24f:2668:833b with SMTP id d23-20020a2eb057000000b0024f2668833bmr16381999ljl.300.1652261276012;
        Wed, 11 May 2022 02:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5pnyy7RM02GVjjr25zdMxywsAUXwIZXeHQ+BpJH/yZ8wlAwtqIUV0+RNxrlNjUJdUnXcetv7Su7hXh9EzXk4=
X-Received: by 2002:a2e:b057:0:b0:24f:2668:833b with SMTP id
 d23-20020a2eb057000000b0024f2668833bmr16381981ljl.300.1652261275822; Wed, 11
 May 2022 02:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org> <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
 <87o804bgrl.fsf@redhat.com>
In-Reply-To: <87o804bgrl.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 17:27:44 +0800
Message-ID: <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
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

On Wed, May 11, 2022 at 4:44 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> >> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> > index d8a2340f928e..23f1694cdbd5 100644
> >> > --- a/include/linux/virtio_config.h
> >> > +++ b/include/linux/virtio_config.h
> >> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> >> >       unsigned status = dev->config->get_status(dev);
> >> >
> >> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >> > +
> >> > +     /*
> >> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >> > +      * will see the driver specific setup if it sees vq->broken
> >> > +      * as false.
> >> > +      */
> >> > +     virtio_synchronize_cbs(dev);
> >>
> >> since you mention vq->broken above, maybe add
> >>         "set vq->broken to false"
> >
> > Ok.
> >
> >>
> >> > +     __virtio_unbreak_device(dev);
> >> > +     /*
> >> > +      * The transport is expected ensure the visibility of
> >>
> >> to ensure
> >
> > Will fix.
> >
> >>
> >> > +      * vq->broken
> >>
> >> let's add: "visibility by vq callbacks"
> >
> > Sure.
> >
> >>
> >> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> >> > +      */
> >>
> >>
> >> Can I see some analysis of existing transports showing
> >> this is actually the case for them?
> >
> > Yes.
> >
> >> And maybe add a comment near set_status to document the
> >> requirement.
> >
> > For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> > wmb() is not needed before the MMIO writel().
> > For CCW, it looks not obvious, it looks to me the IO was submitted via
> > __ssch() which has an inline assembly.  Cornelia and Hali, could you
> > help me to understand if and how did virtio_ccw_set_status() can
> > ensure the visibility of the previous driver setup and vq->broken
> > here?
>
> I'm not sure I completely understand the question here, but let me try:

It's something like the following case:

CPU 0: vq->broken = false
CPU 0: set_status(DRIVER_OK)
CPU 1: vring_interrupt() { if (vq->broken) return IRQ_NONE; }

We need to make sure the CPU 1 sees the vq->broken if the interrupt is
raised after DRVER_OK.

For PCI, we use MMIO of writel() for set_status(), a wmb() is not
needed in this case according to memory-barriers.txt.

"
Note that, when using writel(), a prior
wmb() is not needed to guarantee that the cache coherent memory writes
have completed before writing to the MMIO region.
"

So CPU 1 will see the broken as false.

>
> virtio_ccw_set_status() uses a channel command to set the status, with
> the interesting stuff done inside ccw_io_helper(). That function
> - takes the subchannel lock, disabling interrupts

Then it is, for x86 the operation to disable interrupt is a full
barrier. I guess this should apply to other architecture like s390. I
see a stnsm is used in this case but a quick google doesn't tell me if
it's a barrier.
If this is true. The vring_interrupt will see broken as false.

> - does the ssch; this instruction will fail if there's already another
>   I/O in progress, or an interrupt is pending for the subchannel; on
>   success, it is guaranteed that we'll get an interrupt eventually

I guess ssch might imply a barrier as well, otherwise we may need a
lot of barriers before this.

Thanks

> - unlock the subchannel, and wait for the interupt handler to eventually
>   process the interrupt, so I guess it should see the vq->broken value?
>
> If the I/O fails, virtio_ccw_set_status() will revert its internal
> status to the old value.
>
>
> >
> > Thanks
> >
> >>
> >> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >> >  }
>

