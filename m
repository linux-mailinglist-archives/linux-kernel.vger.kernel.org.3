Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA8512C76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbiD1HS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiD1HSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EBB96838
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651130109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbtXVSqNRWMmnQtAhQDzTDc0JBl2FfEnxCXMM0a4ySw=;
        b=QEijofvWSI80CJlLPu50KND14s0Tra+XWf+FTMT2nRgwM12cMZd06cSL+ARVH3W9PVzikp
        2vrBP7HpCv0SedqXUSxYSM0NE4zuj/k9/Njc6cgVwQpi5cQK6vShdwfo/UnWWMpPtv8LAA
        5xNpbEjFiKJZ5//jeKvqdwsQbxhiHxE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-ILTdsHJGMWOle6rl2nijeA-1; Thu, 28 Apr 2022 03:15:08 -0400
X-MC-Unique: ILTdsHJGMWOle6rl2nijeA-1
Received: by mail-ej1-f70.google.com with SMTP id sa27-20020a1709076d1b00b006e8b357a2e7so2441390ejc.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BbtXVSqNRWMmnQtAhQDzTDc0JBl2FfEnxCXMM0a4ySw=;
        b=Y2cXw+64nl51+kY25+n14nOpAX+IUuiA4axHFBnW/LBBixOT+PHFZNTrt7O4Fe8wnm
         mcOT7loGLBUOpmUKNWTgeZicQPqz6AZNwFl+k1PF+k30sMc40+OFiMgp0IaX8KPjxWpz
         KNbkzPKSrkMx5tUznrNlgEkaIW7H5LgNzWh5L9JcVUGpytelDOfO1chvN22m/9PjJOGp
         K7ehsbp+wIynmYWt/he0AbHi4D3CZ4hZbMo33DO2YdXmLxdnY9NeJg0bhyfMMRtYDWVh
         2AnpBIXdoJJ4N+vDzd52u9i9CkYKO36yGXlxJXPDG6OFDKPMr5w5aaf/+8nx5GsUzXs6
         BSLw==
X-Gm-Message-State: AOAM532fAHmI5xaRiyKqVFboD3Ace62cszDa+ksEYou2UFRf+/dhHZMG
        OLZkhDgdKZvikgxvl7NnbNU7tnXik3DAMqhqemHR8q/KqfFavzzgLZwjSfq+TvQVPYrvhoWnJB8
        QdieM2pNdP2P7SLiNOld0tDWNYtDMu4/PzT3wfFps
X-Received: by 2002:a17:907:c15:b0:6f3:e917:a943 with SMTP id ga21-20020a1709070c1500b006f3e917a943mr146470ejc.747.1651130106823;
        Thu, 28 Apr 2022 00:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1UOqopGzT1haj+3Mgs1mrkRzFB5+elk5AGFOh87efdCD3r6e/RsD5UXhZ0tcrXDa9Um6CBbL3iap039wrIsY=
X-Received: by 2002:a17:907:c15:b0:6f3:e917:a943 with SMTP id
 ga21-20020a1709070c1500b006f3e917a943mr146456ejc.747.1651130106541; Thu, 28
 Apr 2022 00:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com> <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
 <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
 <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com> <CACGkMEuiXh-qXrz_ycQT_jjM0RpOe-G36w_eZyJEJNFp2UdVRg@mail.gmail.com>
