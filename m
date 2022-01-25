Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3949A991
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355560AbiAYDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:23:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:10769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1319531AbiAYDJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643080145; x=1674616145;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xFZOp1fGsqzXn/fUyBiOUmJ92pSPaeM/so/3oAX5ed4=;
  b=Bpm13Y77m0B7h97A69uPYIAZdah9C5hsqofPyraBp7E5Jzwp12mVZ5Lq
   7tzYXvRiprUN02iew7GRTKchluyc6LAvq2x2z3DGJjCx+BQTGUchvjiPe
   Q8nBSVveNeffmi3J6sXSa1djj9YjF5R2s9571FKU/tFAT/mBv4/TirXHe
   7KZVNHRgUot3cxQ0Bhx/MuO3+/wKTVCEKeUb/WnG9E4DuAnWlL5bj721u
   t2F5Rie/vHdfb7/wP6bA96NlVilWNTwNj5kepkdLMKYBtcdOwwUK5jTp8
   VpHE3Tf8+9/OdEQc5HFB+MfaagAhdaU8ImmjkZ9FpfMvbvfCIYIPjKVsv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306920745"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="306920745"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534532285"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:05:05 -0800
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
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52761ADE7D2696DDF0388A6F8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <229d72cf-3d1b-8df2-7438-309893f6aa9a@linux.intel.com>
Date:   Tue, 25 Jan 2022 11:04:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB52761ADE7D2696DDF0388A6F8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 5:48 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 24, 2022 3:11 PM
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index aa5486243892..111b3e9c79bb 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct
>> iommu_iotlb_gather *gather)
>>   	};
>>   }
>>
>> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device
>> *dev)
> 
> dev_get_iommu_ops or just dev_iommu_ops?

dev_iommu_ops() looks better.

Best regards,
baolu
