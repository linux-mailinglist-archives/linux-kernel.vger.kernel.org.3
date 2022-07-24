Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5B57F3AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiGXHX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiGXHX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:23:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A413D6D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658647405; x=1690183405;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W/ZfiGZet5U/LoLWUKDc9YKyt+TrQHvH31tE+Q6WVVY=;
  b=kFKeqBRDQSDL7ZfBiQDMgxWCrQaNfF0g201rfRp0FU9PZeMoF5mroC7a
   YolRkeGG0aU7eNKDsD/kWYT+fG+0atyc+yEX6kWW5htHhTnDDwcbezhru
   fOeLt306MtY+IatTaS3kS5a9y3fS/ocjJmWhIP0KZ1xIb+IllzR5gs1VF
   q7YHoQdu/suKGb/GlNmbPX4qxpd5gbbjfjxcmU90xakpfhisWqKx6WoUc
   rhNcfIYDvxRi8kmT8MvaOya32ghNHcCeXBqRHaMOljxHAqEBk65ExISuy
   115K6cN1Z6/KUC9ALQPUg/A1KesVrEgFrNHPdZWqgOSX14NW0UQlWZDvy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313263959"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="313263959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:23:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657737876"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 00:23:21 -0700
Message-ID: <5f845a90-97ba-e994-c8b9-91fc6f3ea1c1@linux.intel.com>
Date:   Sun, 24 Jul 2022 15:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723141118.GD79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/23 22:11, Jason Gunthorpe wrote:
>> +
>> +	/*
>> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
>> +	 * then singleton can know from the device count in the group.
>> +	 */
>> +	return true;
>> +}
> I would be happer if probe was changed to refuse to add a device to a
> group if the group's pasid xarray is not empty, as a protective
> measure.

Agreed. I will add below code.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 047898666b9f..e43cb6776087 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -895,6 +895,14 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)
         int ret, i = 0;
         struct group_device *device;

+       /*
+        * The iommu_attach_device_pasid() requires a singleton group.
+        * Refuse to add a device into it if this assumption has been
+        * made.
+        */
+       if (!xa_empty(group->pasid_array))
+               return -EBUSY;
+
         device = kzalloc(sizeof(*device), GFP_KERNEL);
         if (!device)
                 return -ENOMEM;

> 
>> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
>> +		iommu_group_put(group);
>> +		return -EINVAL;
> goto error below
> 
>> +	}
>> +
>> +	mutex_lock(&group->mutex);
> Just hold the group->mutex a few lines above and don't put locking in
> iommu_group_immutable_singleton(), it is clearer

Above two comments agreed. iommu_attach_device_pasid() looks like below
after update.

int iommu_attach_device_pasid(struct iommu_domain *domain, struct device 
*dev,
                               ioasid_t pasid)
{
         struct iommu_group *group;
         int ret = -EINVAL;
         void *curr;

         if (!domain->ops->set_dev_pasid)
                 return -EOPNOTSUPP;

         group = iommu_group_get(dev);
         if (!group)
                 return -ENODEV;

         mutex_lock(&group->mutex);
         if (!iommu_group_immutable_singleton(group, dev))
                 goto out_unlock;

         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {
                 ret = xa_err(curr) ? : -EBUSY;
                 goto out_unlock;
         }
         ret = domain->ops->set_dev_pasid(domain, dev, pasid);
         if (ret)
                 xa_erase(&group->pasid_array, pasid);
out_unlock:
         mutex_unlock(&group->mutex);
         iommu_group_put(group);

         return ret;
}

Best regards,
baolu

