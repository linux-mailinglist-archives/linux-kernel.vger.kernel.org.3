Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B984B1F50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbiBKHgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:36:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347691AbiBKHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1A610A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644564990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ger/QR3OvBDgrfELo9ni0SFpEHXgnOyBAkmgj/wgKo=;
        b=L+sv64hnZSTSpn/HRlX2IX50GMMDW+hzNToR4vRMLb+Cs1vJLIyLfcttRMG6OlYOU8s9LJ
        1ruuEjsLveQ5LChm2qQpBpI0U3P9M74fnrZemAEudEM/gSUDIyNUGa1MuMss+OrjiUUGqk
        Ru6FLRnP+n8GBVLTAmWESsWzcG0X3mo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-EBLXkU41MTmYrJqZf025cA-1; Fri, 11 Feb 2022 02:36:29 -0500
X-MC-Unique: EBLXkU41MTmYrJqZf025cA-1
Received: by mail-lj1-f200.google.com with SMTP id a13-20020a2eb54d000000b0023f5f64ae4fso3740325ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ger/QR3OvBDgrfELo9ni0SFpEHXgnOyBAkmgj/wgKo=;
        b=z7ZCUX6vRhQ7sTOzteOQwttimtcqJZ8bMwhIKdS5ZaBU/Mc0acjhzCYz/tG9PDJEF6
         PVB43SC7lKjcgJuuDvQfLBPWVY4mw9zcMLmqdZ+zXd7rvjDkHF1cp0bVE/fBduOW4oJX
         YgfQ3oHCkc6ZLQg5hEl3QE3keGAvhdFsk0Px+V3Igv5EY0SA3zm4+V3J2OVh2bEy87Lr
         OLAATT/xS2eXPX1dllMC0kPLlmbS/Wi23UP4jdQxyThZmmp36yb2bOIfHSh6mbwZsqaD
         Uglh2/COsTQL2cQ3CKgca5o23PBQDTWf/n/PpggaqZsi5z1EY1pWPljJCmxJ2h/sKbES
         wROg==
X-Gm-Message-State: AOAM5339GBtf0GH6IfZ2O+WxPoKlTXJ3cWbbPqwut5YNL6eYaDooWYyD
        7y8TenDREGt8NCSGXI2q0b9EpkQQ4HA/u7ztPcsCX4fJORtyeH2W57TFsChtlzob34MO9GiWzYz
        4HE2AAnZDRcbvpt5z+z1o611HKDc7FKAy7/182/Hr
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr338618lfp.580.1644564987358;
        Thu, 10 Feb 2022 23:36:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiq9kyvD4be5Fn1+/1LZaALFoATMR+JCZu8sTxPrafwqB0tr3RnE1Gwd2fhsEfOdiNhiDbr7hKgEwzFgtzIYo=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr338602lfp.580.1644564987072;
 Thu, 10 Feb 2022 23:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com> <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
 <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Feb 2022 15:36:15 +0800
Message-ID: <CACGkMEtzQFHZgMGe3-zg99bwdTB-X3-eo-AViDqXduoJb24d+w@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 3:13 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Fri, 11 Feb 2022 14:49:03 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> >
> > =E5=9C=A8 2022/2/9 =E4=B8=8B=E5=8D=888:28, Xuan Zhuo =E5=86=99=E9=81=93=
:
> > > Performing reset on a queue is divided into four steps:
> > >
> > > 1. reset_vq: reset one vq
> > > 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > > 3. release the ring of the vq by vring_release_virtqueue()
> > > 4. enable_reset_vq: re-enable the reset queue
> > >
> > > So add two callbacks reset_vq, enable_reset_vq to struct
> > > virtio_config_ops.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >   include/linux/virtio_config.h | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_con=
fig.h
> > > index 4d107ad31149..0d01a64f2576 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -74,6 +74,17 @@ struct virtio_shm_region {
> > >    * @set_vq_affinity: set the affinity for a virtqueue (optional).
> > >    * @get_vq_affinity: get the affinity for a virtqueue (optional).
> > >    * @get_shm_region: get a shared memory region based on the index.
> > > + * @reset_vq: reset a queue individually
> >
> >
> > This needs to be marked as optional I think.
>
> OK.
>
> >
> >
> > > + * vq: the virtqueue
> > > + * Returns 0 on success or error status
> >
> >
> > It looks to me the caller should also guarantee that the vring is not
> > accsed by any functions e.g NAPI.
>
> OK.
>
> >
> >
> > > + * After successfully calling this, be sure to call
> > > + * virtqueue_detach_unused_buf() to recycle the buffer in the ring, =
and
> > > + * then call vring_release_virtqueue() to release the vq ring.
> > > + * @enable_reset_vq: enable a reset queue
> > > + * vq: the virtqueue
> > > + * ring_num: specify ring num for the vq to be re-enabled. 0 means u=
se the
> > > + *           default value. MUST be a power of 2.
> >
> >
> > Note that we don't have power of 2 requirement for packed virtqueue.
>
>
> So the following check here does not seem reasonable. (virtio_pci_modern.=
c)

Rethink about this, looks like I was wrong.

Though packed virtqueue doesn't mandate power of 2, the actual queue
format should be invisible to a driver.

So forcing power of 2 is correct (since it was required by split virtqueue)

>
> static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>                                   struct virtio_pci_vq_info *info,
>                                   unsigned index,
>                                   void (*callback)(struct virtqueue *vq),
>                                   const char *name,
>                                   bool ctx,
>                                   u16 msix_vec)
> {
>
>         struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
>         struct virtqueue *vq;
>         u16 num;
>         int err;
>
>         if (index >=3D vp_modern_get_num_queues(mdev))
>                 return ERR_PTR(-ENOENT);
>
>         /* Check if queue is either not available or already active. */
>         num =3D vp_modern_get_queue_size(mdev, index);
>         if (!num || vp_modern_get_queue_enable(mdev, index))
>                 return ERR_PTR(-ENOENT);
>
>         if (num & (num - 1)) {
>                 dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num)=
;
>                 return ERR_PTR(-EINVAL);
>         }
>         ^^^^^^^^^^^^^^^^^^^^^^^
>
> >
> > And I wonder if it's cleaner to have a find_vq() ops instead to dealing
> > with the re-allocation and possible size change, or have a dedicated
> > helper to set vring size so driver can do.
> >
> > reset_vq()
> >
> > virtqueue_set_vring_size()
> >
> > enable_reset_vq()
>
> I like to add a dedicated helper.
>
> >
> >
> > > + * Returns 0 on success or error status
> > >    */
> > >   typedef void vq_callback_t(struct virtqueue *);
> > >   struct virtio_config_ops {
> > > @@ -100,6 +111,8 @@ struct virtio_config_ops {
> > >                     int index);
> > >     bool (*get_shm_region)(struct virtio_device *vdev,
> > >                            struct virtio_shm_region *region, u8 id);
> > > +   int (*reset_vq)(struct virtqueue *vq);
> > > +   int (*enable_reset_vq)(struct virtqueue *vq, u16 ring_num);
> >
> >
> > Note that the current implement is best-effort, so it's not guarantee
> > that we can have a vring with ring_num, we may get less under memory
> > pressure or even fail. We probably need to have a pamater to mandate th=
e
> > ring_num otherwise user may surprise to see a decreased size of the rin=
g
> > when a increasing is actually requested.
>
> 1. We can add a helper to specify max ring num.
> 2. Or after specifying ring num, in case of failure, return directly.
>
> I prefer #1

That's fine.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >   };
> > >
> > >   /* If driver didn't advertise the feature, it will never appear. */
> >
>

