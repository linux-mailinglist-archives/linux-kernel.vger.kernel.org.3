Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044D4E35CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiCVAzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiCVAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:55:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D4A36E3B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647910449; x=1679446449;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25WEx/VI04GLdRJN6w8aNF3alk3XvOfUYr/ih2ArDWI=;
  b=CWXHbuSiOhAf3tF9IVykXa7tN4czZ3mRdmliqNyavfEADjgsSUkZREOf
   k6OynFLWUVhQ49ZnXdRiG6rzClaQtFLLqNsMVrBsbByrTIU0ySbX0mgMF
   IAjjE25V8m2OcEL4Di88qcymIXz6HAspr/m8p2BY93FYWIrlJuGhlykCx
   BjyoUgvA6F1/+Kb5/7CNl3V7txqDYrZsBB9RNlL59/q9Hsthg2avu0NXO
   efhXWJzsVhuW8D6NuieHmL5t9tLVXX5LkvOpdV2Z+GCpIQLW5yodD3xwE
   OBv2JoZzMhpXadY6M4vVFIfojiIWUwsQBVvsO/KGNF1F9s8Y1uoJV1bOf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320889122"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="320889122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:54:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560121532"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85]) ([10.254.208.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:54:05 -0700
Message-ID: <355235cb-1fe9-cdd5-45a5-3105aead417d@linux.intel.com>
Date:   Tue, 22 Mar 2022 08:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
 <20220321114745.GI11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321114745.GI11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 19:47, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:21PM +0800, Lu Baolu wrote:
>> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O page
>> table which is shared from CPU host VA. Add a sva_cookie field in the
>> iommu_domain structure to save the mm_struct which represent the CPU
>> memory page table.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 36f43af0af53..3e179b853380 100644
>> +++ b/include/linux/iommu.h
>> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>>   
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
>> +
>>   /*
>>    * This are the possible domain-types
>>    *
>> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>>   				 __IOMMU_DOMAIN_DMA_API |	\
>>   				 __IOMMU_DOMAIN_DMA_FQ)
>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
>> +				 __IOMMU_DOMAIN_HOST_VA)
> 
> Is there any use for this in the core code? I feel like flags should
> only be created if the core code needs to test them in some way.

flags are some attributes of the domain and the combination of multiple
flags forms a domain type.

> 
>> @@ -95,6 +100,7 @@ struct iommu_domain {
>>   	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	struct mm_struct *sva_cookie;
> 
> Don't call a mm_struct a cookie please

Sure.

> 
> And why do we need this in core code?

Need to connect an SVA domain with mm.

Best regards,
baolu
