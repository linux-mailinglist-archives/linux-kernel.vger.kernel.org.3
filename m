Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CA52E51F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbiETGiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiETGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:38:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405D146403
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653028701; x=1684564701;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LjXpZ9HfEbrJFZUmIy/qyR+9XU1wWQIVrt5b3XOXC5c=;
  b=d4HRkkZBNsOoO0XzpY+DrcbjgGs1jUraXzoDvDrYwj/tK3wX8HooIwfz
   55mtbq/8f2xRaH3gFMH4G3fTyH+OUhltQDY/z6vIAs7FlpgIjj9JbS1uM
   7Yvzto4am42L/dcMzAdEwRkhZfxlNX+RQlI+lpNec0GaQHayK+7gGaAEs
   qxVWq9cLF1+CmMmaOfEF6UJqxgmuSNc9IPDfVxrlkZF1UyQ0gLgzrvoui
   ZS7flImyqpUSY0oPgsQO8L3PTaI/ynQpzMn2hy5eQT2PKOKBElqtZEua8
   0VZsnXQLPBg5kZ1wntMaziLrnfmckpvjye954hWuxtKe9Tm9Uy55xBETw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="253025889"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="253025889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:38:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="599047317"
Received: from wangyu5-mobl.ccr.corp.intel.com (HELO [10.249.172.121]) ([10.249.172.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:38:14 -0700
Message-ID: <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
Date:   Fri, 20 May 2022 14:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com> <YoZyvVxJLiYOjBHw@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YoZyvVxJLiYOjBHw@myrica>
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

On 2022/5/20 00:39, Jean-Philippe Brucker wrote:
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct iommu_sva_domain *sva_domain;
>> +	struct iommu_domain *domain;
>> +	ioasid_t max_pasid = 0;
>> +	int ret = -EINVAL;
>> +
>> +	/* Allocate mm->pasid if necessary. */
>> +	if (!dev->iommu->iommu_dev->pasids)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	if (dev_is_pci(dev)) {
>> +		max_pasid = pci_max_pasids(to_pci_dev(dev));
>> +		if (max_pasid < 0)
>> +			return ERR_PTR(max_pasid);
>> +	} else {
>> +		ret = device_property_read_u32(dev, "pasid-num-bits",
>> +					       &max_pasid);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +		max_pasid = (1UL << max_pasid);
>> +	}
> The IOMMU driver needs this PASID width information earlier, when creating
> the PASID table (in .probe_device(), .attach_dev()). Since we're moving it
> to the IOMMU core to avoid code duplication, it should be done earlier and
> stored in dev->iommu

Yes, really. How about below changes?

 From f1382579e8a15ca49acdf758d38fd36451ea174d Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Mon, 28 Feb 2022 15:01:35 +0800
Subject: [PATCH 1/1] iommu: Add pasids field in struct dev_iommu

Use this field to save the number of PASIDs that a device is able to
consume. It is a generic attribute of a device and lifting it into the
per-device dev_iommu struct could help to avoid the boilerplate code
in various IOMMU drivers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/iommu.c | 15 +++++++++++++++
  include/linux/iommu.h |  2 ++
  2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e49c5a5b8cc1..6b731171d42f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -20,6 +20,7 @@
  #include <linux/idr.h>
  #include <linux/err.h>
  #include <linux/pci.h>
+#include <linux/pci-ats.h>
  #include <linux/bitops.h>
  #include <linux/property.h>
  #include <linux/fsl/mc.h>
@@ -194,6 +195,8 @@ EXPORT_SYMBOL_GPL(iommu_device_unregister);
  static struct dev_iommu *dev_iommu_get(struct device *dev)
  {
  	struct dev_iommu *param = dev->iommu;
+	u32 max_pasids = 0;
+	int ret;

  	if (param)
  		return param;
@@ -202,6 +205,18 @@ static struct dev_iommu *dev_iommu_get(struct 
device *dev)
  	if (!param)
  		return NULL;

+	if (dev_is_pci(dev)) {
+		ret = pci_max_pasids(to_pci_dev(dev));
+		if (ret > 0)
+			max_pasids = ret;
+	} else {
+		ret = device_property_read_u32(dev, "pasid-num-bits",
+					       &max_pasids);
+		if (!ret)
+			max_pasids = (1UL << max_pasids);
+	}
+	param->pasids = max_pasids;
+
  	mutex_init(&param->lock);
  	dev->iommu = param;
  	return param;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 45f274b2640d..d4296136ba75 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -371,6 +371,7 @@ struct iommu_fault_param {
   * @fwspec:	 IOMMU fwspec data
   * @iommu_dev:	 IOMMU device this device is linked to
   * @priv:	 IOMMU Driver private data
+ * @pasids:	 number of supported PASIDs
   *
   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
   *	struct iommu_group	*iommu_group;
@@ -382,6 +383,7 @@ struct dev_iommu {
  	struct iommu_fwspec		*fwspec;
  	struct iommu_device		*iommu_dev;
  	void				*priv;
+	u32				pasids;
  };

  int iommu_device_register(struct iommu_device *iommu,
-- 
2.25.1

Best regards,
baolu
