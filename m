Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C4049CBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbiAZOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:00:12 -0500
Received: from foss.arm.com ([217.140.110.172]:41768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241824AbiAZOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:00:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E57741FB;
        Wed, 26 Jan 2022 06:00:10 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8953F793;
        Wed, 26 Jan 2022 06:00:07 -0800 (PST)
Message-ID: <ca66f612-879c-4620-0505-26af362b4240@arm.com>
Date:   Wed, 26 Jan 2022 14:00:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
 <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
 <20220125151602.GL84788@nvidia.com>
 <a43279ba-8a18-a4a7-f317-a5e2091a0c74@linux.intel.com>
 <20220126132731.GR84788@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220126132731.GR84788@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 13:27, Jason Gunthorpe via iommu wrote:
> On Wed, Jan 26, 2022 at 09:51:36AM +0800, Lu Baolu wrote:
> 
>>>> they are fundamentally different things in their own right, and the ideal
>>>> API should give us the orthogonality to also bind a device to an SVA domain
>>>> without PASID (e.g. for KVM stage 2, or userspace assignment of simpler
>>>> fault/stall-tolerant devices), or attach PASIDs to regular iommu_domains.
>>>
>>> Yes, these are orthogonal things. A iommu driver that supports PASID
>>> ideally should support PASID enabled attach/detatch for every
>>> iommu_domain type it supports.
>>>
>>> SVA should not be entangled with PASID beyond that SVA is often used
>>> with PASID - a SVA iommu_domain should be fully usable with a RID too.
>>
>> The prototype of PASID enabled attach/detach ops could look like:
>>
>>         int (*attach_dev_pasid)(struct iommu_domain *domain,
>>                                 struct device *dev, ioasid_t id);
>>         void (*detach_dev_pasid)(struct iommu_domain *domain,
>>                                  struct device *dev, ioasid_t id);
> 
> It seems reasonable and straightforward to me..
> 
> These would be domain ops?
>   
>> But the iommu driver should implement different callbacks for
>>
>> 1) attaching an IOMMU DMA domain to a PASID on device;
>>     - kernel DMA with PASID
>>     - mdev-like device passthrough
>>     - etc.
>> 2) attaching a CPU-shared domain to a PASID on device;
>>     - SVA
>>     - guest PASID
>>     - etc.
> 
> But this you mean domain->ops would be different? Seems fine, up to
> the driver.

Indeed, it makes little practical difference whether the driver provides 
distinct sets of ops or just common callbacks which switch on the domain 
type internally. I expect that's largely going to come down to personal 
preference and how much internal driver code is common between the paths.

> I'd hope to see some flow like:
> 
>   domain = device->bus->iommu_ops->alloc_sva_domain(dev)
>   domain->ops->attach_dev_pasid(domain, dev, current->pasid)
> 
> To duplicate the current SVA APIs

+1 - I'd concur that attach/detach belong as domain ops in general. 
There's quite a nice logical split forming here where domain ops are the 
ones that make sense for external subsystems and endpoint drivers to use 
too, while device ops, with the sole exception of domain_alloc, are 
IOMMU API internals. By that reasoning, attach/bind/etc. are firmly in 
the former category.

Thanks,
Robin.
