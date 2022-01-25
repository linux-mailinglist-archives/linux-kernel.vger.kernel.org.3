Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC49249ABA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392334AbiAYFUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:20:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:56374 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391184AbiAYFD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643087037; x=1674623037;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jvQi+RQyehALY6K5e0Jia9BEKYL9WZi+E3wSrVsSdpc=;
  b=KYTkHIe4OaXs+LdZ3z3baNpAl0ovDiedY05FA5I7GaU5dZQxn3r8c51N
   fkqf3c+iTH8O6QcoXzJ1LhkR0Ty/rkLRUPGvieGWL34VrVe2Ai9nSZp1W
   gsWq0AVFdbZA/xbgcnD4+aRJY1FrARRHl7Z1hjlKbV3U3ebUS6DmicjPH
   XB1VXm6DUWxdiJFN0E5UWhgYTmsCf4BbBDIRjYbFpJB0YaXAFPze9W0R8
   1DWfm2nk+t/muxbrFrO6NbSZhLqJ6GPPV8Z5cSDRYtGYjvx2p8OydLGCS
   mxuBdpq4Axs+s3arssqkZtUG7wM3z5QE1DfOM/e7ZZ528awUH5T+5xSKX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233587806"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="233587806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 21:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534563268"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 21:00:14 -0800
Cc:     baolu.lu@linux.intel.com,
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
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <33060cd9-9115-013c-7253-52a36aa467e7@linux.intel.com>
Date:   Tue, 25 Jan 2022 12:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 5:58 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 24, 2022 3:11 PM
>> +/**
>> + * struct domain_ops - per-domain ops
>> + * @attach_dev: attach an iommu domain to a device
>> + * @detach_dev: detach an iommu domain from a device
> 
> What is the criteria about whether an op should be iommu_ops or domain_ops
> when it requires both domain and device pointers like above two (and future
> PASID-based attach)?

Generally ops belong to iommu_ops if they are only device oriented, and
domain_ops if they are only domain oriented. But it's really hard to
judge when both device and domain are involved. Good question. :-)

Perhaps we should leave the attach/detach interfaces in iommu_ops since
they are related to device capabilities. For example, some devices
support attach_dev_pasid, while others not.

> 
> Other examples include:
> 	@apply_resv_region

This will be deprecated.

> 	@is_attach_deferred

Should be at least device centric (domain doesn't play any role here).
Further step is to save the is_attach_deferred at a flag in dev_iommu
and remove the ops (as Robin suggested).

> 
> Thanks
> Kevin
> 

Best regards,
baolu
