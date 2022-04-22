Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45750B081
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444321AbiDVG0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444308AbiDVG0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2722A506C3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650608598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpiO1BWqUyIoEMWKXbDQvoPMDAtjYvoj7pyt+z9H/U8=;
        b=Bsh2i2/Fon7YG7zkghx347XrlqMUlcbLsMVU1yIQ5QTN4DScDohfVg/jQq8Lh9yapDkcsD
        j2KLR5n52DlCwchra2v7yNK6CIV3bahPwuKal6bzCGh5zX8QUKK/zcdEQOcG8ZYET5eIYL
        U/DAu3dam/1zQNK5LtSZOG9h5m8ILIw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176--_ZNjDNgPVWmuLXRGIoc1w-1; Fri, 22 Apr 2022 02:23:10 -0400
X-MC-Unique: -_ZNjDNgPVWmuLXRGIoc1w-1
Received: by mail-lj1-f198.google.com with SMTP id c12-20020a2ebf0c000000b0024af8f2794bso2050863ljr.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kpiO1BWqUyIoEMWKXbDQvoPMDAtjYvoj7pyt+z9H/U8=;
        b=Rf1/IKY2+EyTuv+viVwqaoXYbShgqW5v2VBSUrcmwjxnqthOg79SES0DY+5xv/M+id
         gQNgpvI7qR9VfwZmnjduGPz5ELUENvogsEqB7Yn6X47dABQArUrmLnHw+U6G8dd21L/8
         UEez8JUZ+aWAkHnNDB44lSF+BFt2YQiBkF4uzjz0WrHX/JgHl3rspnsCUZWSftE2X77B
         iqaRl4t8L6sE5GacMPTAOVDPlCevC2ydI0XlTo5Drl9jbe+sbrL6sEwj/xPrisD0v00D
         pggb9tNW9mpoEx57xkEfqh/ZOBYLjv5TOLxSzzuJdmvskzww+E3o2p57gXIKlpTu4e8F
         iyUQ==
X-Gm-Message-State: AOAM532baiHMCJTVZ71+q0poXcjCMt8F0STdTbZbqdOJlGc858MjHGhW
        Pk0KSpEWNJSE5OYePAypiUqW1NcbqdBsQyJ85O436IDPxVRJszOK8Rj1TSvVMrj/hVRoI6/QbBu
        eqE4XL9/YaboQ9Gc3k73UZXrXeOv6bawbCUGH3ETu
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id d18-20020a05651c089200b002499e230015mr1916138ljq.492.1650608588809;
        Thu, 21 Apr 2022 23:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwqKev+t3dwxEksOixf9qhX2r0+MZYnig2BgFOq5A+45aQEs/EnCwKgSO7Te7I2Uzy3IDHGCn7iS75rUnHFBw=
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr1916125ljq.492.1650608588568; Thu, 21
 Apr 2022 23:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220419014025.218121-1-lulu@redhat.com> <32c1113d-4991-0ab0-5a85-33fe85295b93@redhat.com>
 <CACLfguUTXD0r3bDYCA3YkYQ8Oe8L0pMU2gaXsemh392WKNjOwA@mail.gmail.com> <CACLfguVubBQ4N6EFZCPC0ksibmso5Yryy0e_oreKMPg==k9f_Q@mail.gmail.com>
