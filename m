Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA014AA55E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378900AbiBEBlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiBEBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:41:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB34C061347
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 17:41:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y7so1315337plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 17:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=myz4g6Qa1WY7AUZda/vmt1iCRBi20oOlq1O4D8Tshf4=;
        b=WEQzYtgsyGerlT0ueBcIUWjjZDgUC2+53EpsPoDGP3uuPFB3ymg9NKe2NrgyUf8MMH
         j70XqajQ2TjQz9wOVN/Nlh7yoDGCHNk5bpcoN+iylAwS7btXeZnMpIBr8krgWPajbzQM
         sX14DVY5wOg8lE0oYHYUxgXxalig0VFjYSbPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=myz4g6Qa1WY7AUZda/vmt1iCRBi20oOlq1O4D8Tshf4=;
        b=i/gFrbsiiPSVvKq/uUN2kuVInngVvOkvFrQf/IvBLOqJLWfYUgJFfAmRX+HmNTePlg
         /h8ehAN7cKo0JGPr50oJxfF5rE2DI+n5GFEuWHaY3/412J8KojerLPTa5OrZkIuZBM5e
         65X7d8C0klmwg2L5PCHqrnJhx9dY0v9YzXfYlH8xclo08HZgVK1Rh9ssyCd77BMHrjde
         LK9wyy30PnJBxYu27pXRjyecVWty6t4raxhOhYp9/6TePULusy8MEBYLRODiFISLg/jr
         5y0bhAuQwcasZHPfR/kstTy3cXelKSkEOlw+UBHigIeZnv8shobpeYKvI1tg3DMbpGRF
         EsCA==
X-Gm-Message-State: AOAM532iSuOEEsNlgH8Jdh1DJM/T1A9E5PTjtHRoUhwTVLTWALZp+MK2
        6C7plq3UYjKdtweb8w4Cph+5Uw==
X-Google-Smtp-Source: ABdhPJzXzaOsxAG+LTQCOUvqb9DGjAcqKyn2JVuV4Dl2+ulTvIQd3muaH0g4LnXS7BZmwpz/ijca3w==
X-Received: by 2002:a17:902:ce8a:: with SMTP id f10mr6014427plg.35.1644025273975;
        Fri, 04 Feb 2022 17:41:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm13774838pjs.39.2022.02.04.17.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 17:41:13 -0800 (PST)
Date:   Fri, 4 Feb 2022 17:41:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Remove common Post Cursor2 register handling
Message-ID: <202202041740.F368F91F5@keescook>
References: <20220105173507.2420910-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105173507.2420910-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

This is a OOB read fix. Can someone please pick this up?

-Kees

On Wed, Jan 05, 2022 at 09:35:07AM -0800, Kees Cook wrote:
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
> -- 
> 2.30.2
> 

-- 
Kees Cook
