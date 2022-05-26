Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED225347C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbiEZBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiEZBDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:03:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9968D6AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653527016; x=1685063016;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bexwVsjTlj4+OT7BIDQSL12xl4zS/h0VfNF+KXjKZKY=;
  b=Tn725YmF7ODvxzcqDVHrBnlf7SmXOGcYV0TQsIuTGSq1kw3fjBmx7tjj
   nJqLUys79vnvVd1AwUP/w7+PdHbBTcw2ntHsPv4d3tIBnPWxSuI+UbWO4
   PwjCjF1PxFXc/evmgbpLq6e4x/SkBWzzwy75gVLdd+3uru7G0lUUvKJ5h
   DB2qGrxKgkGZfg0GiVqkFdc3OuLwuxhXbI5PzLOD6lW/IlsXYsijDviWp
   Morb8XtxD5iCVGRndHsH/fBNQHO31M1SweWr6y4UuWD0XvDyUlime5Ty7
   +SP2z4jVTJmR1iNsIAdarXm6mwvDcIg8cteV/haPjrJO/0ZJ9si8su6l0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="274089303"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274089303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:03:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="602624206"
Received: from fengyuan-mobl.ccr.corp.intel.com (HELO [10.249.175.132]) ([10.249.175.132])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:03:23 -0700
Message-ID: <6588c871-a46d-9746-53da-c119d79370b5@linux.intel.com>
Date:   Thu, 26 May 2022 09:03:21 +0800
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
 <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
 <20220525152538.GD1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220525152538.GD1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 23:25, Jason Gunthorpe wrote:
> On Wed, May 25, 2022 at 01:19:08PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/24 21:44, Jason Gunthorpe wrote:
>>>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>>>> index 106506143896..210c376f6043 100644
>>>> +++ b/drivers/iommu/iommu-sva-lib.c
>>>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>>>    	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iommu_sva_find);
>>>> +
>>>> +/*
>>>> + * IOMMU SVA driver-oriented interfaces
>>>> + */
>>>> +struct iommu_domain *
>>>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
>>> This should return the proper type
>>>
>>
>> Can you please elaborate a bit on "return the proper type"? Did you mean
>> return iommu_sva_domain instead? That's a wrapper of iommu_domain and
>> only for iommu internal usage.
> 
> If you are exposing special SVA APIs then it is not internal usage
> only anymore, so expose the type.

Ah, got you. Thanks for the explanation.

Best regards,
baolu
