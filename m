Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF451791F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387661AbiEBVbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349695AbiEBVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:31:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F4DFF9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651526893; x=1683062893;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7yBpQAIpUfRJwgMGT0q/fayuN5S9gX0zx6AUvjTG+bk=;
  b=FLVmKnqxAiGLZtYSM+ldVqkGL4A7uvq9UNqgezc3vB7F4khf2F+VvUT1
   f23K17YyGWLWs7bdm0aMaHZdaw1R29o20Iitv56FdCWsg23RRUbADjPBL
   wzs9a2Ivc+UfrfmFfIHDlcR8+yHjXg24bT7k/czBs12kxXDIy5KkHauS5
   5CJz97Fe/rFDZB8eS+ocDxtDTFVdwNP+6GEi15Hb17xkygHMI+yzEpRZ2
   ogTjw0MNG8YidY4Bggd+08zJ20af+Tix6wZqVaS9etFuS0CFC+DfChRwS
   GtLcbZji3/fjGfiG5/rKuu5bMVcJoWewp9B1ekuckjurfndr3G93QRhQi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267208406"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="267208406"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:28:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733632021"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:28:12 -0700
Date:   Mon, 2 May 2022 14:31:54 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Message-ID: <20220502143154.444dd1dd@jacob-builder>
In-Reply-To: <20220501112434.874236-4-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
        <20220501112434.874236-4-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi BaoLu,

On Sun, 1 May 2022 19:24:32 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> As domain->force_snooping only impacts the devices attached with the
> domain, there's no need to check against all IOMMU units. At the same
> time, for a brand new domain (hasn't been attached to any device), the
> force_snooping field could be set, but the attach_dev callback will
> return failure if it wants to attach to a device which IOMMU has no
> snoop control capability.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h |  2 ++
>  drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/intel/pasid.c | 18 +++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index ab4408c824a5..583ea67fc783 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu
> *iommu, bool fault_ignore);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
>  void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 98050943d863..3c1c228f9031 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4554,13 +4554,61 @@ static phys_addr_t
> intel_iommu_iova_to_phys(struct iommu_domain *domain, return phys;
>  }
>  
> +static bool domain_support_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	bool support = true;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out;
> +
> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!ecap_sc_support(info->iommu->ecap)) {
> +			support = false;
> +			break;
> +		}
> +	}
why not just check the flag dmar_domain->force_snooping? devices wouldn't
be able to attach if !ecap_sc, right?

> +out:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	return support;
> +}
> +
> +static void domain_set_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +
> +	/*
> +	 * Second level page table supports per-PTE snoop control. The
> +	 * iommu_map() interface will handle this by setting SNP bit.
> +	 */
> +	if (!domain_use_first_level(domain))
> +		return;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out_unlock;
> +
> +	list_for_each_entry(info, &domain->devices, link)
> +		intel_pasid_setup_page_snoop_control(info->iommu,
> info->dev,
> +						     PASID_RID2PASID);
> +
I guess other DMA API PASIDs need to have sc bit set as well. I will keep
this in mind for my DMA API PASID patch.

> +out_unlock:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +}
> +
>  static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
> *domain) {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  
> -	if (!domain_update_iommu_snooping(NULL))
> +	if (!domain_support_force_snooping(dmar_domain))
>  		return false;
> +
> +	domain_set_force_snooping(dmar_domain);
>  	dmar_domain->force_snooping = true;
> +
nit: spurious change
>  	return true;
>  }
>  
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..815c744e6a34 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct
> intel_iommu *iommu, 
>  	return 0;
>  }
> +
> +/*
> + * Set the page snoop control for a pasid entry which has been set up.
> + */
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	u16 did;
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
> +		return;
> +
> +	pasid_set_pgsnp(pte);
> +	did = pasid_get_domain_id(pte);
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +}


Thanks,

Jacob
