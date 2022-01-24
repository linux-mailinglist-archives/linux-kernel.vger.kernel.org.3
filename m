Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2006F49977F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448484AbiAXVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:12:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:35515 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390882AbiAXUqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643057193; x=1674593193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ujacmyO/PuoKNYdTwG8FMRiUMSIRWymHhVuwGwF59xk=;
  b=YIW/i+TZwgQZF8HdHnZbCvSPlV1wMQHB2mtNF+djAmaDRlkw44kIlQId
   6tg//mbwzkVkVvBrr6ZyNRb4gCyfba5YyJvk+vsdgxIFD86kS7LdNW1TH
   L2cAfzhHbZvJQn4Zcb+UaKPjY43XrU/Re9Oh8Aw6nEyHXw5U1KH6+hPJM
   zmLZKxQcaCIEjCC2rlPQ4a+mwUncRsP/hnUTlefkUHLrcXVBTgj1eQDA+
   XKAVuMAfpR7eYjYtft1Ca8hI88I6QYY14odU8UGU874Kp80T4YRdvNnbm
   kqUQpijkDvH6H6yBduZM5hZvzORyz9jy2ho47cLq7t2AA1UOwE1NvEc5D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246089183"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246089183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:33:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="494750089"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:33:16 -0800
Date:   Mon, 24 Jan 2022 12:33:12 -0800
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
Message-ID: <Ye8NCAKoGF/AsLfs@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee4w6g1n.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, Jan 24, 2022 at 09:21:24PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 17 2021 at 22:01, Fenghua Yu wrote:
> > diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> > index bd41405d34e9..ee2294e02716 100644
> > --- a/drivers/iommu/iommu-sva-lib.c
> > +++ b/drivers/iommu/iommu-sva-lib.c
> > @@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
> >   *
> >   * Try to allocate a PASID for this mm, or take a reference to the existing one
> >   * provided it fits within the [@min, @max] range. On success the PASID is
> > - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> > - * @min must be greater than 0, because 0 indicates an unused mm->pasid.
> > + * available in mm->pasid and will be available for the lifetime of the mm.
> >   *
> >   * Returns 0 on success and < 0 on error.
> >   */
> > @@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&iommu_sva_lock);
> > -	if (mm->pasid) {
> > -		if (mm->pasid >= min && mm->pasid <= max)
> > -			ioasid_get(mm->pasid);
> > -		else
> > +	/* Is a PASID already associated with this mm? */
> > +	if (pasid_valid(mm->pasid)) {
> > +		if (mm->pasid < min || mm->pasid >= max)
> >  			ret = -EOVERFLOW;
> > -	} else {
> > -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -		if (pasid == INVALID_IOASID)
> > -			ret = -ENOMEM;
> > -		else
> > -			mm->pasid = pasid;
> > +		goto out;
> >  	}
> > +
> > +	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > +	if (!pasid_valid(pasid))
> > +		ret = -ENOMEM;
> > +	else
> > +		mm_pasid_get(mm, pasid);
> 
> Hrm. This is odd.
> 
> > +/* Associate a PASID with an mm_struct: */
> > +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> > +{
> > +	mm->pasid = pasid;
> > +}
> 
> This does not get anything. It sets the allocated PASID in the mm. The
> refcount on the PASID was already taken by the allocation. So this
> should be mm_pasid_set() or mm_pasid_install(), right?

Ok. Will change mm_pasid_get() to mm_pasid_set().

Thank you very much for your review!

-Fenghua
