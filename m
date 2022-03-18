Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920314DD941
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiCRLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiCRLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:53:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06112D39C7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647604359; x=1679140359;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IlizNx0D23msIMfflP/Hpjfck4g6+/Khnila9FP+qGo=;
  b=mJqJr/2i1Q3mVAQY7yYv50iWldl+NjFBQuvNVrjmhhjUrhDf3AddjMzs
   W5pnqCYAVCFCWlDVi+FwE7KWc7PFBInd83KR6fJA7I3ihXoUW9EXWhBRl
   Kr/LY/GDyADaR4c5bDY5ur5p5r768g21Urb4Frv1Zs+jnQAsjwMD0T1f0
   pYyjgzDeHxeQwpTqt0abGqP2H0hD/wueK6vCaXU01RORjo85MO5SPApvs
   enyUl4VucFM/ZwFrpBVaOwQpWBhdfL9G8aun3YEAFOuhfCAZRjfnbIfr9
   wmrWrzGMPouwR7N0nPGi/HSdbQYbDhP/YO3f1LVwDbprYfU7GcbP8Z/2A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256847067"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256847067"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 04:52:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558400164"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.248]) ([10.254.215.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 04:52:35 -0700
Message-ID: <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
Date:   Fri, 18 Mar 2022 19:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 13:07, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> An IOMMU domain represents an address space which can be attached by
> devices that perform DMA within a domain. However, for platforms with
> PASID capability the domain attachment needs be handled at device+PASID
> level. There can be multiple PASIDs within a device and multiple devices
> attached to a given domain.
> This patch introduces a new IOMMU op which support device, PASID, and
> IOMMU domain attachment. The immediate use case is for PASID capable
> devices to perform DMA under DMA APIs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   include/linux/iommu.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 369f05c2a4e2..fde5b933dbe3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>    * @aux_get_pasid: get the pasid given an aux-domain
>    * @sva_bind: Bind process address space to device
>    * @sva_unbind: Unbind process address space from device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>    * @sva_get_pasid: Get PASID associated to a SVA handle
>    * @page_response: handle page request response
>    * @cache_invalidate: invalidate translation caches
> @@ -296,6 +298,10 @@ struct iommu_ops {
>   	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>   				      void *drvdata);
>   	void (*sva_unbind)(struct iommu_sva *handle);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);

As we have introduced iommu_domain_ops, these callbacks should be part
of the domain ops.

>   	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>   
>   	int (*page_response)(struct device *dev,

Best regards,
baolu
