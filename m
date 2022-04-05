Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A904F21A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiDEC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiDEC4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:56:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CDD4096BA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649124390; x=1680660390;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YzdBJ3M54EZS3crIo7do3ZbrEz3YRHCmFK7qH0ZuUxM=;
  b=IwwzzoyXn80GJ444Db9Yzhr63G++BeTfUBAxkNiqr+aE+SgMqG8xRWxL
   x8Yc6gGXNoyWwet46LhuLJFqLbPQaNwzVLXydcndrdhcge+2DHXikOrxg
   X3HeZFhyA8U57mhL9m9f5GkmJbdHn9n16kcXfysUxShJP8t1u0b9Ll1lT
   G6w0Tfal/+3W53buKNHghdEcyvLM5MwKLWm83Nn2eJ9iWLdbKvdN2+9z8
   7v6UAyU3iNuH7YfeLA82lXYwFHiO1lX5qt+x6joc8gZ6d+OH9JeBs/rYa
   VzbYatm8hiUwCZB9S/dv54l5YGtlWbDDbuuAw5cPqARm8BmlZejehyEMP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347084589"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="347084589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 18:38:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="569645614"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.208]) ([10.254.211.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 18:38:08 -0700
Message-ID: <806562e6-04b0-9ad9-e3cc-45e0bc12335e@linux.intel.com>
Date:   Tue, 5 Apr 2022 09:38:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, kernel@collabora.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: remove unneeded validity check on dev
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220313150337.593650-1-usama.anjum@collabora.com>
 <ace47a96-4e43-697a-4cfe-04544f014940@collabora.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <ace47a96-4e43-697a-4cfe-04544f014940@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 15:52, Muhammad Usama Anjum wrote:
> Any thoughts?

It looks good to me. I will queue it for v5.19.

Best regards,
baolu

> 
> On 3/13/22 8:03 PM, Muhammad Usama Anjum wrote:
>> dev_iommu_priv_get() is being used at the top of this function which
>> dereferences dev. Dev cannot be NULL after this. Remove the validity
>> check on dev and simplify the code.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index df5c62ecf942b..f79edbbd651a4 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2502,7 +2502,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>   		}
>>   	}
>>   
>> -	if (dev && domain_context_mapping(domain, dev)) {
>> +	if (domain_context_mapping(domain, dev)) {
>>   		dev_err(dev, "Domain context map failed\n");
>>   		dmar_remove_one_dev_info(dev);
>>   		return NULL;
> 
