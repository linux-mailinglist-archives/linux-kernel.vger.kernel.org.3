Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735E1485B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbiAEWMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbiAEWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:11:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D40C034002
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:11:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so5817187pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=23epZgha1vduYGwfVlyJXoEQeuHeRLa9G6BF3JRJdSs=;
        b=bfeddHzRv9HtJY5mtsQRXVAOEmYWMs7ngEG2ATROmYEtn24O+nonhf7KXPUwBbWEoo
         Wdhdhi1DkRY1Ss9sS4fVkhXWyStKlzF3BgmTaRXF8RixyXt4QlFk/ZjxDMkUfcSZLAkI
         Yaai59wXJJwwANPPLgBNPHaBM5LgVDD4YPl+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23epZgha1vduYGwfVlyJXoEQeuHeRLa9G6BF3JRJdSs=;
        b=kAzYM43d5Fwn1cswx9FylDVkDrwyAxHPvIlZR0ubXIrmlCz1k3SLOW8KgO+WOxZ57l
         G9kNZmA7f5NUY1sIy+hFNibI1zVk6XxICHIUpw2C1+TngXs0Nfrqn8ubANByCn5sp9ki
         ko9uMiKfwErJm9Rvug5FBbgmdgtWHKIF8mDtHfFnCPMAft/eRtTMo5tstTq4f6nAcQhW
         F18WueXUBGhWdkTRx5b5pZuwlQc+EpgnlNE2PIP4FzvXPAIv0+QGAf2zh27nmEYw2l/Y
         1wGeQAhPaliW3hnftVj7PvkDUflMZV/WlZwLthFIvUSxp9Nv6fKwJV0eJ8wBqnNMEGef
         aFYQ==
X-Gm-Message-State: AOAM531YvF0jWZlupAaUZv8Hn8YEOcOe54X9q49/tCm/1/Wb+oQKlXNt
        18I7DcA4zZ9fj626afJWS+7IZg==
X-Google-Smtp-Source: ABdhPJzA1QQolIAGWUj/J4KwNJXn9ApDguH+fthMfPH6jJn1bm/a3nte3k2RSaxKz4wYYdX6DKcLWQ==
X-Received: by 2002:a17:902:d507:b0:149:e668:e340 with SMTP id b7-20020a170902d50700b00149e668e340mr2314029plg.66.1641420711267;
        Wed, 05 Jan 2022 14:11:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ot7sm4268637pjb.12.2022.01.05.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:11:51 -0800 (PST)
Date:   Wed, 5 Jan 2022 14:11:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <202201051410.8F65E4E0@keescook>
References: <20220105173507.2420910-1-keescook@chromium.org>
 <878rvujc4t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rvujc4t.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:00:50PM +0200, Jani Nikula wrote:
> On Wed, 05 Jan 2022, Kees Cook <keescook@chromium.org> wrote:
> > The link_status array was not large enough to read the Adjust Request
> > Post Cursor2 register, so remove the common helper function to avoid
> > an OOB read, found with a -Warray-bounds build:
> >
> > drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
> > drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
> >    59 |         return link_status[r - DP_LANE0_1_STATUS];
> >       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
> >   147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> >       |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Replace the only user of the helper with an open-coded fetch and decode,
> > similar to drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.
> >
> > Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This is the alternative to:
> > https://lore.kernel.org/lkml/20211203084354.3105253-1-keescook@chromium.org/
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 10 ----------
> >  drivers/gpu/drm/tegra/dp.c      | 11 ++++++++++-
> >  include/drm/drm_dp_helper.h     |  2 --
> >  3 files changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > index 23f9073bc473..c9528aa62c9c 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -144,16 +144,6 @@ u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
> >  }
> >  EXPORT_SYMBOL(drm_dp_get_adjust_tx_ffe_preset);
> >  
> > -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> > -					 unsigned int lane)
> > -{
> > -	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
> > -	u8 value = dp_link_status(link_status, offset);
> > -
> > -	return (value >> (lane << 1)) & 0x3;
> > -}
> > -EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
> > -
> >  static int __8b10b_clock_recovery_delay_us(const struct drm_dp_aux *aux, u8 rd_interval)
> >  {
> >  	if (rd_interval > 4)
> > diff --git a/drivers/gpu/drm/tegra/dp.c b/drivers/gpu/drm/tegra/dp.c
> > index 70dfb7d1dec5..f5535eb04c6b 100644
> > --- a/drivers/gpu/drm/tegra/dp.c
> > +++ b/drivers/gpu/drm/tegra/dp.c
> > @@ -549,6 +549,15 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
> >  {
> >  	struct drm_dp_link_train_set *adjust = &link->train.adjust;
> >  	unsigned int i;
> > +	u8 post_cursor;
> > +	int err;
> > +
> > +	err = drm_dp_dpcd_read(link->aux, DP_ADJUST_REQUEST_POST_CURSOR2,
> > +			       &post_cursor, sizeof(post_cursor));
> 
> There's a drm_dp_dpcd_readb() for the common 1-byte reads. Other than
> that,
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> 
> Though obviously that's not enough to actually merge to tegra.

As in, "a review by Jani isn't sufficient to land via the tegra tree"?

What should next steps be?

-Kees

> 
> > +	if (err < 0) {
> > +		DRM_ERROR("failed to read post_cursor2: %d\n", err);
> > +		post_cursor = 0;
> > +	}
> >  
> >  	for (i = 0; i < link->lanes; i++) {
> >  		adjust->voltage_swing[i] =
> > @@ -560,7 +569,7 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
> >  				DP_TRAIN_PRE_EMPHASIS_SHIFT;
> >  
> >  		adjust->post_cursor[i] =
> > -			drm_dp_get_adjust_request_post_cursor(status, i);
> > +			(post_cursor >> (i << 1)) & 0x3;
> >  	}
> >  }
> >  
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index 472dac376284..fdf3cf6ccc02 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -1528,8 +1528,6 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
> >  					  int lane);
> >  u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
> >  				   int lane);
> > -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> > -					 unsigned int lane);
> >  
> >  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
> >  #define DP_RECEIVER_CAP_SIZE		0xf
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Kees Cook
