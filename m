Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8E4F0F28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbiDDGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiDDGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:11:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E871C91F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649052595; x=1680588595;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=QUwLd3VDyRAL/XsTJb4wHwKxOdZmbH7Juo3nCntr/mU=;
  b=muP9pC+MqK2O3s2cVTS8RdG7/dRTl7OHguv9xGj5tC0xOvO8efyB9Xkz
   aSYJyR1AXWYRPG9W7+plusA0evf0gkA2/toxzp7lGW1+8iAF5UNwxJTe8
   ASiLMaOlwzD9yAmlWmF65AyIf4uHMOlQT+iT8qrGwfHntLq61T/zy3b7q
   f++DjHcUWiQNVccMFUCIjAuCVP4jrZsB4VlwSGYqAwZAlYikn7LKNP4WN
   5ifsoBA7OWKE25Iq4w4sIda1QUONBYawDOiXYn/vsA8f5BJSFhjt+WkLK
   lMlAdXGof4JCFh0Mc+anPFdgAK2nV4M61FTHx76kyjLe/I+BCdZxVv4MV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323620365"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323620365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:09:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="548536823"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:09:41 -0700
Message-ID: <9cac5d3b-3343-9e39-fe7b-3914d6b41a69@linux.intel.com>
Date:   Mon, 4 Apr 2022 14:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
In-Reply-To: <20220402233210.GM2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason and Kevin,

On 2022/4/3 7:32, Jason Gunthorpe wrote:
> On Sat, Apr 02, 2022 at 08:43:16AM +0000, Tian, Kevin wrote:
> 
>>> This assumes any domain is interchangeable with any device, which is
>>> not the iommu model. We need a domain op to check if a device is
>>> compatiable with the domain for vfio an iommufd, this should do the
>>> same.
>>
>> This suggests that mm_struct needs to include the format information
>> of the CPU page table so the format can be checked by the domain op?
> 
> No, Linux does not support multiple formats for CPU page tables,
> AFAICT, and creating the SVA domain in the first place should check
> this.
> 
>>> It means each mm can have a list of domains associated with it and a
>>> new domain is auto-created if the device doesn't work with any of the
>>> existing domains.
>>
>> mm has only one page table and one format. If a device is incompatible
>> with an existing domain wrapping that page table, how come creating
>> another domain could make it compatible?
> 
> Because domains wrap more than just the IOPTE format, they have
> additional data related to the IOMMU HW block itself. Imagine a SOC
> with two IOMMU HW blocks that can both process the CPU IOPTE format,
> but have different configuration.
> 
> So if device A users IOMMU A it needs an iommu_domain from driver A and
> same for another device B, even if both iommu_domains are thin
> wrappers around the same mm_struct.

How about below data structure design?

- [New]struct iommu_sva_ioas
  Represent the I/O address space shared with an application CPU address
  space. This structure has a 1:1 relationship with an mm_struct. It
  graps a "mm->mm_count" refcount during creation and drop it on release.

struct iommu_sva_ioas {
         struct mm_struct *mm;
         ioasid_t pasid;

         /* Counter of domains attached to this ioas. */
         refcount_t users;

         /* All bindings are linked here. */
         struct list_head bonds;
};

- [Enhance existing] struct iommu_domain (IOMMU_DOMAIN_SVA type)
  Represent a hardware pagetable that the IOMMU hardware could use for
  SVA translation. Multiple iommu domains could be bound with an SVA ioas
  and each graps a refcount from ioas in order to make sure ioas could
  only be freed after all domains have been unbound.

@@ -95,6 +101,7 @@ struct iommu_domain {
         void *handler_token;
         struct iommu_domain_geometry geometry;
         struct iommu_dma_cookie *iova_cookie;
+       struct iommu_sva_ioas *sva_ioas;
  };


- [Enhance existing] struct iommu_sva
   Represent a bond relationship between an SVA ioas and an iommu domain.
   If a bond already exists, it's reused and a reference is taken.

/**
  * struct iommu_sva - handle to a device-mm bond
  */
struct iommu_sva {
         struct device           *dev;
         struct iommu_sva_ioas   *sva_ioas;
         struct iommu_domain     *domain;
         /* Link to sva ioas's bonds list */
         struct list_head        node;
         refcount_t              users;
};

Best regards,
baolu
