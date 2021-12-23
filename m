Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F348447E2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbhLWL5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:57:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:62904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236799AbhLWL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640260622; x=1671796622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l7/Ec1k8g+Fuqc+4+s0zclAcRcBVVg9oTnf/81Ddgz8=;
  b=kYc3sNibFvI+YB1x1ukeZUl8W29DH/QdJbCOecGr02Q7EdxTHm7h0cU0
   BE1KQp1pYgg9j2meS62cnO2f5Tio7fngBLC3i70N88bjc5QfA0+rwliIh
   qCBZ/yK24fOXIha9bpOzcSbJVLXZ5aFrGfblWJFvYjKZknfW65fxhwHMh
   1i7kpK+p1PGkIgXPueCa3c4TCvk4FW3V5s4BpxduA7Qs2Dx4aNOnftnn9
   2mtqOvk64GwwR4wSpZMM29vXG12c76onjergnNWfa0B0uNK+swa+mcbnI
   6jdPJTgiodCPoYrdvgh4cDhKDe5PZYv6thsnW25kqljYE1vuDp6J2rN1s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239568213"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="239568213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 03:57:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="607735683"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.147])
  by FMSMGA003.fm.intel.com with SMTP; 23 Dec 2021 03:56:55 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 Dec 2021 13:56:55 +0200
Date:   Thu, 23 Dec 2021 13:56:55 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     contact@emersion.fr, airlied@linux.ie,
        alexandre.torgue@foss.st.com, benjamin.gaignard@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, s.hauer@pengutronix.de,
        rodrigo.vivi@intel.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yannick.fertre@foss.st.com,
        linux-kernel@vger.kernel.org, philippe.cornu@foss.st.com,
        mcoquelin.stm32@gmail.com, dmitry.baryshkov@linaro.org,
        shawnguo@kernel.org
Subject: Re: [PATCH v2 1/6] =?iso-8859-1?Q?drm=2Fpl?=
 =?iso-8859-1?Q?ane=3A_Make_format=5Fmod=5Fsupported_truly=A0optional?=
Message-ID: <YcRkB7uWyt4EbcZm@intel.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
 <20211222090552.25972-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222090552.25972-2-jose.exposito89@gmail.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:05:47AM +0100, José Expósito wrote:
> The documentation for "drm_plane_funcs.format_mod_supported" reads:
> 
>   This *optional* hook is used for the DRM to determine if the given
>   format/modifier combination is valid for the plane. This allows the
>   DRM to generate the correct format bitmask (which formats apply to
>   which modifier), and to validate modifiers at atomic_check time.
> 
>   *If not present*, then any modifier in the plane's modifier
>   list is allowed with any of the plane's formats.
> 
> However, where the function is not present, an invalid IN_FORMATS blob
> property with modifiers but no formats is exposed to user-space.
> 
> This breaks the latest Weston [1]. For testing purposes, I extracted the
> affected code to a standalone program [2].
> 
> Make "create_in_format_blob" behave as documented.
> 
> [1] https://gitlab.freedesktop.org/wayland/weston/-/blob/9.0/libweston/backend-drm/kms.c#L431
> [2] https://github.com/JoseExposito/drm-sandbox/blob/main/in_formats.c
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 82afb854141b..c1186b7215ee 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -202,17 +202,13 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
>  
>  	memcpy(formats_ptr(blob_data), plane->format_types, formats_size);
>  
> -	/* If we can't determine support, just bail */
> -	if (!plane->funcs->format_mod_supported)
> -		goto done;
> -
>  	mod = modifiers_ptr(blob_data);
>  	for (i = 0; i < plane->modifier_count; i++) {
>  		for (j = 0; j < plane->format_count; j++) {
> -			if (plane->funcs->format_mod_supported(plane,
> +			if (!plane->funcs->format_mod_supported ||
> +			    plane->funcs->format_mod_supported(plane,
>  							       plane->format_types[j],
>  							       plane->modifiers[i])) {

So instead of skipping the whole loop you just skip doing anything
inside the loop? Can't see how that achieves anything at all.

https://patchwork.freedesktop.org/series/83018/
is what I had in mind earlier but no one reviewed it and 
the discussion veered off track IIRC.

-- 
Ville Syrjälä
Intel
