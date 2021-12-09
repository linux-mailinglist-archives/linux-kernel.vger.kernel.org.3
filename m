Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8A46ED14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhLIQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:34:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:14334 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhLIQer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:34:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238083843"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238083843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:28:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="543650742"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:28:31 -0800
Date:   Thu, 9 Dec 2021 08:32:49 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211209083249.7d775512@jacob-builder>
In-Reply-To: <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
        <20211208104939.732fa5b9@jacob-builder>
        <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
        <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Thu, 9 Dec 2021 10:21:38 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> On 12/9/21 9:56 AM, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Thursday, December 9, 2021 2:50 AM
> >>  
> >>> Can a device issue DMA requests with PASID even there's no system  
> >> IOMMU  
> >>> or the system IOMMU is disabled?
> >>>  
> >> Good point.
> >> If IOMMU is not enabled, device cannot issue DMA requests with PASID.
> >> This API will not be available. Forgot to add dummy functions to the
> >> header. 
> > 
> > PASID is a PCI thing, not defined by IOMMU.
> > 
> > I think the key is physically if IOMMU is disabled, how will root
> > complex handle a PCI memory request including a PASID TLP prefix? Does
> > it block such request due to no IOMMU to consume PASID or simply ignore
> > PASID and continue routing the request to the memory controller?
> > 
> > If block, then having an iommu interface makes sense.
> > 
> > If ignore, possibly a DMA API call makes more sense instead, implying
> > that this extension can be used even when iommu is disabled.
> > 
> > I think that is what Baolu wants to point out.  
> 
Thanks for clarifying, very good point.
Looking at the PCIe spec. I don't see specific rules for RC to ignore or
block PASID TLP if not enabled.
"- A Root Complex that supports PASID TLP Prefixes must have a device
specific mechanism for enabling them. By default usage of PASID TLP
Prefixes is disabled
 - Root Complexes may optionally support TLPs with PASID TLP Prefixes. The
mechanism used to detect whether a Root Complex supports the PASID TLP
Prefix is implementation specific
"
For all practical purposes, why would someone sets up PASID for DMA just to
be ignored? An IOMMU interface makes sense to me.

> Yes, exactly. Imagining in the VM guest environment, do we require a
> vIOMMU for this functionality? vIOMMU is not performance friendly if we
> put aside the security considerations.
> 
The primary use case for accelerators to use in-kernel DMA will be in
pass-through mode. vIOMMU should be able to do PT with good performance,
right? no nesting, IO page faults.

> Best regards,
> baolu


Thanks,

Jacob
