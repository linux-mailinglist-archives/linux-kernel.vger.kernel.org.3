Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147845452E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiFIRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiFIRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:25:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0A403E2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654795544; x=1686331544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NM5pPibGbGNtxwzakbyoZcPV7UgqZOLcVDpUOgXosgQ=;
  b=Ey63rsMXHLuKYCMUbQ65ad2Bzfh9jgytLKXvefuAkh5Hg4zfxgPw8dp0
   i7GrInxz2DiMJ1paJQOR8LvjqaeUU0hZIZUQnkO/otX6omsTRJLd8VvAj
   p8xosoR2nNSluYYwdRdX5/ACJLx/O4UMeRes7JpWCnvudAkBY+cehegp+
   ss6YuTAYF8DBr8N7Un3WwE2uqOkOZrwfgLC8VaLzSRrlCcsCEjui65tq5
   j/5kcD/3ZNwuW3xbz0ZhoZSEv6uJ8q56E8qToYR7Bk7c3Xso1s76Nbkcm
   6Q9sP7L4IITM4MaCkV9cFPqH511UM2cR9lqULGOc7AemjvsPjuuzQEBFu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276127485"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="276127485"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="908432917"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:25:42 -0700
Date:   Thu, 9 Jun 2022 17:25:42 +0000
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Message-ID: <20220609172542.GB33363@araj-dh-work>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607014942.3954894-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 07, 2022 at 09:49:32AM +0800, Lu Baolu wrote:
> Use this field to keep the number of supported PASIDs that an IOMMU
> hardware is able to support. This is a generic attribute of an IOMMU
> and lifting it into the per-IOMMU device structure makes it possible

There is also a per-device attribute that tells what width is supported on
each device. When a device enables SVM, for simplicity we were proposing to
disable SVM on devices that don't support the full width, since it adds
additional complexity on the allocation interface. Is that factored into
this?

> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which supports PASID related features should set this
> field before enabling them on the devices.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/intel-iommu.h                 | 3 ++-
>  include/linux/iommu.h                       | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/dmar.c                  | 7 +++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4f29139bbfc3..e065cbe3c857 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -479,7 +479,6 @@ enum {
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>  
> -extern int intel_iommu_sm;
>  extern spinlock_t device_domain_lock;
>  
>  #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
> @@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>  extern const struct iommu_ops intel_iommu_ops;
>  
>  #ifdef CONFIG_INTEL_IOMMU
> +extern int intel_iommu_sm;
>  extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>  extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>  extern int dmar_disabled;
> @@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>  }
>  #define dmar_disabled	(1)
>  #define intel_iommu_enabled (0)
> +#define intel_iommu_sm (0)

Is the above part of this patch? Or should be moved up somewhere?
>  #endif
>  
>  static inline const char *decode_prq_descriptor(char *str, size_t size,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..03fbb1b71536 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>   * @list: Used by the iommu-core to keep a list of registered iommus
>   * @ops: iommu-ops for talking to this iommu
>   * @dev: struct device for sysfs handling
> + * @max_pasids: number of supported PASIDs
>   */
>  struct iommu_device {
>  	struct list_head list;
>  	const struct iommu_ops *ops;
>  	struct fwnode_handle *fwnode;
>  	struct device *dev;
> +	u32 max_pasids;
>  };
>  
>  /**
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..ae8ec8df47c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* SID/SSID sizes */
>  	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>  	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
>  
>  	/*
>  	 * If the SMMU supports fewer bits than would fill a single L2 stream
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 592c1e1a5d4b..6c338888061a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1123,6 +1123,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>  
>  	raw_spin_lock_init(&iommu->register_lock);
>  
> +	/*
> +	 * A value of N in PSS field of eCap register indicates hardware
> +	 * supports PASID field of N+1 bits.
> +	 */
> +	if (pasid_supported(iommu))
> +		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
> +
>  	/*
>  	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>  	 * be set yet. When intel_iommu_init() runs, it registers the units
> -- 
> 2.25.1
> 
