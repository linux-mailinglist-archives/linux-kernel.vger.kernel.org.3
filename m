Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEF525A23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359562AbiEMDcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376767AbiEMDcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:32:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB438CCDF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652412736; x=1683948736;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1JaSwFo6yze7m9vGoeyzvVSuA0dchXzgqHD9DVXRPM4=;
  b=UPbGMbfKlnMPelqHR4jFNH0trG5SByaxFaHAW5uC6x0xSy7c04QUIIYg
   HlMYGXCSfX12RL1Viqx793Q0f4K4Q4ZQnSFZmTa9PsPoT8gpFwbL3ARkL
   in6wdGY35me3AFnHJkAgwSsoXdBcadlUPT65uf+JBwJcYbRxgUFzBdeOp
   nSd6ACXPO3kY0W3ImPsWEvWPaVrwr6Yv59u838irgMVVch5J3BpIlDzn0
   jWzGiQ10seBzV0uXhXZlJhkjIjEmvjz7stcUf1phpwWcf9gMzSHMHDcIW
   MllvzkQDz9s+nfEsVWN4cTCVFXP3XBBznBoEuVkHsNI096JGgzoM33X0c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250734976"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250734976"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:32:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739986975"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.249.175.174]) ([10.249.175.174])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:32:13 -0700
Message-ID: <6da2adf4-6717-b562-5ee3-7e28447aa65b@linux.intel.com>
Date:   Fri, 13 May 2022 11:32:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, jgg@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Try info->iommu in device_to_iommu()
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
References: <20220513003233.4442-1-nicolinc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220513003233.4442-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/13 08:32, Nicolin Chen wrote:
> Local boot test and VFIO sanity test show that info->iommu can be
> used in device_to_iommu() as a fast path. So this patch adds it.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2990f80c5e08..412fca5ab9cd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -777,6 +777,7 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   {
>   	struct dmar_drhd_unit *drhd = NULL;
> +	struct device_domain_info *info;
>   	struct pci_dev *pdev = NULL;
>   	struct intel_iommu *iommu;
>   	struct device *tmp;
> @@ -786,6 +787,10 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   	if (!dev)
>   		return NULL;
>   
> +	info = dev_iommu_priv_get(dev);
> +	if (info)
> +		return info->iommu;

device_to_iommu() also returns device source id (@bus, @devfn).

Perhaps, we can make device_to_iommu() only for probe_device() where the
per-device info data is not initialized yet. After probe_device(), iommu
and sid are retrieved through other helpers by looking up the device
info directly?

Best regards,
baolu

> +
>   	if (dev_is_pci(dev)) {
>   		struct pci_dev *pf_pdev;
>   

