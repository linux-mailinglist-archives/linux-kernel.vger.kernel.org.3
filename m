Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0491530A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiEWHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiEWHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:24:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C823A1B8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653290259; x=1684826259;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkBnlh49x7+Hp8WBycVg2h1xf0cxa9S/tNTkHWNfXo8=;
  b=CLznKgNL7LIwbnzjvOgY+FWTvJDhYhhPjVi+5O7dYW/ZdN+xJQtfByxa
   SFbTBQo6i1tv4mAC353Zi0UCKMgqBnZHZLq2mc6hGBs4E++oSHk8k6NBm
   bFjY5KCz6hMDZdiAiyt/aV+eBomH/9LtaJVttgk1rQBsET4HSe0r24BUB
   JRH+nXAexv4GIsfpryCSCR0Z2es8jKHzj5PfBOIfk1zsDpbUk670Xsvij
   2oniKodbCby4uZY5Jdgp5r8rTQW3JS0k1WszzobckakrkF7S4BE3cN/zH
   RdK2z6F8d5NmZD5rdM+xRws+gM4BZAq+02u/KyraK6jN5iVwpA4LaRe4y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359525441"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="359525441"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:13:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="571941238"
Received: from jsun39-mobl.ccr.corp.intel.com (HELO [10.255.28.225]) ([10.255.28.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:12:57 -0700
Message-ID: <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
Date:   Mon, 23 May 2022 15:12:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/19 15:20, Lu Baolu wrote:
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA domain
>    type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>    support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>    operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.
> 
> Suggested-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h         | 51 +++++++++++++++++++++++++
>   drivers/iommu/iommu-sva-lib.h | 15 ++++++++
>   drivers/iommu/iommu-sva-lib.c | 48 +++++++++++++++++++++++
>   drivers/iommu/iommu.c         | 71 +++++++++++++++++++++++++++++++++++
>   4 files changed, 185 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0c358b7c583b..e8cf82d46ce1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>   
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>   /*
>    * This are the possible domain-types
>    *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>   
>   struct iommu_domain {
>   	unsigned type;
> @@ -254,6 +259,7 @@ struct iommu_ops {
>   	int (*def_domain_type)(struct device *dev);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *sva_domain_ops;

Per Joerg's comment in anther thread,

https://lore.kernel.org/linux-iommu/YodVJ7ervpIdWfg+@8bytes.org/

adding a sva_domain_ops here is not the right way to go.

If no objection, I will make the sva domain go through the
generic domain_alloc/free() callbacks in the next version.

Best regards,
baolu
