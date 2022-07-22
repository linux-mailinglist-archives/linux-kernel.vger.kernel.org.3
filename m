Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41357DD91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiGVJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiGVJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:20:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C5BB8FC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658481235; x=1690017235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x0IVXe/dQxL+jMGm05hSRrfW+Ktw0b5z0uHvDMRGLwM=;
  b=FlRD+GiXNtn6jD8bmKtqsLoJfT67uxJ0+lnvGYrS/hYZCbMf2k6JFhRu
   0RkdHxmug89noA6bVNKoT6Qeb85gMDBjSSqhXu4JB72GQxUX1T0SDG3ZN
   Mc3gSC+UpNWG2cnjPVCktAxIIzs64hqnzG6A1xPy+uYIzPNPYQxu9nguy
   QlyfvGDxX5g30GwXfSinzT3tTfLTZyvlr5g3Basoc02dsLV12MaZ+B5K1
   J/HJUvWB2D9A0Cob9LuTsUHPwSyjv0gSVva5SdiNhRLTT7SeR6vdXl+id
   bnEbLiQZBqkEEpcAYSRMzuply+j9LwZelUJbJqFRk58BaYkRNaANrDkYS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312996692"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="312996692"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 02:13:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="574099527"
Received: from rdolan-mobl.ger.corp.intel.com (HELO [10.213.216.165]) ([10.213.216.165])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 02:13:52 -0700
Message-ID: <118ae557-a7cb-10b2-9198-2ceb92948dd7@linux.intel.com>
Date:   Fri, 22 Jul 2022 10:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/i915: stop using swiotlb
Content-Language: en-US
To:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Christoph Hellwig <hch@lst.de>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220721174307.1085741-1-bob.beckett@collabora.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220721174307.1085741-1-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/07/2022 18:43, Robert Beckett wrote:
> Calling swiotlb functions directly is nowadays considered harmful. See
> https://lore.kernel.org/intel-gfx/20220711082614.GA29487@lst.de/
> 
> Replace swiotlb_max_segment() calls with dma_max_mapping_size().
> In i915_gem_object_get_pages_internal() no longer consider max_segment
> only if CONFIG_SWIOTLB is enabled. There can be other (iommu related)
> causes of specific max segment sizes.

This matches my understanding as well. And thanks for writing the patch 
up, I actually copied you to comment on the timeline of code removal 
only and did not expect you'd take it on fully. Thanks!

Christoph - ack from you? Also, if we merge it via the normal process it 
will hit 5.21 only. Does that work for you?

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 20 +++++---------------
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c    |  2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c      |  4 ++--
>   drivers/gpu/drm/i915/gem/i915_gem_userptr.c  |  2 +-
>   drivers/gpu/drm/i915/i915_scatterlist.h      | 16 ----------------
>   5 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> index c698f95af15f..e1aca378d90f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -6,7 +6,6 @@
>   
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
> -#include <linux/swiotlb.h>
>   
>   #include "i915_drv.h"
>   #include "i915_gem.h"
> @@ -38,22 +37,13 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>   	struct scatterlist *sg;
>   	unsigned int sg_page_sizes;
>   	unsigned int npages;
> -	int max_order;
> +	int max_order = MAX_ORDER;
> +	size_t max_segment;
>   	gfp_t gfp;
>   
> -	max_order = MAX_ORDER;
> -#ifdef CONFIG_SWIOTLB
> -	if (is_swiotlb_active(obj->base.dev->dev)) {
> -		unsigned int max_segment;
> -
> -		max_segment = swiotlb_max_segment();
> -		if (max_segment) {
> -			max_segment = max_t(unsigned int, max_segment,
> -					    PAGE_SIZE) >> PAGE_SHIFT;
> -			max_order = min(max_order, ilog2(max_segment));
> -		}
> -	}
> -#endif
> +	max_segment = dma_max_mapping_size(i915->drm.dev);
> +	max_segment = max_t(size_t, max_segment, PAGE_SIZE) >> PAGE_SHIFT;
> +	max_order = min(max_order, ilog2(max_segment));
>   
>   	gfp = GFP_KERNEL | __GFP_HIGHMEM | __GFP_RECLAIMABLE;
>   	if (IS_I965GM(i915) || IS_I965G(i915)) {
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 4eed3dd90ba8..b0ec65b7c1da 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -194,7 +194,7 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
>   	struct intel_memory_region *mem = obj->mm.region;
>   	struct address_space *mapping = obj->base.filp->f_mapping;
>   	const unsigned long page_count = obj->base.size / PAGE_SIZE;
> -	unsigned int max_segment = i915_sg_segment_size();
> +	unsigned int max_segment = dma_max_mapping_size(i915->drm.dev);
>   	struct sg_table *st;
>   	struct sgt_iter sgt_iter;
>   	struct page *page;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 5a5cf332d8a5..882f046f4d18 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -189,7 +189,7 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
>   	struct drm_i915_private *i915 = container_of(bdev, typeof(*i915), bdev);
>   	struct intel_memory_region *mr = i915->mm.regions[INTEL_MEMORY_SYSTEM];
>   	struct i915_ttm_tt *i915_tt = container_of(ttm, typeof(*i915_tt), ttm);
> -	const unsigned int max_segment = i915_sg_segment_size();
> +	const unsigned int max_segment = dma_max_mapping_size(i915->drm.dev);
>   	const size_t size = (size_t)ttm->num_pages << PAGE_SHIFT;
>   	struct file *filp = i915_tt->filp;
>   	struct sgt_iter sgt_iter;
> @@ -568,7 +568,7 @@ static struct i915_refct_sgt *i915_ttm_tt_get_st(struct ttm_tt *ttm)
>   	ret = sg_alloc_table_from_pages_segment(st,
>   			ttm->pages, ttm->num_pages,
>   			0, (unsigned long)ttm->num_pages << PAGE_SHIFT,
> -			i915_sg_segment_size(), GFP_KERNEL);
> +			dma_max_mapping_size(i915_tt->dev), GFP_KERNEL);
>   	if (ret) {
>   		st->sgl = NULL;
>   		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 094f06b4ce33..8a62a71859e6 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -129,7 +129,7 @@ static void i915_gem_object_userptr_drop_ref(struct drm_i915_gem_object *obj)
>   static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
>   {
>   	const unsigned long num_pages = obj->base.size >> PAGE_SHIFT;
> -	unsigned int max_segment = i915_sg_segment_size();
> +	unsigned int max_segment = dma_max_mapping_size(obj->base.dev->dev);
>   	struct sg_table *st;
>   	unsigned int sg_page_sizes;
>   	struct page **pvec;
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
> index 9ddb3e743a3e..c9a61b51e99d 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> @@ -9,7 +9,6 @@
>   
>   #include <linux/pfn.h>
>   #include <linux/scatterlist.h>
> -#include <linux/swiotlb.h>
>   
>   #include "i915_gem.h"
>   
> @@ -127,21 +126,6 @@ static inline unsigned int i915_sg_dma_sizes(struct scatterlist *sg)
>   	return page_sizes;
>   }
>   
> -static inline unsigned int i915_sg_segment_size(void)
> -{
> -	unsigned int size = swiotlb_max_segment();
> -
> -	if (size == 0)
> -		size = UINT_MAX;
> -
> -	size = rounddown(size, PAGE_SIZE);
> -	/* swiotlb_max_segment_size can return 1 byte when it means one page. */
> -	if (size < PAGE_SIZE)
> -		size = PAGE_SIZE;
> -
> -	return size;
> -}
> -
>   bool i915_sg_trim(struct sg_table *orig_st);
>   
>   /**
