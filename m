Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5328E48BF46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbiALHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237906AbiALHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641973986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ns9t0MBpHKEo9l+PjwNtwXiT/Qp5fHMZFtVVafL1/oM=;
        b=CSuBthrserbck+o/NhB58OnhxGCVjMm31LH0GFunQMTwdnKf5SS81Qs8gCAwC5NzEBGRtD
        uIAMp4E6e9Gzp3SQYPeToFOaVxzUxYHsD5z6t8F/VHC1fLRzDpIiXGQwjITZo1+ow1lLh9
        5pPvr/HX1NUpv9AN6u98d15p+91T7pE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-tEtKfLXrP1a4Vd1xpcpsyQ-1; Wed, 12 Jan 2022 02:53:04 -0500
X-MC-Unique: tEtKfLXrP1a4Vd1xpcpsyQ-1
Received: by mail-lf1-f72.google.com with SMTP id s16-20020a056512215000b0042bd76cb189so1110892lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ns9t0MBpHKEo9l+PjwNtwXiT/Qp5fHMZFtVVafL1/oM=;
        b=4sHnHRJRP2J6t17jL8q02xwplCgNsBhIujL+6lq5VLZidofK+7Xr6NHtkuE7WSn86O
         zKAtYM5xGS9d9FjOl4EHI337wkGVA4axYVsnDA7Ob1ZNLwUdfojdEqfN053xDBf9R85w
         5sZDe2DdQBBWHheC147sljMuH31w0u9SKHkVd3AkdHuDKsrcPv2Q1FZFNlN9LD3RI+qL
         My7z/w3H6x6vIqwH7Qqk7YKThhuufZmU5inh+ZHer+9BePnT26mSAkUJ4kh30wjEIfxe
         xx8aLGOvMDQGoDpYTjMdXFUlt9RL0HstQj9obRtPuxUOWtCrrtQWbH6qftPhewuEFhxE
         HrXw==
X-Gm-Message-State: AOAM530ahkGT3kqB8VKytIhYAdnnish1+8b5fcJSSxfxzwu4Qn0Agwdx
        nugBXtaIsLgNlivL+YQRh7qUJdqmqp45++jUl9pfyCVYKb3KsvVPtP4H3DzpEFTpA+h16IXVt2U
        mQi1aU3vlyos0rDOFJT5pDe9doUVsDwEqWxNGswAc
X-Received: by 2002:a2e:b791:: with SMTP id n17mr5365911ljo.307.1641973983370;
        Tue, 11 Jan 2022 23:53:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAS4eHnu7EzgPGuaFqm3MShiZCtBix4yIV1Kh9Y6VlrHnXbAYcHpDgkdS6SvoHCzGG98EktTkkUuZ0bogSlY4=
X-Received: by 2002:a2e:b791:: with SMTP id n17mr5365902ljo.307.1641973983187;
 Tue, 11 Jan 2022 23:53:03 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com> <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com> <20220112013018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220112013018-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 Jan 2022 15:52:52 +0800
Message-ID: <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     =?UTF-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 12, 2022 at 10:23:07AM +0800, Jason Wang wrote:
> > On Tue, Jan 11, 2022 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Tue, Jan 11, 2022 at 11:36:42AM +0800, =E6=9D=8E=E4=B8=9C=E5=8D=87=
 wrote:
> > > > When virtio vdpa device removed, the abnormal damage of the device =
cannot be
> > > > perceived normally, which will cause problems similar to:
> > > >
> > > > 43bb40c5b926
> > >
> > >
> > > Should include the subject of the patch too.
> > >
> > > > Hence, add the ability to abort the command on surprise removal
> > > >
> > > > Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>
> > >
> > > When removing gracefully,
> > > I am not sure we should break device unconditionally like this
> > > before giving drivers a chance to clean up.
> > > Should we just do it for surprise removal?
> >
> > That requires a new method to query whether it's a surprise removal.
> >
> > Thanks
>
> We can check pci_device_is_present like virtio does.

Though the PCI device is the main user, we are vdpa transport that is
unaware of the type of its parent.

So it looks to me we need a new method and PCI parent and do call this
function when needed.

Thanks

>
> > >
> > > > ---
> > > >  drivers/virtio/virtio_vdpa.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_v=
dpa.c
> > > > index 4a9ddb44b2a7..fd930409d190 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_devi=
ce *vdpa)
> > > >  {
> > > >   struct virtio_vdpa_device *vd_dev =3D vdpa_get_drvdata(vdpa);
> > > >
> > > > + virtio_break_device(vd_dev->vdev);
> > > >   unregister_virtio_device(&vd_dev->vdev);
> > > >  }
> > > >
> > > > --
> > > > 2.17.1
> > >
>

