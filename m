Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05A347A6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhLTJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhLTJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:18:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1260C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:18:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p36-20020a05600c1da400b003457428ec78so7911379wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9w/ZSPyCi0NPX3Lyvam5j4ID+6iXQhov8aHhTDMcgAs=;
        b=MdcGx+BZF7lTug8mlLMGIPgkZMemghLdc5dYMWXRcQ1a6d2ScE9/9p0SYgYzZqd5eU
         GkJt6m1C6sJy8e31e2fapHYpAUjwCYUiqlg7G8O+EQZyJJbKxTRSQM8d+9n3kmn/kFVL
         yXCZi12djADFC2sXTEXh81PvtG1UXiHKaef5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9w/ZSPyCi0NPX3Lyvam5j4ID+6iXQhov8aHhTDMcgAs=;
        b=RwDKD/QgVlj/T89dN6jozkHdF7qeUmkpFoqCW8s/4fiskOCrNhFnzW7xOt15pI/Vko
         N5SgjnL14c1YApvp/4ulb1VSlU2KxBY0qofQrkQLcAz5HRgZPZ2HiGMfX3NNBg5ntmPe
         rqdpKbF5YHdd99zpwA2ea/Y1IfNfnzEkDNWlg9kpEe1KlnYE29u3HrWQabClV2mLDe0U
         9NQ3HI9UJ7gDZkY8uKehgIBbgJ6xm5E3cPRTuN6me+IuUF7MhDDsp5qFZzZV3La6q/AK
         HFDuUUvbgpyahh7seQv1OLEqxttuBY6ZAeIajO/NcdeL0EpIr9/QeaGmQK3gGDdfRojJ
         ZP+w==
X-Gm-Message-State: AOAM533r/EkwtbEvMYidMxgm1DreFSBTjAg1xzIq2b7UvGb3W4i28PjY
        WOZXAddYwtrlQi2hZ9hsSh+GnvKG9gCZYQ==
X-Google-Smtp-Source: ABdhPJx7KY7b44GAF3z2oyvxQbtRLkUoqeuSGgEMIQLTgKI1t2RaspDsXPwYsNciZ579soIvaDz1EQ==
X-Received: by 2002:a1c:7f50:: with SMTP id a77mr13530374wmd.57.1639991921338;
        Mon, 20 Dec 2021 01:18:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e18sm9318917wrx.36.2021.12.20.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 01:18:40 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:18:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Claudio Suarez <cssk@net-c.es>
Cc:     dri-devel@lists.freedesktop.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2] drm: fix error found in some cases after the patch
 d1af5cd86997
Message-ID: <YcBKbn/9oqD2taCk@phenom.ffwll.local>
Mail-Followup-To: Claudio Suarez <cssk@net-c.es>,
        dri-devel@lists.freedesktop.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
References: <YaC7zXW119tlzfVh@gineta.localdomain>
 <20211128142015.GB5295@xsang-OptiPlex-9020>
 <YaUpsaP7hng6zpFh@gineta.localdomain>
 <YaXi803g7iv9MxWR@phenom.ffwll.local>
 <YaiVfZWNyMkG8uED@gineta.localdomain>
 <YaiXEARd8z2C463h@gineta.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaiXEARd8z2C463h@gineta.localdomain>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:51:12AM +0100, Claudio Suarez wrote:
> The patch d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log
> calls in drm core, files drm_a*.c") fails when the drm_device
> cannot be found in the parameter plane_state->crtc.
> Fix it using plane_state->plane.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log calls in drm core, files drm_a*.c")
> Signed-off-by: Claudio Suarez <cssk@net-c.es>

Sorry I missed these two patches, but both applied now, thanks.
-Daniel

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index aef2fbd676e5..a7a05e1e26bb 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -828,8 +828,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
>  	}
>  
>  	if (!crtc_state->enable && !can_update_disabled) {
> -		drm_dbg_kms(plane_state->crtc->dev,
> -			       "Cannot update plane of a disabled CRTC.\n");
> +		drm_dbg_kms(plane_state->plane->dev,
> +			    "Cannot update plane of a disabled CRTC.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -839,8 +839,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
>  	hscale = drm_rect_calc_hscale(src, dst, min_scale, max_scale);
>  	vscale = drm_rect_calc_vscale(src, dst, min_scale, max_scale);
>  	if (hscale < 0 || vscale < 0) {
> -		drm_dbg_kms(plane_state->crtc->dev,
> -			       "Invalid scaling of plane\n");
> +		drm_dbg_kms(plane_state->plane->dev,
> +			    "Invalid scaling of plane\n");
>  		drm_rect_debug_print("src: ", &plane_state->src, true);
>  		drm_rect_debug_print("dst: ", &plane_state->dst, false);
>  		return -ERANGE;
> @@ -864,8 +864,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
>  		return 0;
>  
>  	if (!can_position && !drm_rect_equals(dst, &clip)) {
> -		drm_dbg_kms(plane_state->crtc->dev,
> -			       "Plane must cover entire CRTC\n");
> +		drm_dbg_kms(plane_state->plane->dev,
> +			    "Plane must cover entire CRTC\n");
>  		drm_rect_debug_print("dst: ", dst, false);
>  		drm_rect_debug_print("clip: ", &clip, false);
>  		return -EINVAL;
> -- 
> 2.33.0
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
