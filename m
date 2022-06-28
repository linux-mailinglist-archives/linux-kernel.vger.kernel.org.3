Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8B55E1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbiF1Lli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiF1Lle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:41:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306C2EA32
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656416493; x=1687952493;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5sDkMOObEeUMkZBt6eVhm9iKgpXHF4MwlPjCkr+LpE=;
  b=Ee82Rt5JzBb4WMg+z9dvxkd4a/kOCimgZ7NzmcP+WL98txVBeJNDXAqL
   uknkxcy0zIKEedefBJ9f+8tLU6xPYVUuE7OuzbwlFT84XcblnhSXuv8/9
   LP0+WpqVtTE9MvKL//qkIJ8bTb+IRXHsQ7Lza7sDD/FS/DoyjgSZBhYsf
   A9pg//4FUOU4/Qfb8lmckyVQexBxsY8kXlw2mBSwB0ZjairgF0Z0uWTR6
   KchYTS+oD8gbhfB+jB+3Nz7DNCi/csF1NFwbWg0HpK2XAFT5HoXXgQVDP
   AvXTZh8UfNbrTCUAnVsOlZOD63qaztB1G2jyyFqsvNp9EHPvDZop/i/2W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262127424"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="262127424"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646879736"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:41:29 -0700
Message-ID: <31116b7f-2ce5-ba18-bcc7-97076199d745@linux.intel.com>
Date:   Tue, 28 Jun 2022 19:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/28 16:50, Tian, Kevin wrote:
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>>>> GFP_KERNEL);
>>>> +	if (curr)
>>>> +		goto out_unlock;
>>> Need check xa_is_err(old).
>> Either
>>
>> (1) old entry is a valid pointer, or
> return -EBUSY in this case
> 
>> (2) xa_is_err(curr)
> return xa_err(cur)
> 
>> are failure cases. Hence, "curr == NULL" is the only check we need. Did
>> I miss anything?
>>
> But now you always return -EBUSY for all kinds of xa errors.

Fair enough. Updated like below.

         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {
                 ret = xa_err(curr) ? : -EBUSY;
                 goto out_unlock;
         }

Best regards,
baolu
