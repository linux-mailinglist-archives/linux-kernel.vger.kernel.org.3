Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64EA48C685
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354321AbiALOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:52:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354308AbiALOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641999150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbB9qVe2cdADAoLi9p85NL4WatOPJExL0xOEqnBVVk0=;
        b=Ucm89owBNRQ30FIjBPEKpBKWsPly8jGZoRAZWX9HwTW1YCYDBl2OBHNn5LwJwFAlw8COqr
        8H/wPoJgALvTQiyaA1UZ/IqxB2I8s9l4gQCOR/MahCKi3gDEigB/DCd96/t5/xmuDxJXpR
        jXefJ/3TiCFdVTVv4huZ95LMnTkzKLg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-fQcCSRfcP-WG_n6gRmjodQ-1; Wed, 12 Jan 2022 09:52:29 -0500
X-MC-Unique: fQcCSRfcP-WG_n6gRmjodQ-1
Received: by mail-ed1-f69.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso2473985edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JbB9qVe2cdADAoLi9p85NL4WatOPJExL0xOEqnBVVk0=;
        b=mPB4wvvQSBTUGBhqNT3O7BBweEDzR8VxhoNR/s56GfSVccFT3tmYtVgcudtTUjOAzz
         80CaPiIKT9/Q7/ypPe0RlxtIVT7QI8PU3m3TuyccOkflJkdT9HdBfr6vqeJGveNtVN6t
         7AbDlXIgOifRzx/XZSd8bJB+9eDe6+0jlwWTo1wyWpJ+4B2ZnFcttX3tx28QLubR+nk7
         5YnVXmV/XsIqp6v+c6U0P7RtQOdx959FaVoGxp85+AE7aTg+1ryiIZ1Xu8Nfm3Iy9UfE
         JScO+Zh4efkKT1O0Fyy7QGkhXwpfV1k3+qseUEDCjyksOmmdheJx7kw6Er//pQlRaCfO
         R+pw==
X-Gm-Message-State: AOAM531IGn9AvmhLHrlW4THKHR9gyACvjoCQYgHPQ3NluJFWVB+e9aOG
        iXjKWFLNQJE7CCjZ/0pwL56LcVZBbf+0NJPAAyyyfKmH3XAH3/bKYGMa7rdWNfYX0EMATP26BE7
        ruI55Lw9FfTZfhtNDu74+YtxI
X-Received: by 2002:a17:906:3a55:: with SMTP id a21mr102711ejf.274.1641999148057;
        Wed, 12 Jan 2022 06:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuS6tdgV/MCq8jq1Hv/Sxpb7BZFZoP0GZA1WpMAVHCYU+7TrNcUVD8zlmUbrxmVIq5DlbDfA==
X-Received: by 2002:a17:906:3a55:: with SMTP id a21mr102691ejf.274.1641999147794;
        Wed, 12 Jan 2022 06:52:27 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
        by smtp.gmail.com with ESMTPSA id h3sm25788ede.32.2022.01.12.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:52:26 -0800 (PST)
Date:   Wed, 12 Jan 2022 09:52:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112095208-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
 <20220112013018-mutt-send-email-mst@kernel.org>
 <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:52:52PM +0800, Jason Wang wrote:
> On Wed, Jan 12, 2022 at 2:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jan 12, 2022 at 10:23:07AM +0800, Jason Wang wrote:
> > > On Tue, Jan 11, 2022 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jan 11, 2022 at 11:36:42AM +0800, 李东升 wrote:
> > > > > When virtio vdpa device removed, the abnormal damage of the device cannot be
> > > > > perceived normally, which will cause problems similar to:
> > > > >
> > > > > 43bb40c5b926
> > > >
> > > >
> > > > Should include the subject of the patch too.
> > > >
> > > > > Hence, add the ability to abort the command on surprise removal
> > > > >
> > > > > Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>
> > > >
> > > > When removing gracefully,
> > > > I am not sure we should break device unconditionally like this
> > > > before giving drivers a chance to clean up.
> > > > Should we just do it for surprise removal?
> > >
> > > That requires a new method to query whether it's a surprise removal.
> > >
> > > Thanks
> >
> > We can check pci_device_is_present like virtio does.
> 
> Though the PCI device is the main user, we are vdpa transport that is
> unaware of the type of its parent.
> 
> So it looks to me we need a new method and PCI parent and do call this
> function when needed.
> 
> Thanks

Sure.

> >
> > > >
> > > > > ---
> > > > >  drivers/virtio/virtio_vdpa.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 4a9ddb44b2a7..fd930409d190 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
> > > > >  {
> > > > >   struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
> > > > >
> > > > > + virtio_break_device(vd_dev->vdev);
> > > > >   unregister_virtio_device(&vd_dev->vdev);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.17.1
> > > >
> >

