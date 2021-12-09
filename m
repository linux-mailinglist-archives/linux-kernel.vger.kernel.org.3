Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981FA46E0D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhLICZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:25:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:16958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhLICZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:25:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235511220"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="235511220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="516080276"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 08 Dec 2021 18:21:47 -0800
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
 <20211208104939.732fa5b9@jacob-builder>
 <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
Date:   Thu, 9 Dec 2021 10:21:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 9:56 AM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, December 9, 2021 2:50 AM
>>
>>> Can a device issue DMA requests with PASID even there's no system
>> IOMMU
>>> or the system IOMMU is disabled?
>>>
>> Good point.
>> If IOMMU is not enabled, device cannot issue DMA requests with PASID. This
>> API will not be available. Forgot to add dummy functions to the header.
>>
> 
> PASID is a PCI thing, not defined by IOMMU.
> 
> I think the key is physically if IOMMU is disabled, how will root complex
> handle a PCI memory request including a PASID TLP prefix? Does it block
> such request due to no IOMMU to consume PASID or simply ignore PASID
> and continue routing the request to the memory controller?
> 
> If block, then having an iommu interface makes sense.
> 
> If ignore, possibly a DMA API call makes more sense instead, implying that
> this extension can be used even when iommu is disabled.
> 
> I think that is what Baolu wants to point out.

Yes, exactly. Imagining in the VM guest environment, do we require a
vIOMMU for this functionality? vIOMMU is not performance friendly if we
put aside the security considerations.

Best regards,
baolu
