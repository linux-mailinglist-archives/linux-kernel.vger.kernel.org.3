Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0A46D71A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhLHPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:39:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:31715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhLHPjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:39:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="217875713"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="217875713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 07:35:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="503088404"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.146.48]) ([10.209.146.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 07:35:50 -0800
Message-ID: <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
Date:   Wed, 8 Dec 2021 08:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20211208131358.GR6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/2021 6:13 AM, Jason Gunthorpe wrote:
> On Tue, Dec 07, 2021 at 05:47:14AM -0800, Jacob Pan wrote:
>> In-kernel DMA should be managed by DMA mapping API. The existing kernel
>> PASID support is based on the SVA machinery in SVA lib that is intended
>> for user process SVA. The binding between a kernel PASID and kernel
>> mapping has many flaws. See discussions in the link below.
>>
>> This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
>> requests with PASID under the same mapping managed by DMA mapping API.
>> In addition, SVA-related bits for kernel DMA are removed. As a result,
>> DSA users shall use DMA mapping API to obtain DMA handles instead of
>> using kernel virtual addresses.
> Er, shouldn't this be adding dma_map/etc type calls?
>
> You can't really say a driver is using the DMA API without actually
> calling the DMA API..
>
>> +	/*
>> +	 * Try to enable both in-kernel and user DMA request with PASID.
>> +	 * PASID is supported unless both user and kernel PASID are
>> +	 * supported. Do not fail probe here in that idxd can still be
>> +	 * used w/o PASID or IOMMU.
>> +	 */
>> +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
>> +		idxd_enable_system_pasid(idxd)) {
>> +		dev_warn(dev, "Failed to enable PASID\n");
>> +	} else {
>> +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>>   	}
> Huh? How can the driver keep going if PASID isn't supported? I thought
> the whole point of this was because the device cannot do DMA without
> PASID at all?

There are 2 types of WQ supported with the DSA devices. A dedicated WQ 
type and a shared WQ type. The dedicated WQ type can support DMA with 
and without PASID. The shared wq type must have a PASID to operate. The 
driver can support dedicated WQ only without PASID usage when there is 
no PASID support.


>
> Jason
