Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA504ACF15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbiBHCnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiBHCnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:43:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F7C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644288182; x=1675824182;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1pSkVNl3R0ivLBmQ17CBtNDLkHo+df5KjxxYl3xnHyk=;
  b=cMJaH5c7fKsi1G1mD9Y/36gAFEuHOGvXRJ6c5gjmFSVhh+hw8Qf0Gqe9
   1gC4TY0ZccbsHZYuUI/yeLQbmrvBgCusAukQM1tzlWFY/W1EFM0ON5a1X
   lT+f61LLgFhNCGcg0O6nljhmUvK0esBAVCq88OGawkN68JKvWbGteQwf2
   MlDlXKoy0acQRnWLHcAo0IG1UUa6//H14mCpn/ZhCmrIzDxLNP3AR8Pu/
   iv1TtAauN0aJWBAAhfDpMfqRHl95fnDiV73TbUV6rp0rcS1/kTUeVHZOO
   DxBDhuFYsgqO/0Pgn9YnKnChM6Jfsr/YngXoWJxsYu1/4fvVXf54pBHZQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236263231"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236263231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677965978"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 18:42:49 -0800
Message-ID: <139b9789-403f-c599-de02-3092847952c0@linux.intel.com>
Date:   Tue, 8 Feb 2022 10:41:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 7:02 AM, Fenghua Yu wrote:
> PASIDs are process wide. It was attempted to use refcounted PASIDs to
> free them when the last thread drops the refcount. This turned out to
> be complex and error prone. Given the fact that the PASID space is 20
> bits, which allows up to 1M processes to have a PASID associated
> concurrently, PASID resource exhaustion is not a realistic concern.
> 
> Therefore it was decided to simplify the approach and stick with lazy
> on demand PASID allocation, but drop the eager free approach and make
> a allocated PASID lifetime bound to the life time of the process.
> 
> Get rid of the refcounting mechanisms and replace/rename the interfaces
> to reflect this new approach.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v4:
> - Update the commit message (Thomas).
> 
> v3:
> - Rename mm_pasid_get() to mm_pasid_set() (Thomas).
> - Remove ioasid_get() because it's not used any more when the IOASID
>    is freed on mm exit (Thomas).
> - Remove PASID's refcount exercise in ioasid_put() and rename
>    ioasid_put() to ioasid_free() (Thomas).
> 
> v2:
> - Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
>    PeterZ)
> - Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
>    So the mm's PASID operations are generic for both X86 and ARM
>    (Dave Hansen)
> 
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
>   drivers/iommu/intel/iommu.c                   |  4 +-
>   drivers/iommu/intel/svm.c                     |  9 -----
>   drivers/iommu/ioasid.c                        | 39 ++-----------------
>   drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
>   drivers/iommu/iommu-sva-lib.h                 |  1 -
>   include/linux/ioasid.h                        | 12 +-----
>   include/linux/sched/mm.h                      | 16 ++++++++
>   kernel/fork.c                                 |  1 +
>   9 files changed, 38 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a737ba5f727e..22ddd05bbdcd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -340,14 +340,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
>   	if (IS_ERR(bond->smmu_mn)) {
>   		ret = PTR_ERR(bond->smmu_mn);
> -		goto err_free_pasid;
> +		goto err_free_bond;
>   	}
>   
>   	list_add(&bond->list, &master->bonds);
>   	return &bond->sva;
>   
> -err_free_pasid:
> -	iommu_sva_free_pasid(mm);
>   err_free_bond:
>   	kfree(bond);
>   	return ERR_PTR(ret);
> @@ -377,7 +375,6 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>   	if (refcount_dec_and_test(&bond->refs)) {
>   		list_del(&bond->list);
>   		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -		iommu_sva_free_pasid(bond->mm);
>   		kfree(bond);
>   	}
>   	mutex_unlock(&sva_lock);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..ef03b2176bbd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   link_failed:
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   
>   	return ret;
>   }
> @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   }
>   
>   static int prepare_domain_attach_device(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 5b5d69b04fcc..51ac2096b3da 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -514,11 +514,6 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
>   	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
>   }
>   
> -static void intel_svm_free_pasid(struct mm_struct *mm)
> -{
> -	iommu_sva_free_pasid(mm);
> -}
> -
>   static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   					   struct device *dev,
>   					   struct mm_struct *mm,
> @@ -662,8 +657,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   				kfree(svm);
>   			}
>   		}
> -		/* Drop a PASID reference and free it if no reference. */
> -		intel_svm_free_pasid(mm);
>   	}
>   out:
>   	return ret;
> @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void
>   	}
>   
>   	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> -	if (IS_ERR_OR_NULL(sva))
> -		intel_svm_free_pasid(mm);
>   	mutex_unlock(&pasid_mutex);
>   
>   	return sva;
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 06fee7416816..a786c034907c 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -2,7 +2,7 @@
>   /*
>    * I/O Address Space ID allocator. There is one global IOASID space, split into
>    * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
> - * free IOASIDs with ioasid_alloc and ioasid_put.
> + * free IOASIDs with ioasid_alloc() and ioasid_free().
>    */
>   #include <linux/ioasid.h>
>   #include <linux/module.h>
> @@ -15,7 +15,6 @@ struct ioasid_data {
>   	struct ioasid_set *set;
>   	void *private;
>   	struct rcu_head rcu;
> -	refcount_t refs;
>   };
>   
>   /*
> @@ -315,7 +314,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>   
>   	data->set = set;
>   	data->private = private;
> -	refcount_set(&data->refs, 1);
>   
>   	/*
>   	 * Custom allocator needs allocator data to perform platform specific
> @@ -348,35 +346,11 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>   EXPORT_SYMBOL_GPL(ioasid_alloc);
>   
>   /**
> - * ioasid_get - obtain a reference to the IOASID
> - * @ioasid: the ID to get
> - */
> -void ioasid_get(ioasid_t ioasid)
> -{
> -	struct ioasid_data *ioasid_data;
> -
> -	spin_lock(&ioasid_allocator_lock);
> -	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> -	if (ioasid_data)
> -		refcount_inc(&ioasid_data->refs);
> -	else
> -		WARN_ON(1);
> -	spin_unlock(&ioasid_allocator_lock);
> -}
> -EXPORT_SYMBOL_GPL(ioasid_get);
> -
> -/**
> - * ioasid_put - Release a reference to an ioasid
> + * ioasid_free - Free an ioasid
>    * @ioasid: the ID to remove
> - *
> - * Put a reference to the IOASID, free it when the number of references drops to
> - * zero.
> - *
> - * Return: %true if the IOASID was freed, %false otherwise.
>    */
> -bool ioasid_put(ioasid_t ioasid)
> +void ioasid_free(ioasid_t ioasid)
>   {
> -	bool free = false;
>   	struct ioasid_data *ioasid_data;
>   
>   	spin_lock(&ioasid_allocator_lock);
> @@ -386,10 +360,6 @@ bool ioasid_put(ioasid_t ioasid)
>   		goto exit_unlock;
>   	}
>   
> -	free = refcount_dec_and_test(&ioasid_data->refs);
> -	if (!free)
> -		goto exit_unlock;
> -
>   	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
>   	/* Custom allocator needs additional steps to free the xa element */
>   	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> @@ -399,9 +369,8 @@ bool ioasid_put(ioasid_t ioasid)
>   
>   exit_unlock:
>   	spin_unlock(&ioasid_allocator_lock);
> -	return free;
>   }
> -EXPORT_SYMBOL_GPL(ioasid_put);
> +EXPORT_SYMBOL_GPL(ioasid_free);
>   
>   /**
>    * ioasid_find - Find IOASID data
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index bd41405d34e9..106506143896 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
>    *
>    * Try to allocate a PASID for this mm, or take a reference to the existing one
>    * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> - * @min must be greater than 0, because 0 indicates an unused mm->pasid.
> + * available in mm->pasid and will be available for the lifetime of the mm.
>    *
>    * Returns 0 on success and < 0 on error.
>    */
> @@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   		return -EINVAL;
>   
>   	mutex_lock(&iommu_sva_lock);
> -	if (mm->pasid) {
> -		if (mm->pasid >= min && mm->pasid <= max)
> -			ioasid_get(mm->pasid);
> -		else
> +	/* Is a PASID already associated with this mm? */
> +	if (pasid_valid(mm->pasid)) {
> +		if (mm->pasid < min || mm->pasid >= max)
>   			ret = -EOVERFLOW;
> -	} else {
> -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -		if (pasid == INVALID_IOASID)
> -			ret = -ENOMEM;
> -		else
> -			mm->pasid = pasid;
> +		goto out;
>   	}
> +
> +	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +	if (!pasid_valid(pasid))
> +		ret = -ENOMEM;
> +	else
> +		mm_pasid_set(mm, pasid);
> +out:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>   
> -/**
> - * iommu_sva_free_pasid - Release the mm's PASID
> - * @mm: the mm
> - *
> - * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
> - */
> -void iommu_sva_free_pasid(struct mm_struct *mm)
> -{
> -	mutex_lock(&iommu_sva_lock);
> -	if (ioasid_put(mm->pasid))
> -		mm->pasid = 0;
> -	mutex_unlock(&iommu_sva_lock);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> -
>   /* ioasid_find getter() requires a void * argument */
>   static bool __mmget_not_zero(void *mm)
>   {
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 95dc3ebc1928..8909ea1094e3 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -9,7 +9,6 @@
>   #include <linux/mm_types.h>
>   
>   int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -void iommu_sva_free_pasid(struct mm_struct *mm);
>   struct mm_struct *iommu_sva_find(ioasid_t pasid);
>   
>   /* I/O Page fault */
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 2237f64dbaae..af1c9d62e642 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -34,8 +34,7 @@ struct ioasid_allocator_ops {
>   #if IS_ENABLED(CONFIG_IOASID)
>   ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>   		      void *private);
> -void ioasid_get(ioasid_t ioasid);
> -bool ioasid_put(ioasid_t ioasid);
> +void ioasid_free(ioasid_t ioasid);
>   void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   		  bool (*getter)(void *));
>   int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
> @@ -53,14 +52,7 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>   	return INVALID_IOASID;
>   }
>   
> -static inline void ioasid_get(ioasid_t ioasid)
> -{
> -}
> -
> -static inline bool ioasid_put(ioasid_t ioasid)
> -{
> -	return false;
> -}
> +static inline void ioasid_free(ioasid_t ioasid) { }
>   
>   static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   				bool (*getter)(void *))
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index c74d1edbac2f..a80356e9dc69 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -439,8 +439,24 @@ static inline void mm_pasid_init(struct mm_struct *mm)
>   {
>   	mm->pasid = INVALID_IOASID;
>   }
> +
> +/* Associate a PASID with an mm_struct: */
> +static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
> +{
> +	mm->pasid = pasid;
> +}
> +
> +static inline void mm_pasid_drop(struct mm_struct *mm)
> +{
> +	if (pasid_valid(mm->pasid)) {
> +		ioasid_free(mm->pasid);
> +		mm->pasid = INVALID_IOASID;
> +	}
> +}
>   #else
>   static inline void mm_pasid_init(struct mm_struct *mm) {}
> +static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
> +static inline void mm_pasid_drop(struct mm_struct *mm) {}
>   #endif
>   
>   #endif /* _LINUX_SCHED_MM_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index deacd2c17a7f..c03c6682464c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1115,6 +1115,7 @@ static inline void __mmput(struct mm_struct *mm)
>   	}
>   	if (mm->binfmt)
>   		module_put(mm->binfmt->module);
> +	mm_pasid_drop(mm);
>   	mmdrop(mm);
>   }
>   

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
