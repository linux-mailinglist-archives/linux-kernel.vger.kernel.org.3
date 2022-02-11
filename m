Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC704B1F87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiBKHqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:46:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiBKHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 171392A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644565561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/blf6IlFCiwMIlX6anj8mtrKZzMQn5bOMuNh13XU7xI=;
        b=YnSME+1CNMabYQ+/TU3FGgAjokrqXwee1J2vne1L5FPC3V2139F2qPfrFBDNvXoMIvM8W6
        9yPGfnKby+Iqos3+Tjk43E/GQmKcvKllj4IzE381sEWjP8JTirV0XRa9nFgEd2x+xoigkk
        o2D4JTVmd0Te8GcMrgTITW2s9NW1b7E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-V4lipOF-PKefzRzsGYDcwA-1; Fri, 11 Feb 2022 02:46:00 -0500
X-MC-Unique: V4lipOF-PKefzRzsGYDcwA-1
Received: by mail-lj1-f199.google.com with SMTP id 184-20020a2e05c1000000b0023a30a97e36so3732037ljf.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/blf6IlFCiwMIlX6anj8mtrKZzMQn5bOMuNh13XU7xI=;
        b=IRG/heX6bVyc0O+1rLRqABSwpXr6Cv2WwUL0/6pa7FF0kP5gbjoyMsG2MAcrdTvkUx
         cuvkJzmJL5G69VcB4Pu5BaWyC3jMBJtzXh7y5Bgem1905ZivSAqA7jzrVltfCvhe/2Ge
         RrdI2Zsd/7tEO+vSDLUN3DkGx1DJ89n2Ck4DTc/rRFJZdhKS1lIc7hVgLz0TTUw01tTo
         2syEaIuGdBf6s7eSwY+5lebOuHTpKAAAxWdCRtnwBDDfUxW7ZDE5ESuA5ihshoF7Mz2E
         1TLZ96w2ZbQ+FM0x9h96sH6jZeUJH/zKkOXXr1f/8CiJsZ+DT9FYWI33ItReicsKaWVk
         1aTg==
X-Gm-Message-State: AOAM531OFQ/Gpo368NKapRqjuDfr9fIMkbaigkUbST9MMKWQUp5K/U33
        enaRDEqbnr5o7gjbmGTFMcEPtUz/8QeaCGYEIqKxEfAgWDkC6Qx78shIKyTxRyduixpjP9KmwP6
        oPRWDsxmDa1eE76BBo1K1rpXiMpMk4efc02uLSvqu
X-Received: by 2002:a05:6512:3d8d:: with SMTP id k13mr349184lfv.481.1644565558362;
        Thu, 10 Feb 2022 23:45:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ9KCiVORJ/mE3wfXfdvwvzykLBtlN3JaCqemtEmXorgeYZA6+7UEHf0CY25mJsSLR7+52cR8cYsFhCF825VE=
X-Received: by 2002:a05:6512:3d8d:: with SMTP id k13mr349176lfv.481.1644565558112;
 Thu, 10 Feb 2022 23:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-15-xuanzhuo@linux.alibaba.com> <8b0b5f06-74eb-d6cb-07e2-38249e4cda92@redhat.com>
 <1644564073.3777697-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644564073.3777697-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Feb 2022 15:45:46 +0800
Message-ID: <CACGkMEv4560JKv7UM6v6rADNMbhTv-86KJebAwYebFOkUndnPg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
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

