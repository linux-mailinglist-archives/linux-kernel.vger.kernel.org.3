Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F004DA029
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350104AbiCOQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiCOQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:36:08 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515B506C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362095; x=1678898095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fe4aIhHkHpe8XfCx1caZ69+mJj0mxiFQCb/xeqLijs=;
  b=Cu1LIVNoVZ2Alg3gJk1mwAVJkZ9sYKYF4UETiW5Qlv3ZIaF241DlHtHr
   F31AaYNgaTxlwTmqidJiUZMYnlq+oNZHg9g+c37/SlCNIRBO58zoHFtGN
   eGdKghCfK55JVJfyE4awjB2j83/kRDZFrjeqtD+bhLvGzZ3BsWQBcw3ya
   V624SsyMd+JIvhnabBNM4QL8uqEtq3b0bicUM2b+T3tqqbOVTnS5CyziF
   uqp7kEVzHd4vfCdFi/3glLCNDmDr9TgyTOE/xbEpeyEQG3x0zpw8/YYwf
   /DpbCgvh0JT2PcHsW645nkbFOgBkZe0X8HrNHTSuS75A1BwQ4rD95EAVV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317074634"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="317074634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="690257656"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:34:54 -0700
Date:   Tue, 15 Mar 2022 09:38:10 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API
 users
Message-ID: <20220315093810.4b4c5ebf@jacob-builder>
In-Reply-To: <20220315143535.GX11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
        <20220315143535.GX11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 15 Mar 2022 11:35:35 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 14, 2022 at 10:07:09PM -0700, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a PASID for work submission within
> > the kernel
> > 2. Enable the kernel PASID on the IOMMU for the device
> > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs
> > as is. There is no difference in dma_handle between without PASID and
> > with PASID.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >  drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |  7 +++++
> >  include/linux/iommu.h     |  9 ++++++
> >  3 files changed, 81 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index b22034975301..d0ff1a34b1b6 100644
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
> >  	IOMMU_DMA_MSI_COOKIE,
> >  };
> >  
> > +static DECLARE_IOASID_SET(iommu_dma_pasid);
> > +
> >  struct iommu_dma_cookie {
> >  	enum iommu_dma_cookie_type	type;
> >  	union {
> > @@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain
> > *domain) domain->iova_cookie = NULL;
> >  }
> >  
> > +/**
> > + * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
> > + * @dev:	Device to be enabled
> > + *
> > + * DMA request with PASID will be mapped the same way as the legacy
> > DMA.
> > + * If the device is in pass-through, PASID will also pass-through. If
> > the
> > + * device is in IOVA map, the supervisor PASID will point to the same
> > IOVA
> > + * page table.
> > + *
> > + * @return the kernel PASID to be used for DMA or INVALID_IOASID on
> > failure
> > + */
> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t id, max;
> > +	int ret;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > +		return -ENODEV;  
> 
> Given the purpose of this API I think it should assert that the device
> has the DMA API in-use using the machinery from the other series.
> 
> ie this should not be used to clone non-DMA API iommu_domains..
> 
Let me try to confirm the specific here. I should check domain type and
rejects all others except IOMMU_DOMAIN_DMA type, right? Should also allow
IOMMU_DOMAIN_IDENTITY.

That makes sense.

> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 24607dc3c2ac..e6cb9b52a420 100644
> > +++ b/include/linux/dma-iommu.h
> > @@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain
> > *domain); int iommu_get_msi_cookie(struct iommu_domain *domain,
> > dma_addr_t base); void iommu_put_dma_cookie(struct iommu_domain
> > *domain); 
> > +/*
> > + * For devices that can do DMA request with PASID, setup a system
> > PASID.
> > + * Address modes (IOVA, PA) are selected by the platform code.
> > + */
> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
> > +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);  
> 
> The functions already have a kdoc, don't need two..
> 
Good point!

Thanks,

Jacob
