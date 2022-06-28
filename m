Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D3B55DAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbiF1LXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiF1LXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:23:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A92DF1E5;
        Tue, 28 Jun 2022 04:23:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3284152B;
        Tue, 28 Jun 2022 04:23:08 -0700 (PDT)
Received: from [10.57.85.130] (unknown [10.57.85.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4E43F5A1;
        Tue, 28 Jun 2022 04:23:05 -0700 (PDT)
Message-ID: <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
Date:   Tue, 28 Jun 2022 12:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/5] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1656343521-62897-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 16:25, John Garry wrote:
> Streaming DMA mapping involving an IOMMU may be much slower for larger
> total mapping size. This is because every IOMMU DMA mapping requires an
> IOVA to be allocated and freed. IOVA sizes above a certain limit are not
> cached, which can have a big impact on DMA mapping performance.
> 
> Provide an API for device drivers to know this "optimal" limit, such that
> they may try to produce mapping which don't exceed it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   Documentation/core-api/dma-api.rst |  9 +++++++++
>   include/linux/dma-map-ops.h        |  1 +
>   include/linux/dma-mapping.h        |  5 +++++
>   kernel/dma/mapping.c               | 12 ++++++++++++
>   4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 6d6d0edd2d27..b3cd9763d28b 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -204,6 +204,15 @@ Returns the maximum size of a mapping for the device. The size parameter
>   of the mapping functions like dma_map_single(), dma_map_page() and
>   others should not be larger than the returned value.
>   
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.

Nit: I'm not sure "advised" is necessarily the right thing to say in 
general - that's only really true for a caller who cares about 
throughput of churning through short-lived mappings more than anything 
else, and doesn't take a significant hit overall from splitting up 
larger requests. I do think it's good to clarify the exact context of 
"optimal" here, but I'd prefer to be objectively clear that it's for 
workloads where the up-front mapping overhead dominates.

Thanks,
Robin.

> +
>   ::
>   
>   	bool
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b3a4a6..98ceba6fa848 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -69,6 +69,7 @@ struct dma_map_ops {
>   	int (*dma_supported)(struct device *dev, u64 mask);
>   	u64 (*get_required_mask)(struct device *dev);
>   	size_t (*max_mapping_size)(struct device *dev);
> +	size_t (*opt_mapping_size)(void);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
>   };
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index dca2b1355bb1..fe3849434b2a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>   u64 dma_get_required_mask(struct device *dev);
>   size_t dma_max_mapping_size(struct device *dev);
> +size_t dma_opt_mapping_size(struct device *dev);
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>   unsigned long dma_get_merge_boundary(struct device *dev);
>   struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
> @@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>   {
>   	return 0;
>   }
> +static inline size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
>   static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index db7244291b74..1bfe11b1edb6 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -773,6 +773,18 @@ size_t dma_max_mapping_size(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>   
> +size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	size_t size = SIZE_MAX;
> +
> +	if (ops && ops->opt_mapping_size)
> +		size = ops->opt_mapping_size();
> +
> +	return min(dma_max_mapping_size(dev), size);
> +}
> +EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> +
>   bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
