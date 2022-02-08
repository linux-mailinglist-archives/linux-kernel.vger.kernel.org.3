Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DC4AD060
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbiBHEbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiBHEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:31:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AAC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644294671; x=1675830671;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sLnwdFLCJ4UV9sC7s0su5wmh+vi9Lj/1fhIUEK9dmJA=;
  b=CcreWIs7Igj61y8rLAWOaAPyM9uUg8S9CekjAmqzHdPYRA1Ms6QHlnZK
   Z1IY1OvwESheVO7xKeVKZFmJEWswsB2eluc3ualSBc0Kj7XuuLEW4RENh
   cNuIY2RG5hOEnlu+JSBZ6JRV0YPj0uk2wvtblrENtESPjUYJ4AgTbzU+0
   rfVFo4+MLMiMasJlx0Zce5VCRoGroqp/G1wwnccaYtpmQgJJHco9Vwxgj
   KK6Ahet/c7r+dTTqhBjMJflOVs3daYWaKFZJ/aDe0oA3n3YJmbAzd/SZh
   01BtdTzJkDctUCrnhvqZ+rnxKDag/yoITpJ2QQl81qisb3HtusoKDfCLS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236275232"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236275232"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:31:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677985554"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:31:07 -0800
Message-ID: <d658fd8d-00a2-273f-2685-dee55b96705e@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 04/10] iommu/vt-d: Remove iova_cache_get/put()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-5-baolu.lu@linux.intel.com>
 <ce1183f5-cec1-9438-4b5d-a4a99b046ab6@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <ce1183f5-cec1-9438-4b5d-a4a99b046ab6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 6:39 PM, John Garry wrote:
> On 07/02/2022 06:41, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 583ec0fa4ac1..e8d58654361c 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3348,9 +3348,6 @@ static inline int iommu_devinfo_cache_init(void)
>>   static int __init iommu_init_mempool(void)
>>   {
>>       int ret;
>> -    ret = iova_cache_get();
>> -    if (ret)
>> -        return ret;
>>       ret = iommu_domain_cache_init();
>>       if (ret)
>> @@ -3362,7 +3359,6 @@ static int __init iommu_init_mempool(void)
>>       kmem_cache_destroy(iommu_domain_cache);
>>   domain_error:
> 
> nit: is this label still really required? only failures in 
> iommu_domain_cache_init() jump to it, and that can return directly now.

It will be cleaned up in the next patch.

> 
> Thanks,
> John
> 
>> -    iova_cache_put();
> 

Best regards,
baolu
