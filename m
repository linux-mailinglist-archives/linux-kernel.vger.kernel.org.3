Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21E048CA81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355867AbiALR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:59:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:43707 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348659AbiALR7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642010371; x=1673546371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/LjtuAyqmkFIWB4hNh60XmaO1IJi5r5eKvYN+nL3Gg=;
  b=gagC5pe6ScfsHZwRemt3eoF6K1mnvhL1Zl0navoKa/BlPYpPOERRaY4l
   E9ggK3/sF6eYHsxxEd55D8Sqvb7A0z4RiAuFHeCIAeeB6rcjk0eEb7znZ
   t11TQHGyo5g+308Efmw+Z3bbJt8sU2H6CqyX7ccqg1UeMfSKuVmFjBUeV
   VtqXXl5Ode/kwG+marAd0FEnXrPhdcAMWy3wzzi3Dl7nEnOKyJT5TGuUK
   0Y5yZ5vMKJC5L4C/7MMCTyuOxOx2yPUOtZCUnKWkJ2Eo2gRX5oMNbrivc
   xp8eMhbWhnWyfZi5PKu2xYAI1iszk1YHw8UDX766ZTm7WaZl13/y8wBo3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224491841"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224491841"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 09:59:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623541892"
Received: from jons-linux-dev-box.fm.intel.com (HELO jons-linux-dev-box) ([10.1.27.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 09:59:29 -0800
Date:   Wed, 12 Jan 2022 09:53:38 -0800
From:   Matthew Brost <matthew.brost@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andi Shyti <andi.shyti@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/selftests: Fix NULL vs IS_ERR checking for
 kernel_context
Message-ID: <20220112175338.GA12463@jons-linux-dev-box>
References: <20211222075832.1732-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222075832.1732-1-linmq006@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 07:58:29AM +0000, Miaoqian Lin wrote:
> Since i915_gem_create_context() function return error pointers,
> the kernel_context() function does not return null, It returns error
> pointers too. Using IS_ERR() to check the return value to fix this.
> 

Just a nit, err is initialized to -ENOMEM in a bunch of these tests
which isn't needed anymore. If you want to clean that up too, feel free.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com> 

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/selftest_execlists.c | 41 ++++++++++++++------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> index b367ecfa42de..eacfe920afed 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -1540,13 +1540,16 @@ static int live_busywait_preempt(void *arg)
>  	 */
>  
>  	ctx_hi = kernel_context(gt->i915, NULL);
> -	if (!ctx_hi)
> -		return -ENOMEM;
> +	if (IS_ERR(ctx_hi))
> +		return IS_ERR(ctx_hi);
> +
>  	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
>  
>  	ctx_lo = kernel_context(gt->i915, NULL);
> -	if (!ctx_lo)
> +	if (IS_ERR(ctx_lo)) {
> +		err = PTR_ERR(ctx_lo);
>  		goto err_ctx_hi;
> +	}
>  	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
>  
>  	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
> @@ -1742,13 +1745,17 @@ static int live_preempt(void *arg)
>  		goto err_spin_hi;
>  
>  	ctx_hi = kernel_context(gt->i915, NULL);
> -	if (!ctx_hi)
> +	if (IS_ERR(ctx_hi)) {
> +		err = PTR_ERR(ctx_hi);
>  		goto err_spin_lo;
> +	}
>  	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
>  
>  	ctx_lo = kernel_context(gt->i915, NULL);
> -	if (!ctx_lo)
> +	if (IS_ERR(ctx_lo)) {
> +		err = PTR_ERR(ctx_lo);
>  		goto err_ctx_hi;
> +	}
>  	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
>  
>  	for_each_engine(engine, gt, id) {
> @@ -1834,12 +1841,16 @@ static int live_late_preempt(void *arg)
>  		goto err_spin_hi;
>  
>  	ctx_hi = kernel_context(gt->i915, NULL);
> -	if (!ctx_hi)
> +	if (IS_ERR(ctx_hi)) {
> +		err = PTR_ERR(ctx_hi);
>  		goto err_spin_lo;
> +	}
>  
>  	ctx_lo = kernel_context(gt->i915, NULL);
> -	if (!ctx_lo)
> +	if (IS_ERR(ctx_lo)) {
> +		err = PTR_ERR(ctx_lo);
>  		goto err_ctx_hi;
> +	}
>  
>  	/* Make sure ctx_lo stays before ctx_hi until we trigger preemption. */
>  	ctx_lo->sched.priority = 1;
> @@ -1928,8 +1939,8 @@ struct preempt_client {
>  static int preempt_client_init(struct intel_gt *gt, struct preempt_client *c)
>  {
>  	c->ctx = kernel_context(gt->i915, NULL);
> -	if (!c->ctx)
> -		return -ENOMEM;
> +	if (IS_ERR(c->ctx))
> +		return PTR_ERR(c->ctx);
>  
>  	if (igt_spinner_init(&c->spin, gt))
>  		goto err_ctx;
> @@ -3385,13 +3396,17 @@ static int live_preempt_timeout(void *arg)
>  		return -ENOMEM;
>  
>  	ctx_hi = kernel_context(gt->i915, NULL);
> -	if (!ctx_hi)
> +	if (IS_ERR(ctx_hi)) {
> +		err = PTR_ERR(ctx_hi);
>  		goto err_spin_lo;
> +	}
>  	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
>  
>  	ctx_lo = kernel_context(gt->i915, NULL);
> -	if (!ctx_lo)
> +	if (IS_ERR(ctx_lo)) {
> +		err = PTR_ERR(ctx_lo);
>  		goto err_ctx_hi;
> +	}
>  	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
>  
>  	for_each_engine(engine, gt, id) {
> @@ -3683,8 +3698,10 @@ static int live_preempt_smoke(void *arg)
>  
>  	for (n = 0; n < smoke.ncontext; n++) {
>  		smoke.contexts[n] = kernel_context(smoke.gt->i915, NULL);
> -		if (!smoke.contexts[n])
> +		if (IS_ERR(smoke.contexts[n])) {
> +			err = PTR_ERR(smoke.contexts[n]);
>  			goto err_ctx;
> +		}
>  	}
>  
>  	for (n = 0; n < ARRAY_SIZE(phase); n++) {
> -- 
> 2.17.1
> 
