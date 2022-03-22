Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7814E35B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiCVAua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiCVAu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:50:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B02F3BD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647910142; x=1679446142;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0x7qIpjv0NuBVYWXT9Tw0mEj9Ru1y7+aMXqGBkCgSwc=;
  b=Ag6g7MDhLCmplK7Jes7zPXCvDBAbApNYYb0bLlwdlfSgxEWX1jE8c+ai
   p3a7q7IlHshEviy3dZhbQQ0hL2m8VT18hUgWcrsN3LiLfVXup844sufP6
   UvuobO4C1e+fIMWhgFUPO9wvqRN6hE5rCWgcHiDgiGrgrvNqAbxRGwnSB
   eD2sVePyJg7XeRSURHh1RdgSsmFOUQMSVwF70z9y/m/qp40y0fz/beIxG
   vmazL9lc1/bI4koQWNTyUkpb2CfDyrmw+dqLJvhb8snm07EGvAFwjzrXi
   qzz69Uc+GnFKeTS1Zu5fyaABgeFFBVFQ0Qc5APZo89HHC6wTBXTnSLsPs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282517335"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="282517335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:49:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560120071"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85]) ([10.254.208.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:48:59 -0700
Message-ID: <85d61ad6-0cf0-ac65-3312-32d0cdeb1b27@linux.intel.com>
Date:   Tue, 22 Mar 2022 08:48:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
 <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
 <BN9PR11MB5276981B9328F10E5FC89B728C179@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276981B9328F10E5FC89B728C179@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 8:26, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 21, 2022 6:22 PM
>>>> -				if (features >= 0)
>>>> +				if (features >= 0) {
>>>>    					info->pasid_supported = features | 1;
>>>> +					dev->iommu->pasid_bits =
>>>> +						fls(pci_max_pasids(pdev)) - 1;
>>> Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:
>>>
>>> 	ioasid_t max_pasid = dev_is_pci(dev) ?
>>> 		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
>>>
>>> though I'm not sure whether non-PCI SVA has been supported indeed, this
>>> patch implies a functional change here.
>>>
>>
>> The info->pasid_supported is only set for PCI devices. So the status is
>> that non-PCI SVA hasn't been supported. No functional change here from
>> this point of view.
>>
> 
> Then this information should be included in the commit msg.

Sure.

Best regards,
baolu
