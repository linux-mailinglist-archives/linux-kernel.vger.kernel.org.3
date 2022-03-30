Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF14EB9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiC3Ehi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiC3Ehc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:37:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF952252A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648614948; x=1680150948;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZoWj1iYnMYM7xNhqLBqkQbeVYvtNJbctzqx4BvnGBYs=;
  b=T90Klg3M0BHK2reIOaNCcqtqqZ9hFPoyW9G2CAVhzQay9tiJKI/uzFmu
   XDJ39Ns94pAkpGafUJZOrn3XhvKva0m2f9h6f7BSMsOXJZPrGZDshwLH6
   RSyrmWofrwUolep3+kw3nyPfW8bnHjt9oK4s8BpqpjHWy4nGDBHVDaMXe
   DjSYZslg1HI0FtN0q4PKbJC4U8LTbmDessLQJH0Lk4P2a3Apm+rkQzoxh
   LR4PSAwk1zZOqV9vNw4SKdMyszyEj6z1Owu26gMcF0j8/Ini6szvxxolT
   SKdG7QHbzLlPIuImzdu55wg05ERXiTtdvlssEzl2lLJbzdFKdfBTbw5P7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259629452"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="259629452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:35:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="565256560"
Received: from unknown (HELO [10.249.164.87]) ([10.249.164.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:35:43 -0700
Message-ID: <d46a3f73-4e0f-c86a-f8f8-ff207bedf4e5@linux.intel.com>
Date:   Wed, 30 Mar 2022 12:35:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220329143848.2e763727@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220329143848.2e763727@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/30 5:38, Jacob Pan wrote:
>> +static struct iommu_domain *
>> +iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct bus_type *bus = dev->bus;
>> +	struct iommu_sva_cookie *cookie;
>> +	struct iommu_domain *domain;
>> +	void *curr;
>> +
>> +	if (!bus || !bus->iommu_ops)
>> +		return NULL;
>> +
>> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> +	if (!cookie)
>> +		return NULL;
>> +
>> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		goto err_domain_alloc;
>> +
>> +	cookie->mm = mm;
>> +	cookie->pasid = mm->pasid;
> How do you manage the mm life cycle? do you require caller take mm reference?
> Or this should be limited to the current mm?
> 

The existing sva_bind() interface requires the caller to take the mm
reference before calling it. So mm is safe during sva bind() and
unbind().

drivers/iommu/iommu.c:
/**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
  * @drvdata: opaque data pointer to pass to bind callback
  *
  * Create a bond between device and address space, allowing the device 
to access
  * the mm using the returned PASID. If a bond already exists between 
@device and
  * @mm, it is returned and an additional reference is taken. Caller 
must call
  * iommu_sva_unbind_device() to release each reference.
  *
  * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called 
first, to
  * initialize the required SVA features.
  *
  * On error, returns an ERR_PTR value.
  */
struct iommu_sva *
iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void 
*drvdata)

Best regards,
baolu
