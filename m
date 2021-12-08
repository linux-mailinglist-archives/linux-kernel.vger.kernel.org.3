Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF68246DDED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhLHWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:03:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:58694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237675AbhLHWDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:03:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238188078"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="238188078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 13:55:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="461879525"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 13:55:28 -0800
Date:   Wed, 8 Dec 2021 13:59:45 -0800
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
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211208135945.6d0a3b69@jacob-builder>
In-Reply-To: <20211208203022.GF6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20211208131358.GR6385@nvidia.com>
        <20211208115516.1d36fed9@jacob-builder>
        <20211208203022.GF6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 8 Dec 2021 16:30:22 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Dec 08, 2021 at 11:55:16AM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 8 Dec 2021 09:13:58 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > > This patch utilizes iommu_enable_pasid_dma() to enable DSA to
> > > > perform DMA requests with PASID under the same mapping managed by
> > > > DMA mapping API. In addition, SVA-related bits for kernel DMA are
> > > > removed. As a result, DSA users shall use DMA mapping API to obtain
> > > > DMA handles instead of using kernel virtual addresses.    
> > > 
> > > Er, shouldn't this be adding dma_map/etc type calls?
> > > 
> > > You can't really say a driver is using the DMA API without actually
> > > calling the DMA API..  
> > The IDXD driver is not aware of addressing mode, it is up to the user of
> > dmaengine API to prepare the buffer mappings. Here we only set up the
> > PASID such that it can be picked up during DMA work submission. I
> > tested with /drivers/dma/dmatest.c which does dma_map_page(),
> > map_single etc. also tested with other pieces under development.  
> 
> Ignoring the work, doesn't IDXD prepare the DMA queues itself, don't
> those need the DMA API?
> 
Do you mean wq completion record address? It is already using DMA API.
	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
&wq->compls_addr, GFP_KERNEL);
	desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;

> I'm still very confused how this can radically change from using kSVA
> to DMA API and NOT introduce some more changes than this. They are not
I am guessing the confusion comes from that fact the user of kSVA is not
merged. We were in the process of upstreaming then abandon it. Perhaps that
is why you don't see removing kSVA code?

> the same thing, they do not use the same IOVA's. Did you test this
> with bypass mode off?
Yes with dmatest. IOVA is the default, I separated out the SATC patch which
will put internal accelerators in bypass mode. It can also be verified by
iommu debugfs dump of DMA PASID (2) and PASID 0 (RIDPASID) are pointing to
he same default domain. e.g
PASID   PASID_table_entry
0       0x0000000119ed7004:0x0000000000800002:0x000000000000004d
1       0x0000000000000001:0x0000000000800001:0x000000000000010d
2       0x0000000119ed7004:0x0000000000800002:0x000000000000004d


> 
> Jason


Thanks,

Jacob
