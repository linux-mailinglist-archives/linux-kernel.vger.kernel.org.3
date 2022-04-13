Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137294FF657
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiDMMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiDMMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:00:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE885D5C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649851067; x=1681387067;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KoV5gY7Wi2PGzlg0y3OcX3k0Vg2NKJrLgb3wz9X3dmU=;
  b=Ydz/IhAiHc72j/NXAWIVyBFLcspQ3vfQEIzXU9UR1yDrbSzU6RKJTUka
   qfAY9WaOweZlufFffQHVOM+EA4NsqmErhmzlF3X8ovMFQ+6DZQqfO5scu
   udSp//EYLmjC1hIwsHBsAHKUuDdoOzyoAjoIrNaMz7vc2jBU1go6ByACr
   j2D0NAJTYXwyN9g2LKvvn3xYmbl8frvYB0UlZnMEI1RMtd2M6I6NgVje6
   u9uyoJOIvbVPkz4m5vjwrH5a2UNj7munYLg7HzrvKHRjGLqXeNuDfGOdd
   0xy9o2Tqyh1YDM/xG7KTgNmUy6ihaqDXxrNjjK7++iDhMnMkkPFo6aRbL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260242961"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="260242961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:57:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="573236615"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67]) ([10.254.215.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:57:38 -0700
Message-ID: <c92d014a-9332-27d2-688b-48fc07efdebb@linux.intel.com>
Date:   Wed, 13 Apr 2022 19:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
 <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
In-Reply-To: <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/13 7:36, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 8:53 PM
>>
>>>
>>>> +	if (!handle) {
>>>> +		ret = -ENOMEM;
>>>> +		goto out_put_ioas;
>>>> +	}
>>>> +
>>>> +	/* The reference to ioas will be kept until domain free. */
>>>> +	domain = iommu_sva_alloc_domain(dev, ioas);
>>>
>>> Shouldn't we first try whether existing domains are compatible to this
>>> device?
>>
>> If we think that here domain represents a hardware pagetable actually
>> used by IOMMU for a {device, pasid}, we are able to use per-{device,
>> pasid} domain without checking compatibility. Sharing a domain among
>> devices under the same IOMMU may be an optimization. That could be done
>> in the IOMMU driver just like what vt-d driver is doing for pass-through
>> DMA domains.
>>
> 
> there is only one hardware page table per mm in this case. Multiple domains
> are required only due to compatibility reason as Jason/Robin pointed out
> in SMMU case. Given all other places create multiple domains per ioas only
> upon incompatibility, probably it's more consistent to doing so in this path
> too...

Sharing domain for compatible devices is valuable when the domain
supports map/unmap operations. That can reduce the number of map/unmap
calls and the resulting synchronization of IOTLB. But for SVA case, it's
a dumb domain which only provides attach/detach operations.

A similar case could be found on pass-through DMA domains. The iommu
core allocates a default domain for each group although all the domains
represent a same page table for the compatible devices. The VT-d driver
optimizes this by exporting a static identity domain.

Anyway, I am open for this. I can add a compatible domain list if most
of you like that way. :-)

Best regards,
baolu
