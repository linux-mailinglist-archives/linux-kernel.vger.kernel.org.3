Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D650248BE99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351000AbiALGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345659AbiALGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641969054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bK7XyK/gVW/nDtWgdJaGpYWUQoRdCOb/XtgxbXgPvnM=;
        b=N6qvUggzkydd0+GqfyLYAn0bcLJhIAve31LxzLXZJUf9Tpv/TfsmyCkJSrNlG/xGOSynu/
        CfEIvT7FXJcnb4EtroEg+xCxwKG9BOPBj0XQk5pWn1HTGBhAr0Uc0eYYvXAJEEzeG2hRTl
        COgLe6AaIbKNTtxJJOIDcVojOSlghfg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-AwNamtRXN1-CFqI53b2GMg-1; Wed, 12 Jan 2022 01:30:51 -0500
X-MC-Unique: AwNamtRXN1-CFqI53b2GMg-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso1300776edd.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 22:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bK7XyK/gVW/nDtWgdJaGpYWUQoRdCOb/XtgxbXgPvnM=;
        b=NMKblJRlXUKKWqmX4EG6XXvt9enlV+FioWfgPbkyCzBm0edd7b3jABj08bURfVw5QF
         97g//rFtpwQQGHJMMdpGrQ/rjQCpnhP7YcfNjcPn4HyBe+rmGFZX6x32tqa2cpnRRuqn
         j5PTLNtnmX6KtcB34iPj7Wuiekrc8z5L3jdWOtz0vRYXQCQNEN7Cidh0aBtiyg6euX5k
         bkFVWPv53LAaXeXcHnHwu0xsk0sfQ9oyDjmltUP7Q9VtoZHv+egrgTx0dfGzwJYcmOIu
         luiyyZb7pyMTBlOlT4IrTtcPmdJ2GiVINZoSv/jf6iradpXUzAgL+aLNgE24LPfsk23b
         6I1w==
X-Gm-Message-State: AOAM532oTxupEWRSptQF2KtqUKL7xQBTYaoo1tv9GmfW48/RHIZLwPpK
        C2YSS6dQZDZ1pPUp8PbHQ0PH577mMDdcfe+CKkvTHRHUuC6+l21xfXIjZ9kUwhp+T37Io+RNM0n
        CCwNiWucGBXh2gSttWAgM/RMU
X-Received: by 2002:a17:906:a148:: with SMTP id bu8mr6318690ejb.421.1641969049556;
        Tue, 11 Jan 2022 22:30:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNjiZRz5Py3VHe2DjEuMPn36+kac6X/JVuHHlQgUeOHbPVat7+JLR0moBJobNitXh5a97tOw==
X-Received: by 2002:a17:906:a148:: with SMTP id bu8mr6318683ejb.421.1641969049356;
        Tue, 11 Jan 2022 22:30:49 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
        by smtp.gmail.com with ESMTPSA id h2sm4186388ejo.169.2022.01.11.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 22:30:48 -0800 (PST)
Date:   Wed, 12 Jan 2022 01:30:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112013018-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:23:07AM +0800, Jason Wang wrote:
> On Tue, Jan 11, 2022 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 11, 2022 at 11:36:42AM +0800, 李东升 wrote:
> > > When virtio vdpa device removed, the abnormal damage of the device cannot be
> > > perceived normally, which will cause problems similar to:
> > >
> > > 43bb40c5b926
> >
> >
> > Should include the subject of the patch too.
> >
> > > Hence, add the ability to abort the command on surprise removal
> > >
> > > Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>
> >
> > When removing gracefully,
> > I am not sure we should break device unconditionally like this
> > before giving drivers a chance to clean up.
> > Should we just do it for surprise removal?
> 
> That requires a new method to query whether it's a surprise removal.
> 
> Thanks

We can check pci_device_is_present like virtio does.

> >
> > > ---
> > >  drivers/virtio/virtio_vdpa.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 4a9ddb44b2a7..fd930409d190 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
> > >  {
> > >   struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
> > >
> > > + virtio_break_device(vd_dev->vdev);
> > >   unregister_virtio_device(&vd_dev->vdev);
> > >  }
> > >
> > > --
> > > 2.17.1
> >

