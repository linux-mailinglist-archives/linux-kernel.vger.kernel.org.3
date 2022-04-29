Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955A5144D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356136AbiD2IwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiD2IwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F5CC4010
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651222138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTqxancDJmJgGoX9yjLM+SHPZAqjaDjBQak8aSxBbKI=;
        b=E9+x19oFccDDDYxJWGSzuElf79pX/2jnWps2NKjAGQuEuH14OHoauWZtDIwnZ0kDmlDle5
        i62jq4G+yPoF+bWQ8PQo18AlSlEyvYKvquORYZjtziFr+aZHnHrYImGtZmn/KdqZlTpZCn
        L7yAUz4Ycs1JF9SXGzrsusz03UriP5U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-oVbBIUPEOh6j6J8Q-sKMEA-1; Fri, 29 Apr 2022 04:48:56 -0400
X-MC-Unique: oVbBIUPEOh6j6J8Q-sKMEA-1
Received: by mail-ed1-f72.google.com with SMTP id s24-20020a05640217d800b00425e19e7deaso4131894edy.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HTqxancDJmJgGoX9yjLM+SHPZAqjaDjBQak8aSxBbKI=;
        b=CUy4s53yttDv05Up+0sJQWtL6IsiKiTlTi/gP9DoX0DuJwLHq5wFdJ3w2lOdj20V+m
         ThccWFEwpvvbQKZwazQVrWpsF7HSu6aaE3ewq0LQtIJKRCIKJm+DRb6r951pYw2hgaOf
         4w6cIehgBfSMd1kbfBayDF+r96kzSfcTRT1o9nMjnU/OyLc5vx9vv0rSTECkus0JZWaV
         wU4nTbJnfGY2lQ6orQrw8t+SzWkHbAxdxRL3t5tHKLuIQPKH09uDIuSYztSw6GIrWJu8
         xCTfx6ggC+f9T3cSue3bx3OFitRlD+H+57XmnGL4mqUs1ALFrjmzo8SN+vkJV7JMMrKp
         D9CA==
X-Gm-Message-State: AOAM5325THCxE93ylRkcCAiwM9pkAwsx3cqBloLFD+bTaK5QsVYj30JA
        n5mhPzVPHxTKED3LfcJbeosalmZ373Mkl2uLsS2zaHiOhx/tdXLbAVkBpkuKfIAhHg1V9kxiNSl
        ENng9e9pw9h2BDZ2pZxZcH8IL0CfINK+nyCtsBKvK
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id js12-20020a17090797cc00b006df83bc314cmr35338219ejc.587.1651222135239;
        Fri, 29 Apr 2022 01:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiLxd+CfFW3OqJmXCY0xyGx+eGoHZHRViGYw5pUyUO/KKYcid6gH7163312Msg28wi+QjY5fdYJcSMHBB8xXE=
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id
 js12-20020a17090797cc00b006df83bc314cmr35338211ejc.587.1651222134958; Fri, 29
 Apr 2022 01:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220428073727.390987-1-lulu@redhat.com> <80a4a48a-9557-0411-c01c-4e04fd113a8a@redhat.com>
