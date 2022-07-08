Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1055256B8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiGHLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiGHLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEBA7D1F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657280744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D16LkhWInPs1rx1LRkF636S9a6Uz2RaFBw2M/GUtu3w=;
        b=W0h4xg8pp+NotW5WPk0QOjuD3SILmbeJbJZbbLtbSVpBeoi7KZBF8yBaxRdxgpwM/eQ0iY
        qmfdK4C5ORWlgt+QOQIrzU3p1EgNrD7cW3nZmMRVnOXjZ4NeinOo/mr73J+Z+cK+tReyUU
        9awp4mtd45X77YScI4oKXcAJ4xn2bsU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-Bf5Jb9PyORiTiazBIYsk_A-1; Fri, 08 Jul 2022 07:45:34 -0400
X-MC-Unique: Bf5Jb9PyORiTiazBIYsk_A-1
Received: by mail-qk1-f200.google.com with SMTP id w16-20020a376210000000b006af059b17b7so20704001qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D16LkhWInPs1rx1LRkF636S9a6Uz2RaFBw2M/GUtu3w=;
        b=eX4AmC2YFHYdyQzRrEJOhn743Iq0Bi+LZcYJJKJnfIvVDyLSIXyXWEVYXU1hzbkq2u
         lbVCu1uxS+NhYByFoO8Mqa8bBdhXp9VpKE4hLpOA9f8r0UgU2I0R3u1fMD+XMzmpupL3
         OoJT5CSPH0VFThvMt6lmayenyBTNDgJ0RALypzKNrqaNo3eQVDWYGRLzitNHy2oxHmAr
         uhXTOmL6B1Iuyp1+teZe9Ow4d6bNXjL6OYls6Pi+inJNO8grhr+ElhYqV89ARh5TuFsI
         zJEPIod30KIBHGkWlHGqGquTAQ6tkIU3+gwksASFIXJaNgvvhFxThttTil6/JPxHotsM
         KSzg==
X-Gm-Message-State: AJIora8qKXBOQCJbrVoNzS7NtFotkm6o0ep3Dk+8Hy6PMEqLH5Izvy4U
        98OPQ12H57LosFSKqpR8v0TyQpffnDBx2NGWw7o9GXErWrZ4SEXr/5JtUOGCuXWcNuq09Z/rB7V
        te15CfKeSJtoYHgjd/sBe4Ut1gLWn8qx+YGzKcJ7L
X-Received: by 2002:a05:620a:2005:b0:6b5:6531:ec5e with SMTP id c5-20020a05620a200500b006b56531ec5emr1206578qka.255.1657280734360;
        Fri, 08 Jul 2022 04:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stKhUP+nH27TcsnFwZJ468XK3gzKwN+NclOEEgZAId1wEgmBGS630kxnmOKs/qxn5jXaIABZGZ/lPTom5S67I=
X-Received: by 2002:a05:620a:2005:b0:6b5:6531:ec5e with SMTP id
 c5-20020a05620a200500b006b56531ec5emr1206540qka.255.1657280734102; Fri, 08
 Jul 2022 04:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com> <20220623160738.632852-3-eperezma@redhat.com>
 <CACGkMEtNC=4KeigQXr4NuaiuVGkxK2ruQTk6-Fbr3B1MqHieTA@mail.gmail.com>
In-Reply-To: <CACGkMEtNC=4KeigQXr4NuaiuVGkxK2ruQTk6-Fbr3B1MqHieTA@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 8 Jul 2022 13:44:57 +0200
Message-ID: <CAJaqyWdciXkbtpBmGugDsr+0Nh3X50r2Fa5i9Yk2NyQaXBLKtg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] vhost-vdpa: introduce SUSPEND backend feature bit
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cindy Lu <lulu@redhat.com>,
        "Kamde, Tanuj" <tanuj.kamde@amd.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "Uminski, Piotr" <Piotr.Uminski@intel.com>,
        habetsm.xilinx@gmail.com, "Dawar, Gautam" <gautam.dawar@amd.com>,
        Pablo Cascon Katchadourian <pabloc@xilinx.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Longpeng <longpeng2@huawei.com>,
        Dinan Gunawardena <dinang@xilinx.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Martin Porter <martinpo@xilinx.com>,
        Eli Cohen <elic@nvidia.com>, ecree.xilinx@gmail.com,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Zhang Min <zhang.min9@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 6:12 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Jun 24, 2022 at 12:08 AM Eugenio P=C3=A9rez <eperezma@redhat.com>=
 wrote:
> >
> > Userland knows if it can suspend the device or not by checking this fea=
ture
> > bit.
> >
> > It's only offered if the vdpa driver backend implements the suspend()
> > operation callback, and to offer it or userland to ack it if the backen=
d
> > does not offer that callback is an error.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c             | 16 +++++++++++++++-
> >  include/uapi/linux/vhost_types.h |  2 ++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 23dcbfdfa13b..3d636e192061 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -347,6 +347,14 @@ static long vhost_vdpa_set_config(struct vhost_vdp=
a *v,
> >         return 0;
> >  }
> >
> > +static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> > +{
> > +       struct vdpa_device *vdpa =3D v->vdpa;
> > +       const struct vdpa_config_ops *ops =3D vdpa->config;
> > +
> > +       return ops->suspend;
> > +}
> > +
> >  static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *=
featurep)
> >  {
> >         struct vdpa_device *vdpa =3D v->vdpa;
> > @@ -577,7 +585,11 @@ static long vhost_vdpa_unlocked_ioctl(struct file =
*filep,
> >         if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> >                 if (copy_from_user(&features, featurep, sizeof(features=
)))
> >                         return -EFAULT;
> > -               if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> > +               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > +                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> > +                       return -EOPNOTSUPP;
> > +               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > +                    !vhost_vdpa_can_suspend(v))
>
> Do we need to advertise this to the management?
>

Not sure if I follow, the feature bit is not exposed if the backend
cannot suspend.

Thanks!

> Thanks
>
> >                         return -EOPNOTSUPP;
> >                 vhost_set_backend_features(&v->vdev, features);
> >                 return 0;
> > @@ -628,6 +640,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
> >                 break;
> >         case VHOST_GET_BACKEND_FEATURES:
> >                 features =3D VHOST_VDPA_BACKEND_FEATURES;
> > +               if (vhost_vdpa_can_suspend(v))
> > +                       features |=3D BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> >                 if (copy_to_user(featurep, &features, sizeof(features))=
)
> >                         r =3D -EFAULT;
> >                 break;
> > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhos=
t_types.h
> > index 634cee485abb..1bdd6e363f4c 100644
> > --- a/include/uapi/linux/vhost_types.h
> > +++ b/include/uapi/linux/vhost_types.h
> > @@ -161,5 +161,7 @@ struct vhost_vdpa_iova_range {
> >   * message
> >   */
> >  #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> > +/* Device can be suspended */
> > +#define VHOST_BACKEND_F_SUSPEND  0x4
> >
> >  #endif
> > --
> > 2.31.1
> >
>

