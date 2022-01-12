Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA248BD17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbiALCXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:23:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236391AbiALCXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641954201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmRB+aJwaYRiZq2kIb6YVd1ffIqdhpFrgpSgRgcEfjw=;
        b=LEhA5/RcnO+3ztsKQ1mkXI+FfAAgjQo1bGdvfq1DxZQWDJhnPILH9KeGqdOgoqTNg3vMVW
        m1i1az/8RACsDzhPImyhQchT4R8Gkazw5F8AzE9vDvN66qcfupHuwjM8qziLwIl8043hyh
        8Cpn5ea5jmeNu/d1SSnhLfJyiXpYT1w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-pbckmEBpMu-1JU52Pfi-0g-1; Tue, 11 Jan 2022 21:23:20 -0500
X-MC-Unique: pbckmEBpMu-1JU52Pfi-0g-1
Received: by mail-lf1-f69.google.com with SMTP id b7-20020ac25e87000000b0042ce6d38b71so629072lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GmRB+aJwaYRiZq2kIb6YVd1ffIqdhpFrgpSgRgcEfjw=;
        b=45M63dhWmjUOHRiQsHRR7w9hVLS8RGsAFbLnppqFmTn4hYsM6+GJqTtMpB51iutxU+
         a0H8oeX/j0Zj9tq8NQcNgvuNtQMIS0zIF1jM/weuxozrzVm8/W6ta5QgVNraca9To3Hl
         K6rUKVSuchrCK0s1XYQtVQ1iREo00lsGbWEfEJwWfCNCrZHpNA8h8VbPe6vjgSN24Uft
         aNemvK5K4Zk5QJEtbcw8EMMW8xZgJqM+NcLgZbFeH5VH65Pi+A3sf3NOGyEhMdwkYslI
         d1WX3cT+maNg18gLETLK9aAVVn7dY4N2M+rOwH7MxcZUSeS5x9ruTRAz+6BAecBH+KAH
         kc1Q==
X-Gm-Message-State: AOAM531oBl/l5WCuERttm3lohinQnr992Yg1X/HOARbEhRWUOl7+nyyf
        DtRc02ifMnwXt2g0cB6CRS3DZ5c0LXHWVDpSzM5rYVAl3rb/YzCcP15t+i4t36sAR78hJ61kfQj
        lZLibRP/aa72lQeJPh8AiBr6JfhtXq+nPBTH4MQ/9
X-Received: by 2002:a05:6512:68a:: with SMTP id t10mr5747183lfe.84.1641954198336;
        Tue, 11 Jan 2022 18:23:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5nx3vv9bUmaKDidSiIX9lkAtla7sB5vyGJsdGfLtYggTML9YCj2yt8pOrRvfdAyvYWnfNOjax5icaWEksrwk=
X-Received: by 2002:a05:6512:68a:: with SMTP id t10mr5747178lfe.84.1641954198178;
 Tue, 11 Jan 2022 18:23:18 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com> <20220111065033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220111065033-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 Jan 2022 10:23:07 +0800
Message-ID: <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jan 11, 2022 at 11:36:42AM +0800, =E6=9D=8E=E4=B8=9C=E5=8D=87 wro=
te:
> > When virtio vdpa device removed, the abnormal damage of the device cann=
ot be
> > perceived normally, which will cause problems similar to:
> >
> > 43bb40c5b926
>
>
> Should include the subject of the patch too.
>
> > Hence, add the ability to abort the command on surprise removal
> >
> > Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>
>
> When removing gracefully,
> I am not sure we should break device unconditionally like this
> before giving drivers a chance to clean up.
> Should we just do it for surprise removal?

That requires a new method to query whether it's a surprise removal.

Thanks

>
> > ---
> >  drivers/virtio/virtio_vdpa.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.=
c
> > index 4a9ddb44b2a7..fd930409d190 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *=
vdpa)
> >  {
> >   struct virtio_vdpa_device *vd_dev =3D vdpa_get_drvdata(vdpa);
> >
> > + virtio_break_device(vd_dev->vdev);
> >   unregister_virtio_device(&vd_dev->vdev);
> >  }
> >
> > --
> > 2.17.1
>

