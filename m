Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5978C49761A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiAWWpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAWWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:45:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C136C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:45:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6358FD89;
        Sun, 23 Jan 2022 23:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642977909;
        bh=Tpd2xJOyPUYI9Yn817WlPsinNuoRZkReK2xzPz5Iv2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg+2+jLNXiq4Q8S/HfrbfExWW9Pzdl4nt5YHUe4P+NC3z3LMcaSgqtpgwljZSTd4I
         R6DOvk3xa6aAc9HhxoKyUi6jQh3Xv6+aRjrIvZnyiqD10dioGmArr3NnRKCCBeIefx
         xzYp0RAAKqcrdCREPNF4P/yFmEw9GsNLSPus8fPQ=
Date:   Mon, 24 Jan 2022 00:44:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomohito Esaki <etom@igel.co.jp>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: Re: [RFC PATCH v3 3/3] drm: remove allow_fb_modifiers
Message-ID: <Ye3aZHFQQux4brrc@pendragon.ideasonboard.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-4-etom@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220114101753.24996-4-etom@igel.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Esaki-san,

Thank you for the patch.

On Fri, Jan 14, 2022 at 07:17:53PM +0900, Tomohito Esaki wrote:
> The allow_fb_modifiers flag is unnecessary since it has been replaced
> with cannot_support_modifiers flag.

The new flag is fb_modifiers_not_supported, not
cannot_support_modifiers.

> Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
> ---
>  drivers/gpu/drm/drm_plane.c                      |  9 ---------
>  drivers/gpu/drm/selftests/test-drm_framebuffer.c |  1 -
>  include/drm/drm_mode_config.h                    | 16 ----------------
>  3 files changed, 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 5aa7e241971e..89a3d044ab59 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -288,15 +288,6 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  		}
>  	}
>  
> -	/* autoset the cap and check for consistency across all planes */
> -	if (format_modifier_count) {
> -		drm_WARN_ON(dev, !config->allow_fb_modifiers &&
> -			    !list_empty(&config->plane_list));
> -		config->allow_fb_modifiers = true;
> -	} else {
> -		drm_WARN_ON(dev, config->allow_fb_modifiers);
> -	}
> -

Shouldn't we keep a sanity check to ensure that drivers setting
fb_modifiers_not_supported do not pass modifiers ?

	drm_WARN_ON(dev, config->fb_modifiers_not_supported &&
		    format_modifier_count);

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	plane->modifier_count = format_modifier_count;
>  	plane->modifiers = kmalloc_array(format_modifier_count,
>  					 sizeof(format_modifiers[0]),
> diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> index 61b44d3a6a61..f6d66285c5fc 100644
> --- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> +++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> @@ -323,7 +323,6 @@ static struct drm_device mock_drm_device = {
>  		.max_width = MAX_WIDTH,
>  		.min_height = MIN_HEIGHT,
>  		.max_height = MAX_HEIGHT,
> -		.allow_fb_modifiers = true,
>  		.funcs = &mock_config_funcs,
>  	},
>  };
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index da82f45351c7..5001bda9f9af 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -917,22 +917,6 @@ struct drm_mode_config {
>  	 */
>  	bool async_page_flip;
>  
> -	/**
> -	 * @allow_fb_modifiers:
> -	 *
> -	 * Whether the driver supports fb modifiers in the ADDFB2.1 ioctl call.
> -	 * Note that drivers should not set this directly, it is automatically
> -	 * set in drm_universal_plane_init().
> -	 *
> -	 * IMPORTANT:
> -	 *
> -	 * If this is set the driver must fill out the full implicit modifier
> -	 * information in their &drm_mode_config_funcs.fb_create hook for legacy
> -	 * userspace which does not set modifiers. Otherwise the GETFB2 ioctl is
> -	 * broken for modifier aware userspace.
> -	 */
> -	bool allow_fb_modifiers;
> -
>  	/**
>  	 * @fb_modifiers_not_supported:
>  	 *

-- 
Regards,

Laurent Pinchart
