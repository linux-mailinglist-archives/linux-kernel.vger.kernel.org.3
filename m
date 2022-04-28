Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F527512927
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiD1CAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiD1CAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 244914EDD8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651111016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg7BpXB18jK6A7IZMwZVA/IJ6u+tBfc3GXOTbmnF0Q4=;
        b=NnCTS1K8ei/S86GqP+xuDp68NWbXvJp9keyxY+GXw6e/XIH+tDOnMCRl/qdY1GEEdQzgUw
        6PJ2GuLVDqc8QU+tpuCWaGisdN1vDnE238OoIja0HMvGudNUDz/Q1dfMGjMTrEdpsMj9qs
        xfIGcFIXcUfqippN6xRCJ9VPahLrlI4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-kV3DRZk0O1OcsRKDqVaiAQ-1; Wed, 27 Apr 2022 21:56:54 -0400
X-MC-Unique: kV3DRZk0O1OcsRKDqVaiAQ-1
Received: by mail-ej1-f71.google.com with SMTP id jg25-20020a170907971900b006f010192c19so2062451ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vg7BpXB18jK6A7IZMwZVA/IJ6u+tBfc3GXOTbmnF0Q4=;
        b=wvfeBvfw5/97XSEJCSZE/9QkAQC4ct7gHS6Eo6RdbwBZIivz501Im8juDYfaZHoEJp
         ZCp+T74BaE+beFVKfKZMswDC4cmv2p2XLmF+OWbnrzBHwBKGfVjL5ELFhSXMBkxH6NfQ
         uDyT59Ls+J9cGlBNeFj2VXuCvDsOhscaod/SSh6AS7ys7twwYKVXIZlqxehkqagahlZB
         8OETotmLiW/AHfrX5maqyWQSGVXfrQQvX2Z5zLIg6FhiCbnCPLFVwt2cmlH5u99BwapD
         lVlYc9nL8w5jPWCqOiwgJZT6KWpWXuHCFkU5FW8CaZiygPDpCrB3DjrkzHHEveWRBc3v
         Q//g==
X-Gm-Message-State: AOAM531LlQKg2uYcrHhSq5H5wJ8KmvfSNcnVDIyh7VWLp67w7kJrNJ24
        O7ShupZEdiXySRhBeZUM+cOsqkgGaAbM7EAfxCcjRJ3aYgszwjbsciSjIBlzmGPqHaQ8ZXEAAzt
        zI/ENBNfnjDD6zzi+dMUDcvJSvrK25SpgjwTOgisG
X-Received: by 2002:a17:907:9621:b0:6d7:355d:6da5 with SMTP id gb33-20020a170907962100b006d7355d6da5mr28938701ejc.195.1651111013574;
        Wed, 27 Apr 2022 18:56:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz60bAzEWZCJrTFmwCis+8dy402pafSSsNhhEagw/mgmkY7QsoDOQL6nONSCj0HSPrwpdzooZTPGEnkUT4pOwc=
X-Received: by 2002:a17:907:9621:b0:6d7:355d:6da5 with SMTP id
 gb33-20020a170907962100b006d7355d6da5mr28938690ejc.195.1651111013386; Wed, 27
 Apr 2022 18:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com> <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
In-Reply-To: <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 28 Apr 2022 09:56:12 +0800
Message-ID: <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 12:04 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2022/4/27 10:01, Cindy Lu =E5=86=99=E9=81=93:
> > On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> wrote:
> >> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> >>> To support the dynamic ids in vp_vdpa, we need to add the check for
> >>> id table. If the id table is NULL, will not set the device type
> >>>
> >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >>> ---
> >>>   drivers/vdpa/vdpa.c | 11 +++++++----
> >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>> index 1ea525433a5c..09edd92cede0 100644
> >>> --- a/drivers/vdpa/vdpa.c
> >>> +++ b/drivers/vdpa/vdpa.c
> >>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_=
mgmt_dev *mdev, struct sk_buff *m
> >>>          if (err)
> >>>                  goto msg_err;
> >>>
> >>> -       while (mdev->id_table[i].device) {
> >>> -               if (mdev->id_table[i].device <=3D 63)
> >>> -                       supported_classes |=3D BIT_ULL(mdev->id_table=
[i].device);
> >>> -               i++;
> >>> +       if (mdev->id_table !=3D NULL) {
> >>> +               while (mdev->id_table[i].device) {
> >>> +                       if (mdev->id_table[i].device <=3D 63)
> >>> +                               supported_classes |=3D
> >>> +                                       BIT_ULL(mdev->id_table[i].dev=
ice);
> >>> +                       i++;
> >>> +               }
> >>>          }
> >> This will cause 0 to be advertised as the supported classes.
> >>
> >> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
> >> export it to via uAPI probably).
> >>
> >> Thanks
> >>
> > like the below one? not sure if this ok to use like this?
> > static struct virtio_device_id vp_vdpa_id_table[] =3D {
> > { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> > { 0 },
> > };
>
>
> Something like this.
>
> Thanks
>
>
I have checked the code, this maybe can not work, because the
#define VIRTIO_DEV_ANY_ID 0xffffffff
 it want't work in
                supported_classes |=3D BIT_ULL(mdev->id_table[i].device);
if we chane to
            supported_classes |=3D VIRTIO_DEV_ANY_ID;
the vdpa dev show will be
pci/0000:00:04.0:
  supported_classes net block < unknown class > < unknown class > <
unknown class > < unknown class > < unknown class > < unknow>
  max_supported_vqs 3
  dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_
 I think we can use
static struct virtio_device_id id_table[] =3D {
{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
{ 0 },
};
 if we need to add another type of device, we can add the device id at that=
 type

Thanks
cindy



> >
> >
> >>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASS=
ES,
> >>> --
> >>> 2.34.1
> >>>
>

