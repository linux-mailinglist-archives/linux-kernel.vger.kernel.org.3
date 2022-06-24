Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2E55A306
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiFXUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiFXUtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:49:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461351300
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:49:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lw20so7044395ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Hm+RwF6zdRTAP4jPbUkFegWvOdyeCN+KoGv/KdQyOQ=;
        b=IbqRHr8pQpzMu6gfF9LxN6XfTvx/Z2IK+Zbycio945d5nIgTnwXNVNK+j4lk/X495z
         yuXBe4k0pIlvnpwAIZ5aNZcZ7xdA4653i+Xo1XsGB8DAuSCJF2kDY1Lcy0UFc0OXRHOm
         xDJ129UaWAVhiGChIz6Qs3E9N4JwBx1Om0jvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4Hm+RwF6zdRTAP4jPbUkFegWvOdyeCN+KoGv/KdQyOQ=;
        b=XjZfGAVvc8WXkF/lJIFjvbN7glmEFBeCa8UAHJ0UwLuhuz0IE8/Rgn+2QKTUjonWmB
         FGO7wzsipYazc/NJCq67KYX4ZKEI3SZGDSExVVBsSe7Mc3lO3PUih29XoIl7d1eK4YbX
         zytRGCvO8Rzxfkw7KbJQPgcmEENsbfyyQHo9ONpO97Z0fjV3Jv3DB0gF1wyr32tu/IJR
         QJdcO25HBnsllta67KAObCJUKv45CFWwrJ4W91Qvx+mxib6E4o7+4C5PB/VVpnbm2QWk
         CtRyP7ifq+k8Oum7TqKGv6WXUD/VJD8IHO4//PfzOeWwvQOJDM63uAts+RjLvk+7xsPY
         4LLQ==
X-Gm-Message-State: AJIora94bwWJD/l2TS17WcvfYs0J9E6XX+5Gdjcten+25yCfdKlXKzCk
        s1QHp0K+N8eF43JlZ4mH5ycT+w==
X-Google-Smtp-Source: AGRyM1tUC838ztsYx8GI1aLILWxJgp48uXukKVyAcZfd/hrTaM4Z8OcVOEnxZ/ckpyMWLdikl4heVA==
X-Received: by 2002:a17:906:9b92:b0:722:f705:759d with SMTP id dd18-20020a1709069b9200b00722f705759dmr839195ejc.745.1656103741909;
        Fri, 24 Jun 2022 13:49:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d682000000b0042dddaa8af3sm2726082edr.37.2022.06.24.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:49:01 -0700 (PDT)
Date:   Fri, 24 Jun 2022 22:48:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm: Add DRM_GEM_FOPS
Message-ID: <YrYjO1oSUqL8f4xV@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chris Healy <cphealy@gmail.com>, Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20220609174213.2265938-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609174213.2265938-1-robdclark@gmail.com>
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

On Thu, Jun 09, 2022 at 10:42:11AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The DEFINE_DRM_GEM_FOPS() helper is a bit limiting if a driver wants to
> provide additional file ops, like show_fdinfo().
> 
> v2: Split out DRM_GEM_FOPS instead of making DEFINE_DRM_GEM_FOPS
>     varardic
> v3: nits
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

We're at three drivers, maybe it'd be better if this is more standardized?
I feel like we're opening a bit a can of worms here where everyone just
has some good odl fashioned fun. It's at least much better documented than
the old property proliferation :-)
-Daniel

> ---
>  include/drm/drm_gem.h | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 9d7c61a122dc..87cffc9efa85 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -314,6 +314,23 @@ struct drm_gem_object {
>  	const struct drm_gem_object_funcs *funcs;
>  };
>  
> +/**
> + * DRM_GEM_FOPS - Default drm GEM file operations
> + *
> + * This macro provides a shorthand for setting the GEM file ops in the
> + * &file_operations structure.  If all you need are the default ops, use
> + * DEFINE_DRM_GEM_FOPS instead.
> + */
> +#define DRM_GEM_FOPS \
> +	.open		= drm_open,\
> +	.release	= drm_release,\
> +	.unlocked_ioctl	= drm_ioctl,\
> +	.compat_ioctl	= drm_compat_ioctl,\
> +	.poll		= drm_poll,\
> +	.read		= drm_read,\
> +	.llseek		= noop_llseek,\
> +	.mmap		= drm_gem_mmap
> +
>  /**
>   * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM drivers
>   * @name: name for the generated structure
> @@ -330,14 +347,7 @@ struct drm_gem_object {
>  #define DEFINE_DRM_GEM_FOPS(name) \
>  	static const struct file_operations name = {\
>  		.owner		= THIS_MODULE,\
> -		.open		= drm_open,\
> -		.release	= drm_release,\
> -		.unlocked_ioctl	= drm_ioctl,\
> -		.compat_ioctl	= drm_compat_ioctl,\
> -		.poll		= drm_poll,\
> -		.read		= drm_read,\
> -		.llseek		= noop_llseek,\
> -		.mmap		= drm_gem_mmap,\
> +		DRM_GEM_FOPS,\
>  	}
>  
>  void drm_gem_object_release(struct drm_gem_object *obj);
> -- 
> 2.36.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
