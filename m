Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB8512A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbiD1DtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiD1DtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDDD941307
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651117569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PysP071vsdzg+AYtgM43Jv6G4Yc6NYLrTxTaRTUDRRA=;
        b=f70etNXLxzjbdHVt3lgbtcBa+zsmWB6pmzAL3LWQAYjDqi3T+jW4eaI0aWKOnV3/W/pjO+
        fADmyN2JqcJNrrcSsgIxUx7URVZu0VBmKoWVCY9dvRUxRSjsspiTqyF2KwRtptnQIkCcIn
        tp3HvsHZZaTGo4gWdFTzdENjYRbvnD8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-zh3ckDkKOjeeAKrIsdx14w-1; Wed, 27 Apr 2022 23:46:07 -0400
X-MC-Unique: zh3ckDkKOjeeAKrIsdx14w-1
Received: by mail-lf1-f69.google.com with SMTP id v13-20020a056512096d00b004487e1503d0so1475355lft.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PysP071vsdzg+AYtgM43Jv6G4Yc6NYLrTxTaRTUDRRA=;
        b=6t8RdzFib0cinYp9imt+7w2GhiWRNM0yLNKNmpnlrwQE/+KtFDqwmjMw5LARGE2XWa
         xtJVJ12C1tGN0ndHdpOtxbLu+9l7x2pIV0e8gEyrPzDkUE/cxY2Qqd9iBXQ3FslnzTrx
         nZab2APCdl+SpfN+KoGeGDib+rNduuGE8DMgvtm3hyrsFRck4F7uYyp8FJiGHfFqgvjs
         xXyhVoy8XVsUF0uCjjfPQBkaGnXddE4t29NEx4jEkz4w8httUXLmviBLrCjsV5iP9Gsp
         CMD5JlcNpOGjIcrWrSInx+ylyYaqg4Nvs91OlIeJzc8BW3EYjVrnaRGEpFeEsUEDuil6
         FPcA==
X-Gm-Message-State: AOAM532iUx8fH3BXuZurL4VettKXGrDJUyx2PUBJNCnjzAQ9HYKrLOMv
        QTg0Auykc/yyDqwmmI7cSTr9aC7DwM6ZcD1bV6CkutAnp2Lar7VGTJhYhpVJRNnGKdQ2nVft/8y
        oSWkR1MwyTWDmpKQUF6fGI++UzPUI5jaIDFwlAao7
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id m15-20020a0565120a8f00b00471948b9b6bmr23037831lfu.471.1651117565392;
        Wed, 27 Apr 2022 20:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrMXH3xs932KXDj4oihyw/ZsxZNXihwzCtWef8Zgy1842y47Rf2KL1q1rvwUlz6Fz+FW8fuZHnc8IPfe45plE=
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr23037823lfu.471.1651117565212; Wed, 27
 Apr 2022 20:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com> <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
 <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com> <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com>
In-Reply-To: <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Apr 2022 11:45:53 +0800
Message-ID: <CACGkMEuiXh-qXrz_ycQT_jjM0RpOe-G36w_eZyJEJNFp2UdVRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct vdpa_mgmt_dev
To:     Cindy Lu <lulu@redhat.com>
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

On Thu, Apr 28, 2022 at 11:21 AM Cindy Lu <lulu@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 11:07 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 9:56 AM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 12:04 PM Jason Wang <jasowang@redhat.com> wro=
te:
> > > >
> > > >
> > > > =E5=9C=A8 2022/4/27 10:01, Cindy Lu =E5=86=99=E9=81=93:
> > > > > On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> =
wrote:
> > > > >> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote=
:
> > > > >>> To support the dynamic ids in vp_vdpa, we need to add the check=
 for
