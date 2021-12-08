Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD746DB7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhLHSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:48:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:54972 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhLHSsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:48:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="324161246"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="324161246"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:45:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="543295465"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:45:21 -0800
Date:   Wed, 8 Dec 2021 10:49:39 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211208104939.732fa5b9@jacob-builder>
In-Reply-To: <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Wed, 8 Dec 2021 10:31:36 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Hi Jacob,
> 
> On 12/7/21 9:47 PM, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a kernel PASID for work submission
> > 2. Enable the kernel PASID on the IOMMU
> > 3. Establish address space for the kernel PASID that matches the default
> >     domain. Let it be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs
> > as is. There is no difference in dma_handle between without PASID and
> > with PASID.  
> 
> Can a device issue DMA requests with PASID even there's no system IOMMU
> or the system IOMMU is disabled?
> 
Good point. 
If IOMMU is not enabled, device cannot issue DMA requests with PASID. This
API will not be available. Forgot to add dummy functions to the header.

> Best regards,
> baolu


Thanks,

Jacob
