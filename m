Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65446F2D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbhLISQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:16:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:49468 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237501AbhLISQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:16:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225441522"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225441522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 10:09:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680433388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 10:09:46 -0800
Date:   Thu, 9 Dec 2021 10:14:04 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211209101404.6aefbe1c@jacob-builder>
In-Reply-To: <YbHie/Z4bIXwTInx@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <YbHie/Z4bIXwTInx@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On Thu, 9 Dec 2021 11:03:23 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Tue, Dec 07, 2021 at 05:47:11AM -0800, Jacob Pan wrote:
> > In-kernel DMA is managed by DMA mapping APIs, which supports per device
> > addressing mode for legacy DMA requests. With the introduction of
> > Process Address Space ID (PASID), device DMA can now target at a finer
> > granularity per PASID + Requester ID (RID).
> > 
> > However, for in-kernel DMA there is no need to differentiate between
> > legacy DMA and DMA with PASID in terms of mapping. DMA address mapping
> > for RID+PASID can be made identical to the RID. The benefit for the
> > drivers is the continuation of DMA mapping APIs without change.
> > 
> > This patch reserves a special IOASID for devices that perform in-kernel
> > DMA requests with PASID. This global IOASID is excluded from the
> > IOASID allocator. The analogous case is PASID #0, a special PASID
> > reserved for DMA requests without PASID (legacy). We could have
> > different kernel PASIDs for individual devices, but for simplicity
> > reasons, a globally reserved one will fit the bill.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
> >  drivers/iommu/intel/iommu.c                     | 4 ++--
> >  drivers/iommu/intel/pasid.h                     | 3 +--
> >  drivers/iommu/intel/svm.c                       | 2 +-
> >  drivers/iommu/ioasid.c                          | 2 ++
> >  include/linux/ioasid.h                          | 4 ++++
> >  6 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c index
> > ee66d1f4cb81..ac79a37ffe06 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c @@ -329,7 +329,7 @@
> > __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm) return
> > ERR_PTR(-ENOMEM); 
> >  	/* Allocate a PASID for this mm if necessary */
> > -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) -
> > 1);
> > +	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, (1U <<
> > master->ssid_bits) - 1);  
> 
> I'd rather keep hardware limits as parameters here. PASID#0 is reserved by
> the SMMUv3 hardware so we have to pass at least 1 here, but VT-d could
> change RID_PASID and pass 0. On the other hand IOASID_DMA_PASID depends on
> device drivers needs and is not needed on all systems, so I think could
> stay within the ioasid allocator. Could VT-d do an
> ioasid_alloc()/ioasid_get() to reserve this global PASID, storing it
> under the device_domain_lock?
> 
Yes, this works. We can delegate DMA PASID allocation to vendor drivers. My
proposal here is driven by simplicity.

> This looks like we're just one step away from device drivers needing
> multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
> the API towards that. It's probably as simple as keeping a kernel IOASID
> set at first, but then we'll probably want to optimize by having multiple
> overlapping sets for each device driver (all separate from the SVA set).
Sounds reasonable to start with a kernel set for in-kernel DMA once we need
multiple ones. But I am not sure what *overlapping* sets mean here, could
you explain?

> 


Thanks,

Jacob
