Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A62499E07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587326AbiAXW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454662AbiAXVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:33:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05800C07597B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:21:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643055685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FTeBFVoufuU7ZebHlDAFZY8PMUgfTQm18f5SfOHL8s=;
        b=R1P7/uDqxqfBfk6N4xEy69WETfs1Jhu/2hRwCYOe8xPmYjIrg8SFqoZzucC0OcvPxGC7gE
        5o4eT4spbf9a2ZqK7eh9QlzJNBKyf+ZApSxLDIzy/x5B94QW+Qz6zpqCKEdWp1IUDVNkXi
        GYfV8E0MbwnGXMV3FJvetYWqtILk1ViWaKaz/QYbxXSq9U0fH7KpHObVTFwMWrGkAqCu/N
        cl5gbESO88l9KqBeU+mOEeqASkjarlsDg43xmRuM8k87sqN3ZMUO/r1AZ7D/O7XYWNZ+yq
        JSjH0RaYGsijeqNc8VmEpNnMPIpsZBmy23yo4XiUmbLqWnyg2sefiMDe1hbZ4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643055685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FTeBFVoufuU7ZebHlDAFZY8PMUgfTQm18f5SfOHL8s=;
        b=hzlU/SjNn/fwwC/H/KRPQL79VdGm9mE7ZHkHxDA4MC0SLgFIgF2pfhSDFoTcrjigCCscSE
        EYTOdPC2MJzUZHAw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20211217220136.2762116-6-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
Date:   Mon, 24 Jan 2022 21:21:24 +0100
Message-ID: <87ee4w6g1n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17 2021 at 22:01, Fenghua Yu wrote:
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index bd41405d34e9..ee2294e02716 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
>   *
>   * Try to allocate a PASID for this mm, or take a reference to the existing one
>   * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> - * @min must be greater than 0, because 0 indicates an unused mm->pasid.
> + * available in mm->pasid and will be available for the lifetime of the mm.
>   *
>   * Returns 0 on success and < 0 on error.
>   */
> @@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  		return -EINVAL;
>  
>  	mutex_lock(&iommu_sva_lock);
> -	if (mm->pasid) {
> -		if (mm->pasid >= min && mm->pasid <= max)
> -			ioasid_get(mm->pasid);
> -		else
> +	/* Is a PASID already associated with this mm? */
> +	if (pasid_valid(mm->pasid)) {
> +		if (mm->pasid < min || mm->pasid >= max)
>  			ret = -EOVERFLOW;
> -	} else {
> -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -		if (pasid == INVALID_IOASID)
> -			ret = -ENOMEM;
> -		else
> -			mm->pasid = pasid;
> +		goto out;
>  	}
> +
> +	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +	if (!pasid_valid(pasid))
> +		ret = -ENOMEM;
> +	else
> +		mm_pasid_get(mm, pasid);

Hrm. This is odd.

> +/* Associate a PASID with an mm_struct: */
> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> +{
> +	mm->pasid = pasid;
> +}

This does not get anything. It sets the allocated PASID in the mm. The
refcount on the PASID was already taken by the allocation. So this
should be mm_pasid_set() or mm_pasid_install(), right?

Thanks,

        tglx
