Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1FA53563D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiEZW5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiEZW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:56:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776252FFFE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653605817; x=1685141817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aI6/VxU2h7xTzqWQsH03zlgK2zXxTVp7REvISJhfkUM=;
  b=oJyfXrQ1iSY0RllkRSik23rvhKDgcApcQ6ItvKfhoOXMfkoRPzvMrg9f
   VA4t5xC7SEH3Gl6qgLVadYeO328+iaVm/kMVeet+hEoRMZndne+o5AEQG
   uAaN5Owoyxxx/+EbQJkN6EVqF/dB937MWFIAcN3kCFf3FBFo0u1BMStiw
   Y9vDlxm5PIT+kOPg6xL5utGptQStctztRk2+DKXyQbEKnCz2kVG9ok3yk
   nmF4crDvEgzYPd97VkYWv9ZJA1+0gq8GXnfrqA3z9Lt5sBdGUbpVGQvrE
   1ctIae6sWDetNFeD0GzNnpScAawwabDNdoO05eBrPy8jR9jaz8VXHAu7U
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="200329734"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 06:56:56 +0800
IronPort-SDR: n8Cjdr8VV2ND3QYjUyZYhV5KxLSPoUxuPmpGaZzqO9XHzYNy3/c2eCTfmSMSRi8Oq0nOijqFA3
 myKImHxNoRZVutsNO4BOHx6/nbS3/pmvHlfobkdLh5wkTa354P37a8yHBShywZow7dbu4RTy86
 vdhJ2+/0huUWvwrkvSj2ugt+2UQ+pX0/SWy7HT/aIRFus7biFcGerbZqq74k9iAj+0jfXcEd3I
 xJs9Cbr/XfKnsR956O5FWIPRGwGCAVX+S7UBIx00OihmRcqvToyvRKxoe2DY+yj9pMsXHaqeNG
 yW7wRAViCJY6DvcdQLXOJU+N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 15:20:49 -0700
IronPort-SDR: HI9JM6gmPDIv4uOFOV5wXEe9GHFs2k/s3N/qmWNnm8GZDb235W5AuD5XwENIahy61V+BOGNLLw
 qDzvwJGNj13pQntdPcHPYDISsd4yfM2aSYnDTGD83hdvIRec/nd6qzbTr+gsyrFdSZ7ZbuPwxn
 LzAe/A/Tg7XS7WPAk8WTcnMr6CzEKVZvxvibebhNTko6rDlV1B+tXdwt4HNN8d6Uq6ZAnlAg+3
 HsUqqme400IowMwJ+mvmHnB+RCx8GtMVPEIMxsjJzvBe1+Cead40g5Qis2xdWqBbH6TZBsikfe
 srw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 15:56:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L8Nbq0yj1z1SVny
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:56:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653605814; x=1656197815; bh=aI6/VxU2h7xTzqWQsH03zlgK2zXxTVp7REv
        ISJhfkUM=; b=mUaCxv9v8cJ7R3el0h+ntICd3sYnvGeIZ2UKkpnbJZZj+T9PwLa
        rj8NU7MbE0AePNYG3+WBi8TsdrcKNLbez65tBD3aMPl5xD1tXBIgSBpTNIgVK6L0
        eMd/SZeR4ygvVhl2TrLe69TVpvlTd652Liv5tVZtgx5ObXV5pTYbhhZ6rHmu7s5L
        AZYkf+uQHvYsthX8UxYi4y9XTB/pBgHp3wR0wvNeaUhBMzIOH5pwlYBBQS7JKxOl
        rBaxmXtGPPfWKsFXIlKHPDM9xmYAQDujX1CtlFSWN1zad60a34i2QpSip2QFOaR6
        w7zAHPOvKtOoECrRUPXZs4wQa9Vz/y7/vvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W3GFk0FCTM36 for <linux-kernel@vger.kernel.org>;
        Thu, 26 May 2022 15:56:54 -0700 (PDT)
Received: from [10.89.80.98] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.98])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L8Nbl3WbCz1Rvlc;
        Thu, 26 May 2022 15:56:51 -0700 (PDT)
Message-ID: <36dbfa77-d8f0-88d4-7dda-1e18c4c453b8@opensource.wdc.com>
Date:   Fri, 27 May 2022 07:56:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653560914-82185-1-git-send-email-john.garry@huawei.com>
 <1653560914-82185-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653560914-82185-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/26 19:28, John Garry wrote:
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
