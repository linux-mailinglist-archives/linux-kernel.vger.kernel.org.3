Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619734677D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbhLCNLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:11:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbhLCNLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:11:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C761396;
        Fri,  3 Dec 2021 05:08:21 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6F43F5A1;
        Fri,  3 Dec 2021 05:08:21 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 8A439684474; Fri,  3 Dec 2021 13:08:20 +0000 (GMT)
Date:   Fri, 3 Dec 2021 13:08:20 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/plane: Move range check for format_count earlier
Message-ID: <YaoWxOk0hCuVZpoz@e110455-lin.cambridge.arm.com>
References: <20211203102815.38624-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211203102815.38624-1-steven.price@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:28:15AM +0000, Steven Price wrote:
> While the check for format_count > 64 in __drm_universal_plane_init()
> shouldn't be hit (it's a WARN_ON), in its current position it will then
> leak the plane->format_types array and fail to call
> drm_mode_object_unregister() leaking the modeset identifier. Move it to
> the start of the function to avoid allocating those resources in the
> first place.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

Well spotted!

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

I'm going to wait to see if anyone else has any comments before I'll merge this into
drm-misc-fixes (or should it be drm-misc-next-fixes?)

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_plane.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 82afb854141b..fd0bf90fb4c2 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -249,6 +249,13 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  	if (WARN_ON(config->num_total_plane >= 32))
>  		return -EINVAL;
>  
> +	/*
> +	 * First driver to need more than 64 formats needs to fix this. Each
> +	 * format is encoded as a bit and the current code only supports a u64.
> +	 */
> +	if (WARN_ON(format_count > 64))
> +		return -EINVAL;
> +
>  	WARN_ON(drm_drv_uses_atomic_modeset(dev) &&
>  		(!funcs->atomic_destroy_state ||
>  		 !funcs->atomic_duplicate_state));
> @@ -270,13 +277,6 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  		return -ENOMEM;
>  	}
>  
> -	/*
> -	 * First driver to need more than 64 formats needs to fix this. Each
> -	 * format is encoded as a bit and the current code only supports a u64.
> -	 */
> -	if (WARN_ON(format_count > 64))
> -		return -EINVAL;
> -
>  	if (format_modifiers) {
>  		const uint64_t *temp_modifiers = format_modifiers;
>  
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
