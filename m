Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D112530DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiEWJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiEWJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43D501A051
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653299872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7po0GtrBtc9y8cOPJ/0GbOoVIs2F1iXmywPEu00Vik=;
        b=RzDTXOVM6vVpT8pw0AidYI1rqvoyMOuMqvhqzFvq6NaTKO4WVYqvUWOdVOeoIr0apFbE/C
        Uklh1r+Oe+GzZs2Tb2NAF/HXZI57uDcirYGejVjyUnl33eegEGLD7IkdGwrD6pda9S1UGE
        OCGutU7c6yYeMQdAp5WoDgo89I2QstI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-pLmewfKSMUSJPciWU1xEPA-1; Mon, 23 May 2022 05:57:43 -0400
X-MC-Unique: pLmewfKSMUSJPciWU1xEPA-1
Received: by mail-qk1-f200.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so11044107qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j7po0GtrBtc9y8cOPJ/0GbOoVIs2F1iXmywPEu00Vik=;
        b=xaGGhwxAu1th4SXhz1YVlR/IlNAKQkM7c5xSaqmpK0uFM11Ao+Yvn/b0r24kLI/uqa
         jdZOktZs+h5+JvZYrgPrAYdVqxOfajbNoRNymk6VWC5Tw9jiVR5xI7T9rlj87b0oOSMd
         QMXFNQVfrC09kqE94X+yZNkLdewGiChk3g3vsLiMyim4ECCdOLI2dk7LcL+6vhBg/Zzq
         RPLLY8Ajar3n4YCad44QkGCDrchJWP0lt0f0AvwLhH6wbVFyvoCMpFfhLqj7DfH98f3t
         cCGGRQj+Qi39QpamxLrq8V5Fl0jXt4tUsV8PFEKnACTeB78j8TDCEwLG4jJ4lHIJb5q+
         lIKw==
X-Gm-Message-State: AOAM531KN46/yyGAc/rtKggOPwDY11lLMAUnDkhZ59gcg6TOToNejAHo
        umQ7z+CRfzkYPE0Y0+kGXPT9c1JfAv5XBJ8KVrG5AzZkUQgdA6KGuk/qk+pbjnYhH5yLdebXZT/
        15W+Cxd3NwEp4spuKKP749Vl9o2NvAz7uB/3bd85S
X-Received: by 2002:ac8:4e81:0:b0:2f9:34e4:8955 with SMTP id 1-20020ac84e81000000b002f934e48955mr3214632qtp.459.1653299863486;
        Mon, 23 May 2022 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvbFG1aDvatEqz9FXE4l2jp7/tHOGW5uKpg80Hd8pzafG0zBsY8brrzQMiJMaoyoUAVsq3ctLvZhaXY1yEfaE=
X-Received: by 2002:ac8:4e81:0:b0:2f9:34e4:8955 with SMTP id
 1-20020ac84e81000000b002f934e48955mr3214627qtp.459.1653299863283; Mon, 23 May
 2022 02:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220520172325.980884-1-eperezma@redhat.com> <20220520172325.980884-3-eperezma@redhat.com>
 <c1a31c3f-46c0-f0a2-eb43-757914d46ac3@oracle.com>
In-Reply-To: <c1a31c3f-46c0-f0a2-eb43-757914d46ac3@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 23 May 2022 11:57:07 +0200
Message-ID: <CAJaqyWdg0tuBcDeaB9Q-XkEoPRSqQ=ruFh1eqT40uOeknRwdkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: introduce STOP backend feature bit
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Longpeng <longpeng2@huawei.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Harpreet Singh Anand <hanand@xilinx.com>, dinang@xilinx.com,
        Eli Cohen <elic@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, pabloc@xilinx.com,
        "Dawar, Gautam" <gautam.dawar@amd.com>,
        Xie Yongji <xieyongji@bytedance.com>, habetsm.xilinx@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tanuj.kamde@amd.com, Wu Zongyong <wuzongyong@linux.alibaba.com>,
        martinpo@xilinx.com, Cindy Lu <lulu@redhat.com>,
        ecree.xilinx@gmail.com, Parav Pandit <parav@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Min <zhang.min9@zte.com.cn>
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

On Sat, May 21, 2022 at 12:25 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 5/20/2022 10:23 AM, Eugenio P=C3=A9rez wrote:
> > Userland knows if it can stop the device or not by checking this featur=
e
> > bit.
> >
> > It's only offered if the vdpa driver backend implements the stop()
> > operation callback, and try to set it if the backend does not offer tha=
t
> > callback is an error.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   drivers/vhost/vdpa.c             | 13 +++++++++++++
> >   include/uapi/linux/vhost_types.h |  2 ++
> >   2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 1f1d1c425573..a325bc259afb 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -347,6 +347,14 @@ static long vhost_vdpa_set_config(struct vhost_vdp=
a *v,
> >       return 0;
> >   }
> >
> > +static bool vhost_vdpa_can_stop(const struct vhost_vdpa *v)
> > +{
> > +     struct vdpa_device *vdpa =3D v->vdpa;
> > +     const struct vdpa_config_ops *ops =3D vdpa->config;
> > +
> > +     return ops->stop;
> > +}
> > +
> >   static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user =
*featurep)
> >   {
> >       struct vdpa_device *vdpa =3D v->vdpa;
> > @@ -577,6 +585,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
> >                       return -EFAULT;
> >               if (features & ~VHOST_VDPA_BACKEND_FEATURES)
> >                       return -EOPNOTSUPP;
> > +             if ((features & VHOST_BACKEND_F_STOP) &&
> VHOST_BACKEND_F_STOP is not part of VHOST_VDPA_BACKEND_FEATURES. There's
> no chance for VHOST_BACKEND_F_STOP to get here.
>

That's right. I think I missed to backport your patches about set
backend_features only once in my testing.

I will re-test with the latest qemu master, thanks!

> -Siwei
> > +                  !vhost_vdpa_can_stop(v))
> > +                     return -EOPNOTSUPP;
> >               vhost_set_backend_features(&v->vdev, features);
> >               return 0;
> >       }
> > @@ -624,6 +635,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
> >               break;
> >       case VHOST_GET_BACKEND_FEATURES:
> >               features =3D VHOST_VDPA_BACKEND_FEATURES;
> > +             if (vhost_vdpa_can_stop(v))
> > +                     features |=3D VHOST_BACKEND_F_STOP;
> >               if (copy_to_user(featurep, &features, sizeof(features)))
> >                       r =3D -EFAULT;
> >               break;
> > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhos=
t_types.h
> > index 634cee485abb..2758e665791b 100644
> > --- a/include/uapi/linux/vhost_types.h
> > +++ b/include/uapi/linux/vhost_types.h
> > @@ -161,5 +161,7 @@ struct vhost_vdpa_iova_range {
> >    * message
> >    */
> >   #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> > +/* Stop device from processing virtqueue buffers */
> > +#define VHOST_BACKEND_F_STOP  0x4
> >
> >   #endif
>