In-Reply-To: <CACGkMEuiXh-qXrz_ycQT_jjM0RpOe-G36w_eZyJEJNFp2UdVRg@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 28 Apr 2022 15:14:28 +0800
Message-ID: <CACLfguXt14xN3ickfGXCgd0LYvGGT=q6gH6gQFtwSHB9au2dOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct vdpa_mgmt_dev
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 11:21 AM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 11:07 AM Jason Wang <jasowang@redhat.com> wrote=
:
> > >
> > > On Thu, Apr 28, 2022 at 9:56 AM Cindy Lu <lulu@redhat.com> wrote:
> > > >
> > > > On Wed, Apr 27, 2022 at 12:04 PM Jason Wang <jasowang@redhat.com> w=
rote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2022/4/27 10:01, Cindy Lu =E5=86=99=E9=81=93:
> > > > > > On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > >> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wro=
te:
> > > > > >>> To support the dynamic ids in vp_vdpa, we need to add the che=
ck for
> > > > > >>> id table. If the id table is NULL, will not set the device ty=
pe
> > > > > >>>
> > > > > >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > >>> ---
> > > > > >>>   drivers/vdpa/vdpa.c | 11 +++++++----
> > > > > >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > >>>
> > > > > >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > >>> index 1ea525433a5c..09edd92cede0 100644
> > > > > >>> --- a/drivers/vdpa/vdpa.c
> > > > > >>> +++ b/drivers/vdpa/vdpa.c
> > > > > >>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const stru=
ct vdpa_mgmt_dev *mdev, struct sk_buff *m
> > > > > >>>          if (err)
> > > > > >>>                  goto msg_err;
> > > > > >>>
> > > > > >>> -       while (mdev->id_table[i].device) {
> > > > > >>> -               if (mdev->id_table[i].device <=3D 63)
> > > > > >>> -                       supported_classes |=3D BIT_ULL(mdev->=
id_table[i].device);
> > > > > >>> -               i++;
> > > > > >>> +       if (mdev->id_table !=3D NULL) {
> > > > > >>> +               while (mdev->id_table[i].device) {
> > > > > >>> +                       if (mdev->id_table[i].device <=3D 63)
> > > > > >>> +                               supported_classes |=3D
> > > > > >>> +                                       BIT_ULL(mdev->id_tabl=
e[i].device);
> > > > > >>> +                       i++;
> > > > > >>> +               }
> > > > > >>>          }
> > > > > >> This will cause 0 to be advertised as the supported classes.
> > > > > >>
> > > > > >> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need=
 to
> > > > > >> export it to via uAPI probably).
> > > > > >>
> > > > > >> Thanks
> > > > > >>
> > > > > > like the below one? not sure if this ok to use like this?
> > > > > > static struct virtio_device_id vp_vdpa_id_table[] =3D {
> > > > > > { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> > > > > > { 0 },
> > > > > > };
> > > > >
> > > > >
> > > > > Something like this.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > I have checked the code, this maybe can not work, because the
> > > > #define VIRTIO_DEV_ANY_ID 0xffffffff
> > > >  it want't work in
> > > >                 supported_classes |=3D BIT_ULL(mdev->id_table[i].de=
vice);
> > > > if we chane to
> > > >             supported_classes |=3D VIRTIO_DEV_ANY_ID;
> > > > the vdpa dev show will be
> > > > pci/0000:00:04.0:
> > > >   supported_classes net block < unknown class > < unknown class > <
> > > > unknown class > < unknown class > < unknown class > < unknow>
> > > >   max_supported_vqs 3
> > >
> > > That's why I suggest exporting the ANY_ID via uAPI and then we can fi=
x
> > > the userspace.
> > >
> > sure.But I think maybe we can fix this in another patch, since it
> > related to userspace
>
> Yes.
>
> >
> > > >   dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> > > > GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_
> > > >  I think we can use
> > > > static struct virtio_device_id id_table[] =3D {
> > > > { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > > { 0 },
> > > > };
> > > >  if we need to add another type of device, we can add the device id=
 at that type
> > > >
> > >
> > > My point is that, we have supported any virtio devices before. But
> > > after this change, we only support virtio-net.
> > >
> > > So if we choose to use id arrays, let's just add all possible virtio
> > > devices that are supported by the kernel here.
> > >
> > sorry=EF=BC=8C I didn't make it clearly,  I mean  we can use the vp_vdp=
a device id as
> >  static struct virtio_device_id id_table[] =3D {
> >  { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > { 0 },
> > since it now only support the net device
>
> This is not what I read from the code:
>
> static int virtio_vdpa_probe(struct vdpa_device *vdpa)
> {
> ...
> vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
>         if (vd_dev->vdev.id.device =3D=3D 0)
>                 goto err;
>
> vd_dev->vdev.id.vendor =3D ops->get_vendor_id(vdpa);
>         ret =3D register_virtio_device(&vd_dev->vdev);
> ...
> }
>
> ?
>
sure, Thanks I will post another verson

> Thanks
>
> >  and This will make the vp_vdpa work.
> >
> > Thanks
> > cindy
> >
> > > Thanks
> > >
> > > > Thanks
> > > > cindy
> > > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORT=
ED_CLASSES,
> > > > > >>> --
> > > > > >>> 2.34.1
> > > > > >>>
> > > > >
> > > >
> > >
> >
>