In-Reply-To: <CACLfguVubBQ4N6EFZCPC0ksibmso5Yryy0e_oreKMPg==k9f_Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 22 Apr 2022 14:22:57 +0800
Message-ID: <CACGkMEujYU-qpjEYVKpy41AqyhuHeifV4kO7wAZafi63YpFkrA@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To:     Cindy Lu <lulu@redhat.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 1:57 PM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Apr 20, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> >
> >
> > On Wed, Apr 20, 2022 at 11:21 AM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >>
> >> =E5=9C=A8 2022/4/19 09:40, Cindy Lu =E5=86=99=E9=81=93:
> >> > this patch is to add the support for vdpa tool in vp_vdpa
> >> > here is the example steps
> >> > modprobe vp_vdpa
> >> > modprobe vhost_vdpa
> >> >
> >> > echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> >> > echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
> >> >
> >> > vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
> >> >
> >> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> > ---
> >> >   drivers/vdpa/virtio_pci/vp_vdpa.c | 86 +++++++++++++++++++++++++++=
+---
> >> >   1 file changed, 78 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio=
_pci/vp_vdpa.c
> >> > index cce101e6a940..d8a1d2f8e9bb 100644
> >> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> >> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> >> > @@ -17,6 +17,8 @@
> >> >   #include <linux/virtio_ring.h>
> >> >   #include <linux/virtio_pci.h>
> >> >   #include <linux/virtio_pci_modern.h>
> >> > +#include <uapi/linux/virtio_net.h>
> >> > +#include <uapi/linux/vdpa.h>
> >> >
> >> >   #define VP_VDPA_QUEUE_MAX 256
> >> >   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> >> > @@ -41,6 +43,18 @@ struct vp_vdpa {
> >> >       int vectors;
> >> >   };
> >> >
> >> > +struct vp_vdpa_mgmtdev {
> >> > +     struct vdpa_mgmt_dev mgtdev;
> >> > +     struct vp_vdpa *vp_vdpa;
> >> > +     struct pci_dev *pdev;
> >> > +};
> >> > +
> >> > +#define VP_VDPA_NET_FEATURES                                       =
            \
> >> > +     ((1ULL << VIRTIO_F_ANY_LAYOUT) | (1ULL << VIRTIO_F_VERSION_1) =
|        \
> >> > +      (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> >> > +
> >> > +#define VP_VDPA_NET_VQ_NUM 2
> >>
> >>
> >> Let's not go backwards, e.g we've already support any kind of virtio
> >> device with any kind of features. see the comment in vp_vdpa_probe().
> >>
> >>
> > got it, I will fix this
> >>
> >> > +
> >> >   static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
> >> >   {
> >> >       return container_of(vdpa, struct vp_vdpa, vdpa);
> >> > @@ -454,9 +468,14 @@ static void vp_vdpa_free_irq_vectors(void *data=
)
> >> >       pci_free_irq_vectors(data);
> >> >   }
> >> >
> >> > -static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id *id)
> >> > +static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char=
 *name,
> >> > +                        const struct vdpa_dev_set_config *add_confi=
g)
> >> >   {
> >> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D
> >> > +             container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> >> > +
> >> >       struct virtio_pci_modern_device *mdev;
> >> > +     struct pci_dev *pdev =3D vp_vdpa_mgtdev->pdev;
> >> >       struct device *dev =3D &pdev->dev;
> >> >       struct vp_vdpa *vp_vdpa;
> >> >       int ret, i;
> >> > @@ -465,8 +484,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >> >       if (ret)
> >> >               return ret;
> >> >
> >> > -     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> >> > -                                 dev, &vp_vdpa_ops, NULL, false);
> >> > +     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_v=
dpa_ops,
> >> > +                                 name, false);
> >>
> >>
> >> Nit: let's keep the line of vdpa_alloc_device() unchanged to reduce th=
e
> >> changeset.
> >>
> >>
> > will fix this
> >>
> >> > +
> >> >       if (IS_ERR(vp_vdpa)) {
> >> >               dev_err(dev, "vp_vdpa: Failed to allocate vDPA structu=
re\n");
> >> >               return PTR_ERR(vp_vdpa);
> >> > @@ -480,9 +500,10 @@ static int vp_vdpa_probe(struct pci_dev *pdev, =
const struct pci_device_id *id)
> >> >               dev_err(&pdev->dev, "Failed to probe modern PCI device=
\n");
> >> >               goto err;
> >> >       }
> >> > +     vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> >> >
> >> >       pci_set_master(pdev);
> >> > -     pci_set_drvdata(pdev, vp_vdpa);
> >> > +     pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> >> >
> >> >       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> >> >       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> >> > @@ -516,7 +537,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >> >       }
> >> >       vp_vdpa->config_irq =3D VIRTIO_MSI_NO_VECTOR;
> >> >
> >> > -     ret =3D vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> >> > +     vp_vdpa->vdpa.mdev =3D &vp_vdpa_mgtdev->mgtdev;
> >> > +     ret =3D _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues)=
;
> >> >       if (ret) {
> >> >               dev_err(&pdev->dev, "Failed to register to vdpa bus\n"=
);
> >> >               goto err;
> >> > @@ -529,12 +551,60 @@ static int vp_vdpa_probe(struct pci_dev *pdev,=
 const struct pci_device_id *id)
> >> >       return ret;
> >> >   }
> >> >
> >> > -static void vp_vdpa_remove(struct pci_dev *pdev)
> >> > +static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> >> > +                         struct vdpa_device *dev)
> >> >   {
> >> > -     struct vp_vdpa *vp_vdpa =3D pci_get_drvdata(pdev);
> >> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D
> >> > +             container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> >> > +
> >> > +     struct vp_vdpa *vp_vdpa =3D vp_vdpa_mgtdev->vp_vdpa;
> >> >
> >> >       vp_modern_remove(&vp_vdpa->mdev);
> >> > -     vdpa_unregister_device(&vp_vdpa->vdpa);
> >> > +     _vdpa_unregister_device(&vp_vdpa->vdpa);
> >> > +     vp_vdpa_mgtdev->vp_vdpa =3D NULL;
> >> > +}
> >> > +
> >> > +static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops =3D {
> >> > +     .dev_add =3D vp_vdpa_dev_add,
> >> > +     .dev_del =3D vp_vdpa_dev_del,
> >> > +};
> >> > +
> >> > +static struct virtio_device_id vp_vdpa_id_table[] =3D {
> >> > +     { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> >> > +     { 0 },
> >> > +};
> >>
> >>
> >> Let's not limit the vp_vdpa to net, it can support all other virtio de=
vices.
> >>
> >>
> > sure, will fix this
> >>
> >> > +
> >> > +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id *id)
> >> > +{
> >> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev;
> >> > +     struct vdpa_mgmt_dev *mgtdev;
> >> > +     struct device *dev =3D &pdev->dev;
> >> > +     int err;
> >> > +
> >> > +     vp_vdpa_mgtdev =3D kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL=
);
> >> > +     if (!vp_vdpa_mgtdev)
> >> > +             return -ENOMEM;
> >> > +     mgtdev =3D &vp_vdpa_mgtdev->mgtdev;
> >> > +
> >> > +     mgtdev->ops =3D &vp_vdpa_mdev_ops;
> >> > +     mgtdev->device =3D dev;
> >> > +     mgtdev->id_table =3D vp_vdpa_id_table;
> >> > +     vp_vdpa_mgtdev->pdev =3D pdev;
> >> > +
> >> > +     mgtdev->max_supported_vqs =3D VP_VDPA_NET_VQ_NUM;
> >>
> >>
> >> Let's read this from the device instead of using the hard-coded value.
> >>
> >>
> >> > +     mgtdev->supported_features =3D VP_VDPA_NET_FEATURES;
> >>
> >>
> >> Let's read this from the device.
> >>
> > sure will fix this
> HI Jason, I have check the code, maybe we can't read these
> informations from device here,
> because the  virtio_pci_modern_device   was inited in vp_vdpa_dev_add(),
> if we want to read these information in vp_vdpa_probe(). maybe we need
> to change the struct in vp_vdpa. and separate the
> struct virtio_pci_modern_device  from struct vp_vdpa. I'm not sure if
> this is ok to do?

