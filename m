Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB23596CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiHQKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiHQKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:34:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9B51A33
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660732498; x=1692268498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WDCWwFNC4pSlrtLv+pJZJTESXKf8+WkfSayMR/BUY90=;
  b=UOF0AJLY8nKVPWwGTa4lqcn7In75T5+ois0MvvvB78fcMH7BY8D4JgqH
   FvAHG2xpJHlgIIQ/vamo03wDHb/157Y90skInzujQyeFRFrrMEeBwsKgQ
   dm1FNHgIYrSKWqDoxb86aaS5ATkEqZbBwLcUhcr2TAU+CtIXEgxMt4BQN
   aZO6GxoTi6tazOg4E0DuLrcbRgEjZUQFobnTAPaKq5O7v3dG0kWbT4Gez
   9o6Lq51BN6Ens+PiCx5CrRnWYoiyI8ub5mL7hLnZzU91do6Vv2aYqrKKc
   UCBDInsC9DkJ5Uu1i28+Yvuz9V3FQIheat9CUXQxMTTbhOQWxFD69DH4c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356456887"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="356456887"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:34:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667559585"
Received: from jzhan60-mobl1.ccr.corp.intel.com (HELO [10.254.209.228]) ([10.254.209.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:34:56 -0700
Message-ID: <50b8489c-bd93-c8ae-cd92-af429ae762b0@linux.intel.com>
Date:   Wed, 17 Aug 2022 18:34:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: return early when devices in a group require
 different domain type
Content-Language: en-US
To:     Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
References: <20220816020701.90533-1-yuancan@huawei.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220816020701.90533-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/16 10:07, Yuan Can wrote:
> When alloc default domain for an iommu_group in
> probe_alloc_default_domain, the expected domain
> type of each device in the iommu_group is checked
> in a loop, if two devices require different types,
> the loop can be breaked since the default domain
> will be set to iommu_def_domain_type.
> Return 1 when this happened to break the loop in
> __iommu_group_for_each_dev.
> 
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Nit:
Try to use up the allowed number of characters per line before wrapping
and use "./scripts/checkpatch.pl --strict --codespell _your_patch_file"
to check the patch.

For the change:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 74bc9111c7be..0d4d78946d31 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
>   				 dev_name(gtype->dev),
>   				 iommu_domain_type_str(gtype->type));
>   			gtype->type = 0;
> +			return 1; /* end the outer loop */
>   		}
>   
>   		if (!gtype->dev) {

