Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1425758E0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbiHIUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbiHIUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB87255B6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660076211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYkeLySuoO63EbUsVhpOWeDjHFCcBc523fF2RaZ/lEI=;
        b=MdzPaxfHP1Q4pOuopHyA9s/gfq+LNpihTN5YeKyGv4AA8E1gfuAS6ZZDue7vDJdCj+8klU
        lEwBCeVRx0aZBg7NDhBhGHr+3fAz2fSyEkuNYEM7Ue8SvHNRGiEGuGDV7J+qeNOD44mU66
        9L1A6NfOR3keGKytSpXD+4N1qIEhLqc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-bb3bXEziPZa0OnUyK0w6Vw-1; Tue, 09 Aug 2022 16:16:50 -0400
X-MC-Unique: bb3bXEziPZa0OnUyK0w6Vw-1
Received: by mail-ed1-f69.google.com with SMTP id w5-20020a05640234c500b0043dda025648so7834515edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XYkeLySuoO63EbUsVhpOWeDjHFCcBc523fF2RaZ/lEI=;
        b=MZVFQgTq4ZXzwQEolDzCsOVcAcI1eDfcrIMOiNnS03jTqY4WiZjITQQl7blEaIoImW
         n7Wt4CnDNkGYW/TP7ehG2lJfuatdGgAdKkFjKTA9xN68j/1p/iZ398HJzlP9+bbQKgge
         YsTN3m/Qs5U8aOfmoouKFxn0zd4ucpouxngE3e1UGRjpQIeQU0/lgl2I7JeousUaDbqp
         vEcImCjvztV56WMg8221LBW+ARTksNwOkXVdCHXLL4PwfZ4e9NB5gmFWxEYaqg2VtcUd
         M8dYwgsQZ30cG6prTDasfxX3ymdGAuxQI4smldUePu4wJNNa5hsyf4GGwpMPNVHQ/FTt
         0NKg==
X-Gm-Message-State: ACgBeo1e2zYs0oKWADJvXmfrMSHwNxFTZpgs59udvQcsaFY+eNdbeHYc
        +OIb3dfLH4d1ZxLMSFob+/Za/uMc/gzrVVZr/6Rcm5G9l+EPL6+SF1pXVP4TltmCUgQrtzW5dmF
        6RQai2N5hfJWKp7a2AqcsSJVu
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr17888389ejc.170.1660076209030;
        Tue, 09 Aug 2022 13:16:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40FcDWCVKiWVQE/jialHJimTEIGYpSEUwJ3TAcfINgunPOgf2z6iQ3ExreeybMeYfgQLpt/Q==
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr17888366ejc.170.1660076208746;
        Tue, 09 Aug 2022 13:16:48 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709066bd000b007308bdef04bsm1481466ejs.103.2022.08.09.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:16:48 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:16:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        amit@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        akong@redhat.com, Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org,
        Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Message-ID: <20220809161554-mutt-send-email-mst@kernel.org>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
 <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
 <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
 <20220803073243-mutt-send-email-mst@kernel.org>
 <33f0f429-491c-49da-bd2e-bf9f62cb3efb@arm.com>
 <20220803083406-mutt-send-email-mst@kernel.org>
 <a18f9406-fdc5-130b-0460-eb5ad75d8876@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18f9406-fdc5-130b-0460-eb5ad75d8876@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:12:25PM +0100, Vladimir Murzin wrote:
