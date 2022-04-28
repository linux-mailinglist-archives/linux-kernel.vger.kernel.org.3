Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035275129D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiD1DKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiD1DKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C1E50E07
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651115246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvU+ADphMHmXkpmACAoIK7qVjhSn7tp2TJRJg05m6I4=;
        b=MlDmM5Wn9fa+RyKhZNmu/gJy3tnBjhVabsz/1mfRjZ/ogr7c7pgYMg+pQuT4MV2GHbdkyp
        cRxuM8ppnekcu/c/GbYlZAM/MiCzh2RqUjn7bAMxoJY5F6cpcAC/D7v6E57ByuUxmj3Vm2
        He0chOL3B7Xf0lkkRq+UUoIuK29Ge3U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-9ZiOPzWMO26xUE3XzlijSA-1; Wed, 27 Apr 2022 23:07:24 -0400
X-MC-Unique: 9ZiOPzWMO26xUE3XzlijSA-1
Received: by mail-lf1-f70.google.com with SMTP id bq38-20020a056512152600b0047214ad540dso1427998lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TvU+ADphMHmXkpmACAoIK7qVjhSn7tp2TJRJg05m6I4=;
        b=ENG4Zi2ksN5dNeEDKFerGWs8JmkC8gaFLuZ3wVakq+/14/vmdx1i938RM1VVHfeHqt
         8Dw8E2cvZa45dEgs66GnEN8eftfW5Um+xp3Ic/7XEj9WqpRcx2sAI/1C3q3YNcSbfg1r
         prRz7C+h976Xjk8zrpeFbuee9hscck7ue8ezvCmpz/UFBhyshOl1TciUhYuCvriP5h78
         UQO+Jts2lFAZlfpBa784fQYo2KqAmfnC3KLho7CvxFY73NjX/Qg3K94CaeovfdOIUZNl
         XPLNa+3xZ/i6C9XptBWCIF5dDdTC9s1jKox0IHr6rJyqbPhyRH/HYH4Z9FJQYhP/7eAS
         rkPQ==
X-Gm-Message-State: AOAM530/eX+bf6RfKqbwTpIhgJtT7G49w332wmBAot81phuztsCr7w89
        FoZHkjpVPZCQILLWf19TaJFBWwfy3BUMEgK0UaIDxxLFQAdHVjo3Fos3hTrpEM28M+wM9c3zH2H
        59E8tsLVx6jNqTk94ZuNutNgV4Q/e3w2f0Y7Zyt5F
X-Received: by 2002:a05:6512:33c2:b0:472:33dd:9f46 with SMTP id d2-20020a05651233c200b0047233dd9f46mr2359739lfg.98.1651115242950;
        Wed, 27 Apr 2022 20:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8yMqQeXm0E0kg5h+lxPojpYyv2bDl4nXCwoI/TLwDC/R/01jvRHOvf69oY3waWTTt+1EpXJ4YjqEow7KB2bM=
X-Received: by 2002:a05:6512:33c2:b0:472:33dd:9f46 with SMTP id
 d2-20020a05651233c200b0047233dd9f46mr2359731lfg.98.1651115242769; Wed, 27 Apr
 2022 20:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com> <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
In-Reply-To: <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Apr 2022 11:07:11 +0800
Message-ID: <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 9:56 AM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Apr 27, 2022 at 12:04 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > =E5=9C=A8 2022/4/27 10:01, Cindy Lu =E5=86=99=E9=81=93:
> > > On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> wrot=
e:
> > >> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> > >>> To support the dynamic ids in vp_vdpa, we need to add the check for
> > >>> id table. If the id table is NULL, will not set the device type
> > >>>
> > >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >>> ---
> > >>>   drivers/vdpa/vdpa.c | 11 +++++++----
> > >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > >>> index 1ea525433a5c..09edd92cede0 100644
> > >>> --- a/drivers/vdpa/vdpa.c
> > >>> +++ b/drivers/vdpa/vdpa.c
> > >>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdp=
a_mgmt_dev *mdev, struct sk_buff *m
> > >>>          if (err)
> > >>>                  goto msg_err;
> > >>>
> > >>> -       while (mdev->id_table[i].device) {
> > >>> -               if (mdev->id_table[i].device <=3D 63)
> > >>> -                       supported_classes |=3D BIT_ULL(mdev->id_tab=
le[i].device);
> > >>> -               i++;
> > >>> +       if (mdev->id_table !=3D NULL) {
> > >>> +               while (mdev->id_table[i].device) {
> > >>> +                       if (mdev->id_table[i].device <=3D 63)
> > >>> +                               supported_classes |=3D
> > >>> +                                       BIT_ULL(mdev->id_table[i].d=
evice);
> > >>> +                       i++;
> > >>> +               }
> > >>>          }
> > >> This will cause 0 to be advertised as the supported classes.
> > >>
> > >> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
> > >> export it to via uAPI probably).
> > >>
> > >> Thanks
> > >>
> > > like the below one? not sure if this ok to use like this?
> > > static struct virtio_device_id vp_vdpa_id_table[] =3D {
> > > { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> > > { 0 },
> > > };
> >
> >
> > Something like this.
> >
> > Thanks
> >
> >
> I have checked the code, this maybe can not work, because the
> #define VIRTIO_DEV_ANY_ID 0xffffffff
>  it want't work in
>                 supported_classes |=3D BIT_ULL(mdev->id_table[i].device);
> if we chane to
>             supported_classes |=3D VIRTIO_DEV_ANY_ID;
> the vdpa dev show will be
> pci/0000:00:04.0:
>   supported_classes net block < unknown class > < unknown class > <
> unknown class > < unknown class > < unknown class > < unknow>
>   max_supported_vqs 3

That's why I suggest exporting the ANY_ID via uAPI and then we can fix
the userspace.

>   dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_
>  I think we can use
> static struct virtio_device_id id_table[] =3D {
> { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> { 0 },
> };
>  if we need to add another type of device, we can add the device id at th=
at type
>

My point is that, we have supported any virtio devices before. But
after this change, we only support virtio-net.

So if we choose to use id arrays, let's just add all possible virtio
devices that are supported by the kernel here.

Thanks

> Thanks
> cindy
>
>
>
> > >
> > >
> > >>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLA=
SSES,
> > >>> --
> > >>> 2.34.1
> > >>>
> >
>