On Fri, Feb 11, 2022 at 3:24 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Fri, 11 Feb 2022 15:05:40 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> >
> > =E5=9C=A8 2022/2/9 =E4=B8=8B=E5=8D=888:29, Xuan Zhuo =E5=86=99=E9=81=93=
:
> > > This patch implements virtio pci support for QUEUE RESET.
> > >
> > > Performing reset on a queue is divided into these steps:
> > >
> > > 1. reset_vq: reset one vq
> > > 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > > 3. release the ring of the vq by vring_release_virtqueue()
> > > 4. enable_reset_vq: re-enable the reset queue
> > >
> > > This patch implements reset_vq, enable_reset_vq in the pci scenario
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >   drivers/virtio/virtio_pci_common.c |  8 +--
> > >   drivers/virtio/virtio_pci_modern.c | 80 +++++++++++++++++++++++++++=
+--
> > >   drivers/virtio/virtio_ring.c       |  2 +
> > >   include/linux/virtio.h             |  1 +
> > >   4 files changed, 85 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virt=
io_pci_common.c
> > > index cb01eb0cb2e4..303637ac4914 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
> > >     struct virtio_pci_vq_info *info =3D vp_dev->vqs[vq->index];
> > >     unsigned long flags;
> > >
> > > -   spin_lock_irqsave(&vp_dev->lock, flags);
> > > -   list_del(&info->node);
> > > -   spin_unlock_irqrestore(&vp_dev->lock, flags);
> > > +   if (!vq->reset) {
> > > +           spin_lock_irqsave(&vp_dev->lock, flags);
> > > +           list_del(&info->node);
> > > +           spin_unlock_irqrestore(&vp_dev->lock, flags);
> > > +   }
> > >
> > >     vp_dev->del_vq(info);
> > >     kfree(info);
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virt=
io_pci_modern.c
> > > index d29d40bf0b45..cc45515eda50 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_dev=
ice *vdev, u64 features)
> > >     if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> > >                     pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_S=
RIOV))
> > >             __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > > +
> > > +   if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > > +           __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> > >   }
> > >
> > >   /* virtio config->finalize_features() implementation */
> > > @@ -176,6 +179,70 @@ static void vp_reset(struct virtio_device *vdev)
> > >     vp_disable_cbs(vdev);
> > >   }
> > >
> > > +static int vp_modern_reset_vq(struct virtqueue *vq)
> > > +{
> > > +   struct virtio_pci_device *vp_dev =3D to_vp_device(vq->vdev);
> > > +   struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
> > > +   struct virtio_pci_vq_info *info;
> > > +   unsigned long flags;
> > > +   u16 msix_vec;
> > > +
> > > +   if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> > > +           return -ENOENT;
> > > +
> > > +   vp_modern_set_queue_reset(mdev, vq->index);
> > > +
> > > +   info =3D vp_dev->vqs[vq->index];
> > > +   msix_vec =3D info->msix_vector;
> > > +
> > > +   /* Disable VQ callback. */
> > > +   if (vp_dev->per_vq_vectors && msix_vec !=3D VIRTIO_MSI_NO_VECTOR)
> > > +           disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> >
> >
> > I think we need a comment to explain why per_vq_mode needs to be dealt
> > with differently.
>
> OK.
>
> >
> >
> > > +
> > > +   /* delete vq */
> > > +   spin_lock_irqsave(&vp_dev->lock, flags);
> > > +   list_del(&info->node);
> > > +   spin_unlock_irqrestore(&vp_dev->lock, flags);
> >
> >
> > So I don't see where vring is freed and vp_setup_vq() may try to
> > allocate new memory, won't it be a memory leak in this case?
>
> 1. reset_vq: reset one vq
> 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> 3. release the ring of the vq by vring_release_virtqueue()
> 4. enable_reset_vq: re-enable the reset queue
>
> vring_release_virtqueue() (#8 patch) will release the vring.
> That is called by the driver.
>
> I think I should add a check to vp_modern_enable_reset_vq() that
> vring_release_virtqueue() has already been called.

I wonder if we can have a better API.

Consider we know there's a requirement of vring re-allocation. I
wonder how about adding per vq config ops like:

del_vq()
find_vq()

We can limit them only after a virtqueue is reset before it is
enabled. We can have a full allocation on the resources e.g interrupt
(if some codes could be reused).

Then a driver can do
reset_vq()
detach_unused_buf()
del_vq
find_vq() /* with new parameters like ring_num and others like find_vqs() *=
/
enable_reset_vq()

?

Thanks

>
> Thanks
>
> >
> > Thanks
> >
> >
> > > +
> > > +   vq->reset =3D true;
> > > +
> > > +   INIT_LIST_HEAD(&info->node);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int vp_modern_enable_reset_vq(struct virtqueue *vq, u16 ring_=
num)
> > > +{
> > > +   struct virtio_pci_device *vp_dev =3D to_vp_device(vq->vdev);
> > > +   struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
> > > +   struct virtio_pci_vq_info *info;
> > > +   struct virtqueue *_vq;
> > > +   u16 msix_vec;
> > > +
> > > +   if (!vq->reset)
> > > +           return -EPERM;
> > > +
> > > +   /* check queue reset status */
> > > +   if (vp_modern_get_queue_reset(mdev, vq->index) !=3D 1)
> > > +           return -EBUSY;
> > > +
> > > +   info =3D vp_dev->vqs[vq->index];
> > > +   _vq =3D vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
> > > +                    info->msix_vector, ring_num);
> > > +   if (IS_ERR(_vq)) {
> > > +           vq->reset =3D true;
> > > +           return PTR_ERR(_vq);
> > > +   }
> > > +
> > > +   vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > > +
> > > +   msix_vec =3D vp_dev->vqs[vq->index]->msix_vector;
> > > +   if (vp_dev->per_vq_vectors && msix_vec !=3D VIRTIO_MSI_NO_VECTOR)
> > > +           enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >   static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 v=
ector)
> > >   {
> > >     return vp_modern_config_vector(&vp_dev->mdev, vector);
> > > @@ -231,10 +298,13 @@ static struct virtqueue *setup_vq(struct virtio=
_pci_device *vp_dev,
> > >                             virtqueue_get_avail_addr(vq),
> > >                             virtqueue_get_used_addr(vq));
> > >
> > > -   vq->priv =3D (void __force *)vp_modern_map_vq_notify(mdev, index,=
 NULL);
> > >     if (!vq->priv) {
> > > -           err =3D -ENOMEM;
> > > -           goto err_map_notify;
> > > +           vq->priv =3D (void __force *)vp_modern_map_vq_notify(mdev=
, index,
> > > +                                                              NULL);
> > > +           if (!vq->priv) {
> > > +                   err =3D -ENOMEM;
> > > +                   goto err_map_notify;
> > > +           }
> >
> >
> > This seems unrelated or an artifact of previous patches?
> >
> > Thanks
> >
> >
> > >     }
> > >
> > >     if (msix_vec !=3D VIRTIO_MSI_NO_VECTOR) {
> > > @@ -402,6 +472,8 @@ static const struct virtio_config_ops virtio_pci_=
config_nodev_ops =3D {
> > >     .set_vq_affinity =3D vp_set_vq_affinity,
> > >     .get_vq_affinity =3D vp_get_vq_affinity,
> > >     .get_shm_region  =3D vp_get_shm_region,
> > > +   .reset_vq        =3D vp_modern_reset_vq,
> > > +   .enable_reset_vq =3D vp_modern_enable_reset_vq,
> > >   };
> > >
> > >   static const struct virtio_config_ops virtio_pci_config_ops =3D {
> > > @@ -420,6 +492,8 @@ static const struct virtio_config_ops virtio_pci_=
config_ops =3D {
> > >     .set_vq_affinity =3D vp_set_vq_affinity,
> > >     .get_vq_affinity =3D vp_get_vq_affinity,
> > >     .get_shm_region  =3D vp_get_shm_region,
> > > +   .reset_vq        =3D vp_modern_reset_vq,
> > > +   .enable_reset_vq =3D vp_modern_enable_reset_vq,
> > >   };
> > >
> > >   /* the PCI probing function */
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index b8747df8dc1f..4f6028e1e2d9 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1731,6 +1731,7 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >     vq->vq.vdev =3D vdev;
> > >     vq->vq.num_free =3D num;
> > >     vq->vq.index =3D index;
> > > +   vq->vq.reset =3D false;
> > >     vq->we_own_ring =3D true;
> > >     vq->notify =3D notify;
> > >     vq->weak_barriers =3D weak_barriers;
> > > @@ -2220,6 +2221,7 @@ static int __vring_init_virtqueue(struct virtqu=
eue *_vq,
> > >     vq->vq.vdev =3D vdev;
> > >     vq->vq.num_free =3D vring.num;
> > >     vq->vq.index =3D index;
> > > +   vq->vq.reset =3D false;
> > >     vq->we_own_ring =3D false;
> > >     vq->notify =3D notify;
> > >     vq->weak_barriers =3D weak_barriers;
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index dd1657c3a488..5d4817d79f3f 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -32,6 +32,7 @@ struct virtqueue {
> > >     unsigned int index;
> > >     unsigned int num_free;
> > >     void *priv;
> > > +   bool reset;
> > >   };
> > >
> > >   int virtqueue_add_outbuf(struct virtqueue *vq,
> >
>

