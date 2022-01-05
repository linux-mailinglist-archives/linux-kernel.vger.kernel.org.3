Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E74857D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiAESBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:01:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:45335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242669AbiAESBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641405660; x=1672941660;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yOIur3u1Lt7xcKqKlOErzfMPr1eITTU9LlA4YdRz9kc=;
  b=Y3MighYSsDt3Yn3qLCZ5bglrj1nVWgg4ubqcNEgBVnraQw7yDS2pypzc
   tGrXZOwUr5u8i53KeXBh57izkgyYOKSIFjEZRM6YszNT2o8YlH2BMHBht
   Tn20iitTrkTw8BloxnmdbNKP+PTfEak23e1U6XlMWy7JbRGNXghxUbEqR
   U3cLNm5ZJaqEC6q0QndjNOyVDzulPK7r8ZyUh2s+csUZqKUrxrFvhOxOh
   P5E72ed2SLd3JwI8fZv4Xg6Rh8smN05jU6dPbzxGWUjIRGSNLW0BEbmH6
   YKzU/zxIi4ZyP8KpCbUG/TiLcTYWJrdIErfxErrdAax4rrZQha3WKzH3A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240040488"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="240040488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:00:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="526627797"
Received: from menright-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.25.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:00:53 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Remove common Post Cursor2 register handling
In-Reply-To: <20220105173507.2420910-1-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220105173507.2420910-1-keescook@chromium.org>
Date:   Wed, 05 Jan 2022 20:00:50 +0200
Message-ID: <878rvujc4t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2022, Kees Cook <keescook@chromium.org> wrote:
> The link_status array was not large enough to read the Adjust Request
> Post Cursor2 register, so remove the common helper function to avoid
> an OOB read, found with a -Warray-bounds build:
>
> drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
> drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
>    59 |         return link_status[r - DP_LANE0_1_STATUS];
>       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
>   147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
>       |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Replace the only user of the helper with an open-coded fetch and decode,
> similar to drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.
>
> Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is the alternative to:
> https://lore.kernel.org/lkml/20211203084354.3105253-1-keescook@chromium.org/
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 10 ----------
>  drivers/gpu/drm/tegra/dp.c      | 11 ++++++++++-
>  include/drm/drm_dp_helper.h     |  2 --
>  3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 23f9073bc473..c9528aa62c9c 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -144,16 +144,6 @@ u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>  }
>  EXPORT_SYMBOL(drm_dp_get_adjust_tx_ffe_preset);
>  
> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> -					 unsigned int lane)
> -{
> -	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
> -	u8 value = dp_link_status(link_status, offset);
> -
> -	return (value >> (lane << 1)) & 0x3;
> -}
> -EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
> -
>  static int __8b10b_clock_recovery_delay_us(const struct drm_dp_aux *aux, u8 rd_interval)
>  {
>  	if (rd_interval > 4)
> diff --git a/drivers/gpu/drm/tegra/dp.c b/drivers/gpu/drm/tegra/dp.c
> index 70dfb7d1dec5..f5535eb04c6b 100644
> --- a/drivers/gpu/drm/tegra/dp.c
> +++ b/drivers/gpu/drm/tegra/dp.c
> @@ -549,6 +549,15 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>  {
>  	struct drm_dp_link_train_set *adjust = &link->train.adjust;
>  	unsigned int i;
> +	u8 post_cursor;
> +	int err;
> +
> +	err = drm_dp_dpcd_read(link->aux, DP_ADJUST_REQUEST_POST_CURSOR2,
> +			       &post_cursor, sizeof(post_cursor));

There's a drm_dp_dpcd_readb() for the common 1-byte reads. Other than
that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Though obviously that's not enough to actually merge to tegra.

> +	if (err < 0) {
> +		DRM_ERROR("failed to read post_cursor2: %d\n", err);
> +		post_cursor = 0;
> +	}
>  
>  	for (i = 0; i < link->lanes; i++) {
>  		adjust->voltage_swing[i] =
> @@ -560,7 +569,7 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>  				DP_TRAIN_PRE_EMPHASIS_SHIFT;
>  
>  		adjust->post_cursor[i] =
> -			drm_dp_get_adjust_request_post_cursor(status, i);
> +			(post_cursor >> (i << 1)) & 0x3;
>  	}
>  }
>  
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 472dac376284..fdf3cf6ccc02 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1528,8 +1528,6 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>  					  int lane);
>  u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>  				   int lane);
> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> -					 unsigned int lane);
>  
>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
>  #define DP_RECEIVER_CAP_SIZE		0xf

-- 
Jani Nikula, Intel Open Source Graphics Center
