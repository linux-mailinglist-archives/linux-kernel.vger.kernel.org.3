Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2C52F644
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbiETXdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354147AbiETXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:33:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434491A8111
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653089624; x=1684625624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskNztCAEee0=;
  b=RO5Yl3PhJ4q63wsShavF41jN4z4wxqHncPSjKvrDe9ZYqhhMWD9bwlXW
   caluW65bVz215oRIh5yvC3d1rmcnmKNKR388Gt+EBgVMBJmc6kWl7uryT
   45XJViS1xMWY+OlFP8jkf76I1pHRqQHiIabAO6G5vFXj10Nwrzo5XR3pi
   otHalArD9lM9Lv/mu40RH1j+RWtENFv1ne+gmnrZCTpbT12GYWZSC+uvY
   lJ3YUQuUqk+MXtmSdH5AE/z3aoLlcKfj8EOQeRcfc4FAZQi56TY+hfnRM
   K03zlnfRCf1U/ko+r2pMmYDzQtlSlnMYGf10BjJNggPU5/Mo3J7yAbpcf
   w==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="312941536"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:33:34 +0800
IronPort-SDR: 1AF+V6G7iB1/pGpHoI56v4PdBEOyuNcshewPS6C+R4KsJN4qybVVhZNbZQl+O/wWN4xgrOaUQv
 WdQrubtCF1grrohPR9BskUeUXjgo3pHH+2gncU6JR1MGNDm6nUupnMkLzUI7rDzJpx5JJXaoDt
 a9IZLQplGcpWUb2Fe298CT/LM+JHNqtL0g/MAd2bhAYerSP9sp16Gau7mDsjIMOFGLREE0hOk/
 aHAfwF2k3EjuNw9G08miePy1mXhJtuOdl0KwBY/CH5eAczFmFzW1sExwkoQqOF85RvKLhSrbVT
 O2t7ao8Qt90MkPM10n0DEoFb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 15:56:17 -0700
IronPort-SDR: oLbr5tplG8w72nfl8450BRTCBlZemaNFqgcMmdfpm+MwnxdZ7Hlx9+F/Q2KTsFpfua8sM2aIat
 QJRAy/qeGeH4ihbBUymcLFVIXMrl2ETwPz/Ih1h+yceHgVTIT4k9hUQEj3aMiBIuGv433sCyIs
 4yDoVF1Wf8V6zMGrLM9vx37SkYI1/s0Lbz0etZGHFhSCNsgXWqy5rJOdbRegFVfyJD6yrmkauL
 PQCKinDQSqAwC0Guq7N3VlUkHo/oSGzneqAI3zPCLJthcfgUzgRTLue04gh2FyYL4Cp3xHljde
 aus=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:33:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jhs2MXpz1SVp4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:33:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653089612; x=1655681613; bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskN
        ztCAEee0=; b=uDGNOQIsh48inaoun4AJwCUgoJIBlCt2pvcG1/RPSae5nO73YFv
        dTjg1WJbEhrRrJrL6FBx9wI2n5x3PtQ3g7JxNREFUo1z0h8Wcsk+WF5izoeuwNqH
        5jS0Kz3SYNDbFExwLsgoDjZJgb/Ucoy9tTCeI+mAppQxcV5PuqkSjRGCglCLQalS
        pw67JD9iyU/mfxiU94bNsf6CnzD81OkVdHhRpUGqWsj20ClGWM7ej9elGn21cVjq
        H/bA5J78ULBEWq2jSPrlOwkLJrJ/Xjr1tQ4Qm9Sphuo/ih9Be4N1Cwlc2JTqAIlw
        bvuzzI1ozKNOCj8qIPICikHcZQLCqaxHFzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zzaARqgzWKmi for <linux-kernel@vger.kernel.org>;
        Fri, 20 May 2022 16:33:32 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jhn73qjz1Rvlc;
        Fri, 20 May 2022 16:33:29 -0700 (PDT)
Message-ID: <250a10e6-40ae-e4e8-ae01-4f7144b089f8@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:33:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 17:23, John Garry wrote:
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

Why not a size_t return type ?

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


-- 
Damien Le Moal
Western Digital Research
