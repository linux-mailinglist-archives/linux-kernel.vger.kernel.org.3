Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B146E2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhLIGyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231487AbhLIGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639032648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LAHz5kErPapNWfxXhwQx55INnfEr0AqVPAKYpcd50M=;
        b=fvwKo2IpDZQ7zjv9UPeOOUY0WFC7bG8WS8ykk5CUM49t8SAjeCDnT9fqfl2skhQk1QNeZX
        EWdKYumAoI8e+Q+Uz3byLgQDKXXAsKCY0bwPOMlg+lRzThNlRlnCNGDCO8B05ZPoINcYbb
        oEl8D7aPSu9qcPdszFDHpP1pF2ve26o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-exlDigdLMAKe2YWqK3x_Ow-1; Thu, 09 Dec 2021 01:50:47 -0500
X-MC-Unique: exlDigdLMAKe2YWqK3x_Ow-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so4393792wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6LAHz5kErPapNWfxXhwQx55INnfEr0AqVPAKYpcd50M=;
        b=0HJYj8piJ64IgdlHAXMBeo17cRDoFdIUM3dPD5S8cKvzROCDmsYyzDu9ULjT9GruA5
         24fDx9UHG4uXNeceSYVHeyin5w1vut6kXE9ryB3WkGrgs1HRnDvt53tWRM4THx2hrRvU
         mKwjJnFBOyGBd6U35x5YT06wp8auh1hz0Yl5kkT+3rHHwrae1LS+2cFVBTcqP/hzGrgc
         MuzAETJgM/qVbTeyU2kURicibNvnmvZgMz19WMQsdGt6g6VcJIbxs79GddtpC6o5oueH
         DJj1eXALWo3bag9ZySomXo2hcvAq0dYTYQo1PIs9125nTWg/eZArlkIHpw6dT9pT+UeV
         5WGQ==
X-Gm-Message-State: AOAM532ZoQxSqUTi3JVugfhdhvIvZWQD/0faQmbX+CyIwuEYy3nh4zg3
        PLv3VGcrjOyDFt6LiIP8PVEcDbduqX1sluGu5oZBFpu7g7G5GhIIDQf2uJGE+MDug18k4cyb5kh
        8DhnVsMrKe63T/qQ26SVAXsuo
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr4633731wmr.55.1639032645935;
        Wed, 08 Dec 2021 22:50:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSQ+7SMkZksR/bTLJct8C9fLmx9Vp5o7BoLkjtzqV7OcXLbEsNhmbI6mVp9yFbg0JoJgwiNw==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr4633709wmr.55.1639032645732;
        Wed, 08 Dec 2021 22:50:45 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id h27sm8754726wmc.43.2021.12.08.22.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:50:44 -0800 (PST)
Date:   Thu, 9 Dec 2021 01:50:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211209014044-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208191239-mutt-send-email-mst@kernel.org>
 <67f08ec2-4121-d025-013d-915ee23ca369@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67f08ec2-4121-d025-013d-915ee23ca369@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:00:55AM +0800, 王贇 wrote:
> 
> 
> 在 2021/12/9 上午8:19, Michael S. Tsirkin 写道:
> [snip]
> > > > > > > 
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
> > > 
> > > Besides, I've checked that patch but it can't address our issue, we actually
> > > have this legacy pci device on arm platform, and the memory layout is
> > > unfriendly since allocation rarely providing page-address below 44bit, we
> > > understand the virtio-iommu case should not do force dma, while we don't
> > > have that so it's just working fine.
> > > 
> > > Regards,
> > > Michael Wang
> > 
> > BTW is it just the ring that's at issue?
> 
> Yes, the dma address for ring allocated as page can't fit the requirement.
> 
> > Figuring out we have this problematic config and then allocating just
> > the ring from coherent memory seems more palatable.
> 
> Agree, I'm also wondering why can't we force alloc 44bit-pfn page to fit the
> requirement? I mean if there are such pages, we should use them firstly as
> dma address for legacy devices, and only fail when there are no such pages
> at all, but can't find existing API to alloc page with such requirement...
> anyway.
> 
> > 
> > But please note we still need to detect config with a virtual iommu (can
> > be any kind not just virtio-iommu, smmu, vtd are all affected) and
> > disable the hacks. This is what the new DMA API I suggested would do.
> 
> Fair enough, any more details about the design of new API?
> 
> Regards,
> Michael Wang


The idea was that on some systems any DMA address is also a
physical address (as in the case of e.g. bounce buffers) and
then it can be used without VIRTIO_F_ACCESS_PLATFORM.

> 
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

