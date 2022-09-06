Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1685AF593
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIFUMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiIFUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:12:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F9BD1ED
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:07:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bp20so16598474wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=QO0vmextOE7byXtCUGZRN9XcSr/2rfXe412VbGvJjJM=;
        b=J6lgYCOZEm6bBbC+vgNLT5h6sXbIl/zhC5KHbAbAaIbpQat4Uc94xEaKNP3M1Zl35P
         NU/ABrVCeRFXCA0/M5hfo6R7fg/3Y3SxpS1/mT3Bm2HQGjV8JmSbUeu7tgwk3/hNH38Q
         8jku8SAoH9mN8ulk+jY8cyMxOUiGywfmNE3Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QO0vmextOE7byXtCUGZRN9XcSr/2rfXe412VbGvJjJM=;
        b=zqIA42GSonPe8bEPE4IN6Sp7G9la8SujUM0Euqi9B5fQDo3NQXSHBnV1eF60UByI1w
         4uUJC9VxY7K1BVrj+kctTo27fJeWMnxxb8pHCzaFM706NpulDvK445WU6YoSyElLkeIk
         rrsomUEfm7vBojyi3Iwj12xupfedb8AU5YFl8FQow4DuSOEpzc5/8PzOozJOVl0Ml+zS
         +z0PbJlMKQv7PHo3730Jr3Rw4EV7+F/+N0eNzVPQxa/AY+8rN+w36xHUIzl9vVDeZz0h
         W/5nqHw1unYw0GJhhh9RkHVKqu2r7fOb5hCWDA+BLXvotbcVk3Y2QsMjer96HwwED/pf
         XBWg==
X-Gm-Message-State: ACgBeo2jPgo3rOMmyURGQSm289RrbTJYPgwPLH3iBXeGnuDepjtISINl
        f/u4VGcsIZoUm2MDvTKE6hFQEAH7JpDWvQ==
X-Google-Smtp-Source: AA6agR6yg4CGNrCY5D2cKWurXhI1K66jKY3xXhCCZCA5RPRuvlIYkNbuxmMHwOFlGsbTsMBq12JbHg==
X-Received: by 2002:adf:ebc3:0:b0:228:61a0:e8b with SMTP id v3-20020adfebc3000000b0022861a00e8bmr74297wrn.676.1662494817423;
        Tue, 06 Sep 2022 13:06:57 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b003a4c6e67f01sm26112639wmq.6.2022.09.06.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:06:56 -0700 (PDT)
Date:   Tue, 6 Sep 2022 22:06:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/12] drm/udl: Restore display mode on resume
Message-ID: <YxeoX5dikxsUjzJS@phenom.ffwll.local>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220816153655.27526-1-tiwai@suse.de>
 <20220816153655.27526-2-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816153655.27526-2-tiwai@suse.de>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:36:44PM +0200, Takashi Iwai wrote:
> From: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Restore the display mode whne resuming from suspend. Currently, the
> display remains dark.
> 
> On resume, the CRTC's mode does not change, but the 'active' flag
> changes to 'true'. Taking this into account when considering a mode
> switch restores the display mode.
> 
> The bug is reproducable by using Gnome with udl and observing the
> adapter's suspend/resume behavior.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

This patch isn't great and incomplete, see

https://lore.kernel.org/dri-devel/YxegiQFAv+OWjjqE@phenom.ffwll.local/

You need cc: stable and fixes: 997d33c35618 and actually just remove the
entire check :-)
-Daniel

> ---
>  drivers/gpu/drm/udl/udl_modeset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 169110d8fc2e..df987644fb5d 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2009 Bernie Thompson <bernie@plugable.com>
>   */
>  
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_damage_helper.h>
> @@ -382,7 +383,7 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  
>  	udl_handle_damage(fb, &shadow_plane_state->data[0], 0, 0, fb->width, fb->height);
>  
> -	if (!crtc_state->mode_changed)
> +	if (!drm_atomic_crtc_needs_modeset(crtc_state))
>  		return;
>  
>  	/* enable display */
> -- 
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
