Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0801D533658
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiEYFTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiEYFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:19:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66981D337
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653455954; x=1684991954;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cjXO8vVlpxnhMYVXhRqJDGd35rZJ3LD3EJ/zDC/ghbU=;
  b=TNmedrveP5bET7DjkilBoynbfxBthHPTr1Ptmm+JhEiqZuAoRn/RJad+
   qIG8UkOWnLIrIiI/bdp9xqfCqNHxfvImV20Uj99HDJ27T2jzvdwN7fibg
   4LCiF/J8ffMVfqgXLoyHGCDSpI1Uz6ShQV373VhNdbWou+GE7VArjavkG
   wJ/ZdjHbM2XnWEKYQ/MY7Prnd8elkPM7KuEiAXY5JyhFa2JmaPXY5g3b2
   9BIKJtJd7IMPSDhGAPsBKy9JyyTnhIJsj2z6DabwAg11kvpj1KEiV5JhZ
   thJSD3Nnxs7ZFaxGQUdHbphsJQZO/caEdPkG60NtyV9zCT2FYKI8BlMtP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273715916"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273715916"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:19:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601660650"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:19:10 -0700
Message-ID: <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
Date:   Wed, 25 May 2022 13:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <20220524134440.GT1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220524134440.GT1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2022/5/24 21:44, Jason Gunthorpe wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..210c376f6043 100644
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +/*
>> + * IOMMU SVA driver-oriented interfaces
>> + */
>> +struct iommu_domain *
>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> This should return the proper type
> 

Can you please elaborate a bit on "return the proper type"? Did you mean
return iommu_sva_domain instead? That's a wrapper of iommu_domain and
only for iommu internal usage.

Best regards,
baolu
