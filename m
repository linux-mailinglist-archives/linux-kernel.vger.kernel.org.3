Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7D55487B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354020AbiFVL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiFVL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:56:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C4C1D306
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655898964; x=1687434964;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jiO41cw5EB9KwYflgSuTIcwKXiyLAI7JCG04Edl/BM=;
  b=Gg3OB93KefCui4w4u5mek0dZZ1XzDZb7XVF+WRI5GqMbufvHVHkjBwWh
   FoSlVjWiLpgk2edXggLrzpFk9Hm7IkJo9n8yakxpfF8dBcw4qT2WJMdWi
   3g59vkDUSz9MnqdSxSrFKQLAWE9LbWMTC+BDA/4zfZMr3hcQuG/jHbxGn
   Qvutbk4zAIC1TrmLpMmBQBrJoX4P40I0Q98xHBimzTyYbrujMcXjktHsc
   k7mmb1C5Mo+DWJbJM1Pd6LX8/kM93MbzlCWYa65dorunX52o2LOvoMA8O
   BDIcS+MzqvdGISU4J0paxHKpFUekKcsN7hRiWIW0ZewOfyBb7Xm0cHIoj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263430374"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="263430374"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:56:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690464617"
Received: from wterliko-mobl.ger.corp.intel.com (HELO [10.249.254.201]) ([10.249.254.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:56:00 -0700
Message-ID: <a2a439f677254260c3c4dd6369b8b478d3581889.camel@linux.intel.com>
Subject: Re: [PATCH v8 08/10] drm/i915: allow memory region creators to
 alloc and free the region
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
Cc:     kernel@collabora.com, Matthew Auld <matthew.auld@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jun 2022 13:55:58 +0200
In-Reply-To: <20220621200058.3536182-9-bob.beckett@collabora.com>
References: <20220621200058.3536182-1-bob.beckett@collabora.com>
         <20220621200058.3536182-9-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bob,

On Tue, 2022-06-21 at 20:00 +0000, Robert Beckett wrote:
> add callbacks for alloc and free.
> this allows region creators to allocate any extra storage they may
> require.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

I think the correct solution here would be to, similar to ttm, export
an alloc_reserved() or alloc_locked() interface, that simply skips the
unlock at bo alloc time.

Then the stolen alloc wrapper could simply pin as/if needed under the
lock.

/Thomas



> ---
>  drivers/gpu/drm/i915/intel_memory_region.c | 16 +++++++++++++---
>  drivers/gpu/drm/i915/intel_memory_region.h |  2 ++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_memory_region.c
> b/drivers/gpu/drm/i915/intel_memory_region.c
> index e38d2db1c3e3..3da07a712f90 100644
> --- a/drivers/gpu/drm/i915/intel_memory_region.c
> +++ b/drivers/gpu/drm/i915/intel_memory_region.c
> @@ -231,7 +231,10 @@ intel_memory_region_create(struct
> drm_i915_private *i915,
>         struct intel_memory_region *mem;
>         int err;
>  
> -       mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +       if (ops->alloc)
> +               mem = ops->alloc();
> +       else
> +               mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>         if (!mem)
>                 return ERR_PTR(-ENOMEM);
>  
> @@ -265,7 +268,10 @@ intel_memory_region_create(struct
> drm_i915_private *i915,
>         if (mem->ops->release)
>                 mem->ops->release(mem);
>  err_free:
> -       kfree(mem);
> +       if (mem->ops->free)
> +               mem->ops->free(mem);
> +       else
> +               kfree(mem);
>         return ERR_PTR(err);
>  }
>  
> @@ -288,7 +294,11 @@ void intel_memory_region_destroy(struct
> intel_memory_region *mem)
>  
>         GEM_WARN_ON(!list_empty_careful(&mem->objects.list));
>         mutex_destroy(&mem->objects.lock);
> -       if (!ret)
> +       if (ret)
> +               return;
> +       if (mem->ops->free)
> +               mem->ops->free(mem);
> +       else
>                 kfree(mem);
>  }
>  
> diff --git a/drivers/gpu/drm/i915/intel_memory_region.h
> b/drivers/gpu/drm/i915/intel_memory_region.h
> index 3d8378c1b447..048955b5429f 100644
> --- a/drivers/gpu/drm/i915/intel_memory_region.h
> +++ b/drivers/gpu/drm/i915/intel_memory_region.h
> @@ -61,6 +61,8 @@ struct intel_memory_region_ops {
>                            resource_size_t size,
>                            resource_size_t page_size,
>                            unsigned int flags);
> +       struct intel_memory_region *(*alloc)(void);
> +       void (*free)(struct intel_memory_region *mem);
>  };
>  
>  struct intel_memory_region {


