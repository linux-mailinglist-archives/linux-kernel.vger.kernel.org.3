Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CC51A3CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbiEDPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352360AbiEDPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:24:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2823443CD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651677640; x=1683213640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dJIYLg7h/Q2ldxRvg4MeqMb9Yi/SXMhu0fJoO84kF6w=;
  b=lTt1SOXV97GnZsD3Dkp5l1radovx1owFuprhEg/0OAjCazsO9ZrJibrj
   116Pho5E4M4lev9x1i/9XuHKvU5A5hSDATm5sEH73NR+Ic0jo21aOaLoP
   SKkysd+EgaKC0itblpwnSsFDfgCxVgaTqIZQWDZCYGLv3dBnOPeyi332r
   4J9GS47H1wTV6p6FoIFSjGxNd53Sw2oWzb2Cs45e2SmSaNmyvRgWH+tYw
   cjJWAs4+wSOkGl/RORIeOMQWt0UBdldM1DsMP3su+Nnc+7JBIeTBI7Yr5
   c6gV0rRJzsZNpYd8VPoiLg/snlGxK3aACcIxrtvCHHEO9reRi9tDMFF8V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255263050"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="255263050"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 08:20:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="664511899"
Received: from gidaly-mobl1.ger.corp.intel.com (HELO [10.213.236.183]) ([10.213.236.183])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 08:20:38 -0700
Message-ID: <1ff8137a-7ae6-5162-525d-70373a7170db@linux.intel.com>
Date:   Wed, 4 May 2022 16:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Fix race in
 __i915_vma_remove_closed
Content-Language: en-US
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20220420095720.3331609-1-kherbst@redhat.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220420095720.3331609-1-kherbst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/04/2022 10:57, Karol Herbst wrote:
> i915_vma_reopen checked if the vma is closed before without taking the
> lock. So multiple threads could attempt removing the vma.
> 
> Instead the lock needs to be taken before actually checking.
> 
> v2: move struct declaration
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/5732
> Signed-off-by: Karol Herbst <kherbst@redhat.com>

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/i915_vma.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
> index 162e8d83691b..2efdad2b43fa 100644
> --- a/drivers/gpu/drm/i915/i915_vma.c
> +++ b/drivers/gpu/drm/i915/i915_vma.c
> @@ -1615,17 +1615,17 @@ void i915_vma_close(struct i915_vma *vma)
>   
>   static void __i915_vma_remove_closed(struct i915_vma *vma)
>   {
> -	struct intel_gt *gt = vma->vm->gt;
> -
> -	spin_lock_irq(&gt->closed_lock);
>   	list_del_init(&vma->closed_link);
> -	spin_unlock_irq(&gt->closed_lock);
>   }
>   
>   void i915_vma_reopen(struct i915_vma *vma)
>   {
> +	struct intel_gt *gt = vma->vm->gt;
> +
> +	spin_lock_irq(&gt->closed_lock);
>   	if (i915_vma_is_closed(vma))
>   		__i915_vma_remove_closed(vma);
> +	spin_unlock_irq(&gt->closed_lock);
>   }
>   
>   static void force_unbind(struct i915_vma *vma)
> @@ -1641,6 +1641,7 @@ static void force_unbind(struct i915_vma *vma)
>   static void release_references(struct i915_vma *vma, bool vm_ddestroy)
>   {
>   	struct drm_i915_gem_object *obj = vma->obj;
> +	struct intel_gt *gt = vma->vm->gt;
>   
>   	GEM_BUG_ON(i915_vma_is_active(vma));
>   
> @@ -1651,7 +1652,9 @@ static void release_references(struct i915_vma *vma, bool vm_ddestroy)
>   
>   	spin_unlock(&obj->vma.lock);
>   
> +	spin_lock_irq(&gt->closed_lock);
>   	__i915_vma_remove_closed(vma);
> +	spin_unlock_irq(&gt->closed_lock);
>   
>   	if (vm_ddestroy)
>   		i915_vm_resv_put(vma->vm);
