Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BC3551589
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiFTKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiFTKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:13:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5912A92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655719982; x=1687255982;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Fzmu7C7+l4xuTEjVvRkgXFZwD/Iy08cHcIwmXQAaB/8=;
  b=jLUORwFHswBlsZvcBddegdD8/3IknzXMCcklaMzDotZICkSG/+HpLLJ3
   HFMWkx+kkZPIWpcAbkde7MUyuuiD5VvRfo7gopgIkghCbdlfUM9HXm7dJ
   TYBoLjAIQYfJg0X+yi96qE7fmb4CRK1uyHnBIjpog7tGHnvExxzUulIx4
   /HW0A8HnGlyrROC4FWq1ICgUSgbyUPHiTilvqy4exIn0vMj4sI3RA9MS/
   IFdYwG5bjD5QRoPW87uUnDALsA7njRo5ET+0GCIBmIhjHBkiYqqLBnA/j
   OY5OMveDU2M1H3KRjUdl10nScvMR99eGrw+5cmRG9ECJCTldavVmnLnBe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341539931"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341539931"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:13:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643048954"
Received: from hkanchar-mobl.gar.corp.intel.com (HELO localhost) ([10.252.36.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:12:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     zys.zljxml@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     bob.beckett@collabora.com, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] drm/i915/gem: remove unused assignments
In-Reply-To: <20220620100216.1791284-1-zys.zljxml@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220620100216.1791284-1-zys.zljxml@gmail.com>
Date:   Mon, 20 Jun 2022 13:12:55 +0300
Message-ID: <878rprtzh4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022, zys.zljxml@gmail.com wrote:
> From: katrinzhou <katrinzhou@tencent.com>
>
> The variable ret is reassigned and the value EINVAL is never used.
> Thus, remove the unused assignments.

It's obviously a bug, but it's not obvious just throwing the code away
is the fix. Maybe there's a missing "else" instead.

BR,
Jani.


>
> Addresses-Coverity: ("Unused value")
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Signed-off-by: katrinzhou <katrinzhou@tencent.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index ab4c5ab28e4d..d5ef5243673a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -931,8 +931,6 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>  		break;
>  
>  	case I915_CONTEXT_PARAM_PERSISTENCE:
> -		if (args->size)
> -			ret = -EINVAL;
>  		ret = proto_context_set_persistence(fpriv->dev_priv, pc,
>  						    args->value);
>  		break;

-- 
Jani Nikula, Intel Open Source Graphics Center
