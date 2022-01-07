Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E04877AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiAGMrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:47:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:26529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237422AbiAGMrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641559662; x=1673095662;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o90fDi1F1obo99hBdAW3oJtGnye3JFsSN73YJUlsJQ4=;
  b=fQX/y4IDm/XD1MV/U4t+y4lt8SXt6C1V1pFEuXvhhttk4B6SujKA12v9
   U6Ug45iSCMbBf8oF962KXU0jaeNPL4Am8KiGO6EW3jTzrLJJuyiapMfDe
   F0HXDRyLSqc0Ph4VFKW9bXgRUEQOSHAMnMgltMl0y2peveC7CmWG5Gu3q
   cmKGxk+vF8lRkMQf9rDhYQ9/OrR/7JZSKnMpZzMN+iNUSrqdUQQ85RCHi
   gaGeCdeI6d1VHGtv4AMrpsq/96atYIgsRYC5403OnljaOaLj4F1Ec2vvY
   xdERuOBP1G1vU3DwwoKk+W3yp442NnAy/No7d+16uWMdiIfHZEDGM5vTd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="329203251"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="329203251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:47:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="689773101"
Received: from dgreerx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.24.206])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:47:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ashish Arora <ashisharora.linux@outlook.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Discard large BIOS framebuffers causing
 display corruption.
In-Reply-To: <7F167771-2D0A-40AD-8162-645E7EE2B9A0@outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <7F167771-2D0A-40AD-8162-645E7EE2B9A0@outlook.com>
Date:   Fri, 07 Jan 2022 14:47:34 +0200
Message-ID: <87sftzlnkp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022, Ashish Arora <ashisharora.linux@outlook.com> wrote:
> From: Ashish Arora <ashisharora.linux@outlook.com>
>
> On certain 4k panels, the BIOS framebuffer is larger than what panel
> requires causing display corruption. Introduce a check for the same.

This is quite thin on details. Is there a bug report?

Moreover, if this is what we want, this should be combined with the
conditions that follow resulting in a "!=" check instead of separate "<"
and ">".

BR,
Jani.



>
> Signed-off-by: Ashish Arora <ashisharora.linux@outlook.com>
> ---
>  drivers/gpu/drm/i915/display/intel_fbdev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
> index adc3a81be..f9952e1f8 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
> @@ -193,6 +193,17 @@ static int intelfb_create(struct drm_fb_helper *helper,
>  	struct drm_i915_gem_object *obj;
>  	int ret;
>  
> +	if (intel_fb &&
> +	    (sizes->fb_width < intel_fb->base.width ||
> +	     sizes->fb_height < intel_fb->base.height)) {
> +		drm_dbg_kms(&dev_priv->drm,
> +			    "BIOS fb too large (%dx%d), we require (%dx%d),"
> +			    " releasing it\n",
> +			    intel_fb->base.width, intel_fb->base.height,
> +			    sizes->fb_width, sizes->fb_height);
> +		drm_framebuffer_put(&intel_fb->base);
> +		intel_fb = ifbdev->fb = NULL;
> +	}
>  	if (intel_fb &&
>  	    (sizes->fb_width > intel_fb->base.width ||
>  	     sizes->fb_height > intel_fb->base.height)) {

-- 
Jani Nikula, Intel Open Source Graphics Center
