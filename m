Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC97518127
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiECJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiECJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:41:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A536E30
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651570677; x=1683106677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JqAREk8vnvLu8bKhdmebDQaF1iMe+9wlfQ11DH7NkhU=;
  b=QAL2Ln5f4wKTkmwedtvaDbf+SSZqPP/zVMYy5W0B51XS9tiFu7ReKj/l
   Wm2qx0tWXdBJW/vB7fjjFZIlw2kM+Z9cxjmHc+F+e+dUqkeqN++vz9qBS
   E53P20vgkZ9pD7DjeLMIfDqhr+yBOeVl21ngocNYS6kVSqbqbBo6SMEOe
   oc3Y1lyXEn/lIqxNpLM/N+cz4W08D+pwhi3+Hm0HF0najbYL18cMR1cRp
   qXYkhL/Hre9duPfXZqLb6s05Ah6o3SU+TKKoqekG4rbykwdbv8h7qCzjo
   Mm4rbHQjvKAr62d05aAh0wikysFfAegT/T+ebMC/EK29ZEDpxripzn62e
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353878972"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="353878972"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 02:36:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="562145028"
Received: from doshaugh-mobl.ger.corp.intel.com (HELO [10.213.236.211]) ([10.213.236.211])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 02:36:57 -0700
Message-ID: <4e3525db-5aa4-fec8-a496-749e08b5f257@linux.intel.com>
Date:   Tue, 3 May 2022 10:36:55 +0100
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
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Fix looks correct to me. In which case it seems breakage was introduced 
with:

Fixes: 155ab8836caa ("drm/i915: Move object close under its own lock")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v5.3+

AFAICT at least. I will add these tags and pull it in unless someone 
shouts a correction.

Regards,

Tvrtko

> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/5732
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
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