> > > > >>> id table. If the id table is NULL, will not set the device type
> > > > >>>
> > > > >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > >>> ---
> > > > >>>   drivers/vdpa/vdpa.c | 11 +++++++----
> > > > >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> > > > >>>
> > > > >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > >>> index 1ea525433a5c..09edd92cede0 100644
> > > > >>> --- a/drivers/vdpa/vdpa.c
> > > > >>> +++ b/drivers/vdpa/vdpa.c
> > > > >>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct=
 vdpa_mgmt_dev *mdev, struct sk_buff *m
> > > > >>>          if (err)
> > > > >>>                  goto msg_err;
> > > > >>>
> > > > >>> -       while (mdev->id_table[i].device) {
> > > > >>> -               if (mdev->id_table[i].device <=3D 63)
> > > > >>> -                       supported_classes |=3D BIT_ULL(mdev->id=
_table[i].device);
> > > > >>> -               i++;
> > > > >>> +       if (mdev->id_table !=3D NULL) {
> > > > >>> +               while (mdev->id_table[i].device) {
> > > > >>> +                       if (mdev->id_table[i].device <=3D 63)
> > > > >>> +                               supported_classes |=3D
> > > > >>> +                                       BIT_ULL(mdev->id_table[=
i].device);
> > > > >>> +                       i++;
> > > > >>> +               }
> > > > >>>          }
> > > > >> This will cause 0 to be advertised as the supported classes.
> > > > >>
> > > > >> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need t=
o
> > > > >> export it to via uAPI probably).
> > > > >>
> > > > >> Thanks
> > > > >>
> > > > > like the below one? not sure if this ok to use like this?
> > > > > static struct virtio_device_id vp_vdpa_id_table[] =3D {
> > > > > { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> > > > > { 0 },
> > > > > };
> > > >
> > > >
> > > > Something like this.
> > > >
> > > > Thanks
> > > >
> > > >
> > > I have checked the code, this maybe can not work, because the
> > > #define VIRTIO_DEV_ANY_ID 0xffffffff
> > >  it want't work in
> > >                 supported_classes |=3D BIT_ULL(mdev->id_table[i].devi=
ce);
> > > if we chane to
> > >             supported_classes |=3D VIRTIO_DEV_ANY_ID;
> > > the vdpa dev show will be
> > > pci/0000:00:04.0:
> > >   supported_classes net block < unknown class > < unknown class > <
> > > unknown class > < unknown class > < unknown class > < unknow>
> > >   max_supported_vqs 3
> >
> > That's why I suggest exporting the ANY_ID via uAPI and then we can fix
> > the userspace.
> >
> sure.But I think maybe we can fix this in another patch, since it
> related to userspace

Yes.

>
> > >   dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> > > GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_
> > >  I think we can use
> > > static struct virtio_device_id id_table[] =3D {
> > > { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > { 0 },
> > > };
> > >  if we need to add another type of device, we can add the device id a=
t that type
> > >
> >
> > My point is that, we have supported any virtio devices before. But
> > after this change, we only support virtio-net.
> >
> > So if we choose to use id arrays, let's just add all possible virtio
> > devices that are supported by the kernel here.
> >
> sorry=EF=BC=8C I didn't make it clearly,  I mean  we can use the vp_vdpa =
device id as
>  static struct virtio_device_id id_table[] =3D {
>  { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> { 0 },
> since it now only support the net device

This is not what I read from the code:

static int virtio_vdpa_probe(struct vdpa_device *vdpa)
{
...
vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
        if (vd_dev->vdev.id.device =3D=3D 0)
                goto err;

vd_dev->vdev.id.vendor =3D ops->get_vendor_id(vdpa);
        ret =3D register_virtio_device(&vd_dev->vdev);
...
}

?

Thanks

>  and This will make the vp_vdpa work.
>
> Thanks
> cindy
>
> > Thanks
> >
> > > Thanks
> > > cindy
> > >
> > >
> > >
> > > > >
> > > > >
> > > > >>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED=
_CLASSES,
> > > > >>> --
> > > > >>> 2.34.1
> > > > >>>
> > > >
> > >
> >
>

