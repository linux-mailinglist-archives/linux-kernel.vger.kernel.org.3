Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65909522D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiEKHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242819AbiEKHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:21:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05C1EAD5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652253701; x=1683789701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WRk+Mj38yZ5XuDxKKjAT+LROx+EdfwdtEsjJvOuTgP4=;
  b=GtZ5GGi9V0OvqJNrsGS/uNcTHWG0E4bedA5S0HkFzE5zNwh2p9QlOyPF
   cmg6w63YljZgUIzT0skLRsGYpjwz6w05JhaWo+q1Lo9ctRrtkYcqOaD5Q
   UxVZp4J6SUfP3TSZb2n6U2v6zNW4pX8Q+727oCp8uwM1a/PBYznEypYO7
   in1trTW12LxpledMz2V5EjepSzWYRo3SRA+mFl/Ao1XVTJfPnAaP6r5jf
   GCAFFrvLHBrGuzQmhmYs1t5cp8ZRe08wHG7ly39rK1dVpxxdsWFS2oKvU
   CQYc+G0uBPOa0N81knCI81S+0wEW0ijLxGVQgeCP9jLJ/ZkadLHyVC99S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249512766"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="249512766"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:21:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="542180435"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10]) ([10.255.30.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:21:35 -0700
Message-ID: <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
Date:   Wed, 11 May 2022 15:21:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510152330.GG49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 23:23, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:34PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	/*
>> +	 * TODO: Remove the drvdata parameter after kernel PASID support is
>> +	 * enabled for the idxd driver.
>> +	 */
>> +	if (drvdata)
>> +		return ERR_PTR(-EOPNOTSUPP);
> 
> Why is this being left behind? Clean up the callers too please.

Okay, let me try to.

> 
>> +	/* Allocate mm->pasid if necessary. */
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	/* Search for an existing bond. */
>> +	handle = xa_load(&dev->iommu->sva_bonds, mm->pasid);
>> +	if (handle) {
>> +		refcount_inc(&handle->users);
>> +		goto out_success;
>> +	}
> 
> How can there be an existing bond?
> 
> dev->iommu is per-device
> 
> The device_group_immutable_singleton() insists on a single device
> group
> 
> Basically 'sva_bonds' is the same thing as the group->pasid_array.

Yes, really.

> 
> Assuming we leave room for multi-device groups this logic should just
> be
> 
> 	group = iommu_group_get(dev);
> 	if (!group)
> 		return -ENODEV;
> 
> 	mutex_lock(&group->mutex);
> 	domain = xa_load(&group->pasid_array, mm->pasid);
> 	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
> 		domain = iommu_sva_alloc_domain(dev, mm);
> 
> ?

Agreed. As a helper in iommu core, how about making it more generic like
below?

+struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
+                                                   iosid_t pasid,
+                                                   unsigned int type)
+{
+       struct iommu_domain *domain;
+       struct iommu_group *group;
+
+       if (!pasid_valid(pasid))
+               return NULL;
+
+       group = iommu_group_get(dev);
+       if (!group)
+               return NULL;
+
+       mutex_lock(&group->mutex);
+       domain = xa_load(&group->pasid_array, pasid);
+       if (domain && domain->type != type)
+               domain = NULL;
+       mutex_unlock(&group->mutex);
+       iommu_group_put(group);
+
+       return domain;
+}

> 
> And stick the refcount in the sva_domain
> 
> Also, given the current arrangement it might make sense to have a
> struct iommu_domain_sva given that no driver is wrappering this in
> something else.

Fair enough. How about below wrapper?

+struct iommu_sva_domain {
+       /*
+        * Common iommu domain header, *must* be put at the top
+        * of the structure.
+        */
+       struct iommu_domain domain;
+       struct mm_struct *mm;
+       struct iommu_sva bond;
+}

The refcount is wrapped in bond.

Best regards,
baolu
