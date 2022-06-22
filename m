Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323DD5547B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiFVKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiFVKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:45:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95217E2F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655894705; x=1687430705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sjP6ER5kaN8ovs6+XvgVuwIu8rl+gxIcCzgujBRaFMA=;
  b=Rkm2AXKwDt3u/ji7CsgEWEq7alEAPwhzyaArRUI3poOraFltixx92RpB
   vzEmEVi5QCcGvuVhCQGLSSvTKpciX7k/nfH7wvAi61Yz1OEh9kFDGBClY
   prtPdXBBHNSyhaD1gr2+MdexrQkBUmhoUyFIGfAZ70tlmJuV55c4IoBK5
   gv/aP+tY4Wy1FnmHwupjb6BE4lzQsoQ87wQvqD5SPxIfOi92Yn7I9VAtn
   QdXU2nWUawLgnkqmlE2vLPAVNXiidmX21SUz7KLMXDICtXexRur5JEGjr
   R8QMyj3tOUlHvRojvHqGetFjZSjc/KSdJEgJDluAJ36fvXMEYmUnIey/b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269102693"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="269102693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:45:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690438099"
Received: from wterliko-mobl.ger.corp.intel.com (HELO [10.249.254.201]) ([10.249.254.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:45:01 -0700
Message-ID: <3dae0d34-78f3-b74e-517d-f14274540cf1@linux.intel.com>
Date:   Wed, 22 Jun 2022 12:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 01/10] drm/i915/ttm: dont trample cache_level overrides
 during ttm move
Content-Language: en-US
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Matthew Auld <matthew.auld@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220621200058.3536182-1-bob.beckett@collabora.com>
 <20220621200058.3536182-2-bob.beckett@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20220621200058.3536182-2-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/22 22:00, Robert Beckett wrote:
> Various places within the driver override the default chosen cache_level.
> Before ttm, these overrides were permanent until explicitly changed again
> or for the lifetime of the buffer.
>
> TTM movement code came along and decided that it could make that
> decision at that time, which is usually well after object creation, so
> overrode the cache_level decision and reverted it back to its default
> decision.
>
> Add logic to indicate whether the caching mode has been set by anything
> other than the move logic. If so, assume that the code that overrode the
> defaults knows best and keep it.
>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

LGTM.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


> ---
>   drivers/gpu/drm/i915/gem/i915_gem_object.c       | 1 +
>   drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 1 +
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c          | 1 +
>   drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c     | 9 ++++++---
>   4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> index 06b1b188ce5a..519887769c08 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -125,6 +125,7 @@ void i915_gem_object_set_cache_coherency(struct drm_i915_gem_object *obj,
>   	struct drm_i915_private *i915 = to_i915(obj->base.dev);
>   
>   	obj->cache_level = cache_level;
> +	obj->ttm.cache_level_override = true;
>   
>   	if (cache_level != I915_CACHE_NONE)
>   		obj->cache_coherent = (I915_BO_CACHE_COHERENT_FOR_READ |
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> index 2c88bdb8ff7c..6632ed52e919 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> @@ -605,6 +605,7 @@ struct drm_i915_gem_object {
>   		struct i915_gem_object_page_iter get_io_page;
>   		struct drm_i915_gem_object *backup;
>   		bool created:1;
> +		bool cache_level_override:1;
>   	} ttm;
>   
>   	/*
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 4c25d9b2f138..27d59639177f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -1241,6 +1241,7 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
>   	i915_gem_object_init_memory_region(obj, mem);
>   	i915_ttm_adjust_domains_after_move(obj);
>   	i915_ttm_adjust_gem_after_move(obj);
> +	obj->ttm.cache_level_override = false;
>   	i915_gem_object_unlock(obj);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index a10716f4e717..4c1de0b4a10f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -123,9 +123,12 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
>   	obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
>   		I915_BO_FLAG_STRUCT_PAGE;
>   
> -	cache_level = i915_ttm_cache_level(to_i915(bo->base.dev), bo->resource,
> -					   bo->ttm);
> -	i915_gem_object_set_cache_coherency(obj, cache_level);
> +	if (!obj->ttm.cache_level_override) {
> +		cache_level = i915_ttm_cache_level(to_i915(bo->base.dev),
> +						   bo->resource, bo->ttm);
> +		i915_gem_object_set_cache_coherency(obj, cache_level);
> +		obj->ttm.cache_level_override = false;
> +	}
>   }
>   
>   /**
