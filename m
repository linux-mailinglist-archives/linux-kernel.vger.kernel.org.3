Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472284B3EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbiBNAwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:52:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiBNAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:52:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B10522DD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644799930; x=1676335930;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A7I9zLwsVImPNRQZmWXcl3s9YjInQxRy4fAobdgLVV8=;
  b=IDDEoL1iQli1tJn1QHgU6p0TUIuqc2XlP+Ocl/TplM2DgX1otGltAC4b
   GQTz2nreJivlmYG8aOQ4VfifOjo0CAl1TDhtkLC3HLSH3FwL1/iI534fh
   B/n/HxkM75HRZ5I/y/9phC+hodEhoK8IyoomMo0J1HAmMdhShzXak1Km4
   Zror9s4FvJbGlqsug8jOssRZq9CMnNLxtDzmWkeW2u1MHUSRQB+kHmf9f
   t81JcoC1JlD94bz4TBnhHIj9B7eJ6HRrYzkhEcpwFXm80E+rqLhzTsXQy
   lRGViyI/NRnY2Y/m6J5t3ZeDb7E60Pc4tK98ExzWjTyGIf1DLoLOdYGqZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250192930"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="250192930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 16:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680109475"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 16:52:05 -0800
Message-ID: <73989fc7-b01e-fbfc-3fbd-cef0ec326334@linux.intel.com>
Date:   Mon, 14 Feb 2022 08:50:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
 <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2/9/22 9:52 PM, Robin Murphy wrote:
> On 2022-02-08 01:25, Lu Baolu wrote:
>> The is_attach_deferred iommu_ops callback is a device op. The domain
>> argument is unnecessary and never used. Remove it to make code clean.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h         |  2 +-
>>   drivers/iommu/amd/amd_iommu.h |  3 +--
>>   drivers/iommu/amd/iommu.c     |  3 +--
>>   drivers/iommu/amd/iommu_v2.c  |  2 +-
>>   drivers/iommu/intel/iommu.c   |  3 +--
>>   drivers/iommu/iommu.c         | 15 ++++++---------
>>   6 files changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index eb2684f95018..47ca7eca5d7b 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -269,7 +269,7 @@ struct iommu_ops {
>>       void (*put_resv_regions)(struct device *dev, struct list_head 
>> *list);
>>       int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>> -    bool (*is_attach_deferred)(struct iommu_domain *domain, struct 
>> device *dev);
>> +    bool (*is_attach_deferred)(struct device *dev);
>>       /* Per device IOMMU features */
>>       bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features 
>> f);
>> diff --git a/drivers/iommu/amd/amd_iommu.h 
>> b/drivers/iommu/amd/amd_iommu.h
>> index 416815a525d6..3b2f06b7aca6 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -116,8 +116,7 @@ void amd_iommu_domain_clr_pt_root(struct 
>> protection_domain *domain)
>>   extern bool translation_pre_enabled(struct amd_iommu *iommu);
>> -extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>> -                     struct device *dev);
>> +extern bool amd_iommu_is_attach_deferred(struct device *dev);
>>   extern int __init add_special_device(u8 type, u8 id, u16 *devid,
>>                        bool cmd_line);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 461f1844ed1f..37f2fbb4b129 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2215,8 +2215,7 @@ static void amd_iommu_get_resv_regions(struct 
>> device *dev,
>>       list_add_tail(&region->list, head);
>>   }
>> -bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>> -                  struct device *dev)
>> +bool amd_iommu_is_attach_deferred(struct device *dev)
>>   {
>>       struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
>> index 58da08cc3d01..7c94ec05d289 100644
>> --- a/drivers/iommu/amd/iommu_v2.c
>> +++ b/drivers/iommu/amd/iommu_v2.c
>> @@ -537,7 +537,7 @@ static int ppr_notifier(struct notifier_block *nb, 
>> unsigned long e, void *data)
>>       ret = NOTIFY_DONE;
>>       /* In kdump kernel pci dev is not initialized yet -> send 
>> INVALID */
>> -    if (amd_iommu_is_attach_deferred(NULL, &pdev->dev)) {
>> +    if (amd_iommu_is_attach_deferred(&pdev->dev)) {
>>           amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
>>                          PPR_INVALID, tag);
>>           goto out;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 2b5f4e57a8bb..80f1294be634 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5052,8 +5052,7 @@ intel_iommu_dev_disable_feat(struct device *dev, 
>> enum iommu_dev_features feat)
>>       }
>>   }
>> -static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
>> -                       struct device *dev)
>> +static bool intel_iommu_is_attach_deferred(struct device *dev)
>>   {
>>       return attach_deferred(dev);
> 
> Seems like there's no need to wrap this now?

I just realized that I have cleaned this up in this patch.

https://lore.kernel.org/linux-iommu/20220207064142.1092846-7-baolu.lu@linux.intel.com/

Best regards,
baolu