In-Reply-To: <80a4a48a-9557-0411-c01c-4e04fd113a8a@redhat.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Fri, 29 Apr 2022 16:48:18 +0800
Message-ID: <CACLfguVco8m+eQv2BFOmx-qgrEQG2OTz-R7bP6BxVunUM2z8CQ@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 29, 2022 at 12:14 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2022/4/28 15:37, Cindy Lu =E5=86=99=E9=81=93:
> > this patch is to add the support for vdpa tool in vp_vdpa
> > here is the example steps
> >
> > modprobe vp_vdpa
> > modprobe vhost_vdpa
> > echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> > echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
> >
> > vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   drivers/vdpa/virtio_pci/vp_vdpa.c | 159 ++++++++++++++++++++++++-----=
-
> >   include/linux/vdpa.h              |   2 +-
> >   2 files changed, 128 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pc=
i/vp_vdpa.c
> > index cce101e6a940..a3827e496b8f 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -32,7 +32,7 @@ struct vp_vring {
> >
> >   struct vp_vdpa {
> >       struct vdpa_device vdpa;
> > -     struct virtio_pci_modern_device mdev;
> > +     struct virtio_pci_modern_device *mdev;
> >       struct vp_vring *vring;
> >       struct vdpa_callback config_cb;
> >       char msix_name[VP_VDPA_NAME_SIZE];
> > @@ -41,6 +41,12 @@ struct vp_vdpa {
> >       int vectors;
> >   };
> >
> > +struct vp_vdpa_mgmtdev {
> > +     struct vdpa_mgmt_dev mgtdev;
> > +     struct virtio_pci_modern_device *mdev;
> > +     struct vp_vdpa *vp_vdpa;
> > +};
> > +
> >   static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
> >   {
> >       return container_of(vdpa, struct vp_vdpa, vdpa);
> > @@ -50,7 +56,12 @@ static struct virtio_pci_modern_device *vdpa_to_mdev=
(struct vdpa_device *vdpa)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> >
> > -     return &vp_vdpa->mdev;
> > +     return vp_vdpa->mdev;
> > +}
> > +
> > +static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa=
 *vp_vdpa)
> > +{
> > +     return vp_vdpa->mdev;
> >   }
> >
> >   static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> > @@ -96,7 +107,7 @@ static int vp_vdpa_get_vq_irq(struct vdpa_device *vd=
pa, u16 idx)
> >
> >   static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> >   {
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       struct pci_dev *pdev =3D mdev->pci_dev;
> >       int i;
> >
> > @@ -143,7 +154,7 @@ static irqreturn_t vp_vdpa_config_handler(int irq, =
void *arg)
> >
> >   static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> >   {
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       struct pci_dev *pdev =3D mdev->pci_dev;
> >       int i, ret, irq;
> >       int queues =3D vp_vdpa->queues;
> > @@ -198,7 +209,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_v=
dpa)
> >   static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       u8 s =3D vp_vdpa_get_status(vdpa);
> >
> >       if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> > @@ -212,7 +223,7 @@ static void vp_vdpa_set_status(struct vdpa_device *=
vdpa, u8 status)
> >   static int vp_vdpa_reset(struct vdpa_device *vdpa)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       u8 s =3D vp_vdpa_get_status(vdpa);
> >
> >       vp_modern_set_status(mdev, 0);
> > @@ -372,7 +383,7 @@ static void vp_vdpa_get_config(struct vdpa_device *=
vdpa,
> >                              void *buf, unsigned int len)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       u8 old, new;
> >       u8 *p;
> >       int i;
> > @@ -392,7 +403,7 @@ static void vp_vdpa_set_config(struct vdpa_device *=
vdpa,
> >                              unsigned int len)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       const u8 *p =3D buf;
> >       int i;
> >
> > @@ -412,7 +423,7 @@ static struct vdpa_notification_area
> >   vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> >   {
> >       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> > -     struct virtio_pci_modern_device *mdev =3D &vp_vdpa->mdev;
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> >       struct vdpa_notification_area notify;
> >
> >       notify.addr =3D vp_vdpa->vring[qid].notify_pa;
> > @@ -454,38 +465,31 @@ static void vp_vdpa_free_irq_vectors(void *data)
> >       pci_free_irq_vectors(data);
> >   }
> >
> > -static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device=
_id *id)
> > +static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *n=
ame,
> > +                        const struct vdpa_dev_set_config *add_config)
> >   {
> > -     struct virtio_pci_modern_device *mdev;
> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D
> > +             container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> > +
> > +     struct virtio_pci_modern_device *mdev =3D vp_vdpa_mgtdev->mdev;
> > +     struct pci_dev *pdev =3D mdev->pci_dev;
> >       struct device *dev =3D &pdev->dev;
> > -     struct vp_vdpa *vp_vdpa;
> > +     struct vp_vdpa *vp_vdpa =3D NULL;
> >       int ret, i;
> >
> > -     ret =3D pcim_enable_device(pdev);
> > -     if (ret)
> > -             return ret;
> > +     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa=
_ops,
> > +                                 name, false);
> >
> > -     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > -                                 dev, &vp_vdpa_ops, NULL, false);
> >       if (IS_ERR(vp_vdpa)) {
> >               dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> >               return PTR_ERR(vp_vdpa);
> >       }
> >
> > -     mdev =3D &vp_vdpa->mdev;
> > -     mdev->pci_dev =3D pdev;
> > -
> > -     ret =3D vp_modern_probe(mdev);
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "Failed to probe modern PCI device\n"=
);
> > -             goto err;
> > -     }
> > -
> > -     pci_set_master(pdev);
> > -     pci_set_drvdata(pdev, vp_vdpa);
> > +     vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> >
> >       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> >       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> > +     vp_vdpa->mdev =3D mdev;
> >
> >       ret =3D devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, p=
dev);
> >       if (ret) {
> > @@ -516,7 +520,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
> >       }
> >       vp_vdpa->config_irq =3D VIRTIO_MSI_NO_VECTOR;
> >
> > -     ret =3D vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> > +     vp_vdpa->vdpa.mdev =3D &vp_vdpa_mgtdev->mgtdev;
> > +     ret =3D _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> >       if (ret) {
> >               dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
> >               goto err;
> > @@ -529,12 +534,102 @@ static int vp_vdpa_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >       return ret;
> >   }
> >
> > +static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> > +                         struct vdpa_device *dev)
> > +{
> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D
> > +             container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> > +
> > +     struct vp_vdpa *vp_vdpa =3D vp_vdpa_mgtdev->vp_vdpa;
> > +
> > +     _vdpa_unregister_device(&vp_vdpa->vdpa);
> > +     vp_vdpa_mgtdev->vp_vdpa =3D NULL;
> > +}
> > +
> > +static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops =3D {
> > +     .dev_add =3D vp_vdpa_dev_add,
> > +     .dev_del =3D vp_vdpa_dev_del,
> > +};
> > +
> > +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device=
_id *id)
> > +{
> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D NULL;
> > +     struct vdpa_mgmt_dev *mgtdev;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct virtio_pci_modern_device *mdev =3D NULL;
> > +     struct virtio_device_id *mdev_id =3D NULL;
> > +     int err;
> > +
> > +     vp_vdpa_mgtdev =3D kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL);
> > +     if (!vp_vdpa_mgtdev)
> > +             return -ENOMEM;
> > +
> > +     mgtdev =3D &vp_vdpa_mgtdev->mgtdev;
> > +     mgtdev->ops =3D &vp_vdpa_mdev_ops;
> > +     mgtdev->device =3D dev;
> > +
> > +     mdev =3D kzalloc(sizeof(struct virtio_pci_modern_device), GFP_KER=
NEL);
> > +     if (!mdev) {
> > +             kfree(vp_vdpa_mgtdev);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     mdev_id =3D kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
> > +     if (!mdev_id) {
> > +             kfree(mdev);
> > +             kfree(vp_vdpa_mgtdev);
> > +             return -ENOMEM;
>
>
> Nit: let' use err label for having a consistent rewind.
>
> Other looks good.
>
> Thanks
>
Thanks, Jason, I will post a new version soon
>
> > +     }
> > +
> > +     vp_vdpa_mgtdev->mdev =3D mdev;
> > +     mdev->pci_dev =3D pdev;
> > +
> > +     err =3D pcim_enable_device(pdev);
> > +     if (err) {
> > +             goto err;
> > +     }
> > +
> > +     err =3D vp_modern_probe(mdev);
> > +     if (err) {
> > +             dev_err(&pdev->dev, "Failed to probe modern PCI device\n"=
);
> > +             goto err;
> > +     }
> > +
> > +     mdev_id->device =3D mdev->id.device;
> > +     mdev_id->vendor =3D mdev->id.vendor;
> > +     mgtdev->id_table =3D mdev_id;
> > +
> > +     mgtdev->max_supported_vqs =3D vp_modern_get_num_queues(mdev);
> > +     mgtdev->supported_features =3D vp_modern_get_features(mdev);
> > +     pci_set_master(pdev);
> > +     pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> > +
> > +     err =3D vdpa_mgmtdev_register(mgtdev);
> > +     if (err) {
> > +             dev_err(&pdev->dev, "Failed to register vdpa mgmtdev devi=
ce\n");
> > +             vp_modern_remove(vp_vdpa_mgtdev->mdev);
> > +             goto err;
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     kfree(mdev_id);
> > +     kfree(mdev);
> > +     kfree(vp_vdpa_mgtdev);
> > +     return err;
> > +}
> > +
> >   static void vp_vdpa_remove(struct pci_dev *pdev)
> >   {
> > -     struct vp_vdpa *vp_vdpa =3D pci_get_drvdata(pdev);
> > +     struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =3D pci_get_drvdata(pdev);
> > +     struct virtio_pci_modern_device *mdev =3D NULL;
> >
> > -     vp_modern_remove(&vp_vdpa->mdev);
> > -     vdpa_unregister_device(&vp_vdpa->vdpa);
> > +     mdev =3D vp_vdpa_mgtdev->mdev;
> > +     vp_modern_remove(mdev);
> > +     vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> > +     kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
> > +     kfree(mdev);
> > +     kfree(vp_vdpa_mgtdev);
> >   }
> >
> >   static struct pci_driver vp_vdpa_driver =3D {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 721089bb4c84..342c454c1623 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -462,7 +462,7 @@ struct vdpa_mgmtdev_ops {
> >   struct vdpa_mgmt_dev {
> >       struct device *device;
> >       const struct vdpa_mgmtdev_ops *ops;
> > -     const struct virtio_device_id *id_table;
> > +     struct virtio_device_id *id_table;
> >       u64 config_attr_mask;
> >       struct list_head list;
> >       u64 supported_features;
>

