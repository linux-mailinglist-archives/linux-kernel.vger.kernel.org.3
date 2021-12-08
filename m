Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F253B46DAC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhLHSPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:15:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:35479 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238613AbhLHSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:15:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225155909"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="225155909"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:11:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="462858988"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:11:39 -0800
Date:   Wed, 8 Dec 2021 10:15:57 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/4] Enable PASID for DMA API users
Message-ID: <20211208101557.0a896d2d@jacob-builder>
In-Reply-To: <20211208131038.GQ6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20211208131038.GQ6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for the quick review.

On Wed, 8 Dec 2021 09:10:38 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Dec 07, 2021 at 05:47:10AM -0800, Jacob Pan wrote:
> > Modern accelerators such as Intel's Data Streaming Accelerator (DSA) can
> > perform DMA requests with PASID, which is a finer granularity than the
> > device's requester ID(RID). In fact, work submissions on DSA shared work
> > queues require PASID.  
> 
> Lets use plain langauge please:
> 
> DSA HW cannot do DMA from its RID, so always requires a PASID, even
> for kernel controlled DMA.
> 
> To allow it to use the DMA API we must associate a PASID with the
> iommu_domain that the DMA API is already using for the device's RID.
> 
> This way DMA tagged with the PASID will be treated exactly the same as
> DMA originating from the RID.
> 
Exactly, will incorporate in the next version.

> > DMA mapping API is the de facto standard for in-kernel DMA. However, it
> > operates on a per device/RID basis which is not PASID-aware.
> > 
> > This patch introduces the following driver facing API that enables DMA
> > API PASID usage: ioasid_t iommu_enable_pasid_dma(struct device *dev);  
> 
> This is the wrong API, IMHO
> 
> It should be more like
> 
> int iommu_get_dma_api_pasid(struct device *dev, ioasid_t *pasid);
This works. I had ioasid_t *pasid in my previous version but thinking we
can simplify the interface since we can have the reserved INVALID_IOASID
for return status.
But it seems to me _get_ does not convey the message that this API
actually enables/attaches the kernel DMA PASID. Perhaps call it
iommu_attach_dma_api_pasid() as you suggested in the ops function?

> void iommu_destroy_dma_api_pasid(struct device *dev);
> 
Sounds good

> > A PASID field is added to struct device for the purposes of storing
> > kernel DMA PASID and flushing device IOTLBs. A separate use case in
> > interrupt  
> 
> And this really should not be touching the struct device at all.
> 
I was thinking RID is per device, this PASID == RID. We could put in pci_dev
but there are non-PCI devices use SSID/PASID.

> At worst the PASID should be stored in the iommu_group.
> 
This also makes sense, default domain is stored per group. To support
multiple devices per group, we still need a per device flag for devTLB
flush. Right?

i.e. while doing iova unmap, IOTLBs are flush for all devices, but we
only need to flush the device TLBs for devices that has kernel DMA PASID.

> > message store (IMS) also hinted adding a PASID field to struct device.
> > https://lore.kernel.org/all/87pmx73tfw.ffs@nanos.tec.linutronix.de/
> > IMS virtualization and DMA API does not overlap.  
> 
> This is under debate, I'm skeptical it will happen considering the new
> direction for this work.
> 
Good to know, thanks.

> > Once enabled, device drivers can continue to use DMA APIs as-is. There
> > is no difference in terms of mapping in dma_handle between without
> > PASID and with PASID.  The DMA mapping performed by IOMMU will be
> > identical for both requests with and without PASID (legacy), let it be
> > IOVA or PA in case of pass-through.  
> 
> In other words all this does is connect the PASID to the normal
> DMA-API owned iommu_domain.
> 
Exactly! will incorporate. 


Thanks,

Jacob
