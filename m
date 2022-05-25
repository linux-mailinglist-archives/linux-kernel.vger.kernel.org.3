Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08E5338AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiEYIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiEYIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02700220D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653468063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWhpLcpJcmzzGJ2iM8haayonZZiCVvJa6aMQQNtfVeM=;
        b=OMlFnyE43cMz4++19Ro8XI5JR5BC61YNALEmcv0SkFsJ4oGxO7Eb12pA9vnsshJGDGNb/R
        CWrH4IpaM+/Y3jPbf+QCU9tKpbjpcKsIFo30A0hqurDsOq/papiQ2ouGmvOGb0uVa1C3Sa
        dkSZ9p+1HTPHki1ChXi8VkV5pDNcpfM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-CU-ifHlqNJWZ52T_1adxeQ-1; Wed, 25 May 2022 04:41:01 -0400
X-MC-Unique: CU-ifHlqNJWZ52T_1adxeQ-1
Received: by mail-qk1-f198.google.com with SMTP id l26-20020a37f51a000000b006a32d5737d2so13025675qkk.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sWhpLcpJcmzzGJ2iM8haayonZZiCVvJa6aMQQNtfVeM=;
        b=HhkaSRsNtxbbp43P+ZnOIIIxakzcONsORKonaxnQx50muzNdpuWF83pMcFPzcazGgY
         fQYvUsYPU/0Bk+vg0YjIf//+haml+OfEAx9dN6SEw7+KTAbL8Ul2GH8TiDtJQPwkDGSg
         sk2CKdPzeNZnWbSKiH0Rsc8qNyT5il3zlgQexdc2itH9ZB/CR9K8xksybvXLsRNkaiU/
         +xsGLe5hGHyu8vgG8+cShaROR4EKys1ynnltfjpFy/BIjg602eUud8LWT5BfyvColluQ
         MUvMwDzaFvObEyvS1Bw018Fk7UNe5hbJ4FnH8o5Q3JDwGL/OZg7wFlR60LJhQVjOv1IR
         Oykg==
X-Gm-Message-State: AOAM5308UfsB473RSL1rKr9YhLLv+ZoQflnE2ESi11gGyhpg0t7zDkvB
        hJxe24uSLKhxioANLGS+6d5ow7o6GlfiuEpcDCzMe3n6Ki6XsAmE2eBU8zFoXY28k2z50aTEPMd
        /NAOu7ewjObgFaDmcynWoDQoGbSAu7gJyI4kFgH2F
X-Received: by 2002:ac8:59d6:0:b0:2f3:f521:ed4b with SMTP id f22-20020ac859d6000000b002f3f521ed4bmr23653695qtf.320.1653468060210;
        Wed, 25 May 2022 01:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUZjfDXKV2TZOhlW7DV8KIWqqQ7N5Fmr6WTaKUlb3oH2yQ3eYGHbrEDNce9XcfwrIGLsGtKUGPeFYNJD6JERI=
X-Received: by 2002:ac8:59d6:0:b0:2f3:f521:ed4b with SMTP id
 f22-20020ac859d6000000b002f3f521ed4bmr23653668qtf.320.1653468059954; Wed, 25
 May 2022 01:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220524170610.2255608-1-eperezma@redhat.com> <20220524170610.2255608-5-eperezma@redhat.com>
 <CACGkMEvCzxy+1BX2FMs5CvsvVvd9oedtgXmpiyAZWZECPypRig@mail.gmail.com>
In-Reply-To: <CACGkMEvCzxy+1BX2FMs5CvsvVvd9oedtgXmpiyAZWZECPypRig@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 25 May 2022 10:40:23 +0200
Message-ID: <CAJaqyWenRO_NY6=T8hL=VJ7F9Shn2VbicATBKPK7=U6te890ng@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa_sim: Implement stop vdpa op
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Zhang Min <zhang.min9@zte.com.cn>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>, tanuj.kamde@amd.com,
        "Dawar, Gautam" <gautam.dawar@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xie Yongji <xieyongji@bytedance.com>,
        Dinan Gunawardena <dinang@xilinx.com>,
        habetsm.xilinx@gmail.com, Eli Cohen <elic@nvidia.com>,
        Pablo Cascon Katchadourian <pabloc@xilinx.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Cindy Lu <lulu@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        ecree.xilinx@gmail.com, "Uminski, Piotr" <Piotr.Uminski@intel.com>,
        Martin Porter <martinpo@xilinx.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Longpeng <longpeng2@huawei.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 4:54 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, May 25, 2022 at 1:06 AM Eugenio P=C3=A9rez <eperezma@redhat.com> =
