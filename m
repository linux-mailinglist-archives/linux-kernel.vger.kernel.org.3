Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E258EFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiHJP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiHJP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:59:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0EF57200
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:59:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso1230370wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=5J/+lzEP3tSd3WPCvbjczX9ZLB61OBoGBALKUmRBw5s=;
        b=ObbzQmaiZonvgZXM6vJSd38JNEFOl1Gu5gzz2JK4cCiW02dTTl9lARpq5+KEgkwx5t
         cZJhbJXz1x3QyfajbDqIBIK4mbujsEdG9ys1inAOUjcSj9Wthi41cGYBetIvCKmHUnmo
         XO09Qv92NvVrVC0xszkX26ZJeWoeHIRqb67s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=5J/+lzEP3tSd3WPCvbjczX9ZLB61OBoGBALKUmRBw5s=;
        b=ctnZiEXhi3oGlJ/Eqczhl4TasfetWBEES+mvQamIHtwFYCkYe0UZU/rNxfabFTHSWK
         kE9aXVx+98JLOCR1Jgo2guN0fd1W+msjcEZw7UEdJhozGKmzFitjMyzN5fP7Bw/Sbu57
         II/HOqpONT5poGyqGP4+O/g77Oh71U19V/K0JHvO2zSBsOCI1AxQk3TWFFcxFt0KRv8C
         zp20NCQn+mxElOnQxwnnVP3T+GVo2VQAOF/s0Vcy6MkxmTJDY3wpkoR73QqLcZnAuWR2
         l/oXhyNmEoFIOEDlDUH3RFUAeEi8do8+VEz67UcocgKrQCqw9F+clDwER1B3pyVKOpxd
         NboQ==
X-Gm-Message-State: ACgBeo1AhT3wp4tkr/lqnWRKNTaa04voohaNQDKiN2FDGcokC+uMtABR
        zQ+njS2npNemTCVv/WfPbW3heTmkZ6Rqp8KG
X-Google-Smtp-Source: AA6agR7HY0wQU3y5yY6Kddj9MwzCY8wYP5mk/EVfoL8kIoQTc3N+5GNg+l+pO2qUm7O0zYD6sEsViQ==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id m4-20020a05600c4f4400b003a56de38375mr2992173wmq.198.1660147146409;
        Wed, 10 Aug 2022 08:59:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b003a32251c3f9sm3033032wmq.5.2022.08.10.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:59:05 -0700 (PDT)
Date:   Wed, 10 Aug 2022 17:59:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
Message-ID: <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
References: <cover.1657294931.git.geert@linux-m68k.org>
 <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 08:20:46PM +0200, Geert Uytterhoeven wrote:
> Add a helper to retrieve the actual number of bits per pixel for a
> plane, taking into account the number of characters and pixels per
> block for tiled formats.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v3:
>   - Add Reviewed-by,
> 
> v2:
>   - Move up.
> ---
>  drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
>  include/drm/drm_fourcc.h     |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 07741b678798b0f1..cf48ea0b2cb70ba8 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
>  }
>  EXPORT_SYMBOL(drm_format_info_block_height);
>  
> +/**
> + * drm_format_info_bpp - number of bits per pixel
> + * @info: pixel format info
> + * @plane: plane index
> + *
> + * Returns:
> + * The actual number of bits per pixel, depending on the plane index.
> + */
> +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
> +{
> +	if (!info || plane < 0 || plane >= info->num_planes)
> +		return 0;
> +
> +	return info->char_per_block[plane] * 8 /
> +	       (drm_format_info_block_width(info, plane) *
> +		drm_format_info_block_height(info, plane));

Do we really needs this for blocky formats where this is potentially
ill-defined? I think if there's no need then this should also return 0
when block_width/height != 1, it doesn't make much sense to compute bpp
when it's not really bits per _pixel_.

Minimally this needs to check whether the division actually makes sense or
whether there's a reminder, and if there's  reminder, then fail. But that
feels like a bad hack and I think we should avoid it if it's not
absolutely necessary.

Otherwise lgtm.
-Daniel

> +}
> +EXPORT_SYMBOL(drm_format_info_bpp);
> +
>  /**
>   * drm_format_info_min_pitch - computes the minimum required pitch in bytes
>   * @info: pixel format info
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index 22aa64d07c7905e2..3800a7ad7f0cda7a 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -313,6 +313,7 @@ unsigned int drm_format_info_block_width(const struct drm_format_info *info,
>  					 int plane);
>  unsigned int drm_format_info_block_height(const struct drm_format_info *info,
>  					  int plane);
> +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane);
>  uint64_t drm_format_info_min_pitch(const struct drm_format_info *info,
>  				   int plane, unsigned int buffer_width);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