Any reason we can't do vdpa_alloc_device() in the vp_vdpa_probe() and
register it in dev_add?

If we can't I'd then decouple virtio_pci_moder_device out of vp_vdpa:

struct vp_vdpa {
    struct vdpa_device vdpa;
    struct virtio_pci_modern_device *mdev;
};

Thanks

>
> struct vp_vdpa {
> struct vdpa_device vdpa;
> struct virtio_pci_modern_device mdev;
> struct vp_vring *vring;
> struct vdpa_callback config_cb;
> char msix_name[VP_VDPA_NAME_SIZE];
> int config_irq;
> int queues;
> int vectors;
> };
> Thanks
> cindy
> >>
> >>
> >> > +
> >> > +     err =3D vdpa_mgmtdev_register(mgtdev);
> >>
> >>
> >> Do we need to free the vp_vdpa_mgtdev here?
> >>
> > will add the this
> >>
> >> Thanks
> >>
> >>
> >> > +
> >> > +     return err;
> >> > +}
> >> > +
> >> > +static void vp_vdpa_remove(struct pci_dev *pdev)
> >> > +{
> >> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D pci_get_drvdata(pde=
v);
> >> > +
> >> > +     vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> >> > +     kfree(vp_vdpa_mgtdev);
> >> >   }
> >> >
> >> >   static struct pci_driver vp_vdpa_driver =3D {
> >>
>

