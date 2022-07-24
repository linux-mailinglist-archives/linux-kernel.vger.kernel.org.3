Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1957F44E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiGXJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:13:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816814034
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658654022; x=1690190022;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AzxZtybqvJM0/ZZ2jKJszUtZP/9aLY29CH9nP0hU6Gc=;
  b=WpCocqoy6hO5jonLZ8Du0ed3+sgygYlMXuFo55TGeyuwpWqu9Euo1df7
   uMZAFo6JMZg+xsuP22UnLADWIY8gzFmKq+iJX26jHInAQwN2oJmDzsdUr
   FGBeYKju/XfBimujQTPohT5IXJUIqrijVi2EZiBtB0tXiSS9wd7A5l59e
   H0Cwt1ijQw4jYE2Ar+ZE3f4RmYXU/Wy49l1UUM/p+493fD74v4kUXnsqh
   BUJ9TE0KqNJbtMldNJgK/g09ljg/HuKH6wjnkPlF0BN3gFZDGPhXkETSw
   t1wPpyyCrqI4WeDndYh+ELWAxFdeXgBRxU+pCBmalNB+fIYI8P/Bcge9l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313270940"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="313270940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 02:13:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657763568"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 02:13:37 -0700
Message-ID: <5d353fe4-b642-992e-ef42-7d7f8b2edf7e@linux.intel.com>
Date:   Sun, 24 Jul 2022 17:13:35 +0800
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
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/23 22:11, Jason Gunthorpe wrote:
>> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			       ioasid_t pasid)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain->ops->block_dev_pasid(domain, dev, pasid);
> I still really this OP, it is nonsense to invoke 'block_dev_pasid' on
> a domain, it should be on the iommu ops and it should not take in a
> domain parameter. This is why I prefer we write it as
> 
> domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
> 

I originally plan to refactor this after both Intel and ARM SMMUv3
drivers have real blocking domain supports. After revisiting this, it
seems that the only difficulty is how to check whether a domain is a
blocking domain. I am going to use below checking code:

+	/*
+	 * Detach the domain if a blocking domain is set. Check the
+	 * right domain type once the IOMMU driver supports a real
+	 * blocking domain.
+	 */
+	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {

Does this work for you?

The incremental changes look like below:

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6633c7b040b8..9f8748b51630 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -890,22 +890,23 @@ static int intel_svm_set_dev_pasid(struct 
iommu_domain *domain,
  	int ret = 0;

  	mutex_lock(&pasid_mutex);
-	sva = intel_svm_bind_mm(iommu, dev, mm);
-	if (IS_ERR(sva))
-		ret = PTR_ERR(sva);
+	/*
+	 * Detach the domain if a blocking domain is set. Check the
+	 * right domain type once the IOMMU driver supports a real
+	 * blocking domain.
+	 */
+	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
+		intel_svm_unbind_mm(dev, pasid);
+	} else {
+		sva = intel_svm_bind_mm(iommu, dev, mm);
+		if (IS_ERR(sva))
+			ret = PTR_ERR(sva);
+	}
  	mutex_unlock(&pasid_mutex);

  	return ret;
  }

-static void intel_svm_block_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t pasid)
-{
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(dev, pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
  static void intel_svm_domain_free(struct iommu_domain *domain)
  {
  	kfree(to_dmar_domain(domain));
@@ -913,7 +914,6 @@ static void intel_svm_domain_free(struct 
iommu_domain *domain)

  static const struct iommu_domain_ops intel_svm_domain_ops = {
  	.set_dev_pasid		= intel_svm_set_dev_pasid,
-	.block_dev_pasid	= intel_svm_block_dev_pasid,
  	.free			= intel_svm_domain_free,
  };

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index efe6a58eee48..a7f7a611fcce 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3262,7 +3262,7 @@ void iommu_detach_device_pasid(struct iommu_domain 
*domain, struct device *dev,
  	struct iommu_group *group = iommu_group_get(dev);

  	mutex_lock(&group->mutex);
-	domain->ops->block_dev_pasid(domain, dev, pasid);
+	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
  	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
  	mutex_unlock(&group->mutex);

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba6543f4c6a2..c52dccb86460 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -283,7 +283,6 @@ struct iommu_ops {
   * @attach_dev: attach an iommu domain to a device
   * @detach_dev: detach an iommu domain from a device
   * @set_dev_pasid: set an iommu domain to a pasid of device
- * @block_dev_pasid: block pasid of device from using iommu domain
   * @map: map a physically contiguous memory region to an iommu domain
   * @map_pages: map a physically contiguous set of pages of the same 
size to
   *             an iommu domain.
@@ -306,8 +305,6 @@ struct iommu_domain_ops {
  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
  	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
  			     ioasid_t pasid);
-	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-				ioasid_t pasid);

  	int (*map)(struct iommu_domain *domain, unsigned long iova,
  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);

Best regards,
baolu
