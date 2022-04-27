Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843D7510E83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357042AbiD0CFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349881AbiD0CFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8419B12096
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651024944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53mrPkeW9KOi0bl6N4Fte0+icOguROXqZAbaSV/DmGo=;
        b=a43Ip8qzLzaqdObpcucL72gEUd2wufndV1SyNya5E8zU/vSbmEufk3PBxqOh4w1QMUXMH3
        vsxGuwbgMvSzmVpkd5ybJ7nxVMYl4SMavaV95Whfr2SHwl3ApilkGXSMWDbPAFUC2TqOdi
        E6jXk20ELIXOZEGEBYYB5xbvGvlmrhM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-ZjTMPR_2O-O59-TryGYHhg-1; Tue, 26 Apr 2022 22:02:22 -0400
X-MC-Unique: ZjTMPR_2O-O59-TryGYHhg-1
Received: by mail-ej1-f71.google.com with SMTP id nc20-20020a1709071c1400b006f3726da7d3so201477ejc.15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53mrPkeW9KOi0bl6N4Fte0+icOguROXqZAbaSV/DmGo=;
        b=s88iCB+EPGUYIK7neNktccGC8nEJnZRCHn2ddkjyDI4fLMf88tsL/lCNshqpxssMxO
         zWI+N4HSA1MP5EVQtabywOcmXy6zgX420/a/3bV5/az/ytYSrQ6f2I+bkpuJmy8x/wXC
         gMoypRBMNzTe6cQHoborh76G7mYcu/d8hGovFzgqG+GXpMwJJ+k/1QxPblSEVU00y+2s
         eXa1H48Gpng22C/61ZYh/9Rbkaqyyv65krlbM5iSGSKnXAbfSkvPgbohVqyHABO/p7Ju
         IoEudjo8/dXgUZbQ4vHkoM4qogeN+nbB2OsFI0ji3cQ3m8pB/ZASivhshskDet3iO0M0
         pufQ==
X-Gm-Message-State: AOAM531C1shntCRnzgFipXllbMqiXa+hEOJkYsFsGMTMHS+DmZWVQaLt
        Lnd7tfwYjLOhJvzKElq9QlKbfwc2HbgbGn2X0oscq4Zdb1OrBm0L2ZzyMIHn4UAFESpTOM6NL6f
        Ym3SJZ6R5S9x3OdXQ0pxD/sVvadGJ17bUEUxguOyj
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id g12-20020a056402090c00b00415d3404ae2mr28082575edz.331.1651024941489;
        Tue, 26 Apr 2022 19:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKs+y0+3qWvY+IVaCiqw2RfHdBAhFgQvTiOo4p2FBOD+qS4pDrRNfnuJro7UGcKXZyrlyqYHuCVOIu4hdEbC8=
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id
 g12-20020a056402090c00b00415d3404ae2mr28082563edz.331.1651024941345; Tue, 26
 Apr 2022 19:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com> <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
In-Reply-To: <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 27 Apr 2022 10:01:42 +0800
Message-ID: <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct vdpa_mgmt_dev
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > To support the dynamic ids in vp_vdpa, we need to add the check for
> > id table. If the id table is NULL, will not set the device type
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 1ea525433a5c..09edd92cede0 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> >         if (err)
> >                 goto msg_err;
> >
> > -       while (mdev->id_table[i].device) {
> > -               if (mdev->id_table[i].device <= 63)
> > -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
> > -               i++;
> > +       if (mdev->id_table != NULL) {
> > +               while (mdev->id_table[i].device) {
> > +                       if (mdev->id_table[i].device <= 63)
> > +                               supported_classes |=
> > +                                       BIT_ULL(mdev->id_table[i].device);
> > +                       i++;
> > +               }
> >         }
>
> This will cause 0 to be advertised as the supported classes.
>
> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
> export it to via uAPI probably).
>
> Thanks
>
like the below one? not sure if this ok to use like this?
static struct virtio_device_id vp_vdpa_id_table[] = {
{ VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
{ 0 },
};


> >
> >         if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> > --
> > 2.34.1
> >
>

