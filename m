Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63B58992B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHDISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:18:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670165813
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659601087; x=1691137087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yQan3K3MzfFlco62xGlbqgCcc6m4f4EY80JPF0pTQKo=;
  b=EDGp72U97h5uxPWFhn71B3VxQ5naCcqTc5tWmQDQDuHoXnn1uybxGi0y
   4QUblHMO90xxiBzNet3CBAEaoS997bDsJ3SvBX9EDT+kW44PAhy33Z/z4
   Y/0Lc1wnMuVK4kBG9TUNrJNPpDpJjsC6RmCQi09jr5nBHatPA67b+IQC8
   +5X1qwTCJC3Wl3TM7n6oe/NEwNDVchccxvLnN57r1evQdg9DFOQhRPTSg
   Mgq5VitYNG7KboQlaqoeA9cwcAYPONnjoleDUVc+HCn461pqGH+UISYlG
   zQw1yzyPSk+f/s6fcUkchyYaWrWcCJOpgJUnUDSTw1liZDaPBy0TGjQsy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376172285"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="376172285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 01:18:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="603135791"
Received: from fzoltan-mobl1.ger.corp.intel.com (HELO [10.213.220.160]) ([10.213.220.160])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 01:18:03 -0700
Message-ID: <aa323022-f54c-23e2-92b9-87191209177e@linux.intel.com>
Date:   Thu, 4 Aug 2022 09:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] drm/i915: pass a pointer for tlb seqno at
 vma_invalidate_tlb()
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Michael Cheng <michael.cheng@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1659598090.git.mchehab@kernel.org>
 <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/08/2022 08:37, Mauro Carvalho Chehab wrote:
> WRITE_ONCE() should happen at the original var, not on a local
> copy of it.
> 
> Fixes: 5d36acb7198b ("drm/i915/gt: Batch TLB invalidations")

Cc: stable I think, since the above one was. So both hit 5.21 (or 6.1) 
together.

Regards,

Tvrtko

> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 0/3] at: https://lore.kernel.org/all/cover.1659598090.git.mchehab@kernel.org/
> 
>   drivers/gpu/drm/i915/gt/intel_ppgtt.c | 2 +-
>   drivers/gpu/drm/i915/i915_vma.c       | 6 +++---
>   drivers/gpu/drm/i915/i915_vma.h       | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> index 2da6c82a8bd2..6ee8d1127016 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> @@ -211,7 +211,7 @@ void ppgtt_unbind_vma(struct i915_address_space *vm,
>   
>   	vm->clear_range(vm, vma_res->start, vma_res->vma_size);
>   	if (vma_res->tlb)
> -		vma_invalidate_tlb(vm, *vma_res->tlb);
> +		vma_invalidate_tlb(vm, vma_res->tlb);
>   }
>   
>   static unsigned long pd_count(u64 size, int shift)
> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
> index 84a9ccbc5fc5..260371716490 100644
> --- a/drivers/gpu/drm/i915/i915_vma.c
> +++ b/drivers/gpu/drm/i915/i915_vma.c
> @@ -1308,7 +1308,7 @@ I915_SELFTEST_EXPORT int i915_vma_get_pages(struct i915_vma *vma)
>   	return err;
>   }
>   
> -void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb)
> +void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb)
>   {
>   	/*
>   	 * Before we release the pages that were bound by this vma, we
> @@ -1318,7 +1318,7 @@ void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb)
>   	 * the most recent TLB invalidation seqno, and if we have not yet
>   	 * flushed the TLBs upon release, perform a full invalidation.
>   	 */
> -	WRITE_ONCE(tlb, intel_gt_next_invalidate_tlb_full(vm->gt));
> +	WRITE_ONCE(*tlb, intel_gt_next_invalidate_tlb_full(vm->gt));
>   }
>   
>   static void __vma_put_pages(struct i915_vma *vma, unsigned int count)
> @@ -1971,7 +1971,7 @@ struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async)
>   			dma_fence_put(unbind_fence);
>   			unbind_fence = NULL;
>   		}
> -		vma_invalidate_tlb(vma->vm, vma->obj->mm.tlb);
> +		vma_invalidate_tlb(vma->vm, &vma->obj->mm.tlb);
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
> index 5048eed536da..33a58f605d75 100644
> --- a/drivers/gpu/drm/i915/i915_vma.h
> +++ b/drivers/gpu/drm/i915/i915_vma.h
> @@ -213,7 +213,7 @@ bool i915_vma_misplaced(const struct i915_vma *vma,
>   			u64 size, u64 alignment, u64 flags);
>   void __i915_vma_set_map_and_fenceable(struct i915_vma *vma);
>   void i915_vma_revoke_mmap(struct i915_vma *vma);
> -void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb);
> +void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb);
>   struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async);
>   int __i915_vma_unbind(struct i915_vma *vma);
>   int __must_check i915_vma_unbind(struct i915_vma *vma);
