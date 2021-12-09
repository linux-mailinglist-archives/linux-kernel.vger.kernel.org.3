Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13EE46E2B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhLIGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233238AbhLIGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639032043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HItKaEVThTkJ2QIHyp/bO4uhWwDFTwJR6Bm5V+C1o5Y=;
        b=WeESDI4AF1WSi/1ykAv4lRpcV8Q1ax25GGB0zuSWr0RBrTAX79j9CBI3/bOKbHjXAqckwI
        6/5H2M3P04bfi8JtGTgwGQfOa6IT2h5H6sNP8pxZ7+6fnkrUdgW+DULTtXletacbhcOPDU
        gXJEz4gnCmPyePQo09jilzMzcpDgsso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-juP5tGl-PuOv9-S8JkNOUQ-1; Thu, 09 Dec 2021 01:40:41 -0500
X-MC-Unique: juP5tGl-PuOv9-S8JkNOUQ-1
Received: by mail-wm1-f70.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so4350340wmd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HItKaEVThTkJ2QIHyp/bO4uhWwDFTwJR6Bm5V+C1o5Y=;
        b=ce1WpGv7LmZJ59LdrU03uEt4h5qjM084tO8o90vm9UC2PfXzVo1VgibOoYKG7K+yeW
         6JNao1Q/wO2i3A7eZf3DwNxKUxdCBGt2h32Wo1U40vu3zRh61wWrrCrktlzGHT1xRuWF
         NbUTA1/q36DJFLxJJy3kIxTSyMG7Kc2ss3lnFNTQUWO+nEFW/5fxHgVl9tHbFOlZHVAo
         T3+0Bp17sUd427RI6+0NXHn+AYxXFLUtsWvy0iTEfYovSPDvN9aSTNayJ80DDGZZDYoQ
         4BHnrUo1GsfxgC70qOEgapfOFqOF620FgA94zGqyMccAVQBY+BjGzdVbhY7Z0SA8509V
         GXyA==
X-Gm-Message-State: AOAM530qEzKrwLzOyFc54QxzXSu+O4Ih62vcFwpE9pyt9QAPuvbgTgMK
        iwuvlbMxL6KAvUPqIFnsSblyWIG+RQh7LuO1QM6pjXMrk/vxbTAsY3sFP/06QPouBAD4CORw7qI
        FWwbAv4coLN6zKWMIqj/sfQoX
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4269924wrq.626.1639032040269;
        Wed, 08 Dec 2021 22:40:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxigXNVg7SRW6zp5Vj3MsFSvI73LOepnWH/bWDIovVMHtbh4xBRqE80WZsdE/KLDQ1CeD2Hcw==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4269902wrq.626.1639032040068;
        Wed, 08 Dec 2021 22:40:40 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id e3sm4830673wrp.8.2021.12.08.22.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:40:39 -0800 (PST)
Date:   Thu, 9 Dec 2021 01:40:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211209013833-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208060115-mutt-send-email-mst@kernel.org>
 <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:21:36AM +0800, 王贇 wrote:
> 
> 
> 在 2021/12/8 下午7:08, Michael S. Tsirkin 写道:
> [snip]
> > > > > 
> > > > > Hi, Michael
> > > > > 
> > > > > Thanks for the comment, unfortunately modify device is not an option for us
> > > > > :-(
> > > > > 
> > > > > Is there any idea on how to solve this issue properly?
> > > > > 
> > > > > Regards,
> > > > > Michael Wang
> > > > 
> > > > By the way, there is a bug in the error message. Want to fix that?
> > > 
> > > Could you please provide more detail about the bug? We'd like to help fixing
> > > it :-)
> > 
> > virtio-pci 0000:14:00.0: platform bug: legacy virtio-mmio must ...
> > 
> > should be virtio-pci not virtio-mmio
> 
> Patch on the way~
> 
> > 
> > 
> > 
> > > Besides, I've checked that patch but it can't address our issue, we actually
> > > have this legacy pci device on arm platform, and the memory layout is
> > > unfriendly since allocation rarely providing page-address below 44bit, we
> > > understand the virtio-iommu case should not do force dma, while we don't
> > > have that so it's just working fine.
> > > 
> > > Regards,
> > > Michael Wang
> > 
> > Hmm wait a sec is it a physical device or a hypervisor?
> > If a physical one then doesn't it need VIRTIO_F_ORDER_PLATFORM
> > on ARM?
> 
> The PCI device is virtual, I can't see how VIRTIO_F_ORDER_PLATFORM help
> address this issue, legacy pci config is 32bit but it's 36, seems like will
> never be included?
> 
> Regards,
> Michael Wang

Oh, if the device is virtual then I think you should just update it please.
virtio 0.X is architecturally limited to small VMs,
if your hypervisor supports more it should emulate virtio 1.0.



> > 
> > 
> > 
> > > > 
> > > > 
> > > > > > 
> > > > > > > ---
> > > > > > >     drivers/virtio/virtio_pci_legacy.c | 10 ++++++++++
> > > > > > >     drivers/virtio/virtio_ring.c       |  3 +++
> > > > > > >     include/linux/virtio.h             |  1 +
> > > > > > >     3 files changed, 14 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > index d62e983..11f2ebf 100644
> > > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > @@ -263,6 +263,16 @@ int virtio_pci_legacy_probe(struct virtio_pci_device
> > > > > > > *vp_dev)
> > > > > > >     	vp_dev->setup_vq = setup_vq;
> > > > > > >     	vp_dev->del_vq = del_vq;
> > > > > > > 
> > > > > > > +	/*
> > > > > > > +	 * The legacy pci device requre 32bit-pfn vq,
> > > > > > > +	 * or setup_vq() will failed.
> > > > > > > +	 *
> > > > > > > +	 * Thus we make sure vring_use_dma_api() will
> > > > > > > +	 * return true during the allocation by marking
> > > > > > > +	 * force_dma here.
> > > > > > > +	 */
> > > > > > > +	vp_dev->vdev.force_dma = true;
> > > > > > > +
> > > > > > >     	return 0;
> > > > > > > 
> > > > > > >     err_iomap:
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index 3035bb6..6562e01 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -245,6 +245,9 @@ static inline bool virtqueue_use_indirect(struct
> > > > > > > virtqueue *_vq,
> > > > > > > 
> > > > > > >     static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > > > >     {
> > > > > > > +	if (vdev->force_dma)
> > > > > > > +		return true;
> > > > > > > +
> > > > > > >     	if (!virtio_has_dma_quirk(vdev))
> > > > > > >     		return true;
> > > > > > > 
> > > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > > index 41edbc0..a4eb29d 100644
> > > > > > > --- a/include/linux/virtio.h
> > > > > > > +++ b/include/linux/virtio.h
> > > > > > > @@ -109,6 +109,7 @@ struct virtio_device {
> > > > > > >     	bool failed;
> > > > > > >     	bool config_enabled;
> > > > > > >     	bool config_change_pending;
> > > > > > > +	bool force_dma;
> > > > > > >     	spinlock_t config_lock;
> > > > > > >     	spinlock_t vqs_list_lock; /* Protects VQs list access */
> > > > > > >     	struct device dev;
> > > > > > > -- 
> > > > > > > 1.8.3.1