wrote:
> >
> > Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
> > that backend feature and userspace can effectively stop the device.
> >
> > This is a must before get virtqueue indexes (base) for live migration,
> > since the device could modify them after userland gets them. There are
> > individual ways to perform that action for some devices
> > (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> > way to perform it for any vhost device (and, in particular, vhost-vdpa)=
.
> >
> > After the return of ioctl with stop !=3D 0, the device MUST finish any
> > pending operations like in flight requests. It must also preserve all
> > the necessary state (the virtqueue vring base plus the possible device
> > specific states) that is required for restoring in the future. The
> > device must not change its configuration after that point.
> >
> > After the return of ioctl with stop =3D=3D 0, the device can continue
> > processing buffers as long as typical conditions are met (vq is enabled=
,
> > DRIVER_OK status bit is enabled, etc).
> >
> > In the future, we will provide features similar to
> > VHOST_USER_GET_INFLIGHT_FD so the device can save pending operations.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> > index 50d721072beb..0515cf314bed 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -107,6 +107,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasi=
m)
> >         for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> >                 vhost_iotlb_reset(&vdpasim->iommu[i]);
> >
> > +       vdpasim->running =3D true;
> >         spin_unlock(&vdpasim->iommu_lock);
> >
> >         vdpasim->features =3D 0;
> > @@ -505,6 +506,24 @@ static int vdpasim_reset(struct vdpa_device *vdpa)
> >         return 0;
> >  }
> >
> > +static int vdpasim_stop(struct vdpa_device *vdpa, bool stop)
> > +{
> > +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > +       int i;
> > +
> > +       spin_lock(&vdpasim->lock);
> > +       vdpasim->running =3D !stop;
> > +       if (vdpasim->running) {
> > +               /* Check for missed buffers */
> > +               for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> > +                       vdpasim_kick_vq(vdpa, i);
> > +
> > +       }
> > +       spin_unlock(&vdpasim->lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > @@ -694,6 +713,7 @@ static const struct vdpa_config_ops vdpasim_config_=
ops =3D {
> >         .get_status             =3D vdpasim_get_status,
> >         .set_status             =3D vdpasim_set_status,
> >         .reset                  =3D vdpasim_reset,
> > +       .stop                   =3D vdpasim_stop,
> >         .get_config_size        =3D vdpasim_get_config_size,
> >         .get_config             =3D vdpasim_get_config,
> >         .set_config             =3D vdpasim_set_config,
> > @@ -726,6 +746,7 @@ static const struct vdpa_config_ops vdpasim_batch_c=
onfig_ops =3D {
> >         .get_status             =3D vdpasim_get_status,
> >         .set_status             =3D vdpasim_set_status,
> >         .reset                  =3D vdpasim_reset,
> > +       .stop                   =3D vdpasim_stop,
> >         .get_config_size        =3D vdpasim_get_config_size,
> >         .get_config             =3D vdpasim_get_config,
> >         .set_config             =3D vdpasim_set_config,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/v=
dpa_sim.h
> > index 622782e92239..061986f30911 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -66,6 +66,7 @@ struct vdpasim {
> >         u32 generation;
> >         u64 features;
> >         u32 groups;
> > +       bool running;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> >  };
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_blk.c
> > index 42d401d43911..bcdb1982c378 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -204,6 +204,9 @@ static void vdpasim_blk_work(struct work_struct *wo=
rk)
> >         if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >                 goto out;
> >
> > +       if (!vdpasim->running)
> > +               goto out;
> > +
> >         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> >                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index 5125976a4df8..886449e88502 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -154,6 +154,9 @@ static void vdpasim_net_work(struct work_struct *wo=
rk)
> >
> >         spin_lock(&vdpasim->lock);
> >
> > +       if (!vdpasim->running)
> > +               goto out;
> > +
>
> Do we need to check vdpasim->running in vdpasim_kick_vq()?
>

I'd say that not really: The important part is that we don't process
more buffers, and that is more accurate here. To check it here will
always avoid it although we queue work.

Maybe we can see it as an optimization: either to check before queuing
the work as you propose or simply stop polling kick file descriptors?

Thanks!

> Thanks
>
> >         if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >                 goto out;
> >
> > --
> > 2.27.0
> >
>

