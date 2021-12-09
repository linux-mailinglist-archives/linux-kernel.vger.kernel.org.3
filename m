Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37146F1E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbhLIRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:33:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:65366 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238548AbhLIRdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:33:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324423816"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="324423816"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:30:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680417004"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:29:59 -0800
Date:   Thu, 9 Dec 2021 09:34:17 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211209093417.58767913@jacob-builder>
In-Reply-To: <20211209165715.GA566788@otc-nc-03>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
        <20211208104939.732fa5b9@jacob-builder>
        <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
        <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
        <20211209083249.7d775512@jacob-builder>
        <20211209165715.GA566788@otc-nc-03>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On Thu, 9 Dec 2021 08:57:15 -0800, "Raj, Ashok" <ashok.raj@intel.com> wrote:

> > Prefixes is disabled
> >  - Root Complexes may optionally support TLPs with PASID TLP Prefixes.
> > The mechanism used to detect whether a Root Complex supports the PASID
> > TLP Prefix is implementation specific  
> 
> Isn't implementation specific mechanism is IOMMU?
> 
I agree. In case of VT-d it would be in ecap.pasid bit.
> > "
> > For all practical purposes, why would someone sets up PASID for DMA
> > just to be ignored? An IOMMU interface makes sense to me.
> >   
> > > Yes, exactly. Imagining in the VM guest environment, do we require a
> > > vIOMMU for this functionality? vIOMMU is not performance friendly if
> > > we put aside the security considerations.
> > >   
> > The primary use case for accelerators to use in-kernel DMA will be in
> > pass-through mode. vIOMMU should be able to do PT with good performance,
> > right? no nesting, IO page faults.  
> 
> But from an enabling perspective when PASID is in use we have to mandate
> either the presence of an IOMMU, or some hypercall that will do the
> required plumbing for PASID isn't it? 
So the point is that we need either vIOMMU or virtio IOMMU to use PASID?
For the purpose of this discussion to decide whether iommu API or DMA API
should be used, I am still convinced it should be iommu API.

Unlike IOMMU on/off for DMA API (which is transparent to the driver), using
PASID is not transparent. Other than enabling the PASID, the driver has to
program the PASID explicitly. There is no point of doing this dance knowing
the PASID might be ignored.

Thanks,

Jacob
