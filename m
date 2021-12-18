Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5A47990A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLRF4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:56:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:46118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhLRF4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:56:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237430987"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="237430987"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 21:56:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="520056486"
Received: from weizhuoz-mobl.ccr.corp.intel.com (HELO [10.254.215.142]) ([10.254.215.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 21:56:11 -0800
Message-ID: <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
Date:   Sat, 18 Dec 2021 13:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dwmw2@infradead.org, joro@8bytes.org, will@kernel.org
References: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/18 5:58, Christophe JAILLET wrote:
> 'ommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code and improve the semantic, instead of hand writing it.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b6a8f3282411..4acc97765209 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1878,17 +1878,16 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   
>   static int iommu_init_domains(struct intel_iommu *iommu)
>   {
> -	u32 ndomains, nlongs;
> +	u32 ndomains;
>   	size_t size;
>   
>   	ndomains = cap_ndoms(iommu->cap);
>   	pr_debug("%s: Number of Domains supported <%d>\n",
>   		 iommu->name, ndomains);
> -	nlongs = BITS_TO_LONGS(ndomains);
>   
>   	spin_lock_init(&iommu->lock);
>   
> -	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
> +	iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
>   	if (!iommu->domain_ids)
>   		return -ENOMEM;
>   
> @@ -1903,7 +1902,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>   	if (!iommu->domains || !iommu->domains[0]) {
>   		pr_err("%s: Allocating domain array failed\n",
>   		       iommu->name);
> -		kfree(iommu->domain_ids);
> +		bitmap_free(iommu->domain_ids);
>   		kfree(iommu->domains);
>   		iommu->domain_ids = NULL;
>   		iommu->domains    = NULL;
> @@ -1964,7 +1963,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>   		for (i = 0; i < elems; i++)
>   			kfree(iommu->domains[i]);
>   		kfree(iommu->domains);
> -		kfree(iommu->domain_ids);
> +		bitmap_free(iommu->domain_ids);
>   		iommu->domains = NULL;
>   		iommu->domain_ids = NULL;
>   	}

This patch has been merged to Joerg's tree through

https://lore.kernel.org/linux-iommu/20211217083817.1745419-2-baolu.lu@linux.intel.com/

Are there any extra changes in this one?

Best regards,
baolu
