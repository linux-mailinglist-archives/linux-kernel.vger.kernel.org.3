Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7A49AB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S246651AbiAYExH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:53:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:56207 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1325657AbiAYEn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643085836; x=1674621836;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ePB8x5wsn46fcq0gstZC9w5tmuRZOJRLGU6KysgfNoE=;
  b=WqqCtDqH5DNkEa6FYxhKPyQ9RApBxIMMbkvlJkSLSnS9j7iw4dLsd3FR
   66dHYB4LVAR36U16XsYRPsBYiYwHC897pws24zV5FVteeUsA9+AEiA9tS
   mDF8muX1JeumUSbzED+hVFjx83Ff62gHzE7Z30Ymj6CHALRumkFdF/R4/
   5iGNKPkIvEqpj6o262Q5wQZ8bhdsrzOeyT3ELrUcngYkMe3VWboIakkBa
   LSajQ/LF+WUPLKYrRa9HjitF4LHSO98JU9IKQau9odszOaDW68bg/rPXb
   s3IFewZhVvdZwLRr2dSDnatNdicn83jGr25f3XP+8BVJWZlAjHaEJ+yO0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233585515"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="233585515"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 20:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534559224"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 20:43:50 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To:     Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <Ye5zUapC/YcZs7kl@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <62b47e7f-8704-24b1-2a94-bc456e7ad3a0@linux.intel.com>
Date:   Tue, 25 Jan 2022 12:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5zUapC/YcZs7kl@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 5:37 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>> to provide domain specific operations. Move domain-specific callbacks
>> from iommu_ops to the domain_ops and hook them when a domain is allocated.
> 
> Ah, that's what I meant earlier.  Perfect!
> 
> Nit:  I don't think vendor is the right term here.
> 
> Maybe something like:
> 
> iommut: split struct iommu_ops
> 
> Move the domain specific operations out of struct iommu_ops into a new
> structure that only has domain specific operations.  This solves
> the problem of needing to know if the method vector for a given
> operation needs to be retreived from the device or th domain.

Sure. Will use above description.

> 
>> +struct domain_ops {
> 
> This needs to keep an iommu in the name, i.e. iommu_domain_ops.

Sure.

> 
>> +	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> 
> Overly long line.

./scripts/checkpatch.pl --strict *.patch

didn't give me a WARN or CHECK. I will make it short anyway.

> 
>> +static inline void iommu_domain_set_ops(struct iommu_domain *domain,
>> +					const struct domain_ops *ops)
>> +{
>> +	domain->ops = ops;
>> +}
> 
> Do we really need this helper?

Unnecessary. I can set the pointer directly in the drivers.

> 
>> +static const struct domain_ops amd_domain_ops;
> 
> Can we avoid these forward declarations or would that cause too much
> churn?
> 

I don't like this either. But it's common to put the ops at the bottom
of the file in almost all iommu drivers.

Best regards,
baolu
