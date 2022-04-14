Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F48501767
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiDNPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348834AbiDNONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:13:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC3CC7496
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649945110; x=1681481110;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89/dz+Osr1QwvheHjAyZOBd+b+PSggqKY7BVPhCMc/4=;
  b=JocdJb7a7Iww0DuhVFCHFqviW28tUKZ8evgnkinYn+l2ZKoM77MabadX
   64BcCkqp3bwjsVlP7i5XT6mZLt6linxKTvRvSvG976bmc4eQeF1nop+76
   /tDzmfMgw8r1eWLlV6vi6ugcxtZXaSzp5es5FQgAxNQQ0jGJdDGLhwA4/
   0jHC6+vqdlfZ4DCw3zpCw1dEYihw4NKUVJ5Jq2LcgyPGYqjc3GsaklWXq
   bnJrdHx6NmiiV4bqwv33aqPhAknEl6neGytLOgDsVNbRwq5SOdq1dKHx+
   jguQT+t3zXgtLoAFwjQHP6Xyul41ivEEFbCsnaqTZhi8xjRbQ3cRsDDNo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244821097"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="244821097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:05:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="645634913"
Received: from aviljane-mobl.ger.corp.intel.com (HELO [10.249.254.86]) ([10.249.254.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:05:03 -0700
Message-ID: <07e5b1dc442e0b318ee0314f90a433216ed38dcb.camel@linux.intel.com>
Subject: Re: [PATCH v2 4/5] drm/i915: ttm backend dont provide mmap_offset
 for kernel buffers
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
Date:   Thu, 14 Apr 2022 16:05:00 +0200
In-Reply-To: <20220412151838.1298956-5-bob.beckett@collabora.com>
References: <20220412151838.1298956-1-bob.beckett@collabora.com>
         <20220412151838.1298956-5-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 15:18 +0000, Robert Beckett wrote:
> stolen/kernel buffers should not be mmapable by userland.
> do not provide callbacks to facilitate this for these buffers.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 32 +++++++++++++++++++++--
> --
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index a878910a563c..b20f81836c54 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -1092,8 +1092,8 @@ static void i915_ttm_unmap_virtual(struct
> drm_i915_gem_object *obj)
>         ttm_bo_unmap_virtual(i915_gem_to_ttm(obj));
>  }
>  
> -static const struct drm_i915_gem_object_ops i915_gem_ttm_obj_ops = {
> -       .name = "i915_gem_object_ttm",
> +static const struct drm_i915_gem_object_ops
> i915_gem_ttm_user_obj_ops = {
> +       .name = "i915_gem_object_ttm_user",
>         .flags = I915_GEM_OBJECT_IS_SHRINKABLE |
>                  I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
>  
> @@ -1111,6 +1111,21 @@ static const struct drm_i915_gem_object_ops
> i915_gem_ttm_obj_ops = {
>         .mmap_ops = &vm_ops_ttm,
>  };
>  
> +static const struct drm_i915_gem_object_ops
> i915_gem_ttm_kern_obj_ops = {
> +       .name = "i915_gem_object_ttm_kern",
> +       .flags = I915_GEM_OBJECT_IS_SHRINKABLE |
> +                I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
> +
> +       .get_pages = i915_ttm_get_pages,
> +       .put_pages = i915_ttm_put_pages,
> +       .truncate = i915_ttm_truncate,
> +       .shrink = i915_ttm_shrink,
> +
> +       .adjust_lru = i915_ttm_adjust_lru,
> +       .delayed_free = i915_ttm_delayed_free,
> +       .migrate = i915_ttm_migrate,
> +};

Do we really need two different ops here?

Since if we don't have mmap ops, basically that tells GEM it should do
the mmapping rather than TTM. 

That might of course come in handy for the shmem backend, but I don't
fully follow why we need this for stolen.

Also for the framebuffer handed over from BIOS to fbdev, Does that need
mmapping and if so, how do we handle that?


/Thomas




> +
>  void i915_ttm_bo_destroy(struct ttm_buffer_object *bo)
>  {
>         struct drm_i915_gem_object *obj = i915_ttm_to_gem(bo);
> @@ -1165,10 +1180,19 @@ int __i915_gem_ttm_object_init(struct
> intel_memory_region *mem,
>                 .no_wait_gpu = false,
>         };
>         enum ttm_bo_type bo_type;
> +       const struct drm_i915_gem_object_ops *ops;
>         int ret;
>  
>         drm_gem_private_object_init(&i915->drm, &obj->base, size);
> -       i915_gem_object_init(obj, &i915_gem_ttm_obj_ops, &lock_class,
> flags);
> +
> +       if (flags & I915_BO_ALLOC_USER &&
> intel_region_to_ttm_type(mem) != I915_PL_STOLEN) {
> +               bo_type = ttm_bo_type_device;
> +               ops = &i915_gem_ttm_user_obj_ops;
> +       } else {
> +               bo_type = ttm_bo_type_kernel;
> +               ops = &i915_gem_ttm_kern_obj_ops;
> +       }
> +       i915_gem_object_init(obj, ops, &lock_class, flags);
>  
>         obj->bo_offset = offset;
>  
> @@ -1178,8 +1202,6 @@ int __i915_gem_ttm_object_init(struct
> intel_memory_region *mem,
>  
>         INIT_RADIX_TREE(&obj->ttm.get_io_page.radix, GFP_KERNEL |
> __GFP_NOWARN);
>         mutex_init(&obj->ttm.get_io_page.lock);
> -       bo_type = (obj->flags & I915_BO_ALLOC_USER) ?
> ttm_bo_type_device :
> -               ttm_bo_type_kernel;
>  
>         obj->base.vma_node.driver_private = i915_gem_to_ttm(obj);
>  


