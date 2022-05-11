Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F520523086
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiEKKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiEKKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:14:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D72211C8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652264041; x=1683800041;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfzNbK8xK1toiVcloBzznf91Fo0KngmwDAbahjmvIeY=;
  b=S7+0NRF7goSYFhihBkcJaZv2eWFN5WryE4ZRVPPpkkfsLjnXMQ3duprq
   Nc+WK3WyMG1YDFL5QibTFRhA+//ETFfoYbjMs1r25AKU2Vv9iJMPHHrU3
   GsRF68UPsKmuGPKMyV4+0N+2gcc6odqwq3ixNeEyDQ0paYlwNCs1JSN2p
   F6c9FNzNmj0CONiW7BBp8r5uh0KtY5NwN2scU1ZmIQaKe5OhrNWwqf5B5
   Iw+PIbQM17ALHxUdKEcob94I9oF8YofVoxiEI1RoP4bLDdVPa44fWXz0t
   e28qEAyPDu6RnRXtmIZ4C25p7ZqUd4DLEXsHTq9PWYGSAuxDTnJv1ITwx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332692385"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="332692385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:14:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="697510872"
Received: from mstribae-mobl1.ger.corp.intel.com (HELO [10.249.254.135]) ([10.249.254.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:13:57 -0700
Message-ID: <3d08eb595c4a4eff02be5385c82d1e1d0e781c98.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] drm/i915: add gen6 ppgtt dummy creation function
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 12:13:55 +0200
In-Reply-To: <20220503191316.1145124-2-bob.beckett@collabora.com>
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
         <20220503191316.1145124-2-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2022-05-03 at 19:13 +0000, Robert Beckett wrote:
> Internal gem objects will soon just be volatile system memory region
> objects.
> To enable this, create a separate dummy object creation function
> for gen6 ppgtt


It's not clear from the commit message why we need a special case for
this. Could you describe more in detail?

Thanks,
Thomas


> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 43
> ++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> index 1bb766c79dcb..f3b660cfeb7f 100644
> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> @@ -372,6 +372,45 @@ static const struct drm_i915_gem_object_ops
> pd_dummy_obj_ops = {
>         .put_pages = pd_dummy_obj_put_pages,
>  };
>  
> +static struct drm_i915_gem_object *
> +i915_gem_object_create_dummy(struct drm_i915_private *i915,
> phys_addr_t size)
> +{
> +       static struct lock_class_key lock_class;
> +       struct drm_i915_gem_object *obj;
> +       unsigned int cache_level;
> +
> +       GEM_BUG_ON(!size);
> +       GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
> +
> +       if (overflows_type(size, obj->base.size))
> +               return ERR_PTR(-E2BIG);
> +
> +       obj = i915_gem_object_alloc();
> +       if (!obj)
> +               return ERR_PTR(-ENOMEM);
> +
> +       drm_gem_private_object_init(&i915->drm, &obj->base, size);
> +       i915_gem_object_init(obj, &pd_dummy_obj_ops, &lock_class, 0);
> +       obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
> +
> +       /*
> +        * Mark the object as volatile, such that the pages are
> marked as
> +        * dontneed whilst they are still pinned. As soon as they are
> unpinned
> +        * they are allowed to be reaped by the shrinker, and the
> caller is
> +        * expected to repopulate - the contents of this object are
> only valid
> +        * whilst active and pinned.
> +        */
> +       i915_gem_object_set_volatile(obj);
> +
> +       obj->read_domains = I915_GEM_DOMAIN_CPU;
> +       obj->write_domain = I915_GEM_DOMAIN_CPU;
> +
> +       cache_level = HAS_LLC(i915) ? I915_CACHE_LLC :
> I915_CACHE_NONE;
> +       i915_gem_object_set_cache_coherency(obj, cache_level);
> +
> +       return obj;
> +}
> +
>  static struct i915_page_directory *
>  gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
>  {
> @@ -383,9 +422,7 @@ gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
>         if (unlikely(!pd))
>                 return ERR_PTR(-ENOMEM);
>  
> -       pd->pt.base = __i915_gem_object_create_internal(ppgtt-
> >base.vm.gt->i915,
> -
>                                                        &pd_dummy_obj_o
> ps,
> -                                                       I915_PDES *
> SZ_4K);
> +       pd->pt.base = i915_gem_object_create_dummy(ppgtt->base.vm.gt-
> >i915, I915_PDES * SZ_4K);
>         if (IS_ERR(pd->pt.base)) {
>                 err = PTR_ERR(pd->pt.base);
>                 pd->pt.base = NULL;


