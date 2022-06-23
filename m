Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA45577D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiFWKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiFWKZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:25:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDD4A3D1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655979893; x=1687515893;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=SfMNjDTXpdpTEG8SwqU5sfdcfOKk5la9f1bmwwHuL3w=;
  b=akWFe2mSBqYdRjCoQ7KEEk+YN7PCDDzmQQQdGUubvkLxg19NBLJC8Epg
   U54tuA2p/VDuunuANMguZRInO8FxGmXqLyxKqhB2/pxJPx3en+7XS8kNQ
   221bSspPuu4xRGeyed5ctEzvvvlEP5EMtIQoFvntmxmQJTUsKWxNhn6jw
   8sYdywY0PnNAyOiKw/ZnxGlybHFYAJpPZBP3k4UaNoVC1HLZ3fnDxQMJf
   sX6M0sHu9L/XLWWcfj8ziUfbI+bJ2vmYkHaNfYDSVGbPgQdQsIK0fbf44
   okKz21GCESvZ639MK3x0uCshIvd4yqw9VO8LtkrAMOVCzlLkmCuGN1MkI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342365651"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="342365651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:24:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644671879"
Received: from wterliko-mobl.ger.corp.intel.com (HELO [10.249.254.158]) ([10.249.254.158])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:24:50 -0700
Message-ID: <a3c7a668-ecc1-b6ca-202b-8459726b1941@linux.intel.com>
Date:   Thu, 23 Jun 2022 12:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: Split huge PUD on wp_huge_pud fallback
Content-Language: en-US
To:     "Gowans, James" <jgowans@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <6f48d622eb8bce1ae5dd75327b0b73894a2ec407.camel@amazon.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <6f48d622eb8bce1ae5dd75327b0b73894a2ec407.camel@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/23/22 07:24, Gowans, James wrote:
> Currently the implementation will split the PUD when a fallback is taken
> inside the create_huge_pud function. This isn't where it should be done:
> the splitting should be done in wp_huge_pud, just like it's done for
> PMDs. Reason being that if a callback is taken during create, there is
> no PUD yet so nothing to split, whereas if a fallback is taken when
> encountering a write protection fault there is something to split.
>
> It looks like this was the original intention with the commit where the
> splitting was introduced, but somehow it got moved to the wrong place
> between v1 and v2 of the patch series. Rebase mistake perhaps.
>
> Fixes: 327e9fd48972 ("mm: Split huge pages on write-notify or COW")

Some time since I looked into this, but looks correct to me.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Jan H. Schönherr <jschoenh@amazon.de>
> Signed-off-by: James Gowans <jgowans@amazon.com>
> ---
>   mm/memory.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..4cf7d4b6c950 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4802,29 +4802,30 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
>   	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>   	/* No support for anonymous transparent PUD pages yet */
>   	if (vma_is_anonymous(vmf->vma))
> -		goto split;
> -	if (vmf->vma->vm_ops->huge_fault) {
> -		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
> -
> -		if (!(ret & VM_FAULT_FALLBACK))
> -			return ret;
> -	}
> -split:
> -	/* COW or write-notify not handled on PUD level: split pud.*/
> -	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
> +		return VM_FAULT_FALLBACK;
> +	if (vmf->vma->vm_ops->huge_fault)
> +		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   	return VM_FAULT_FALLBACK;
>   }
>   
>   static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>   {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
> +	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>   	/* No support for anonymous transparent PUD pages yet */
>   	if (vma_is_anonymous(vmf->vma))
> -		return VM_FAULT_FALLBACK;
> -	if (vmf->vma->vm_ops->huge_fault)
> -		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +		goto split;
> +	if (vmf->vma->vm_ops->huge_fault) {
> +		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
> +
> +		if (!(ret & VM_FAULT_FALLBACK))
> +			return ret;
> +	}
> +split:
> +	/* COW or write-notify not handled on PUD level: split pud.*/
> +	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>   	return VM_FAULT_FALLBACK;
>   }
>   