> On 8/3/22 13:55, Michael S. Tsirkin wrote:
> > On Wed, Aug 03, 2022 at 01:25:15PM +0100, Vladimir Murzin wrote:
> >> On 8/3/22 12:39, Michael S. Tsirkin wrote:
> >>> On Wed, Aug 03, 2022 at 09:57:35AM +0100, Vladimir Murzin wrote:
> >>>> On 8/2/22 13:49, Vladimir Murzin wrote:
> >>>>> Hi Laurent,
> >>>>>
> >>>>> On 10/28/21 11:11, Laurent Vivier wrote:
> >>>>>> If we ensure we have already some data available by enqueuing
> >>>>>> again the buffer once data are exhausted, we can return what we
> >>>>>> have without waiting for the device answer.
> >>>>>>
> >>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>>>> ---
> >>>>>>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
> >>>>>>  1 file changed, 12 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> >>>>>> index 8ba97cf4ca8f..0a7dde135db1 100644
> >>>>>> --- a/drivers/char/hw_random/virtio-rng.c
> >>>>>> +++ b/drivers/char/hw_random/virtio-rng.c
> >>>>>> @@ -20,7 +20,6 @@ struct virtrng_info {
> >>>>>>          struct virtqueue *vq;
> >>>>>>          char name[25];
> >>>>>>          int index;
> >>>>>> -        bool busy;
> >>>>>>          bool hwrng_register_done;
> >>>>>>          bool hwrng_removed;
> >>>>>>          /* data transfer */
> >>>>>> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *vq)
> >>>>>>                  return;
> >>>>>>
> >>>>>>          vi->data_idx = 0;
> >>>>>> -        vi->busy = false;
> >>>>>>
> >>>>>>          complete(&vi->have_data);
> >>>>>>  }
> >>>>>>
> >>>>>> -/* The host will fill any buffer we give it with sweet, sweet randomness. */
> >>>>>> -static void register_buffer(struct virtrng_info *vi)
> >>>>>> +static void request_entropy(struct virtrng_info *vi)
> >>>>>>  {
> >>>>>>          struct scatterlist sg;
> >>>>>>
> >>>>>> +        reinit_completion(&vi->have_data);
> >>>>>> +        vi->data_avail = 0;
> >>>>>> +        vi->data_idx = 0;
> >>>>>> +
> >>>>>>          sg_init_one(&sg, vi->data, sizeof(vi->data));
> >>>>>>
> >>>>>>          /* There should always be room for one buffer. */
> >>>>>> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
> >>>>>>          memcpy(buf, vi->data + vi->data_idx, size);
> >>>>>>          vi->data_idx += size;
> >>>>>>          vi->data_avail -= size;
> >>>>>> +        if (vi->data_avail == 0)
> >>>>>> +                request_entropy(vi);
> >>>>>>          return size;
> >>>>>>  }
> >>>>>>
> >>>>>> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >>>>>>           * so either size is 0 or data_avail is 0
> >>>>>>           */
> >>>>>>          while (size != 0) {
> >>>>>> -                /* data_avail is 0 */
> >>>>>> -                if (!vi->busy) {
> >>>>>> -                        /* no pending request, ask for more */
> >>>>>> -                        vi->busy = true;
> >>>>>> -                        reinit_completion(&vi->have_data);
> >>>>>> -                        register_buffer(vi);
> >>>>>> -                }
> >>>>>> +                /* data_avail is 0 but a request is pending */
> >>>>>>                  ret = wait_for_completion_killable(&vi->have_data);
> >>>>>>                  if (ret < 0)
> >>>>>>                          return ret;
> >>>>>> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
> >>>>>>  {
> >>>>>>          struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> >>>>>>
> >>>>>> -        if (vi->busy)
> >>>>>> -                complete(&vi->have_data);
> >>>>>> +        complete(&vi->have_data);
> >>>>>>  }
> >>>>>>
> >>>>>>  static int probe_common(struct virtio_device *vdev)
> >>>>>> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
> >>>>>>                  goto err_find;
> >>>>>>          }
> >>>>>>
> >>>>>> +        /* we always have a pending entropy request */
> >>>>>> +        request_entropy(vi);
> >>>>>> +
> >>>>>>          return 0;
> >>>>>>
> >>>>>>  err_find:
> >>>>>> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *vdev)
> >>>>>>          vi->data_idx = 0;
> >>>>>>          complete(&vi->have_data);
> >>>>>>          vdev->config->reset(vdev);
> >>>>>> -        vi->busy = false;
> >>>>>>          if (vi->hwrng_register_done)
> >>>>>>                  hwrng_unregister(&vi->hwrng);
> >>>>>>          vdev->config->del_vqs(vdev);
> >>>>>
> >>>>> We observed that after this commit virtio-rng implementation in FVP doesn't
> >>>>> work
> >>>>>
> >>>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> >>>>> INFO: bp.virtio_rng: Using seed value: 0x5674bba8
> >>>>> Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid descriptor index
> >>>>> In file: (unknown):0
> >>>>> In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
> >>>>> Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer
> >>>>>
> >>>>> while basic baremetal test works as expected
> >>>>>
> >>>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> >>>>> INFO: bp.virtio_rng: Using seed value: 0x541c142e
> >>>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb377e6
> >>>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765ba62f7
> >>>>>
> >>>>> We are trying to get an idea what is missing and where, yet none of us familiar
> >>>>> with the driver :(
> >>>>>
> >>>>> I'm looping Kevin who originally reported that and Mauricio who is looking form
> >>>>> the FVP side.
> >>>>
> >>>> With the following diff FVP works agin
> >>>>
> >>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> >>>> index a6f3a8a2ac..042503ad6c 100644
> >>>> --- a/drivers/char/hw_random/virtio-rng.c
> >>>> +++ b/drivers/char/hw_random/virtio-rng.c
> >>>> @@ -54,6 +54,7 @@ static void request_entropy(struct virtrng_info *vi)
> >>>>         reinit_completion(&vi->have_data);
> >>>>         vi->data_avail = 0;
> >>>>         vi->data_idx = 0;
> >>>> +       smp_mb();
> >>>>
> >>>>         sg_init_one(&sg, vi->data, sizeof(vi->data));
> >>>>
> >>>>
> >>>> What do you reckon?
> >>>>
> >>>> Cheers
> >>>> Vladimir
> >>>
> >>> Thanks for debugging this!
> >>>
> >>> OK, interesting.
> >>>
> >>> data_idx and data_avail are accessed from virtio_read.
> >>>
> >>> Which as far as I can tell is invoked just with reading_mutex.
> >>>
> >>>
> >>> But, request_entropy is called from probe when device is registered
> >>> this time without locks
> >>> so it can trigger while another thread is calling virtio_read.
> >>>
> >>> Second request_entropy is called from a callback random_recv_done
> >>> also without locks.
> >>>
> >>> So it's great that smp_mb helped here but I suspect in fact we
> >>> need locking. Laurent?
> >>>
> >>
> >> I'm sorry for the noise, but it looks like I'm seeing issue for some different reasons.
> >> I manage to reproduce issue even with smb_mb() in place. The reason I though it helped
> >> is because I changed both environment and added smb_mb().
> >>
> >> Anyway, thank you for your time!
> >>
> >> Cheers
> >> Vladimir
> >
> > Well we at least have a race condition found by code review here. Here's
> > a quick hack attempting to fix it. I don't like it much since
> > it adds buffers with GFP_ATOMIC and kicks under a spinlock, but
> > for now we can at least test it. I did a quick build but that's
> > all, a bit rushed now sorry. Would appreciate knowing whether
> > this addresses the issue for you.
> >
> >
> > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > index a6f3a8a2aca6..36121c8d0315 100644
> > --- a/drivers/char/hw_random/virtio-rng.c
> > +++ b/drivers/char/hw_random/virtio-rng.c
> > @@ -23,6 +23,7 @@ struct virtrng_info {
> >       bool hwrng_register_done;
> >       bool hwrng_removed;
> >       /* data transfer */
> > +     spinlock_t lock;
> >       struct completion have_data;
> >       unsigned int data_avail;
> >       unsigned int data_idx;
> > @@ -37,6 +38,9 @@ struct virtrng_info {
> >  static void random_recv_done(struct virtqueue *vq)
> >  {
> >       struct virtrng_info *vi = vq->vdev->priv;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&vi->lock, flags);
> >
> >       /* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
> >       if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
> > @@ -45,20 +49,20 @@ static void random_recv_done(struct virtqueue *vq)
> >       vi->data_idx = 0;
> >
> >       complete(&vi->have_data);
> > +     spin_unlock_irqrestore(&vi->lock, flags);
> >  }
> >
> >  static void request_entropy(struct virtrng_info *vi)
> >  {
> >       struct scatterlist sg;
> >
> > -     reinit_completion(&vi->have_data);
> > -     vi->data_avail = 0;
> > +     BUG_ON(vi->data_avail != 0);
> >       vi->data_idx = 0;
> >
> >       sg_init_one(&sg, vi->data, sizeof(vi->data));
> >
> >       /* There should always be room for one buffer. */
> > -     virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> > +     virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_ATOMIC);
> >
> >       virtqueue_kick(vi->vq);
> >  }
> > @@ -70,8 +74,10 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
> >       memcpy(buf, vi->data + vi->data_idx, size);
> >       vi->data_idx += size;
> >       vi->data_avail -= size;
> > -     if (vi->data_avail == 0)
> > +     if (vi->data_avail == 0) {
> > +             reinit_completion(&vi->have_data);
> >               request_entropy(vi);
> > +     }
> >       return size;
> >  }
> >
> > @@ -81,18 +87,21 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >       struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> >       unsigned int chunk;
> >       size_t read;
> > +     unsigned long flags;
> >
> >       if (vi->hwrng_removed)
> >               return -ENODEV;
> >
> >       read = 0;
> >
> > +     spin_lock_irqsave(&vi->lock, flags);
> >       /* copy available data */
> >       if (vi->data_avail) {
> >               chunk = copy_data(vi, buf, size);
> >               size -= chunk;
> >               read += chunk;
> >       }
> > +     spin_unlock_irqrestore(&vi->lock, flags);
> >
> >       if (!wait)
> >               return read;
> > @@ -108,12 +117,14 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >               /* if vi->data_avail is 0, we have been interrupted
> >                * by a cleanup, but buffer stays in the queue
> >                */
> > +             spin_lock_irqsave(&vi->lock, flags);
> >               if (vi->data_avail == 0)
> >                       return read;
> >
> >               chunk = copy_data(vi, buf + read, size);
> >               size -= chunk;
> >               read += chunk;
> > +             spin_unlock_irqrestore(&vi->lock, flags);
> >       }
> >
> >       return read;
> > @@ -122,19 +133,25 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >  static void virtio_cleanup(struct hwrng *rng)
> >  {
> >       struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> > +     unsigned long flags;
> >
> > +     spin_lock_irqsave(&vi->lock, flags);
> >       complete(&vi->have_data);
> > +     spin_unlock_irqrestore(&vi->lock, flags);
> >  }
> >
> >  static int probe_common(struct virtio_device *vdev)
> >  {
> >       int err, index;
> >       struct virtrng_info *vi = NULL;
> > +     unsigned long flags;
> >
> >       vi = kzalloc(sizeof(struct virtrng_info), GFP_KERNEL);
> >       if (!vi)
> >               return -ENOMEM;
> >
> > +     spin_lock_init(&vi->lock);
> > +
> >       vi->index = index = ida_simple_get(&rng_index_ida, 0, 0, GFP_KERNEL);
> >       if (index < 0) {
> >               err = index;
> > @@ -162,7 +179,10 @@ static int probe_common(struct virtio_device *vdev)
> >       virtio_device_ready(vdev);
> >
> >       /* we always have a pending entropy request */
> > -     request_entropy(vi);
> > +     spin_lock_irqsave(&vi->lock, flags);
> > +     if (vi->data_avail == 0)
> > +             request_entropy(vi);
> > +     spin_unlock_irqrestore(&vi->lock, flags);
> >
> >       return 0;
> >
> >
> 
> Thanks a lot! I gave it a go and it did not help. I think I need to find out how exactly
> my environment affected... it not necessary need to be kernel related.

Okay ... I'll wait to hear your report then. You are saying maybe
there's no bug in kernel, something else changed in your environment?

-- 
MST

