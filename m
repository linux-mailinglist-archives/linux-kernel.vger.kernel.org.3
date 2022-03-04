Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF94CDF9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiCDVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCDVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:12:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE0838BC2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646428321; x=1677964321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ykWgWP/GD+9Jm+IbipK2/JYt9vytoc4D+hbYU5DMUts=;
  b=BHr+YwXpuqNZhFBZJhrSWd94weN1x8LqMRtZgctOQKHM07CVOLIygvF8
   DX2l4usEU/93e4OH2TRgG3u+pVIUmgqlb3DaUVfKJ1G0YMPhX2SeXi/Y+
   hsKVqVABE6gPaumqj8JW1wlMkSmfHYO2hW8F+QSATHw4xft706RDIsMTi
   TOHfdLYC2cGtPaL7PMoojWs+fl57XIW/q38qwFKweAZ8bI+H09wwBwvtN
   YMtleo4r118Gm+kRZt1iFX2e3iHJ1K6SsJq22tHBZiTDlQW9i6nyO6qQx
   z6Nii6PaTEHosXuLsi7++NEprX6tNR6O5yEqEEs1jRdBP3bdeBkEYjRp3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278757374"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278757374"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552369587"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by orsmga008.jf.intel.com with SMTP; 04 Mar 2022 13:11:54 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Mar 2022 23:11:54 +0200
Date:   Fri, 4 Mar 2022 23:11:54 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     trix@redhat.com
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, matthew.d.roper@intel.com,
        lucas.demarchi@intel.com, airlied@redhat.com, imre.deak@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/i915: rework the error handling in *_dpll_params
Message-ID: <YiKAmhXEye0fpAyF@intel.com>
References: <20220304210355.608898-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220304210355.608898-1-trix@redhat.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:03:55PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> intel_dpll.c:472:31: warning: The left operand of '-'
>   is a garbage value [core.UndefinedBinaryOperatorResult]
>   this_err = abs(clock.dot - target);
>                  ~~~~~~~~~ ^
> 
> In a loop clock.dot is set on successful call to
> i9xx_calc_dpll_params().  If the call fails, the later
> *is_valid() will use the previous loop's clock.dot.

I don't think this can happen. intel_pll_is_valid() validates
all the dividers first and bails out if they are junk.

> 
> The *_dpll_params functions return an arithmetic statement
> with the clock.dot as the variable.  Change the error handler
> to set clock.dot to 0 and jump to the return statement.
> 
> Fixes: dccbea3b0704 ("drm/i915: calculate the port clock rate along with other PLL params")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dpll.c | 32 ++++++++++++++---------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
> index 0ae37fdbf2a5b..ba7cada704288 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll.c
> @@ -309,11 +309,13 @@ int pnv_calc_dpll_params(int refclk, struct dpll *clock)
>  {
>  	clock->m = clock->m2 + 2;
>  	clock->p = clock->p1 * clock->p2;
> -	if (WARN_ON(clock->n == 0 || clock->p == 0))
> -		return 0;
> +	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
> +		clock->dot = 0;
> +		goto end;
> +	}
>  	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n);
>  	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
> -
> +end:
>  	return clock->dot;
>  }
>  
> @@ -326,11 +328,13 @@ int i9xx_calc_dpll_params(int refclk, struct dpll *clock)
>  {
>  	clock->m = i9xx_dpll_compute_m(clock);
>  	clock->p = clock->p1 * clock->p2;
> -	if (WARN_ON(clock->n + 2 == 0 || clock->p == 0))
> -		return 0;
> +	if (WARN_ON(clock->n + 2 == 0 || clock->p == 0)) {
> +		clock->dot = 0;
> +		goto end;
> +	}
>  	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n + 2);
>  	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
> -
> +end:
>  	return clock->dot;
>  }
>  
> @@ -338,11 +342,13 @@ int vlv_calc_dpll_params(int refclk, struct dpll *clock)
>  {
>  	clock->m = clock->m1 * clock->m2;
>  	clock->p = clock->p1 * clock->p2;
> -	if (WARN_ON(clock->n == 0 || clock->p == 0))
> -		return 0;
> +	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
> +		clock->dot = 0;
> +		goto end;
> +	}
>  	clock->vco = DIV_ROUND_CLOSEST(refclk * clock->m, clock->n);
>  	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
> -
> +end:
>  	return clock->dot / 5;
>  }
>  
> @@ -350,12 +356,14 @@ int chv_calc_dpll_params(int refclk, struct dpll *clock)
>  {
>  	clock->m = clock->m1 * clock->m2;
>  	clock->p = clock->p1 * clock->p2;
> -	if (WARN_ON(clock->n == 0 || clock->p == 0))
> -		return 0;
> +	if (WARN_ON(clock->n == 0 || clock->p == 0)) {
> +		clock->dot = 0;
> +		goto end;
> +	}
>  	clock->vco = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(refclk, clock->m),
>  					   clock->n << 22);
>  	clock->dot = DIV_ROUND_CLOSEST(clock->vco, clock->p);
> -
> +end:
>  	return clock->dot / 5;
>  }
>  
> -- 
> 2.26.3

-- 
Ville Syrjälä
Intel
