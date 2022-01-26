Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A949D0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbiAZRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:36:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:56209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243795AbiAZRg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643218586; x=1674754586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YEq+VbUd0qvM6dYGJRXqCaF1eKzMqOSL9aGqV0Ee52U=;
  b=HKEVRETqvy4/SWSn1id5gdlUKMmXMVHPFUHjJazNqBXq4dlSgkFDfH2q
   zvEXnHq0hxVNnH5iqwiaLJAviyzM0oJIYMDRN0bdZ2GIRIr6HbGEzga7i
   MIHh8Yb5IjbPT2yQqFbvSXMehYoOnaLvWb/nGgDlBS/cvDm4YpPQquoFU
   kV4mYNqDoJlo3ndGj5oG6iIzaW+rxzDV2AosnlwSONH2dPZBaG38lNWEt
   sv0D/qsnDRcpH06/4WsGv7MoNe3SJrsB8d7ztcm9e7SsEHhpJWT3dqyaN
   l+4jnqJgfXMNaY1liseQulCBleszQ4Lhfprrh2hHVTTFOWoJrHq5IwRdt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244204867"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244204867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:36:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="535264237"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:36:24 -0800
Date:   Wed, 26 Jan 2022 09:36:19 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx>
 <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx>
 <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0em4lu9.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Wed, Jan 26, 2022 at 03:23:42PM +0100, Thomas Gleixner wrote:
> On Tue, Jan 25 2022 at 07:18, Fenghua Yu wrote:
> > On Mon, Jan 24, 2022 at 09:55:56PM +0100, Thomas Gleixner wrote:
> >  /**
> >   * ioasid_put - Release a reference to an ioasid
> >   * @ioasid: the ID to remove
> 
> which in turn makes ioasid_put() a misnomer and the whole refcounting of
> the ioasid a pointless exercise.
> 
> While looking at ioasid_put() usage I tripped over the following UAF
> issue:
> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4817,8 +4817,10 @@ static int aux_domain_add_dev(struct dma
>  	auxiliary_unlink_device(domain, dev);
>  link_failed:
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>  		ioasid_put(domain->default_pasid);
> +		domain->default_pasid = INVALID_IOASID;
> +	}
>  
>  	return ret;
>  }
> @@ -4847,8 +4849,10 @@ static void aux_domain_remove_dev(struct
>  
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  
> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>  		ioasid_put(domain->default_pasid);
> +		domain->default_pasid = INVALID_IOASID;
> +	}
>  }
>  
>  static int prepare_domain_attach_device(struct iommu_domain *domain,

The above patch fixes an existing issue. I will put it in a separate patch,
right?

It cannot be applied cleanly to the upstream tree. Do you want me to base
the above patch (and the whole patch set) to the upstream tree or a specific
tip branch?

I will fold the following patch into patch #5. The patch #11 (the doc patch)
also needs to remove one paragraph talking about refcount.

So I will send the whole patch set with the following changes:
1. One new bug fix patch (the above patch)
2. Updated patch #5 (with the following patch folded)
3. Updated patch #11 (removing refcount description)

Are the changes OK to you?
 
> 
> Vs. ioasid_put() I think we should fold the following:
> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4818,7 +4818,7 @@ static int aux_domain_add_dev(struct dma
>  link_failed:
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  		domain->default_pasid = INVALID_IOASID;
>  	}
>  
> @@ -4850,7 +4850,7 @@ static void aux_domain_remove_dev(struct
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  
>  	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  		domain->default_pasid = INVALID_IOASID;
>  	}
>  }
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -2,7 +2,7 @@
>  /*
>   * I/O Address Space ID allocator. There is one global IOASID space, split into
>   * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
> - * free IOASIDs with ioasid_alloc and ioasid_put.
> + * free IOASIDs with ioasid_alloc() and ioasid_free().
>   */
>  #include <linux/ioasid.h>
>  #include <linux/module.h>
> @@ -15,7 +15,6 @@ struct ioasid_data {
>  	struct ioasid_set *set;
>  	void *private;
>  	struct rcu_head rcu;
> -	refcount_t refs;
>  };
>  
>  /*
> @@ -315,7 +314,6 @@ ioasid_t ioasid_alloc(struct ioasid_set
>  
>  	data->set = set;
>  	data->private = private;
> -	refcount_set(&data->refs, 1);
>  
>  	/*
>  	 * Custom allocator needs allocator data to perform platform specific
> @@ -348,17 +346,11 @@ ioasid_t ioasid_alloc(struct ioasid_set
>  EXPORT_SYMBOL_GPL(ioasid_alloc);
>  
>  /**
> - * ioasid_put - Release a reference to an ioasid
> + * ioasid_free - Free an ioasid
>   * @ioasid: the ID to remove
> - *
> - * Put a reference to the IOASID, free it when the number of references drops to
> - * zero.
> - *
> - * Return: %true if the IOASID was freed, %false otherwise.
>   */
> -bool ioasid_put(ioasid_t ioasid)
> +void ioasid_free(ioasid_t ioasid)
>  {
> -	bool free = false;
>  	struct ioasid_data *ioasid_data;
>  
>  	spin_lock(&ioasid_allocator_lock);
> @@ -368,10 +360,6 @@ bool ioasid_put(ioasid_t ioasid)
>  		goto exit_unlock;
>  	}
>  
> -	free = refcount_dec_and_test(&ioasid_data->refs);
> -	if (!free)
> -		goto exit_unlock;
> -
>  	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
>  	/* Custom allocator needs additional steps to free the xa element */
>  	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> @@ -381,9 +369,8 @@ bool ioasid_put(ioasid_t ioasid)
>  
>  exit_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> -	return free;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_put);
> +EXPORT_SYMBOL_GPL(ioasid_free);
>  
>  /**
>   * ioasid_find - Find IOASID data
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -34,7 +34,7 @@ struct ioasid_allocator_ops {
>  #if IS_ENABLED(CONFIG_IOASID)
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private);
> -bool ioasid_put(ioasid_t ioasid);
> +void ioasid_free(ioasid_t ioasid);
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
> @@ -52,10 +52,7 @@ static inline ioasid_t ioasid_alloc(stru
>  	return INVALID_IOASID;
>  }
>  
> -static inline bool ioasid_put(ioasid_t ioasid)
> -{
> -	return false;
> -}
> +static inline void ioasid_free(ioasid_t ioasid) { }
>  
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  				bool (*getter)(void *))
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -423,7 +423,7 @@ static inline void mm_pasid_set(struct m
>  static inline void mm_pasid_drop(struct mm_struct *mm)
>  {
>  	if (pasid_valid(mm->pasid)) {
> -		ioasid_put(mm->pasid);
> +		ioasid_free(mm->pasid);
>  		mm->pasid = INVALID_IOASID;
>  	}
>  }

Thank you very much for your review!

-Fenghua
