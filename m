Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87E4E3811
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiCVEwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiCVEwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:52:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FB107839
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647924653; x=1679460653;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cTZrAGX+t69jJcCH7JXAi2XQzqRxygaDZLgYJyVhgpM=;
  b=jh96nUWM1ZuuX6hfl63PEnyVzTQ4JdBl58x4pz3UgiTc/6KOcZ0DlcWc
   iKMmDtXx2qvGnhdmwWg/XEUx3wOhr50vDza6YqvV+mc5JdL7BMjyKG6vB
   5HDzNPTKarvwMQC98BAalOP6O2sjtn/yK+vd1XDaDBmug+31ziAXBbtv5
   ImfYVtFFI1tKIpOcJ9F/2cruF8arGxlEb+lOj1Iuxi1li00/utWNLlNOt
   j42VDlTY3U4r7DUvFhYAuJfIi7AYw5S4bi6GqgEaInweA/zHBeGmgUaNE
   VtM5mTSFp+6ibyvkF/e1YtcjLGeQ4laK9EjVSOcZwxN5kKSczs24LyUQV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="256542391"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="256542391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:50:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518724693"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186]) ([10.254.209.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:50:47 -0700
Message-ID: <966d28f6-3b87-45c5-e758-f38eb339e3c6@linux.intel.com>
Date:   Tue, 22 Mar 2022 12:50:45 +0800
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
Subject: Re: [PATCH RFC 09/11] iommu: Add iommu_get_domain_for_dev_pasid()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-10-baolu.lu@linux.intel.com>
 <20220321124058.GO11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321124058.GO11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 20:40, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:28PM +0800, Lu Baolu wrote:
>> @@ -3098,7 +3101,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   	if (iommu_group_device_count(group) != 1)
>>   		goto out_unlock;
>>   
>> +	xa_lock(&group->pasid_array);
>> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			    domain, GFP_KERNEL);
>> +	xa_unlock(&group->pasid_array);
>> +	if (curr)
> 
> curr can be an xa_err that should be propogated.

Yes, should check xa_err().

> 
>> +		goto out_unlock;
>> +
>>   	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
>> +	if (ret)
>> +		xa_erase(&group->pasid_array, pasid);
>>   
>>   out_unlock:
>>   	mutex_unlock(&group->mutex);
>> @@ -3118,6 +3130,25 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>   
>>   	mutex_lock(&group->mutex);
>>   	domain->ops->detach_dev_pasid(domain, dev, pasid);
>> +	xa_erase(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +}
>> +
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain = xa_load(&group->pasid_array, pasid);
>>   	mutex_unlock(&group->mutex);
>>   	iommu_group_put(group);
> 
> This whole API seems sketchy - what is the lifecycle of the returned
> iommu_domain and what prevents it from being concurrently freed after
> unlocking?

Agreed. The domain could be used in page fault handling thread, hence
need a mechanism to guarantee the concurrence.

Best regards,
baolu
