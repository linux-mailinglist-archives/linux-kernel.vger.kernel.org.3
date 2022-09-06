Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF45AE432
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiIFJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbiIFJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:28:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B56F263
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662456517; x=1693992517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QqmXy2GZLHSohVU0zyxyHogpet/ueg+VsoCb0iGCfBE=;
  b=LYZqZGnlmUns3OTpnk34/sPBcxVfdHwDIX+2DUFgGejYvurKWhPvNVU8
   kd/BxGbte5NnlzmyQa3HdsoVqM8F0LZFdbIa7Ae5jojC0CcazdWtwC/HN
   EvNCIr13d+aSUFdgZkC6WMtPevsdw0gDYmcWqjiohDEFw+m52+j/gb314
   Lc2Eo9i4j/uEyJPEqWww4hgJWw47i0bcPzQNE5Qy2ik5yx1o8bPYljAWy
   WDUDHQhNaMg7OfjvLuQ+0djb5XiNLZXCoFLh3kqxwagx3jjG8YXv7I0i/
   lNhFAu6JOEFQHDYhsllDJa1X8ghBsmpBPotctTMzru3FZ/ZsNQKTe50Da
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="358264015"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="358264015"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 02:28:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="644091572"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.214.249]) ([10.254.214.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 02:28:32 -0700
Message-ID: <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
Date:   Tue, 6 Sep 2022 17:28:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To:     John Garry <john.garry@huawei.com>, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <1662369083-238529-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

在 2022/9/5 17:11, John Garry 写道:
> Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
> has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
> pointers. As such, the checks in iova_magazine_full(),
> iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..580fdf669922 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i;
>   
> -	if (!mag)
> -		return;
> -

iommu_probe_device
   ops->probe_finalize(dev);
     intel_iommu_probe_finalize
        iommu_setup_dma_ops
          iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
            iova_domain_init_rcaches
              {
              ...
              cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
              cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
   	     if (!cpu_rcache->loaded || !cpu_rcache->prev) {
			    ret = -ENOMEM;
   		            goto out_err;

Do you mean iova_magazine_alloc() is impossible to fail ?

Thanks,

Ethan

>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   
>   	for (i = 0 ; i < mag->size; ++i) {
> @@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   
>   static bool iova_magazine_full(struct iova_magazine *mag)
>   {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	return mag->size == IOVA_MAG_SIZE;
>   }
>   
>   static bool iova_magazine_empty(struct iova_magazine *mag)
>   {
> -	return (!mag || mag->size == 0);
> +	return mag->size == 0;
>   }
>   
>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,

-- 
"firm, enduring, strong, and long-lived"

