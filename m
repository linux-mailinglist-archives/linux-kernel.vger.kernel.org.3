Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66E4FE0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353703AbiDLMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354399AbiDLMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:42:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF468323
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649765319; x=1681301319;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9BKMBQYeN/NiMXBksh7LG49m1sBKXcvyEtC8Ta/5KDM=;
  b=mnsBnMNrdffTE+/oUuMVb+NvUM35iN/itfOtXCfBFBS9kE/wPM5oPlvi
   guMNucIWdG1qJV4urGsr8MjtDlspVA8wWILgOT62vtbsGL7J+iXeEdLDZ
   cNb8kCFvSMJjy5rR8BDlcdanso3LBkUwN5QTMr/JMDdaUB46KoOoGfZLZ
   EmdJslLTuSjZrIdLE2DaDP4cKKY8JOj4rVmzXVYG3D5SreyHepAr3t8t/
   FgVwvCxd7bMXobJCKhX9tqhYW8fjWys3iod10m9vVxIeGRNTebSJUZ77H
   PhIEQp1MqXTyuP/r4uftw42PVk87mRy0l00/Ty0Tbk05O6ybNEmBlIxC5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242946973"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242946973"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:08:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572735067"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:08:18 -0700
Message-ID: <ff4426d8-c76e-dd9b-96b9-fc35eede00c4@linux.intel.com>
Date:   Tue, 12 Apr 2022 20:08:16 +0800
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
 <20220410102443.294128-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52764EB5F4BB89909585662B8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 04/12] iommu/sva: Basic data structures for SVA
In-Reply-To: <BN9PR11MB52764EB5F4BB89909585662B8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 14:56, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>>
>> Use below data structures for SVA implementation in the IOMMU core:
>>
>> - struct iommu_sva_ioas
>>    Represent the I/O address space shared with an application CPU address
>>    space. This structure has a 1:1 relationship with an mm_struct. It
>>    graps a "mm->mm_count" refcount during creation and drop it on release.
> 
> s/graps/grabs

Thanks!

> 
>>
>> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>>    Represent a hardware pagetable that the IOMMU hardware could use for
>>    SVA translation. Multiple iommu domains could be bound with an SVA ioas
>>    and each graps a refcount from ioas in order to make sure ioas could
>>    only be freed after all domains have been unbound.
>>
>> - struct iommu_sva
>>    Represent a bond relationship between an SVA ioas and an iommu domain.
>>    If a bond already exists, it's reused and a reference is taken.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> btw given the actually intention of above structures does it make more
> sense to s/iommu_sva_ioas/iommu_sva/ and s/iommu_sva/iommu_sva_bond?

The use of iommu_sva has been scattered in external files as it's the
return type or parameter of the the iommu sva intefaces:

$ git grep "struct iommu_sva" :^drivers/iommu :^include/linux
drivers/dma/idxd/cdev.c:        struct iommu_sva *sva;
drivers/dma/idxd/cdev.c:        struct iommu_sva *sva;
drivers/dma/idxd/idxd.h:        struct iommu_sva *sva;
drivers/dma/idxd/init.c:        struct iommu_sva *sva;
drivers/misc/uacce/uacce.c:     struct iommu_sva *handle;

Your suggestion makes sense to me as I've also thought about it. :-)
It might be easier to arrive there through a separated cleanup series.

Best regards,
baolu
