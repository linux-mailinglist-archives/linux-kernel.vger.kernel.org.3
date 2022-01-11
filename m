Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8748A99D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiAKIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:36:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:31519 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbiAKIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641890211; x=1673426211;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fb8nWMAZrmWV41xVjkHvGnRCVsb+6xDWT6E89YI2w8A=;
  b=ml2GcNP7vd1cg1Oo0NCQ8/wNVY30Cs3vqRXUFknlUBoXeJHVvnNxs11e
   WFNKDCB6u/tPsySzj0slMxaHzUKTFkSinJgCfQmOY/uVfLKglkD+ra7m1
   zFFzc3omNQbUYLgMLoWbI687hLIoP1UmS2H1/OBP25730BzMk/Kk1viZE
   ri5oTI062bLI9nsgcDNRekN53RJHYspqfI3QARobe3K/PqSxOSA+hXpY+
   eFWCliO7CLpcn5BmzTmTOe3CyLYDNbZrGu7QzmrNwEjHaqD68hdF2przL
   ZMc53vcXqwDurwte+q699XFP8nPw2ENQLTR/kzbiX0YBYmzS4c/uHhf6d
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304173561"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="304173561"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 00:36:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="622997227"
Received: from sjobrien-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.25.241])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 00:36:49 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ashish Arora <ashisharora.linux@outlook.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        ville.syrjala@linux.intel.com
Subject: Re: [PATCH - v3] drm/i915: Discard large BIOS framebuffers causing
 display corruption.
In-Reply-To: <31D69334-DEF9-41B7-968B-B847796926FF@outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <31D69334-DEF9-41B7-968B-B847796926FF@outlook.com>
Date:   Tue, 11 Jan 2022 10:36:46 +0200
Message-ID: <87v8yq8y8x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022, Ashish Arora <ashisharora.linux@outlook.com> wrote:
> From: Ashish Arora <ashisharora.linux@outlook.com>
>
> On certain 4k panels and Macs, the BIOS framebuffer is larger than what
> panel requires causing display corruption. Introduce a check for the same.
>
>
> Signed-off-by: Ashish Arora <ashisharora.linux@outlook.com>
> Reviewed-by: Aun-Ali Zaidi <admin@kodeit.net>

I'll defer to Ville on this one, Cc'd.

BR,
Jani.



> ---
> V2 :- Use != instead of < and >
> V3 :- Mention Macs (Thanks to Orlando)
>  drivers/gpu/drm/i915/display/intel_fbdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
> index 842c04e63..16b1c82b2 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
> @@ -181,10 +181,10 @@ static int intelfb_create(struct drm_fb_helper *helper,
>  	int ret;
>  
>  	if (intel_fb &&
> -	    (sizes->fb_width > intel_fb->base.width ||
> -	     sizes->fb_height > intel_fb->base.height)) {
> +	    (sizes->fb_width != intel_fb->base.width ||
> +	     sizes->fb_height != intel_fb->base.height)) {
>  		drm_dbg_kms(&dev_priv->drm,
> -			    "BIOS fb too small (%dx%d), we require (%dx%d),"
> +			    "BIOS fb not valid (%dx%d), we require (%dx%d),"
>  			    " releasing it\n",
>  			    intel_fb->base.width, intel_fb->base.height,
>  			    sizes->fb_width, sizes->fb_height);

-- 
Jani Nikula, Intel Open Source Graphics Center
