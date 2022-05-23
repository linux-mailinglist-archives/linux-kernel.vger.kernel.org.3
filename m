Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBD5307F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbiEWDHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353900AbiEWDHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:07:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEFC37BDC
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653275262; x=1684811262;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cud34Huotn8SDaPIoxRDAoxNvr8ULjV7tp01yDrBhHU=;
  b=n1RLoDjGS3zHVGWIBmWAA8wmZ2m6ar5StEbvve9dEPtqloe5BrlF+EQg
   BGWQ47kGqOjmirkphs47L0o/FIpt4QzT+NeeuZW+WZNE9NDFBbA/jHnrw
   ORsmutVa32TzpuP9WTbSUQsBTZOMIRgSbFeQrfkCUUnrxR7Etai7fvgZF
   k7C89Xt44VgP+moaO56D73l0cgq9s0E5e4SK18/wwuZHQYP7EYA4qML7g
   WoUm69QArq9wD8PQXTdM8GYVpmlGkUR8ODPXbmmTazNm2wMpUlptQNWIQ
   QPEWCsxdjghOFeHwhHgkiAnstEhtTSlsyCCVJ7DrdE/E4H+0kDc3xBeNh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="270656487"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="270656487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 20:07:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="571854693"
Received: from jsun39-mobl.ccr.corp.intel.com (HELO [10.255.28.225]) ([10.255.28.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 20:07:37 -0700
Message-ID: <e273695b-cafc-2f9d-f24b-1babae4286b5@linux.intel.com>
Date:   Mon, 23 May 2022 11:07:32 +0800
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
 <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
 <Yod6/ceSMIeela/x@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yod6/ceSMIeela/x@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/20 19:28, Jean-Philippe Brucker wrote:
> On Fri, May 20, 2022 at 02:38:12PM +0800, Baolu Lu wrote:
>> On 2022/5/20 00:39, Jean-Philippe Brucker wrote:
>>>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>>>> +{
>>>> +	struct iommu_sva_domain *sva_domain;
>>>> +	struct iommu_domain *domain;
>>>> +	ioasid_t max_pasid = 0;
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	/* Allocate mm->pasid if necessary. */
>>>> +	if (!dev->iommu->iommu_dev->pasids)
>>>> +		return ERR_PTR(-EOPNOTSUPP);
>>>> +
>>>> +	if (dev_is_pci(dev)) {
>>>> +		max_pasid = pci_max_pasids(to_pci_dev(dev));
>>>> +		if (max_pasid < 0)
>>>> +			return ERR_PTR(max_pasid);
>>>> +	} else {
>>>> +		ret = device_property_read_u32(dev, "pasid-num-bits",
>>>> +					       &max_pasid);
>>>> +		if (ret)
>>>> +			return ERR_PTR(ret);
>>>> +		max_pasid = (1UL << max_pasid);
>>>> +	}
>>> The IOMMU driver needs this PASID width information earlier, when creating
>>> the PASID table (in .probe_device(), .attach_dev()). Since we're moving it
>>> to the IOMMU core to avoid code duplication, it should be done earlier and
>>> stored in dev->iommu
>> Yes, really. How about below changes?
>>
>>  From f1382579e8a15ca49acdf758d38fd36451ea174d Mon Sep 17 00:00:00 2001
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Date: Mon, 28 Feb 2022 15:01:35 +0800
>> Subject: [PATCH 1/1] iommu: Add pasids field in struct dev_iommu
>>
>> Use this field to save the number of PASIDs that a device is able to
>> consume. It is a generic attribute of a device and lifting it into the
>> per-device dev_iommu struct could help to avoid the boilerplate code
>> in various IOMMU drivers.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 15 +++++++++++++++
>>   include/linux/iommu.h |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e49c5a5b8cc1..6b731171d42f 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/err.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ats.h>
>>   #include <linux/bitops.h>
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>> @@ -194,6 +195,8 @@ EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>   static struct dev_iommu *dev_iommu_get(struct device *dev)
>>   {
>>   	struct dev_iommu *param = dev->iommu;
>> +	u32 max_pasids = 0;
>> +	int ret;
>>
>>   	if (param)
>>   		return param;
>> @@ -202,6 +205,18 @@ static struct dev_iommu *dev_iommu_get(struct device
>> *dev)
>>   	if (!param)
>>   		return NULL;
>>
>> +	if (dev_is_pci(dev)) {
>> +		ret = pci_max_pasids(to_pci_dev(dev));
>> +		if (ret > 0)
>> +			max_pasids = ret;
>> +	} else {
>> +		ret = device_property_read_u32(dev, "pasid-num-bits",
>> +					       &max_pasids);
>> +		if (!ret)
>> +			max_pasids = (1UL << max_pasids);
>> +	}
>> +	param->pasids = max_pasids;
>> +
> we could also do a min() with the IOMMU PASID size here
> 
>>   	mutex_init(&param->lock);
>>   	dev->iommu = param;
>>   	return param;
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 45f274b2640d..d4296136ba75 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -371,6 +371,7 @@ struct iommu_fault_param {
>>    * @fwspec:	 IOMMU fwspec data
>>    * @iommu_dev:	 IOMMU device this device is linked to
>>    * @priv:	 IOMMU Driver private data
>> + * @pasids:	 number of supported PASIDs
> 'max_pasids' to stay consistent?

Both done. How about below changes?

 From 008c73b9c0ad51a4a70a18d60361a76c28a63342 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Mon, 28 Feb 2022 15:01:35 +0800
Subject: [PATCH 1/1] iommu: Add max_pasids field in struct dev_iommu

Use this field to save the number of PASIDs that a device is able to
consume. It is a generic attribute of a device and lifting it into the
per-device dev_iommu struct could help to avoid the boilerplate code
in various IOMMU drivers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/iommu.c | 26 ++++++++++++++++++++++++++
  include/linux/iommu.h |  2 ++
  2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..365d0f2b7f55 100644
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
@@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
  	kfree(param);
  }

+static u32 dev_iommu_get_max_pasids(struct device *dev)
+{
+	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
+	u32 num_bits;
+	int ret;
+
+	if (!max_pasids)
+		return 0;
+
+	if (dev_is_pci(dev)) {
+		ret = pci_max_pasids(to_pci_dev(dev));
+		if (ret < 0)
+			return 0;
+
+		return min_t(u32, max_pasids, ret);
+	}
+
+	ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
+	if (ret)
+		return 0;
+
+	return min_t(u32, max_pasids, 1UL << num_bits);
+}
+
  static int __iommu_probe_device(struct device *dev, struct list_head 
*group_list)
  {
  	const struct iommu_ops *ops = dev->bus->iommu_ops;
@@ -242,6 +267,7 @@ static int __iommu_probe_device(struct device *dev, 
struct list_head *group_list
  		goto out_module_put;
  	}

+	iommu_dev->max_pasids = dev_iommu_get_max_pasids(dev);
  	dev->iommu->iommu_dev = iommu_dev;

  	group = iommu_group_get_for_dev(dev);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 03fbb1b71536..d50afb2c9a09 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -364,6 +364,7 @@ struct iommu_fault_param {
   * @fwspec:	 IOMMU fwspec data
   * @iommu_dev:	 IOMMU device this device is linked to
   * @priv:	 IOMMU Driver private data
+ * @max_pasids:  number of PASIDs device can consume
   *
   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
   *	struct iommu_group	*iommu_group;
@@ -375,6 +376,7 @@ struct dev_iommu {
  	struct iommu_fwspec		*fwspec;
  	struct iommu_device		*iommu_dev;
  	void				*priv;
+	u32				max_pasids;
  };

  int iommu_device_register(struct iommu_device *iommu,

Best regards,
baolu
