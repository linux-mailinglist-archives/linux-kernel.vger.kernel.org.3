Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF8530ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiEWHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiEWHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:35:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B0EAA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653291290; x=1684827290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+UmZzsA9DQ/myvorGwrWNQn+6DDRetvo79UNzgmtCs=;
  b=Jh7WjlJuNDhsAVK4hFzkDihHwijefoc6ItYRbbe4mWn3NICvu4rf4Yi8
   4y6AfAjO4LJdv7UCn159miPI2SdQzsiKoyuvKmIIxlc53MB4MAjzbL+5k
   MGlUvzXbrjB7tNioJ/VY8Z/mezerDSnzvYLNIvpgOIRGk5l9n8kzszg+w
   VHJV5I2XBNG9SgVqLyx22bZ8w5XmE45rX0pjWmc40fcMaexbMuhIAL1lF
   qHVOn0ngDeLoh9yvltABW7rsZH2xCZeQsYSRmfI+if+ro3WRtldxhtAKR
   AKU/e7MQG6UfuOWbhyZsZxwQgWenTLZdJfH8/WVQDIVeMoBWxcIM161J0
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647273600"; 
   d="scan'208";a="199924661"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:34:14 +0800
IronPort-SDR: 4YXtl+L5oKe/vUXh5/960qHCskDzx8m17HKsC/Ty4My2o8Rm82tuu1a+R8mO8fQxWgNrTnZuOY
 LKhU8MrSTcvNyh8bL0NGtdNzgPF5hwEpT2NmEFNVl/NlCgcKHhe30x/7aQ4QFFXtIOI/j7vsEz
 6+KcUKmi8/xzXz5nPZwP4Ib3KgSRdEnrpI1KdywZVB2TMYGTvWTYEIlygi9y7HIjc8FyG1RxDK
 mVakqIISoRO2ElClQlFP0ffQDR2g3k19iL0dn/B9AY3+PZhAkLuMestkpXmbH8xAwA42It5yaw
 fmSrU0EXaAlq9wmGxuoxBzKD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 23:53:48 -0700
IronPort-SDR: WpVxTUnvsNP5RWu/Gg/TMg06SGul0PUw9UsRKMnb1NwBKOl2NrF3+cHgBDNOZemma2GSh59H3T
 NhtbNACjB/20jG2JB7C/1QXmgF3qx8XD8e/bNmPD6vrNJxw60McXjou3xZ4+cYwKpt/pUzCbSh
 8kt0NgPAfF9BvSN8A/xPpOWwKvMLWFtKk1InJa5SWB38WlHAtdIXqEAh9El+mC+BBU7b5Vb2Zd
 iy31SdH2cQEO296gM+xxMOFPTHPjh+fmK/7OZVkXQLX/xM7SX024lRPlYP+8kE7iYvycAj0I7r
 98M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 00:34:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68GY3KJJz1SVp5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:34:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653291252; x=1655883253; bh=h+UmZzsA9DQ/myvorGwrWNQn+6DDRetvo79
        UNzgmtCs=; b=cqZ6jZYr4SmGijrtOIj6+lh3jkOdhPWaMe1i8SQ8n9EsLA7R4Au
        xsGI6TnzMuDc3fW9vZ0EbZgWOppQbWljo11SqlkkneKM+AbW5a2/dUQPUBH6UIaB
        7HiWKvZvszAAoCkzl740RmSVmbcJEUdbzQW4WNtBKltAr+K6+65cm5sL6UG2bbcT
        dG94j80enwe/hHM2mUGEGmq2+odtp51yZTqxCSL9czjWlXDG+vQ2/mIU1JDsmefY
        IH9xVqhPt3Mr1w+stzyZh6+hNxCt4IHC+EIoBkEHV8HqO0RRhbs3bE+DxUtCxqpZ
        IwoNO46u6CIkSUODSzVJULgcky7ZCKlWyzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tkyqlQrV4Qme for <linux-kernel@vger.kernel.org>;
        Mon, 23 May 2022 00:34:12 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68GT6WZQz1Rvlc;
        Mon, 23 May 2022 00:34:09 -0700 (PDT)
Message-ID: <4e4aa6f0-7be4-d815-81b5-52f49e5f0455@opensource.wdc.com>
Date:   Mon, 23 May 2022 16:34:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/20 17:23, John Garry wrote:
> Add the IOMMU callback for DMA mapping API dma_opt_mapping_size(), which
> allows the drivers to know the optimal mapping limit and thus limit the
> requested IOVA lengths.
> 
> This value is based on the IOVA rcache range limit, as IOVAs allocated
> above this limit must always be newly allocated, which may be quite slow.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c | 6 ++++++
>  drivers/iommu/iova.c      | 5 +++++
>  include/linux/iova.h      | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..f619e41b9172 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,11 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  
> +static size_t iommu_dma_opt_mapping_size(void)
> +{
> +	return iova_rcache_range();
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops = {
>  	.alloc			= iommu_dma_alloc,
>  	.free			= iommu_dma_free,
> @@ -1462,6 +1467,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>  	.map_resource		= iommu_dma_map_resource,
>  	.unmap_resource		= iommu_dma_unmap_resource,
>  	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> +	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>  };
>  
>  /*
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..9f00b58d546e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>  static void free_iova_rcaches(struct iova_domain *iovad);
>  
> +unsigned long iova_rcache_range(void)
> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}
> +
>  static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct iova_domain *iovad;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..c6ba6d95d79c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>  int iova_cache_get(void);
>  void iova_cache_put(void);
>  
> +unsigned long iova_rcache_range(void);
> +
>  void free_iova(struct iova_domain *iovad, unsigned long pfn);
>  void __free_iova(struct iova_domain *iovad, struct iova *iova);
>  struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
