Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B69582874
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiG0OUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiG0OUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:20:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E4B4BB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658931650; x=1690467650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rZS/z2pPCJR+9C5Wg/O1igele6E4XF4KknGxce6vuL8=;
  b=Y6U5jebzPp4LyJPTdbU6Ik2020vQo1DMFJ6TYq5JDjNaBuNKgj8mlu3O
   FKF9y3xHE8AoL75iYOx0hZfjHaoDie1IVTDtv1aG/8qK5nDfxFEDonN5A
   Q5D852I+hVwVtlsJywvqi+6kxMTjdcYmVWmCFyLjHrqCmYJHAx6JgKe2+
   z6fAOcmA8Fx/JzqqkbOq02QbawBeZj+iw4COy6xne3xYre2pof/Irz1YF
   EAgMjIdwRl6HZQpBq6Za3ltmzOWI5smcRyxMz2DNsMpNG7CctFnWgDDxM
   WzGxdnLDPZyoggLYG+O4LajFMPoFWbi2RPvdqSF0LQHa7A31iauxWeKoG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="314024139"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="314024139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:20:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659216188"
Received: from cene1-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.44.151])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:20:41 -0700
Date:   Wed, 27 Jul 2022 16:20:39 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH v3 6/6] drm/i915/gt: describe the new tlb
 parameter at i915_vma_resource
Message-ID: <YuFJtzTmyRZLwwK7@alfio.lan>
References: <cover.1658924372.git.mchehab@kernel.org>
 <aa55eef7e63b8f3d0f69b525db2dd2eb87e9db6b.1658924372.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa55eef7e63b8f3d0f69b525db2dd2eb87e9db6b.1658924372.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> TLB cache invalidation can happen on two different situations:
> 
> 1. synchronously, at __vma_put_pages();
> 2. asynchronously.
> 
> On the first case, TLB cache invalidation happens inside
> __vma_put_pages(). So, no need to do it later on.
> 
> However, on the second case, the pages will keep in memory
> until __i915_vma_evict() is called.
> 
> So, we need to store the TLB data at struct i915_vma_resource,
> in order to do a TLB cache invalidation before allowing
> userspace to re-use the same memory.
> 
> So, i915_vma_resource_unbind() has gained a new parameter
> in order to store the TLB data at the second case.
> 
> Document it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1658924372.git.mchehab@kernel.org/
> 
>  drivers/gpu/drm/i915/i915_vma_resource.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
> index 5a67995ea5fe..4fe09ea0a825 100644
> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
> @@ -216,6 +216,10 @@ i915_vma_resource_fence_notify(struct i915_sw_fence *fence,
>  /**
>   * i915_vma_resource_unbind - Unbind a vma resource
>   * @vma_res: The vma resource to unbind.
> + * @tlb: pointer to vma->obj->mm.tlb associated with the resource
> + *	 to be stored at vma_res->tlb. When not-NULL, it will be used
> + *	 to do TLB cache invalidation before freeing a VMA resource.
> + *	 used only for async unbind.

/used/Used/

With that:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
