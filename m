Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB949501744
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiDNPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiDNOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:02:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449ADD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649944759; x=1681480759;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDZXdZIyeMCAJpASuXEC2rLdsvUK9DibPgDtDpIJulQ=;
  b=VmhhqJv0pU3nPSaHmEwLWDlfA5WFnfjT1K7rlHjt0a4LhEAPJetOPo9k
   TlQmtNtkLGYrdVz8Eox0WEQKZnNyQAUWZTB++9X2RcFJ2Bt6mR7jNF93N
   r0ACbiw4khaxx4jhDRfz6+dvz8rUhtByx8b1jZuM2ywQCZCiIQpUl9PCW
   LhCaGlhfLuf6KQpkZCbGd0MiFNpQH4WaJ2aFsaNRy6itQyrj7AGICalFT
   6OJ5NwF9VRLJlmJMroRfuh3+IA88xtljBCX7Qn+HkiE97TCtx8+JlqBO7
   vtjBjBThRSp27dcTatN12xKjsGKUIFL1kuqI4FSveBd/o8GmqIdl0SW9d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262378046"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262378046"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:59:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="661383991"
Received: from aviljane-mobl.ger.corp.intel.com (HELO [10.249.254.86]) ([10.249.254.86])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:59:15 -0700
Message-ID: <955ad2c80d540ba9eee884d6a1f15b4d1604e306.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/5] drm/i915: sanitize mem_flags for stolen buffers
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
Date:   Thu, 14 Apr 2022 15:58:53 +0200
In-Reply-To: <20220412151838.1298956-3-bob.beckett@collabora.com>
References: <20220412151838.1298956-1-bob.beckett@collabora.com>
         <20220412151838.1298956-3-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 15:18 +0000, Robert Beckett wrote:
> stolen regions are not page backed or considered iomem.

thus...

A little more elaborate commit message please.


> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index 358f8a1a30ce..9fe8132de3b2 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -122,8 +122,9 @@ void i915_ttm_adjust_gem_after_move(struct
> drm_i915_gem_object *obj)
>  
>         obj->mem_flags &= ~(I915_BO_FLAG_STRUCT_PAGE |
> I915_BO_FLAG_IOMEM);
>  
> -       obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ?
> I915_BO_FLAG_IOMEM :
> -               I915_BO_FLAG_STRUCT_PAGE;
> +       if (obj->mm.region->id != INTEL_REGION_STOLEN_SMEM)
> +               obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo-
> >resource) ? I915_BO_FLAG_IOMEM :
> +                       I915_BO_FLAG_STRUCT_PAGE;
>  
>         cache_level = i915_ttm_cache_level(to_i915(bo->base.dev), bo-
> >resource,
>                                            bo->ttm);


