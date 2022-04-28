Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913035129EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiD1DZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbiD1DZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 280AA98F44
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651116113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWTp4yaWdfWUPtHWFlBNQneS0qdCKFMJ9HDg1d8VUa8=;
        b=OtT27f76gYlSb30jRVcS8ea2qkmDHjJDaxIWqYrfQbMzOh6lzOjRILzv3WxX+g55t3bRRX
        D/beT0ZM3vIUP0IS8dnrRTglBw5i0CqwdFIT2KHx+gHWFTPH9bk5SDv0h3KzXdPDlWIJGx
        pqs1rWTpDwVn2yvoLM9pKk/95SzLhmU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-RFkJdZ_1Ni26JTcIH0nh1Q-1; Wed, 27 Apr 2022 23:21:51 -0400
X-MC-Unique: RFkJdZ_1Ni26JTcIH0nh1Q-1
Received: by mail-ed1-f71.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso1993332edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RWTp4yaWdfWUPtHWFlBNQneS0qdCKFMJ9HDg1d8VUa8=;
        b=1GuOdc+UuWyppabs+uTx653kCuT+ahGFjOw8xcL2f3YVAnfNI8SA9viIQDbwApRwhi
         bjmO7F2n113KWmOb3A4rnLSZ9bM0JUGTMIIxeYtG8zKBDJ//AVCVML7Fb+hvG1zl7YIo
         7g1lkiiWLXh5G7IKTdHHobXXCOvyh0GXYXU6x/GBZIX+n+5c1xmUo6z+qEqQfYzv4/FS
         mUP0zxlnhA1f9MsHoq0bVQHNAgRc6EyVXVfSB9r39PO3C7mHv/B3RyP13kRXw+H97fFN
         SCJdzVq1Tt8JpUhiwCbaDLN2Rk9cixihk1+pMbUMfjLR1hmAlMeOskOrE9OAdj5Ai+Qp
         kYlg==
X-Gm-Message-State: AOAM532qrqWN9A4yQtKwZqnupCWkUrT7kc4zVqU6GpS3eBB1u5LckzqS
        EpTpjOdlz/tus6QKn8ApF+I2mi5msvBlR8wI5qMi4bONnZFRjbry29BFeEgwBhm08cU23stwwLk
        cZsQw3UaQWxyEyZW8fhfkjN40BSL9GwlYTW/3O3CR
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id i3-20020a1709064fc300b006e066a5d59cmr28770500ejw.131.1651116109077;
        Wed, 27 Apr 2022 20:21:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVS2I0+viNy4osAXG1kjD9pnxU9sgoXgJ9kAdtvf3xONcbrWyidzTUb9rZNhBtITxIjolCSaHMRySkKl1cKtU=
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id
 i3-20020a1709064fc300b006e066a5d59cmr28770492ejw.131.1651116108889; Wed, 27
 Apr 2022 20:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com> <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
 <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
In-Reply-To: <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 28 Apr 2022 11:21:10 +0800
Message-ID: <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 11:07 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 9:56 AM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 12:04 PM Jason Wang <jasowang@redhat.com> wrote=
:
> > >
> > >
> > > =E5=9C=A8 2022/4/27 10:01, Cindy Lu =E5=86=99=E9=81=93:
> > > > On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> wr=
ote:
> > > >> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> > > >>> To support the dynamic ids in vp_vdpa, we need to add the check f=
or
> > > >>> id table. If the id table is NULL, will not set the device type
> > > >>>
> > > >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > >>> ---
> > > >>>   drivers/vdpa/vdpa.c | 11 +++++++----
> > > >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > >>> index 1ea525433a5c..09edd92cede0 100644
> > > >>> --- a/drivers/vdpa/vdpa.c
> > > >>> +++ b/drivers/vdpa/vdpa.c
> > > >>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct v=
dpa_mgmt_dev *mdev, struct sk_buff *m
> > > >>>          if (err)
> > > >>>                  goto msg_err;
> > > >>>
> > > >>> -       while (mdev->id_table[i].device) {
> > > >>> -               if (mdev->id_table[i].device <=3D 63)
> > > >>> -                       supported_classes |=3D BIT_ULL(mdev->id_t=
able[i].device);
> > > >>> -               i++;
> > > >>> +       if (mdev->id_table !=3D NULL) {
> > > >>> +               while (mdev->id_table[i].device) {
> > > >>> +                       if (mdev->id_table[i].device <=3D 63)
> > > >>> +                               supported_classes |=3D
> > > >>> +                                       BIT_ULL(mdev->id_table[i]=
.device);
> > > >>> +                       i++;
> > > >>> +               }
> > > >>>          }
> > > >> This will cause 0 to be advertised as the supported classes.
> > > >>
> > > >> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
> > > >> export it to via uAPI probably).
> > > >>
> > > >> Thanks
> > > >>
> > > > like the below one? not sure if this ok to use like this?
> > > > static struct virtio_device_id vp_vdpa_id_table[] =3D {
> > > > { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> > > > { 0 },
> > > > };
> > >
> > >
> > > Something like this.
> > >
> > > Thanks
> > >
> > >
> > I have checked the code, this maybe can not work, because the
> > #define VIRTIO_DEV_ANY_ID 0xffffffff
> >  it want't work in
> >                 supported_classes |=3D BIT_ULL(mdev->id_table[i].device=
);
> > if we chane to
> >             supported_classes |=3D VIRTIO_DEV_ANY_ID;
> > the vdpa dev show will be
> > pci/0000:00:04.0:
> >   supported_classes net block < unknown class > < unknown class > <
> > unknown class > < unknown class > < unknown class > < unknow>
> >   max_supported_vqs 3
>
> That's why I suggest exporting the ANY_ID via uAPI and then we can fix
> the userspace.
>
sure.But I think maybe we can fix this in another patch, since it
related to userspace

> >   dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> > GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_
> >  I think we can use
> > static struct virtio_device_id id_table[] =3D {
> > { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > { 0 },
> > };
> >  if we need to add another type of device, we can add the device id at =
that type
> >
>
> My point is that, we have supported any virtio devices before. But
> after this change, we only support virtio-net.
>
> So if we choose to use id arrays, let's just add all possible virtio
> devices that are supported by the kernel here.
>
sorry=EF=BC=8C I didn't make it clearly,  I mean  we can use the vp_vdpa de=
vice id as
 static struct virtio_device_id id_table[] =3D {
 { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
{ 0 },
since it now only support the net device and This will make the vp_vdpa wor=
k.

Thanks
cindy

> Thanks
>
> > Thanks
> > cindy
> >
> >
> >
> > > >
> > > >
> > > >>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_C=
LASSES,
> > > >>> --
> > > >>> 2.34.1
> > > >>>
> > >
> >
>

