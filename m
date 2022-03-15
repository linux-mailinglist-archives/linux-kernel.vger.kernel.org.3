Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978F4DA008
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiCOQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350029AbiCOQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:29:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECD42BB2F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647361700; x=1678897700;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NlMuHVWGQMaaogSGPp+bKQ4Qb4Uj1fNrUqrs9vh7KA=;
  b=meVPf+2z9MaGY0dIh7bO4K15rO0tzigxrG8EhjRtSzpMmeu5iWxIxxBh
   XDj+6oFkFDuTmH5cxlMmsFfR0EFr3BJd/LPKhw6zYdtZn8SlSdnmS9VqM
   0DtucWCT5O4Ml+5d1YNItqWaSpFqIawbhrrfnOaUKHSyK+WOCS77euRWP
   14LppnBh6DtmclGBR4UJ4/oLNRNktdnsbwpLvUI+SrfKT9EdA5VXHTRId
   hZNmcBitM4QXXIB9aq3AbTX3UOugl/+pk0DtvbHNH9EUA7R0MFFdcqVQM
   GW+HVswEMRGA2Ar7W+y7dZfB62rWwExnfN9oz1Bh2wYGucnmbw/FGWWEF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255180783"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="255180783"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:28:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="646287929"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:28:20 -0700
Date:   Tue, 15 Mar 2022 09:31:35 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API
 users
Message-ID: <20220315093135.5c11066d@jacob-builder>
In-Reply-To: <20220315142216.GV11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
        <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
        <20220315142216.GV11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 15 Mar 2022 11:22:16 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 11:16:41AM +0000, Robin Murphy wrote:
> > On 2022-03-15 05:07, Jacob Pan wrote:  
> > > DMA mapping API is the de facto standard for in-kernel DMA. It
> > > operates on a per device/RID basis which is not PASID-aware.
> > > 
> > > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > > required for certain work submissions. To allow such devices use DMA
> > > mapping API, we need the following functionalities:
> > > 1. Provide device a way to retrieve a PASID for work submission within
> > > the kernel
> > > 2. Enable the kernel PASID on the IOMMU for the device
> > > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > > be IOVA or physical address in case of pass-through.
> > > 
> > > This patch introduces a driver facing API that enables DMA API
> > > PASID usage. Once enabled, device drivers can continue to use DMA
> > > APIs as is. There is no difference in dma_handle between without
> > > PASID and with PASID.  
> > 
> > Surely the main point of PASIDs is to be able to use more than one
> > of them?  
> 
> IMHO, not for the DMA API.
> 
Right, but we really need two here. One for DMA request w/o PASID (PASID 0)
and a kernel PASID for DMA request tagged w/ PASID.
Since DMA API is not per process, there is no need for more right now.

> I can't think of good reasons why a single in-kernel device should
> require more than one iommu_domain for use by the DMA API. Even with
> the SIOV cases we have been looking at we don't really see a use case
> for more than one DMA API iommu_domain on a single physical device.
> Do you know of something on the horizon?
> 
Not that I know.

> From my view the main point of PASIDs is to assign iommu_domains that
> are not used by the DMA API.
> 
Right, DMA API default to PASID 0. But IDXD device cannot use PASID 0 for
enqcmds.

> IMHO it is a device mis-design of IDXD to require all DMA be PASID
> tagged. Devices should be able to do DMA on their RID when the PCI
IDXD can do DMA w/ RID, the PASID requirement is only for shared WQ where
ENQCMDS is used. ENQCMDS has the benefit of avoiding locking where work
submission is done from multiple CPUs.
Tony, Dave?

> function is controlled by a kernel driver. I see this driver facing
> API as addressing a device quirk by aliasing the DMA API of the RID
> into a PASID and that is really all it is good for.
> 
> In any case I think we are better to wait for an actual user for multi
> DMA API iommu_domains to come forward before we try to build an API
> for it.
> 
What would you recommend in the interim?

Shall we let VT-d driver set up a special global PASID for DMA API? Then
IDXD driver can retrieve it somehow? But that still needs an API similar to
what I did in the previous version where PASID #1 was used.

Thanks,

Jacob
