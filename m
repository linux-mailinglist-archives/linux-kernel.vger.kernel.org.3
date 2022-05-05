Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AB51B824
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245069AbiEEGqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244918AbiEEGqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:46:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DA47069
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651732954; x=1683268954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L/a6wMWAdKWT7KhDXjvHIAk8TGKh0XXXJxXYnJtT6H0=;
  b=l2uXxVXbLidrD4Kfx8cOJyrPbFqZUB5RByA35SwziHFrlMsyam2JdggA
   rbqBnNTDEh2thUK+dn1/uuAL89gfyEPZVDFVfXqbuIca2BzTB0agw3gBM
   lRhvb/v3EKJehgxMorQ+P6xUODKEiJPimADjwwcNQOK7dzs24TeANrkyN
   YSYuq004fUn+a4wDuLClk7cF6ovtL8b2f9Cu6IXwL87hDq+tdIIqbrLyt
   ltUikFjX3Np3WLIjPOmCciJeNIK+Uxa5QSLQksOhZck1eERfwcDaxZM36
   xwyzRViJoGnfwqEUWFOjkD1ftC2xD8JzvB6NTfVRZnXz1GNjWN9v0mZK0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265614509"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="265614509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:42:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563100789"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:42:27 -0700
Message-ID: <d490e542-140c-58c3-bb11-9990795272b1@linux.intel.com>
Date:   Thu, 5 May 2022 14:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 04/12] iommu/sva: Basic data structures for SVA
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-5-baolu.lu@linux.intel.com> <YnFv0ps0Ad8v+7uH@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFv0ps0Ad8v+7uH@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 02:09, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:34AM +0800, Lu Baolu wrote:
>> Use below data structures for SVA implementation in the IOMMU core:
>>
>> - struct iommu_sva_ioas
>>    Represent the I/O address space shared with an application CPU address
>>    space. This structure has a 1:1 relationship with an mm_struct. It
>>    grabs a "mm->mm_count" refcount during creation and drop it on release.
> 
> Do we actually need this structure?  At the moment it only keeps track of
> bonds, which we can move to struct dev_iommu. Replacing it by a mm pointer
> in struct iommu_domain simplifies the driver and seems to work

Fair enough.

+struct iommu_sva_ioas {
+	struct mm_struct *mm;
+	ioasid_t pasid;
+
+	/* Counter of domains attached to this ioas. */
+	refcount_t users;
+
+	/* All bindings are linked here. */
+	struct list_head bonds;
+};

By moving @mm to struct iommu_domain and @bonds to struct dev_iommu, the
code looks simpler. The mm, sva domain and per-device dev_iommu are
guaranteed to be valid during bind() and unbind().

Will head this direction in the next version.

> 
> Thanks,
> Jean

Best regards,
baolu

> 
>>
>> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>>    Represent a hardware pagetable that the IOMMU hardware could use for
>>    SVA translation. Multiple iommu domains could be bound with an SVA ioas
>>    and each grabs a refcount from ioas in order to make sure ioas could
>>    only be freed after all domains have been unbound.
>>
>> - struct iommu_sva
>>    Represent a bond relationship between an SVA ioas and an iommu domain.
>>    If a bond already exists, it's reused and a reference is taken.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h         | 14 +++++++++++++-
>>   drivers/iommu/iommu-sva-lib.h |  1 +
>>   drivers/iommu/iommu-sva-lib.c | 18 ++++++++++++++++++
>>   3 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ab36244d4e94..f582f434c513 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -42,6 +42,7 @@ struct notifier_block;
>>   struct iommu_sva;
>>   struct iommu_fault_event;
>>   struct iommu_dma_cookie;
>> +struct iommu_sva_ioas;
>>   
>>   /* iommu fault flags */
>>   #define IOMMU_FAULT_READ	0x0
>> @@ -64,6 +65,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>>   
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
>> +
>>   /*
>>    * This are the possible domain-types
>>    *
>> @@ -86,6 +90,8 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>>   				 __IOMMU_DOMAIN_DMA_API |	\
>>   				 __IOMMU_DOMAIN_DMA_FQ)
>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
>> +				 __IOMMU_DOMAIN_HOST_VA)
>>   
>>   struct iommu_domain {
>>   	unsigned type;
>> @@ -95,6 +101,7 @@ struct iommu_domain {
>>   	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	struct iommu_sva_ioas *sva_ioas;
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -628,7 +635,12 @@ struct iommu_fwspec {
>>    * struct iommu_sva - handle to a device-mm bond
>>    */
>>   struct iommu_sva {
>> -	struct device			*dev;
>> +	struct device		*dev;
>> +	struct iommu_sva_ioas	*sva_ioas;
>> +	struct iommu_domain	*domain;
>> +	/* Link to sva ioas's bonds list */
>> +	struct list_head	node;
>> +	refcount_t		users;
>>   };
>>   
>>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
>> index 8909ea1094e3..9c5e108e2c8a 100644
>> --- a/drivers/iommu/iommu-sva-lib.h
>> +++ b/drivers/iommu/iommu-sva-lib.h
>> @@ -10,6 +10,7 @@
>>   
>>   int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>>   struct mm_struct *iommu_sva_find(ioasid_t pasid);
>> +struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
>>   
>>   /* I/O Page fault */
>>   struct device;
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..d524a402be3b 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -3,6 +3,8 @@
>>    * Helpers for IOMMU drivers implementing SVA
>>    */
>>   #include <linux/mutex.h>
>> +#include <linux/iommu.h>
>> +#include <linux/slab.h>
>>   #include <linux/sched/mm.h>
>>   
>>   #include "iommu-sva-lib.h"
>> @@ -10,6 +12,22 @@
>>   static DEFINE_MUTEX(iommu_sva_lock);
>>   static DECLARE_IOASID_SET(iommu_sva_pasid);
>>   
>> +struct iommu_sva_ioas {
>> +	struct mm_struct *mm;
>> +	ioasid_t pasid;
>> +
>> +	/* Counter of domains attached to this ioas. */
>> +	refcount_t users;
>> +
>> +	/* All bindings are linked here. */
>> +	struct list_head bonds;
>> +};
>> +
>> +struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
>> +{
>> +	return domain->sva_ioas->mm;
>> +}
>> +
>>   /**
>>    * iommu_sva_alloc_pasid - Allocate a PASID for the mm
>>    * @mm: the mm
>> -- 
>> 2.25.1
>>

