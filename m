Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCD48C6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354406AbiALPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354401AbiALPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641999731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7f6mTNt7YaUSpPXZZCZPgQVj1/ZDxnN/2snqOElACbM=;
        b=NTJ3EvJlxBB0L00CT5WQA90EHqAa2pAmgNHhseieLOyvaF26BR+m3EXCKZMgk4rqQU3O9A
        r2+QzOHOXfAc1lUfAOAFIlJWOnybppp9dg0mJEqHuGhxJFmAzjegjDVMWIXbVndkGbzPMc
        +sLXIrjzo/szdQneafSHETXEGnQgihQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-uqH0CxOVOMKUI5luLVj_mw-1; Wed, 12 Jan 2022 10:02:09 -0500
X-MC-Unique: uqH0CxOVOMKUI5luLVj_mw-1
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso2482634edd.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 07:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7f6mTNt7YaUSpPXZZCZPgQVj1/ZDxnN/2snqOElACbM=;
        b=GX+aNfph5cYh6apOZ6SRQoprZ4T9sm6O/f+zKy3y0HSWQP0hUVCPeQeY0UVrp4BJjQ
         r19j0QpmAm6Ls1wXmZFHPOAyQP0T+ZKZwWahXfed78+6EPIBvYa8uRrp5DJmLRcd5bHF
         0w/jwoy6KILNAFxyuP/Vg5xly9ecjSOfJbmSWQm72ja7ab81sgWR/ASAcTP3xJxG+vgT
         eccKV6p+uxD3Mambi5/kiLNrJ10H0SxjfTufrh4SSGO6RDzYzgITYGndfYaSQMRRw4mm
         brtK9cpXHRe1OM3QvDdey+9LlOdTEs2dDWcLfHuJoYm5+WX+vRNBWLAZCslLglm9xuSF
         5v6Q==
X-Gm-Message-State: AOAM530N3iRl1hafGruv4ZIwfiZ8I8/6ekVqreqKdp14VoZXZAoxtr5p
        Q+7uPqZEgTf4YiU5+xy7nxtpShnQWxj4DrltTum46yZMraF2qCN0A766NPY7HmM/LyD9jidlQyu
        bjkI+qvgRliy4wO+uZSYXyhwJ
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr54964edz.414.1641999728541;
        Wed, 12 Jan 2022 07:02:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQRAl2uTikFNex8JGdk4/ia/gTryowOeWKg0HXYHyybKohwCELxbZl+CxPAksdmOkmMm7hQw==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr54945edz.414.1641999728332;
        Wed, 12 Jan 2022 07:02:08 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
        by smtp.gmail.com with ESMTPSA id h13sm16749edl.96.2022.01.12.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:02:07 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:02:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Cc:     jasowang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112100006-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
 <20220112013018-mutt-send-email-mst@kernel.org>
 <tencent_18F8A88D22E327230EF313BE@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_18F8A88D22E327230EF313BE@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jan 12, 2022 at 04:44:08PM +0800, 李东升 wrote:
> Indeed, there are hidden dangers for storage devices.
> So maybe we can break the device before virtio_net unregister_netdev and before
> virtio_blk reset
> 
> Unlike pci device, there is a manufacturer-driven existence between virtio vdpa
> and hardware devices, 
> unless the manufacturer provides a state interface, virtio vdpa and
> higher-level drivers cannot obtain the real hardware state.

I think for surprise removal you need to propagate the presence status up.
No way around that imho.

> 
> ------------------ Original ------------------
> From:  "mst"<mst@redhat.com>;
> Date:  Wed, Jan 12, 2022 02:30 PM
> To:  "jasowang"<jasowang@redhat.com>;
> Cc:  "李东升"<lidongsheng@dayudpu.com>; "virtualization"
> <virtualization@lists.linux-foundation.org>; "linux-kernel"
> <linux-kernel@vger.kernel.org>;
> Subject:  Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
> device
>  
> On Wed, Jan 12, 2022 at 10:23:07AM +0800, Jason Wang wrote:
> > On Tue, Jan 11, 2022 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jan 11, 2022 at 11:36:42AM +0800, 李东升 wrote:
> > > > When virtio vdpa device removed, the abnormal damage of the device cannot
> be
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
> 
> > >
> > > > ---
> > > >  drivers/virtio/virtio_vdpa.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index 4a9ddb44b2a7..fd930409d190 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device
> *vdpa)
> > > >  {
> > > >   struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
> > > >
> > > > + virtio_break_device(vd_dev->vdev);
> > > >   unregister_virtio_device(&vd_dev->vdev);
> > > >  }
> > > >
> > > > --
> > > > 2.17.1
> > >
> 

