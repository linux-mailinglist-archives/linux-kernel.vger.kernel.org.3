Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9646CF3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhLHIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:44:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:13270 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233172AbhLHIo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:44:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237593422"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="237593422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 00:40:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="679819062"
Received: from cahanley-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.1])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 00:40:53 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/i915/display: Remove the useless
 variable offset and its assignment
In-Reply-To: <20211208074952.404381-1-luo.penghao@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211208074952.404381-1-luo.penghao@zte.com.cn>
Date:   Wed, 08 Dec 2021 10:40:49 +0200
Message-ID: <87y24v4hgu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
>
> The existence of offset is meaningless, so it should be deleted.
>
> The clang_analyzer complains as follows:
>
> Value stored to 'offset' is never read
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>

I've said the same things before, and I'll say them again.

Having an unused variable like this could be an indication of a bug
introduced by an earlier change; maybe we should still be using the
variable but no longer do. Please figure out when the variable became
unused and reference the commit so we can tell.

If cgel.zte@gmail.com sends the patches, we'll need their name and
Signed-off-by too.

Thanks for the report, but I'll consider this as a report only.


BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/i9xx_plane.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
> index b1439ba..a478b7f 100644
> --- a/drivers/gpu/drm/i915/display/i9xx_plane.c
> +++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
> @@ -964,7 +964,7 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
>  	struct intel_plane *plane = to_intel_plane(crtc->base.primary);
>  	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
>  	enum pipe pipe;
> -	u32 val, base, offset;
> +	u32 val, base;
>  	int fourcc, pixel_format;
>  	unsigned int aligned_height;
>  	struct drm_framebuffer *fb;
> @@ -1006,14 +1006,14 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
>  	fb->format = drm_format_info(fourcc);
>  
>  	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv)) {
> -		offset = intel_de_read(dev_priv, DSPOFFSET(i9xx_plane));
> +		intel_de_read(dev_priv, DSPOFFSET(i9xx_plane));
>  		base = intel_de_read(dev_priv, DSPSURF(i9xx_plane)) & 0xfffff000;
>  	} else if (DISPLAY_VER(dev_priv) >= 4) {
>  		if (plane_config->tiling)
> -			offset = intel_de_read(dev_priv,
> +			intel_de_read(dev_priv,
>  					       DSPTILEOFF(i9xx_plane));
>  		else
> -			offset = intel_de_read(dev_priv,
> +			intel_de_read(dev_priv,
>  					       DSPLINOFF(i9xx_plane));
>  		base = intel_de_read(dev_priv, DSPSURF(i9xx_plane)) & 0xfffff000;
>  	} else {

-- 
Jani Nikula, Intel Open Source Graphics Center
