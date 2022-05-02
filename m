Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1147516C08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382906AbiEBIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiEBIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:33:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4507629F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651480213; x=1683016213;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/J8JbV8t2FS+lPPIOg2xi6/2iCk4fuaVr9xvS6LzXEo=;
  b=UC+FVwU6XSPw6KrMlorWW0dxA507XA3QKzpJhSjtDAphkOKXa5BFikWj
   78twPGf1zfqsygxK1NvPRasYjSHdRapkTwv9Rk2DlGMuSpoau/s8/+NB7
   iWEvJ++RI2PTyRtAp5cF61AVk0ExxOA1r+S9Uyj/zRTepKOPHBi0PWhWG
   NnILTsbji2mrSa0ruBuyviZgQmszeAKx8EMm+fdSMJwVfkvjwDM/jYfdI
   VCT4NbSYAeI1/NHcXIZShQlt9CAolDai+XyWxr4w4xbrKnh1LbXwNKiJD
   ycJfedPmH42wmu4PT8WppAnnEMq1JRN/EljRxDYpRU+PBMuj8ZMWHfr58
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="267313760"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="267313760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 01:30:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="583592217"
Received: from wagoleb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 01:30:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] drm/i915: use IOMEM_ERR_PTR() directly
In-Reply-To: <20220502034328.78486-1-wangkefeng.wang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220502034328.78486-1-wangkefeng.wang@huawei.com>
Date:   Mon, 02 May 2022 11:30:06 +0300
Message-ID: <87h768s5f5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2022, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use IOMEM_ERR_PTR() instead of self defined IO_ERR_PTR().
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/i915_vma.c | 4 ++--
>  drivers/gpu/drm/i915/i915_vma.h | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
> index 94fcdb7bd21d..639605c89b7b 100644
> --- a/drivers/gpu/drm/i915/i915_vma.c
> +++ b/drivers/gpu/drm/i915/i915_vma.c
> @@ -541,7 +541,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
>  	int err;
>  
>  	if (WARN_ON_ONCE(vma->obj->flags & I915_BO_ALLOC_GPU_ONLY))
> -		return IO_ERR_PTR(-EINVAL);
> +		return IOMEM_ERR_PTR(-EINVAL);
>  
>  	if (!i915_gem_object_is_lmem(vma->obj)) {
>  		if (GEM_WARN_ON(!i915_vma_is_map_and_fenceable(vma))) {
> @@ -594,7 +594,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
>  err_unpin:
>  	__i915_vma_unpin(vma);
>  err:
> -	return IO_ERR_PTR(err);
> +	return IOMEM_ERR_PTR(err);
>  }
>  
>  void i915_vma_flush_writes(struct i915_vma *vma)
> diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
> index 67ae7341c7e0..8e74972fdca3 100644
> --- a/drivers/gpu/drm/i915/i915_vma.h
> +++ b/drivers/gpu/drm/i915/i915_vma.h
> @@ -331,7 +331,6 @@ static inline bool i915_node_color_differs(const struct drm_mm_node *node,
>   * Returns a valid iomapped pointer or ERR_PTR.
>   */
>  void __iomem *i915_vma_pin_iomap(struct i915_vma *vma);
> -#define IO_ERR_PTR(x) ((void __iomem *)ERR_PTR(x))
>  
>  /**
>   * i915_vma_unpin_iomap - unpins the mapping returned from i915_vma_iomap

-- 
Jani Nikula, Intel Open Source Graphics Center
