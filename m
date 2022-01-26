Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3D49C0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiAZBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:53:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:15371 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236019AbiAZBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643161980; x=1674697980;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oI90OnN0LBZgNPGK9oSIcHjxmu/Ye7JY6xZhvKkRU+o=;
  b=ZiZ/b8mZ55Y4FtPJzu1WzHmdQeMdxLp6jW6YCHxBXDwiS8OU4JasSs+U
   8WuAoyALhGXkEt6gZ/tJavRLDSRo9UmbaZpyPL4RW25N0p6O1tTy6vVPj
   cvqCxPmfLjUnUBFGF6iBpGHO7m0X4haYUahG3rczvo140O1S9dkSEkZXs
   WWCYbbPbV0GzdeK1ehbd19gXXEifKAYk4B2/ZbeWRaPPhIjntNPxLHXc8
   8PiFjQblxH8Z4JthUtvTt0sjMp82U3l+muAWSZapr4CbbQ2gvXue9vXCa
   hdx/hWeNTg8PEZHApuz1+WA8b5+rBd2oPtrUQTzq+dayDV6vScMOJvYt+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227133939"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="227133939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="534988737"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 17:52:37 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
 <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
 <20220125151602.GL84788@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a43279ba-8a18-a4a7-f317-a5e2091a0c74@linux.intel.com>
Date:   Wed, 26 Jan 2022 09:51:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125151602.GL84788@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 11:16 PM, Jason Gunthorpe wrote:
> On Tue, Jan 25, 2022 at 02:48:02PM +0000, Robin Murphy wrote:
>   
>> Agreed, certainly an IOMMU_DOMAIN_SVA type that can both encapsulate the mm
>> and effectively replace iommu_sva seems like a logical and fairly small next
>> step. We already have the paradigm of different domain types supporting
>> different ops, so initially an SVA domain would simply allow bind/unbind
>> rather than attach/detach/map/unmap.
> 
> I hope we can quickly get to a PASID enabled generic attach/detach
> scheme - we really need this to do the uAPI part of this interface.

Agreed. Jacob is working on kernel DMA with PASID. He needs such
interfaces as well. I have worked out an implementation for vt-d driver.
It could be post for review inside Jacob's series for kernel DMA with
PASID.

> 
>> they are fundamentally different things in their own right, and the ideal
>> API should give us the orthogonality to also bind a device to an SVA domain
>> without PASID (e.g. for KVM stage 2, or userspace assignment of simpler
>> fault/stall-tolerant devices), or attach PASIDs to regular iommu_domains.
> 
> Yes, these are orthogonal things. A iommu driver that supports PASID
> ideally should support PASID enabled attach/detatch for every
> iommu_domain type it supports.
> 
> SVA should not be entangled with PASID beyond that SVA is often used
> with PASID - a SVA iommu_domain should be fully usable with a RID too.

The prototype of PASID enabled attach/detach ops could look like:

        int (*attach_dev_pasid)(struct iommu_domain *domain,
                                struct device *dev, ioasid_t id);
        void (*detach_dev_pasid)(struct iommu_domain *domain,
                                 struct device *dev, ioasid_t id);

But the iommu driver should implement different callbacks for

1) attaching an IOMMU DMA domain to a PASID on device;
    - kernel DMA with PASID
    - mdev-like device passthrough
    - etc.
2) attaching a CPU-shared domain to a PASID on device;
    - SVA
    - guest PASID
    - etc.

> 
> I'm hoping to see the core iommu code provide some simplified "SVA"
> API that under the covers creates a SVA domain and then does a normal
> PASID attach using the global PASID in the mm_struct - the
> driver should not care what, or even if, PASID is used for a SVA
> domain.
> 
> Jason
> 

Best regards,
baolu
